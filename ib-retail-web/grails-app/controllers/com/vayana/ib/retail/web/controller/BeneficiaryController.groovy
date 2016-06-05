package com.vayana.ib.retail.web.controller

import com.vayana.bm.core.api.constants.BusinessFunctionConstants;
import com.vayana.ib.retail.web.controller.common.GenericController;
import com.vayana.ib.retail.web.service.common.BmClient;
import com.vayana.ib.bm.core.api.beans.beneficiary.BeneficiaryInstructionResponse

class BeneficiaryController extends GenericController {
	
	BmClient bmClient
	
	def getBeneficiaryDetails()
	{
		render view:"/beneficiary/updateBeneficiary",model:model;
	}
	
	def benePhoto()
	{
		response.outputStream << model.benePhoto
	}
	
	def editBeneficiary()
	{
		render (view:"/beneficiary/updateBeneficiary",model:model);
	}
	
	def loadsearchBankForm()
	{
		model << [bankType:params?.bankType,payType:params?.payType]
		render template:"/beneficiary/templates/instructions/banksearch" , model:model;
	}
	
	def searchBankDetails()
	{
		print "${params.bankType}" 
		render (template:"/beneficiary/templates/instructions/banksearchList",model:model);
	}
	
	
	def insertBeneficiary()
	{
		render (template:"/beneficiary/templates/beneficiaryAccounts",model:model);
	}
	def showBeneInsDetails(){
		if ("BENE_INS".equals(params.transactionIdentifier)&& "IB".equals(params.dataSource)) {  
		render template:params.viewUrl, model:model;  
		}   
		if("BENE_INS".equals(params.transactionIdentifier)&& "WF".equals(params.dataSource)){          
			render (template:params.viewUrl,
				model:[resp:bmClient.workflowService.loadWorkflowPayload(params.processInstanceId)])
			}                        
	}
	
	def assignBeneInstruction()
	{
		render (template:"/beneficiary/templates/beneficiaryAccounts",model:model);
	}
	
	
	def insertBeneficiaryLimit()
	{
		render (template:"/beneficiary/templates/beneficiarylimitDetails",model:model);
	}
	
	def updateBeneficiaryLimit()
	{
		render (template:"/beneficiary/templates/beneficiarylimitDetails",model:model);
	}
		
	def limitInsertionTag()
	{
		if(model.beneficiaryLimitTypes)	{		
			render  template:"/beneficiary/templates/instructionlimitdtl",model:model;
		}
		
	}
	def updateBeneficiary()
	{		
		render (template:"/beneficiary/templates/beneficiaryAccountsEdit",model:model);		
	}	

	def editBeneficiaryInstruction()
	{
		render template:"/beneficiary/templates/addBeneficiaryInstruction",params:params, model:model;
	}
	
	def beneficiaryInstructionConfirm()
	{
		
		render template:"/beneficiary/templates/instructions/beneficiaryInstructionConfirm", model:model;
	}
	
	def addBeneficiaryInstruction(){
		
		render template:"/beneficiary/templates/addBeneficiaryInstruction",model:model,params:params;
	}
		
	def selectTransactionSubType()
	{
		render template:"/beneficiary/templates/instructions/beneTransactionSubType",params:params ,model:model ;
	}
	
	def displayBeneInstructionInput()
	{
		BeneficiaryInstructionResponse benInsResponse = model.beneInsRespone;
		String beneInsTemplate = benInsResponse.getBeneInstructionTemplate();
		if(beneInsTemplate.equals(BusinessFunctionConstants.OVERSEAS_PAYMENT))
		{
			render template:"/beneficiary/templates/instructions/SWIFTtemplate",params:params ,model:model;
		}
		else if(beneInsTemplate.equals(BusinessFunctionConstants.LOCAL_TRANSFER))
		{
			render template:"/beneficiary/templates/instructions/LOCALtemplate",params:params ,model:model;
		}
		else if(beneInsTemplate.equals(BusinessFunctionConstants.WITHIN_BANK))
		{
			render template:"/beneficiary/templates/instructions/TPTtemplate",params:params ,model:model;
		}
		else if(beneInsTemplate.equals(BusinessFunctionConstants.NEFT))
		{
			render template:"/beneficiary/templates/instructions/NEFTtemplate",params:params ,model:model;
		}
		else if(beneInsTemplate.equals(BusinessFunctionConstants.RTGS))
		{
			render template:"/beneficiary/templates/instructions/RTGStemplate",params:params ,model:model;
		}
//		else if(beneInsTemplate.equals("SARIE"))
//		{
//			render template:"/beneficiary/templates/instructions/SARIEtemplate",params:params ,model:model;
//		}
		else if(beneInsTemplate.equals(BusinessFunctionConstants.CREDIT_CARD_TRANS))
		{
			render template:"/beneficiary/templates/instructions/creditCardTemplate",params:params ,model:model;
		}
		else if(beneInsTemplate.equals(BusinessFunctionConstants.IMPSP2P))
		{
			render template:"/beneficiary/templates/instructions/IMPSP2Ptemplate",params:params ,model:model;
		}
		
		else if(beneInsTemplate.equals(BusinessFunctionConstants.IMPSP2M))
		{
			render template:"/beneficiary/templates/instructions/IMPSP2Mtemplate",params:params ,model:model;
		}
		else if(beneInsTemplate.equals(BusinessFunctionConstants.IMPSP2A))
		{
			render template:"/beneficiary/templates/instructions/IMPSP2Atemplate",params:params ,model:model;
		}
		else if(beneInsTemplate.equals(BusinessFunctionConstants.IMPSP2U))
		{
			render template:"/beneficiary/templates/instructions/IMPSP2Utemplate",params:params ,model:model;
		}
		else{
			
			render template:"/beneficiary/templates/instructions/benePaymentMode",model:model,params:params;
			
		}
	}
	
	

	def insertBeneficiaryInstruction()
	{
		render template:"/beneficiary/templates/beneficiaryAccountDetails",model:model;		
	}	
	
	def updateBeneficiaryInstruction()
	{
		render template:"/beneficiary/templates/beneficiaryAccountDetails",model:model;		
	}
	
	def enableBeneficiary(){
		render template:"/beneficiary/templates/updateBeneficiary",model:model;
	}
	
	def disableBeneficiary(){
		render template:"/beneficiary/templates/updateBeneficiary",model:model;
	}
	
	def updateBeneInstructionStatus(){
		render template:"/beneficiary/templates/beneficiaryAccountDetails",model:model;
	}
	
	def confirmBeneficiaryStatusUpdate(){
		render template:"/beneficiary/templates/confirmStatusUpdate",model:model;
	}
	
	def beneficiaryDetails()
	{
		render (template:"/beneficiary/templates/beneficiaryDetails",model:model);
	}
	
	def beneficiaryAccounts()
	{
		render (template:"/beneficiary/templates/beneficiaryAccounts",model:model);    
	}
	
	def beneficiaryAccountsEdit()
	{
		render (template:"/beneficiary/templates/beneficiaryAccountsEdit",model:model);
	}
	
	def beneficiaryLimits()
	{
		render (template:"/beneficiary/templates/beneficiarylimitDetails",model:model);
	}
	
	def listBeneficiaryInstructions()
	{
		render(template:"/beneficiary/templates/beneficiaryAccountsEdit",model:model)
	}
	
	def viewBeneficiaryInstruction(){
		if(params.recordStatus.equals('PFA')){
			render(template:"/beneficiary/templates/instructions/beneficiaryinstructionwfview",model:[resp:bmClient.workflowService.loadWorkflowPayload(params.processInstanceId)])
			}else if("REJECTED".equals(params.recordStatus)){
			render(template:"/beneficiary/templates/instructions/beneficiaryinstructionwfview",model:[resp:bmClient.workflowService.getHistoricPayload(params.processInstanceId)])
			
			}
	}
	
	def getValidAccount()
	{
		render(template:"/beneficiary/templates/instructions/TPTtemplateDetails",model:model)
	}
	
	def getValidCreditCard()
	{
		render(template:"/beneficiary/templates/instructions/creditCardTemplateDetails",model:model)
	}
	
	
	def addBeneficiary() {	   
		render (view:"/beneficiary/beneficiaryMain",model:model);
	}
	
	
	def addBeneMain(){
		render view:"/beneficiary/addBeneficiary",model:model;
	}
	
	
	///// Quick Pay
	def loadQuickPay(){
		render view:"/beneficiary/quickPay",model:model;      
	}
	def loadSearchBankCode(){
		model << [bankType:params?.bankType]
		render template:"/beneficiary/templates/quickPay/banksearch" , model:model;
	}
	def searchBankCodeDetails(){
		render (template:"/beneficiary/templates/instructions/banksearchList",model:model);  
	}
	def validateAccountNumber() {
		render template:"/beneficiary/templates/quickPay/currencyReadOnly",model:model;
	}
	def validateCreditCardNumber(){
		render template:"/beneficiary/templates/quickPay/currencyReadOnly",model:model;
	}
	
	def loadTenantApplicationCurrency(){
		render template:"/beneficiary/templates/quickPay/tenantApplicationCurrency",model:model;
	}
	def pay(){
		render template:"/common/dummy",model:model;
	}
	def saveAndPay(){
		render template:"/common/dummy",model:model;
	}
	def saveAndPaySuccess(){
		params.beneId = model.beneId;
		render view:"/payment/friendsandfamilypayment",params:params,model:model;
	}
	def paySuccess(){
		params.beneId = model.beneId;
		params.isQuickPay = model.isQuickPay;
		params.beneShortName = model.beneShortName
		render view:"/payment/friendsandfamilypayment",params:params,model:model;
	}
	
	def showTermsAndConditions(){
		render (template:"/beneficiary/templates/instructions/termsAndConditions",model:model);
	}
}
