package com.vayana.ib.retail.web.service

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.ui.ModelMap

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.beans.common.Invoker
import com.vayana.bm.core.api.exception.BusinessException;
import com.vayana.ib.retail.web.service.common.GenericService


class TenantService  extends GenericService{
	
	@Autowired
	SessionRegistryImpl sessionRegistry;
	
	def index(Map params,  GenericRequestHeader requestHeader, ModelMap model) {
		for (Object username: sessionRegistry.getAllPrincipals()) {
			if(username!=null)
			{
				log.info(username?.invoker?.loginId);
				String sessionId = session?.id;
				if(sessionId!=null && !sessionId.equals(""))
				{
					sessionRegistry.removeSessionInformation(sessionId);
				}
			}
			
		  }
	}
	
	def tenantlogin(Map params,  GenericRequestHeader requestHeader, ModelMap model) {
		
	}	
	
}
