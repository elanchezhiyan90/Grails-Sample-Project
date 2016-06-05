package com.vayana.ib.retail.web.controller

import java.util.Map;

import grails.converters.JSON

import javax.servlet.http.HttpServletRequest
import org.springframework.beans.factory.annotation.Value
import org.apache.commons.fileupload.FileUploadException
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

import com.vayana.bm.core.api.beans.common.ContextCodeType;
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.InterfaceException
import com.vayana.bm.core.api.exception.code.ErrorCategoryConstants;
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants;
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.CommonService;
import com.vayana.ib.retail.web.service.UserRegistrationService
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.FileUploadService;

class UserRegistrationController extends GenericController {   	
	
	UserRegistrationService userRegistrationService
	BmClient bmClient;
	FileUploadService fileUploadService;
	CommonService commonService;
	
	
	    
	@Value('${ib.appcontexturl}')
	private String appcontexturl;

	def index = {
		redirect(action: "userRegistrationFlow")
	}
	def usernamevalidator(){
		render template:"/userRegistration/templates/usernamevalidator",model:model;
	}
	
	def loginsecureimage(){
		render template:"/userRegistration/templates/loginsecureimages",model:model;
	}
   def showPasswordPolicy(){
	   render template:"/common/passwordPolicy",model:model;
   }                                  
	   
/*	def userRegistrationFlow = {    
		initialize {   
			action {
				println "On Initialize"				
			}
			on("success").to "userverification"
			on(Exception).to "handleVerifyException"
		}
		userverification{
			on("userVerificationSubmit"){ 
				flow.fcustomerId=params?.customerId
				flow.fcardNumber=params?.cardNumber
				flow.fpinNumber=params?.pinNumber
				flow.fcardIssuedDate=params?.cardIssuedDate
				flow.fcardValidUpto=params?.cardValidUpto
				flow.fnameOnCard=params?.nameOnCard
				
				userRegistrationService.userverificationinfo(params, getRequestHeader(params), model)				
				flow.userSelfRegistrationRequestModel=model.userSelfRegistrationRequestModel
				flow.userSelfRegistrationResponseModel=model.userSelfRegistrationResponseModel
			}.to("verifyUserInfoModel")
			on(Exception).to "handleVerifyException"
		}
		
		verifyUserInfoModel{
			action{
				if(model?.errors){
					flow.errors=model?.errors
					return error()
				}else{
					return userlogininfo()
				}
			}			
			on("userlogininfo").to "userlogininfo"
			on("error").to"userverification"
			on(Exception).to "handleVerifyException"
		}
		
		userlogininfo {
			on ("userlogininfosubmit") {
				flow.fibUserSecureImageId=params.list('ibUserSecureImgChkId')
				flow.fibUserName=params.ibUserLoginName;
				flow.fibUserSecureMessage=params.ibUserSecureMessage;
				flow.fibUserEncryptedPassCode=params.ibUserEncryptedPassCode;
				flow.fibUserEncryptedConfPassCode=params.ibUserEncryptedConfPassCode;
				flow.fibUserSecureImageId1=params.ibUserSecureImageId1
				flow.fibUserSecureImgChkId=params.ibUserSecureImgChkId
				model <<[userSelfRegistrationRequestModel:flow.userSelfRegistrationRequestModel]
				userRegistrationService.userlogininfo(params, getRequestHeader(params), model)
				flow.userSelfRegistrationRequestModel=model.userLoginInfoRequestModel
				
			}to("verifyUserLoginInfo")
			on(Exception).to "handleLoginException"
		}
		verifyUserLoginInfo{
			action{
				if(model?.errors){	
					flash.errors=model?.errors
					return error()
				}else{				
					return usersecretinfo()
				}
			}
			on("error").to"userlogininfo"
			on("usersecretinfo")
			{
				flow.userSelfRegistrationResponseModel=model?.userSelfRegistrationResponseModel
			}.to"usersecretinfo"
			on(Exception).to "handleLoginException"
		}
		usersecretinfo {
			on("usersecretinfosubmit"){				
				model <<[userSelfRegistrationRequestModel:flow.userSelfRegistrationRequestModel]
				userRegistrationService.registeruser(params, getRequestHeader(params), model)
			}to("verifySecretInfo")
			on(Exception).to "handleSecretInfoException"
			
		}
		
		verifySecretInfo{
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()
				}else{
					return userregisterinfo()
				}
			}
			on("error").to"usersecretinfo"
			on("userregisterinfo").to"userregisterinfo"
			on(Exception).to "handleSecretInfoException"
		}
		
		
		userregisterinfo{
			  
		}
		handleVerifyException{
			action{				
				 if(flash.rootCauseException instanceof BusinessException)
				 {
					 String errorCode = flash.rootCauseException.errorCode;
					 Object[] args =  flash.rootCauseException.arguments;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof Exception)
				 {
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
				 
				}
			on("success").to "userverification"
		}
		handleLoginException{
			action{
				 if(flash.rootCauseException instanceof BusinessException)
				 {
					 String errorCode = flash.rootCauseException.errorCode;
					 Object[] args =  flash.rootCauseException.arguments;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof Exception)
				 {
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
				 
				}
			on("success").to "userlogininfo"
		}
		handleSecretInfoException{
			action{
				 if(flash.rootCauseException instanceof BusinessException)
				 {
					 String errorCode = flash.rootCauseException.errorCode;
					 Object[] args =  flash.rootCauseException.arguments;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof Exception)
				 {
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
				 
				}
			on("success").to "usersecretinfo"
		}
	}*/

	def userRegistrationFlow = {       
		intialize{                 
			action{         
				println "Flow Intialized"   
			}
			on("success").to "userIdentificationInfo"
		}
		
		userIdentificationInfo{
			on("userIdentificationSubmit"){
				flow.fcustomerId=params?.customerId
				userRegistrationService.userIdentificationInfo(params, getRequestHeader(params), model)
				flow.fcustomerId=model.userSelfRegistrationRequestModel?.customerId
			}.to("verifyIdentityInfoModel")	
			//on("error").to"userIdentificationInfo"
			on(Exception).to "handleIdentityException"
		}
		
		verifyIdentityInfoModel{
			action{
				if(model?.errors){
					flow.errors=model?.errors
					return error()
				}else{
					return processUserVerification()
				}
			}
			on("processUserVerification").to "userverification"
			on("error").to"userIdentificationInfo"
			on(Exception).to "handleVerifyException"   
		}  
		
		userverification{
			on("userVerificationSubmit"){ 
				flow.fcustomerId=params?.customerId
				//flow.fcardNumber=params?.cardNumber
				// card1, card2, card3 ,card4 added for getting 4 split box values
				//flow.fcardNumber1=params?.card1
				//flow.fcardNumber2=params?.card2
				//flow.fcardNumber3=params?.card3
				//flow.fcardNumber4=params?.card4
				//flow.fpinNumber=params?.pinNumber
				//flow.fcardIssuedDate=params?.cardIssuedDate
				//flow.fcardValidUpto=params?.cardValidUpto
				//flow.fnameOnCard=params?.nameOnCard
				//model <<[userSelfRegistrationRequestModel:flow.userSelfRegistrationRequestModel]
				flow.existLoginId = params?.existLoginId;
				String decyptedValue = commonService.decryptData(params?.existUsrPwd);
				params?.existUsrPwd = decyptedValue;
				flow.existUsrPwd = decyptedValue;
				userRegistrationService.userverificationinfo(params, getRequestHeader(params), model)				
				flow.userSelfRegistrationRequestModel=model.userSelfRegistrationRequestModel
				flow.userSelfRegistrationResponseModel=model.userSelfRegistrationResponseModel
				flow.secureImageBaskets=model?.userSelfRegistrationResponseModel?.secureImageBaskets
				flow.fuserProfile=model?.userSelfRegistrationRequestModel?.userProfile
				flow.fbranch=model?.userSelfRegistrationRequestModel?.branch
				flow.fsegment=model?.userSelfRegistrationRequestModel?.segment
				flow.fApplyTransPassword=model?.isToApplyTransPassword
			}.to("verifyUserInfoModel")
			on(Exception).to "handleVerifyException"
		}
		
		verifyUserInfoModel{
			action{
				if(model?.errors){
					flow.errors=model?.errors
					return error()
				}else{
					return userlogininfo()
				}
			}			
			on("userlogininfo").to "userlogininfo"
			on("error").to"userverification"
			on(Exception).to "handleVerifyException"
		}
		
		userlogininfo {
			
			on ("userlogininfosubmit") {
				flow.fibUserSecureImageId=params.list('ibUserSecureImgChkId')
				flow.fibUserName=params.ibUserLoginName;
				flow.fibUserEncryptedPassCode=params.ibUserEncryptedPassCode;
				flow.fibUserEncryptedConfPassCode=params.ibUserEncryptedConfPassCode;	
				flow.fibUserEncryptedTransPassCode=params.ibUserEncryptedTransPassCode;
				params.toApplyTransPassword=flow.fApplyTransPassword			
				userRegistrationService.userlogininfo(params, getRequestHeader(params), model)				
			}to("verifyUserLoginInfo")
			on(Exception).to "handleLoginException"
		}
		verifyUserLoginInfo{
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()
				}else{
					return usersecretinfo()
				}
			}
			on("error").to"userlogininfo"
			on("usersecretinfo")
			{
				
			}.to"usersecretinfo"
			on(Exception).to "handleLoginException"
		}
		usersecretinfo {
			on("usersecretinfosubmit"){	
				flow.fibUserSecretQuestionId=params.list("ibUserSecretQuestionId")
				flow.fibUserSecretAnswer=params.list("ibUserSecretAnswer")
				userRegistrationService.verifyUserSecretInfo(params, getRequestHeader(params), model)
			}to("verifySecretInfo")
			on(Exception).to "handleSecretInfoException"			
		}
		
		verifySecretInfo{
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()
				}else{
					return securitysealinfo()
				}
			}
			on("error").to"usersecretinfo"
			on("securitysealinfo").to"securitysealinfo"
			on(Exception).to "handleSecretInfoException"
		}
		securitysealinfo{
			on("usersealinfosubmit"){
				flow.fibUserSecureImageId1=params.ibUserSecureImageId1
				flow.fibUserSecureImgChkId=params.ibUserSecureImgChkId
				//flow.fibUserSecureColorChkId=params.ibUserSecureColorChkId
				flow.fibUserSecureMessage=params.ibUserSecureMessage;
				flow.fimageType=params.imageType
				flow.selfImageName=params.selfImageName
				params.customerId=flow.fcustomerId
//				params.cardNumber=flow.fcardNumber
//				params.pinNumber=flow.fpinNumber
//				params.cardIssuedDate=flow.fcardIssuedDate
//				params.cardValidUpto=flow.fcardValidUpto
//				params.nameOnCard=flow.fnameOnCard
				params.ibUserLoginName=flow.fibUserName
				params.ibUserEncryptedPassCode=flow.fibUserEncryptedPassCode
				params.ibUserEncryptedConfPassCode=flow.fibUserEncryptedConfPassCode
				params.ibUserEncryptedTransPassCode=flow.fibUserEncryptedTransPassCode
				params.ibUserEncryptedTransConfPassCode=flow.fibUserEncryptedTransPassCode
				params.ibUserSecretQuestionId=flow.fibUserSecretQuestionId
				params.ibUserSecretAnswer=flow.fibUserSecretAnswer
				params.applyTransPassword=flow.fApplyTransPassword
				model <<[userSelfRegistrationRequestModel:flow.userSelfRegistrationRequestModel,userProfile:flow.fuserProfile,branch:flow.fbranch,segment:flow.fsegment]
				userRegistrationService.registeruser(params, getRequestHeader(params), model)
			}to("verifySealInfo")
			on(Exception).to "handleSecretInfoException"
		}
		verifySealInfo{
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()
				}else{
					return userregisterinfo()
				}
			}
			on("error").to"securitysealinfo"
			on("userregisterinfo").to"userregisterinfo"
			on(Exception).to "handleSealInfoException"
		}
		/*userContactInfo{
			on("usercontactinfosubmit"){
				params.customerId=flow.fcustomerId				
				params.cardNumber=flow.fcardNumber
				params.pinNumber=flow.fpinNumber
				params.cardIssuedDate=flow.fcardIssuedDate
				params.cardValidUpto=flow.fcardValidUpto
				params.nameOnCard=flow.fnameOnCard
				params.ibUserLoginName=flow.fibUserName
				params.ibUserEncryptedPassCode=flow.fibUserEncryptedPassCode
				params.ibUserEncryptedConfPassCode=flow.fibUserEncryptedConfPassCode
				params.ibUserEncryptedTransPassCode=flow.fibUserEncryptedTransPassCode
				params.ibUserEncryptedTransConfPassCode=flow.fibUserEncryptedTransPassCode
				params.ibUserSecureImageId1=flow.fibUserSecureImageId1
				params.ibUserSecureImgChkId=flow.fibUserSecureImgChkId
				params.ibUserSecureColorChkId=flow.fibUserSecureColorChkId
				params.ibUserSecureMessage=flow.fibUserSecureMessage
				params.ibUserSecretQuestionId=flow.fibUserSecretQuestionId  
				params.ibUserSecretAnswer=flow.fibUserSecretAnswer
				params.applyTransPassword=flow.fApplyTransPassword
				params.imageType=flow.fimageType
				params.selfImageName=flow.selfImageName
				model <<[userSelfRegistrationRequestModel:flow.userSelfRegistrationRequestModel,userProfile:flow.fuserProfile,branch:flow.fbranch]
				userRegistrationService.registeruser(params, getRequestHeader(params), model)
			}to("verifyContactInfo")
			on(Exception).to "handleContactInfoException"
		}
		verifyContactInfo{
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()
				}else{
					return userregisterinfo()
				}
			}
			on("error").to"userContactInfo"
			on("userregisterinfo").to"userregisterinfo"
			on(Exception).to "handleContactInfoException"
		}*/
		userregisterinfo{
			
		}
		handleIdentityException{
			action{
				 if(flash.rootCauseException instanceof BusinessException)
				 {
					 String errorCode = flash.rootCauseException.errorCode;
					 Object[] args =  flash.rootCauseException.arguments;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof InterfaceException){
				 		String errorCode = flash.rootCauseException.errorCode;
						 Object[] args =  flash.rootCauseException.arguments;
						 model << [messageType:"error", errorCode:errorCode, args:args]
						 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof Exception) {     
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
				 
				}
			on("success").to "userIdentificationInfo"
		}
		handleVerifyException{    
			action{
				 if(flash.rootCauseException instanceof BusinessException)
				 {
					 String errorCode = flash.rootCauseException.errorCode;
					 Object[] args =  flash.rootCauseException.arguments;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof InterfaceException){
				 		String errorCode = flash.rootCauseException.errorCode;
						 Object[] args =  flash.rootCauseException.arguments;
						 model << [messageType:"error", errorCode:errorCode, args:args]
						 flash.errorModel=model;
				 } else if(flash.rootCauseException instanceof Exception)
				 {
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
				 
				}
			on("success").to "userverification"
		}
		handleLoginException{
			action{
				 if(flash.rootCauseException instanceof BusinessException)
				 {
					 String errorCode = flash.rootCauseException.errorCode;
					 Object[] args =  flash.rootCauseException.arguments;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof InterfaceException){
				 		String errorCode = flash.rootCauseException.errorCode;
						 Object[] args =  flash.rootCauseException.arguments;
						 model << [messageType:"error", errorCode:errorCode, args:args]
						 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof Exception)
				 {
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
				 
				}
			on("success").to "userlogininfo"
		}
		
		handleSecretInfoException{   
			action{
				 if(flash.rootCauseException instanceof BusinessException)
				 {
					 String errorCode = flash.rootCauseException.errorCode;
					 Object[] args =  flash.rootCauseException.arguments;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof Exception)
				 {
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
				 
				}
			on("success").to "usersecretinfo"
		}
		handleSealInfoException{
			action{
				 if(flash.rootCauseException instanceof BusinessException)
				 {
					 String errorCode = flash.rootCauseException.errorCode;
					 Object[] args =  flash.rootCauseException.arguments;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof Exception)
				 {
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
				 
				}
			on("success").to "securitysealinfo"
		}
		
		/*handleContactInfoException{
			action{
				 if(flash.rootCauseException instanceof BusinessException)
				 {
					 String errorCode = flash.rootCauseException.errorCode;
					 Object[] args =  flash.rootCauseException.arguments;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }else if(flash.rootCauseException instanceof Exception)
				 {
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
				 
				}
			on("success").to "userContactInfo"
		}*/
	}
	    
	def redirectUrl(){
		invokeForceLogout(request, response)
//		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
//		response.setHeader("Pragma", "no-cache");
//		response.setDateHeader("Expires", 0);    
		redirect(uri: "/tenant/index")
	}
	def secureUpload(){
		try {
			StringBuffer tenantPath = getTenantFilePathLocal(params);
			String fileName = params.qqfile;
			File uploaded = createTemporaryFile(tenantPath, fileName);
			InputStream inputStream = selectInputStream(request)
			fileUploadService.upload(inputStream, uploaded)    
			return render(text: [success:true] as JSON, contentType:'text/json')
		} catch (FileUploadException e) {
			return render(text: [success:false] as JSON, contentType:'text/json')
		}
	}
	
	private InputStream selectInputStream(HttpServletRequest request) {
		if (request instanceof MultipartHttpServletRequest) {
			MultipartFile uploadedFile = ((MultipartHttpServletRequest) request).getFile('qqfile')
			return uploadedFile.inputStream
		}
		return request.inputStream
	}    
	
	private File createTemporaryFile(StringBuffer filePath, String fileName) {
		File fullPath=  new File(filePath.toString());
		if (!fullPath.exists()) {
			fullPath.mkdirs();
		}
		String fullPathFileName = filePath.append("/").append(fileName).toString();
		File uploadedFile = new File(fullPathFileName)
		return uploadedFile
	}
	
	protected StringBuffer getTenantFilePathLocal(Map params){
		def config = grailsApplication.getConfig()
		String uploadFileLocation = config.fileUpload?.location;
		String ulpId = params?.cif;
		StringBuffer sb = new StringBuffer();
		sb.append(uploadFileLocation).append(params.groupShortDescription).append("/").append(params.tenantShortDescription).append("/").append(ulpId).append("/");
		return sb;
	}
	
	
}
