package com.vayana.ib.retail.web.controller

import org.apache.http.NameValuePair
import org.apache.http.client.utils.URIBuilder
import org.springframework.dao.DataAccessException

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.core.api.constants.BusinessFunctionConstants;
import com.vayana.bm.core.api.constants.LookupCodeConstants;
import com.vayana.bm.core.api.constants.SubModuleConstants;
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.infra.workflow.WorkflowService
import com.vayana.dateline.ib.connector.DatelineIBUtils
import com.vayana.dateline.model.DatelineTask
import com.vayana.ib.bm.core.api.model.enums.TwoFactorTypeEnum
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.common.BmClient

class PaymentController extends GenericController {
	
	BmClient bmClient;
	
	DatelineIBUtils datelineIBUtils;
	
	WorkflowService workflowService;	
	
	
	def ownaccountpayment() {
		render view:"/payment/ownaccountpayment", model:model;
	}
	
	def ownaccountbalanceandexgrate () {
		render template:"/payment/templates/ownaccount/balanceandexgrate", model:model;
	}
	def fromaccountbalanceandexgrate () {
		render template:"/payment/templates/common/balanceandexgrate", model:model;
	}

	def dotransfer(){
		println params;
		render "ok"
	}

	def ownaccounttransferCurrency(){
		render view:"/payment/templates/ownaccount/transferCurrency", model:model;
	}
	def friendsandfamilypayment(){
		render view:"/payment/friendsandfamilypayment", model:model;
	}

	def processfundtransfer() { 
		if(model?.transferRequestModel?.safetyNetExist=='Y' || model?.transferRequestModel?.isJointAuthRequired){       
			render template:"/payment/templates/common/safetynetresult", model:model;    
		}else{
			render template:"/payment/templates/common/corerefnumber", model:model;      
		}
	}

	def processfundpaylater() {	   
		if(model?.transferRequestModel?.safetyNetExist=='Y' || model?.transferRequestModel?.isJointAuthRequired){
			render template:"/payment/templates/common/safetynetresult", model:model;
		}else{   
		render template:"/payment/templates/common/corerefnumber", model:model;          
		}
	}
			
	def processfundschedulepayment() {	   
		if(model?.transferRequestModel?.safetyNetExist=='Y' || model?.transferRequestModel?.isJointAuthRequired){
			render template:"/payment/templates/common/safetynetresult", model:model;    
		}else{
		render template:"/payment/templates/common/corerefnumber", model:model;   
		}       
	}

	def ownaccountfavourite(){

		render "ok"
	}
	def prepaidcardpaymentfavourite(){
		render "ok"
	}

	def ownscheduledfavourite(){
		render template:"/payment/templates/ownaccount/transfer", model:model;
	}

	def ownpastpaymentfavourite(){
//		render template:"/payment/templates/ownaccount/transfer", model:model;
		render "ok"
	}

	def friendsandfamilyfavourite(){
		//render template:"/payment/templates/friendsandfamily/transferfavourite", model:model;
		render "ok"
	}

	def benepastpaymentfavourite(){
		render template:"/payment/templates/friendsandfamily/transfer", model:model;
	}
	def benescheduledfavourite(){
		render template:"/payment/templates/friendsandfamily/transfer", model:model;
	}

	def exchangeRateAndLimit(){
		render template:"/payment/templates/friendsandfamily/limitsandexchangerate", model:model;
	}
	def prepaidcardpayment() {
		render view:"/payment/prepaidcardpayment",model:model;
	}
	def creditcardpayment() {
		render view:"/payment/creditcardpayment",model:model;
	}
	
	def creditcardtransfer() {
		render template:"/payment/templates/creditcard/corerefnumber", model:model;
	}
	
	def cardpaymentconfirm(){
		if(model.twoFactorType?.equals(TwoFactorTypeEnum.NONE.toString())){
			
			render template:"/payment/templates/creditcard/corerefnumber", model:model;
		}else{
			render template:"/common/twoFaGenerate", model:model;
		}
	}
	def creditcardpaymentfavourite(){
		render "ok"
	}
	def creditcardpaylater(){
		render template:"/payment/templates/creditcard/corerefnumber", model:model;
	}
	
	def creditcardpaylaterconfirm(){
		if(model.twoFactorType?.equals(TwoFactorTypeEnum.NONE.toString())){
			render template:"/payment/templates/creditcard/corerefnumber", model:model;
		}else{
		
			render template:"/common/twoFaGenerate", model:model;
		}
	}
	
	def creditcardschedulepayment(){
		render template:"/payment/templates/creditcard/corerefnumber", model:model;
	}
	
	def creditcardschedulepaymentconfirm(){
		if(model.twoFactorType?.equals(TwoFactorTypeEnum.NONE.toString())){
			render template:"/payment/templates/creditcard/corerefnumber", model:model;
		}else{
		
			render template:"/common/twoFaGenerate", model:model;
		}
	}

	def validatefundtransfer(){
		render template:"/payment/templates/common/paymentok", model:model;  
	}	
	def validateLoanFundTransfer(){
		validatefundtransfer();
	}
		
	def loanPayment() {
		render view:"/payment/loanPayment",model:model;
	}
	def loanPaymentConfirm(){
		if(model.transferResponseModel?.coreReferenceNumber){
			render template:"/payment/templates/loan/corerefnumber", model:model;
		}
		else{
			render template:"/twofactor/templates/invalidotp", model:model;
		}
	}
	def loanPaymentFavourite(){
		render "ok"
	}
	
	def viewsihistory()
	{
		if(params?.viewValue?.equals("BP")){
			render template:"/payment/templates/schedulepaymentreview/billpaysipending",model:model;
		}else{
			render template:"/payment/templates/schedulepaymentreview/sipending",model:model;
		}
	}

	def viewsi()
	{
		render template:"/payment/templates/schedulepaymentreview/viewsi"  
	}
	
	def stopSIPaymentSeries()
	{
		render template:"/payment/templates/schedulepaymentreview/siskipsuccess",model:model;
	}
	def skipSIPayment()
	{
		render template:"/payment/templates/schedulepaymentreview/siskipsuccess",model:model;
	}
	
	def viewsihistorypage()
	{
		if(model?.siViewAndUpdateRequestModel?.transferType?.equals("BP")){
			render template:"/payment/templates/schedulepaymentreview/billpaysipendingpage",model:model;  
		}else{
			render template:"/payment/templates/schedulepaymentreview/sipendingpage",model:model;
		}		
	}
	
	def viewskippedsi()
	{
		if(model?.siViewAndUpdateRequestModel?.transferType?.equals("BP")){
			render template:"/payment/templates/schedulepaymentreview/billpaysiskip",model:model;
		}else{
			render template:"/payment/templates/schedulepaymentreview/siskip",model:model;
		}
	}
	
	def viewskippedsipage()
	{
		if(model?.siViewAndUpdateRequestModel?.transferType?.equals("BP")){
			render template:"/payment/templates/schedulepaymentreview/billpaysiskippage",model:model;
		}else{
			render template:"/payment/templates/schedulepaymentreview/siskippage",model:model;
		}
	}
	
	def viewrejectedpayment()
	{
		if(model?.pastPaymentReviewRequestModel?.transferType?.equals("BP")){ 
			render template:"/payment/templates/pastpaymentreview/billpaymentrejected",model:model;
		}else{
			render template:"/payment/templates/pastpaymentreview/paymentrejected",model:model;
		}
	}
	
	def viewrejectedpaymentpage()
	{
		if(model?.pastPaymentReviewRequestModel?.transferType?.equals("BP")){ 
			render template:"/payment/templates/pastpaymentreview/billpaymentrejectedpage",model:model;
		}
		else{
			render template:"/payment/templates/pastpaymentreview/paymentrejectedpage",model:model;
		}  
	}
	
	def viewexecutedpayment()
	{
		if(params?.viewValue?.equals("BP")){
			render template:"/payment/templates/pastpaymentreview/billpaymentexecuted",model:model;
		}
		else{
			render template:"/payment/templates/pastpaymentreview/paymentexecuted",model:model;
		}
	}
	
	def viewexecutedpaymentpage()
	{
		if(model?.pastPaymentReviewRequestModel?.transferType?.equals("BP")){ 
			render template:"/payment/templates/pastpaymentreview/billpaymentexecutedpage",model:model;
		}else{
			render template:"/payment/templates/pastpaymentreview/paymentexecutedpage",model:model;
		}
	}
	
	def showPaymentDetails(){
		render template:params.viewUrl, model:model;
	}
		
	def showPaymentOriginPage(){
		println params.dump();		
			render view : params.editUrl, model:model;		
	}	
	
	def cancelSIPayment(){
		render template:"/common/twoFaGenerate",params:params, model:model;
	}
	
	def confirmCancelSIPayment()
	{
		render template:"/payment/templates/schedulepaymentreview/siskipsuccess",model:model;
	}
	
	def showMakePaymentPage(){
		
		render view : params.editUrl, model:model;
	}
	
	def cancelSITransaction(){		
		chain(controller: "payment", action: "cancelSIPayment",params:params)
	}
	
	def paymentPostProcess()
	{
		render template:"/payment/templates/common/paymentconfirm",model:model;     
	}
	def overridePaymentPostProcess() {
		render template:"/payment/templates/common/paymentconfirm",model:model;
	}
	
	def payLaterPreConfirm()
	{
		println params.dump()
		render template:"/payment/templates/common/payLater",model:model;
	}
	
	def repeatPreConfirm()
	{
		render template:"/payment/templates/common/repeat",model:model;
	}
	def approvePreConfirm() {
		render template:"/payment/templates/common/remarks",params:params,model:model;
	}
	def approvePreConfirmImps() {
		render template:"/payment/templates/common/remarksImps",params:params,model:model;
	}
	
	
	def rejectPreConfirm() {
		render template:"/payment/templates/common/remarks",params:params,model:model;
	}
	
	def investmentPayment(){
		render view:"/payment/investmentPayment",model:model;
	}

	def investmentpaymentfavourite(){
		
	}
	
	def autoPay(){
		render template:"/payment/templates/loan/autoPay",model:model;
	}
	def fetchEMIAmount(){
		render template:"/payment/templates/loan/emiAmount",model:model;
	}
	def currencyAndAmount(){
		render template:"/payment/templates/loan/currencyAndAmount",model:model;
	}
	
	def approveFundTransfer(){
		String errorCode = null;
		Object[] args    = null;
		pushDatelineUrlParametersIntoGrailsParams(params?.datelineReferenceId);
		Map<String,Object> taskVariables = new HashMap<String,Object>();
		String loggedInUser = SecurityUtils.invoker.userLoginProfileId
		taskVariables.put("authorizeAction", "approve");
		try{
			workflowService.completeTaskWithFormData(params.taskId, taskVariables,loggedInUser,"Sample Approve");
		}catch(BusinessException be){
			errorCode 	= be.getErrorCode();
			args 		= be.getArguments();
			response.status = 417;		
			render (template:'/payment/templates/common/authError',model:[taskId:params.taskId,messageType:"failure", errorCode:errorCode, args:args]);   
			return;
		}catch(DataAccessException dae){
			errorCode 		= dae.getClass().getName();			
			response.status = 417;		
			render (template:'/payment/templates/common/authError',model:[taskId:params.taskId,messageType:"failure", errorCode:errorCode, args:args]);
			return;
		}catch(Exception e){
			errorCode 		= e.message;
			response.status = 417;		
			render (template:'/payment/templates/common/authError',model:[taskId:params.taskId,messageType:"failure", errorCode:errorCode, args:args]);
			return;
		}
		/* Added to Handle Checker CASA Accounts Refresh in Menu after Successful Payment */
		session.setAttribute("actsumModel",null);
		render (template:'/payment/templates/common/authorized',model:[taskId:params.taskId]);
	}
	
	def rejectFundTransfer(){
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
		render (template:'/payment/templates/common/rejected',model:[taskId:params.taskId]); //template to be changed
	}
	
	
	def pushDatelineUrlParametersIntoGrailsParams(String datelineTaskIdentifier){
		DatelineTask task = datelineIBUtils.getDateLineService().getDatelineTaskById(Long.parseLong(datelineTaskIdentifier))
		URIBuilder builder = new URIBuilder(task.getTargetUrlParam());
		List<NameValuePair> parameters = builder.getQueryParams();
		for (NameValuePair parameter : parameters) {
			params.put(parameter.getName(), parameter.getValue());
		}
	}
	
	def saveasDraft(){
		render template:"/payment/templates/common/draftMsg", model:model;
	}
	
	
	
	///SI Starts
	def standingInstruction(){
		render view:"/payment/standingInstructions", model:model;       
	}
	
	def editSI(){
		if(SubModuleConstants.EXTERNAL_TRANSFER.equals(params.ttCode)){
			render view:"/payment/friendsandfamilypayment", model:model;
		}else if(SubModuleConstants.INTERNAL_TRANSFER.equals(params.ttCode)){  
			if(BusinessFunctionConstants.OWN_ACCOUNT_TRANS.equals(params.tstCode)){
				render view:"/payment/ownaccountpayment", model:model;
			} else if(BusinessFunctionConstants.CREDIT_CARD_TRANS.equals(params.tstCode)){
				render view:"/payment/creditcardpayment",model:model;
			} else if(BusinessFunctionConstants.WITHIN_BANK.equals(params.tstCode)){
				render view:"/payment/friendsandfamilypayment", model:model;  
			}
		}  
//		params.editUrl = 
//		redirect(action: "ownaccountpayment", params: [beneId: "557058"])     
//		chain(action: "ownaccountpayment", params:[beneId: "557058"],model:model)    
//		render view:"/payment/ownaccountpayment", params:params,model:model;    
	}
	def suspendStandingInstruction(){
		render template:"/payment/templates/standingInstruction/standingInstructionList",model:model;
	}
	def pendingTransactions(){
		render view:"/payment/pendingTransactions", model:model;
	}
	def viewPendingTransaction(){
		render template:"/payment/templates/pendingTransactions/viewPendingTransaction",model:model;
	}
	def discardPendingTransaction(){
		render template:"/payment/templates/pendingTransactions/pendingTransactionsList",model:model;
	}
	def executePendingTransaction(){
		redirect(controller:"security",action: "fetchPaymentSecurityAdvice")
	}
	def pendingTransactionsPage(){
		render template:"/payment/templates/pendingTransactions/pendingTransactionsContent",model:model;
	}
	
	def ccTransferExcessCredit() {
		render view:"/payment/ccardbalancetransfer",model:model;
	}
	
	def termsAndConditions(){
		render template:"/payment/templates/common/termsAndConditions",model:model;
	}
	
	
	def discardPaymentFavourite(){
		render "ok";
	}
	
}