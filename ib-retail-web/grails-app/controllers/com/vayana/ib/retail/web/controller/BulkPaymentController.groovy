package com.vayana.ib.retail.web.controller

import grails.converters.JSON

import com.vayana.bm.infra.workflow.WorkflowService
import com.vayana.dateline.ib.connector.DatelineIBUtils
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.BulkPaymentService
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.FileUploadService
import com.vayana.ib.retail.web.taglibs.exception.FileUploadException

class BulkPaymentController extends GenericController{
	
	BmClient bmClient;
	
	DatelineIBUtils datelineIBUtils;
	
	WorkflowService workflowService;
	
	FileUploadService fileUploadService;
	
	BulkPaymentService bulkPaymentService;

	/* ---------------------SME Bulk Payment Starts -----------------------*/
	def smeBulkPayment(){
		if(params?.gotoPage){
			render template:"/bulkPayment/templates/smeBulkPayment/reviewHeaderList",model:model;
		}else{
		render view:"/bulkPayment/smeBulkPayment", model:model;
		}
	}

	def paymentFileUpload(){
		log.info("--------------------------------------------------------------");
		log.info("Starting paymentFileUpload");
		try {
			bulkPaymentService.prepareFileForProcess(request, params);
			return render(text: [success:true] as JSON, contentType:'text/json')
			log.info("--------------------------------------------------------------");
		} catch (FileUploadException e) {
			log.error("File Upload Failed...");
			return render(text: [success:false] as JSON, contentType:'text/json')
		}
	}
	
	def bulkPaymentFileSubmit(){
		//render template:"/bulkPayment/templates/smeBulkPayment/fileSubmitReference",model:model;
	}
	
	def validateSalaryPayment(){
		render template:"/bulkPayment/templates/smeBulkPayment/paymentok", model:model;
	}
	
	def validateVendorPayment(){
		render template:"/bulkPayment/templates/smeBulkPayment/paymentok", model:model;
	}
		
	def bulkpaymentPostProcess()
	{
		render template:"/bulkPayment/templates/smeBulkPayment/paymentConfirm",model:model;
	}
	
	def uploadBulkPaymentFile(){
		render template:"/bulkPayment/templates/smeBulkPayment/fileSubmitReference",model:model;
	}
	
	def showBulkFileContent(){
		render template:"/bulkPayment/templates/smeBulkPayment/reviewFileContent",model:model;
	}
	
	def proceedForApproval(){
		render template:"/bulkPayment/templates/smeBulkPayment/fileSubmitReference",model:model;
	}
	
	def discardBulkPaymentTransaction(){
		render template : "/bulkPayment/templates/smeBulkPayment/reviewHeaderList",model:model;
	}
	
	def showBulkPaymentDetails(){
		
		render view : params.editUrl, model:model;
	
	}
	
	def showBulkPaymentDatelineDetails(){
		
		render template : "/bulkPayment/templates/smeBulkPayment/bulkPaymentDatelineViewSubDetails",model:model;
	
	}
	
	def authReviewFileContentDetails(){
		
		render template : "/bulkPayment/templates/smeBulkPayment/authReviewFileContentDetails",model:model;
	
	}
	
	
	
	
	def deleteBulkPaymentTransaction(){
		render template : "/bulkPayment/templates/smeBulkPayment/reviewHeaderList",model:model;
	}
	
	def bulkPaymentDatelineView()
	{
		render template:"/bulkPayment/templates/smeBulkPayment/bulkPaymentDatelineView",params:params,model:model;
	}
	
	def approveBulkPaymentPreConfirm() {
		render template:"/bulkPayment/templates/smeBulkPayment/remarks",params:params,model:model;
	}
	def rejectBulkPaymentPreConfirm() {
		render template:"/bulkPayment/templates/smeBulkPayment/remarks",params:params,model:model;
	}
	
	def approveBulkPayment(){
		log.info("Starting approveBulkPayment... Params="+params?.dump());
		if(model.messageType!=null && model.messageType.equalsIgnoreCase("success"))
		{
			render (template:'/bulkPayment/templates/smeBulkPayment/authorized',model:[taskId:params.taskId]);
		}
		else if(model.messageType!=null && model.messageType.equalsIgnoreCase("failure"))
		{
			response.status = 417;
			render (template:'/payment/templates/common/authError',model:[taskId:params.taskId,messageType:"failure", errorCode:model.errorCode, args:model.args]);
		} 
		
	}
	
	def rejectBulkPayment(){
		log.info("Starting approveBulkPayment... Params="+params?.dump());
		if(model.messageType!=null && model.messageType.equalsIgnoreCase("success"))
		{
			render (template:'/bulkPayment/templates/smeBulkPayment/rejected',model:[taskId:params.taskId]);
		}
		else if(model.messageType!=null && model.messageType.equalsIgnoreCase("failure"))
		{
			response.status = 417;
			render (template:'/payment/templates/common/authError',model:[taskId:params.taskId,messageType:"failure", errorCode:model.errorCode, args:model.args]);
		} 
	}
	
	def exchangeRateAndLimit () {
		render template:"/bulkPayment/templates/smeBulkPayment/balanceandexgrate", model:model;
	}
	
	def termsAndConditions(){
		render template:"/bulkPayment/templates/smeBulkPayment/termsAndConditionsBulkPayment",model:model;
	}
		
	/*------------------- SME Bulk Payment Ends----------------------- */
	
}
