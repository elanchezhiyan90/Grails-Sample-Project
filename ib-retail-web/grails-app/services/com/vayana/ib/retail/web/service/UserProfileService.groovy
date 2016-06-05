package com.vayana.ib.retail.web.service

import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils

import com.google.common.collect.ImmutableSet
import com.vayana.bm.common.utils.CollectionUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.ContextCodeType
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.beans.user.UserLoginProfileRequest
import com.vayana.bm.core.api.beans.user.UserLoginProfileResponse
import com.vayana.bm.core.api.constants.LookupCodeConstants
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.model.configuration.PasswordPolicyConfiguration
import com.vayana.bm.core.api.model.enums.YesNoEnum
import com.vayana.bm.core.api.model.user.UserLoginProfile
import com.vayana.bm.core.impl.service.utils.TenantAppConfig
import com.vayana.ib.bm.core.api.beans.account.NameSequenceRequest
import com.vayana.ib.bm.core.api.beans.account.UpdateNickNameRequest
import com.vayana.ib.bm.core.api.beans.account.UpdateNickNameResponse
import com.vayana.ib.bm.core.api.beans.common.SMSAlertsRequest
import com.vayana.ib.bm.core.api.beans.common.SMSAlertsResponse
import com.vayana.ib.bm.core.api.beans.payment.OwnAccountRequest
import com.vayana.ib.bm.core.api.beans.payment.OwnAccountResponse
import com.vayana.ib.bm.core.api.beans.user.ChangeSecureAccessRequest
import com.vayana.ib.bm.core.api.beans.user.ChangeSecureAccessResponse
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileRequest
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileResponse
import com.vayana.ib.bm.core.api.beans.user.UserSelfRegistrationRequest
import com.vayana.ib.bm.core.api.beans.user.UserSelfRegistrationResponse
import com.vayana.ib.bm.core.api.model.account.Account
import com.vayana.ib.bm.core.api.model.common.SMSAlerts
import com.vayana.ib.bm.core.api.model.user.IBUserProfile
import com.vayana.ib.bm.core.api.model.userpreference.UserPreferenceRequest
import com.vayana.ib.bm.core.api.model.userpreference.UserPreferenceResponse
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class UserProfileService extends GenericService {
	
	BmClient bmClient;
	CommonService commonService;
	TenantAppConfig tenantAppConfig;

	def preferences(Map params,  GenericRequestHeader requestHeader, ModelMap model){
	
	}
	
	def showPasswordPolicy(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		PasswordPolicyConfiguration ppc = commonService.fetchPasswordPolicyConfig(requestHeader)
		model<<[ppc:ppc]
	}
	
	
	
	def usersettings(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		UserPreferenceRequest  userPreferenceRequest=getBean(UserPreferenceRequest.class, requestHeader, params);
		UserPreferenceResponse userPreferenceResponse=bmClient.iBUserService.getUserSettings(userPreferenceRequest);
		if(!userPreferenceResponse.hasErrors())
		{
			model<<[userPreferenceResponseModel:userPreferenceResponse]
		}else
		{
			model <<[errors:userPreferenceResponse.errors()]

		}
	}
	
	def changepassword(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		
	}
	
	def smsalertnotification(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		IBUserProfileResponse userProfileReponse = getuserprofilereponse();
		
		if(!userProfileReponse.hasErrors())
		{
			model <<[userProfileResponseModel:userProfileReponse]
		}else
		{
			model <<["errors":userProfileReponse]

		}
	}
	def displaysmsalerts(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		SMSAlertsRequest smsAlertsRequest = getBean(SMSAlertsRequest.class, requestHeader, params);         
		smsAlertsRequest.setAccountNumber(params.accountNumber);   
		smsAlertsRequest.setMobileNumber(params.primaryPhoneNumber);
		smsAlertsRequest.setCifNumber(smsAlertsRequest.requestHeader.getInvoker().getPrimaryCIF());         
		SMSAlertsResponse sMSAlertsResponse = bmClient.notificationService.getSMSAlerts(smsAlertsRequest);
		if(!sMSAlertsResponse.hasErrors())
		{
			model<<[smsAlertModel:sMSAlertsResponse]
		}else
		{
			model <<["errors":sMSAlertsResponse]
		}
	}
	
	def updatesmsalerts(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		SMSAlertsRequest sMSAlertsRequest = getBean(SMSAlertsRequest.class, requestHeader, params);       
		sMSAlertsRequest.mobileNumber = params.mobileNumber             
		sMSAlertsRequest.setCifNumber(sMSAlertsRequest.requestHeader.getInvoker().getPrimaryCIF());      
	    
		
		Integer rowIndexCount = params.int('rowIndexCount')
		
		List<String> alertID       = params.list("alertID");
		List<String> alertDesc     = params.list("alertDesc");
		List<String> accountNumber = params.list("accountNumber");
		List<String> numberOfDays  = params.list("numberOfDays");
		List<String> upperLimit    = params.list("upperLimit");
		List<String> lowerLimit    = params.list("lowerLimit");
		List<String> isRegistered  = params.list("isRegistered");
		
		SMSAlerts smsAlerts = null;
		for(int counter=0;counter<rowIndexCount;counter++ )
		{
			smsAlerts = new SMSAlerts();
			
			if(!CollectionUtils.isEmpty(alertID))
			{
				smsAlerts.setAlertID(alertID.get(counter));
			}
			
			if(!CollectionUtils.isEmpty(isRegistered))
			{
				smsAlerts.setIsRegistered(isRegistered.get(counter));
			}
			
			if(!CollectionUtils.isEmpty(alertDesc))
			{
				smsAlerts.setAlertDesc(alertDesc.get(counter));
			}
			if(!CollectionUtils.isEmpty(accountNumber))
			{
				smsAlerts.setAccountNumber(accountNumber.get(counter));
			}
			if(!CollectionUtils.isEmpty(numberOfDays))
			{
				smsAlerts.setNumberOfDays(numberOfDays.get(counter));
			}
			if(!CollectionUtils.isEmpty(upperLimit))
			{
				smsAlerts.setUpperLimit(upperLimit.get(counter));
			}
			
			if(!CollectionUtils.isEmpty(lowerLimit))
			{
					smsAlerts.setLowerLimit(lowerLimit.get(counter));				
			}
			sMSAlertsRequest.getSmsAlerts().add(smsAlerts);          
		}
				
		SMSAlertsResponse sMSAlertsResponse = bmClient.notificationService.getSMSAlertsRegistration(sMSAlertsRequest);    
		
		if(!sMSAlertsResponse.hasErrors())
		{
			setMessage(DEFAULT_UPDATED_MESSAGE, ["SMS ALERT NOTIFCATION"," Successfully"], model);
			model <<[smsAlertsRegistrationModel:sMSAlertsResponse]
		}else
		{
			model <<[errors:sMSAlertsResponse.errors()]

		}
	}
	/**
	 * @author elanchezhiyan
	 * @param params
	 * @param requestHeader
	 * @param model
	 * @return
	 */
	def loginhistory(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		CommonRequest commonRequest = getBean(CommonRequest.class,null,null);
		commonRequest.setCommonEntityId(getUserLoginProfile().getId());   
		CommonResponse commonResponse = bmClient.userService.getUserLoginHistory(commonRequest);
		if(!commonResponse.hasErrors())
		{	
			def loginHistories = commonResponse.getCommonEntities(); 
			model<<[userLoginHistoryModel:loginHistories]
		}else
		{
			model <<["errors":commonResponse]
		}
	}
	def verifyloginpasscode(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		//For server side validation       
		ChangePasswordCommand changePasswordCmd=validateCommandObject(ChangePasswordCommand.class,params)
		if(changePasswordCmd.hasErrors()){
			model << [errors:changePasswordCmd]
			return
		}
		IBUserProfileRequest  ibUserProfileRequest=getBean(IBUserProfileRequest.class, requestHeader, params);
		IBUserProfileResponse ibUserProfileResponse=bmClient.iBUserService.verifyAndUpdatePassword(ibUserProfileRequest);
		if(!ibUserProfileResponse.hasErrors())
		{
			setMessage(DEFAULT_UPDATED_MESSAGE, ["Change password"," Successfully"], model);
			model <<[ibUserProfileResponseModel:ibUserProfileResponse]
		}else
		{
			model <<[errors:ibUserProfileResponse.errors()]

		}
}
	def verifyforceloginpasscode(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		//For server side validation       
		ChangePasswordCommand changePasswordCmd=validateCommandObject(ChangePasswordCommand.class,params)
		if(changePasswordCmd.hasErrors()){
			model << [errors:changePasswordCmd]
			return
		}
		IBUserProfileRequest  ibUserProfileRequest=getBean(IBUserProfileRequest.class, requestHeader, params);
		IBUserProfileResponse ibUserProfileResponse=bmClient.iBUserService.verifyAndUpdatePassword(ibUserProfileRequest);
		if(!ibUserProfileResponse.hasErrors())
		{
			setMessage(DEFAULT_UPDATED_MESSAGE, ["Change password"," Successfully"], model);
			model <<[ibUserProfileResponseModel:ibUserProfileResponse]
		}else
		{
			model <<[errors:ibUserProfileResponse.errors()]

		}
	}

	
	def verifytransactionpasscode(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		//For server side validation
	 	TransactionPasswordCommand transactionPasswordCmd=validateCommandObject(TransactionPasswordCommand.class,params)
		if(transactionPasswordCmd.hasErrors()){
			model << [errors:transactionPasswordCmd]
			return
		}
		IBUserProfileRequest  ibUserProfileRequest=getBean(IBUserProfileRequest.class, requestHeader, params);
		IBUserProfileResponse ibUserProfileResponse=bmClient.iBUserService.verifyAndUpdateTransactionPassword(ibUserProfileRequest);
		if(!ibUserProfileResponse.hasErrors())
		{
			setMessage(DEFAULT_UPDATED_MESSAGE, ["Transaction password"," Successfully"], model)
			model <<[ibUserProfileResponseModel:ibUserProfileResponse]
		}else
		{
			model <<[errors:ibUserProfileResponse.errors()]

		}
}
	

	
	def changesecureaccess(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		ChangeSecureAccessRequest  changeSecureAccessRequest=getBean(ChangeSecureAccessRequest.class, requestHeader, params);
		changeSecureAccessRequest.setLoginProfileId(getUserLoginProfile().getId());
		ChangeSecureAccessResponse changeSecureAccessResponse=bmClient.iBUserService.getImageBasketsAndSecretText(changeSecureAccessRequest);
		if(!changeSecureAccessResponse.hasErrors())
		{
			model<<[changeSecureAccessModel:changeSecureAccessResponse]
		}else
		{
			model <<[errors:changeSecureAccessResponse.errors()]

		}
	}
	
	def secureimages(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		ChangeSecureAccessRequest  changeSecureAccessRequest=getBean(ChangeSecureAccessRequest.class, requestHeader, params);
		if(params.secureCategoryId)
		{
			changeSecureAccessRequest.setIbSecureImageBasketId(params.secureCategoryId.toLong())
		}
		changeSecureAccessRequest.setLoginProfileId(getUserLoginProfile().getId());
		ChangeSecureAccessResponse changeSecureAccessResponse=bmClient.iBUserService.getSecureImages(changeSecureAccessRequest);
		if(!changeSecureAccessResponse.hasErrors())
		{			    
			model <<[secureImagesModel:changeSecureAccessResponse]
		}else
		{
			model <<[errors:changeSecureAccessResponse.errors()]

		}
	}	
	
	def verifysecureaccess(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		//For server side validation
		ChangeSecureAccessCommand changeSecureAccessCmd=validateCommandObject(ChangeSecureAccessCommand.class,params)
		if(changeSecureAccessCmd.hasErrors()){
			model << [errors:changeSecureAccessCmd]
		}else{		
		ChangeSecureAccessRequest  changeSecureAccessRequest=getBean(ChangeSecureAccessRequest.class, requestHeader, params);
		changeSecureAccessRequest.documentIds=params.list('ibUserSecureImages');		
		changeSecureAccessRequest.setLoginProfileId(getUserLoginProfile().getId());
		changeSecureAccessRequest.ibUserColorPalate=params?.ibUserSecureColorChkId
		ChangeSecureAccessResponse changeSecureAccessResponse=bmClient.iBUserService.updateSecureAccess(changeSecureAccessRequest);
		if(!changeSecureAccessResponse.hasErrors())
		{
			setMessage(DEFAULT_UPDATED_MESSAGE, ["Change Secure Images"," Successfully"], model); 
			model <<[updateSecureAccessModel:changeSecureAccessResponse]
		}else
		{  			
			model <<[errors:changeSecureAccessCmd.errors()]
		}
		}
		
	}
	def usersettingsdetail(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		//For server side validation
		
		UserPreferenceRequest  userPreferenceRequest=getBean(UserPreferenceRequest.class, requestHeader, params);
		if(!StringUtils.hasLength(params.tenantApplicationCurrency))
		{
			userPreferenceRequest?.tenantApplicationCurrency = commonService.getBaseCurrency(requestHeader.getInvoker().getOperatingCountryId()).getIdVersion();
		}
		UserPreferenceResponse userPreferenceResponse=bmClient.iBUserService.verifyAndUpdateUserSettings(userPreferenceRequest);
		
		// Set the themeName back to Params
		String themeName = "";
		String locale = userPreferenceResponse.getUserPreference().getLocale().getLocale().getCode();
		themeName = userPreferenceResponse.getUserPreference().getProfileTheme().getCode();
		themeName = themeName +"_"+locale;
		params.themeName = themeName;
		
		// Set the Language to en or ar based on the selection
		def lang = locale.split("_");
		lang = lang[0];
		params.lang = lang;
		 
		if(!userPreferenceResponse.hasErrors())
		
		{
			setMessage(DEFAULT_UPDATED_MESSAGE, ["UserSettings Updated"," Successfully"], model);
			model <<[userPreferenceResponseModel:userPreferenceResponse]
		}else
		{
			model <<[errors:userPreferenceResponse.errors()]

		}
}

	IBUserProfileResponse getuserprofilereponse(GenericRequestHeader requestHeader){
		Long loginprofileId = requestHeader.getInvoker().getUserLoginProfileId();
		IBUserProfileResponse userProfileResponse = commonService.getIBUserProfileDetails(loginprofileId);
		return userProfileResponse;
	}
	
	
	
	List<String> cifNumbers(){
		IBUserProfile ibUserProfile = getuserprofilereponse().getIbUserProfile();
		List cifNumbers = ibUserProfile.getCifNumbers();
		return cifNumbers;
	}
	
	IBUserProfileResponse getuserprofilereponse(){
		Long loginprofileId = getUserLoginProfile().getId();
		println("loginprofileId:"+loginprofileId);
		IBUserProfileResponse userProfileResponse = commonService.getIBUserProfileDetails(loginprofileId);
		return userProfileResponse;
	}
	
	def profile(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		
		
		IBUserProfileResponse userProfileReponse = getuserprofilereponse();
		//IBUserProfile ibUserProfile = userProfileReponse.getIbUserProfile();
		//println ("value::::"+userProfileReponse.ibUserLoginProfile.segment.code);
		
		
		if(!userProfileReponse.hasErrors())
		{
			model <<[userProfileResponseModel:userProfileReponse]
		}else
		{
			model <<["errors":userProfileReponse]

		}
		
		//model<<[responsemodel:userProfileReponse];
	
		//model << [userProfileReponseModel:userProfileReponse.ibUserLoginProfile]
	
		//model <<[ResponseModel:userProfileReponse]
		
	}
	def updateCustomerProfile(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		
		
		
		IBUserProfileRequest  ibUserProfileRequest =getBean(IBUserProfileRequest.class, requestHeader, params);  
		ibUserProfileRequest.setCifNumber(invoker.getPrimaryCIF());
		//ibUserProfileRequest.setMobileNumber(params.primaryPhoneNumber); 
		IBUserProfileResponse userProfileReponse = bmClient.iBUserService.updateCustomerProfile(ibUserProfileRequest);
		if(!userProfileReponse.hasErrors())
		{
			setMessage(DEFAULT_UPDATED_MESSAGE, ["Cusomer Profile "," Successfully"], model);
			model <<[userProfileResponseModel:userProfileReponse]
		}else
		{
			model <<["errors":userProfileReponse]

		}
		
	}
	
	def firstTimeLogin(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		UserSelfRegistrationRequest userSelfRegistrationRequest=getBean(UserSelfRegistrationRequest.class, requestHeader, null);
			UserSelfRegistrationResponse userSelfRegistrationResponse=bmClient.iBUserService.getSecureImageBaskets(userSelfRegistrationRequest);			
			if(userSelfRegistrationResponse.hasErrors()){
				model << [userVerificationRequestModel:userSelfRegistrationRequest,"errors":userSelfRegistrationResponse.errors()]
			}else{
				model << [userSelfRegistrationRequestModel:userSelfRegistrationRequest,userSelfRegistrationResponseModel:userSelfRegistrationResponse,ibUserLoginProfile:userSelfRegistrationResponse?.ibUserLoginProfile,isToApplyTransPassword:tenantAppConfig.isToApplyTransPassword()]
			}
		
		
	}
	def verifylogininfo(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		
		//Server Side validation
		FirstTimeLoginInfoCommand  firstTimeLoginInfoCmd=validateCommandObject(FirstTimeLoginInfoCommand.class,params)
		if(firstTimeLoginInfoCmd.hasErrors()){			
			model << [errors:firstTimeLoginInfoCmd]     
			return
		}
		//request object taken from flow to persist the request value from previous page  
		UserSelfRegistrationRequest userSelfRegistrationRequest=(UserSelfRegistrationRequest)model.userSelfRegistrationRequestModel;
		userSelfRegistrationRequest.ibUserSecureImageId=params.list('ibUserSecureImgChkId')
		userSelfRegistrationRequest.ibUserName=params.ibUserLoginName;
		userSelfRegistrationRequest.ibUserSecureMessage=params.ibUserSecureMessage;
		log.info("VERIFY LOGIN INFO IB SEC MESSAGE :: "+params?.ibUserSecureMessage);
		userSelfRegistrationRequest.ibUserEncryptedPassCode=params.ibUserEncryptedPassCode;
		userSelfRegistrationRequest.ibUserEncryptedTransPassCode=params.ibUserEncryptedTransPassCode;
		userSelfRegistrationRequest.isASelfUploadedImage=params.imageType=='PSZL'?YesNoEnum.Y:YesNoEnum.N
		userSelfRegistrationRequest.selfUploadedImageName=params.selfImageName
		UserSelfRegistrationResponse userSelfRegistrationResponse=bmClient.iBUserService.getSecureQuestions(userSelfRegistrationRequest);
		   
		if(userSelfRegistrationResponse.hasErrors()){
			model << [userVerificationRequestModel:userSelfRegistrationRequest,"errors":userSelfRegistrationResponse.errors()]
		}else{
			model << [userSelfRegistrationRequestModel:userSelfRegistrationRequest,userSelfRegistrationResponseModel:userSelfRegistrationResponse]
		}
		
		
	}
	
	def registerFirstTimeUser(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		//Server Side validation
		UserSecretInfoCommands  userSecretInfoCmd=validateCommandObject(UserSecretInfoCommands.class,params)
		if(userSecretInfoCmd.hasErrors()){
			model << [errors:userSecretInfoCmd]
			return
		}
		//request object taken from flow to persist the request value from previous page
		UserSelfRegistrationRequest userSelfRegistrationRequest=(UserSelfRegistrationRequest)model.userSelfRegistrationRequestModel;
		userSelfRegistrationRequest.ibUserSecretQuestionId=params?.list("ibUserSecretQuestionId")
		userSelfRegistrationRequest.ibUserSecretAnswer=params?.list("ibUserSecretAnswer")
		userSelfRegistrationRequest.ibUserColorPalates=params?.list("ibUserSecureColorChkId")
		userSelfRegistrationRequest.toApplyTransPassword=tenantAppConfig.isToApplyTransPassword()
		log.info("REGISTER FIRST TIME USER IB SEC MESSAGE :: "+userSelfRegistrationRequest.getIbUserSecureMessage());
		UserSelfRegistrationResponse userSelfRegistrationResponse=bmClient.iBUserService.registerFirstTimeUser(userSelfRegistrationRequest);
		
		if(userSelfRegistrationResponse.hasErrors()){
			model << [userVerificationRequestModel:userSelfRegistrationRequest,"errors":userSelfRegistrationResponse.errors()]
		}else{
			model << [userLoginInfoRequestModel:userSelfRegistrationRequest,userSelfRegistrationResponseModel:userSelfRegistrationResponse]
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
	def forceChangeLoginPasswordWarning(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception
	{
		boolean forceChangePassword 			= 	false;
		IBUserProfileResponse ulp 				= 	getuserprofilereponse();
		PasswordPolicyConfiguration pwdConf 	= 	commonService.fetchPasswordPolicyConfig(requestHeader);
		Integer passwordChangeFrequency 		= 	pwdConf?.passwordChangeFrequency;
		Date lastLoginPwdChange 				= 	ulp?.ibUserLoginProfile?.getUserCredential()?.getLastLoginPwdChange();
		Date currentDate 						= 	new Date();
		long currentTime 						= 	currentDate.getTime();
		long  pwdChangeTime 					= 	lastLoginPwdChange.getTime();
		long diffDays 							= 	(currentTime-pwdChangeTime) / (24 * 60 * 60 * 1000);
		Integer forceChangeLoginPasswordDays	=	pwdConf?.forceChangePasscodeDays;
		int noOfDays							=	0;
		if(diffDays > Long.valueOf(String.valueOf(passwordChangeFrequency.intValue())) )
		{
			forceChangePassword 				= 	true;
			int number							=	forceChangeLoginPasswordDays.intValue() - passwordChangeFrequency.intValue();
			if(number>0){
				noOfDays 						= 	number;
			}
		}
		if(forceChangePassword){
			model<<[noOfDays:noOfDays]
		}
	}
	def registerIPAddress(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception
	{
		//Register the IP Address as Allowed IP for the user
		UserLoginProfileRequest ulpRequest = getBean(UserLoginProfileRequest.class, requestHeader, params);
		UserLoginProfileResponse ulpResponse = bmClient.userService.updateAllowedLocations(ulpRequest);
		UserLoginProfile ulp = ulpResponse.getUserLoginProfile();
		redirectBasedOnStatus(ulp,model);
	}
	
	def dontRegisterIPAddress(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception
	{
		UserLoginProfileRequest ulpRequest = getBean(UserLoginProfileRequest.class, requestHeader, params);
		Long ulpId = ulpRequest.getRequestHeader().getInvoker().getUserLoginProfileId();
		ulpRequest.setUserLoginProfileId(ulpId);
		UserLoginProfileResponse ulpResponse = bmClient.userService.getUserLoginProfileById(ulpRequest);
		redirectBasedOnStatus(ulpResponse.getUserLoginProfile(),model);
	}
	
	def personalizeaccounts(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		setnamesequence(params,requestHeader,model);
	}
	
	def personalizecreditcards(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		setnamesequence(params,requestHeader,model);
	}
	
	def setnamesequence(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		UpdateNickNameRequest upReq = getBean(UpdateNickNameRequest.class, requestHeader, params);
		OwnAccountRequest ownAccountRequest=getBean(OwnAccountRequest.class, requestHeader, params);		
		ownAccountRequest.setIbUserLoginProfileId(getUserLoginProfile().getId());
		OwnAccountResponse ownAccountResponse=bmClient.accountService.getOwnAccounts(ownAccountRequest);
		String productType = params.productType;
		upReq.setProductType(productType);
		if(!CollectionUtils.isEmpty(ownAccountResponse.getOwnAccountList()) && productType.equalsIgnoreCase("A"))
		{
			ListIterator<Account> listItr = ownAccountResponse.getOwnAccountList().listIterator();
			Account userAccount = null;
			while(listItr.hasNext())
			{
				userAccount = listItr.next();
				if(userAccount!=null && userAccount.getAcctProduct().getProductType().getCode().equalsIgnoreCase("SB") )
				{
					upReq.getSavingsAccount().add(userAccount);
					upReq.getUserAccounts().add(userAccount);
				}
				else if(userAccount!=null && userAccount.getAcctProduct().getProductType().getCode().equalsIgnoreCase("CA") )
				{
					upReq.getCurrentAccount().add(userAccount);
					upReq.getUserAccounts().add(userAccount);
				}
				else if(userAccount!=null && userAccount.getAcctProduct().getProductType().getCode().equalsIgnoreCase("LA") )
				{
					upReq.getLoanAccount().add(userAccount);
					upReq.getUserAccounts().add(userAccount);
				}
				else if(userAccount!=null && userAccount.getAcctProduct().getProductType().getCode().equalsIgnoreCase("DA") )
				{
					upReq.getDepositAccount().add(userAccount);
					upReq.getUserAccounts().add(userAccount);
				}
			}
		} else if(!CollectionUtils.isEmpty(ownAccountResponse.getOwnAccountList()) && productType.equalsIgnoreCase("C"))
		{
			ListIterator<Account> listItr = ownAccountResponse.getOwnAccountList().listIterator();
			Account userAccount = null;
			while(listItr.hasNext())
			{
				userAccount = listItr.next();
				if(userAccount!=null && userAccount.getAcctProduct().getProductType().getCode().equalsIgnoreCase("CC1") )
				{
					upReq.getCreditCardAccounts().add(userAccount);
					upReq.getUserAccounts().add(userAccount);
				}
			}
		}
		
		
		model << [setnameseqrequest:upReq];
	}
	
	
	def updatenamesequence(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		UpdateNickNameRequest accountRequest = getBean(UpdateNickNameRequest.class, requestHeader, params);
		
		// Populate the NameSequenceRequest Objects
		Integer rowIndexCount = params.int('rowIndexCount')
		
		List<String> lstAccountNumbers = params.list("accountNumber");
		List<String> lstAccountTypes = params.list("accountType");
		List<String> lstNicknames = params.list("nickname");
		List<String> lstSequence = params.list("sequence");
		List<String> lstUserAccountAttributeId = params.list("userAccountAttributeId");
		List<String> lstAccountId = params.list("accountId");
		
		NameSequenceRequest nameSeqReq = null;
		
		for(int counter=0;counter<rowIndexCount;counter++ )
		{
			nameSeqReq = new NameSequenceRequest();
			
			if(!CollectionUtils.isEmpty(lstAccountNumbers))
			{
				nameSeqReq.setNumber(lstAccountNumbers.get(counter));
			}
			
			if(!CollectionUtils.isEmpty(lstNicknames))
			{
				nameSeqReq.setName(lstNicknames.get(counter));
			}
			
			if(!CollectionUtils.isEmpty(lstSequence))
			{
				nameSeqReq.setSequence(lstSequence.get(counter));
			}
			
			if(!CollectionUtils.isEmpty(lstUserAccountAttributeId) &&  lstUserAccountAttributeId.get(counter)!=null && !lstUserAccountAttributeId.get(counter).equals(""))
			{
				nameSeqReq.setUserAccountAttributeId(Long.valueOf(lstUserAccountAttributeId.get(counter)));
			}
			
			if(!CollectionUtils.isEmpty(lstAccountId) &&  lstAccountId.get(counter)!=null && !lstAccountId.get(counter).equals(""))
			{
				nameSeqReq.setAccountId(Long.valueOf(lstAccountId.get(counter)));
			}
			
			if(!CollectionUtils.isEmpty(lstAccountTypes))
			{
				String accountType = lstAccountTypes.get(counter).toString();
				if(accountType!=null && !accountType.equals("") && accountType.equals("CC1"))
				{
					accountRequest.setNameSequenceType("C");
					nameSeqReq.setAccountType(accountType);
					accountRequest.getNameSequenceList().add(nameSeqReq);
				}
				else if(accountType!=null && !accountType.equals(""))
				{
					accountRequest.setNameSequenceType("A");
					nameSeqReq.setAccountType(accountType);
					accountRequest.getNameSequenceList().add(nameSeqReq);
				}
			}
		}
		UpdateNickNameResponse upNickResponse = null;
		if(!CollectionUtils.isEmpty(accountRequest.getNameSequenceList()))
		{
			checkForDuplicateSeqNos(accountRequest);
			upNickResponse = bmClient.accountService.updateNickNameSequence(accountRequest);
		}
		
		setMessage(DEFAULT_UPDATED_MESSAGE, ["NickName / Sequence Updated"," Successfully"], model);
		model <<[setnameseqrequest:accountRequest,productType:accountRequest.getNameSequenceType()];
		
	}
		
	
	
	def redirectBasedOnStatus(UserLoginProfile ulp,ModelMap model) throws Exception
	{
		if(checkFirstTimeLogin(ulp))
		{
			model << [userStatus:'ftlogin']
		}
		else if (checkLoginPasswordExpired(ulp))
		{
			model << [userStatus:'lpExpired']
		}
		else if (checkTransactionPasswordExpired(ulp))
		{
			model << [userStatus:'tpExpired']
		}
		else
		{
			model << [userStatus:'home']
		}
	}
	
	/*
	* @param ulp
	* @return
	*/
   private boolean checkLoginPasswordExpired(UserLoginProfile ulp){
	   
	   boolean credentialsNotExpired = false;
	   String loginPassCodeExpired= ulp.getUserCredential().isLoginPassCodeExpired.toString();
	   if(loginPassCodeExpired!=null && !loginPassCodeExpired.equalsIgnoreCase("") && loginPassCodeExpired.equalsIgnoreCase("Y"))
	   {
		   credentialsNotExpired = true;
	   }
	   
	   return credentialsNotExpired;
   }
   
   
   /**
	* This method is used to set the Default Failure URL to Change Transaction Password based on Transaction Password Expiry Flag
	*
	* @param ulp
	* @return
	*/
   private boolean checkTransactionPasswordExpired(UserLoginProfile ulp){
	   
	   boolean credentialsNotExpired = false;
	   String transPassCodeExpired= ulp.getUserCredential().isTransPassCodeExpired.toString();
	   if(transPassCodeExpired!=null && !transPassCodeExpired.equalsIgnoreCase("") && transPassCodeExpired.equalsIgnoreCase("Y"))
	   {
		   credentialsNotExpired = true;
	   }
	   
	   return credentialsNotExpired;
   }
	
	
	public boolean checkFirstTimeLogin(UserLoginProfile ulp)
	{
		boolean firstTimeLogin = false;
		if(userLoginProfile.getLoginStatus()!=null && LookupCodeConstants.FIRST.equalsIgnoreCase(userLoginProfile.getLoginStatus().getCode()))
		{
			firstTimeLogin = true;
		}
		return firstTimeLogin;
	}
	
	/**
	 * This method is used to check for duplicate Sequence Numbers.
	 * 
	 * @param nickNameReq
	 * @return
	 */
	def checkForDuplicateSeqNos(UpdateNickNameRequest nickNameReq)
	{
		List<NameSequenceRequest> listNameSeq = nickNameReq.getNameSequenceList();
		if(listNameSeq!=null && !listNameSeq.isEmpty())
		{
			ListIterator<NameSequenceRequest> lstItr = listNameSeq.listIterator();
			NameSequenceRequest nameSeqReq = null;
			List<String> savingsAccounts = new ArrayList<String>();
			List<String> currentAccounts = new ArrayList<String>();
			List<String> loanAccounts = new ArrayList<String>();
			List<String> depositAccounts = new ArrayList<String>();
			List<String> creditCardAccounts = new ArrayList<String>();
			while(lstItr.hasNext())
			{
				nameSeqReq = lstItr.next();
				if(StringUtils.hasLength(nameSeqReq.getAccountType()))
				{
					String accountType = nameSeqReq.getAccountType();
					if(accountType.equalsIgnoreCase("SB"))
					{
						savingsAccounts.add(nameSeqReq.getSequence());
					}
					else if(accountType.equalsIgnoreCase("CA"))
					{
						currentAccounts.add(nameSeqReq.getSequence());
					}
					else if(accountType.equalsIgnoreCase("LA"))
					{
						loanAccounts.add(nameSeqReq.getSequence());
					}
					else if(accountType.equalsIgnoreCase("DA"))
					{
						depositAccounts.add(nameSeqReq.getSequence());
					}
					else if(accountType.equalsIgnoreCase("CC1"))
					{
						creditCardAccounts.add(nameSeqReq.getSequence());
					}
				}
			}
			
			int savingsCounter = savingsAccounts.size();
			int currentCounter = currentAccounts.size();
			int loanCounter = loanAccounts.size();
			int depositCounter = depositAccounts.size();
			int creditCardCounter = creditCardAccounts.size();
			
			List<String> savingsAccountsUnique =  ImmutableSet.copyOf(savingsAccounts).asList();
			List<String> currentAccountsUnique = ImmutableSet.copyOf(currentAccounts).asList();
			List<String> loanAccountsUnique = ImmutableSet.copyOf(loanAccounts).asList();
			List<String> depositAccountsUnique = ImmutableSet.copyOf(depositAccounts).asList();
			List<String> creditCardAccountsUnique = ImmutableSet.copyOf(creditCardAccounts).asList();
			
			int savingsUnique = savingsAccountsUnique.size();
			int currentUnique = currentAccountsUnique.size();
			int loanUnique = loanAccountsUnique.size();
			int depositUnique = depositAccountsUnique.size();
			int creditCardUnique = creditCardAccountsUnique.size();
			
			if(savingsUnique!=savingsCounter)
			{
				throw new BusinessException(ContextCodeType.CORE, "savings.sequence.unique.error", "Update Sequence NickName", null);
			}
			
			if(currentUnique!=currentCounter)
			{
				throw new BusinessException(ContextCodeType.CORE, "current.sequence.unique.error", "Update Sequence NickName", null);
			}
			
			if(loanUnique!=loanCounter)
			{
				throw new BusinessException(ContextCodeType.CORE, "loan.sequence.unique.error", "Update Sequence NickName", null);
			}
			
			if(depositUnique!=depositCounter)
			{
				throw new BusinessException(ContextCodeType.CORE, "deposit.sequence.unique.error", "Update Sequence NickName", null);
			}
			
			if(creditCardUnique!=creditCardCounter)
			{
				throw new BusinessException(ContextCodeType.CORE, "creditcard.sequence.unique.error", "Update Sequence NickName", null);
			}
		}
	}
}

class ChangePasswordCommand{
	String ibUserEncryptedPassCode;
	String ibNewEncryptedPassCode;
	String ibNewConfEncryptedPassCode;

	static constraints={
		ibUserEncryptedPassCode(blank:false);
		ibNewEncryptedPassCode(blank:false,validator:{val,obj ->
			if(val?.toString().equals(obj?.ibUserEncryptedPassCode?.value.toString())){
				obj.errors.rejectValue('ibNewEncryptedPassCode','userLoginInfoCommand.oldandnewpassword.notsame')
			}
		});
		ibNewConfEncryptedPassCode(blank:false,validator:{val,obj ->
			if(!val?.toString().equals(obj?.ibNewEncryptedPassCode?.value.toString())){
				obj.errors.rejectValue('ibNewEncryptedPassCode','userLoginInfoCommand.password.notsame')
			}
		});     
		
		
	}
}


class ChangeSecureAccessCommand{
	String ibUserSecureImages;
	String ibSecretAnswer;
	
	static constraints={
		ibUserSecureImages(blank:false);
		ibSecretAnswer(blank:false);
	}
}


class TransactionPasswordCommand{
	String ibUserEncryptedTransactionPassCode;
	String ibNewEncryptedTransactionPassCode;
	String ibNewConfEncryptedTransactionPassCode;

	static constraints={
		ibUserEncryptedTransactionPassCode(blank:false);
		ibNewEncryptedTransactionPassCode(blank:false,validator:{val,obj ->
			if(val?.toString().equals(obj?.ibUserEncryptedTransactionPassCode?.value.toString())){
				obj.errors.rejectValue('ibNewEncryptedTransactionPassCode','userLoginInfoCommand.oldandnewpassword.notsame')
			}
		});		
		ibNewConfEncryptedTransactionPassCode(blank:false,validator:{val,obj ->
			if(!val?.toString().equals(obj?.ibNewEncryptedTransactionPassCode?.value.toString())){
				obj.errors.rejectValue('ibNewEncryptedTransactionPassCode','userLoginInfoCommand.transpassword.notsame')
			}
		});
	}
}
class FirstTimeLoginInfoCommand implements Serializable{
	String ibUserLoginName;
	String ibUserEncryptedPassCode;
	String ibUserEncryptedConfPassCode;	
	String isToApplyTransPassword;
	String ibUserEncryptedTransPassCode;
	String ibUserEncryptedTransConfPassCode;
	String ibUserSecureImageId1;
	String ibUserSecureImgChkId;
	String ibUserSecureMessage;
	//String ibUserSecureColorChkId;
	String imageType;
	String selfImageName;
	
	static constraints={
		ibUserLoginName(blank:false);     
		ibUserEncryptedPassCode(blank:false);
		ibUserSecureImgChkId(nullable:false);  
		ibUserEncryptedTransPassCode(blank:false);
		ibUserEncryptedConfPassCode(blank:false,validator:{val,obj ->
			if(!val?.toString().equals(obj?.ibUserEncryptedPassCode?.value.toString())){
				obj.errors.rejectValue('ibUserEncryptedPassCode','userLoginInfoCommand.password.notsame')
			}
		});
		ibUserEncryptedTransConfPassCode(blank:false,validator:{val,obj ->
//			if("Y".equals(obj?.isToApplyTransPassword?.value.toString())){  
				if(!val?.toString().equals(obj?.ibUserEncryptedTransPassCode?.value.toString())){
					obj.errors.rejectValue('ibUserEncryptedPassCode','userLoginInfoCommand.transpassword.notsame')
				}
//			}
		});
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
		//ibUserSecureColorChkId(blank:false);         
	}
}   
class UserSecretInfoCommands implements Serializable{
	String ibUserSecretQuestionId;
	String ibUserSecretAnswer;
		
	static constraints={
		ibUserSecretQuestionId(blank:false);
		ibUserSecretAnswer(blank:false);
	}
}