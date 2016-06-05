package com.vayana.ib.retail.web.filter

import groovy.util.logging.Slf4j

import javax.servlet.ServletContext
import javax.servlet.http.HttpServletRequest

import org.apache.log4j.MDC
import org.codehaus.groovy.grails.commons.ApplicationAttributes
import org.codehaus.groovy.grails.commons.GrailsApplication
import org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib
import org.springframework.beans.BeansException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.ApplicationContext
import org.springframework.dao.DataAccessException
import org.springframework.ui.ModelMap

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.core.api.beans.common.ContextCodeType;
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.beans.common.InvocationSource
import com.vayana.bm.core.api.beans.common.Invoker
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.InterfaceException;
import com.vayana.ib.retail.web.controller.ErrorsController;
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.common.GenericService
import com.vayana.bm.core.api.exception.InterfaceException;



import org.springframework.util.StringUtils;

@Slf4j
class BusinessManagerFilters {
	def GrailsApplication grailsApplication

	private static final String ERROR_CONTROLLER_NAME = 'errors'
	private static final String SERVERERROR_ACTION_NAME = 'error500'
	private static final String NOTFOUND_ACTION_NAME = 'error404'
	private static final String FORBIDDEN_ACTION_NAME = 'error403'

	private static final String GROUP_DESCRIPTION = 'RIB'
	private static final String MEDIA_TYPE = 'WEB'
	
	private static final String FAILURE = 'failure'
	
	@Autowired
	ApplicationTagLib g;
	
	def simpleCaptchaService
	
	private boolean skipPage(controllerName, actionName) {
		def isErrorPage = ERROR_CONTROLLER_NAME.equals(controllerName)
		isErrorPage || !controllerName
	}

	def filters = {
		all(controller:'*', action:'*') {
			before = {
				if (!controllerName) return true
				if (controllerName == "errors") return true
				if (!skipPage(controllerName, actionName)) {
					//create a ModelMap object if it doesn't exist
					ModelMap model = new ModelMap();
					params.actionName = actionName;
					params.controllerName = controllerName;

					Invoker invoker = prepareInvoker(request, params);
					MDC.put 'userName', invoker.loginId ?: 'ANON'
					GenericRequestHeader requestHeader = prepareRequestHeader(invoker,params);
					checkPageOverrides(params);
					try{
//						validateCaptcha(params,model); This is blocikng the IE Version Browsers
						invoker = requestHeader?.getInvoker();
						if (invoker.isSessionExists){
							params.lang = invoker.getLocale().toString();
						}

						executeService(servletContext, requestHeader, model, params);
						response.status = 200;

						//command object errors
						if(model?.errors){
							response.status = 417;
							if (request.xhr){
								render template:GenericController.AJAX_ERROR , model:model;
								return false;
							}
						}
						
						String modelMessage = model.message;
						if (modelMessage != null){
							flash.success = modelMessage
						}
						params.model = model;

					}catch(BeansException beex){
						log.error "BEAN EXCEPTION ::: " + beex.message;
						//beex.printStackTrace();
					}catch(BusinessException bex){
						response.status = 417;
						log.error "BUSINESS EXCEPTION ::: " + bex.message;
						String errorCode = bex.getErrorCode();
						Object[] args =  bex.getArguments();
						model << [messageType:"failure", errorCode:errorCode, args:args]
						println model.dump();
						render template:GenericController.AJAX_ERROR, model:model
						/*if (request.xhr){
							render template:GenericController.AJAX_ERROR, model:model
						}else{
							render view:ErrorsController.SERVER_ERROR_500,model:model
						}*/    
						return false;
					}catch(InterfaceException iex)
					{
						iex.printStackTrace();  
						response.status = 417;
						String errorCode = iex.getErrorCode();   
						String interfaceExpClassName = iex.getClass().getName();
						log.error "INTERFACE EXCEPTION ::: " +interfaceExpClassName;
						Object[] args =  null;
						model << [messageType:"failure", errorCode:errorCode, args:args]
						render template:GenericController.AJAX_ERROR, model:model
						/*if (request.xhr){
							render template:GenericController.AJAX_ERROR, model:model
						}else{
							render view:ErrorsController.SERVER_ERROR_500,model:model
						}*/
						return false;
					}catch(DataAccessException dax){
						response.status = 417;
						String dataAccessExceptionClassName=dax.getClass().getName();
						log.error "DATAACCESS EXCEPTION ::: " +dataAccessExceptionClassName;
						Object[] args =  null;
						model << [messageType:"failure", errorCode:dataAccessExceptionClassName, args:args]
						render template:GenericController.AJAX_ERROR, model:model
						/*if (request.xhr){
							render template:GenericController.AJAX_ERROR, model:model
						}else{
							render view:ErrorsController.SERVER_ERROR_500,model:model
						}*/
						return false;
					}
					
					catch(Exception ex){
						  ex.printStackTrace();
						response.status = 417;
						log.error "500 INTERNAL ERROR ::: " + ex.getClass().getName();
						Object[] args =  null;
						model << [messageType:"failure", errorCode:"ERR-500"]
						render template:GenericController.AJAX_ERROR, model:model
						/*if (request.xhr){
							render template:GenericController.AJAX_ERROR, model:model
						}else{
							render view:ErrorsController.SERVER_ERROR_500,model:model
						}*/
						return false;
					}
				}
			}
			after = {Map model ->
				//println "AFTER CALLED"
				response.addHeader("X-FRAME-OPTIONS", "SAMEORIGIN")
			//	response.setHeader("Pragma", "no-cache");
			//	response.setDateHeader("Expires", 1L);
			//	response.setHeader("Cache-Control", "no-cache");
			//	response.addHeader("Cache-Control", "no-store");
				if (!controllerName) return true
				if (controllerName == "errors") return true
				if (!skipPage(controllerName, actionName)) {
					if (!model){
						model = new ModelMap();
					}
					ModelMap ibModel = params.model;
					ibModel.each{
						model.put(it.key, it.value);
					}
					//model << [tenantId:params.tenantId]
				}
			}
			afterView = {Exception e ->
				MDC.remove 'userName'
			}
		}
	}

	private Invoker prepareInvoker(HttpServletRequest request, Map params){
		Long  groupId = null;
		String tenantShortDescription , groupShortDescription = null
		Invoker invoker = null;
		if (SecurityUtils.isAuthenticated()){
			invoker = SecurityUtils.getInvoker();
		}else{
			invoker = request.getSession().getAttribute("invoker");
		}
		String lang = null;
		if (invoker){
			lang = invoker.locale.toString();
		}else{
			invoker = new Invoker();
			lang = request.getLocale().toString();
			invoker.setLocale(request.getLocale());
			invoker.tenantShortDescription = params.tenantShortDescription
			invoker.groupId = params.groupId?.toLong()
			invoker.groupShortDescription = GROUP_DESCRIPTION
			invoker.tenantApplicationId = params.tenantApplicationId?.toLong()
			if (params.tenantShortDescription){
				//set only if tenantShortDescription is set.
				request.getSession().setAttribute("invoker", invoker);
			}
		}

		params.tenantShortDescription = invoker.tenantShortDescription
		params.groupId = invoker.groupId
		params.groupShortDescription = invoker.groupShortDescription
		params.themeName = 	invoker.themeName
		params.lang = lang;
		//Set the Captcha
		params.captcha = request.getParameter("captcha");
		params.hidcaptchaflag = request.getParameter("hidcaptchaflag")
		invoker.workStationIP = request.remoteAddr
		invoker.xforwardedFor = request.getHeader("x-forwarded-for")
		invoker.userAgent = request.getHeader("user-agent")
		invoker.sessionId = request.getSession().getId().toString();
		invoker.isAdmin = false;
		return invoker;
	}

	private GenericRequestHeader prepareRequestHeader(Invoker invoker, Map params){
		GenericRequestHeader requestHeader = new GenericRequestHeader();
		def actionName = params.actionName;
		def controllerName  = params.controllerName;
		params.eventName	= actionName?actionName:"index";
		requestHeader.invokedAt = new Date();
		requestHeader.invocationSource = new InvocationSource(channelId:GROUP_DESCRIPTION,controller:controllerName ,event:params.eventName, mediaType:MEDIA_TYPE);
		requestHeader.invoker = invoker;
		requestHeader.uniqueReferenceNumber = Math.random().toString();
		return requestHeader;
	}
	
	def validateCaptcha(Map params,ModelMap model) throws BusinessException
	{
		String showCaptcha = "showcaptcha." + params.tenantShortDescription?.toLowerCase() +"."+ params.controllerName + "." + params.eventName
		String validateCaptcha = "validatecaptcha." + params.tenantShortDescription?.toLowerCase() +"."+ params.controllerName + "." + params.eventName
		def showCaptchaFlag = grailsApplication.getFlatConfig().get(showCaptcha);
		def validateCaptchaFLag = grailsApplication.getFlatConfig().get(validateCaptcha);
		params.showCaptcha = showCaptchaFlag
		if(validateCaptchaFLag && params.hidcaptchaflag && params.hidcaptchaflag.equals("true"))
		{
			
			boolean captchaValid = simpleCaptchaService.validateCaptcha(params.captcha)
			if(!captchaValid)
			{
				log.error "CAPTCHA VALIDATION ERROR ::: ";
				String errorCode="invalid.captcha.error";
				throw new BusinessException(ContextCodeType.GENERAL, errorCode);
			}
		}
		 
	}

	private void checkPageOverrides(Map params){
		String pageFullName =  "tenants." + params.tenantShortDescription?.toLowerCase() + "." + params.controllerName + "." + params.eventName
		def pageFullNameOverrideValue =  grailsApplication.getFlatConfig().get(pageFullName)
		pageFullName = "/" + pageFullName.replace(".", "/")
		if ("y".equals(pageFullNameOverrideValue)) {
			params.found = "true"
			params.tenantPage = pageFullName
		}else{
			params.found = "false"
			params.tenantPage = params.eventName
		}
	}

	private void executeService(ServletContext servletContext , GenericRequestHeader requestHeader, ModelMap model,  Map params) throws BeansException{
		ApplicationContext ctx = servletContext.getAttribute(ApplicationAttributes.APPLICATION_CONTEXT)
		String tenantId = requestHeader?.invoker?.tenantShortDescription?.toLowerCase();
		if (tenantId){
			System.setProperty("TENANT_ID", tenantId);
			MDC.put("TENANT_ID", tenantId);
		}
		if (params.controllerName){
			Object serviceBean = ctx.getBean(params.controllerName + "Service")
			if (serviceBean instanceof GenericService){
				GenericService service =  (GenericService) serviceBean
				service.execute(params , requestHeader, model)
			}
		}
	}
}







/*println "request.method : " + request.method
 println "URI : " + request.requestURI
 println "Controller : " + controllerName
 println "Action : " + actionName
 println "Protocol : " + request.protocol
 println "Host : " + request.getHeader("host")
 println "Server port : " +  request.getServerPort()
 println "user-agent : " + request.getHeader("user-agent")
 println "accept-language : " + request.getHeader("accept-language")
 println "accept : " + request.getHeader("accept")
 println "cookie : " + request.getHeader("cookie")
 println "Remote Address : " + request.remoteAddr
 println "x-forwarded-for : " + request.getHeader("x-forwarded-for")
 println "Scheme : " + request.scheme
 println "New Session : " + session.isNew()
 println "Session ID: " + session.id
 println "Session Creation Time : " + new Date(session.getCreationTime())
 println "Session Last Access Time : " + new Date(session.getLastAccessedTime())
 println("Requested session ID from cookie: " +
 request.isRequestedSessionIdFromCookie());
 println("Requested session ID from URL: " +
 request.isRequestedSessionIdFromUrl());
 println("Requested session ID valid: " +
 request.isRequestedSessionIdValid());
 println "Environment.current : " + Environment.current*/



