package com.vayana.ib.retail.web.service

import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils;

import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.ContextCodeType;
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.beans.user.UserLoginProfileRequest
import com.vayana.bm.core.api.beans.user.UserLoginProfileResponse
import com.vayana.bm.core.api.constants.BusinessFunctionConstants;
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants;
import com.vayana.bm.core.api.model.user.UserSecretQuestion
import com.vayana.ib.bm.core.api.beans.common.IBCommonRequest;
import com.vayana.ib.bm.core.api.beans.common.IBCommonResponse;
import com.vayana.ib.bm.core.api.beans.otp.OTPGenerationRequest
import com.vayana.ib.bm.core.api.beans.otp.OTPGenerationResponse
import com.vayana.ib.bm.core.api.beans.otp.OTPVerificationRequest
import com.vayana.ib.bm.core.api.beans.otp.OTPVerificationResponse
import com.vayana.ib.bm.core.api.beans.security.SecurityHolder
import com.vayana.ib.bm.core.api.beans.servicerequest.GenericSRRequest
import com.vayana.ib.bm.core.api.beans.servicerequest.GenericSRResponse
import com.vayana.ib.bm.core.api.beans.transfers.BillPaymentTransferRequest;
import com.vayana.ib.bm.core.api.beans.transfers.BillPaymentTransferResponse;
import com.vayana.ib.bm.core.api.beans.transfers.FundTransferRequest
import com.vayana.ib.bm.core.api.beans.transfers.FundTransferResponse
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileResponse;
import com.vayana.ib.bm.core.api.model.applyloan.ApplyLoanRequest;
import com.vayana.ib.bm.core.api.model.applyloan.ApplyLoanResponse
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService
import com.vayana.bm.core.api.model.user.UserLoginProfile

class SecurityService extends GenericService {
	
	private static final PROCESS_PAYNOW_ACTION="processfundtransfer"
	private static final PAYMENT_CONTROLLER="payment"
	
	BmClient bmClient
	
	CommonService commonService
	
	int _MAX_RETRY_ATTEMPTS = 10;
	
	def fetchPaymentSecurityAdvice(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
 		FundTransferRequest fundTransferRequest=(FundTransferRequest)getSessionAttribute("FTR")	
		FundTransferResponse fundTransferResponse=bmClient.paymentService.verifyPaymentSecuritySetting(fundTransferRequest)
 	 	SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		securityHolder.setSecuritySettings(fundTransferResponse.getSecuritySettings())	  
		if(fundTransferResponse.getSecuritySettings().isEmpty()){
			securityHolder.setIsValidated(Boolean.TRUE)
		}else{
			securityHolder.setIsValidated(Boolean.FALSE)
		}
		setSessionAttribute("SECHOLD", securityHolder)
		
		model<<[securityHolder:securityHolder]
		
	}
	

	
	def fetchSecurityAdviceForAService(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{	
		IBCommonRequest iBCommonRequest= new IBCommonRequest();
		Map<String,Object> requestParams=new HashMap<String, Object>(1); 
		requestParams.put("serviceCode", params?.serviceCode);
		iBCommonRequest.setRequestHeader(requestHeader);
		iBCommonRequest.setRequestParams(requestParams);
		IBCommonResponse iBCommonResponse=bmClient.iBCommonService.fetchSecuritySettingsForAService(iBCommonRequest);
		SecurityHolder securityHolder=getBean(SecurityHolder.class, requestHeader, null);
		securityHolder.setSuccessAction(params?.successAction)
		securityHolder.setSuccessController(params?.successController)
		securityHolder.setSecuritySettings(iBCommonResponse.getResponseValues())
		if(iBCommonResponse.getResponseValues().isEmpty()){
			securityHolder.setIsValidated(Boolean.TRUE)
		}else{
			securityHolder.setIsValidated(Boolean.FALSE)
		}	
		setSessionAttribute("SECHOLD", securityHolder)	
		model<<[securityHolder:securityHolder]
			
	}
	
	def fetchSecurityAdviceForAImpsService(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		IBCommonRequest iBCommonRequest= new IBCommonRequest();
		Map<String,Object> requestParams=new HashMap<String, Object>(1);
		requestParams.put("serviceCode", params?.serviceCode);   
		iBCommonRequest.setRequestHeader(requestHeader);
		iBCommonRequest.setRequestParams(requestParams);
		IBCommonResponse iBCommonResponse=bmClient.iBCommonService.fetchSecuritySettingsForAService(iBCommonRequest);
		SecurityHolder securityHolder=getBean(SecurityHolder.class, requestHeader, null);
		securityHolder.setSuccessAction(params?.successAction)
		securityHolder.setSuccessController(params?.successController)
		securityHolder.setSecuritySettings(iBCommonResponse.getResponseValues())
		if(iBCommonResponse.getResponseValues().isEmpty()){
			securityHolder.setIsValidated(Boolean.TRUE)
		}else{
			securityHolder.setIsValidated(Boolean.FALSE)
		}
		setSessionAttribute("SECHOLD", securityHolder)
		model<<[securityHolder:securityHolder]
			
	}
	
	def showTwoFa(Map params,  GenericRequestHeader requestHeader, ModelMap model)
	{    
		String otpTransactionId = java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong();
		//To add Security Holder with OTP Transaction Id for validation
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		securityHolder.setOtpTransactionId(otpTransactionId);
		setSessionAttribute("SECHOLD", securityHolder)
		def intervalForOTPResend=grailsApplication.getFlatConfig().get("otp.resend.interval")?.toString()
		OTPGenerationRequest otpGenerationRequest = getBean(OTPGenerationRequest.class, requestHeader, params)
		otpGenerationRequest.cifNumber	=	requestHeader?.invoker?.primaryCIF
		otpGenerationRequest.setLoginProfileId(getUserLoginProfile().getId());
//		otpGenerationRequest.transactionData1 = otpTransactionId
		if(PAYMENT_CONTROLLER.equals(securityHolder.getSuccessController())){ /*&& PROCESS_PAYNOW_ACTION.equals(securityHolder.getSuccessAction())*/
			/*FundTransferRequest fundTransferRequest=(FundTransferRequest)getSessionAttribute("FTR")
			if(fundTransferRequest != null){
				otpGenerationRequest.transactionData2 = fundTransferRequest.fromAccount.accountNumber
				otpGenerationRequest.transactionData3 = fundTransferRequest.toAccountNumber
				otpGenerationRequest.transactionData4 = fundTransferRequest.paymentAmount
				otpGenerationRequest.transactionData5 = fundTransferRequest.transactionCurrency
			}*/
			otpGenerationRequest.otpRequestType = "REQ01"
		} else {
			otpGenerationRequest.otpRequestType = "REQ02"
		}
		if(params?.comments && securityHolder != null){
			securityHolder?.comments = params?.comments
		}
		OTPGenerationResponse otpGenerationResponse = bmClient.twoFactorService.otpGeneration(otpGenerationRequest);
		if(otpGenerationResponse.hasErrors()){
			model<<[errors:otpGenerationResponse.errors()]
		}else{
			securityHolder.setOtpTransactionId(otpGenerationResponse.getTokenTag());
			model<<[otpGenModel:otpGenerationResponse,otpTransactionId:otpTransactionId,securityHolder:securityHolder,resendInterval:intervalForOTPResend]
		}	
	}
	
	def validateTwoFa(Map params,  GenericRequestHeader requestHeader, ModelMap model)
	{
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		String otpTransactionId = securityHolder?.otpTransactionId;
		String decyptedValue = commonService.decryptData(params.otpValue);
		params.otpValue = decyptedValue;
		String otpTokenValue = params.otpValue;
		OTPVerificationRequest otpVerificationRequest = getBean(OTPVerificationRequest.class, requestHeader, params);
		otpVerificationRequest.cifNumber	=	requestHeader?.invoker?.primaryCIF
		otpVerificationRequest.setLoginProfileId(getUserLoginProfile().getId());
		otpVerificationRequest.transactionId = otpTransactionId
		/*if(PAYMENT_CONTROLLER.equals(securityHolder.getSuccessController()) && PROCESS_PAYNOW_ACTION.equals(securityHolder.getSuccessAction())){
			FundTransferRequest fundTransferRequest=(FundTransferRequest)getSessionAttribute("FTR")
			if(fundTransferRequest != null){
				otpVerificationRequest.transactionData2 = fundTransferRequest.fromAccount.accountNumber
				otpVerificationRequest.transactionData3 = fundTransferRequest.toAccountNumber
				otpVerificationRequest.transactionData4 = fundTransferRequest.paymentAmount
				otpVerificationRequest.transactionData5 = fundTransferRequest.transactionCurrency
			}
		}*/
		otpVerificationRequest.setOtpValue(otpTokenValue);
		OTPVerificationResponse otpVerificationResponse = bmClient.twoFactorService.otpVerification(otpVerificationRequest);
		
		if(otpVerificationResponse.hasErrors())
		{
			model<<[errors:otpVerificationResponse.errors()]
		}else
		{	
			if(securityHolder != null && securityHolder?.comments){
				params?.comments = securityHolder?.comments
			}
			def securitySettings=securityHolder?.securitySettings
				if(!securitySettings?.isEmpty())
				{
					securitySettings.remove(0);
					securityHolder.setSecuritySettings(securitySettings);
					
				}
				if(securitySettings?.isEmpty())
				{
					securityHolder.setIsValidated(Boolean.TRUE)
				}
				setSessionAttribute("SECHOLD", securityHolder)
			model<<[otpVerifyModel:otpVerificationResponse,securityHolder:securityHolder]
		}
	}

	def showTxnPwd(Map params,  GenericRequestHeader requestHeader, ModelMap model)
	{
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		IBUserProfileResponse ibUserProfileResponse = commonService.getIBUserProfileDetails(getUserLoginProfile().getId());
		params.userLoginProfileId = getUserLoginProfile().getId();
		params.loginId = ibUserProfileResponse?.ibUserLoginProfile?.userLogin;
		params.tenantApplicationId = getInvoker().getTenantApplicationId();
		
		if(params?.comments && securityHolder != null){
			securityHolder?.comments = params?.comments
		}
		model<<[securityHolder:securityHolder]
		
	}
	
	def validateTxnPwd(Map params,  GenericRequestHeader requestHeader, ModelMap model)
	{
		log.info("------------------------------------------------------------");
		log.info("Service ::: Security");
		log.info("Closure ::: validateTxnPwd");
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")		
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, params);
		Map<String,String> requestParams=new HashMap<String, String>(3);
		String decyptedValue = commonService.decryptData(params?.txnPassword);
		requestParams.put("hashedPasswordCode", decyptedValue);
		commonRequest.setRequestParams(requestParams);
		log.info("Tenant Service Code ::: "+securityHolder?.serviceCode);
		CommonResponse commonResponse = null;
		try{
			commonResponse = bmClient.iBCommonService.verifyTransactionPassword(commonRequest);
		}catch(BusinessException be){
			if(BusinessFunctionConstants.PG_PAYMENT.equals(securityHolder?.serviceCode)){
				_MAX_RETRY_ATTEMPTS = _MAX_RETRY_ATTEMPTS-1;
			}
			log.info("Exception _MAX_RETRY_ATTEMPTS ::: "+_MAX_RETRY_ATTEMPTS);
			if(_MAX_RETRY_ATTEMPTS != 0){
				throw new BusinessException(be?.contextCode,be?.errorCode, be?.errorDescription,null);
			}else{
				_MAX_RETRY_ATTEMPTS = 10;
				log.info(" Exception  _MAX_RETRY_ATTEMPTS ::: "+_MAX_RETRY_ATTEMPTS);
				if(BusinessFunctionConstants.PG_PAYMENT.equals(securityHolder?.serviceCode)){
					securityHolder.setMAX_TXN_PWD_ATTEMPTS(0); 
				}
				log.info("Exception  Security Holder MAX_TXN_PWD_ATTEMPTS ::: "+securityHolder?.MAX_TXN_PWD_ATTEMPTS);
				model<<[securityHolder:securityHolder]
				return;
			}
		}
		if(commonResponse?.hasErrors())
		{
			model<<[errors:commonResponse.errors()]
		}else
		{	
			_MAX_RETRY_ATTEMPTS = 10;
			log.info("No Exception _MAX_RETRY_ATTEMPTS ::: "+_MAX_RETRY_ATTEMPTS);
			securityHolder.setMAX_TXN_PWD_ATTEMPTS(-1);
			log.info("No Exception Security Holder MAX_TXN_PWD_ATTEMPTS ::: "+securityHolder?.MAX_TXN_PWD_ATTEMPTS);
			if(securityHolder != null && securityHolder?.comments){
				params?.comments = securityHolder?.comments
			}
			def securitySettings=securityHolder?.securitySettings
				if(!securitySettings?.isEmpty())
				{
					securitySettings.remove(0);
					securityHolder.setSecuritySettings(securitySettings);
					
				}
				if(securitySettings?.isEmpty())
				{
					securityHolder.setIsValidated(Boolean.TRUE)
				}
				setSessionAttribute("SECHOLD", securityHolder)
			model<<[securityHolder:securityHolder]
		}		
	}
	
	def showSecretQandA(Map params,  GenericRequestHeader requestHeader, ModelMap model)
	{
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, params);
		if(params?.comments && securityHolder != null){
			securityHolder?.comments = params?.comments
		}
 		CommonResponse commonResponse=bmClient.iBCommonService.fetchUserSecretQuestions(commonRequest);
		if(commonResponse?.hasErrors())
		{
			model<<[errors:commonResponse.errors()]
		}else
		{
			model<<[userSecretQuestionModel:(List<UserSecretQuestion>)commonResponse.getCommonEntities(),securityHolder:securityHolder]
		}
	}
	
	def validateSecretQandA(Map params,  GenericRequestHeader requestHeader, ModelMap model)
	{
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")		
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, params);
		println params?.dump()
		Map<List<String>,List<String>> requestParams=new HashMap<List<String>>();
		List<String> ibUserSecretQuestion = params.list("ibUserSecretQuestion");
		List<String> ibUserSecretAnswer = params.list("ibUserSecretAnswer");
		requestParams.put(ibUserSecretQuestion, ibUserSecretAnswer);
		commonRequest.setRequestParams(requestParams);
		CommonResponse commonResponse=bmClient.iBCommonService.validateUserSecretQuestion(commonRequest);
		if(commonResponse?.hasErrors())
		{
			model<<[errors:commonResponse.errors()]
		}else
		{
			
			if(securityHolder != null && securityHolder?.comments){
				params?.comments = securityHolder?.comments
			}
			def securitySettings=securityHolder?.securitySettings
				if(!securitySettings?.isEmpty())
				{
					securitySettings.remove(0);
					securityHolder.setSecuritySettings(securitySettings);
					
				}
				if(securitySettings?.isEmpty())
				{
					securityHolder.setIsValidated(Boolean.TRUE)
				}
				setSessionAttribute("SECHOLD", securityHolder)
			model<<[securityHolder:securityHolder]
		}	
	}
	
	def fetchBillPaymentSecurityAdvice(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		log.info("-----------------------------------------------------------");
		log.info("Service   ::  Security");
		log.info("Action 	::	fetchBillPaymentSecurityAdvice");	
		BillPaymentTransferRequest billPaymentTransferRequest=(BillPaymentTransferRequest)getSessionAttribute("FTR")
		BillPaymentTransferResponse billPaymentTransferResponse=bmClient.billPaymentService.verifyBillPaymentSecuritySetting(billPaymentTransferRequest)
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		securityHolder.setSecuritySettings(billPaymentTransferResponse.getSecuritySettings())
		securityHolder.setServiceCode(billPaymentTransferRequest?.billPaymentTenantService?.serviceApplication?.service?.code);
		log.info("Security Service Code 	::	"+securityHolder?.serviceCode);
		if(BusinessFunctionConstants.PG_PAYMENT.equals(securityHolder.getServiceCode()) && StringUtils.hasText(billPaymentTransferResponse?.SEC_DEF_MAX_ATTEMPTS)){
		   _MAX_RETRY_ATTEMPTS = Integer.parseInt(billPaymentTransferResponse?.SEC_DEF_MAX_ATTEMPTS);
		}
		log.info("Security Service _max_retry_attempts 	::	"+_MAX_RETRY_ATTEMPTS);
		if(billPaymentTransferResponse.getSecuritySettings().isEmpty()){
		   securityHolder.setIsValidated(Boolean.TRUE)
		}else{
		   securityHolder.setIsValidated(Boolean.FALSE)
		}
		setSessionAttribute("SECHOLD", securityHolder)
		log.info("-----------------------------------------------------------");
		model<<[securityHolder:securityHolder]
	   
   }
	
	def resendOTP(Map params,  GenericRequestHeader requestHeader, ModelMap model){
		String otpTransactionId = java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong();
		//To add Security Holder with OTP Transaction Id for validation
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		securityHolder.setOtpTransactionId(otpTransactionId);
		setSessionAttribute("SECHOLD", securityHolder)
		
		OTPGenerationRequest otpGenerationRequest = getBean(OTPGenerationRequest.class, requestHeader, params)
		otpGenerationRequest.cifNumber	=	requestHeader?.invoker?.primaryCIF
		otpGenerationRequest.setLoginProfileId(getUserLoginProfile().getId());
//		otpGenerationRequest.transactionData1 = otpTransactionId
		if(PAYMENT_CONTROLLER.equals(securityHolder.getSuccessController())){ /*&& PROCESS_PAYNOW_ACTION.equals(securityHolder.getSuccessAction())*/
			/*FundTransferRequest fundTransferRequest=(FundTransferRequest)getSessionAttribute("FTR")
			if(fundTransferRequest != null){
				otpGenerationRequest.transactionData2 = fundTransferRequest.fromAccount.accountNumber
				otpGenerationRequest.transactionData3 = fundTransferRequest.toAccountNumber
				otpGenerationRequest.transactionData4 = fundTransferRequest.paymentAmount
				otpGenerationRequest.transactionData5 = fundTransferRequest.transactionCurrency
			}*/
			otpGenerationRequest.otpRequestType = "REQ01"
		} else {
			otpGenerationRequest.otpRequestType = "REQ02"
		}
		OTPGenerationResponse otpGenerationResponse = bmClient.twoFactorService.otpGeneration(otpGenerationRequest);
		if(otpGenerationResponse.hasErrors()){
			model<<[errors:otpGenerationResponse.errors()]
		}else{
			securityHolder.setOtpTransactionId(otpGenerationResponse.getTokenTag());
			model<<[otpGenModel:otpGenerationResponse,otpTransactionId:otpTransactionId,securityHolder:securityHolder]
		}
	}
	
	def fetchSecurityAdviceForAServiceRequest(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		GenericSRRequest genericSRRequest=(GenericSRRequest)getSessionAttribute("GSRR")
		if(genericSRRequest.getIsJointAuthRequired() == false)
		{
			params?.successAction = 'insertServicerequest'
			params?.successController = 'serviceRequest'
		}
		genericSRRequest.setInitiatedDate(new Date());
		genericSRRequest.setReferenceNo(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString());
		genericSRRequest.setPersistEntity(true);
		genericSRRequest.setCifNumber(genericSRRequest.getRequestHeader().getInvoker().getPrimaryCIF());
		/*String tenantServiceCode = genericSRRequest.tenantServiceCode;
		String businessFunction  = tenantServiceCode+"."+"ADD"+"."+"AUTHORIZED";
		String alertType = "SMS";
		genericSRRequest.setBusinessFunction(businessFunction);
		genericSRRequest.setAlertType(alertType);*/
		GenericSRResponse serviceResponse = bmClient.serviceRequestService.verifySecuritySettingForAServiceRequest(genericSRRequest);
		SecurityHolder securityHolder=getBean(SecurityHolder.class, requestHeader, null);
		securityHolder.setSuccessAction(params?.successAction)
		securityHolder.setSuccessController(params?.successController)
		//println "security:"+serviceResponse.getSecuritySettings();
		securityHolder.setSecuritySettings(serviceResponse.getSecuritySettings())
		if(serviceResponse.getSecuritySettings().isEmpty()){
			securityHolder.setIsValidated(Boolean.TRUE)
		}else{
			securityHolder.setIsValidated(Boolean.FALSE)
		}
		setSessionAttribute("SECHOLD", securityHolder)
		
		model<<[securityHolder:securityHolder]
	}
	
	def fetchLoanRequestSecurityAdvice(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		
		ApplyLoanRequest applyLoanRequest = (ApplyLoanRequest)getSessionAttribute("APPLYLOANREQUEST")
		applyLoanRequest.setPersistEntity(true);		
		applyLoanRequest.setTenantServiceCode(params?.serviceCode)
		applyLoanRequest.setCifNumber(applyLoanRequest.getRequestHeader().getInvoker().getPrimaryCIF());
		//applyLoanRequest.setReferenceNo(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString());
		ApplyLoanResponse applyLoanResponse = bmClient.applyLoanService.verifySecuritySettingForALoanRequest(applyLoanRequest);
		//applyLoanRequest.setLoanrefnumber(applyLoanResponse.getLoanrefnumber().toString());			
		SecurityHolder securityHolder=getBean(SecurityHolder.class, requestHeader, null);
		securityHolder.setSuccessAction(params?.successAction)
		securityHolder.setSuccessController(params?.successController)
		securityHolder.setSecuritySettings(applyLoanResponse.getSecuritySettings())
		if(applyLoanResponse.getSecuritySettings().isEmpty()){
			securityHolder.setIsValidated(Boolean.TRUE)
		}else{
			securityHolder.setIsValidated(Boolean.FALSE)
		}
		setSessionAttribute("SECHOLD", securityHolder)
		
		model<<[securityHolder:securityHolder]
	}	
	
	
	def fetchIMPSSecurityAdvice(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		FundTransferRequest fundTransferRequest=(FundTransferRequest)getSessionAttribute("FTR")
	   FundTransferResponse fundTransferResponse=bmClient.paymentService.verifyPaymentSecuritySetting(fundTransferRequest)    
		 SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
	   securityHolder.setSecuritySettings(fundTransferResponse.getSecuritySettings())
	   if(fundTransferResponse.getSecuritySettings().isEmpty()){
		   securityHolder.setIsValidated(Boolean.TRUE)
	   }else{
		   securityHolder.setIsValidated(Boolean.FALSE)
	   }
	   setSessionAttribute("SECHOLD", securityHolder)
	   
	   model<<[securityHolder:securityHolder]
	   
   }
	
	def showTwoFaIMPS(Map params,  GenericRequestHeader requestHeader, ModelMap model)
	{
		    
		String otpTransactionId = java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong();   
		//To add Security Holder with OTP Transaction Id for validation
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		securityHolder.setOtpTransactionId(otpTransactionId);
		setSessionAttribute("SECHOLD", securityHolder)
		def intervalForOTPResend=grailsApplication.getFlatConfig().get("otp.resend.interval")?.toString()
		OTPGenerationRequest otpGenerationRequest = getBean(OTPGenerationRequest.class, requestHeader, params)
		otpGenerationRequest.cifNumber	=	requestHeader?.invoker?.primaryCIF
		otpGenerationRequest.setLoginProfileId(getUserLoginProfile().getId());
//		otpGenerationRequest.transactionData1 = otpTransactionId
		if(PAYMENT_CONTROLLER.equals(securityHolder.getSuccessController())){ /*&& PROCESS_PAYNOW_ACTION.equals(securityHolder.getSuccessAction())*/
			/*FundTransferRequest fundTransferRequest=(FundTransferRequest)getSessionAttribute("FTR")
			if(fundTransferRequest != null){
				otpGenerationRequest.transactionData2 = fundTransferRequest.fromAccount.accountNumber
				otpGenerationRequest.transactionData3 = fundTransferRequest.toAccountNumber
				otpGenerationRequest.transactionData4 = fundTransferRequest.paymentAmount
				otpGenerationRequest.transactionData5 = fundTransferRequest.transactionCurrency
			}*/
			otpGenerationRequest.otpRequestType = "REQ01"
		} else {
			otpGenerationRequest.otpRequestType = "REQ02"
		}
		if(params?.comments && securityHolder != null){
			securityHolder?.comments = params?.comments
		}
		String mpin				=	 (String)getSessionAttribute("MPIN");
		otpGenerationRequest.setmPIN(mpin);
		UserLoginProfileRequest userLoginProfileRequest = getBean(UserLoginProfileRequest.class, requestHeader, params)
		userLoginProfileRequest.setUserLoginProfileId(otpGenerationRequest.getRequestHeader().getInvoker().getUserLoginProfileId());
		UserLoginProfileResponse userLoginProfileResponse =bmClient.userService.getUserLoginProfileById(userLoginProfileRequest);
		otpGenerationRequest.setCustMobNo(userLoginProfileResponse.getUserLoginProfile().getUserContactDetail().getContact().getPrimaryMobileNumber());
		OTPGenerationResponse otpGenerationResponse = bmClient.twoFactorService.otpImpsGeneration(otpGenerationRequest);
		if(otpGenerationResponse.hasErrors()){
			model<<[errors:otpGenerationResponse.errors()]
		}else{
			securityHolder.setOtpTransactionId(otpGenerationResponse.getTokenTag());
			model<<[otpGenModel:otpGenerationResponse,otpTransactionId:otpTransactionId,securityHolder:securityHolder,resendInterval:intervalForOTPResend]
		}
	}
	def validateTwoFaIMPS(Map params,  GenericRequestHeader requestHeader, ModelMap model)
	{
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")    
		String otpTransactionId = securityHolder?.otpTransactionId;
		String decyptedValue = commonService.decryptData(params.otpValue);
		params.otpValue = decyptedValue;   
		String otpTokenValue = params.otpValue;
		
		FundTransferRequest fundTransferRequest =(FundTransferRequest)getSessionAttribute("FTR")
		if(fundTransferRequest==null){   
			FundTransferRequest fundTransferRequest1=getBean(FundTransferRequest.class,"fundTransferRequest", requestHeader, params); 
			 fundTransferRequest1.setOtpValue(otpTokenValue);       
			 FundTransferResponse response = bmClient.paymentService.setOtpValueInCache(fundTransferRequest1);     
		}
		fundTransferRequest.setOtpValue(otpTokenValue);    
		setSessionAttribute("FTR", fundTransferRequest);
		println("testIMPS"+otpTokenValue)
		OTPVerificationRequest otpVerificationRequest = getBean(OTPVerificationRequest.class, requestHeader, params);
		otpVerificationRequest.transactionId = otpTransactionId	
		otpVerificationRequest.setOtpValue(otpTokenValue);
		OTPVerificationResponse otpVerificationResponse = null;
		
			def securitySettings=securityHolder?.securitySettings
				if(!securitySettings?.isEmpty())
				{
					securitySettings.remove(0);
					securityHolder.setSecuritySettings(securitySettings);
					
				}
				if(securitySettings?.isEmpty())
				{
					securityHolder.setIsValidated(Boolean.TRUE)
				}
				setSessionAttribute("SECHOLD", securityHolder)
			model<<[otpVerifyModel:otpVerificationResponse,securityHolder:securityHolder]
	}
	
}
