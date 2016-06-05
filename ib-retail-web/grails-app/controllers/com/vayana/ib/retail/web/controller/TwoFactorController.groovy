package com.vayana.ib.retail.web.controller

import com.vayana.ib.retail.web.controller.common.GenericController;

class TwoFactorController extends GenericController{
	
	def otpgeneration(){
		render template:"/twoFactor/templates/coreresponse", model:model;
	}
	
	def otpverification(){  	
		render "";
	}

}
