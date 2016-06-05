package com.vayana.ib.retail.web.controller

import com.vayana.ib.retail.web.controller.common.GenericController;

class MessageCenterController extends GenericController{

	def inbox()
	{
		render(view:"/messageCenter/inbox",model:model)
	}
	
	def drafts()
	{
		render(view:"/messageCenter/inbox",model:model)
	}
	
	def sentItems()
	{
		render(view:"/messageCenter/inbox",model:model)
	}
	
	def getMessagesByLabel()
	{
		render (template:"/messageCenter/templates/messageLabelCount",model:model);
	}
	
	def trash()
	{
		render(view:"/messageCenter/inbox",model:model)
	}
	
	
	def messageDetails()
	{
		render (template:"/messageCenter/templates/messageDetails",model:model);
	}
	
	def compose()
	{
		render (template:"/messageCenter/templates/compose",model:model);
	}
	
	def saveAsDraft()
	{
		render(view:"/messageCenter/inbox",model:model)
	}
	
	def sendMessage()
	{
		render(view:"/messageCenter/inbox",model:model)
	}
	
	def reply()
	{
		render (template:"/messageCenter/templates/reply",model:model);
	}
	
	def deleteMessage()
	{
		render(view:"/messageCenter/inbox",model:model)
	}
	
	def moveMessages(){
		render(view:"/messageCenter/inbox",model:model)
	}
	
	def discardDraftMessages(){
		render(view:"/messageCenter/inbox",model:model)
	}
	
	def deleteForever(){
		render(view:"/messageCenter/inbox",model:model)
	}
	def notificationDetails(){
		
		render(view:"/messageCenter/inbox",model:model)
	}
	
}