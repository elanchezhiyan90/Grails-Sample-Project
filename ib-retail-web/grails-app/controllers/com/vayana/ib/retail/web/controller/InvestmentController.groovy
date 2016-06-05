package com.vayana.ib.retail.web.controller

import com.vayana.bm.infra.workflow.WorkflowService;
import com.vayana.ib.retail.web.controller.common.GenericController;
import com.vayana.ib.retail.web.service.common.BmClient;

class InvestmentController extends GenericController {
	BmClient bmClient;
	WorkflowService workflowService;
	
	def details() {
		render view:"/investment/details",model:model;
	}
	
	def updateaccountnickname(){
		render template:"/common/nickname", model:model;
	}
	
	def statement(){
		render view:"/investment/statement", model:model
	}
			
	def detailedstatement(){
		render template:"/investment/templates/statement/contentdetail", model:model
	}
	
	def detailedstatementgotopage(){
		render template:"/investment/templates/statement/contentdetail", model:model
	}
	
	def statementfilter(){
		render template:"/investment/templates/statement/contentdetail", model:model
	}
	def addDepositAccount(){
		render view:"/investment/openNewDeposit", model:model     
	}
	def openNewDeposit() {
		
	}
	
	def showBranch(){
		render template:"/investment/templates/openDeposit/branch",model:model;
	}
	
	def showDepositTypeDetails(){
		render template:"/investment/templates/openDeposit/depositTypeDetails",model:model;
	}
	def showHomeBranch(){
		model<< [custBranch:params?.custBranch]
		render template:"/investment/templates/openDeposit/customerBranch",model:model;
	}
	
	def validateOpenNewDeposit(){
		render template:"/investment/templates/openDeposit/deposit", model:model
	}
	
	def openNewDepositConfirm(){
		render template:"/investment/templates/openDeposit/investConfirm", model:model
	}
	
	def investLaterPreConfirm()
	{
		render template:"/investment/templates/openDeposit/investLater",model:model;
	}
	
	def recurringPreConfirm()
	{
		render template:"/investment/templates/openDeposit/recurring",model:model;
	}
	def insertOpenNewDeposit(){
		render template:"/investment/templates/openDeposit/refnumber",model:model;
	}
	def cancelOpenDepositRequest(){
		//render view:"/investment/openNewDeposit",model:model;
		//forward (controller:'investment',action:'addDepositAccount')
		chain (action:"investment" ,controller:"addDepositAccount",model:model)
		
	}
	def showOpenNewDeposit(){
		
		render (template:params.viewUrl,
			model:[resp:bmClient.workflowService.loadWorkflowPayload(params.processInstanceId)])
	}
	
	def termsAndConditions(){
		render template:"/investment/templates/openDeposit/termsAndConditions",model:model;
	}
}


