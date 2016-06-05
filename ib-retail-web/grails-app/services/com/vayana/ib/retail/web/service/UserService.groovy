package com.vayana.ib.retail.web.service

import java.util.Map;

import grails.util.GrailsUtil

import org.codehaus.groovy.grails.commons.GrailsApplication
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.ui.ModelMap

import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.ContextCodeType
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.beans.user.LoginRequest
import com.vayana.bm.core.api.beans.user.LoginResponse
import com.vayana.bm.core.api.beans.user.UserLoginProfileRequest
import com.vayana.bm.core.api.beans.user.UserLoginProfileResponse
import com.vayana.bm.core.api.beans.user.UserSecureImageRequest
import com.vayana.bm.core.api.beans.user.UserSecureImageResponse
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.InterfaceException;
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants
import com.vayana.bm.core.api.model.configuration.PasswordPolicyConfiguration
import com.vayana.bm.core.api.model.security.ColorPaleteBasketDetail
import com.vayana.bm.core.api.model.user.UserColorPalete
import com.vayana.bm.core.api.model.user.UserLoginProfile
import com.vayana.bm.core.api.model.user.UserSecretQuestion
import com.vayana.bm.core.impl.service.user.util.UserServiceUtil
import com.vayana.bm.core.impl.service.utils.TenantAppConfig
import com.vayana.ib.bm.core.api.beans.user.AtmPinVerificationRequest
import com.vayana.ib.bm.core.api.beans.user.AtmPinVerificationResponse
import com.vayana.ib.bm.core.api.beans.user.CustomerInquiryRequest
import com.vayana.ib.bm.core.api.beans.user.CustomerInquiryResponse
import com.vayana.ib.bm.core.api.beans.user.ForgetUserNameRequest
import com.vayana.ib.bm.core.api.beans.user.ForgetUserNameResponse
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileRequest
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileResponse
import com.vayana.ib.bm.core.api.beans.user.UserSelfRegistrationRequest
import com.vayana.ib.bm.core.api.beans.user.UserSelfRegistrationResponse
import com.vayana.ib.bm.core.impl.service.util.IBCommonUtil
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class UserService  extends GenericService {
	GrailsApplication grailsApplication
	BmClient bmClient
	CommonService commonService;
	
	@Autowired
	IBCommonUtil iBCommonUtil;
	
	def simpleCaptchaService
	
	@Autowired
	TenantAppConfig tenantAppConfig;
	
	
	@Autowired
	UserServiceUtil userServiceUtil;
	
	def index(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		if (GrailsUtil.isDevelopmentEnv()){
			String devUserName = "";
			devUserName = params.groupShortDescription + "." + params.tenantShortDescription + ".dev.username";
			devUserName = grailsApplication.getFlatConfig().get(devUserName.toLowerCase())
			model << [username:devUserName]
		}
		//Set the tenant Application Id
		if(!params.tenantApplicationId)
		{
			params.tenantApplicationId = requestHeader?.invoker?.tenantApplicationId;
		}
	}
	
	def preloginIntermediate(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception {
		UserLoginProfileRequest ulpRequest = getBean(UserLoginProfileRequest.class, requestHeader, params);
		CommonRequest commonRequest = getBean(CommonRequest.class, requestHeader, params);
		ulpRequest.loginId = params.login;
		UserLoginProfileResponse ulpResponse = bmClient.userService.getUserLoginProfile(ulpRequest);
		commonRequest.setAttribute("userLoginProfileId",ulpResponse.getUserLoginProfile().getId())
		CommonResponse commonResponse =   bmClient.userService.getUserSecretQuestion(commonRequest);
		String iPFilterValidation = tenantAppConfig.getIPFilterValidationFlag();
		List<UserSecretQuestion> usrSecretQuestions = (List<UserSecretQuestion>)commonResponse.getCommonEntities();
		
		if(iPFilterValidation.equalsIgnoreCase("Y") && !ulpResponse.getUserLoginProfile().getLoginStatus().getCode().equalsIgnoreCase("FAC"))
		{
			println "IP FILTER VALIDATION IS ENABLED";
			invokeIPFilterValidation(params,model,ulpResponse.getUserLoginProfile(),requestHeader);
			 
			model << [secretQuestions:usrSecretQuestions]
		}
		else
		{
			println "IP FILTER VALIDATION IS DISABLED";
			prelogin(params,requestHeader,model);
			model << [allowedIp:true]
		}
		
		
	}
	
	def invokeIPFilterValidation(Map params,ModelMap model,UserLoginProfile ulp,GenericRequestHeader requestHeader)
	{
		CommonRequest commonRequest = getBean(CommonRequest.class, requestHeader, params);
		commonRequest.setAttribute("ulp",ulp.getId());
		CommonResponse resp  = bmClient.iBCommonService.validateBlockedIPAddress(commonRequest);
		
			Map<String, Object> mpVal = resp.getAdditionalInfoMap();
			if(mpVal!=null && mpVal.size()>0)
			{
				Boolean allowed_Ip = mpVal.get("ALLOWED_IP");
				if(!allowed_Ip)
				{
					prelogin(params,requestHeader,model);
					model << [allowedIp:false]
				}
				else
				{
					prelogin(params,requestHeader,model);
					model << [allowedIp:true]
				}
			}
			else
			{
				prelogin(params,requestHeader,model);
				model << [allowedIp:false]
			}
	}
	
	
	def preLoginIntermediateSubmit(Map params,GenericRequestHeader requestHeader,ModelMap model) throws Exception
	{
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, params);
		def requestParams	=	[:];
		requestParams = ["secretQuestion":params?.list("ibUserSecretQuestionId"),
						 "secretAnswer":params?.list("ibUserSecretAnswer"),
						 "secureImage":params?.list("secureImg"),
						 "secureText":params?.list("ibUserSecureMessage"),
						 "secureColor":params?.list("userSecureColor")
						 ]
		commonRequest.setRequestParams(requestParams);
		commonRequest.setCommonEntityId(Long.parseLong(params?.userLogin));
		CommonResponse commonResponse=bmClient.iBCommonService.validateSecuritySetting(commonRequest);
		if(commonResponse?.hasErrors())
		{
			model<<[errors:commonResponse.errors()]
		}
		else{
			model << [preLoginSubmit:true];
			prelogin(params,requestHeader,model);
		}
	}
	
	def prelogin(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception {
		PreLoginCommand preLoginCmd = validateCommandObject(PreLoginCommand.class, params)
		if (preLoginCmd.hasErrors()){
			model << [errors:preLoginCmd]
		}else{
		
			UserLoginProfileRequest ulpRequest = getBean(UserLoginProfileRequest.class, requestHeader, params);
			ulpRequest.loginId = preLoginCmd.login;
			// Set the Captcha Count and Attempts Left. This is needed when the user logs into the application. Values are not read from session here
			
			UserLoginProfileResponse ulpResponse = bmClient.userService.getUserLoginProfile(ulpRequest);
			Integer captchaCount = tenantAppConfig.getCaptchaDisplayCount();
			params.captchaCount = captchaCount;
			
			// Set the Account Locked Parameter and check if the user is already locked
			CommonRequest commonRequest1=getBean(CommonRequest.class, null, null);
			commonRequest1.setAttribute("tenantApplicationId", 50000L);
			CommonResponse commonResponse = iBCommonUtil.getPasswordPolicyConfiguration(commonRequest1);
			PasswordPolicyConfiguration pwdConf  = (PasswordPolicyConfiguration)commonResponse.getCommonEntity();
			Integer userAcntLockedCount =  pwdConf.getLockAferNWrongPasscode();
			
			Integer pwdFailedCount = ulpResponse.getUserLoginProfile().getPasscodeFailedCount() !=null ? ulpResponse.getUserLoginProfile().getPasscodeFailedCount() : new Integer(0);
			Integer attemptsLeft = userAcntLockedCount - pwdFailedCount;
			params.attemptsLeft = attemptsLeft;
			
			if (GrailsUtil.isDevelopmentEnv()){
				String devPassword = "";
				devPassword = params.groupShortDescription + "." + params.tenantShortDescription + ".dev.password";
				devPassword = grailsApplication.getFlatConfig().get(devPassword.toLowerCase())
				model  << [password:devPassword,devEnvFlag:'true']
			}
			
			
			UserSecureImageResponse secureImagesModel = null;
			UserColorPalete userSelectedColor = null;
			if(!ulpResponse.getUserLoginProfile().getLoginStatus().getCode().equals("FAC")){
			
			// Set the User Secure Image and Text
			
			if (ulpResponse.getUserLoginProfile().getId()){
				UserSecureImageRequest secureImageRequest  = getBean(UserSecureImageRequest.class, null, null);
				secureImageRequest.userLoginProfileId = ulpResponse.getUserLoginProfile().getId();
			    secureImagesModel = bmClient.userService.getSecureImageforUser(secureImageRequest);
				List<String> userSecureImages = new ArrayList<String>();
				secureImagesModel.getUserSecureImages().each {
					userSecureImages.add(it.toString())
				}
				session.userSecureImages = userSecureImages;
			}
			
			// Set the Secure Color
				if(grailsApplication.config.secure.color.required){
					List<ColorPaleteBasketDetail> colorPaleteBasketDetails = null;
					
					Long tenantApplicationId = 50000;
					if(ulpResponse.getUserLoginProfile().getId() && tenantApplicationId) {
						CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
						commonRequest.setAttribute("userLoginprofileId",ulpResponse.getUserLoginProfile().getId());
						commonRequest.setAttribute("tenantApplicationId",tenantApplicationId);
						CommonResponse commResModel=bmClient.iBUserService.getSecureColorForUser(commonRequest);
						colorPaleteBasketDetails = (List<ColorPaleteBasketDetail>)commResModel.getAttribute("basketColors");
						userSelectedColor= (UserColorPalete)commResModel.getAttribute("userSelectedColor");
					}
				}
			}
			
			model << [userLoginProfileModel:ulpResponse,secureImagesModel:secureImagesModel,userSelectedColor:userSelectedColor]
		}
	}
	/**
	 * @author elanchezhiyan
	 */
	def validateLoginCaptcha(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		log.info "**** Welcome to validateLoginCaptcha method***";
		log.info "End User Entered Captcha Text"+params?.captcha;
		if(params.captcha)   
		{
			log.info "******Validation Begins******";
			char[] capchaArray = params?.captcha?.toCharArray();
			boolean caseSensitive = false;
			capchaArray.each {val->
				if(val.isLowerCase()){
					caseSensitive = true;
				}
			}
			if(caseSensitive){
				log.info "******Captcha is Case Sensitive******";
				String errorCode="invalid.captcha.error";
				session.setAttribute("errorCode",errorCode)
				throw new BusinessException(ContextCodeType.GENERAL, errorCode);
			}else{
				log.info "***Validate the User Entered captcha****";
	 			boolean captchaValid = simpleCaptchaService.validateCaptcha(params.captcha)
				if(!captchaValid)
				{
					log.info "*Invalid Captcha *"+captchaValid;
					log.error "CAPTCHA VALIDATION ERROR ::: ";
					String errorCode="invalid.captcha.error";
					session.setAttribute("errorCode",errorCode)   
					throw new BusinessException(ContextCodeType.GENERAL, errorCode);
				}else{
					log.info "*Captcha validation Success *"+captchaValid;
				}
			}
		}
	}
	def login(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		LoginResponse loginResponse = new LoginResponse();
		LoginCommand loginCmd = validateCommandObject(LoginCommand.class, params)
		if (loginCmd.hasErrors()){
			model << [errors:loginCmd]
		}else{
			String[] userSelectedImagesArray =  loginCmd.getSecureImg().split(",");
			List<String> userSelectedImages= null;
			
			if (userSelectedImagesArray.length == 0){
				loginResponse.setError(ErrorCodeConstants.AUTHENTICATION_EXCEPTION);
				model << [errors:loginResponse.errors()]
				return;
			}else{
				userSelectedImages = Arrays.asList(userSelectedImagesArray);
			}
			
			List<String> userSelectedImagesFromDB = getSession().userSecureImages;
			getSession().removeAttribute("userSecureImages");
			
			if (secureImagesMatched(userSelectedImages ,userSelectedImagesFromDB )){
				LoginRequest loginRequest = getBean(LoginRequest.class, requestHeader, params);
				loginRequest.userName = loginCmd.login;
				loginRequest.password = loginCmd.pwd;
				loginResponse = bmClient.userService.login(loginRequest);
			}else{
				loginResponse.setError(ErrorCodeConstants.AUTHENTICATION_EXCEPTION);
				model << [errors:loginResponse.errors()]
				return;
			}
			model << [authModel:loginResponse]
		}
	}
	
	def signout(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
	
	}
	
	
	private Boolean secureImagesMatched(List<String> userSelectedImages, List<String> userSelectedImagesDB){
		Boolean matched = false;
		if (userSelectedImages.size()  == userSelectedImagesDB.size()){
			if (userSelectedImages.containsAll(userSelectedImagesDB)){
				matched = true;
			}else{
				matched = false;
			}
		}
		if (GrailsUtil.isDevelopmentEnv()){
			matched = true;
		}
		return matched;
	}
	

	
	def forgotPassword(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
	
	}
	
	def userverificationinfo(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		
		//Server Side validation
		UserVerificationInfoCommand  userVerificationInfoCmd=validateCommandObject(UserVerificationInfoCommand.class,params)
		if(userVerificationInfoCmd.hasErrors()){
			model << [errors:userVerificationInfoCmd]
			return
		}
		UserSelfRegistrationRequest userSelfRegistrationRequest=getBean(UserSelfRegistrationRequest.class, null, params)
		userSelfRegistrationRequest.requestHeader=requestHeader
		userSelfRegistrationRequest.ibUserName	=	params?.customerId;
		
		UserSelfRegistrationResponse userSelfRegistrationResponse=bmClient.iBUserService.verifyRegisteredUser(userSelfRegistrationRequest);
		
//		userSelfRegistrationRequest.userProfile		=	(IBUserProfile)userSelfRegistrationResponse.getUserLoginProfile().getUserProfile();	//customerInquiryResponse.getUserProfile();
			
		requestHeader.getInvoker().setUserLoginProfileId(userSelfRegistrationResponse.getUserLoginProfile().getId());
		if(userSelfRegistrationResponse.hasErrors()){
			model << [userVerificationRequestModel:userSelfRegistrationRequest,"errors":userSelfRegistrationResponse.errors()]
		}else{
			model << [userVerificationRequestModel:userSelfRegistrationRequest,userVerificationResponseModel:userSelfRegistrationResponse]
		}
	}
	
	
	def verifyloginpasscode(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception {
		//For server side validation
		ChangePasswordCommand changePasswordCmd			=	validateCommandObject(ChangePasswordCommand.class,params)
		if(changePasswordCmd.hasErrors()){
			model << [errors:changePasswordCmd]
			return
		}
		IBUserProfileRequest  ibUserProfileRequest		=	getBean(IBUserProfileRequest.class, requestHeader, params);
		ibUserProfileRequest.ibUserLoginProfileId=params?.ulpId?.toLong()  
		ibUserProfileRequest.cifNumber=params?.customerId
		
		IBUserProfileResponse ibUserProfileResponse		=	bmClient.iBUserService.forgotLoginPasswordAndUpdateLoginPassword(ibUserProfileRequest);
		if(ibUserProfileResponse.hasErrors())
		{
			model <<[userVerificationRequestModel:ibUserProfileResponse,"errors":ibUserProfileResponse.errors()]
		}else
		{
			model <<[userLoginInfoRequestModel:ibUserProfileResponse,userLoginInfoResponseModel:ibUserProfileResponse]
		}
	}
	
	def userIdentificationInfo(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		
		//Server Side validation
		UserCifInfoCommand  userCifInfoCommand=validateCommandObject(UserCifInfoCommand.class,params)
		if(userCifInfoCommand.hasErrors()){
			model << [errors:userCifInfoCommand.errors]
			return
		}
		
		CustomerInquiryRequest customerInquiryRequest		=	getBean(CustomerInquiryRequest.class, requestHeader, null);
		customerInquiryRequest.cifNumber					=	params.customerId;
		customerInquiryRequest.requestHeader				=	requestHeader;
		CustomerInquiryResponse  customerInquiryResponse	=	bmClient.iBUserService.getCustomerProfile(customerInquiryRequest)
		
		if(customerInquiryResponse.hasErrors()){
			model << ["errors":customerInquiryResponse.errors()]
			//return
		}	
	
		ForgetUserNameRequest forgetUserNameRequest =	getBean(ForgetUserNameRequest.class, null, params)
		forgetUserNameRequest.setCifNumber(customerInquiryResponse?.cifNumber);
		forgetUserNameRequest.setCustomerId(customerInquiryResponse?.cifNumber);
		forgetUserNameRequest.requestHeader=requestHeader
		ForgetUserNameResponse forgetUserNameResponse=bmClient.iBUserService.VerifyUserCifAndCpr(forgetUserNameRequest);
		
		if(forgetUserNameResponse.hasErrors()){
			model << [userVerificationRequestModel:forgetUserNameRequest,"errors":forgetUserNameResponse.errors()]
		}else{
			model << [forgetUserNameRequestModel:forgetUserNameRequest,forgetUserNameResponseModel:forgetUserNameResponse]
		}
	}
	
	def validateSecurity(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
	
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, params);     
		println params?.dump()    
		List<String> ibUserSecureMessage = null;                                
		if(params.secureText.equalsIgnoreCase("on")){             
		ibUserSecureMessage =params?.list("ibUserSecureMessage");             
		}
		def requestParams	=	[:];		
		requestParams = ["secretQuestion":params?.list("ibUserSecretQuestionId"),           
						 "secretAnswer":params?.list("ibUserSecretAnswer"),
						 "secureImage":params?.list("secureImg"),       
						 "secureText":ibUserSecureMessage,                   
						 "secureColor":params?.list("ibUserSecureColorChkId")                 
						 ]
		commonRequest.setRequestParams(requestParams);    
		commonRequest.setCommonEntityId(Long.parseLong(params?.ibUserLoginProfileId));  
		CommonResponse commonResponse=bmClient.iBCommonService.validateSecuritySetting(commonRequest);  
//		CommonResponse commonResponses =bmClient.userService.sendConfirmationEmail(commonRequest);           
		if(commonResponse?.hasErrors())
		{
			model<<[errors:commonResponse.errors()]
		}   
		else{
			model << [forgetUserNameResponseModel:commonResponse]    
		}
		
	}
	
	
	
	def authForgotPasswordURL(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		IBUserProfileRequest  ibUserProfileRequest		=	getBean(IBUserProfileRequest.class, requestHeader, params);
		ibUserProfileRequest.externalLinkParam=params?.reDirectKey
		IBUserProfileResponse ibUserProfileResponse=bmClient.iBUserService.checkExternalLinkValidity(ibUserProfileRequest);
		if(ibUserProfileResponse.hasErrors())
		{
			model <<["errors":ibUserProfileResponse.errors()]
		}else
		{
			model <<[userLoginInfoRequestModel:ibUserProfileResponse,userLoginInfoResponseModel:ibUserProfileResponse]
		}
	}
	
	def verifyActivationCode(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		
		//Server Side validation
		ActivationCommand  activationCommand=validateCommandObject(ActivationCommand.class,params)
		if(activationCommand.hasErrors()){
			model << [errors:activationCommand.errors]
			return
		}
	}
  
	
	def atmPinInfoValidation(Map params,GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		AtmVerificationInfoCommand atmVerificationInfoCommand =validateCommandObject(AtmVerificationInfoCommand.class,params)
		if(atmVerificationInfoCommand.hasErrors()){
			model << [errors:atmVerificationInfoCommand.errors]
			return
		}
		AtmPinVerificationRequest atmPinVerificationRequest = getBean(AtmPinVerificationRequest.class, requestHeader, params);
		atmPinVerificationRequest.setCardNumber(params?.cardNumber)
//		atmPinVerificationRequest.setPinNumber(params?.pinNumber)
		atmPinVerificationRequest.setPinNumber(userServiceUtil.decryptData(params?.pinNumber));
		AtmPinVerificationResponse atmPinVerificationResponse = null;
		try{
		atmPinVerificationResponse = bmClient.iBUserService.validateAtmpinInfo(atmPinVerificationRequest);
		}catch(Exception e){
			if(e instanceof InterfaceException){      
				InterfaceException ie = (InterfaceException)e;
				if("9992".equals(ie?.getErrorCode()?.trim())){
					throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.INTERNAL_ERROR);
				}else{
					throw new BusinessException(ContextCodeType.CORE,ie.getErrorCode(),ie.getErrorDescription());
				}
			}else if(e.getCause() instanceof InterfaceException){
				InterfaceException ie = (InterfaceException)e.getCause();
				if("9992".equals(ie?.getErrorCode()?.trim())){
					throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.INTERNAL_ERROR);
				}else{
					throw new BusinessException(ContextCodeType.CORE,ie.getErrorCode(),ie.getErrorDescription());
				}
			}else if(e instanceof BusinessException){
				BusinessException be = (BusinessException)e;
				throw new BusinessException(ContextCodeType.CORE,be.getErrorCode(),be.getErrorDescription());
			}else{
				throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.UNSUPPORTED_OPERATION);
			}
		}
		model << [AtmPinVerification:atmPinVerificationResponse]
		}
	
	
	
	def showPasswordPolicy(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		PasswordPolicyConfiguration ppc = commonService.fetchPasswordPolicyConfig(requestHeader)
		model<<[ppc:ppc]
	}
	
			
	def validateSecurityForFP(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		
			CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, params);
			List<String> ibUserSecureMessage = null;
			if(params.secureText.equalsIgnoreCase("on")){  
			ibUserSecureMessage =params?.list("ibUserSecureMessage");
			}
			def requestParams	=	[:];
			requestParams = ["secretQuestion":params?.list("ibUserSecretQuestionId"),
							 "secretAnswer":params?.list("ibUserSecretAnswer"),
							 "secureImage":params?.list("secureImg"),
							 "secureText":ibUserSecureMessage,
							 "secureColor":params?.list("ibUserSecureColorChkId")
							 ]
			commonRequest.setRequestParams(requestParams);
			commonRequest.setCommonEntityId(Long.parseLong(params?.ibUserLoginProfileId));
			CommonResponse commonResponse=bmClient.iBCommonService.validateSecuritySetting(commonRequest);
			if(commonResponse?.hasErrors())
			{
				model<<[errors:commonResponse.errors()]
			}
			else{
					IBUserProfileRequest  ibUserProfileRequest		=	getBean(IBUserProfileRequest.class, requestHeader, params);
					ibUserProfileRequest.ibUserLoginProfileId=Long.parseLong(params?.ibUserLoginProfileId)
					IBUserProfileResponse ibUserProfileResponse=bmClient.iBUserService.getResetPasswordLink(ibUserProfileRequest);
							if(ibUserProfileResponse.hasErrors())
							{
								model <<["errors":ibUserProfileResponse.errors()]
							}else
							{
								model <<[userLoginInfoRequestModel:ibUserProfileResponse,userLoginInfoResponseModel:ibUserProfileResponse]
							}				
						}	
			
		}
	
	  
	//	Command Objects
	
	class UserVerificationInfoCommand implements Serializable{
		
		String customerId;
		
		static constraints={
			customerId(blank:false);

		}
			
			
	}
	class UserLoginInfoCommand implements Serializable{
		String ibUserLoginName;
		String ibUserEncryptedPassCode;
		String ibUserEncryptedConfPassCode;
		String ibUserSecureImageId1;
		String ibUserSecureImgChkId;
		String ibUserSecureMessage;
		
		static constraints={
			ibUserLoginName(blank:false);
			ibUserEncryptedPassCode(blank:false);
			ibUserEncryptedConfPassCode(blank:false);
			ibUserSecureImageId1(blank:false);
			ibUserSecureImgChkId(blank:false);
			ibUserSecureMessage(blank:false);
		}
			
			
	}
	class UserSecretInfoCommand implements Serializable{
	
		String ibUserSecretQuestionId;
		String ibUserSecretAnswer;
		
		static constraints={
			ibUserSecretQuestionId(blank:false);
			ibUserSecretAnswer(blank:false);
		}
	}
	
	class ChangePasswordCommand{
		String ibNewEncryptedPassCode;
		String ibNewEncryptedConfPassCode;

		static constraints={
			ibNewEncryptedPassCode(blank:false);
			ibNewEncryptedConfPassCode(blank:false);
		}
	}
	
	
	class PreLoginCommand {
		String login;
		static constraints = {
		   login(blank: false)
		}
	}
	
	class LoginCommand {
		String login;
		String pwd;
		String secureText;
		String secureImg;
		static constraints = {
		   login(blank: false)
		   pwd(blank: false)
		   secureText(blank: false)
		   secureImg(blank: false)
		}
	}
	class UserCifInfoCommand implements Serializable{
		String customerId;
		
		static constraints ={
			customerId(blank:false);
		}
	}
	class ActivationCommand implements Serializable{
		String activeCode;
		
		static constraints ={
			activeCode(blank:false);
		}
	}
}



class AtmVerificationInfoCommand{
	
	String cardNumber,pinNumber;
	
	static constraints={
			
		
		cardNumber(blank:false,validator :{val,obj ->
			print "Length :::"+val.length();      
			if(val.length() != 16 ){
				obj.errors.rejectValue('cardNumber','atmVerificationInfoCommand.cardNumber.match.invalid')
			  }
		});   
		
		 pinNumber (blank:false);
		 /*, validator :{val,obj ->
		if(!val.length() ==4){
			obj.errors.rejectValue('pinNumber','atmVerificationInfoCommand.pinNumber.match.invalid')
		  }
		 });*/
	}
	
}