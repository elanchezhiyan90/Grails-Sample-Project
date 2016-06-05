package com.vayana.ib.retail.web.controller
class TenantController {

    def index() { 
		
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		if (ipAddress == null) {
			ipAddress = request.getRemoteAddr();
		}
		log.info("Client IP -ADDRESS : " +  ipAddress);
		
 		params.groupId="40000";
		params.tenantShortDescription="PMCB";
		params.tenantApplicationId="50000";                
		forward(controller:"user",action: "index",params:params)
	}	
	
	def tenantlogin() {
	
	}
	def relogin() {
		redirect(uri: "/tenant/index")
	}
	
}
