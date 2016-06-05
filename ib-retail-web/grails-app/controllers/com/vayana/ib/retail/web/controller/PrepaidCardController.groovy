package com.vayana.ib.retail.web.controller

import com.vayana.ib.bm.core.api.model.enums.CreditCardTransactionTypeEnum
import com.vayana.ib.retail.web.controller.common.GenericController

class PrepaidCardController extends GenericController{
	def summary = {
	}

	def details = {		
		render view:"/prepaidCard/details",model:model;
	}
	
	def updateprepaidcardnickname(){
		render template:"/common/nickname", model:model;
	}
	
	def ministatement(){
		render view:"/prepaidCard/ministatement",model:model;
	}
	
	def detailedstatement()
	{
		render template:"/prepaidCard/templates/statement/contentdetail", model:model
	}
	def detailedstatementgotopage(){
		render template:"/prepaidCard/templates/statement/contentdetail", model:model
	}
}
