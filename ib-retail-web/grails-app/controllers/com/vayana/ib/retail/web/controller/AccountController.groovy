package com.vayana.ib.retail.web.controller

import com.vayana.ib.retail.web.controller.common.GenericController


class AccountController extends GenericController{
	def details() { 
		render view:"/account/details", model:model;
	}
	
	def ministatement()
	{
		render view:"/account/ministatement", model:model
	}
	
	def detailedstatement()
	{
		render template:"/account/templates/statement/contentdetail", model:model
	}
	
	def updateaccountnickname(){
		render template:"/common/nickname", model:model;
	}
	
	def detailedstatementgotopage(){
		render template:"/account/templates/statement/contentdetail", model:model
	}
	
	def fetchChequeImage(){
		render template:"/account/templates/statement/chequeImage", model:model
	}
}
