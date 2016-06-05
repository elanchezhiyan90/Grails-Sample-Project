package com.vayana.ib.retail.web.service

import java.util.Map;

import org.springframework.ui.ModelMap

import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.ib.bm.core.api.beans.reminder.ReminderRequest
import com.vayana.ib.bm.core.api.beans.reminder.ReminderResponse
import com.vayana.ib.retail.web.controller.ReminderController;
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class ReminderService extends GenericService{

	BmClient bmClient;
	
	def getReminderMetaData(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
	
	}

	def getBillerInstructions(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		model<<[billerResponseModel:params.selectedBillerId.toLong()]
	
	}
	def getBeneficiaryInstructions(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		model<<[beneficiaryResponseModel:params.selectedBeneId.toLong()]
	}
	
	def savereminder(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{	
		ReminderCommand reminderCommand = validateCommandObject(ReminderCommand.class, params)
		if (reminderCommand.hasErrors()){
			model << [errors:reminderCommand]
		}else{
			ReminderRequest reminderRequest 	= getBean(ReminderRequest.class,requestHeader,params);
			reminderRequest.currencyCode		= params.currencyId;		
			ReminderResponse reminderResponse 	= bmClient.reminderService.insertReminder(reminderRequest);
			if(reminderResponse.hasErrors()){
				model <<[errors:reminderResponse.errors()]
				return;
			}
			else{
				model <<[reminderResponseModel:reminderResponse.getUserReminder()]
			}
		}
	}
	
	def removereminder(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		ReminderRequest reminderRequest 	= getBean(ReminderRequest.class,requestHeader,params);
		reminderRequest.reminderId 			= params.reminderId.toLong();
		//reminderRequest.datelineReferenceId = params.datelineReferenceId.toLong();		
		reminderRequest.status				= "D";
		ReminderResponse reminderResponse 	= bmClient.reminderService.updateReminderStatus(reminderRequest);
		if(reminderResponse.hasErrors()){
			model <<[errors:reminderResponse.errors()]
			return;
		}
		else{
			model <<[reminderResponseModel:reminderResponse]
		}
	}
	
	def updatereminderstatus(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		ReminderRequest reminderRequest 	= getBean(ReminderRequest.class,requestHeader,params);
		reminderRequest.reminderId 			= params.reminderId.toLong();
		//reminderRequest.datelineReferenceId = params.datelineReferenceId.toLong();
		reminderRequest.status				= "D";
		ReminderResponse reminderResponse 	= bmClient.reminderService.updateReminderStatus(reminderRequest);
		if(reminderResponse.hasErrors()){
			model <<[errors:reminderResponse.errors()]
			return;
		}
		else{
			model <<[reminderResponseModel:reminderResponse]
		}
	}
	
}

class ReminderCommand{
		String description;
		static constraints = {
			description shared: "reminderDescriptionSize"		
		}
}		
