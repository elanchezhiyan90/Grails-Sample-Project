package com.vayana.ib.retail.web.controller

import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.model.common.DocumentDetail
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.CommonService
import com.vayana.ib.retail.web.service.UserService
import javax.servlet.http.HttpSession

class UserController extends GenericController{
	
	CommonService commonService	
	UserService userService
	
	def image(){
		Long docDetailId = params.id?.toLong();
		DocumentDetail documentDetail = commonService.getDocumentDetailById(docDetailId);
		response.outputStream << documentDetail?.documentBlob;
	} 
	
	def index(){
		//get Error Code from Session attribute
		String errorCode  = session.getAttribute("errorCode");
		if (errorCode){
			String attemptsLeft  = session.getAttribute("attemptsLeft");
			
			
			session.removeAttribute("attemptsLeft");
			session.removeAttribute("errorCode");
			
			Object[] args =  new Object[1];
			if (attemptsLeft != null){
				args[0] = new String(attemptsLeft);
			}
			
			model << [errorCode:errorCode, args:args]
		}
		if (!params?.groupId) { params?.groupId ="40000" }
		if (!params?.tenantShortDescription) { params?.tenantShortDescription ="PMCB" }
		if (!params?.tenantApplicationId) { params?.tenantApplicationId ="50000" }
		log.info("---------------------------------------------------------")
		log.info("Params ="+params?.dump())
		log.info("---------------------------------------------------------")
		render view:"index", model:model,params:params;	    
	}
	
	def prelogin(){
		if (!model.errors){
			render template:"/user/templates/secure", model:model;
		}
	}

	def login = {
		log.info("---------------------------------------------------------")
		log.info("******* User Controller login action invoked ************")
		log.info("---------------------------------------------------------")
	}
	def validateLoginCaptcha(){
		render template:"/common/dummy",model:model;
	}
	
	def thankyou(){
		log.info("---------------------------------------------------------")
		log.info("******* User Controller thankyou action invoked *********")
		log.info("---------------------------------------------------------")
	}
	
	def logout(){
		log.info("---------------------------------------------------------")
		log.info("********* User Controller logout action invoked *********")
		log.info("---------------------------------------------------------")
	}
	
	def relogin(){
		/*HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}*/
		chain(controller:"user",action: "logout",params:params)      
		forward(controller:"tenant",action: "index",params:params)
	}
	
	def unauthorized(){
		
	}
	
	def invalidsession()
	{
		log.info("---------------------------------------------------------")
		log.info("**** User Controller invalidsession action invoked ******")
		log.info("---------------------------------------------------------")
		render view:"/user/expiredsession"
	}
	
	def expiredsession(){
		log.info("---------------------------------------------------------")
		log.info("**** User Controller expiredsession action invoked ******")
		log.info("---------------------------------------------------------")
		redirect(controller:"tenant",action: "index")
	} 
	
	
	
	def terms(){
		
		render template:"/user/templates/termsAndConditions", model:model;
	}
	
	def privacyStatement()
		{
			render template:"/user/templates/privacyStatement", model:model;
	
		}
	
		def legalDisclaimer()
		{
			render template:"/user/templates/legalDisclaimer", model:model;
	
		}
	
		def contact()
		{
			render template:"/user/templates/contact", model:model;
	
		}
	
	
	
	def forgetUserNameFlow={              
		intialize{        
			action{   
				println "Flow Intialized"
			}
			on("success").to "userIdentificationInfo"
		}
		
		userIdentificationInfo{      
			on("userIdentificationSubmit"){        
				flow.fcustomerId=params?.customerId
				userService.userIdentificationInfo(params, getRequestHeader(params), model)
				//flow.fcustomerId=model.forgetUserNameRequestModel?.customerId
			}.to("verifyIdentityInfoModel")      
			on(Exception).to "handleIdentityException"   
		}
		
		verifyIdentityInfoModel{                             
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()
				}else{
					return usersecretinfo()       
				}
			}
			on("error").to"userIdentificationInfo"      
			on("usersecretinfo")      
			{
				
			}.to"usersecretinfo"
			on(Exception).to "handleVerifyException"      
		}
		usersecretinfo{
		on("usersealinfosubmit"){
			userService.validateSecurity(params, getRequestHeader(params), model)
			}       
		.to("verifySecurityModel")
		on(Exception).to "handleSecurityException"   
	}
	
	verifySecurityModel{
		action{
			if(model?.errors){
				flash.errors=model?.errors
				return error()
			}else{
				return successForgetUserName()
			}
		}
		on("error").to"usersecretinfo"
		on("successForgetUserName").to"successForgetUserName"          
		on(Exception).to "handleVerifyException"
	}
	successForgetUserName{
	}
		handleIdentityException{
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
		handleSecurityException{
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
		
	}
	     
	
	def forgotPasswordFlow={        
		initialize {        
			action {       
				println "On Initialize"
				}
			on("success").to "userverification"      
			on(Exception).to "handleVerificationException"
	}
		userverification{
			on("userVerificationSubmit"){
				flow.fcustomerId =params?.customerId;
				userService.userverificationinfo(params, getRequestHeader(params), model)
				flow.userVerificationRequestModel=model.userVerificationRequestModel
				flow.userVerificationResponseModel=model.userVerificationResponseModel
			}to("verifyUserInfoModel")
			on(Exception).to "handleVerificationException"
		}
		verifyUserInfoModel{
			action{
				if(model.errors){
					flash.errors=model?.errors
					return error()
				}else{
					return usersecretinfo()
				}
			}
			on("error").to "userverification"
			on("usersecretinfo").to "usersecretinfo"
			on(Exception).to "handleVerificationException"
		}
		usersecretinfo{
			on("usersealinfosubmit"){ 
				flow.fcustomerId =params?.customerId
				flow.fcardNumber=params?.cardNumber
				// card1, card2, card3 ,card4 added for getting 4 split box values
				flow.fcardNumber1=params?.card1
				flow.fcardNumber2=params?.card2
				flow.fcardNumber3=params?.card3
				flow.fcardNumber4=params?.card4
				params.cardNumber=flow.fcardNumber
				//userService.validateSecurityForFP(params, getRequestHeader(params), model)
				  userService.atmPinInfoValidation(params, getRequestHeader(params), model)
			}to("verifyATMPinInfo")
			on(Exception).to "handleSecurityException"
		}
		
		verifySecurityModel{
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()
				}else{
					return passwordupdatedinfo()
				}
			}
			on("error").to"usersecretinfo"
			on("passwordupdatedinfo").to"passwordupdatedinfo"
			on(Exception).to "handleSecurityException"
		}
		verifyATMPinInfo{
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()
				}else{
				
					return userlogininfo()
				}
			}
			on("error").to"usersecretinfo"
			on("userlogininfo").to"userlogininfo"
			on(Exception).to "handleSecurityException"
		}
	
		
		userlogininfo{
			on("userlogininfosubmit"){
				flow.fcustomerId =params?.customerId
			   model <<[userVerificationRequestModel:flow.userVerificationRequestModel]
				userService.verifyloginpasscode(params, getRequestHeader(params), model)
				flow.userVerificationRequestModel=model.userLoginInfoRequestModel
				flow.userVerificationResponseModel=model.userLoginInfoResponseModel
			}to("verifyUserLoginInfo")
			on("error").to"userlogininfo"
			on(Exception).to "handleLoginException"
		}
		verifyUserLoginInfo{
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()
				}else{
					return passwordupdatedinfo()
				}
			}
			on("error").to"userlogininfo"
			on("passwordupdatedinfo"){
				
			}.to("passwordupdatedinfo")
			on(Exception).to"handleLoginException"
		}
		
		passwordupdatedinfo{
			
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
				 }else if(flash.rootCauseException instanceof Exception) {     
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
			}
			on("success").to("userlogininfo")
		}
		
		handleVerificationException{
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
				 }else if(flash.rootCauseException instanceof Exception) {     
					 String errorCode = flash.rootCauseException;
					 Object[] args =  flash.rootCauseException;
					 model << [messageType:"error", errorCode:errorCode, args:args]
					 flash.errorModel=model;
				 }
				 
				}
			on("success").to("userverification")
		}
		
		handleSecurityException{
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
					 }else if(flash.rootCauseException instanceof Exception) {     
					 	String errorCode = flash.rootCauseException;
						 Object[] args =  flash.rootCauseException;
						 model << [messageType:"error", errorCode:errorCode, args:args]
						 flash.errorModel=model;
					 }
					 
					}
				on("success").to "usersecretinfo"
			}
	}
	
	
	
	def preloginIntermediate()
	{
		if (!model.errors){
			def allowedIp = model.allowedIp;
			if(!allowedIp)
			{
				render template:"/user/templates/preloginIntermediate", model:model;
			}
			else
			{
				render template:"/user/templates/secure", model:model;
			}
			
		}
	}
	
	def preLoginIntermediateSubmit()
	{
		if (!model.errors){
			render template:"/user/templates/secure", model:model;
		}
	}
	
	def authForgotPasswordFlow={
		initialize {
			action {
				println "On Initialize"
				}
			on("success"){
				userService.authForgotPasswordURL(params, getRequestHeader(params), model)
				flow.fIbUserLoginProfile=model?.userLoginInfoResponseModel?.ibUserLoginProfile
			}.to "userActivation"
			on(Exception).to "handleAuthException"
	}
		userActivation{
			on("userActivationSubmit"){
				userService.verifyActivationCode(params, getRequestHeader(params), model)
			}to("verifyActInfoModel")
			on(Exception).to "handleVerificationException"
		}
		verifyActInfoModel{    
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()  
				}else{
					return userLogInInfo()
				}
			}
			on("error").to "userActivation"
			on("userLogInInfo").to "userLogInInfo"
			on(Exception).to "handleActivationException"
		}
		userLogInInfo{
			on("userlogininfosubmit"){
				params.ibULPId=flow.fIbUserLoginProfile.id
				userService.verifyloginpasscode(params, getRequestHeader(params), model)
			}to("verifyUserLoginInfo")
			on("error").to"userLogInInfo"
			on(Exception).to "handleLoginException"
		}
		
		verifyUserLoginInfo{
			action{
				if(model?.errors){
					flash.errors=model?.errors
					return error()
				}else{
					return passwordUpdateInfo()
				}
			}
			on("error").to"userLogInInfo"
			on("passwordUpdateInfo"){
				
			}.to("passwordUpdateInfo")
			on(Exception).to"handleLoginException"
		}
		
		passwordUpdateInfo{
			
		}
		urlExpired{
		
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
			on("success").to("userLogInInfo")
		}
		handleAuthException{
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
			on("success").to("urlExpired")
		}
		handleActivationException{
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
			on("success").to("userActivation")
		}
	}
	
	def migratedUser(){
		
	}
	
	def showPasswordPolicy(){
		
		render template:"/common/passwordPolicy",model:model;
	}
}