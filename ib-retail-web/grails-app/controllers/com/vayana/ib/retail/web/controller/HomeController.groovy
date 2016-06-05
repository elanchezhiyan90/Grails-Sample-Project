package com.vayana.ib.retail.web.controller

import com.vayana.ib.retail.web.controller.common.GenericController;

class HomeController extends GenericController{

	def changelocale = {
		println "POST SESSION ::" +request.getSession().getId();
		render view:"/home/homepage",model:model;
	}
	
	
	def homepage = {
		println "POST SESSION ::" +request.getSession().getId();
		if(model?.messageType && "failure".equals(model?.messageType)){
			invokeForceLogout(request,response);
			render view:"/errors/error500",model:model;
		}else{
			render view:"/home/homepage",model:model;
		}
	}
	
	def creditcardsummary() {
		render template:"/home/templates/portfolio/creditcards",model:model;
	}
	
	def accountsummary() {
		render template:"/home/templates/portfolio/availablebalances",model:model;
	}
	
	def ownaccounts() {
		render template:"/home/templates/sendmoney/ownaccounts",model:model;
	}
	
	def prepaidcardsummary() {
		render template:"/home/templates/portfolio/prepaidcards",model:model;
	}
	
	def loansummary() {
		render template:"/home/templates/portfolio/loans",model:model;
	}
	
	def investmentsummary() {
		render template:"/home/templates/portfolio/investments",model:model;
	}
	
	def depositsummary() {
		render template:"/home/templates/portfolio/deposits",model:model;
	}
	
	def owncreditcards(){
		render template:"/home/templates/sendmoney/owncreditcards",model:model;
	}
	
	def prepaidcards(){
		render template:"/home/templates/sendmoney/prepaidcards",model:model;
	}
	
	def loans(){
		render template:"/home/templates/sendmoney/loans",model:model;
	}
	
	def friendsandfamily() {
		render template:"/home/templates/sendmoney/friendsandfamily",model:model;
	}
	
	def billDesk(){
		render template:"/home/templates/sendmoney/billpay",model:model;
	}
	
	def investments() {
		render template:"/home/templates/sendmoney/investments",model:model;
	}
	
	def standingInstructions(){
		render template:"/home/templates/sendmoney/standingInstructions",model:model;
	}
	
	def pendingTransactions(){
		render template:"/home/templates/sendmoney/pendingTransactions",model:model;
	}
	
	def keepalive()
	{
		render "OK";
	}
	
	
	def exit() {
		System.exit(0)
	}
	
	def smeBulkPayment(){
		render template:"/home/templates/sendmoney/smeBulkpayment",model:model;
	}
}
