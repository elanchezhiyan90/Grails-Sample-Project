package com.vayana.ib.retail.web.controller

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler
import org.springframework.security.core.context.SecurityContextHolder
import grails.util.GrailsUtil;

class ErrorsController {
	
	public static final String SERVER_ERROR_500 = "/errors/error500";     
    def error403() { 
		log.error("ErrorsController	: Action :error403")
		invokeForceLogout(request,response)
	}
	
	def error404() {
	
	}
	
	def error405() {
	
	}
	
	def error500() {
		log.error("ErrorsController	: Action : error500")
		//invokeForceLogout(request, response);
		if (GrailsUtil.isDevelopmentEnv()){
			render view:"deverror"
		}else{
			render view:"error500"
		}
	}
	
	def jsnotenabled(){
		render view:"errorjavascript404"
	}
	
	def securityerror(){
		render "Security Error";
	}
	
	def pgError(){
		
	}
	
	public void invokeForceLogout(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		  if (auth != null){
			 new SecurityContextLogoutHandler().logout(request, response, auth);
		  }
		SecurityContextHolder.getContext().setAuthentication(null);
	}
}
