package com.vayana.ib.retail.web.service

import java.text.SimpleDateFormat

import org.springframework.data.domain.PageRequest
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils

import com.ibm.icu.math.BigDecimal;
import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.ib.bm.core.api.beans.constants.AttributeConstants
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardDetailRequest
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardDetailResponse
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardMiniStatementRequest
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardMiniStatementResponse
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardStatementRequest
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardStatementResponse
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class PrepaidCardService extends GenericService{

	BmClient bmClient;

	def details(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		
		String accountId=params.accountId    
		PrepaidCardDetailRequest prepaidCardDetailRequest = getBean(PrepaidCardDetailRequest.class, requestHeader,params);
		prepaidCardDetailRequest.setAccountId(accountId.toLong())
		PrepaidCardDetailResponse prepaidCardDetailResponse=bmClient.prepaidCardService.getPrepaidCardDetail(prepaidCardDetailRequest);		
		if(prepaidCardDetailResponse.hasErrors())		{
			model << [errors:prepaidCardDetailResponse.errors()]			
			return;
		}
		else {
			
			model << [prepaidCardDetailModel:prepaidCardDetailResponse]		
				print "Prepaid Card::"+prepaidCardDetailResponse.prepaidCardAccount.accountNumber
				print "Prepaid cardType::"+prepaidCardDetailResponse.prepaidCardAccount.cardType
		}
	}
	def updateprepaidcardnickname(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UpdatePrepaidCardNickNameCommand updateNickCommand = validateCommandObject(UpdatePrepaidCardNickNameCommand.class, params)
		//If Errors Not Found Prepare the Request and call BM.
		if (!updateNickCommand.hasErrors()){
			CommonRequest nickUpdateRequest = getBean(CommonRequest.class, requestHeader, params);
			nickUpdateRequest.setAttribute(AttributeConstants.ACCOUNT_NUMBER, params.accountNumber);
			nickUpdateRequest.setAttribute(AttributeConstants.ACCOUNT_SHORT_NAME, params.accountShortName);
			CommonResponse updateNickResponse = bmClient.prepaidCardService.updatePrepaidCardNickName(nickUpdateRequest);
			
			model << [prepaidCardNickModel:updateNickResponse]
		}else{
			model << [errors:updateNickCommand]
		}
	}   
	   
	def ministatement(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception{		
		String accountId=params.accountId;   
  	   	PrepaidCardMiniStatementRequest prepaidCardMiniStatementRequest =getBean(PrepaidCardMiniStatementRequest.class, requestHeader, params);
		prepaidCardMiniStatementRequest.setAccountNumber(accountId);
        PrepaidCardMiniStatementResponse prepaidCardMiniStatementResponse=bmClient.prepaidCardService.getPrepaidCardMiniStatement(prepaidCardMiniStatementRequest);		
		if(prepaidCardMiniStatementResponse.hasErrors()){	  	
			model << [errors:prepaidCardMiniStatementResponse.errors()]			
			return;
		}else{
		print "Pager Model:"+prepaidCardMiniStatementResponse?.getPage()
		model<< [prepaidCardStatementModel:prepaidCardMiniStatementResponse,pagerModel:prepaidCardMiniStatementResponse?.getPage()]
		return;		
		}    
	}
	def detailedstatement(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
	   	PrepaidCardDetailedStatementCommand prepaidCardDetailedStatementCommand	=	validateCommandObject(PrepaidCardDetailedStatementCommand.class,params);
		if(!prepaidCardDetailedStatementCommand.hasErrors()){
	     PrepaidCardStatementRequest prepaidCardStatementRequest =  getBean(PrepaidCardStatementRequest.class, requestHeader, null);
	  	prepaidCardStatementRequest.cardNumber=params.accountNumber; 
		if(params.lastNTransactionFilter != ""){
			prepaidCardStatementRequest.fromDate=null
			prepaidCardStatementRequest.uptoDate=null
			prepaidCardStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;                   
			prepaidCardStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
			prepaidCardStatementRequest.lastNTransactionFilter=params.int("lastNTransactionFilter")
				
			
		}else if(params.monthFilter != ""){
			Calendar cal	=	Calendar.getInstance();
			cal.setTime(new SimpleDateFormat("MMM-yyyy").parse(params.monthFilter));
			String endDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH)+"-"+params.monthFilter
			prepaidCardStatementRequest.fromDate=new Date("01-"+params.monthFilter)
			prepaidCardStatementRequest.uptoDate=new Date(endDate)
			prepaidCardStatementRequest.fromAmountFilter=null
			prepaidCardStatementRequest.toAmountFilter=null
			prepaidCardStatementRequest.lastNTransactionFilter=null
		}else if(params.fromDate !="" && params.uptoDate!=""){
		 	prepaidCardStatementRequest.setFromDate(DateUtils.convertStringToDate(params.fromDate, DateUtils.YYYY_MM_DD));
			prepaidCardStatementRequest.setUptoDate(DateUtils.convertStringToDate(params.uptoDate, DateUtils.YYYY_MM_DD));
			prepaidCardStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
			prepaidCardStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
			prepaidCardStatementRequest.lastNTransactionFilter=null
		}else if(params.fromAmountFilter != "" && params.toAmountFilter != ""){
				 prepaidCardStatementRequest.fromDate=null
				 prepaidCardStatementRequest.uptoDate=null
				 prepaidCardStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
				 prepaidCardStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
				 prepaidCardStatementRequest.lastNTransactionFilter=null
		     }
		prepaidCardStatementRequest.debitCreditFilter=params.debitCreditFilter
		prepaidCardStatementRequest.referenceNumberFilter=params.referenceNumberFilter
		prepaidCardStatementRequest.setSortBy("transactionDate");
		PrepaidCardStatementResponse prepaidCardStatementResponse =  bmClient.prepaidCardService.getPrepaidCardStatement(prepaidCardStatementRequest);
		print "Pager Model:"+prepaidCardStatementResponse?.getPage()
  		model << [prepaidCardStatementModel:prepaidCardStatementResponse, pagerModel:prepaidCardStatementResponse.getPage()]
		}else{
		model<<[errors:prepaidCardDetailedStatementCommand]
		}
	}
	
	def detailedstatementgotopage(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception{
	 	println "CCC : " +params.dump();
	     	PrepaidCardStatementRequest prepaidCardStatementRequest=getBean(PrepaidCardStatementRequest.class, requestHeader, params);         
	  	prepaidCardStatementRequest.setUserSession(getInvoker().getSessionId());
//	  	PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),appConfig.getInt("rowsPerPage"));
  	   	PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),5);
		prepaidCardStatementRequest.setPageRequest(pageRequest);   
		if(params.sortBy){
			prepaidCardStatementRequest.setSortBy(params.sortBy);
		}else{
			prepaidCardStatementRequest.setSortBy("transactionDate");
		}
  		if(params.sortOrder){   
		prepaidCardStatementRequest.setSortOrder(params.sortOrder);
		}	
		
		PrepaidCardStatementResponse prepaidCardStatementResponse=bmClient.prepaidCardService.getPrepaidCardStatementPage(prepaidCardStatementRequest);		
		if(prepaidCardStatementResponse.hasErrors()){
			model << [errors:prepaidCardStatementResponse.errors()]
			return;
		}else{		  
		model<< [prepaidCardStatementModel:prepaidCardStatementResponse,pagerModel:prepaidCardStatementResponse.getPage()]
		return;
		}
		
	}
	
}
class UpdatePrepaidCardNickNameCommand {
	String accountNumber, accountShortName;
	static constraints = {
	   accountNumber(blank: false)
	   accountShortName(blank: false)
	}
}
class PrepaidCardDetailedStatementCommand{
	String lastNTransactionFilter,monthFilter,fromDate,uptoDate,debitCreditFilter,fromAmountFilter,toAmountFilter,referenceNumberFilter;
	static constraints={
		debitCreditFilter validator:{val,obj ->
 			if(!StringUtils.hasLength(obj.lastNTransactionFilter) && !StringUtils.hasLength(obj.monthFilter) && !StringUtils.hasLength(obj.fromDate) && !StringUtils.hasLength(obj.uptoDate)
				&& !StringUtils.hasLength(obj.fromAmountFilter) && !StringUtils.hasLength(obj.toAmountFilter)&& !StringUtils.hasLength(obj.referenceNumberFilter) )
			{
				obj.errors.rejectValue('debitCreditFilter','prepaidCardDetailedStatementCommand.datemonthlastn.blank')
			}
			if(StringUtils.hasLength(obj.fromAmountFilter)){
				if(!StringUtils.hasLength(obj.toAmountFilter)){
					   obj.errors.rejectValue('debitCreditFilter','prepaidCardDetailedStatementCommand.toAmountFilter.blank')
				}
			}else if(StringUtils.hasLength(obj.toAmountFilter)){
				if(!StringUtils.hasLength(obj.fromAmountFilter)){
						   obj.errors.rejectValue('debitCreditFilter','prepaidCardDetailedStatementCommand.fromAmountFilter.blank')
				}
			}
		};
		fromDate validator :{val,obj->
			if(StringUtils.hasLength(obj.fromDate)){
				if(!StringUtils.hasLength(obj.uptoDate)){
	 	 			obj.errors.rejectValue('fromDate','prepaidCardDetailedStatementCommand.uptoDate.blank')
				}
			}else if(StringUtils.hasLength(obj.uptoDate)){
					if(!StringUtils.hasLength(obj.fromDate)){
				 		obj.errors.rejectValue('fromDate','prepaidCardDetailedStatementCommand.fromDate.blank')
					}
		   	}
		};
	}
}