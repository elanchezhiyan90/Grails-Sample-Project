package com.vayana.ib.retail.web.taglibs

import com.vayana.ib.retail.web.service.SocialConnectService;

class SocialConnectTagLib {
	SocialConnectService socialConnectService
	
	  static namespace = 'social'
	  static returnObjectForTags = ['registeredProviderIds', 'isCurrentUserConnectedTo', 'currentUserProfilesToService']
	
	  def registeredProviderIds = {
		socialConnectService.registeredProviderIds()
	  }
	
	  def isCurrentUserConnectedTo = {attrs, body ->
		socialConnectService.isCurrentUserConnectedTo(attrs.providerId)
	  }
	
	  def currentUserProfilesToService = {attrs, body ->
		socialConnectService.getUserProfile(attrs.providerId)
	  }
	}
	