package com.vayana.ib.retail.web.service

import org.springframework.ui.ModelMap

import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.ib.bm.core.api.beans.notification.NotificationRequest
import com.vayana.ib.bm.core.api.beans.notification.NotificationResponse
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class NotificationService extends GenericService{

	    BmClient bmClient;
		
		def notification(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		 	NotificationRequest notificationRequest = getBean(NotificationRequest.class, requestHeader,params)
			NotificationResponse notificationResponse = bmClient.notificationService.getAllNotifications(notificationRequest);
			model << [notificationsModel:notificationResponse.getAlertNotifyRecipients(),
				messageModel:notificationResponse.getUserMessages(),
				totalAlertsCount:notificationResponse.getTotalAlerts(),
			    totalUnreadMessages:notificationResponse.getTotalUnreadMessages()]
			
	    }
		def notificationstatus(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
			
			NotificationRequest notificationRequest = getBean(NotificationRequest.class, requestHeader,params);
			notificationRequest.setAlertNotifyRecepientId(params.alertnonifyreceiptId);
			NotificationResponse notificationResponse = bmClient.notificationService.changeNotificationStatus(notificationRequest);
			model << [notificationsModel:notificationResponse.getAlertNotifyRecipients(),
				changeOriginFlag:params.changeOriginFlag,
				totalAlertsCount:notificationResponse.getTotalAlerts()]
				
		}
		
		def alerts(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		 	NotificationRequest notificationRequest = getBean(NotificationRequest.class, requestHeader,params)
			NotificationResponse notificationResponse = bmClient.notificationService.getAlertNotifications(notificationRequest);
			model << [notificationsModel:notificationResponse.getAlertNotifyRecipients()]
			
	    }
}
