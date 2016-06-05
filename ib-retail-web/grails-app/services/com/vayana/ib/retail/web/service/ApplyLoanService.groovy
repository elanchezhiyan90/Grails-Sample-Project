package com.vayana.ib.retail.web.service

import java.util.UUID;

import org.springframework.ui.ModelMap

import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.ib.bm.core.api.model.applyloan.ApplyLoanRequest
import com.vayana.ib.bm.core.api.model.applyloan.ApplyLoanResponse
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService


class ApplyLoanService extends GenericService{

	BmClient bmClient;
	
	def propertydetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		if(getSessionAttribute("APPLYLOANREQUEST")!=null)
		{
			ApplyLoanRequest applyLoanRequest = (ApplyLoanRequest)getSessionAttribute("APPLYLOANREQUEST");
			model << [applyLoanRequest:applyLoanRequest]
		}
		
	};
	
	def savepropertydetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		
		PropertyDetailsCommand propertyDetailsCommandObject = validateCommandObject(PropertyDetailsCommand.class,params);
		if(!propertyDetailsCommandObject.hasErrors()){			
		
			if(getSessionAttribute("APPLYLOANREQUEST")!=null)
			{
				ApplyLoanRequest applyLoanRequest = (ApplyLoanRequest)getSessionAttribute("APPLYLOANREQUEST");
				updatePropertyDetails(applyLoanRequest,params);
				setSessionAttribute("APPLYLOANREQUEST", applyLoanRequest);
			}
			else
			{
				ApplyLoanRequest applyLoanRequest = getBean(ApplyLoanRequest.class,requestHeader, params);
				println "---------------------------------"
				println applyLoanRequest.dump()
				updatePropertyDetails(applyLoanRequest,params);
				setSessionAttribute("APPLYLOANREQUEST", applyLoanRequest);
			}
		
		}else{
		   model << [errors:propertyDetailsCommandObject.errors]
	   }
				
	
	}
	
	def saveincomedetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		IncomeDetailsCommand incomeDetailsCommandObject = validateCommandObject(IncomeDetailsCommand.class,params);
		if(!incomeDetailsCommandObject.hasErrors()){
		ApplyLoanRequest applyLoanRequest = (ApplyLoanRequest)getSessionAttribute("APPLYLOANREQUEST");
		//Update All Income Details related parameters
		updateIncomeDetails(applyLoanRequest,params);
		setSessionAttribute("APPLYLOANREQUEST", applyLoanRequest);
		println "---------------------------------"
		println "params----->"+params.dump();
		println applyLoanRequest.dump()
	}else{
		   model << [errors:incomeDetailsCommandObject.errors]
	   }
	}
	
	def updatePropertyDetails(ApplyLoanRequest applyLoanRequest,Map params)
	{
		applyLoanRequest.setPurposeofloan(params.purposeofloan);
		applyLoanRequest.setPropertylocation(params.propertylocation);
		applyLoanRequest.setPropertydetails(params.propertydetails);
		applyLoanRequest.setNameofthebuilder(params.nameofthebuilder);
		applyLoanRequest.setCostofhome(params.costofhome?.toBigDecimal());
		applyLoanRequest.setLivingcountry(params.livingcountry);
	}
	
	def updateIncomeDetails(ApplyLoanRequest applyLoanRequest,Map params)
	{
		applyLoanRequest.setTypeofemployment(params.typeofemployment?.toString());
		applyLoanRequest.setCompanyname(params.companyname);
		applyLoanRequest.setJoiningdate(DateUtils.convertStringToDate(params.joiningdate, "mm/dd/yyyy")); 
		applyLoanRequest.setGrossmonthlyincome(params.grossmonthlyincome?.toBigDecimal()); 
		applyLoanRequest.setNetmonthlyincome(params.netmonthlyincome?.toBigDecimal());
		applyLoanRequest.setRetirementage(params.retirementage?.toInteger());
		applyLoanRequest.setCurrentemi(params.currentemi);
		applyLoanRequest.setGrossmonthlyincomecurrency(params.grossmonthlyincomecurrency);
		applyLoanRequest.setNetmonthlyincomecurrency(params.netmonthlyincomecurrency);
		applyLoanRequest.setCurrentemicurrency(params.currentemicurrency);
		
	}
	
	def updateEligibilityDetails(ApplyLoanRequest applyLoanRequest,Map params)
	{
		applyLoanRequest.setAmount(params.amount?.toBigDecimal());
		applyLoanRequest.setInterestrate(params.interestrate)
		applyLoanRequest.setTime(params.time);
		applyLoanRequest.setEmiamount(params.emiamount?.toBigDecimal());
		applyLoanRequest.setStatus(params.status);
	
	}
	
	def saveloneeligibility(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		ApplyLoanRequest applyLoanRequest = (ApplyLoanRequest)getSessionAttribute("APPLYLOANREQUEST");
		updateEligibilityDetails(applyLoanRequest,params);
		applyLoanRequest.setPersistEntity(false);
		applyLoanRequest.setLoanrefnumber(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString())
		ApplyLoanResponse applyLoanResponse = bmClient.applyLoanService.getConfirmForApplyLoan(applyLoanRequest);
		model <<[loanDetailModel:applyLoanResponse.loanRequestDetail];
	
	}
	
	def saveloanstatus(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		ApplyLoanRequest applyLoanRequest = (ApplyLoanRequest)getSessionAttribute("APPLYLOANREQUEST")
		ApplyLoanResponse applyLoanResponse = bmClient.applyLoanService.insertRequestDetail(applyLoanRequest);
		model <<[loanDetailModel:applyLoanResponse.getLoanRequestDetail(),loanDetailReferencemodel:applyLoanRequest.getLoanrefnumber()];
	}
			
	
	def showApplyLoanDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		ApplyLoanRequest applyLoanRequest = getBean(ApplyLoanRequest.class,requestHeader, params); 
		applyLoanRequest.setLoanId(params.processInstanceId?.toLong())
		ApplyLoanResponse applyLoanResponse = bmClient.applyLoanService.getLoanRequestDetail(applyLoanRequest);
		model <<[loanDetailModel:applyLoanResponse.loanRequestDetail];
		return;
	}
}




	
class PropertyDetailsCommand{
	String nameofthebuilder;
	String costofhome;
	
	static constraints={
	
		//purposeofloan(blank:false);
	
		
	nameofthebuilder blank:false,validator : {val,obj ->
		if(!val?.matches("[a-zA-Z0-9_' ]+")){
		  obj.errors.rejectValue('nameofthebuilder','propertyDetailsCommand.nameofthebuilder.match.invalid')
		 
		}
	}
	
	costofhome blank:false,validator : {val,obj ->
		if(!val?.matches("[0-9]+([.][0-9]{1,2})?")){
		  obj.errors.rejectValue('costofhome','propertyDetailsCommand.costofhome.match.invalid')
		}
	}
	}
	
	
	
}

class IncomeDetailsCommand{
	String companyname,grossmonthlyincome,netmonthlyincome,retirementage,currentemi;

	
	static constraints={
	companyname blank:false,validator : {val,obj ->
		if(!val?.matches("[a-zA-Z0-9_' ]+")){
		  obj.errors.rejectValue('companyname','incomeDetailsCommand.companyname.match.invalid')
		 
		}
	}
	
	
	grossmonthlyincome blank:false,validator : {val,obj ->
		if(!val?.matches("[0-9]+([.][0-9]{1,2})?")){
		  obj.errors.rejectValue('grossmonthlyincome','incomeDetailsCommand.grossmonthlyincome.match.invalid')
		}
	}
	netmonthlyincome blank:false,validator : {val,obj ->
		if(!val?.matches("[0-9]+([.][0-9]{1,2})?")){
		  obj.errors.rejectValue('netmonthlyincome','incomeDetailsCommand.netmonthlyincome.match.invalid')
		}
	}
	retirementage blank:false,validator : {val,obj ->
		if(!val?.matches("[1-9][0-9]*|0")){
		  obj.errors.rejectValue('retirementage','incomeDetailsCommand.retirementage.match.invalid')
		}
	}
	currentemi blank:false,validator : {val,obj ->
		if(!val?.matches("[0-9]+([.][0-9]{1,2})?")){
		  obj.errors.rejectValue('currentemi','incomeDetailsCommand.currentemi.match.invalid')
		}
	}
	}
	
	
	
}
	   
	




