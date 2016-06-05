package com.vayana.ib.retail.web.service.common

import groovy.util.logging.Slf4j

import javax.servlet.http.HttpSession

import org.apache.commons.configuration.Configuration
import org.codehaus.groovy.grails.commons.GrailsApplication
import org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib
import org.codehaus.groovy.grails.web.metaclass.BindDynamicMethod
import org.codehaus.groovy.grails.web.plugins.support.WebMetaUtils
import org.codehaus.groovy.grails.web.servlet.FlashScope
import org.codehaus.groovy.grails.web.util.WebUtils
import org.slf4j.MDC
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.ui.ModelMap
import org.springframework.web.context.request.RequestContextHolder

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.common.utils.BeanUtils
import com.vayana.bm.core.api.beans.common.GenericRequest
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.beans.common.GenericResponse;
import com.vayana.bm.core.api.beans.common.Invoker
import com.vayana.bm.core.api.model.common.GenericEntity
import com.vayana.bm.core.api.model.user.UserLoginProfile
import com.vayana.ib.retail.web.service.common.ApplicationContextHolder

@Slf4j
class  GenericService {
	@Autowired
	ApplicationTagLib g;


	String DEFAULT_CREATED_MESSAGE = 'default.created.message';
	String DEFAULT_UPDATED_MESSAGE = 'default.updated.message';
	String DEFAULT_DELETED_MESSAGE = 'default.deleted.message';
	@Autowired
	GrailsApplication grailsApplication

	@Autowired
	Configuration appConfig;

	static transactional = false

	/*def setMessage(String code, List args, MessageType msgType, Map model){
		String message = "${g.message(code:code, args:args)}";
		model << [messageType:msgType.toString().toLowerCase() , message:message]
	}*/

	def setMessage(String code, List args, Map model){
		String message =  "${g.message(code:code, args:args)}";
		model << [messageType:"success", message:message]
	}

	
	def setError(GenericResponse responseObj ,  Map model ){
		String errorCode = responseObj.errorCode();
		Object[] args =  responseObj.getErrorArguments();
		String errorMessage =  "${g.message(code:errorCode, args:args)}";
		model << [messageType:"error", message:errorMessage]
	}
	

	def execute(Map params, GenericRequestHeader requestHeader, ModelMap model){
		def resp = null
		String eventName =  params.eventName;
		resp = this."$eventName"(params, requestHeader, model)
		return resp;
	}

	protected <T> T getBean(Class<T> requiredType, GenericRequestHeader requestHeader, Map params){
		GenericRequest requiredTypeObject = null;
		//Tenant Request Class Override -Beg
		//check if requiredType's Name (FQ ClassName) is found in configuration.
		String requestClassName = requiredType.name
		String tenantId = requestHeader?.invoker?.tenantShortDescription?.toLowerCase();

		if (tenantId){
			System.setProperty("TENANT_ID" , tenantId);
			MDC.put("TENANT_ID" , tenantId);
		}
		String tenantRequestObjectName =  appConfig.getString(requiredType.simpleName);
		if (tenantRequestObjectName){ //If Found
			log.info "FOUND Request Object Substitution for " + requestClassName + " value = " + tenantRequestObjectName;
			//Create a New Instance for Substituted Class.
			requiredTypeObject = Class.forName(tenantRequestObjectName).newInstance();
			//Check if the New Instance of requiredType
			/*if (requiredTypeObject instanceof T){
			 }else{ //Throw if New Instance is not of T Type
			 //throw new BusinessException(ContextCodeType.GENERAL,ErrorCodeConstants.UNSUPPORTED_REQUEST_OBJECT);
			 }*/
		}else{ //Substitution Request Object not found. so proceed to normal execution. get from Spring Context.
			requiredTypeObject = ApplicationContextHolder.getApplicationContext().getBean(requiredType)
		}
		//Tenant Request Class Override - End
		//Check the type again with GenericRequest
		if (requiredTypeObject instanceof GenericRequest){
			if (requestHeader == null){ // if requestHeader is null
				//create a new instance and assign invoker and set header
				requestHeader  = new GenericRequestHeader();
				Invoker invoker = getSession().getAttribute("invoker");
				if (invoker == null) {
					invoker = SecurityUtils.getInvoker();
				}
				requestHeader.setInvoker(invoker);
			}
			requiredTypeObject.requestHeader = requestHeader
			//check if params is null. do not populate params with the requestObject.
			if (params){
				this.populate(params, requiredTypeObject);
			}
		}
		return requiredTypeObject;
	}
	
	
	/**
	 * 
	 * @param requiredType
	 * @param beanName
	 * @param requestHeader
	 * @param params
	 * @return this method helps to get the bean by its ID
	 */
	protected <T> T getBean(Class<T> requiredType,String beanName, GenericRequestHeader requestHeader, Map params){
		GenericRequest requiredTypeObject = null;		
			requiredTypeObject = ApplicationContextHolder.getApplicationContext().getBean(beanName,requiredType)
		
		//Check the type again with GenericRequest
		if (requiredTypeObject instanceof GenericRequest){
			if (requestHeader == null){ // if requestHeader is null
				//create a new instance and assign invoker and set header
				requestHeader  = new GenericRequestHeader();
				Invoker invoker = getSession().getAttribute("invoker");
				if (invoker == null) {
					invoker = SecurityUtils.getInvoker();
				}
				requestHeader.setInvoker(invoker);
			}
			requiredTypeObject.requestHeader = requestHeader
			//check if params is null. do not populate params with the requestObject.
			if (params){
				this.populate(params, requiredTypeObject);
			}
		}
		return requiredTypeObject;
	}
	
	

	def getIdVersion(String idVersion)
	{
		return [
			idVersion?.split(",")[0].toLong() ,
			idVersion?.split(",")[1].toLong()
		]
	}

	def methodMissing(String name, args) {
		log.debug "MISSING METHOD in Class : " + this.getClass().getName() + " METHOD : " + name  + "  ARGS : " + args.toString()
	}


	def isAuthenticated(){
		return SecurityUtils.isAuthenticated();
	}

	Invoker getInvoker(){
		return SecurityUtils.getInvoker();
	}

	UserLoginProfile getUserLoginProfile(){
		return SecurityUtils.getUserLoginProfile();
	}

	def getSessionAttribute(String key){
		return getSession().getAttribute(key);
	}

	def setSessionAttribute(String key, Object value){
		return getSession().setAttribute(key,value);
	}

	def bindCommandObject={Object o , params  ->
		WebMetaUtils.enhanceCommandObject (ApplicationContextHolder.getApplicationContext(), o.class)
		BindDynamicMethod  bind = new BindDynamicMethod()
		def args =  [o, params]
		bind.invoke( o, 'bind', (Object[])args)
	}

	def validateCommandObject={Class clazz , params  ->
		def obj = clazz.newInstance();
		bindCommandObject(obj,params);
		obj.validate();
		return obj;
	}
	def bindFormCommandObject={Object i,Class clazz ->
		def propsMap = i.properties
		propsMap.remove('metaClass')
		propsMap.remove('class')
		def obj = clazz.newInstance();
		BindDynamicMethod  bind = new BindDynamicMethod()
		def args =  [obj, propsMap]
		bind.invoke( obj, 'bind', (Object[])args)
		return obj;
	}

	def generateId(){
		Long d = new Long(java.nio.ByteBuffer.wrap(
				UUID.randomUUID().toString().getBytes()).getLong());
		return d
	}

	def propCopy( src, clazz ) {
		[src.getClass(), clazz].declaredFields*.grep { !it.synthetic }.name.with { a, b ->
			clazz.metaClass.invokeConstructor( a.intersect( b ).collectEntries { [ (it):src[ it ] ] } )
		}
	}

	//call BM Commons BeanUtils.
	public Object populate(Map source, GenericRequest destination) {
		/*Map paramsMap = new HashMap()
		source.each {key, value ->
			paramsMap.put(key, value)
		}*/
		destination = BeanUtils.populate(source, destination)
//		destination.setRequestParams(paramsMap);
		return destination;
	}

	//call BM Commons BeanUtils.
	public <T> T populateEntity(Map source, Class<T> requiredType) {
		Map paramsMap = new HashMap()
		source.each {key, value ->
			paramsMap.put(key, value)
		}
		GenericEntity requiredTypeObject = null;
		String requestClassName = requiredType.name
		String tenantRequestObjectName =  appConfig.getString(requiredType.simpleName);
		if (tenantRequestObjectName){
			requiredTypeObject = Class.forName(tenantRequestObjectName).newInstance();
			requiredTypeObject = BeanUtils.populate(source, requiredTypeObject)
		}

		return requiredTypeObject;
	}

	public Object copyProperties(Object source, Object destination) {
		return BeanUtils.copyProperties(source, destination);
	}

	protected FlashScope flash(){
		def webUtils = WebUtils.retrieveGrailsWebRequest()
		def flashScope = webUtils.attributes.getFlashScope(webUtils.getRequest())
		return flashScope;

	}
	protected HttpSession getSession() {
		return RequestContextHolder.currentRequestAttributes().getSession(false)
	}
}