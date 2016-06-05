package com.vayana.ib.retail.web.controller

import grails.converters.JSON

import org.apache.http.NameValuePair
import org.apache.http.client.utils.URIBuilder

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.infra.workflow.WorkflowService;
import com.vayana.dateline.api.DateLineFilterType
import com.vayana.dateline.ib.connector.DatelineIBUtils
import com.vayana.dateline.ib.connector.IBEventType;
import com.vayana.dateline.model.DatelineTask
import com.vayana.ib.bm.core.api.model.enums.TransactionTypeEnum;
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.bm.core.api.constants.BusinessFunctionConstants

class DatelineController extends GenericController {
	
	DatelineIBUtils datelineIBUtils;
	
	BmClient bmClient;	
	
	WorkflowService workflowService;
	
	
	def addreminder(){
		render template:"/dateline/templates/addreminder", model:model;
	}
	
	def index(){
		chain action:'dateline', params:params
	}
	
	def datelineTaskAsJson(){
		
		String userLoginProfileId = SecurityUtils.getUserLoginProfile().getId().toString();
		
		List allTasks = datelineIBUtils.getDateLineService().getAllTasksForUser(userLoginProfileId,DateLineFilterType.ALL);
		
		def events = 
			   allTasks.collect {				
				[
					id: it.id,
					title: it.taskDescription,
					start: it.eventDate.format('yyyy-MM-dd')				
				]
			}
		render events as JSON	
	}
	
	
	def dateline() {		
		String userLoginProfileId 	= SecurityUtils.getUserLoginProfile().getId().toString();
		try{
		render (view:'dateline',model:[todayTaskList:datelineIBUtils.getDateLineService().getAllTasksForUser(userLoginProfileId,DateLineFilterType.TODAY),
			pastTaskList:datelineIBUtils.getDateLineService().getAllTasksForUser(userLoginProfileId,DateLineFilterType.PAST),
			futureTaskList:datelineIBUtils.getDateLineService().getAllTasksForUser(userLoginProfileId,DateLineFilterType.FUTURE)]);
		}catch(Exception e){
			log.info("!!!Dateline Exception!!!!");
			render (view:'datelineNotAvailable',model:model);
		}		
	}
	
	def getDatelineTaskByFilter() {
		String userLoginProfileId 	= SecurityUtils.getUserLoginProfile().getId().toString();
		render (template:'/dateline/templates/datelineContent',model:[todayTaskList:datelineIBUtils.getDateLineService().getAllTasksForUserByFilter(userLoginProfileId,DateLineFilterType.TODAY,params.sortBy,params.searchText),
			pastTaskList:datelineIBUtils.getDateLineService().getAllTasksForUserByFilter(userLoginProfileId,DateLineFilterType.PAST,params.sortBy,params.searchText),
			futureTaskList:datelineIBUtils.getDateLineService().getAllTasksForUserByFilter(userLoginProfileId,DateLineFilterType.FUTURE,params.sortBy,params.searchText)]);
	}
		
	def showTaskDetails(){		
		pushDatelineUrlParametersIntoGrailsParams(params.taskValue);
		DatelineTask task = datelineIBUtils.getDateLineService().getDatelineTaskById(Long.parseLong(params.taskValue))	
		//params.put("dtype", task.dtype); 
		if(task != null && params.transactionIdentifier?.equals("FT") || params.transactionIdentifier?.equals("FT_SI") || params.transactionIdentifier?.equals("SI_HEADER")){		
			chain action: "showPaymentDetails", controller: "payment", params:params
		}else if(task != null && params.transactionIdentifier?.equals("SR")){
			chain action: "showSRDetails", controller: "serviceRequest", params:params
		}else if(task != null && params.transactionIdentifier?.equals("SR_GOAL")){
			chain action: "showUserGoalDetails", controller: "goal", params:params
		}	
		else if(task != null && params.transactionIdentifier?.equals("BENE_INS")){
			chain action: "showBeneInsDetails", controller: "beneficiary", params:params
		} 
		
		else if(task != null && params.transactionIdentifier?.equals("APPLYLOAN_REQUEST")){
			chain action: "showApplyLoanDetails", controller: "applyLoan", params:params
		} else if(task != null && params.transactionIdentifier?.equals("APPLYINVESTREQUEST")){
			chain action: "showOpenNewDeposit", controller: "investment", params:params
		}else if(task != null && params.transactionIdentifier?.equals(IBEventType.BULK_PAY.toString())){
			chain action: "bulkPaymentDatelineView", controller: "bulkPayment", params:params
		} 	
	}
	
	def editSITransaction(){
		pushDatelineUrlParametersIntoGrailsParams(params.id);
		DatelineTask task = datelineIBUtils.getDateLineService().getDatelineTaskById(Long.parseLong(params.id))
		params.put("dtype", task.dtype);
		if("SR".equals(params.transactionIdentifier))
		{
			chain action:"showDatelineSRDetailsforEdit",controller:"serviceRequest",params:params;
		}
		else if(TransactionTypeEnum.PG_PAYMENT.toString().equals(params.subTransactionIdentifier)){
			chain action: "showPaymentOriginPage", controller: "billPayment", params:params
	   }
		else if(TransactionTypeEnum.BILLPAYMENT.toString().equals(params.subTransactionIdentifier)){			
			 chain action: "showPaymentOriginPage", controller: "billPayment", params:params
		}else if(TransactionTypeEnum.OWNACCTRNS.toString().equals(params.subTransactionIdentifier) 	|| 
				TransactionTypeEnum.TPTTRANS.toString().equals(params.subTransactionIdentifier) 		||
				TransactionTypeEnum.INTCC.toString().equals(params.subTransactionIdentifier) 		|| 
				TransactionTypeEnum.LOANPAYEMI.toString().equals(params.subTransactionIdentifier) 	||
				TransactionTypeEnum.INTCC.toString().equals(params.subTransactionIdentifier) 		||
				TransactionTypeEnum.OVTRANS.toString().equals(params.subTransactionIdentifier) 		||
				TransactionTypeEnum.INVSTPAY.toString().equals(params.subTransactionIdentifier) 	||
				TransactionTypeEnum.NEFT.toString().equals(params.subTransactionIdentifier) 		||
				TransactionTypeEnum.RTGS.toString().equals(params.subTransactionIdentifier)       	||
				BusinessFunctionConstants.IMPSP2P.toString().equals(params.subTransactionIdentifier)||    
				BusinessFunctionConstants.IMPSP2A.toString().equals(params.subTransactionIdentifier)){              
				chain action: "showPaymentOriginPage", controller: "payment", params:params //getPaymentOriginDetail
		}else if("REM_FT".equals(params.subTransactionIdentifier)){
			chain action: "showMakePaymentPage", controller: "payment", params:params
		}else if("REM_BP".equals(params.subTransactionIdentifier)){   
			chain action: "showMakePaymentPage", controller: "billPayment", params:params
		}
		else if("BULK_PAYMENT".equals(params.subTransactionIdentifier)){
				chain action: "showBulkPaymentDetails", controller: "bulkPayment", params:params
		}		
	}
		
	def pushDatelineUrlParametersIntoGrailsParams(String datelineTaskIdentifier){
		DatelineTask task = datelineIBUtils.getDateLineService().getDatelineTaskById(Long.parseLong(datelineTaskIdentifier))
		URIBuilder builder = new URIBuilder(task.getTargetUrlParam());
		List<NameValuePair> parameters = builder.getQueryParams();
		for (NameValuePair parameter : parameters) {
			params.put(parameter.getName(), parameter.getValue());
		}
	}
	
	def setAlarm(){
		render template:"/dateline/templates/alarm", model:model;
	}
	
	def sendMessage(){
		render template:"/dateline/templates/message", model:model;
	}
	
	def authorizeTask(){
		pushDatelineUrlParametersIntoGrailsParams(params.id);
		println params.dump()
		Map<String,Object> taskVariables = new HashMap<String,Object>();
		String loggedInUser = SecurityUtils.invoker.userLoginProfileId
		taskVariables.put("authorizeAction", "approve");
		workflowService.completeTaskWithFormData(params.taskId, taskVariables,loggedInUser,params.userComments);
		render (template:'templates/authorized',model:[taskId:params.taskId]);
	}
	
	def rejectAtAuthorization(){
		pushDatelineUrlParametersIntoGrailsParams(params.id);
		println params.dump()
		Map<String,Object> taskVariables = new HashMap<String,Object>();
		String loggedInUser = SecurityUtils.invoker.userLoginProfileId
		taskVariables.put("authorizeAction", "reject");
		workflowService.completeTaskWithFormData(params.taskId, taskVariables,loggedInUser,params.userComments);
		render (template:'templates/authorized',model:[taskId:params.taskId]); //template to be changed
	}
	
	def removeTaskFromDateline(){ 
		if(params.removeTaskId){
			datelineIBUtils.getDateLineService().purgeTask(params.removeTaskId?.toLong());
		}
		render "OK"
	}
	
}
