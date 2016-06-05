package com.vayana.ib.retail.web.controller

import com.vayana.ib.retail.web.controller.common.GenericController;

class ApplyLoanController extends GenericController{
	
	def addLoanRequest() {
	//	render template:"/applyLoan/templates/addLoanRequest"
		
	}	
	
	def propertydetails(){
		render template:"/applyLoan/templates/propertydetails",model:model;
	}
	def savepropertydetails(){
		render template:"/applyLoan/templates/incomedetails",model:model;  
		
	}
	def saveincomedetails(){
		render template:"/applyLoan/templates/loaneligibility",model:model;
		
	}
	
	def saveloneeligibility(){

	    render template:"/applyLoan/templates/loanapplicationstatus",model:model;
	    
		
	}
	
	def saveloanstatus()
	{
		render template:"/applyLoan/templates/loanstatus",model:model;
	}
	
	
	def displayincomedetails()
	{
		render template:"/applyLoan/templates/incomedetails",model:model;
	}
	def displayloaneligibility(){
		
		render template:"/applyLoan/templates/loaneligibility";
	}
	
	def displayloanstatus(){
		render template:"/applyLoan/templates/loanapplicationstatus1",model:model;   
	}
	
	def showApplyLoanDetails(){
		render (template:params.viewUrl,model:model);
	}
	
}