package com.vayana.ib.retail.web.controller

import com.vayana.ib.retail.web.controller.common.GenericController


class PortfolioController extends GenericController{
	
	def portfoliomaster() {
		
		render view:"/portfolio/portfoliomaster",model:model;
	}			
	def preferredCurrencyChange(){
		render template:"/portfolio/templates/portfoliosummary",model:model;
	}
}
