package com.vayana.ib.retail.web.service

import java.text.SimpleDateFormat

import org.springframework.data.domain.PageRequest
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils

import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.ib.bm.core.api.beans.constants.AttributeConstants
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardDetailRequest
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardDetailResponse
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardStatementRequest
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardStatementResponse
import com.vayana.ib.bm.core.api.model.enums.CreditCardTransactionTypeEnum
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService
import com.vayana.ib.bm.core.impl.service.util.IBDateUtils;

class CreditCardService extends GenericService{

	BmClient bmClient;

	def details(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		
		String creditCardNumber=params.creditCardNumber;
		CreditCardDetailRequest creditCardDetailRequest = getBean(CreditCardDetailRequest.class, requestHeader,params);
		//creditCardDetailRequest.setCreditCardNumber(creditCardNumber);
		creditCardDetailRequest.accountId = creditCardNumber?.toLong();
		CreditCardDetailResponse creditCardDetailResponse=bmClient.creditCardService.getCreditCardDetail(creditCardDetailRequest);		
		if(creditCardDetailResponse.hasErrors()){
			model << [errors:creditCardDetailResponse.errors()]			
			return;
		}
		else {
			
			model << [creditCardDetailModel:creditCardDetailResponse]		
				print "Credit Card::"+creditCardDetailResponse.creditCardAccount.accountNumber
				print "Credit cardType::"+creditCardDetailResponse.creditCardAccount.cardType
		}
	}
	def updatecreditcardnickname(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UpdateCreditCardNickNameCommand updateNickCommand = validateCommandObject(UpdateCreditCardNickNameCommand.class, params)
		//If Errors Not Found Prepare the Request and call BM.
		if (!updateNickCommand.hasErrors()){
			CommonRequest nickUpdateRequest = getBean(CommonRequest.class, requestHeader, params);
			nickUpdateRequest.setAttribute(AttributeConstants.ACCOUNT_NUMBER, params.accountNumber);
			nickUpdateRequest.setAttribute(AttributeConstants.ACCOUNT_SHORT_NAME, params.accountShortName);
			CommonResponse updateNickResponse = bmClient.creditCardService.updateCreditCardNickName(nickUpdateRequest);
			
			model << [creditCardNickModel:updateNickResponse]
		}else{
			model << [errors:updateNickCommand]
		}
	}   
	   
	def ministatement(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception{		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());        
		int currentMonth = cal.get(Calendar.MONTH) + 1;
		int currentYear = cal.get(Calendar.YEAR);
		String accountId=params.accountId;
		CreditCardStatementRequest creditCardStatementRequest=getBean(CreditCardStatementRequest.class, requestHeader, params);
		creditCardStatementRequest.setAccountId(accountId.toLong());
		creditCardStatementRequest.setTransactionTypeEnum(CreditCardTransactionTypeEnum.BILL);
		creditCardStatementRequest.setMonth(currentMonth);		
		creditCardStatementRequest.setYear(currentYear);	
		creditCardStatementRequest.sortBy="transactionDate";
		creditCardStatementRequest.lastNTransactionFilter= new Integer(10);
        CreditCardStatementResponse creditCardStatementResponse=bmClient.creditCardService.getCreditCardStatement(creditCardStatementRequest);		
		if(creditCardStatementResponse.hasErrors()){		
			model << [errors:creditCardStatementResponse.errors()]			
			return;
		}else{	
		
		model<< [accountId:accountId,credditCardStatementModel:creditCardStatementResponse,pagerModel:creditCardStatementResponse.getPage()]
		return;		
		}    
	}
	
	def detailedstatement(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		CreditCardDetailedStatementCommand creditCardDetailedStatementCommand =validateCommandObject(CreditCardDetailedStatementCommand.class,params);
		if(!creditCardDetailedStatementCommand.hasErrors()){
			CreditCardStatementRequest creditCardStatementRequest=getBean(CreditCardStatementRequest.class, requestHeader, params);
			
		String accountId=params.accountId;
		creditCardStatementRequest.setAccountId(accountId.toLong());
		creditCardStatementRequest.setTransactionTypeEnum(CreditCardTransactionTypeEnum.getTransactionTypeEnum(params.fundstype));
		creditCardStatementRequest.transactionStatus=params.fundstype;  
		Map<String,String> requestParams=new HashMap<String,String>(1)  
		requestParams.put("transactionType", params.filterparam);  
		if(params.lastNTransaction != ""){
			creditCardStatementRequest.fromDate=null
			creditCardStatementRequest.uptoDate=null
			creditCardStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
		    creditCardStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
			creditCardStatementRequest.lastNTransactionFilter=params.int("lastNTransaction")
			
		}else if(params.monthFilter != ""){
			Calendar cal	=	Calendar.getInstance();
			cal.setTime(new SimpleDateFormat("MMM-yyyy").parse(params.monthFilter));
			String endDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH)+"-"+params.monthFilter
			creditCardStatementRequest.fromDate=new Date("01-"+params.monthFilter)
			creditCardStatementRequest.uptoDate=new Date(endDate)
			creditCardStatementRequest?.lastNTransactionFilter= "0";			
		}else{
			creditCardStatementRequest.lastNTransactionFilter=10
		}
		
		if(creditCardStatementRequest.getTransactionTypeEnum().equals(CreditCardTransactionTypeEnum.UNBILL)){
			creditCardStatementRequest?.holdOfFund = "0";
		}else if(creditCardStatementRequest.getTransactionTypeEnum().equals(CreditCardTransactionTypeEnum.PEN)){
			creditCardStatementRequest?.holdOfFund = "1";
		}
		
		creditCardStatementRequest.debitCreditFilter=params.debitCreditFilter
		creditCardStatementRequest.referenceNumberFilter=params.referenceNumberFilter
		creditCardStatementRequest.setSortBy("transactionDate");
		CreditCardStatementResponse creditCardStatementResponse=bmClient.creditCardService.getCreditCardFullStatement(creditCardStatementRequest);
		print "Pager Model:"+creditCardStatementResponse?.getPage()
		model<< [transactionType:params.fundstype,credditCardStatementModel:creditCardStatementResponse,pagerModel:creditCardStatementResponse?.getPage()]
		}else{
		model<<[errors:creditCardDetailedStatementCommand]
		}
	}
	
	def statementgotopage(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		CreditCardStatementRequest creditCardStatementRequest=getBean(CreditCardStatementRequest.class, requestHeader, params);
		creditCardStatementRequest.setUserSession(getInvoker().getSessionId());
//		PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),appConfig.getInt("rowsPerPage"));
		PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),10);
		creditCardStatementRequest.setPageRequest(pageRequest);   
		if(params.sortBy!=null){
			creditCardStatementRequest.setSortBy(params.sortBy);
		}else{
			creditCardStatementRequest.setSortBy("transactionDate");
		}
		if(params.sortOrder!=null){
		creditCardStatementRequest.setSortOrder(params.sortOrder);
		}	
		
		CreditCardStatementResponse creditCardStatementResponse=bmClient.creditCardService.getCreditCardStatementPage(creditCardStatementRequest);		
		if(creditCardStatementResponse.hasErrors()){
			model << [errors:creditCardStatementResponse.errors()]
			return;
		}else{		
		model<< [credditCardStatementModel:creditCardStatementResponse,pagerModel:creditCardStatementResponse.getPage()]
		return;
		}
		
	}
	
	def statementfilter(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		CreditCardDetailedStatementCommand creditCardDetailedStatementCommand =validateCommandObject(CreditCardDetailedStatementCommand.class,params);
	if(!creditCardDetailedStatementCommand.hasErrors()){
		CreditCardStatementRequest creditCardStatementRequest=getBean(CreditCardStatementRequest.class, requestHeader, params);
		String accountId=params.accountId;
		creditCardStatementRequest.setAccountId(accountId.toLong());
//		creditCardStatementRequest.cardNumber=params.accountNumber;
		creditCardStatementRequest.setTransactionTypeEnum(CreditCardTransactionTypeEnum.getTransactionTypeEnum(params.filter));
		creditCardStatementRequest.transactionStatus=params.filter;  
		Map<String,String> requestParams=new HashMap<String,String>(1)  
		requestParams.put("transactionType", params.filterparam);
		if(params.lastNTransaction != ""){
			creditCardStatementRequest.fromDate=null
			creditCardStatementRequest.uptoDate=null
			creditCardStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
		    creditCardStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
			creditCardStatementRequest.lastNTransactionFilter=params.int("lastNTransaction")
			
		}else if(params.monthFilter != ""){
			Calendar cal	=	Calendar.getInstance();
			cal.setTime(new SimpleDateFormat("MMM-yyyy").parse(params.monthFilter));
			String endDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH)+"-"+params.monthFilter
			creditCardStatementRequest.fromDate=new Date("01-"+params.monthFilter)
			creditCardStatementRequest.uptoDate=new Date(endDate)
			//creditCardStatementRequest.month=cal.get(Calendar.MONTH)+1;
			//creditCardStatementRequest.year=cal.get(Calendar.YEAR);
			//creditCardStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
			//creditCardStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
			creditCardStatementRequest?.lastNTransactionFilter= "0";			
		}
		/*else if(params.fromDate !="" && params.uptoDate!=""){
		   creditCardStatementRequest.setFromDate(DateUtils.convertStringToDate(params.fromDate, DateUtils.YYYY_MM_DD));
		   creditCardStatementRequest.setUptoDate(DateUtils.convertStringToDate(params.uptoDate, DateUtils.YYYY_MM_DD));
		   creditCardStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
		   creditCardStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
		   creditCardStatementRequest.lastNTransactionFilter=null
		 }*/
		/*else if(params.fromAmountFilter != "" && params.toAmountFilter != ""){
		    creditCardStatementRequest.fromDate=null
			creditCardStatementRequest.uptoDate=null
			creditCardStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
			creditCardStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
			creditCardStatementRequest.lastNTransactionFilter=null
		}*/
		if(creditCardStatementRequest.getTransactionTypeEnum().equals(CreditCardTransactionTypeEnum.UNBILL)){
			creditCardStatementRequest?.holdOfFund = "0";
		}else if(creditCardStatementRequest.getTransactionTypeEnum().equals(CreditCardTransactionTypeEnum.PEN)){
			creditCardStatementRequest?.holdOfFund = "1";
		}
		
		creditCardStatementRequest.debitCreditFilter=params.debitCreditFilter
		creditCardStatementRequest.referenceNumberFilter=params.referenceNumberFilter
		creditCardStatementRequest.setSortBy("transactionDate");
		CreditCardStatementResponse creditCardStatementResponse=bmClient.creditCardService.getCreditCardFullStatement(creditCardStatementRequest);
		print "Pager Model:"+creditCardStatementResponse?.getPage()
		model<< [transactionType:params.filter,credditCardStatementModel:creditCardStatementResponse,pagerModel:creditCardStatementResponse?.getPage()]
		}else{
		model<<[errors:creditCardDetailedStatementCommand]
		}
		
	}
		
	def currentstatement(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception{
			
		CreditCardStatementResponse creditCardStatementResponse = null;
		
		String accountId=params.accountId;
		String transactionType=params.filter;
		Map<String,String> requestParams=new HashMap<String,String>(1)
		requestParams.put("transactionType", params.filter);
		CreditCardStatementRequest creditCardStatementRequest=getBean(CreditCardStatementRequest.class, requestHeader, params);
		creditCardStatementRequest.setAccountId(accountId.toLong());
		creditCardStatementRequest.setTransactionTypeEnum(CreditCardTransactionTypeEnum.getTransactionTypeEnum(params.filter));
		
		
		//PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),appConfig.getInt("rowsPerPage"));
		PageRequest pageRequest= new PageRequest(0,10);
		creditCardStatementRequest.setPageRequest(pageRequest);
		if(params.sortBy!=null){
			creditCardStatementRequest.setSortBy(params.sortBy);
		}else{
			creditCardStatementRequest.setSortBy("transactionDate");
		}
		if(params.sortOrder!=null){
		creditCardStatementRequest.setSortOrder(params.sortOrder);
		}
		creditCardStatementRequest.setRequestParams(requestParams);
		
		if(creditCardStatementRequest.getTransactionTypeEnum().equals(CreditCardTransactionTypeEnum.BILL))
		{
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			int currentMonth = cal.get(Calendar.MONTH) + 1;
			int currentYear = cal.get(Calendar.YEAR);
			creditCardStatementRequest.setMonth(currentMonth);
			creditCardStatementRequest.setYear(currentYear);
			creditCardStatementRequest?.lastNTransactionFilter= new Integer(10);
			creditCardStatementResponse=bmClient.creditCardService.getCreditCardStatement(creditCardStatementRequest);
		}
		else if(creditCardStatementRequest.getTransactionTypeEnum().equals(CreditCardTransactionTypeEnum.UNBILL))
		{
			/* Set the Start and the End Dates */
			Calendar firstDay = Calendar.getInstance();
			firstDay.set(Calendar.DAY_OF_MONTH, 1);
			creditCardStatementRequest.setFromDate(IBDateUtils.getDateWithMinHourOfDay(firstDay.getTime()));
			creditCardStatementRequest.setUptoDate(IBDateUtils.getDateWithMaxHourOfDay(new Date()));
			creditCardStatementRequest?.holdOfFund = "0";
			creditCardStatementRequest?.lastNTransactionFilter= new Integer(10);
			creditCardStatementResponse=bmClient.creditCardService.getCreditCardFullStatement(creditCardStatementRequest);
		}
		else if(creditCardStatementRequest.getTransactionTypeEnum().equals(CreditCardTransactionTypeEnum.PEN))
		{
			/* Set the Start and End Dates */
			Calendar firstDay = Calendar.getInstance();
			firstDay.set(Calendar.DAY_OF_MONTH, 1);
			creditCardStatementRequest.setFromDate(IBDateUtils.getDateWithMinHourOfDay(firstDay.getTime()));
			creditCardStatementRequest.setUptoDate(IBDateUtils.getDateWithMaxHourOfDay(new Date()));
			creditCardStatementRequest?.holdOfFund = "1";
			creditCardStatementRequest?.lastNTransactionFilter= new Integer(10);
			creditCardStatementResponse=bmClient.creditCardService.getCreditCardFullStatement(creditCardStatementRequest);
		}
		
		
		if(creditCardStatementResponse.hasErrors()){
			model << [errors:creditCardStatementResponse.errors()]
			return;
		}else{
				
		model<< [transactionType:transactionType,credditCardStatementModel:creditCardStatementResponse,pagerModel:creditCardStatementResponse.getPage()]	
		
		return;
		}
		
			
	}
}

class UpdateCreditCardNickNameCommand {
	String accountNumber, accountShortName;
	static constraints = {
	   accountNumber(blank: false)
	   accountShortName(blank: false)
	}
}
class CreditCardDetailedStatementCommand{
	String lastNTransaction,monthFilter,fromDate,uptoDate,debitCreditFilter,fromAmountFilter,toAmountFilter,referenceNumberFilter;
	static constraints={
		debitCreditFilter validator:{val,obj ->
			
			if(StringUtils.hasLength(obj.fromAmountFilter)){
				if(!StringUtils.hasLength(obj.lastNTransaction) && !StringUtils.hasLength(obj.monthFilter)){
					obj.errors.rejectValue('debitCreditFilter','creditCardDetailedStatementCommand.datemonthlastn.blank')
				}
				if(!StringUtils.hasLength(obj.toAmountFilter)){
					   obj.errors.rejectValue('debitCreditFilter','creditCardDetailedStatementCommand.toAmountFilter.blank')
				}
			}else if(StringUtils.hasLength(obj.toAmountFilter)){
				if(!StringUtils.hasLength(obj.lastNTransaction) && !StringUtils.hasLength(obj.monthFilter)){
					obj.errors.rejectValue('debitCreditFilter','creditCardDetailedStatementCommand.datemonthlastn.blank')
				}
				if(!StringUtils.hasLength(obj.fromAmountFilter)){
						   obj.errors.rejectValue('debitCreditFilter','creditCardDetailedStatementCommand.fromAmountFilter.blank')
				}
			}
		};
		/*fromDate validator :{val,obj->
			if(StringUtils.hasLength(obj.fromDate)){
				if(!StringUtils.hasLength(obj.uptoDate)){
					  obj.errors.rejectValue('fromDate','creditCardDetailedStatementCommand.uptoDate.blank')
				}
			}else if(StringUtils.hasLength(obj.uptoDate)){
					if(!StringUtils.hasLength(obj.fromDate)){
						 obj.errors.rejectValue('fromDate','creditCardDetailedStatementCommand.fromDate.blank')
					}
			   }
		};*/
	}
}

