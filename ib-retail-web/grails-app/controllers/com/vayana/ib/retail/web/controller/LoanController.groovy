package com.vayana.ib.retail.web.controller

import com.vayana.ib.retail.web.controller.common.GenericController;

class LoanController extends GenericController{
	
	def details() {
		render view:"/loan/details",model:model;
	}	
	
	def updateaccountnickname(){
		render template:"/common/nickname", model:model;
	}
	
	def statement(){
		render view:"/loan/statement",model:model;
	}
	
	def detailedStatement(){
		render template:"/loan/templates/statement/contentdetail", model:model
	}
	
	
	def detailedstatementgotopage(){
		render template:"/loan/templates/statement/contentdetail", model:model
	}
	
	def statementfilter(){
		render template:"/loan/templates/statement/contentdetail", model:model
	}
}
