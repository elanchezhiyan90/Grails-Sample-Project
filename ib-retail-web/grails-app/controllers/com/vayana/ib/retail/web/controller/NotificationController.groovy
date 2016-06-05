package com.vayana.ib.retail.web.controller

import com.vayana.ib.retail.web.controller.common.GenericController

class NotificationController extends GenericController {
	def notification(){
		render view:"/notification/notification",model:model;
	}
	def alerts(){
		render view:"/notification/alerts",model:model;
	}
	def inbox ={
		
	}
	def message ={
	
	}
	def notificationstatus(){
		render template:"/notification/templates/alertsNotifications",model:model;
	}
}
