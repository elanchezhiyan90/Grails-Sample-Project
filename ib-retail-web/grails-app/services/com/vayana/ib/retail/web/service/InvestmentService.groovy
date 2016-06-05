package com.vayana.ib.retail.web.service

import java.text.DateFormat
import java.text.SimpleDateFormat

import org.springframework.data.domain.PageRequest
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils

import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.ContextCodeType;
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.exception.BusinessException;
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants;
import com.vayana.ib.bm.core.api.beans.account.AccountBalanceResponse
import com.vayana.ib.bm.core.api.beans.constants.AttributeConstants
import com.vayana.ib.bm.core.api.beans.investment.DetailedStatementRequest
import com.vayana.ib.bm.core.api.beans.investment.DetailedStatementResponse
import com.vayana.ib.bm.core.api.beans.investment.InvestmentDetailRequest
import com.vayana.ib.bm.core.api.beans.investment.InvestmentDetailResponse
import com.vayana.ib.bm.core.api.beans.investment.MiniStatementRequest
import com.vayana.ib.bm.core.api.beans.investment.MiniStatementResponse
import com.vayana.ib.bm.core.api.beans.security.SecurityHolder
import com.vayana.ib.bm.core.api.beans.servicerequest.DepositServiceRequest
import com.vayana.ib.bm.core.api.beans.servicerequest.DepositServiceResponse
import com.vayana.ib.bm.core.api.beans.servicerequest.GenericSRRequest
import com.vayana.ib.bm.core.api.beans.servicerequest.GenericSRResponse
import com.vayana.ib.bm.core.api.model.enums.PaymentButtonEnum
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService



class InvestmentService extends GenericService{
	
	BmClient bmClient;
	
	CommonService commonService;
	
	def details(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
				InvestmentDetailRequest investmentDetailRequest 	= getBean(InvestmentDetailRequest.class,requestHeader, params);
				InvestmentDetailResponse investmentDetailResponse 	= bmClient.investmentService.getInvestmentDetail(investmentDetailRequest);
				if(investmentDetailResponse.hasErrors())		{
					model << [errors:investmentDetailResponse.errors()]
					return;
				}
				else {					 
					model << [investmentDetailModel:investmentDetailResponse]					
				}
	}
	
	def updateaccountnickname(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UpdateInvestAccountNickNameCommand updateNickCommand = validateCommandObject(UpdateInvestAccountNickNameCommand.class, params)
		//If Errors Not Found Prepare the Request and call BM.
		if (!updateNickCommand.hasErrors()){
			CommonRequest nickUpdateRequest = getBean(CommonRequest.class, requestHeader, params);
			nickUpdateRequest.setAttribute(AttributeConstants.ACCOUNT_NUMBER, params.accountNumber);
			nickUpdateRequest.setAttribute(AttributeConstants.ACCOUNT_SHORT_NAME, params.accountShortName);
			CommonResponse updateNickResponse = bmClient.investmentService.updateAccountNickName(nickUpdateRequest);			
			model << [loanDetailModel:updateNickResponse]
		}else{
			model << [errors:updateNickCommand]
		}
	}
	
	def statement(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception	{		
		MiniStatementRequest statementRequest 	= getBean(MiniStatementRequest.class,requestHeader,params);
		statementRequest.cifNumber 				= requestHeader?.invoker?.primaryCIF
		statementRequest.branchId = "001"
		statementRequest.setTransactionCount("10")
		MiniStatementResponse statementResponse = null;
		try{
			statementResponse = bmClient.investmentService.getMiniStatement(statementRequest);
		} catch(Exception e) {
			e.printStackTrace();
			model << [StatementModel:null]
			return;
		}		
		if(statementResponse.hasErrors())		{
			model << [errors:statementResponse.errors()]
			return;
		}
		else {
			model << [StatementModel:statementResponse]
		}
				
	}
	
	def detailedstatement(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception	{				
		InvestmentAccountDetailedStatementCommand investmentAccountDetailedStatementCommand =validateCommandObject(InvestmentAccountDetailedStatementCommand.class,params);
	if(!investmentAccountDetailedStatementCommand.hasErrors()){
		DetailedStatementRequest statementRequest = getBean(DetailedStatementRequest.class,requestHeader,null);
		statementRequest.accountNumber=params.accountNumber;
		statementRequest.cifNumber 	= requestHeader?.invoker?.primaryCIF
		statementRequest.branchId ="001"
		log.info("Detailedstatement Params ::: "+params?.dump());
		if(params.lastNTransactionFilter != ""){
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");                                 
			String fromDate =  df.format(new Date());
			statementRequest.setFromDate(DateUtils.convertStringToDate(fromDate, DateUtils.YYYY_MM_DD));
			statementRequest.uptoDate=null
			statementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
		    statementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
			statementRequest.lastNTransactionFilter=params.int("lastNTransactionFilter")
			
		}else if(params.monthFilter != "" && params.fromDate =="" && params.uptoDate ==""){
			Calendar cal	=	Calendar.getInstance();
			cal.setTime(new SimpleDateFormat("MMM-yyyy").parse(params.monthFilter));
			String endDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH)+"-"+params.monthFilter
			statementRequest.fromDate=new Date("01-"+params.monthFilter)
			statementRequest.uptoDate=new Date(endDate)
			statementRequest.fromAmountFilter=null
			statementRequest.toAmountFilter=null
			if((params.lastNTransactionFilter != null) &&( params.lastNTransactionFilter != "")){
			   statementRequest.lastNTransactionFilter=params.int("lastNTransactionFilter")
			}else{
		   		statementRequest.lastNTransactionFilter=0
			}
		}
		else if(params.fromDate !="" && params.uptoDate!=""){
		   statementRequest.setFromDate(DateUtils.convertStringToDate(params.fromDate, DateUtils.YYYY_MM_DD));
		   statementRequest.setUptoDate(DateUtils.convertStringToDate(params.uptoDate, DateUtils.YYYY_MM_DD));
		   statementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
		   statementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
		   if((params.lastNTransactionFilter != null) &&( params.lastNTransactionFilter != "")){
			   statementRequest.lastNTransactionFilter=params.int("lastNTransactionFilter")
		   }else{
		   	statementRequest.lastNTransactionFilter=0
		   }
		 }else{
		 	statementRequest.lastNTransactionFilter=10
		 }
		
		statementRequest.debitCreditFilter=params.debitCreditFilter
		statementRequest.referenceNumberFilter=params.referenceNumberFilter
		statementRequest.setSortBy("id");
		statementRequest.setSortOrder("asc")
		statementRequest.setPmcbSortOrder("A");
		DetailedStatementResponse statementResponse = bmClient.investmentService.getDetailedStatement(statementRequest);
		print "Pager Model:"+statementResponse?.getPage()
		model << [StatementModel:statementResponse, pagerModel:statementResponse.getPage()]
		}else{
		model<<[errors:investmentAccountDetailedStatementCommand]
		}
	}
	
	def detailedstatementgotopage(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		DetailedStatementRequest statementRequest = getBean(DetailedStatementRequest.class,requestHeader,null);	
		statementRequest.setUserSession(getInvoker().getSessionId());
		//PageRequest pageRequest = new PageRequest(Integer.parseInt(params.gotoPage), appConfig.getInt("rowsPerPage"));
		PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),10);
		statementRequest.setPageRequest(pageRequest);
		if(params?.sortBy){
			statementRequest.setSortBy(params.sortBy)
		}else{
			statementRequest.setSortBy("id");
		}
		if(params?.sortOrder){
			statementRequest.setSortOrder(params.sortOrder);
		}else{
			statementRequest.setSortOrder("asc");
		}
		DetailedStatementResponse statementResponse = bmClient.investmentService.getDetailedStatementPage(statementRequest);
		if(statementResponse.hasErrors()){
			model << [errors:statementResponse.errors()]
			return;
		}
		else{
			model << [StatementModel:statementResponse, pagerModel:statementResponse.getPage()]
		 return;
		}
	}

	def statementfilter(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception{		
		DetailedStatementRequest statementRequest = getBean(DetailedStatementRequest.class,requestHeader,null);
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
		DetailedStatementResponse statementResponse = bmClient.investmentService.getStatementFilter(statementRequest);
		if(statementResponse.hasErrors()){
			model << [errors:statementResponse.errors()]
			return;
		}else{
		model<< [StatementModel:statementResponse,pagerModel:statementResponse.getPage()]
		return;
		}		
	}
	
	
	
	def addDepositAccount(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		model<<[customerBranchCode:requestHeader?.getInvoker()?.getCustomerBranchCode(),customerBranchIdVersion:requestHeader?.getInvoker()?.getCustomerBranchIdVersion()]
	}
	
	def showDepositTypeDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		GenericSRRequest req = getBean(GenericSRRequest.class, "genericSRRequest", requestHeader, params);
		req.setDepositType(params?.depositType?.split(',')[0]);
		GenericSRResponse res =  bmClient.serviceRequestService.fetchDepositTypeDetails(req);
		model<<[depositDetail:res?.depositDetail]
	}
	def cancelOpenDepositRequest(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		DepositServiceRequest depositServiceRequest 	= getBean(DepositServiceRequest.class,requestHeader, params);
		DepositServiceResponse depositServiceResponse 	= bmClient.investmentService.getDepositTenure(depositServiceRequest);
		if(depositServiceResponse.hasErrors())		{
			model << [errors:depositServiceResponse.errors()]
			return;
		}
		else {
			model << [depositServiceResponseModel:depositServiceResponse.getDepositTenureServiceRequests()]
		}
	}
	
	def validateOpenNewDeposit(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{

		DepositServiceRequest depositServiceRequest=new DepositServiceRequest();
		//For server side validation
		DepositRequestCommand  depositRequestCommand=validateCommandObject(DepositRequestCommand.class,params);
		if(depositRequestCommand.hasErrors()){
			model << [errors:depositRequestCommand]
			return
		}
		/*  if(PaymentButtonEnum.LATER.toString().equals(params?.buttonEvent))
		 {
		 InvestLaterCommand investLaterCmd =validateCommandObject(InvestLaterCommand.class,params)
		 if(investLaterCmd.hasErrors()){
		 model << [errors:investLaterCmd]
		 return
		 }
		 }
		 else if(PaymentButtonEnum.REPEAT.toString().equals(params?.buttonEvent))
		 {
		 InvestRecurringCommand investRecurringCmd =validateCommandObject(InvestRecurringCommand.class,params)
		 if(investRecurringCmd.hasErrors()){
		 model << [errors:investRecurringCmd]
		 return
		 }
		 }*/
		
//		SecurityHolder securityHolder=getBean(SecurityHolder.class, requestHeader, params);
		AccountBalanceResponse accountBalanceResponse		=	(AccountBalanceResponse)getSessionAttribute("_BAL")
		
		if (accountBalanceResponse?.availableBalance?.compareTo(new BigDecimal(params?.amount)) == -1) {
			log.info("Transaction Amount greater Than Available Balance!!!");
			throw new BusinessException(
					ContextCodeType.CORE,
					ErrorCodeConstants.TRANSACTION_AMOUNT_GREATER_THAN_AVL_BALANCE,
					"Transaction Amount greater Than Available Balance", null);
		}
		depositServiceRequest=getDepositServiceRequest(params, depositServiceRequest)
		depositServiceRequest.setRequestHeader(requestHeader);
		
		

		setSessionAttribute("DSR", depositServiceRequest);

	}
	

	def checkBlank(String value)
	{
		if(value != null && !value.equalsIgnoreCase("") && !value.equalsIgnoreCase("null"))
		{
			return false;
		}
		else
		{
			return true;
		}
		
	}
	
	def openNewDepositConfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		DepositServiceRequest depositServiceRequest				=	(DepositServiceRequest) getSessionAttribute("DSR");
		DepositServiceResponse depositServiceResponse 	= bmClient.investmentService.confirmDepositService(depositServiceRequest);
		//depositServiceRequest.setTdSchmCode(depositServiceRequest.getTdSchmCode());
		//depositServiceRequest.setMaturityAmount(depositServiceRequest.getMaturityAmount());
		DepositServiceResponse depositServiceResponsenew 	= bmClient.investmentService.getTDMaturityInfo(depositServiceRequest);	
		
		if(depositServiceResponse.hasErrors())		{
			model << [errors:depositServiceResponse.errors()]
			return;
		}else {
			model << [depositServiceResponseModel:depositServiceRequest.getDepositRequest(),buttonTypeModel:depositServiceRequest.getButtonType(),depositServiceResponsenewModel:depositServiceResponsenew]
		}

	}

	def insertOpenNewDeposit(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		DepositServiceRequest depositServiceRequest				=	(DepositServiceRequest) getSessionAttribute("DSR");
		depositServiceRequest.setIbReferenceNumber(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString());
		DepositServiceResponse depositServiceResponse 	= bmClient.investmentService.insertOpenNewDeposit(depositServiceRequest);
		if(depositServiceResponse.hasErrors())		{
			model << [errors:depositServiceResponse.errors()]
			return;
		}else {
			model << [depositServiceResponseModel:depositServiceResponse.getDepositRequest(),depositReferenceNoModel:depositServiceRequest.getIbReferenceNumber(),tdAccountNoModel:depositServiceResponse.getCoreResponse()]
		}

	}
	
	 
	def investLaterPreConfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		
		}
	
	def recurringPreConfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
	
	}
	
	//private methods
	private DepositServiceRequest getDepositServiceRequest(Map params,DepositServiceRequest depositServiceRequest)
	{	
		depositServiceRequest.setCifNumber(invoker.getPrimaryCIF());
		depositServiceRequest.setTdSchmCode(params?.depositType);
		depositServiceRequest.setPayerInstructionId(params?.payerInstruction);
		depositServiceRequest.setBranchType(params?.branchType);
		depositServiceRequest.setTenantBranch(params?.tenantBranch);
		depositServiceRequest.setDeposittype(params?.depositType);
		depositServiceRequest.setAmount(params?.amount);
		depositServiceRequest.setCurrency(params?.currency);
		depositServiceRequest.setMonth(params?.month);
		depositServiceRequest.setDays(params?.days);
		depositServiceRequest.setMaturityInstruction(params?.maturityInstruction);
		depositServiceRequest.setInterestPayableFreq(params?.interestPayableFreq);
		depositServiceRequest.setInterestPayableMode(params?.interestPayableMode);
		//depositServiceRequest.setCreditAccountNumber(params?.creditAccountNumber);
		depositServiceRequest.setCreditAccountNumber(params?.payerInstruction);
		depositServiceRequest.setNominationFacility(params?.nominationFacility);
		//depositServiceRequest.setNomineeminorYES(params?.nomineeminorYES);
		depositServiceRequest.setNomineeisminor(params?.nomineeminor);
		depositServiceRequest.setNomineeName(params?.nomineeName);
		if(!checkBlank(params?.renewalTerm)){
		depositServiceRequest.setRenewalTerm(params?.renewalTerm);
		  }
		if(!checkBlank(params?.nomineeAddress)){
		depositServiceRequest.setNomineeAddress(params?.nomineeAddress);
		}
		if(!checkBlank(params?.nomineeAddress1)){
			depositServiceRequest.setNomineeAddress1(params?.nomineeAddress1);
			}
		if(!checkBlank(params?.nomineeAddress2)){
			depositServiceRequest.setNomineeAddress2(params?.nomineeAddress2);
			}
		if(!checkBlank(params?.country)){
			depositServiceRequest.setCountry(params?.country);
			}
		if(!checkBlank(params?.state)){
			depositServiceRequest.setState(params?.state);
			}
		if(!checkBlank(params?.pincode)){
			depositServiceRequest.setPincode(params?.pincode);
			}
		if(!checkBlank(params?.city)){
			depositServiceRequest.setCity(params?.city);
			}
		if(!checkBlank(params?.nomineeDOB)){
		//if(null != params?.nomineeDOB){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-mm-dd");
		depositServiceRequest.setNomineeDOB(df.parse(params?.nomineeDOB));
		}
		if(!checkBlank(params?.nomineeRelationship)){
		depositServiceRequest.setNomineeRelationship(params?.nomineeRelationship);
		}
		depositServiceRequest.setPanNumber(params?.panNumber);
		depositServiceRequest.setGuardianName(params?.guardianName);
		if(!checkBlank(params?.guardianRelationship))
		{
			depositServiceRequest.setGuardianRelationship(params?.guardianRelationship);
		}
	
		
		
		
		/*depositServiceRequest.setMaturityType(params.maturityType);
		depositServiceRequest.setMaturityId(params.maturityId);
		depositServiceRequest.setTenure(params.tenure);
		depositServiceRequest.setInterestPayout(params?.interestPayout);
		depositServiceRequest.setOther(params?.other);
		if(params.startDate){
			depositServiceRequest.setStartDate(params.startDate);
		}
		if(params.frequency){
			
			depositServiceRequest.setFrequency(params.frequency);
		}
		if(params.noOfTimes){
			depositServiceRequest.setNumberOfTime(params.noOfTimes);
		}*/
		if(PaymentButtonEnum.PAYNOW.toString().equals(params?.buttonEvent)){   
			depositServiceRequest.setButtonType("PAYNOW")  
		}
		/*if(PaymentButtonEnum.LATER.toString().equals(params?.buttonEvent)){
			depositServiceRequest.setButtonType("LATER")
		}
		if(PaymentButtonEnum.REPEAT.toString().equals(params?.buttonEvent)){
			depositServiceRequest.setButtonType("REPEAT")
		}*/
		return depositServiceRequest;
	}
	


}

class UpdateInvestAccountNickNameCommand {
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

class InvestmentAccountDetailedStatementCommand{
	String lastNTransactionFilter,monthFilter,fromDate,uptoDate,debitCreditFilter,fromAmountFilter,toAmountFilter,referenceNumberFilter;
	static constraints={
		debitCreditFilter validator:{val,obj ->
			
			if(StringUtils.hasLength(obj.fromAmountFilter)){
				if(!StringUtils.hasLength(obj.lastNTransactionFilter) && !StringUtils.hasLength(obj.monthFilter) && !StringUtils.hasLength(obj.fromDate) && !StringUtils.hasLength(obj.uptoDate))
				{
					obj.errors.rejectValue('debitCreditFilter','investmentAccountDetailedStatementCommand.datemonthlastn.blank')
				}
				if(!StringUtils.hasLength(obj.toAmountFilter)){
					   obj.errors.rejectValue('debitCreditFilter','investmentAccountDetailedStatementCommand.toAmountFilter.blank')
				}
			}else if(StringUtils.hasLength(obj.toAmountFilter)){
				if(!StringUtils.hasLength(obj.lastNTransactionFilter) && !StringUtils.hasLength(obj.monthFilter) && !StringUtils.hasLength(obj.fromDate) && !StringUtils.hasLength(obj.uptoDate))
				{
					obj.errors.rejectValue('debitCreditFilter','investmentAccountDetailedStatementCommand.datemonthlastn.blank')
				}
				if(!StringUtils.hasLength(obj.fromAmountFilter)){
						   obj.errors.rejectValue('debitCreditFilter','investmentAccountDetailedStatementCommand.fromAmountFilter.blank')
				}
			}
		};
		fromDate validator :{val,obj->
			if(StringUtils.hasLength(obj.fromDate)){
				if(!StringUtils.hasLength(obj.uptoDate)){
					  obj.errors.rejectValue('fromDate','investmentAccountDetailedStatementCommand.uptoDate.blank')
				}
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Date currentDate = formatter.parse(formatter.format(new Date()))
				Date date = obj.uptoDate ? (Date)formatter.parse(obj.uptoDate):null;
				if(date.compareTo(currentDate)>0){
					obj.errors.rejectValue('fromDate','casaAccountDetailedStatementCommand.uptoDate.compare.error')
				}
			}else if(StringUtils.hasLength(obj.uptoDate)){
					if(!StringUtils.hasLength(obj.fromDate)){
						 obj.errors.rejectValue('fromDate','investmentAccountDetailedStatementCommand.fromDate.blank')
					}
					DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					Date currentDate = formatter.parse(formatter.format(new Date()))
					Date date = obj.uptoDate ? (Date)formatter.parse(obj.uptoDate):null;
					if(date.compareTo(currentDate)>0){
						obj.errors.rejectValue('fromDate','casaAccountDetailedStatementCommand.uptoDate.compare.error')
					}
			   }
		};
	}
}

class DepositRequestCommand{
	//String payerInstruction,amount,currency,depositType,tenantBranch,maturityInstruction,month,days,interestPayableFreq,interestPayableMode,creditAccountNumber;
	String payerInstruction,amount,currency,depositType,tenantBranch,maturityInstruction,month,creditAccountNumber;
	
	static constraints={
		payerInstruction(blank: false)
		amount(blank: false)
		amount validator:{val,obj ->
			
			if(StringUtils.hasLength(val) && val?.matches("[0-9]*"))
			{
				
							
				}else{
					obj.errors.rejectValue('amount','depositRequestCommand.amount.invalid')
				}
			
		};
		currency(blank: false)
		depositType(blank: false)
		tenantBranch(blank: false)
		maturityInstruction(blank: false)
		//interestPayableFreq(blank: false)
		month(blank: false)
		//days(blank: false) 
		//interestPayableMode(blank: false)
		creditAccountNumber(blank: false)
	

}

class InvestLaterCommand{
	String startDate;
	static constraints={
		startDate(blank: false)
	}
}

class InvestRecurringCommand{
	
	String startDate,frequency,noOfTimes;
	static constraints={
		startDate(blank: false)
		frequency(blank: false)
		noOfTimes(blank: false)
	}
	
}
}

