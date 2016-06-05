package com.vayana.ib.retail.web.controller

import com.vayana.ib.bm.core.api.model.enums.CreditCardTransactionTypeEnum
import com.vayana.ib.retail.web.controller.common.GenericController

class CreditCardController extends GenericController{
	def summary = {
	}

	def details = {		
		render view:"/creditCard/details",model:model;
	}
	
	def updatecreditcardnickname(){
		render template:"/common/nickname", model:model;
	}
	
	def statement(){
		render view:"/creditCard/statement", model:model
	}
	
	def ministatement(){
		render view:"/creditCard/ministatement", model:model
	}
	
	def detailedstatement(){
		render template:"/creditCard/templates/statement/contentdetail", model:model
	}
	
	def statementgotopage(){
		render template:"/creditCard/templates/statement/contentdetail", model:model
	}
	
	def statementfilter(){
				
		if(model.transactionType.equals(CreditCardTransactionTypeEnum.BILL.toString())){
		  	render template:"/creditCard/templates/statement/currentmonthtransactionsummary", model:model
		}else if(model.transactionType.equals(CreditCardTransactionTypeEnum.UNBILL.toString())){
			render template:"/creditCard/templates/statement/unbilledtransactionfiltersummary", model:model
		}else if(model.transactionType.equals(CreditCardTransactionTypeEnum.PEN.toString())){
			render template:"/creditCard/templates/statement/pendingtransactionfiltersummary",model:model;
		}
	}
	
	
	def converttoemi(){
		render template:"/creditCard/templates/statement/converttoemi"
	}
	
	def currentstatement(){
		
		if(model.transactionType.equals(CreditCardTransactionTypeEnum.BILL.toString())){			
			render template:"/creditCard/templates/statement/currenttransactionsummary",model:model;
		}else if(model.transactionType.equals(CreditCardTransactionTypeEnum.UNBILL.toString())){		
			render template:"/creditCard/templates/statement/unbilledtransactionsummary",model:model;
		}else if(model.transactionType.equals(CreditCardTransactionTypeEnum.PEN.toString())){		
			render template:"/creditCard/templates/statement/pendingtransactionsummary",model:model;
		}
	}
	
}
