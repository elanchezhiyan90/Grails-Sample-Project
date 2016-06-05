package com.vayana.ib.retail.web.service

import org.springframework.ui.ModelMap

import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.ContextCodeType
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.InterfaceException;
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants
import com.vayana.bm.core.api.model.configuration.PasswordPolicyConfiguration;
import com.vayana.bm.core.api.model.enums.YesNoEnum;
import com.vayana.bm.core.impl.service.utils.TenantAppConfig
import com.vayana.ib.bm.core.api.beans.user.CustomerInquiryRequest
import com.vayana.ib.bm.core.api.beans.user.CustomerInquiryResponse
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileRequest
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileResponse
import com.vayana.ib.bm.core.api.beans.user.UserSelfRegistrationRequest
import com.vayana.ib.bm.core.api.beans.user.UserSelfRegistrationResponse
import com.vayana.ib.bm.core.api.model.common.Segment
import com.vayana.ib.bm.core.api.model.common.TenantBranch
import com.vayana.ib.bm.core.api.model.user.IBUserProfile
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class UserRegistrationService extends GenericService {
	
	BmClient bmClient;
	CommonService commonService;
	
	def simpleCaptchaService
	
	TenantAppConfig tenantAppConfig;
	
	def userverification(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{  
		
	}

	def userRegistration(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		
	}
	
	def showPasswordPolicy(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		PasswordPolicyConfiguration ppc = commonService.fetchPasswordPolicyConfig(requestHeader)
		model<<[ppc:ppc]
	}
	
	def userverificationinfo(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		
		//Server Side validation
		UserVerificationInfoCommand  userVerificationInfoCmd=validateCommandObject(UserVerificationInfoCommand.class,params)
		if(userVerificationInfoCmd.hasErrors()){
			model << [errors:userVerificationInfoCmd.errors]      
			return
		}		
		
		//To validate captcha
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
				throw new BusinessException(ContextCodeType.GENERAL, errorCode);
			}else{
				log.info "***Validate the User Entered captcha****";
	 			boolean captchaValid = simpleCaptchaService.validateCaptcha(params.captcha)
				if(!captchaValid)
				{
					log.info "*Invalid Captcha *"+captchaValid;
					log.error "CAPTCHA VALIDATION ERROR ::: ";
					String errorCode="invalid.captcha.error";
					throw new BusinessException(ContextCodeType.GENERAL, errorCode);
				}else{
					log.info "*Captcha validation Success *"+captchaValid;
				}
			}
		}
		
		   
		UserSelfRegistrationRequest userSelfRegistrationRequest=getBean(UserSelfRegistrationRequest.class, requestHeader, params)
		userSelfRegistrationRequest.requestHeader=requestHeader
		
		
		userSelfRegistrationRequest.customerId=params?.customerId
		userSelfRegistrationRequest.existingCustomerLoginId = params?.existLoginId
		userSelfRegistrationRequest.existingPassword = params?.existUsrPwd
		/*userSelfRegistrationRequest.cardNumber=params?.cardNumber
		userSelfRegistrationRequest.pinNumber=params?.pinNumber
		userSelfRegistrationRequest.nameOnCard = params?.nameOnCard
		
		if(params.cardIssuedDate)
		{
			userSelfRegistrationRequest.issuedDate=DateUtils.convertStringToDate(params.cardIssuedDate, DateUtils.YYYY_MM_DD)
		}
		if(params.cardValidUpto)
		{
			userSelfRegistrationRequest.validUpto=DateUtils.convertStringToDate(params.cardValidUpto, DateUtils.YYYY_MM_DD)
		}*/
		
		UserSelfRegistrationResponse userSelfRegistrationResponse	=	null;
		try{       
			userSelfRegistrationResponse	=	bmClient.iBUserService.verifyUser(userSelfRegistrationRequest);
		}catch(ConnectException e){
			throw new BusinessException(ContextCodeType.CORE,ErrorCodeConstants.IM_CONN_ERR,e.getMessage());
		}catch(InterfaceException e){
			throw new BusinessException(ContextCodeType.GENERAL, e.getErrorCode());  
		}
		CustomerInquiryRequest customerInquiryRequest=getBean(CustomerInquiryRequest.class, requestHeader, null);
		customerInquiryRequest.cifNumber=params.customerId;
		CustomerInquiryResponse  customerInquiryResponse=bmClient.iBUserService.getCustomerProfile(customerInquiryRequest)
		userSelfRegistrationRequest.userProfile=customerInquiryResponse.getUserProfile();
		userSelfRegistrationRequest.branch=customerInquiryResponse.getBranch();
		userSelfRegistrationRequest.segment=customerInquiryResponse.getSegment();
		userSelfRegistrationRequest.customerId=customerInquiryResponse.getCifNumber();        
		//FIXME senba - CPR has to be added here

		if(userSelfRegistrationResponse.hasErrors()){    
			model << [userVerificationRequestModel:userSelfRegistrationRequest,"errors":userSelfRegistrationResponse.errors()]
		}else{
			model << [userSelfRegistrationRequestModel:userSelfRegistrationRequest,userSelfRegistrationResponseModel:userSelfRegistrationResponse,isToApplyTransPassword:tenantAppConfig.isToApplyTransPassword()] 
		}
	}
	   	
	def userlogininfo(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		
		//Server Side validation
		UserLoginInfoCommand  userLoginInfoCmd=validateCommandObject(UserLoginInfoCommand.class,params)
		if(userLoginInfoCmd.hasErrors()){
			println userLoginInfoCmd.dump()
			model << [errors:userLoginInfoCmd.errors]
			return
		}		   
		//request object taken from flow to persist the request value from previous page
		UserSelfRegistrationRequest userSelfRegistrationRequest=getBean(UserSelfRegistrationRequest.class, null, null);
						
	
		userSelfRegistrationRequest.ibUserName=params.ibUserLoginName;
		userSelfRegistrationRequest.ibUserEncryptedPassCode=params.ibUserEncryptedPassCode;
		userSelfRegistrationRequest.ibUserEncryptedTransPassCode=params.ibUserEncryptedTransPassCode;
		UserSelfRegistrationResponse userSelfRegistrationResponse=bmClient.iBUserService.verifyLoginInfo(userSelfRegistrationRequest);
		
		if(userSelfRegistrationResponse.hasErrors()){
			model << [userVerificationRequestModel:userSelfRegistrationRequest,"errors":userSelfRegistrationResponse.errors()]
		}else{
			model << [userLoginInfoRequestModel:userSelfRegistrationRequest,userSelfRegistrationResponseModel:userSelfRegistrationResponse]
		}
		
		
	}
	
	def usernamevalidator(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		IBUserProfileRequest ibUserProfileRequest=getBean(IBUserProfileRequest.class, requestHeader, params)
		if(ibUserProfileRequest.ibUserLoginName)
		{
			IBUserProfileResponse ibUserProfileResponse=bmClient.iBUserService.checkUserLoginName(ibUserProfileRequest);
			
			if(ibUserProfileResponse.hasErrors()){
				model << ["errors":ibUserProfileResponse.errors()]
			}else{
				model <<[ibUserProfileModel:ibUserProfileResponse]		
			}	
		}	
	}
	
	def loginsecureimage(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		
		IBUserProfileRequest ibUserProfileRequest=getBean(IBUserProfileRequest.class, requestHeader, null)
		 
		if(params.ibUserSecureImageId)
		{
			ibUserProfileRequest.setIbSecureImageBasketId(params.ibUserSecureImageId.toLong())
			IBUserProfileResponse ibUserProfileResponse=bmClient.iBUserService.getIBSecureImageDocumentId(ibUserProfileRequest);
			
			if(ibUserProfileResponse.hasErrors()){
				model << ["errors":ibUserProfileResponse.errors()]
			}else{
				model <<[ibSecureImagesModel:ibUserProfileResponse.secureImageBasketDetailList]
			}
		}
	}
	
	def registeruser(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{  
		
		//Server Side validation
		/*UserContactInfoCommand  userContactInfoCmd=validateCommandObject(UserContactInfoCommand.class,params)
		if(userContactInfoCmd.hasErrors()){
			model << [errors:userContactInfoCmd.errors]   
			return
		}*/
		
		UserSealInfoCommand  userSealInfoCmd=validateCommandObject(UserSealInfoCommand.class,params)
		if(userSealInfoCmd.hasErrors()){
			model << [errors:userSealInfoCmd.errors]
			return
		}
		
		//request object taken from flow to persist the request value from previous page
		UserSelfRegistrationRequest userSelfRegistrationRequest=getBean(UserSelfRegistrationRequest.class, requestHeader, params);
		userSelfRegistrationRequest.userProfile=(IBUserProfile)model?.userProfile
		userSelfRegistrationRequest.branch=(TenantBranch)model?.branch
		userSelfRegistrationRequest.segment=(Segment)model?.segment
		userSelfRegistrationRequest.ibUserName=params?.ibUserLoginName
		userSelfRegistrationRequest.ibUserSecureImageId=params?.list("ibUserSecureImgChkId")
		//userSelfRegistrationRequest.ibUserColorPalates=params?.list("ibUserSecureColorChkId")
		userSelfRegistrationRequest.ibUserEmail=params?.ibUserEmailId
		userSelfRegistrationRequest.ibUserMobileNumber=params?.ibUserMobileNumber
		userSelfRegistrationRequest.toApplyTransPassword=params?.applyTransPassword
		userSelfRegistrationRequest.isASelfUploadedImage=params.imageType=='PSZL'?YesNoEnum.Y:YesNoEnum.N
		//userSelfRegistrationRequest.selfUploadedImageName=params.selfImageName
		UserSelfRegistrationResponse userSelfRegistrationResponse=bmClient.iBUserService.registerUser(userSelfRegistrationRequest);
		
		if(userSelfRegistrationResponse.hasErrors()){
			model << [userVerificationRequestModel:userSelfRegistrationRequest,"errors":userSelfRegistrationResponse.errors()]
		}else{
			model << [userLoginInfoRequestModel:userSelfRegistrationRequest,userSelfRegistrationResponseModel:userSelfRegistrationResponse]
		}
	}	
	
	
	def userIdentificationInfo(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{		
		//Server Side validation
		UserIdentificationInfoCommand  userIdentificationInfoCmd=validateCommandObject(UserIdentificationInfoCommand.class,params)
		if(userIdentificationInfoCmd.hasErrors()){
			model << [errors:userIdentificationInfoCmd.errors]
			return
		}
		
		CustomerInquiryRequest customerInquiryRequest		=	getBean(CustomerInquiryRequest.class, requestHeader, null);
		customerInquiryRequest.cifNumber					=	params.customerId;
		/*CustomerInquiryResponse blockedUser =bmClient.iBUserService.checkUserBlockedForRegistration(customerInquiryRequest);
		
		if(blockedUser.hasErrors()){
			model << ["errors":blockedUser.errors()]
		}
		else
		{*/
			CustomerInquiryResponse  customerInquiryResponse	=	bmClient.iBUserService.getCustomerProfile(customerInquiryRequest)
			
			if(customerInquiryResponse.hasErrors()){
				model << ["errors":customerInquiryResponse.errors()]
			}
			else
			{
				UserSelfRegistrationRequest userSelfRegistrationRequest=getBean(UserSelfRegistrationRequest.class, null, params)
				userSelfRegistrationRequest.setCustomerId(customerInquiryResponse?.cifNumber);
				userSelfRegistrationRequest.setCprNumber(customerInquiryResponse?.cifNumber);
				userSelfRegistrationRequest.requestHeader=requestHeader
				UserSelfRegistrationResponse userSelfRegistrationResponse=bmClient.iBUserService.verifyUserCifCpr(userSelfRegistrationRequest);
				
				if(userSelfRegistrationResponse.hasErrors()){
					model << [userVerificationRequestModel:userSelfRegistrationRequest,"errors":userSelfRegistrationResponse.errors()]
				}else{
					model << [userSelfRegistrationRequestModel:userSelfRegistrationRequest,userSelfRegistrationResponseModel:userSelfRegistrationResponse]
				}
			}
//		}
	}
	
	
	def verifyUserSecretInfo(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		
		//Server Side validation
		UserSecretInfoCommand  userSecretInfoCmd=validateCommandObject(UserSecretInfoCommand.class,params)
		if(userSecretInfoCmd.hasErrors()){
			model << [errors:userSecretInfoCmd.errors]
			return
		}
		  
		UserSelfRegistrationRequest userSelfRegistrationRequest=getBean(UserSelfRegistrationRequest.class, null, null)
		userSelfRegistrationRequest.requestHeader=requestHeader
		UserSelfRegistrationResponse userSelfRegistrationResponse=bmClient.iBUserService.getColorPalateDetails(userSelfRegistrationRequest);
		
		if(userSelfRegistrationResponse.hasErrors()){
			model << [userVerificationRequestModel:userSelfRegistrationRequest,"errors":userSelfRegistrationResponse.errors()]
		}else{
			model << [userSelfRegistrationRequestModel:userSelfRegistrationRequest,userSelfRegistrationResponseModel:userSelfRegistrationResponse]
		}
	}
	//As per KHCB dont have to get the email and mobile from end user
	/*def verifyUserSealInfo(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		
		//Server Side validation
		UserSealInfoCommand  userSealInfoCmd=validateCommandObject(UserSealInfoCommand.class,params)
		if(userSealInfoCmd.hasErrors()){
			model << [errors:userSealInfoCmd.errors]    
			return
		} 
		
		UserSelfRegistrationRequest userSelfRegistrationRequest=getBean(UserSelfRegistrationRequest.class, requestHeader, params);
		userSelfRegistrationRequest.userProfile=(IBUserProfile)model?.userProfile
		userSelfRegistrationRequest.branch=(TenantBranch)model?.branch
		userSelfRegistrationRequest.ibUserName=params?.ibUserLoginName
		userSelfRegistrationRequest.ibUserSecureImageId=params?.list("ibUserSecureImgChkId")
		userSelfRegistrationRequest.ibUserColorPalates=params?.list("ibUserSecureColorChkId")
		userSelfRegistrationRequest.ibUserEmail=params?.ibUserEmailId
		userSelfRegistrationRequest.ibUserMobileNumber=params?.ibUserMobileNumber
		userSelfRegistrationRequest.toApplyTransPassword=params?.applyTransPassword
		userSelfRegistrationRequest.isASelfUploadedImage=params.imageType=='PSZL'?YesNoEnum.Y:YesNoEnum.N
		userSelfRegistrationRequest.selfUploadedImageName=params.selfImageName
		UserSelfRegistrationResponse userSelfRegistrationResponse=bmClient.iBUserService.registerUser(userSelfRegistrationRequest);
		
		if(userSelfRegistrationResponse.hasErrors()){
			model << [userVerificationRequestModel:userSelfRegistrationRequest,"errors":userSelfRegistrationResponse.errors()]
		}else{
			model << [userLoginInfoRequestModel:userSelfRegistrationRequest,userSelfRegistrationResponseModel:userSelfRegistrationResponse]
		}
	}*/
	
	
}





//	Command Objects

class UserVerificationInfoCommand implements Serializable{
	String customerId;
//	String cardNumber;
//	String pinNumber;
//	String cardIssuedDate;
//	String cardValidUpto;
//	String nameOnCard;
	String captcha;
	String existLoginId;
	String existUsrPwd;
	
	static constraints={

//		cardNumber(blank:false);
//		pinNumber(blank:false);
		//cardIssuedDate(blank:false);
		//cardValidUpto(blank:false);
//		nameOnCard(blank:false,shared : 'nameOnCardConstraint')
		captcha(blank:false);
		
		existLoginId(blank:false);
		existUsrPwd(blank:false);
		customerId validator :{val,obj->
		if(val==''){
			obj.errors.rejectValue('customerId','userVerificationInfoCommand.customerId.blank')
		}
	};

//		customerId validator :{val,obj->
//			if(val==''){
//				obj.errors.rejectValue('customerId','userVerificationInfoCommand.customerId.blank')
//			}
//	};





	}
		
		
}
class UserLoginInfoCommand implements Serializable{
	String ibUserLoginName;
	String ibUserEncryptedPassCode;
	String ibUserEncryptedConfPassCode;
	String ibUserEncryptedTransPassCode;
	String ibUserEncryptedTransConfPassCode;
	String toApplyTransPassword;
//	String ibUserSecureImageId1; //we have to put
//	String ibUserSecureImgChkId;
//	String ibUserSecureMessage;
	
	static constraints={
		ibUserLoginName(blank:false)
		ibUserEncryptedPassCode(blank:false);
		ibUserEncryptedConfPassCode(blank:false,validator:{val,obj ->
			if(!val?.toString().equals(obj?.ibUserEncryptedPassCode?.value.toString())){
				obj.errors.rejectValue('ibUserEncryptedPassCode','userLoginInfoCommand.password.notsame')
			}
		});
	ibUserEncryptedTransConfPassCode(blank:false,validator:{val,obj ->
		if("Y".equals(obj?.toApplyTransPassword?.value.toString())){
			if(!val?.toString().equals(obj?.ibUserEncryptedTransPassCode?.value.toString())){
				obj.errors.rejectValue('ibUserEncryptedPassCode','userLoginInfoCommand.transpassword.notsame')
			}
		}
	});
//		ibUserSecureImageId1(blank:false);
//		ibUserSecureImgChkId(blank:false);
//		ibUserSecureMessage(blank:false);
	}
		
		
}
class UserSecretInfoCommand implements Serializable{
	String ibUserSecretQuestionId;
	String ibUserSecretAnswer;
	private static SECRETANS_LENGTH = 20
	static constraints={
		ibUserSecretQuestionId(blank:false);
		ibUserSecretAnswer(blank:false);
		
		ibUserSecretAnswer validator : { val,obj ->
			
			// Check if variable val is accountNumber or IBAN Number accordingly validate the same
			
			if(val.length() > SECRETANS_LENGTH)
			{
			obj.errors.rejectValue('ibUserSecretAnswer','ibUserSecretAnswer.length.error')
			}
			
			
			}
		
	}
}


class UserIdentificationInfoCommand implements Serializable{
	String customerId;
	
	static constraints ={
		customerId(blank:false);
	}
	
	
	
}

class UserSealInfoCommand implements Serializable{
	
	String ibUserSecureImageId1;
	String ibUserSecureImgChkId;
	String ibUserSecureMessage;
	//String ibUserSecureColorChkId;
	String imageType;
	String selfImageName;
	
	private static int USERSECURE_MESSAGE_LENGTH = 50
	static constraints={
		ibUserSecureImageId1(blank:false,validator:{val,obj ->
			if(obj?.imageType?.value.toString().equals("PRE") && val?.toString()==''){
				obj.errors.rejectValue('ibUserSecureImageId1','userSealInfoCommand.ibUserSecureImageId1.select')
			}
		});
		imageType(blank:false,validator:{val,obj ->
			if(val?.toString().equals("PRE") && obj?.ibUserSecureImgChkId==null){
				obj.errors.rejectValue('ibUserSecureImageId1','userSealInfoCommand.ibUserSecureImgChkId.predef')
			}else if(val?.toString().equals("PSZL") && obj?.selfImageName?.value.toString()== '' ){
				obj.errors.rejectValue('ibUserSecureImageId1','userSealInfoCommand.ibUserSecureImgChkId.userdef')
			}
		});
		ibUserSecureMessage(blank:false);
	//	ibUserSecureColorChkId(blank:false);
	
		ibUserSecureMessage validator : { val,obj ->
			
			if(val.length() > USERSECURE_MESSAGE_LENGTH)
			{
			obj.errors.rejectValue('ibUserSecureMessage','ibUserSecureMessage.invalidlength.error')
			}
			
			}
		
		}	
		
}
class UserContactInfoCommand implements Serializable{
	
	String ibUserMobileNumber;
	String ibUserEmailId;
	
	static constraints={
		ibUserEmailId(blank:false,email:true);
		ibUserMobileNumber(blank:false);
		
	}
}