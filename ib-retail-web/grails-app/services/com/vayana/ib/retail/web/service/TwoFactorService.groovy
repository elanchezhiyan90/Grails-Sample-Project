package com.vayana.ib.retail.web.service

import java.util.Map;

import org.springframework.ui.ModelMap;

import com.vayana.bm.core.api.beans.common.GenericRequestHeader;
import com.vayana.bm.core.api.exception.BusinessException;
import com.vayana.ib.bm.core.api.beans.otp.OTPGenerationRequest;
import com.vayana.ib.bm.core.api.beans.otp.OTPGenerationResponse;
import com.vayana.ib.bm.core.api.beans.otp.OTPVerificationRequest;
import com.vayana.ib.bm.core.api.beans.otp.OTPVerificationResponse;
import com.vayana.ib.retail.web.service.common.BmClient;
import com.vayana.ib.retail.web.service.common.GenericService;

class TwoFactorService extends GenericService{
	
	BmClient bmClient;

	def otpgeneration(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		String otpTransactionId = java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong();
		OTPGenerationRequest otpGenerationRequest = getBean(OTPGenerationRequest.class, requestHeader, params)
		otpGenerationRequest.setLoginProfileId(getUserLoginProfile().getId());
		otpGenerationRequest.setTransactionId(otpTransactionId);
		OTPGenerationResponse otpGenerationResponse = bmClient.twoFactorService.otpGeneration(otpGenerationRequest);		
		if(otpGenerationResponse.hasErrors()){
			model<<[errors:otpGenerationResponse.errors()]
		}else{
			model<<[otpGenModel:otpGenerationResponse,otpTransactionId:otpTransactionId]
		}		
	}
	
	def otpverification(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		String otpTransactionId = params.otpTransactionId;
		String otpTokenValue = params.otpValue;
		OTPVerificationRequest otpVerificationRequest = getBean(OTPVerificationRequest.class, requestHeader, params);
		otpVerificationRequest.setLoginProfileId(getUserLoginProfile().getId());
		otpVerificationRequest.setTransactionId(otpTransactionId);
		otpVerificationRequest.setOtpValue(otpTokenValue);
		OTPVerificationResponse otpVerificationResponse = bmClient.twoFactorService.otpVerification(otpVerificationRequest);
		
		if(otpVerificationResponse.hasErrors()){
			model<<[otpVerifyModel:otpVerificationResponse]
		}else{
			model<<[otpVerifyModel:otpVerificationResponse]
		}		
		
	}
	
	
	
	
}
