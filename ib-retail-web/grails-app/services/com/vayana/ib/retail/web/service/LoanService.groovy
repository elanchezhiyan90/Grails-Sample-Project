package com.vayana.ib.retail.web.service;

import java.text.DateFormat
import java.text.SimpleDateFormat

import org.springframework.data.domain.PageRequest
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils

import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.ib.bm.core.api.beans.constants.AttributeConstants
import com.vayana.ib.bm.core.api.beans.loan.LoanDetailedStatementRequest
import com.vayana.ib.bm.core.api.beans.loan.LoanDetailedStatementResponse
import com.vayana.ib.bm.core.api.beans.loan.LoanDetailsRequest
import com.vayana.ib.bm.core.api.beans.loan.LoanDetailsResponse
import com.vayana.ib.bm.core.api.beans.loan.LoanStatementRequest
import com.vayana.ib.bm.core.api.beans.loan.LoanStatementResponse
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class LoanService extends GenericService{
	
	BmClient bmClient;
	
	CommonService commonService;
			
	def details(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{				
				LoanDetailsRequest loanDetailRequest = getBean(LoanDetailsRequest.class,"loanDetailsRequest",requestHeader, params);
				loanDetailRequest.requestHeader=requestHeader
				loanDetailRequest.accountNumber = params.accountNumber;
				loanDetailRequest.accountId=params.accountId.toLong();
				LoanDetailsResponse loanDetailResponse = bmClient.loanService.getLoanDetail(loanDetailRequest);
				loanDetailResponse.setAccountNumber(params.accountNumber)
				
				if(loanDetailResponse.hasErrors())		{
					model << [errors:loanDetailResponse.errors()]
					return;
				}
				else {
					model << [loanDetailModel:loanDetailResponse]
				}
	}	
	
	
	
	
	def updateaccountnickname(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UpdateLoanAccountNickNameCommand updateNickCommand = validateCommandObject(UpdateLoanAccountNickNameCommand.class, params)
		//If Errors Not Found Prepare the Request and call BM.
		if (!updateNickCommand.hasErrors()){
			CommonRequest nickUpdateRequest = getBean(CommonRequest.class, requestHeader, params);
			nickUpdateRequest.setAttribute(AttributeConstants.ACCOUNT_NUMBER, params.accountNumber);
			nickUpdateRequest.setAttribute(AttributeConstants.ACCOUNT_SHORT_NAME, params.accountShortName);
			CommonResponse updateNickResponse = bmClient.loanService.updateAccountNickName(nickUpdateRequest);			
			model << [loanDetailModel:updateNickResponse]
		}else{
			model << [errors:updateNickCommand]
		}
	}
	
	def statement(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception	{
		String accountId = params.accountId;
		String accountNumber = params.accountNumber;
		LoanStatementRequest loanStatementRequest = getBean(LoanStatementRequest.class,"loanStatementRequest",requestHeader,params);
		loanStatementRequest.accountId=accountId.toLong();
		loanStatementRequest.accountNumber=accountNumber.toLong();
		loanStatementRequest.customerId = requestHeader.getInvoker().getPrimaryCIF();
		loanStatementRequest.setNumRecordsRequested("10");
		LoanStatementResponse loanStatementResponse = null;
		try{
			loanStatementResponse = bmClient.loanService.getLoanStatement(loanStatementRequest);
		}catch(Exception e){
			e.printStackTrace();
			model << [LoanStatementModel:null,pagerModel:null]
			return;
		}
		if(loanStatementResponse.hasErrors())		{
			model << [errors:loanStatementResponse.errors()]
			return;
		}
		else {
			print "Pager Model:"+loanStatementResponse?.getPage()
			model << [LoanStatementModel:loanStatementResponse,pagerModel:loanStatementResponse?.getPage()]			
		}
		
	}
	
	
	def detailedStatement(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception	{
		LoanDetailedStatementCommand casaAccountDetailedStatementCommand =validateCommandObject(LoanDetailedStatementCommand.class,params);
		if(!casaAccountDetailedStatementCommand.hasErrors()){
			LoanDetailedStatementRequest detailedStatementRequest =  getBean(LoanDetailedStatementRequest.class, requestHeader, null);
			String accountId = params.accountId;
			detailedStatementRequest.accountId=accountId.toLong();
			detailedStatementRequest.loanNumber=params.loanNumber;
			detailedStatementRequest.customerId = requestHeader.getInvoker().getPrimaryCIF();
			log.info("Detailedstatement Params ::: "+params?.dump());
			if(params.lastNTransactionFilter != ""){
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");                                 
				String fromDate =  df.format(new Date());
				detailedStatementRequest.setFromDate(DateUtils.convertStringToDate(fromDate, DateUtils.YYYY_MM_DD));
				detailedStatementRequest.uptoDate=null
				detailedStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
				detailedStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
				detailedStatementRequest.lastNTransactionFilter=params.int("lastNTransactionFilter")
				
			}else if(params.monthFilter != "" && params.fromDate =="" && params.uptoDate ==""){
				Calendar cal	=	Calendar.getInstance();
				cal.setTime(new SimpleDateFormat("MMM-yyyy").parse(params.monthFilter));
				String endDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH)+"-"+params.monthFilter
				detailedStatementRequest.fromDate=new Date("01-"+params.monthFilter)
				detailedStatementRequest.uptoDate=new Date(endDate)
				detailedStatementRequest.fromAmountFilter=null
				detailedStatementRequest.toAmountFilter=null
				if((params.lastNTransactionFilter != null) &&( params.lastNTransactionFilter != "")){
				   detailedStatementRequest.lastNTransactionFilter=params.int("lastNTransactionFilter")
			   }else{
			   detailedStatementRequest.lastNTransactionFilter=0
			   }
			}else if(params.fromDate !="" && params.uptoDate!=""){
			   detailedStatementRequest.setFromDate(DateUtils.convertStringToDate(params.fromDate, DateUtils.YYYY_MM_DD));
			   detailedStatementRequest.setUptoDate(DateUtils.convertStringToDate(params.uptoDate, DateUtils.YYYY_MM_DD));
			   detailedStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
			   detailedStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
			   if((params.lastNTransactionFilter != null) &&( params.lastNTransactionFilter != "")){
				   detailedStatementRequest.lastNTransactionFilter=params.int("lastNTransactionFilter")
			   }else{
			   detailedStatementRequest.lastNTransactionFilter=0
			   }
			 }else{
			 	detailedStatementRequest.lastNTransactionFilter=10
			 }
			
			/*else if(params.fromAmountFilter != "" && params.toAmountFilter != ""){
				 detailedStatementRequest.fromDate=null
				 detailedStatementRequest.uptoDate=null
				 detailedStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
				 detailedStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
				 detailedStatementRequest.lastNTransactionFilter=null
			 }*/
			detailedStatementRequest.debitCreditFilter=params.debitCreditFilter
			detailedStatementRequest.referenceNumberFilter=params.referenceNumberFilter
			detailedStatementRequest.setSortBy("id");
			detailedStatementRequest.setSortOrder("asc");
			detailedStatementRequest.setPmcbSortOrder("A");
			LoanDetailedStatementResponse detailedStatementResponse =  bmClient.loanService.getLoanDetailedStatement(detailedStatementRequest);
			print "Pager Model:"+detailedStatementResponse?.getPage()
			model << [LoanStatementModel:detailedStatementResponse, pagerModel:detailedStatementResponse.getPage()]
			}else{
			model<<[errors:casaAccountDetailedStatementCommand]
			}
			
	}
	
	
	def detailedstatementgotopage(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		LoanDetailedStatementRequest loanDetailedStatementRequest= getBean(LoanDetailedStatementRequest.class,requestHeader,null);
		loanDetailedStatementRequest.setUserSession(getInvoker().getSessionId());
		PageRequest pageRequest = new PageRequest(Integer.parseInt(params.gotoPage), 10);
		loanDetailedStatementRequest.setPageRequest(pageRequest);
		if(params?.sortBy){
			loanDetailedStatementRequest.setSortBy(params.sortBy)
		}else{
			loanDetailedStatementRequest.setSortBy("id");
		}
		if(params?.sortOrder){
			loanDetailedStatementRequest.setSortOrder(params.sortOrder);
		}else{
			loanDetailedStatementRequest.setSortOrder("asc");
		}
		LoanDetailedStatementResponse detailedStatementResponse = bmClient.loanService.getLoanDetailedStatementPage(loanDetailedStatementRequest);
		if(detailedStatementResponse.hasErrors()){
			model << [errors:detailedStatementResponse.errors()]
			return;
		}else{
		model << [LoanStatementModel:detailedStatementResponse, pagerModel:detailedStatementResponse.getPage()]
		return;
		}
	}
	
	def statementfilter(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		LoanDetailedStatementRequest statementRequest = getBean(LoanDetailedStatementRequest.class,requestHeader,null);
		statementRequest.setUserSession(getInvoker().getSessionId());
//		PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),appConfig.getInt("rowsPerPage"));
		PageRequest pageRequest= new PageRequest(0,5);
		statementRequest.setPageRequest(pageRequest);
		if(params.sortBy!=null){
			statementRequest.setSortBy(params.sortBy);
		}else{
			statementRequest.setSortBy("transactionDescription");
		}
		if(params.sortOrder!=null){
		statementRequest.setSortOrder(params.sortOrder);
		}
		LoanDetailedStatementResponse statementResponse = bmClient.loanService.getStatementFilter(statementRequest);
		if(statementResponse.hasErrors()){
			model << [errors:statementResponse.errors()]
			return;
		}else{
		model<< [LoanStatementModel:statementResponse,pagerModel:statementResponse.getPage()]
		return;
		}
	}
	
}

class UpdateLoanAccountNickNameCommand {
	String accountNumber, accountShortName;
	private static int SHORT_NAME_LENGTH = 25
	static constraints = {
	   accountNumber(blank: false)
	   accountShortName validator : { val,obj->
		   if(StringUtils.hasLength(val) && val?.matches("[a-zA-Z0-9 ]+")) {
			   if(val.length() > SHORT_NAME_LENGTH) {
				   obj.errors.rejectValue('accountShortName','accountShortName.invalid.error')
			   }
		   } else {
			   	obj.errors.rejectValue('accountShortName','accountShortName.invalid.error')
		   }
		   
	   } 
	}
}
class LoanDetailedStatementCommand {
	String lastNTransactionFilter,monthFilter,fromDate,uptoDate,debitCreditFilter,fromAmountFilter,toAmountFilter,referenceNumberFilter;
	static constraints={
		importFrom CasaAccountDetailedStatementCommand;
	}
}