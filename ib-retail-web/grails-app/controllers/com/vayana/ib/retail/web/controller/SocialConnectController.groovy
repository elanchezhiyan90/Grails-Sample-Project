package com.vayana.ib.retail.web.controller

import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
import org.springframework.social.connect.ConnectionFactoryLocator
import org.springframework.social.connect.ConnectionKey
import org.springframework.social.connect.ConnectionRepository
import org.springframework.social.connect.DuplicateConnectionException
import org.springframework.social.connect.web.ConnectSupport
import org.springframework.util.Assert
import org.springframework.util.LinkedMultiValueMap
import org.springframework.util.MultiValueMap
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.RequestAttributes;
import org.codehaus.groovy.grails.commons.GrailsApplication

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.infra.social.connect.web.SocialConnectWebSupport;

class SocialConnectController {

	private static final String DUPLICATE_CONNECTION_EXCEPTION_ATTRIBUTE = "_duplicateConnectionException"
	private static final String DUPLICATE_CONNECTION_ATTRIBUTE = "social.addConnection.duplicate"

	ConnectionFactoryLocator connectionFactoryLocator
	ConnectionRepository connectionRepository

	SocialConnectWebSupport webSupport = new SocialConnectWebSupport("http://localhost:9090/ib-retail-web/socialConnect/oauthCallback?providerId=facebook");
	static allowedMethods = [connect: 'POST', oauthCallback: 'GET', disconnect: 'DELETE']
	GrailsApplication grailsApplication
	
	def connect = {
		String result
		if (SecurityUtils.isAuthenticated()) {
			def providerId = params.providerId
			Assert.hasText(providerId, "The providerId is required")
			def connectionFactory = connectionFactoryLocator.getConnectionFactory(providerId)
			MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
			def nativeWebRequest = new GrailsWebRequest(request, response, servletContext)
			result = webSupport.buildOAuthUrl(connectionFactory, nativeWebRequest, parameters)
			println result;
			redirect url: result
		} else {
			if (log.isWarnEnabled()) {
				log.warn("The connect feature only is available for Signed Users. New users perhaps can use SignIn feature.")
			}
			//TODO: Document this parameters
			result = session.ss_auth_loginFromUrl ?: "/user/login"
			redirect uri: result
		}
	}

	def oauthCallback = {
		def providerId = params.providerId

		Assert.hasText(providerId, "The providerId is required")

		def config = grailsApplication.config.get(providerId)
		def denied = params.denied

		if (denied) {
			def uriRedirectOnDenied = session.ss_oauth_redirect_callback_on_denied ?: config.page.deniedHome
			if (log.isInfoEnabled()) {
				log.info("The user has denied accesss to ${providerId} profile. Redirecting to uri: ${uriRedirectOnDenied}")
			}
			redirect(uri: uriRedirectOnDenied)
			return
		}

		def uri = "http://localhost:9090/ib-retail-web/home/homepage"

		def connectionFactory = connectionFactoryLocator.getConnectionFactory(providerId)
		def nativeWebRequest = new GrailsWebRequest(request, response, servletContext)
		def connection = webSupport.completeConnection(connectionFactory, nativeWebRequest)

		addConnection(connection, connectionFactory, nativeWebRequest)
		redirect(uri: uri)
	}

	def disconnect = {
		def providerId = params.providerId
		def providerUserId = params.providerUserId
		Assert.hasText(providerId, "The providerId is required")

		if (providerUserId) {
			if (log.isInfoEnabled()) {
				log.info("Disconecting from ${providerId} to ${providerUserId}")
			}
			connectionRepository.removeConnection(new ConnectionKey(providerId, providerUserId));
		} else {
			if (log.isInfoEnabled()) {
				log.info("Disconecting from ${providerId}")
			}
			connectionRepository.removeConnections(providerId)
		}

		def cfg = grailsApplication.config.get(providerId)

		//TODO: Document this parameter
		def postDisconnectUri = params.ss_post_disconnect_uri ?: cfg.postDisconnectUri
		if (log.isInfoEnabled()) {
			log.info("redirecting to ${postDisconnectUri}")
		}
		redirect(uri: postDisconnectUri)
	}

	private void addConnection(connection, connectionFactory, NativeWebRequest request) {
		try {
			connectionRepository.addConnection(connection)
		} catch (DuplicateConnectionException e) {
			request.setAttribute(DUPLICATE_CONNECTION_ATTRIBUTE, e, RequestAttributes.SCOPE_SESSION)
		}
	}
}
