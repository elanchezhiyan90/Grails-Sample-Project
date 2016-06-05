package com.vayana.ib.retail.web.controller

import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
import org.springframework.util.Assert
import com.vayana.bm.infra.social.connect.web.SocialConnectWebSupport;
import com.vayana.bm.infra.social.signin.SimpleSignInAdapter
import org.codehaus.groovy.grails.commons.GrailsApplication;
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
import org.springframework.social.connect.Connection
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.connect.web.ConnectSupport;
import org.springframework.social.connect.web.ProviderSignInAttempt
import org.springframework.util.Assert
import org.springframework.web.context.request.RequestAttributes


class SocialConnectSignInController {
	ConnectionFactoryLocator connectionFactoryLocator
	ConnectionRepository connectionRepository
	def signInService
	UsersConnectionRepository usersConnectionRepository
	def requestCache
	ConnectSupport webSupport = new SocialConnectWebSupport("http://localhost:9090/ib-retail-web/home/homepage");
	static allowedMethods = [signin: 'POST', oauthCallback: 'GET', disconnect: 'DELETE']
	GrailsApplication grailsApplication
	
	def signin = {
	  def providerId = params.providerId
  
	  Assert.hasText(providerId, "The providerId is required")
  
	  def connectionFactory = connectionFactoryLocator.getConnectionFactory(providerId)
	  GrailsWebRequest nativeWebRequest = new GrailsWebRequest(request, response, servletContext)
	  def url = webSupport.buildOAuthUrl(connectionFactory, nativeWebRequest)
	  redirect url: url
	}
  
	def oauthCallback = {
	  def providerId = params.providerId
  
	  Assert.hasText(providerId, "The providerId is required")
  
	  def nativeWebRequest = new GrailsWebRequest(request, response, servletContext)
	  def config = grailsApplication.config.get(providerId)
  
	  def connectionFactory = connectionFactoryLocator.getConnectionFactory(providerId);
	  def connection = webSupport.completeConnection(connectionFactory, nativeWebRequest);
	  def url = handleSignIn(connection, nativeWebRequest, config);
	  redirect url: url
	}
  
	private String handleSignIn(Connection connection, GrailsWebRequest request, config) {
	  String result
	  List<String> userIds = usersConnectionRepository.findUserIdsWithConnection(connection)
	  if (userIds.size() == 0) {
		if (log.isDebugEnabled()) {
		  log.debug("No user found in the repository, creating a new one...")
		}
		ProviderSignInAttempt signInAttempt = new ProviderSignInAttempt(connection, connectionFactoryLocator, usersConnectionRepository)
		request.setAttribute(ProviderSignInAttempt.SESSION_ATTRIBUTE, signInAttempt, RequestAttributes.SCOPE_SESSION)
		//TODO: Document this setting
		result = request.session.ss_oauth_redirect_on_signIn_attempt ?: config.page.handleSignIn
	  } else if (userIds.size() == 1) {
		if (log.isDebugEnabled()) {
		  log.debug("User found in the repository...")
		}
		usersConnectionRepository.createConnectionRepository(userIds.get(0)).updateConnection(connection)
		SimpleSignInAdapter signInAdapter = new SimpleSignInAdapter(requestCache)
		def originalUrl = signInAdapter.signIn(userIds.get(0), connection, request)
		if (log.isDebugEnabled()) {
		  log.debug("originalUrl: ${originalUrl}")
		}
		//TODO: Document this setting
		result = originalUrl ?: config.postSignInUrl
	  } else {
		if (log.isErrorEnabled()) {
		  log.error("Multiple Users found in the repository...")
		}
		//TODO: handle redirect when multiple users found
		//result = redirect(URIBuilder.fromUri(signInUrl).queryParam("error", "multiple_users").build().toString());
	  }
	  result
	}
  }