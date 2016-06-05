package com.vayana.ib.retail.web.service
import org.springframework.social.connect.Connection
import org.springframework.social.connect.ConnectionFactoryLocator
import org.springframework.social.connect.ConnectionRepository
import org.springframework.social.connect.UserProfile
import org.springframework.util.Assert
import org.springframework.util.MultiValueMap

import com.vayana.bm.common.security.SecurityUtils;

class SocialConnectService {
  ConnectionRepository connectionRepository
  ConnectionFactoryLocator connectionFactoryLocator

  static transactional = false

  Set<String> registeredProviderIds() {
	connectionFactoryLocator.registeredProviderIds()
  }

  MultiValueMap<String, Connection<?>> findAllConnections() {
	verifyCurrentUser()
	connectionRepository.findAllConnections()
  }

  Boolean isCurrentUserConnectedTo(String providerId) {
	connectionRepository?.findConnections(providerId)?.size() > 0
  }

  List<UserProfile> getUserProfile(String providerId) {
	verifyCurrentUser()
	connectionRepository.findConnections(providerId)*.fetchUserProfile()
  }

  private void verifyCurrentUser() {
	Assert.isTrue(SecurityUtils.isAuthenticated(), "There is no current user loggedId")
  }
}