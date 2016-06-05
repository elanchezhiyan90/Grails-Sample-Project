package com.vayana.ib.retail.web.controller

import org.springframework.social.connect.ConnectionKey
import org.springframework.social.connect.ConnectionRepository;

import org.springframework.social.facebook.api.Facebook
import org.springframework.social.facebook.api.FacebookProfile;
import org.springframework.ui.ModelMap;

class SocialConnectFacebookController {
	Facebook facebook
	ConnectionRepository connectionRepository

	def beforeInterceptor = [action: this.&auth, except: 'login']

	def index = {
		def model = ["profile": facebook.userOperations().getUserProfile()]
		render(view: "index", model: model)
	}
	def profilePhoto = {
		response.outputStream << facebook.userOperations().getUserProfileImage()
	}
	def feed = {
		def model = ['feed': facebook.feedOperations().getFeed()]
		render(view: "feed", model: model)
	}

	def update = {
		def message = params.id ?: params.message
		facebook.feedOperations().updateStatus(message);
		redirect(action: feed)
	}

	def friends = {
		def friendsProfiles = facebook.friendOperations().getFriendProfiles();
		session.setAttribute("FBPROFILES", friendsProfiles)
		def model = ["friends": friendsProfiles]		
		render(view: "friends", model: model)
	}

	def albums = {
		def model = ["albums": facebook.mediaOperations().getAlbums()]
		render(view: "albums", model: model)
	}

	def album = {
		def albumId = params.id ?: params.albumId
		def model = [:]
		model.album = facebook.mediaOperations().getAlbum(albumId)
		model.photos = facebook.mediaOperations().getPhotos(albumId)

		render(view: "album", model: model)
	}

	def login = { render(view: "connect") }

	def auth() {
		if (!isConnected()) {
			redirect(action: 'login')
			return false
		}
	}

	Boolean isConnected() {
		connectionRepository.findPrimaryConnection(Facebook)
	}
	
	def friendDetail()           
	{
		List<FacebookProfile> facebookProfiles=(List<FacebookProfile>)session.getAttribute("FBPROFILES")    
		session.removeAttribute("FBPROFILES") 
		def facebookProfileId=params?.friendId	
		println params.dump()
		for(FacebookProfile facebookProfile:facebookProfiles)
		{
			if(facebookProfile.id.equals(facebookProfileId))
			{	session.setAttribute("FBPROFILE", facebookProfile)
				chain(action:'addBeneficiary',controller:'beneficiary')
				break;
			}
		}
		
	}
}

