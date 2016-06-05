package com.vayana.ib.retail.web.service

import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils

import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.ib.bm.admin.core.api.beans.messagecenter.MessageCenterRequest
import com.vayana.ib.bm.admin.core.api.beans.messagecenter.MessageCenterResponse
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class MessageCenterService extends GenericService
{

	BmClient bmClient;
	
	def inbox(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		MessageCenterResponse response = bmClient.messageCenterService.getInboxMessages(msgRequest);
		model << [messageCenterResponse:response];
	}
	
	def drafts(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		MessageCenterResponse response = bmClient.messageCenterService.getDrafts(msgRequest);
		model << [messageCenterResponse:response];
		
	}
	
	def sentItems(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		MessageCenterResponse response = bmClient.messageCenterService.getSentItems(msgRequest);
		model << [messageCenterResponse:response];
	}
	
	def trash(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		MessageCenterResponse response = bmClient.messageCenterService.getTrash(msgRequest);
		model << [messageCenterResponse:response];
	}
	
	def getMessagesByLabel(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		MessageCenterResponse response = bmClient.messageCenterService.getMessagesByLabel(msgRequest);
		model << [msgcntrResponse:response];
	}
	
	def saveAsDraft(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
//		MessageCenterCommand msgCommand = validateCommandObject(MessageCenterCommand.class,params);
//		if(!msgCommand.hasErrors())
//		{
			MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
			//Set the Priority Type and Message Type
			//Set the Priority Type and Message Type
			String replyIndicator = params.replyIndicator;
			if(StringUtils.hasLength(replyIndicator))
			{
				updateRequestParamsForReply(msgRequest,params);
			}
			msgRequest.setPriorityType("L");
			msgRequest.setMessageType("NW");
			MessageCenterResponse response = bmClient.messageCenterService.saveDraft(msgRequest);
			model << [messageCenterResponse:response];
//		}
//		else
//		{
//			model << [errors:msgCommand];
//		}
		
	}
	
	def sendMessage(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		MessageCenterCommand msgCommand = validateCommandObject(MessageCenterCommand.class,params);     
		if(!msgCommand.hasErrors())
		{
			MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
			//Set the Priority Type and Message Type
			String replyIndicator = params.replyIndicator;
			if(StringUtils.hasLength(replyIndicator))
			{
				updateRequestParamsForReply(msgRequest,params);
			}
			msgRequest.setPriorityType("L");
			msgRequest.setMessageType("NW");
			MessageCenterResponse msgResponse = bmClient.messageCenterService.sendMessage(msgRequest);
			setMessage(("true".equals(params.isDraftSubmission))?DEFAULT_DRAFT_MESSAGE:DEFAULT_CREATED_MESSAGE, ["Message Sent ", " Successfully"], model);
			model << [messageCenterResponse:msgResponse];
		}
		else
		{
			model << [errors:msgCommand.errors];
		}
		
	}
	
	
	def updateRequestParamsForReply(MessageCenterRequest msgRequest,Map params)
	{
		//Set the Priority Type and Message Type
		String [] recipientIdArr = StringUtils.commaDelimitedListToStringArray(params.recipientId);
		List<String> recipientIds = Arrays.asList(recipientIdArr);
		String toRecipient = params.toRecipient;
		msgRequest.setRecipientType(toRecipient);
		msgRequest.setMessageRecipientGroupIds(recipientIds);
	}
	
	def messageDetails(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		String msgId = params.msgId;
		String msgVersion = params.msgVersion;
		String msgActionName = params.msgActionName;
		msgRequest.setMessageId(msgId+","+msgVersion);
		MessageCenterResponse msgResponse = bmClient.messageCenterService.getMessagesByThread(msgRequest);
		msgResponse.setActionName(msgActionName);
		setMessage(("true".equals(params.isDraftSubmission))?DEFAULT_DRAFT_MESSAGE:DEFAULT_CREATED_MESSAGE, ["Message Sent "," Successfully"], model);
		model << [messageCenterResponse:msgResponse];
	}
	
	def notificationDetails(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		
	}
	
	def reply(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		MessageCenterResponse response = bmClient.messageCenterService.reply(msgRequest);
		model << [messageCenterResponse:response];
		
	}
	def deleteMessage(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		List<String> messageIds = params.list("selectmessage");
		String msgActionName = params.msgActionName;
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		msgRequest.setMessageIds(messageIds);
		msgRequest.setMessageActionName(msgActionName);
		MessageCenterResponse response = bmClient.messageCenterService.moveToTrash(msgRequest);
		model << [messageCenterResponse:response];
		
	}
	
	def moveMessages(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		List<String> messageIds = params.list("selectmessage");
		String msgActionName = params.msgActionName;
		msgRequest.setMessageIds(messageIds);
		msgRequest.setMoveLocation(params.selectlocation);
		msgRequest.setMessageActionName(msgActionName);
		MessageCenterResponse response = bmClient.messageCenterService.moveMessages(msgRequest);
		model << [messageCenterResponse:response];

	}
	
	def discardDraftMessages(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		List<String> messageIds = params.list("selectmessage");
		msgRequest.setMessageIds(messageIds);
		MessageCenterResponse response = bmClient.messageCenterService.discardDraftMessages(msgRequest);
		model << [messageCenterResponse:response];
	}
	
	def deleteForever(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		MessageCenterRequest msgRequest = getBean(MessageCenterRequest.class, requestHeader, params);
		List<String> messageIds = params.list("selectmessage");
		msgRequest.setMessageIds(messageIds);
		MessageCenterResponse response = bmClient.messageCenterService.deleteForever(msgRequest);
		model << [messageCenterResponse:response];
	}
	
}
   
class MessageCenterCommand
{
	String subjectId,messageBody
	
	static constraints = {
		
		messageBody (blank:false);
		subjectId (blank:false);  
		
	}
}