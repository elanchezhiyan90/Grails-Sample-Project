package com.vayana.ib.retail.web.controller.common

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.beans.common.GenericResponseHeader
import com.vayana.bm.core.api.beans.common.InvocationSource
import com.vayana.bm.core.api.beans.common.Invoker

class GenericController {
  public static final String AJAX_ERROR = "/common/ajaxerror";
  def renderView(){
	  if (params.tenantPage){
		  render view:params.tenantPage
	  }
  }
  
  def getModel(){
  	return params.model;
  }
  
  protected StringBuffer getTenantFilePath(Map params){
	  def config = grailsApplication.getConfig()
	  String uploadFileLocation = config.fileUpload?.location;
	  Long ulpId = SecurityUtils.getUserLoginProfile().getId();
	  StringBuffer sb = new StringBuffer();
	  sb.append(uploadFileLocation).append(params.groupShortDescription).append("/").append(params.tenantShortDescription).append("/").append(ulpId).append("/");
	  return sb;
  }
  
  def messages()
  {
	  render template:"/common/ajaxsuccess"
  }
  
  protected GenericRequestHeader getRequestHeader(params){   
	  Invoker invoker = session?.invoker;
	  if (invoker == null){
		  invoker = SecurityUtils.getInvoker();
	  }
	  GenericRequestHeader requestHeader = new GenericRequestHeader();
	  def actionName = params.actionName;
	  def controllerName  = params.controllerName;
	  params.eventName	= actionName?actionName:"index";
	  requestHeader.invokedAt = new Date();
	  requestHeader.invocationSource = new InvocationSource(channelId:"RIB",controller:controllerName ,event:params.eventName, mediaType:"WEB");
	  requestHeader.invoker = invoker;
	  requestHeader.uniqueReferenceNumber = Math.random().toString();
	  return requestHeader;
  }
  
 protected  boolean hasErrorModel(Object obj){
	  boolean errorFound  = false;
	  if (GenericResponseHeader.SUCCESS.equals(obj.responseHeader?.ackStatus)){
		  errorFound = Boolean.FALSE;
	  }else{
		  errorFound = Boolean.TRUE;
	  }
	  return errorFound;
  }
 
 public void invokeForceLogout(HttpServletRequest request, HttpServletResponse response) {
	 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	   if (auth != null){
		  new SecurityContextLogoutHandler().logout(request, response, auth);
	   }
	 SecurityContextHolder.getContext().setAuthentication(null);
 }
 
 
 
}
