package com.vayana.ib.retail.web.controller

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

import org.apache.http.NameValuePair
import org.apache.http.client.utils.URIBuilder
import org.springframework.dao.DataAccessException
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler

import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.infra.workflow.WorkflowService;
import com.vayana.dateline.ib.connector.DatelineIBUtils;
import com.vayana.dateline.model.DatelineTask
import com.vayana.ib.bm.core.api.model.enums.TwoFactorTypeEnum		
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.DematService
import com.vayana.bm.common.security.SecurityUtils

class DematController extends GenericController{
	
	
	private @Value('${ib.demat.service.url}') String dematServiceUrl;
	
	def DematService dematService;

	def demat(){

		//String loginParams 		= dematService.getLoginRequestParams();
		String loginParams 		= dematService.getDematEncryption();
		//String dematsession 		= request.getSession().getId();
		//String loggedInUsersession = SecurityUtils.invoker?.sessionId
		def redirectLoginReqUrl;
	//	println "POST SESSION DEMAT ::" +request.getSession().getId();
	//	println "loggedInUsersession ::" +SecurityUtils.invoker?.sessionId
		if(loginParams != null){
			redirectLoginReqUrl = dematServiceUrl.concat(loginParams)
			//response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
			render template:"/servicerequest/templates/demattwofaView",model:[dematModel:redirectLoginReqUrl];
//			redirect(url: redirectLoginReqUrl,permanent:true);
			//invokeForceLogout(request, response);

		}
		/*if(dematsession.equals(loggedInUsersession)){
		//	redirect(url: redirectLoginReqUrl)				
			invokeForceLogout(request, response);


		}*/else{
			logger.info( "------------------------------------------")
			logger.error( "-----Error while redirectLoginReqUrl -----")
			logger.info( "-------------------------------------")
			forward(controller:"demat",action:"dematLoginException", model:[responseModel:"login-failed"])
		}
	}
	def invokeAppLogout(){

		invokeForceLogout(request, response);
	}

	def dematLoginException(){

	}
	

	
	def dematView(){
		//render template:"/servicerequest/templates/demattwofa",model:model;
		render view:"/servicerequest/dematView",model:model;
	}
	
	 def demattwofaView(){
		render template:"/servicerequest/templates/demattwofaView",model:[dematModel:redirectLoginReqUrl];
	  }
  
		
}
