package com.vayana.ib.retail.web.controller



import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.model.common.DocumentDetail
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.CommonService;
import com.vayana.ib.retail.web.service.UserProfileService
import com.vayana.ib.retail.web.service.common.FileUploadService;
import com.vayana.ib.retail.web.taglibs.exception.FileUploadException

class UserProfileController extends GenericController{
	
	CommonService commonService;
	UserProfileService userProfileService;
	FileUploadService fileUploadService;
	def profile(){
		render template:"/userProfile/templates/profile",model:model;
	}
	def updateCustomerProfile(){
		render template:"/userProfile/templates/profile",model:model;
	}
	def userpreferences(){
		render template:"/userProfile/templates/preferences";
	}
	
	def loginhistory(){
		render template:"/userProfile/templates/loginhistory",model:model;
	}
	
	def showPasswordPolicy(){
		render template:"/common/passwordPolicy",model:model;
	}
	
	def changepassword(){
		render template:"/userProfile/templates/changepassword",model:model;
	}
	
	def transactionpassword(){
		render template:"/userProfile/templates/transactionpassword";
		
	}
	
	def verifyloginpasscode(){
		render template:"/userProfile/templates/changepasswordsuccess"
	}
	def verifyforceloginpasscode(){
		render template:"/userProfile/templates/forceChangePasswordSuccess"
	}
	
	def usersettings() {
		render template:"/userProfile/templates/usersettings",model:model
		//render "ok";
	}
	
	def verifytransactionpasscode(){
		if(!model.errors){
			render template:"/userProfile/templates/transactionpasswordsuccess"
		}else
		{
			render "";
		}
	}
	
	
	
	def changesecureaccess(){
		render template:"/userProfile/templates/changesecureaccess",model:model;
	}
	
	def secureimages(){
		render template:"/userProfile/templates/secureimages",model:model;
	}
	
	def usersettingsdetail(){
		//render template:"/userProfile/templates/usersettings",model:model;
		redirect(uri: "/home/homepage/changelocale?lang="+params.lang+"&themeName="+params.themeName,model:model)  
	}
	
	
	
	
	def verifysecureaccess(){
		if(!model.errors){
			render template:"/userProfile/templates/changesecureaccess",model:model;
		}else
		{
			render "";
		}
	}
	
	
	def loginsecureimage(){
		render template:"/userProfile/firstTimeLogin/template/loginsecureimages",model:model;
	}
	def smsalertnotification(){
		
	  render template:"/userProfile/templates/smsalertnotification",model:model;
	}
	def displaysmsalerts(){
		render template:"/userProfile/templates/displaysmsalert",model:model;
	}
	def updatesmsalerts(){
		render template:"/userProfile/templates/displaysmsalert",model:model;
	}
	def firstTimeLoginFlow={
		initialize {
			action {
				println "On Initialize"
				}
			on("success"){
				flow.userSelfRegistrationResponseModel=model?.userSelfRegistrationResponseModel
				flow.ibUserLoginProfile=model?.ibUserLoginProfile
				flow.fibUserName=model?.ibUserLoginProfile?.userLogin
				flow.userSelfRegistrationRequestModel=model?.userSelfRegistrationRequestModel
				flow.fApplyTransPassword=model?.isToApplyTransPassword
			}.to "userlogininfo"
	}
		userlogininfo{
			on("firstTimeLoginInfoSubmit"){
				flow.fibUserSecureImageId=params.list('ibUserSecureImgChkId')
				flow.fimageType=params.imageType
				flow.selfImageName=params.selfImageName
				flow.fibUserName=params.ibUserLoginName;
				flow.fibUserSecureMessage=params.ibUserSecureMessage;
				flow.fibUserEncryptedPassCode=params.ibUserEncryptedPassCode;
				flow.fibUserEncryptedConfPassCode=params.ibUserEncryptedConfPassCode;
				flow.fibUserEncryptedTransPassCode=params.ibUserEncryptedTransPassCode;
				flow.fibUserSecureColorChkId=params.ibUserSecureColorChkId
				model <<[userSelfRegistrationRequestModel:flow?.userSelfRegistrationRequestModel]
				userProfileService.verifylogininfo(params, getRequestHeader(params), model)
				flow.userSelfRegistrationRequestModel=model?.userSelfRegistrationRequestModel
			}to("verifyLoginSubmit")
			on(Exception).to "handleLoginException"
		}
		verifyLoginSubmit{
			action{
				if(model?.errors){
					flow.errors=model?.errors    
					return error()
				}else{
					return usersecretinfo()
				}
			}
			on("usersecretinfo"){
				flow.userSelfRegistrationResponseModel=model?.userSelfRegistrationResponseModel
			}.to"usersecretinfo"
			on("error").to"userlogininfo"
			on(Exception).to "handleLoginException"
			
		}
		usersecretinfo{
			on("firstTimeSecretInfoSubmit"){
				params.ibUserSecureColorChkId=flow.fibUserSecureColorChkId
				params.toApplyTransPassword=flow.fApplyTransPassword
				model <<[userSelfRegistrationRequestModel:flow.userSelfRegistrationRequestModel]
				userProfileService.registerFirstTimeUser(params, getRequestHeader(params), model)
			}to("verifySecretInfoSubmit")
			on("error").to"usersecretinfo"
			on(Exception).to "handleSecretInfoException"
		}
		verifySecretInfoSubmit{
			action{
				if(model?.errors){
					flow.errors=model?.errors
					return error()
				}else{
					return success()
				}
			}
			on("error").to"usersecretinfo"
			on("success").to("homepage")
			on(Exception).to"handleSecretInfoException"
		}
		
		homepage{
			redirect(controller:"home",action:"homepage")
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
			on("success").to("userlogininfo")
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
			on("success").to("usersecretinfo")
		}
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
		String ulpId = params?.ulp;
		StringBuffer sb = new StringBuffer();
		sb.append(uploadFileLocation).append(params.groupShortDescription).append("/").append(params.tenantShortDescription).append("/").append(ulpId).append("/");
		return sb;
	}
	
	
	def forceChangeLoginPassword()
	{
		render view:"/userProfile/userPref/changepassword";
	}
	
	def forceChangeTransactionPassword()
	{
		render view:"/userProfile/userPref/transactionpassword";
	}
	
	def continueToLogin()
	{
		chain(action:"homepage", controller:"home",params:params,model:model)
		 
	}
	def forceChangeLoginPasswordWarning(){
		if (!model.errors){
			render view :"/userProfile/userPref/forceChangeLoginPasswordWarning", model:model;
		}
	}
	def dontChangeLoginPassword(){
		redirect uri:"/home/homepage";
	}
	def registerIPInput()
	{
		if (!model.errors){
			render view :"/userProfile/userPref/registerIPAddress", model:model;
		}
	}
	
	def dontRegisterIPAddress()
	{
		def userStatus = model.userStatus;
		redirectBasedOnStatus(userStatus);
	}
	
	def registerIPAddress()
	{
		def userStatus = model.userStatus;
		redirectBasedOnStatus(userStatus);
	}
	
	def redirectBasedOnStatus(def userStatus)
	{
		if(userStatus.equals("ftlogin"))
		{
			redirect uri:"/userProfile/firstTimeLogin";
		}
		else if(userStatus.equals("lpExpired"))
		{
			redirect uri:"/userProfile/forceChangeLoginPassword";
		}
		else if(userStatus.equals("tpExpired"))
		{
			redirect uri:"/userProfile/forceChangeTransactionPassword";
		}
		else
		{
			redirect uri:"/home/homepage";
		}
	}
	
	def setnamesequence()
	{
		render template:"/userProfile/templates/setnamesequence",model:model;
	}
	
	def updatenamesequence()
	{
		if(model.productType!=null && model.productType.equals("A"))
		{
			render template:"/userProfile/templates/personalizeAccounts",model:model;
		}
		else if(model.productType!=null && model.productType.equals("C"))
		{
			render template:"/userProfile/templates/personalizeCreditCards",model:model;
		} 
		
	}
	
	def personalizeaccounts()
	{
		render template:"/userProfile/templates/personalizeAccounts",model:model;
	}
	
	def personalizecreditcards()
	{
		render template:"/userProfile/templates/personalizeCreditCards",model:model;
	}
	
	def image(){
		Long docDetailId = params.id?.toLong();
		DocumentDetail documentDetail = commonService.getDocumentDetailById(docDetailId);
		response.outputStream << documentDetail?.documentBlob;
	}
	
}