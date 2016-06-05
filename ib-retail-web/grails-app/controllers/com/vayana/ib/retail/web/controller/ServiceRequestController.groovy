package com.vayana.ib.retail.web.controller

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.core.api.exception.BusinessException;
import com.vayana.bm.infra.workflow.WorkflowService;
import com.vayana.dateline.ib.connector.DatelineIBUtils;
import com.vayana.dateline.model.DatelineTask;
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.common.BmClient

import org.activiti.engine.task.Task
import org.springframework.dao.DataAccessException;
import org.apache.http.NameValuePair
import org.apache.http.client.utils.URIBuilder

class ServiceRequestController extends GenericController {
	BmClient bmClient;
	WorkflowService workflowService;
	//Account Serive Request
	
	DatelineIBUtils datelineIBUtils;
	
	def showSRDetails(){
		render (template:params.viewUrl,model:model);
			
			//model:[resp:bmClient.workflowService.loadWorkflowPayload(params.processInstanceId)])
	}
	
	def serviceRequestMetaData(){
		render view:"/serviceRequest/serviceRequestMetaData",model:model;
		}
    def cancelServiceRequest(){
		render template:"/serviceRequest/templates/metadata",model:model;
	}
	def serviceRequestConfirm()
	{
		render template:"/serviceRequest/templates/metadataConfirm",model:model;        
	}
	def insertServicerequest(){
		render template:"/serviceRequest/templates/refnumber",model:model;     
	}
	
	def transactiontoEmi(){
		render template:"/serviceRequest/transactiontoEmi",model:model;
	
	}
	
	def transferToEmiConfirm(){
		render template:"/serviceRequest/templates/transactiontoEmiConfirm",model:model;
	}
	
	def cancelTransactionToEmi(){
		render template:"/serviceRequest/transactiontoEmi",model:model;  
	}
	
	
	def getBranchPickUp(){
		render template:"/serviceRequest/templates/branchpickup",model:model;     
	}
	def serviceRequestStatus(){
		render view:"/serviceRequest/serviceRequestStatus",model:model;  
     }       
	def viewserviceRequestDetails(){
		if(params.recordStatus.equals('PFA')){
			render(template:"/serviceRequest/templates/serviceRequestViewDetails",model:[genericSRModel:bmClient.workflowService.loadWorkflowPayload(params.processInstanceId)])
			}
		else if("REJECTED".equals(params.recordStatus)){
			render(template:"/serviceRequest/templates/serviceRequestViewDetails",model:[genericSRModel:bmClient.workflowService.getHistoricPayload(params.processInstanceId)])
			
			}    
	}
    def serviceRequestDetails(){
	render template:"/serviceRequest/templates/serviceRequestViewDetails",model:model;     
     }
	def serviceRequestFilter(){
		render template:"/serviceRequest/templates/serviceSRRequestStatus",model:model;      
	}
	
	def cancelServicerequests(){
		Task task = workflowService.getTaskByProcessInstanceId(params.processInstanceId);     
		Map<String,Object> taskVariables = new HashMap<String,Object>();
		String loggedInUser = "10020"//SecurityUtils.invoker.userLoginProfileId  
		String userComments = "Cancelled the Service Request by End User"   
		taskVariables.put("authorizeAction", "reject");        
		workflowService.completeTaskWithFormData(task?.getId(), taskVariables,loggedInUser,userComments);
		chain (action:"serviceRequestStatus" ,controller:"serviceRequest",model:model)            
		}
	
	def getBranchDisplay(){
		render view:"/serviceRequest/branchDisplayMain",model:model;
	}
	
	def getExchangerate(){
		render view:"/serviceRequest/exchangeRate",model:model;
	}
  
 

  def getBankTariff(){
	   render view:"/serviceRequest/bankTariff",model:model;
    }
  
  
  def termsAndConditions(){
	  render template:"/serviceRequest/templates/termsAndConditions",model:model;    
  }
  
  def showDatelineSRDetailsforEdit(){
	  println params.dump();
		  render view : "/serviceRequest/serviceRequestDatelineView", model:model;
  }
  
  def approvePreConfirm() {
	  render template:"/serviceRequest/templates/remarks",params:params,model:model;
  }
  def rejectPreConfirm() {
	  render template:"/serviceRequest/templates/remarks",params:params,model:model;
  }
  
  def approveServiceRequest(){
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
	  render (template:'/serviceRequest/templates/authorized',model:[taskId:params.taskId]);
  }
  
  def rejectServiceRequest(){
	  pushDatelineUrlParametersIntoGrailsParams(params?.datelineReferenceId);
	  println params.dump()
	  Map<String,Object> taskVariables = new HashMap<String,Object>();
	  String loggedInUser = SecurityUtils.invoker.userLoginProfileId
	  String rejectComments =params?.comments;
	  taskVariables.put("authorizeAction", "reject");
	  workflowService.completeTaskWithFormData(params.taskId, taskVariables,loggedInUser,rejectComments);
	  render (template:'/serviceRequest/templates/rejected',model:[taskId:params.taskId]); //template to be changed
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