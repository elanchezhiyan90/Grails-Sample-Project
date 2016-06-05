package com.vayana.ib.retail.web.service

import java.util.Map;

import org.springframework.ui.ModelMap

import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.ib.bm.core.api.beans.reminder.ReminderRequest
import com.vayana.ib.bm.core.api.beans.reminder.ReminderResponse
import com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction
import com.vayana.ib.bm.core.api.model.payment.BillerInstruction
import com.vayana.ib.bm.core.api.model.payment.PaymentDetail
import com.vayana.ib.bm.core.api.model.payment.PaymentHeader
import com.vayana.ib.bm.core.api.model.payment.PaymentScheduleDetail;
import com.vayana.ib.bm.core.api.model.payment.PaymentScheduleHeader;
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class DatelineService extends GenericService{
	
	BmClient bmClient	
	
	def addreminder(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		ReminderRequest reminderRequest 	= getBean(ReminderRequest.class,requestHeader,params);
		ReminderResponse reminderResponse 	= bmClient.reminderService.getPreviousReminders(reminderRequest);
		if(reminderResponse.hasErrors()){
			model <<[errors:reminderResponse.errors()]
			return;
		}
		else{
			model <<[reminderResponseModel:reminderResponse.getUserReminders()]
		}
	}
		
}
