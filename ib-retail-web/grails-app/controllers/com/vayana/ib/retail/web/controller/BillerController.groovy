package com.vayana.ib.retail.web.controller

import com.vayana.ib.bm.core.api.service.BillerService;
import com.vayana.ib.retail.web.controller.common.GenericController;

class BillerController extends GenericController{
	
	def details(){		render view :"/biller/details", model:model;	}
	
	def addBiller(){
		render view :"/biller/addBiller", model:model;
	}
	
	def getParentBillerCompany(){
		if (!model.errors){
			render template:"/biller/templates/addbiller/parentbillercompany", model:model;
		}
	}
	
	def getParentBillerMetaData(){		
		if (!model.errors){
			if(model.BillerDetailsModel?.billers){
				render template:"/biller/templates/addbiller/subbillercompany", model:model;
			}
			else{
				render template:"/biller/templates/addbiller/metadatafields", model:model;
			}
		}
	}
	
	def getBillerServiceMetaData(){
		render template:"/biller/templates/addbiller/metadatafields", model:model;
	}
	
	def getSubBillerMetaData(){
		if (!model.errors){
			render template:"/biller/templates/addbiller/metadatafields", model:model;
		}
	}

	def addBillerConfirm(){
		if (!model.errors){
			render template:"/biller/templates/addbiller/billerSuccessResponse", model:model;
		}
	}
		def getBillerInstructiondetails(){
		if (!model.errors){
			render template:"/biller/templates/details/instructiondetails", model:model;
		}
	}
	
	def updateBillerInstructionStatus(){
		if (!model.errors){
			render template:"/biller/templates/details/billerInstructionsTable", model:model;
		}
	}
	def updateBillerStatus(){
		if (!model.errors){
			render template:"/biller/templates/details/statusUpdate", model:model;
		}
	}
	
	def updateBillerConfirm(){
		if (!model.errors){
			render template:"/biller/templates/details/billerInstructionsTable", model:model;
		}
	}
	
	def addInstruction(){
		if (!model.errors){
			render template:"/biller/templates/addInstruction/addInstruction", model:model;
		}
	}
	
	def getautopayfields(){
		render template:"/biller/templates/addbiller/autopayfields",model:model;
	}
	
	def getBillerServices(){
		if (!model.errors){
			render template:"/biller/templates/addbiller/billerServices", model:model;
		}
	}
	
	def validateBillerInstruction(){
		render template:"/biller/templates/addbiller/billerInstructionconfirm", model:model;
	}
	
	def validateWithinBillerInstruction(){
		render template:"/biller/templates/addInstruction/withinBillerInstructionConfirm", model:model;
	}
	
	def addWithinBillerConfirm(){
		if (!model.errors){
			render template:"/biller/templates/details/billerInstructionsTable", model:model;
		}
	}
	
	def validateeditBillerInstruction(){
		render template:"/biller/templates/details/editBillerInstructionConfirm", model:model;
	}
	
	def saveAndPayBillerInstruction(){
		render template:"/common/dummy",model:model; 
	}
	
	def saveAndPaySuccess(){
		params.beneId = model.billerId;
		params.billerInsId = model.billerInsId;
		params.buttonEvent = model.buttonEvent;
		render view:"/billPayment/billpayment",params:params,model:model;
	}
	
}
