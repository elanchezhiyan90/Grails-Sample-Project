package com.vayana.ib.retail.web.context

import javax.servlet.ServletContext
import javax.servlet.ServletContextEvent
import javax.servlet.ServletContextListener
import javax.servlet.http.HttpSession
import javax.servlet.http.HttpSessionEvent
import javax.servlet.http.HttpSessionListener

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.ApplicationContext

import com.vayana.bm.common.context.AppContext
import com.vayana.bm.common.utils.CollectionUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.impl.service.UserServiceImpl
import com.vayana.ib.retail.web.service.common.BmClient

class WebApplicationEventListener implements ServletContextListener, HttpSessionListener {
	
	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		println "Session Created..."
		HttpSession    sessionObject 	= 	arg0.getSession();
		ServletContext context 			= 	sessionObject.getServletContext();
		HashMap contextSessionInfoMap 	=   (HashMap)context.getAttribute("contextSessionInfoMap");
		if(CollectionUtils.isEmpty(contextSessionInfoMap)){
			contextSessionInfoMap 		=  	new HashMap();
		}		
		contextSessionInfoMap.put(sessionObject.getId(), sessionObject);
		context.setAttribute("contextSessionInfoMap", contextSessionInfoMap);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		println "Session Destroyed..."
		HttpSession    sessionObject 	= arg0.getSession();
		ServletContext context 			= sessionObject.getServletContext();
		HashMap contextSessionInfoMap 	= (HashMap)context.getAttribute("contextSessionInfoMap");
		contextSessionInfoMap.remove(sessionObject.getId());
		println "Session ID="+sessionObject?.getId()
		CommonRequest req 	= 	new CommonRequest();
		req.setAttribute("SESSION_ID", sessionObject.getId());
		//req.setAttribute("LOGOUT_TYPE", sessionObject.getId());
		ApplicationContext appCtx 	= AppContext.getApplicationContext();
		UserServiceImpl userService = appCtx.getBean("userService",UserServiceImpl.class);
		CommonResponse res			= userService.updateLogoutDetails(req);		
	}
	
	
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		println "Context Initialized..."
		ServletContext context 			= arg0.getServletContext();
		HashMap contextSessionInfoMap 	= new HashMap();
		context.setAttribute("contextSessionInfoMap", contextSessionInfoMap);
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		println "Context Destroyed..."
		//Remove contextSessionInfoMap
	}

}
