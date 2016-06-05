package com.vayana.ib.retail.web.controller

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

import org.apache.http.NameValuePair
import org.apache.http.client.utils.URIBuilder
import org.springframework.dao.DataAccessException
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler

import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.infra.workflow.WorkflowService;
import com.vayana.dateline.ib.connector.DatelineIBUtils;
import com.vayana.dateline.model.DatelineTask
import com.vayana.ib.bm.core.api.model.enums.TwoFactorTypeEnum		
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.BillPaymentService
import com.vayana.bm.common.security.SecurityUtils

class BillPaymentController extends GenericController{
	
	def BillPaymentService billPaymentService;
	
	/*def getSessionInfo(){
		render "OK";
	}*/
	
	WorkflowService workflowService;
	
	DatelineIBUtils datelineIBUtils;

	def billDesk(){
		forward (controller:'billPay',action:'index')
	}
	
	def billpaynowconfirm(){
		if(model.twoFactorType?.equals(TwoFactorTypeEnum.NONE.toString())){
			
			render template:"/billPayment/templates/corerefnumber", model:model;
		}else{
			render template:"/common/twoFaGenerate", model:model;
		}
	}
	
	def fromaccountbalanceandexgrate () {
		render template:"/payment/templates/common/balanceandexgrate", model:model;
	}
	
	def billpaynow()
	{
		render template:"/billPayment/templates/corerefnumber", model:model;
	}
	
	def validatefundtransfer(){
		render template:"/billPayment/templates/billpaymentok", model:model;
	}
	
	def paymentPostProcess()
	{
		render template:"/billPayment/templates/pg/paymentConfirm",model:model;
	}
	
	def processbillpayment() {
		if(model?.transferRequestModel?.safetyNetExist=='Y'){ 
			render template:"/billPayment/templates/safetynetresult", model:model;
		}else{
			if("BILLDESK".equals(model?.transferRequestModel?.toBillerInstruction?.biller?.shortName)){
				render template:"/billPayment/templates/corerefnumber", model:model;				 
			}else if("PG".equals(model?.transferRequestModel?.toBillerInstruction?.biller?.shortName)){	
				if(!model?.transferRequestModel?.isJointAuthRequired){	   		
					render template:"/billPayment/templates/pg/merchantRedirect", model:model;
				}else{
					render template:"/billPayment/templates/pg/pgSMERemarks", model:model;
					//invokeForceLogout(request,response);
				}						
			}						
		}
	}
	
	
	
	//BillDesk Starts	
	def billDeskTransaction(){
		render view :"/billPayment/billDeskTransaction", model:model;
	}
	
	def executeBillDeskPayment(){
		redirect(controller:"security",action: "fetchBillPaymentSecurityAdvice")
	}
	
	def billDeskLoginException(){
		render view :"/billPayment/billDeskLoginException", model:model;
	}
	
	def ibLogin(){
		invokeForceLogout(request,response);
		chain(controller:"tenant",action: "index")
	}
	//BillDesk Ends
	
	//Payment Gateway Starts
	def pgTransaction(){
		render view:"/billPayment/pgTransaction",model:model;
	}
	
	def pgUserLoginError(){
		render view:"/billPayment/pgUserLoginError",model:model;
	}
	
	def pgFAPError(){
		render view:"/billPayment/pgFAPError",model:model;
	}
	

	def cancelPGTransaction(){
		String redirectURL = model?.callBackURLModel
		println model?.dump()
		log.info("BillPaymentController : cancelPGTransaction : redirectURL ="+redirectURL);
		redirect (url:redirectURL)
		invokeForceLogout(request, response);		
	}
	
	/*def pgCallBackOnCancel(){
		String redirectURL = model?.callBackURLModel
		println model?.dump()
		invokeForceLogout(request, response);
		redirect (url:redirectURL)
	}*/
	
	def pgCallBackOnSuccess(){		
		String redirectURL = model?.callBackURLModel
		println model?.dump()	
		log.info("BillPaymentController : pgCallBackOnSuccess : redirectURL ="+redirectURL);
		redirect (url:redirectURL)
		invokeForceLogout(request, response);
	}
	
	
	
	
	/*def pgCallBackOnFailure(){
	
	}*/
	
	/*public void logout(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		  if (auth != null){
			 new SecurityContextLogoutHandler().logout(request, response, auth);
		  }
		SecurityContextHolder.getContext().setAuthentication(null);
	}*/
	
	//Payment Gateway Ends
	
	
	
	
	
	/*def billpayment(){
		render view :"/billPayment/billpayment", model:model;
	}
		
	def balanceandexgrate ()
	{
		render template:"/billPayment/templates/balanceandexgrate", model:model;
	}
		
	def billpaymentfavourite()
	{
		render "ok"; //render template:"/billPayment/templates/billpayment", model:model;
	}
	
	def scheduledfavourite(){
		render template:"/billPayment/templates/billpayment", model:model;
	}
	
	def pastpaymentfavourite(){
		render template:"/billPayment/templates/billpayment", model:model;
	}*/
	
	
	
	/*def billpaylaterconfirm(){
		if(model.twoFactorType?.equals(TwoFactorTypeEnum.NONE.toString())){
			render template:"/billPayment/templates/corerefnumber", model:model;
		}else{
		
			render template:"/common/twoFaGenerate", model:model;
		}
	}
	
	def billpaylater()
	{
		render template:"/billPayment/templates/corerefnumber", model:model;
	}
	
	def scheduledbillpayconfirm(){
		if(model.twoFactorType?.equals(TwoFactorTypeEnum.NONE.toString())){
			render template:"/billPayment/templates/corerefnumber", model:model;
		}else{
			render template:"/common/twoFaGenerate", model:model;
		}
	}
	
	def scheduledbillpay()
	{
		render template:"/billPayment/templates/corerefnumber", model:model;
	}	
	
	def showPaymentOriginPage(){
		println params.dump();
		render view : params.editUrl, model:model;
	}
		
	def showMakePaymentPage(){
		render view : params.editUrl, model:model;
	}
	
*/		
	
	/*def payLaterPreConfirm()
	{
		render template:"/billPayment/templates/billpayLater",model:model;
	}
	
	def repeatPreConfirm()
	{
		render template:"/billPayment/templates/billrepeat",model:model;
	}*/
	
	

	/*def processbillpaymentlater() {
		render template:"/billPayment/templates/corerefnumber", model:model;
	}
			
	def processbillschedulepayment() {
		render template:"/billPayment/templates/corerefnumber", model:model;
	}
	
	def billpaymentcancel(){
		render view :"/billPayment/billpayment", model:model;
	}
	
	def confirmCancelSIPayment()
	{
		render template:"/billPayment/templates/siskipsuccess",model:model;
	}
	
	def billInquiry(){
		render template:"/billPayment/templates/billInquiry", model:model;
	}*/
	
	
	
	/*def exchangeRateAndLimit(){
		render template:"/payment/templates/friendsandfamily/limitsandexchangerate", model:model;
	}
	
	def billerServiceType(){
		if(model?.billServiceModel?.billerInstruction?.billerService?.code == 'Prepaid'){
			render template:"/billPayment/templates/prepaidservicetype", model:model;
		}else if(model?.billServiceModel?.billerInstruction?.billerService?.code == 'Postpaid'){
			render template:"/billPayment/templates/postpaidservicetype", model:model;
		}
	}
	
	def utilityStandingInstruction(){
		render view :"/billPayment/utilitystandinginstruction", model:model;
	}
	
	def editSI(){
		render view :"/billPayment/billpayment", model:model;
	}
	
	def suspendStandingInstruction(){
		render template:"/billPayment/templates/utilitystandingInstructionList",model:model;
	}*/
	
	
	def showPaymentOriginPage(){
		println params.dump();
			render view : params.editUrl, model:model;
	}
	
	def approvePGPreConfirm() {
		render template:"/billPayment/templates/pg/remarks",params:params,model:model;
	}
	def rejectPGPreConfirm() {
		render template:"/billPayment/templates/pg/remarks",params:params,model:model;
	}
	
	def approvePGTransaction(){
		String errorCode = null;
		Object[] args    = null;
		pushDatelineUrlParametersIntoGrailsParams(params?.datelineReferenceId);
		Map<String,Object> taskVariables = new HashMap<String,Object>();
		String loggedInUser = SecurityUtils.invoker.userLoginProfileId
		taskVariables.put("authorizeAction", "approve");
		println "Params Dump :: "+params?.dump()
		try{
			workflowService.completeTaskWithFormData(params.taskId, taskVariables,loggedInUser,"Sample Approve");
		}catch(BusinessException be){
			errorCode 	= be.getErrorCode();
			args 		= be.getArguments();
			response.status = 417;
			render (template:'/billPayment/templates/pg/authError',model:[taskId:params.taskId,messageType:"failure", errorCode:errorCode, args:args]);
			return;
		}catch(DataAccessException dae){
			errorCode 		= dae.getClass().getName();
			response.status = 417;
			render (template:'/billPayment/templates/pg/authError',model:[taskId:params.taskId,messageType:"failure", errorCode:errorCode, args:args]);
			return;
		}catch(Exception e){
			errorCode 		= e.message;
			response.status = 417;
			render (template:'/billPayment/templates/pg/authError',model:[taskId:params.taskId,messageType:"failure", errorCode:errorCode, args:args]);
			return;
		}
		/* Added to Handle Checker CASA Accounts Refresh in Menu after Successful Payment */
		session.setAttribute("actsumModel",null);
		def PGDATA = billPaymentService.validatePGPayment(params?.paymentDetailId);
		render (template:'/billPayment/templates/pg/authorized',model:[taskId:params.taskId,PGDATA:PGDATA]);
	}
	
	def rejectPGTransaction(){
		log.info("----> Reject Fund Transfer in Payment Controller <----");
		log.info("----> Params Details :: "+params?.dump());
		pushDatelineUrlParametersIntoGrailsParams(params?.datelineReferenceId);
		Map<String,Object> taskVariables = new HashMap<String,Object>();
		String loggedInUser = SecurityUtils?.invoker?.userLoginProfileId
		log.info("----> Logged In User :: "+loggedInUser);
		String rejectComments =params?.comments;
		log.info("----> Reject Comments :: "+rejectComments)
		taskVariables.put("authorizeAction", "reject");
		log.info("----> Task Variables :: "+taskVariables?.dump());
		log.info("----> Task Id :: "+params?.taskId);
		workflowService.completeTaskWithFormData(params.taskId, taskVariables,loggedInUser,rejectComments);
		render (template:'/billPayment/templates/pg/rejected',model:[taskId:params.taskId]); //template to be changed
	}
	
	
	def pushDatelineUrlParametersIntoGrailsParams(String datelineTaskIdentifier){
		DatelineTask task = datelineIBUtils.getDateLineService().getDatelineTaskById(Long.parseLong(datelineTaskIdentifier))
		URIBuilder builder = new URIBuilder(task.getTargetUrlParam());
		List<NameValuePair> parameters = builder.getQueryParams();
		for (NameValuePair parameter : parameters) {
			params.put(parameter.getName(), parameter.getValue());
		}
	}
	
}
