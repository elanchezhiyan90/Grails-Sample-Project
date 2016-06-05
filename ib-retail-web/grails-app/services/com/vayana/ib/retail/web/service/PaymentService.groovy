
package com.vayana.ib.retail.web.service

import java.math.RoundingMode
import java.text.DateFormat
import java.text.SimpleDateFormat

import javax.servlet.http.HttpSession

import org.springframework.data.domain.PageRequest
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils

import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.ContextCodeType
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.constants.BusinessFunctionConstants
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants
import com.vayana.bm.core.api.model.common.Currency
import com.vayana.ib.bm.core.api.beans.account.AccountBalanceRequest
import com.vayana.ib.bm.core.api.beans.account.AccountBalanceResponse
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailsRequest
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailsResponse
import com.vayana.ib.bm.core.api.beans.charges.ChargeResponse
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardDetailRequest
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardDetailResponse
import com.vayana.ib.bm.core.api.beans.exchangerate.ExchangeRateResponse
import com.vayana.ib.bm.core.api.beans.investment.InvestmentDetailRequest
import com.vayana.ib.bm.core.api.beans.investment.InvestmentDetailResponse
import com.vayana.ib.bm.core.api.beans.loan.LoanDetailsRequest
import com.vayana.ib.bm.core.api.beans.loan.LoanDetailsResponse
import com.vayana.ib.bm.core.api.beans.payment.FavouritePaymentDetailRequest
import com.vayana.ib.bm.core.api.beans.payment.FavouritePaymentDetailResponse
import com.vayana.ib.bm.core.api.beans.payment.FavouritePaymentRequest
import com.vayana.ib.bm.core.api.beans.payment.FavouritePaymentResponse
import com.vayana.ib.bm.core.api.beans.payment.PastPaymentReviewRequest
import com.vayana.ib.bm.core.api.beans.payment.PastPaymentReviewResponse
import com.vayana.ib.bm.core.api.beans.payment.PaymentDetailRequest
import com.vayana.ib.bm.core.api.beans.payment.PaymentDetailResponse
import com.vayana.ib.bm.core.api.beans.payment.SIViewAndUpdateRequest
import com.vayana.ib.bm.core.api.beans.payment.SIViewAndUpdateResponse
import com.vayana.ib.bm.core.api.beans.payment.TransactionLimitRequest
import com.vayana.ib.bm.core.api.beans.payment.TransactionLimitResponse
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardDetailRequest
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardDetailResponse
import com.vayana.ib.bm.core.api.beans.security.SecurityHolder
import com.vayana.ib.bm.core.api.beans.standingorder.StandingOrderInformationRequest
import com.vayana.ib.bm.core.api.beans.standingorder.StandingOrderInformationResponse
import com.vayana.ib.bm.core.api.beans.transfers.FundTransferRequest
import com.vayana.ib.bm.core.api.beans.transfers.FundTransferResponse
import com.vayana.ib.bm.core.api.beans.transfers.PaymentTransferRequest
import com.vayana.ib.bm.core.api.beans.transfers.PaymentTransferResponse
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileResponse
import com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction
import com.vayana.ib.bm.core.api.model.enums.PaymentButtonEnum
import com.vayana.ib.bm.core.api.model.enums.PaymentModuleTypeEnum
import com.vayana.ib.bm.core.api.model.enums.PaymentTypeEnum
import com.vayana.ib.bm.core.api.model.enums.SOFlagEnum
import com.vayana.ib.bm.core.api.model.enums.SchedulePaymentEnum
import com.vayana.ib.bm.core.api.model.enums.TransactionTypeEnum
import com.vayana.ib.bm.core.api.model.enums.TwoFactorTypeEnum
import com.vayana.ib.bm.core.api.model.payment.PaymentDetail
import com.vayana.ib.bm.core.api.model.payment.PaymentScheduleDetail
import com.vayana.ib.bm.core.api.model.payment.PaymentScheduleHeader
import com.vayana.ib.bm.core.impl.service.util.IBCommonUtil
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class PaymentService extends GenericService{
	
	BmClient bmClient
	CommonService commonService
	IBCommonUtil iBCommonUtil
	
	private static final PROCESS_PAYNOW_ACTION="processfundtransfer"
	private static final PROCESS_PAYLATER_ACTION="processfundpaylater"
	private static final PROCESS_REPEAT_ACTION="processfundschedulepayment"
	private static final PAYMENT_CONTROLLER="payment"
	private static final CANCEL_PAYMENT_ACTION="confirmCancelSIPayment";
	private static final APPROVE_PAYMENT_ACTION="approveFundTransfer";
	private static final REJECT_PAYMENT_ACTION="rejectFundTransfer";
	private static final CC_EXCESS_TRANSFER = "CCExcessTransfer";
	
	def ownaccountpayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		
		FavouritePaymentDetailRequest favouritePaymentDetailRequest=getBean(FavouritePaymentDetailRequest.class, requestHeader, params);
		favouritePaymentDetailRequest.setAccountId(params.beneId.toLong())
		FavouritePaymentDetailResponse favouritePaymentDetailResponse=bmClient.paymentService.getOwnAccountFavouritePayments(favouritePaymentDetailRequest);
		if(favouritePaymentDetailResponse.hasErrors()){
			model<<[errors:favouritePaymentDetailResponse.errors()]
		}else{
			session.removeAttribute("FTR")
			model<<[favPaymentDetailModel:favouritePaymentDetailResponse]
			}

	}
	
	def friendsandfamilypayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		FavouritePaymentDetailRequest favouritePaymentDetailRequest=getBean(FavouritePaymentDetailRequest.class, requestHeader, params);
		
		favouritePaymentDetailRequest.setBeneId(params?.beneId?.toLong())
		FavouritePaymentDetailResponse favouritePaymentDetailResponse=bmClient.paymentService.getBeneFavouritePayments(favouritePaymentDetailRequest);
		if(favouritePaymentDetailResponse.hasErrors()){
			model<<[errors:favouritePaymentDetailResponse.errors()]
		}else{
			session.removeAttribute("FTR")
			model<<[favPaymentDetailModel:favouritePaymentDetailResponse]
			}
		
	}
	def transferAccountsCurrency(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		CommonRequest request =  getBean(CommonRequest.class, requestHeader, null);
		PaymentTransferRequest paymentRequest = getBean(PaymentTransferRequest.class, requestHeader, null);
		PaymentTransferResponse response ;
		List transferCurrency = []
		Long accountId ;
						
		if(params.payeeId)		{
			paymentRequest.setPayeeId(params.payeeId.toLong())
			response = 	bmClient.paymentService.getPayee(paymentRequest);
			transferCurrency.add(response.getPayee().getCurrency())
		}
		if(params.payerId)		{
			paymentRequest.setPayerId(params.payerId.toLong())
			response = 	bmClient.paymentService.getPayer(paymentRequest);
			transferCurrency.add(response.getPayer().getCurrency())
		}
		
		
		CasaAccountDetailsRequest casaAccountDetailsRequest = getBean(CasaAccountDetailsRequest.class, requestHeader,null);
		casaAccountDetailsRequest.accountId = params.payerId.toLong();
		CasaAccountDetailsResponse casaAccountDetailsResponse = bmClient.accountService.getCasaAccountDetails(casaAccountDetailsRequest);
		model<<[transferCurrency:transferCurrency,accountBalanceModel:casaAccountDetailsResponse]
	}
	
	def ownaccountbalanceandexgrate(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		def transferCurrency = [] as HashSet<Currency>;  
//		String fromCurrency="",toCurrency="";
//		String exchangeRate="";
//		Long accountId ;
		Long fromCurrencyId;
		
		/*//  Added to check SME matrix combination of from accountNumber and toAccount transactionSubType for the sme users starts
		PaymentTransferRequest paymenttransRequest = getBean(PaymentTransferRequest.class, requestHeader, null);
		paymenttransRequest.setPayerId(getIdVersion(params.payerId)[0])
		PaymentTransferResponse paymentTransResponse =bmClient.paymentService.validateSmeMatrix(paymenttransRequest);
		//  Add to check SME matrix combination of from account number and toAccount transactionSubType for the sme users ends
		*/		
//		To get From Currency with account ID
		if(params?.payerId){
			PaymentTransferRequest paymentRequest = getBean(PaymentTransferRequest.class, requestHeader, null);
			paymentRequest.payerId 	=	getIdVersion(params?.payerId)[0];
			PaymentTransferResponse paymentTransferResponse  = 	bmClient.paymentService.getPayer(paymentRequest);
			if(paymentTransferResponse.hasErrors()) {
				model<<[errors:paymentTransferResponse.errors()]
			}
			Currency frmCurrencyObj	=   paymentTransferResponse?.payer?.currency;
//			fromCurrency			=	frmCurrencyObj?.code;
			fromCurrencyId			=	frmCurrencyObj?.id;
			transferCurrency.add(frmCurrencyObj);
		}
		//To get To Currency from BeneId
		if(params?.payeeId) {
			CommonRequest commonRequest		=		getBean(CommonRequest.class, requestHeader, null);
			commonRequest.setAttribute("beneId", params.payeeId) ;
			CommonResponse commonResponse	=	bmClient.iBCommonService.getCurrencyByBeneId(commonRequest)
			if(commonResponse.hasErrors()) {
				model<<[errors:commonResponse.errors()]
			}
			Currency toCurrencyObj	=	commonResponse.getAttribute("beneCurrency");
//			toCurrency	=	toCurrencyObj?.code;
//	Get the ExchangeRate from BM
//			exchangeRate = 1+" "+toCurrency;
//			if(!fromCurrency.equals(toCurrency)) {
				transferCurrency.add(toCurrencyObj);
				/*ExchangeRateRequest exchangeRateRequest	=	getBean(ExchangeRateRequest.class, requestHeader, null);
				exchangeRateRequest.fromCurrency 	=	fromCurrency;
				exchangeRateRequest.toCurrency		=	toCurrency;
				ExchangeRateResponse exchangeRateResponse	=	bmClient.accountService.getExchangeRate(exchangeRateRequest);*/
//				exchangeRate	=	exchangeRateResponse.getExchangeRate()+" "+toCurrency;
//			}
		}
	// Get the from Account Balance	
		AccountBalanceRequest accountBalanceRequest  =  getBean(AccountBalanceRequest.class, requestHeader, null);
		accountBalanceRequest.accountId  = getIdVersion(params?.payerId)[0];
 		AccountBalanceResponse accountBalanceResponse	= commonService.getAccountBalance(accountBalanceRequest);
		if(accountBalanceResponse.hasErrors()) {
			model<<[errors:accountBalanceResponse.errors()]
		}  
		setSessionAttribute("BAL", accountBalanceResponse)	  
		
		/*transactionLimitRequest.setPayeeInstruction(params?.payeeId?.toLong())  
		transactionLimitRequest.setFromCurrencyId(fromCurrencyId)
		Long userLoginProfileId = getInvoker().getUserLoginProfileId();
		transactionLimitRequest.setUserLoginProfileId(userLoginProfileId);*/
		
		
		TransactionLimitResponse transactionLimitResponse = getPayerLimitDetails(requestHeader,params?.payeeId?.toLong(),fromCurrencyId,getInvoker().getUserLoginProfileId());
		if(transactionLimitResponse.hasErrors()) {
			model<<[errors:transactionLimitResponse.errors()]
		}
		setSessionAttribute("LIMIT", transactionLimitResponse)
		model<<[accountBalanceModel:accountBalanceResponse,transferCurrency:transferCurrency.toList(),limitModel:transactionLimitResponse]
	} 
	
	
	private PaymentTransferResponse getPayerAccountDetails(GenericRequestHeader requestHeader,Long payerId){
		PaymentTransferRequest paymentRequest 		= 	getBean(PaymentTransferRequest.class, requestHeader, null);
		paymentRequest.setPayerId(payerId);
		PaymentTransferResponse response = bmClient.paymentService.getPayer(paymentRequest);
		return response;
	}
	/**
	 * 
	 * @param requestHeader
	 * @param payeeInstructionId
	 * @param payerCurrencyId
	 * @param ulpId
	 * @return
	 */
	private TransactionLimitResponse getPayerLimitDetails(GenericRequestHeader requestHeader, Long payeeInstructionId, Long payerCurrencyId, Long ulpId){
		TransactionLimitRequest transactionLimitRequest		=	new TransactionLimitRequest();
		transactionLimitRequest.setRequestHeader(requestHeader);
		transactionLimitRequest.setPayeeInstruction(payeeInstructionId);
		transactionLimitRequest.setFromCurrencyId(payerCurrencyId);
		transactionLimitRequest.setUserLoginProfileId(ulpId);
		TransactionLimitResponse transactionLimitResponse	=	bmClient.paymentService.fetchTransactionalLimit(transactionLimitRequest);
		return transactionLimitResponse;
	}
	
	 
	def fromaccountbalanceandexgrate(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		
 		PaymentTransferRequest paymentRequest = getBean(PaymentTransferRequest.class, requestHeader, null);		
		PaymentTransferResponse response ;
		 CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, null);
		def transferCurrency = [] as HashSet<Currency>;
		String fromCurrency,toCurrency="";   
		String exchangeRate="";
		String transactionType='';
		Long accountId ;
		Long fromCurrencyId;
//		To get From Currency with account ID
		if(params.payerId){
			
			paymentRequest.setPayerId(getIdVersion(params.payerId)[0])
			response = 	bmClient.paymentService.getPayer(paymentRequest);
			fromCurrency=response.getPayer().getCurrency().getCode();
			fromCurrencyId=response.getPayer().getCurrency().getId();
			transferCurrency.add(response.getPayer().getCurrency())
		}
				
		if(params?.payeeId != null && !"".equals(params?.payeeId) && !"undefined".equalsIgnoreCase(params?.payeeId)) {
	//		To get To Currency from BeneId
			commonRequest.setAttribute("beneId", params.payeeId) ;
			com.vayana.bm.core.api.model.common.Currency toCurrencyobj = null;
			CommonResponse commonResponse=bmClient.iBCommonService.getCurrencyByBeneId(commonRequest)
			if(commonResponse.additionalInfoMap != null && !commonResponse.additionalInfoMap?.isEmpty()){
				toCurrencyobj	=	commonResponse.getAttribute("beneCurrency");
				transactionType = 	commonResponse.getAdditionalInfo("TT")
			}else{
				commonResponse=bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
				toCurrencyobj	=	commonResponse.getCommonEntity()
			}
			toCurrency		=	toCurrencyobj?.code;
			if(!fromCurrency.equals(toCurrency)){
				transferCurrency.add(toCurrencyobj)
			}
		
		}
		
		if(CC_EXCESS_TRANSFER.equals(params?.transferEvent)){
			CommonResponse commonResponse=bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
			transferCurrency.clear();
			transferCurrency.add(commonResponse?.commonEntity)
		}
		
		AccountBalanceRequest accountBalanceRequest=getBean(AccountBalanceRequest.class, requestHeader, null);
		accountBalanceRequest.accountId= getIdVersion(params.payerId)[0];
		 AccountBalanceResponse accountBalanceResponse= commonService.getAccountBalance(accountBalanceRequest);
		setSessionAttribute("BAL", accountBalanceResponse)		
		
		model<<[accountBalanceModel:accountBalanceResponse,transferCurrency:transferCurrency?.toList(),exchangeRateModel:exchangeRate,transactionType:transactionType]
	}   
		
	def processfundtransfer(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
	 	if(securityHolder!=null && securityHolder.isValidated) {	  	      
	 		FundTransferResponse fundTransferResponse=null;  
	  		FundTransferRequest fundTransferRequest=(FundTransferRequest)getSessionAttribute("FTR");
			String transferType= fundTransferRequest?.transferType;
			String transactionType = fundTransferRequest?.transactionType;
			//fundTransferRequest.setPaymentType(TransactionTypeEnum.FF); --SENBA
			String methodName	=	PaymentTypeEnum.valueOf(transferType).getKey()
			FundTransferRequest[] ftr	=	new FundTransferRequest[1];  
			ftr[0]	=	fundTransferRequest;
			fundTransferResponse=bmClient.paymentService.invokeMethod(methodName, ftr[0])
		    if(fundTransferResponse.hasErrors()) {
				session.removeAttribute("FTR")
				model<<[errors:fundTransferResponse.errors()]
			} else {
				session.removeAttribute("FTR")
				/*This line is added to remove the account summ model from session during login. Refer HomeService.groovy homepage*/
				session.removeAttribute("actsumModel");
				model<<[transferResponseModel:fundTransferResponse,transferRequestModel:fundTransferRequest,transferType:transferType,transactionType:transactionType]   
			}
		} else {
			throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.UNSUPPORTED_OPERATION, "Security Breach", null)
		}
     }
	
	def ownscheduledfavourite(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
	log.info("-------------------------------------------------------")	
	log.info("-----------------ownscheduledfavourite in PaymentService.groovy-----------------")
	FavouritePaymentRequest favouritePaymentRequest=getBean(FavouritePaymentRequest.class, requestHeader, params);
	favouritePaymentRequest.setPaymentDetailId(params.long('paymentId'))
	log.info("FAV - Payment Detail Id ::"+favouritePaymentRequest.getPaymentDetailId());
	favouritePaymentRequest.setPayeeInstructionId(params.long('beneId'))
	log.info("FAV - Payee Instruction Id ::"+favouritePaymentRequest?.payeeInstructionId);
	favouritePaymentRequest.setIbUserLoginProfileId(getUserLoginProfile().getId())
	log.info("FAV - User Login Profile Id ::"+favouritePaymentRequest?.ibUserLoginProfileId)
	favouritePaymentRequest.setPaymentType("SP");
	log.info("FAV - Payment Type ::"+favouritePaymentRequest?.paymentType)
	favouritePaymentRequest.setFavouriteType("OA");
	log.info("FAV - Favourite Type ::"+favouritePaymentRequest?.favouriteType)
	favouritePaymentRequest.setPayeeId(params.long('payeeId'))
	log.info("FAV - Payee Id ::"+favouritePaymentRequest?.payeeId)
	favouritePaymentRequest.setFavouriteFlag(params.favouriteId);
	log.info("FAV - Favourite Flag ::"+favouritePaymentRequest?.favouriteFlag)
	log.info("FAV - Invoking createOwnFavouritePayment BM Method in PaymentService Impl")
	log.info("-------------------------------------------------------")
	FavouritePaymentResponse favouritePaymentResponse=bmClient.paymentService.createOwnFavouritePayment(favouritePaymentRequest);
	if(favouritePaymentResponse.hasErrors()){
		model<< [errors:favouritePaymentResponse]
	}else{
		model<< [favPaymentModel:favouritePaymentResponse]
	}
  }
	
	def ownpastpaymentfavourite(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		log.info("-------------------------------------------------------")
		log.info("---------------ownpastpaymentfavourite in PaymentService.groovy-----------------")
	FavouritePaymentRequest favouritePaymentRequest=getBean(FavouritePaymentRequest.class, requestHeader, params);
	
	favouritePaymentRequest.setPaymentDetailId(params.long('paymentId'))
	log.info("FAV - Payment Detail Id ::"+favouritePaymentRequest?.paymentDetailId);
	favouritePaymentRequest.setPayeeInstructionId(params.long('beneId')) 
	log.info("FAV - Payee Instruction Id ::"+favouritePaymentRequest?.payeeInstructionId);
	favouritePaymentRequest.setIbUserLoginProfileId(getUserLoginProfile().getId())
	log.info("FAV - User Login Profile Id ::"+favouritePaymentRequest?.ibUserLoginProfileId)
	favouritePaymentRequest.setPaymentType("PP");
	log.info("FAV - Payment Type ::"+favouritePaymentRequest?.paymentType)
	favouritePaymentRequest.setFavouriteType("OA");
	log.info("FAV - Favourite Type ::"+favouritePaymentRequest?.favouriteType)
	favouritePaymentRequest.setPayeeId(params.long('payeeId'))
	log.info("FAV - Payee Id ::"+favouritePaymentRequest?.payeeId)
	favouritePaymentRequest.setFavouriteFlag(params.favouriteId);
	log.info("FAV - Favourite Flag ::"+favouritePaymentRequest?.favouriteFlag)
	log.info("FAV - Invoking createOwnFavouritePayment BM Method in PaymentService Impl")
	log.info("-------------------------------------------------------")
	FavouritePaymentResponse favouritePaymentResponse=bmClient.paymentService.createOwnFavouritePayment(favouritePaymentRequest);
	if(favouritePaymentResponse.hasErrors()){
		model<< [errors:favouritePaymentResponse]
	}else{
		model<< [favPaymentModel:favouritePaymentResponse]
	}
  }
	
	def benepastpaymentfavourite(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		log.info("-------------------------------------------------------")
		log.info("----------------benepastpaymentfavourite in PaymentService.groovy-------------------")
	FavouritePaymentRequest favouritePaymentRequest=getBean(FavouritePaymentRequest.class, requestHeader, params);
	favouritePaymentRequest.setPaymentDetailId(params.long('paymentId'))
	log.info("FAV - Payment Detail Id ::"+favouritePaymentRequest?.paymentDetailId);
	favouritePaymentRequest.setIbUserLoginProfileId(getUserLoginProfile().getId())
	log.info("FAV - User Login Profile Id ::"+favouritePaymentRequest?.ibUserLoginProfileId)
	favouritePaymentRequest.setPaymentType("PP");
	log.info("FAV - Payment Type ::"+favouritePaymentRequest?.paymentType)
	favouritePaymentRequest.setFavouriteType("FF");
	log.info("FAV - Favourite Type ::"+favouritePaymentRequest?.favouriteType)
	favouritePaymentRequest.setBeneId(params.long('payeeId'))
	log.info("FAV - Bene Id ::"+favouritePaymentRequest?.beneId)
	favouritePaymentRequest.setFavouriteFlag(params.favouriteId);
	log.info("FAV - Favourite Flag ::"+favouritePaymentRequest?.favouriteFlag)
	log.info("FAV - Invoking createOwnFavouritePayment BM Method in PaymentService Impl")
	log.info("-------------------------------------------------------")
	FavouritePaymentResponse favouritePaymentResponse=bmClient.paymentService.createBeneFavouritePayment(favouritePaymentRequest);
	if(favouritePaymentResponse.hasErrors()){
		model<< [errors:favouritePaymentResponse]
	}else{
		model<< [favPaymentModel:favouritePaymentResponse]
	}
  }
	
	def benescheduledfavourite(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		log.info("-------------------------------------------------------")
		log.info("----------------benescheduledfavourite in PaymentService.groovy------------------")
	FavouritePaymentRequest favouritePaymentRequest=getBean(FavouritePaymentRequest.class, requestHeader, params);
	favouritePaymentRequest.setPaymentDetailId(params.long('paymentId'))
	log.info("FAV - Payment Detail Id ::"+favouritePaymentRequest?.paymentDetailId);
	favouritePaymentRequest.setIbUserLoginProfileId(getUserLoginProfile().getId())
	log.info("FAV - User Login Profile Id ::"+favouritePaymentRequest?.ibUserLoginProfileId)
	favouritePaymentRequest.setPaymentType("SP");
	log.info("FAV - Payment Type ::"+favouritePaymentRequest?.paymentType)
	favouritePaymentRequest.setFavouriteType("FF"); 
	log.info("FAV - Favourite Type ::"+favouritePaymentRequest?.favouriteType)
	favouritePaymentRequest.setBeneId(params.long('beneId'))
	log.info("FAV - Bene Id ::"+favouritePaymentRequest?.beneId)
	favouritePaymentRequest.setFavouriteFlag(params.favouriteId);
	log.info("FAV - Favourite Flag ::"+favouritePaymentRequest?.favouriteFlag)
	log.info("FAV - Invoking createOwnFavouritePayment BM Method in PaymentService Impl")
	log.info("-------------------------------------------------------")
	FavouritePaymentResponse favouritePaymentResponse=bmClient.paymentService.createBeneFavouritePayment(favouritePaymentRequest);
	if(favouritePaymentResponse.hasErrors()){
		model<< [errors:favouritePaymentResponse]
	}else{
		model<< [favPaymentModel:favouritePaymentResponse]
	}
  }
	
	def discardPaymentFavourite(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		log.info("---------------------------------------------------------------------");
		log.info("------discardPaymentFavourite in PaymentService.groovy------");
		FavouritePaymentRequest favouritePaymentRequest=getBean(FavouritePaymentRequest.class, requestHeader, params);
		favouritePaymentRequest.paymentFavouriteId = (params?.paymentFavouriteId) ? params?.long('paymentFavouriteId') : null;
		if(favouritePaymentRequest?.paymentFavouriteId != null){
			FavouritePaymentResponse favouritePaymentResponse=bmClient.paymentService.discardPaymentFavourite(favouritePaymentRequest);
			if(favouritePaymentResponse.hasErrors()){
				model<< [errors:favouritePaymentResponse]
			}else{
				model<< [favPaymentModel:favouritePaymentResponse]
			}
		}
	}
	def exchangeRateAndLimit(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		    		
		PaymentTransferRequest paymentRequest = getBean(PaymentTransferRequest.class, requestHeader, null);  
		PaymentTransferResponse response ;   
	  	CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, null);    
  		TransactionLimitRequest transactionLimitRequest=new TransactionLimitRequest();    
		  transactionLimitRequest.setRequestHeader(requestHeader);
		def transferCurrency = [] as HashSet<Currency>;
		String fromCurrency,toCurrency="";
		Long fromCurrencyId;
		String exchangeRate="";
		Long accountId ;  
		String transactionType="";
		String transactionSubType ="";
		
		
		/*//  Added to check SME matrix combination of from accountNumber and toAccount transactionSubType for the sme users starts
		
		PaymentTransferRequest paymenttransferRequest = getBean(PaymentTransferRequest.class, requestHeader, null);
		if(params.payerId){
		paymenttransferRequest.setPayerId(getIdVersion(params.payerId)[0])
		}
		paymenttransferRequest.setPayeeId(Long.parseLong(params.payeeId))
		PaymentTransferResponse paymentTransferResponse =bmClient.paymentService.validateSmeMatrix(paymenttransferRequest);   
//		if(paymentTransferResponse.hasErrors()){        
//			model<< [errors:paymentTransferResponse]     
//		}   
		
	//  Add to check SME matrix combination of from account number and toAccount transactionSubType for the sme users ends
		*/
		
//		To get From Currency with account ID
		if(params?.payerId){
			
			paymentRequest.setPayerId(getIdVersion(params.payerId)[0])
			response = 	bmClient.paymentService.getPayer(paymentRequest);
			fromCurrency=response.getPayer().getCurrency().getCode();
			fromCurrencyId=response.getPayer().getCurrency().getId();
			transferCurrency.add(response.getPayer().getCurrency())
			
		}
		if(params?.payeeId)  
		{
	//		To get To Currency from BeneId
				commonRequest.setAttribute("beneId", params.payeeId) ;
				com.vayana.bm.core.api.model.common.Currency toCurrencyobj = null;
				CommonResponse commonResponse=bmClient.iBCommonService.getCurrencyByBeneId(commonRequest)
				if(commonResponse.additionalInfoMap != null && !commonResponse.additionalInfoMap?.isEmpty()){        
					toCurrencyobj	=	commonResponse.getAttribute("beneCurrency");
					transactionType = 	commonResponse.getAdditionalInfo("TT");
					transactionSubType = 	commonResponse.getCommonValue();
				}else{
					commonResponse=bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
					toCurrencyobj	=	commonResponse.getCommonEntity()
				}
				toCurrency		=	toCurrencyobj?.code;
			if(!fromCurrency.equals(toCurrency)){
				transferCurrency.add(toCurrencyobj)
			}

			
//			Get the ExchangeRate from BM
//			ExchangeRateRequest exchangeRateRequest=getBean(ExchangeRateRequest.class, requestHeader, null);
//			exchangeRateRequest.setFromCurrency(fromCurrency);
//			exchangeRateRequest.setToCurrency(toCurrency);
//			ExchangeRateResponse exchangeRateResponse=bmClient.accountService.getExchangeRate(exchangeRateRequest);
//			
//			exchangeRate=exchangeRateResponse.getExchangeRate()+" "+toCurrency;
			transactionLimitRequest.setPayeeInstruction(params?.payeeId.toLong())
			transactionLimitRequest.setFromCurrencyId(fromCurrencyId)
		}
		Long userLoginProfileId = getInvoker().getUserLoginProfileId();
		transactionLimitRequest.setUserLoginProfileId(userLoginProfileId);
		TransactionLimitResponse transactionLimitResponse=bmClient.paymentService.fetchTransactionalLimit(transactionLimitRequest)
		setSessionAttribute("LIMIT", transactionLimitResponse)
		model<<[exchangeRateModel:exchangeRate,limitModel:transactionLimitResponse,transactionType:transactionType,transactionSubType:transactionSubType,transferCurrency:transferCurrency?.toList()]
	}
	
	
	
		
	def processfundpaylater(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		if(securityHolder.isValidated)
		{
			FundTransferRequest fundTransferRequest=(FundTransferRequest)getSessionAttribute("FTR");
			FundTransferResponse fundTransferResponse=null;			
			if(fundTransferRequest.paymentScheduleHeaderId && fundTransferRequest.paymentScheduleDetailId){ // Update the scheduled payment
				fundTransferRequest.soFlag  =  SOFlagEnum.A;
				fundTransferResponse=bmClient.paymentService.updateScheduledPaymentFundTransfer(fundTransferRequest);
			}else{
				fundTransferRequest.soFlag  =  SOFlagEnum.C;
				fundTransferResponse=bmClient.paymentService.payLaterFundTransfer(fundTransferRequest);
			}
		   if(fundTransferResponse.hasErrors())
			{
				session.removeAttribute("FTR")
				model<<[transferResponseModel:fundTransferResponse.errors()]
			}
			else
			{
				session.removeAttribute("FTR")
				model<<[transferResponseModel:fundTransferResponse,transferRequestModel:fundTransferRequest]
		   
			}
		}else
		{
			throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.UNSUPPORTED_OPERATION, "Security Breach", null)
		}
	}
		
	def processfundschedulepayment(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
				
		FundTransferRequest fundTransferRequest=(FundTransferRequest)getSessionAttribute("FTR");
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		if(securityHolder.isValidated)
		{	
			FundTransferResponse fundTransferResponse=null;
			if(fundTransferRequest.paymentScheduleHeaderId && fundTransferRequest.paymentScheduleDetailId){ // Update the scheduled payment
				fundTransferRequest.soFlag  =  SOFlagEnum.A;  
				fundTransferResponse=bmClient.paymentService.updateScheduledPaymentFundTransfer(fundTransferRequest);
			}else{
				fundTransferRequest.soFlag  =  SOFlagEnum.C;
				fundTransferResponse=bmClient.paymentService.schedulePaymentFundTransfer(fundTransferRequest);
			}
				   
		   if(fundTransferResponse.hasErrors())
			{
				session.removeAttribute("FTR")
				model<<[errors:fundTransferResponse.errors()]
			}
			else
			{
				session.removeAttribute("FTR")
				model<<[transferResponseModel:fundTransferResponse,transferRequestModel:fundTransferRequest]         
		   
			}
		}else
		{
			throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.UNSUPPORTED_OPERATION, "Security Breach", null)
		}
	}
	
	def prepaidcardpayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		FavouritePaymentDetailRequest favouritePaymentDetailRequest=getBean(FavouritePaymentDetailRequest.class, requestHeader, params);
		PrepaidCardDetailRequest prepaidCardDetailRequest = getBean(PrepaidCardDetailRequest.class, requestHeader,params);
		prepaidCardDetailRequest.setAccountId(params.beneId.toLong())
		PrepaidCardDetailResponse prepaidCardDetailResponse=bmClient.prepaidCardService.getPrepaidCardDetail(prepaidCardDetailRequest);
		favouritePaymentDetailRequest.setAccountId(params.beneId.toLong())
		FavouritePaymentDetailResponse favouritePaymentDetailResponse=bmClient.paymentService.getOwnAccountFavouritePayments(favouritePaymentDetailRequest);
		if(favouritePaymentDetailResponse.hasErrors()){
			model<<[errors:favouritePaymentDetailResponse.errors()]
		}else{
			session.removeAttribute("FTR")
			model<<[favPaymentDetailModel:favouritePaymentDetailResponse,cardDetailsModel:prepaidCardDetailResponse]
		}
	}
	def creditcardpayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		FavouritePaymentDetailRequest favouritePaymentDetailRequest=getBean(FavouritePaymentDetailRequest.class, requestHeader, params);
		CreditCardDetailRequest creditCardDetailRequest = getBean(CreditCardDetailRequest.class, requestHeader,params);
		String creditCardNumber=params.creditCardNumber;
		creditCardDetailRequest.setAccountId(params.beneId.toLong())
		creditCardDetailRequest.setCreditCardNumber(creditCardNumber)
		CreditCardDetailResponse creditCardDetailResponse=bmClient.creditCardService.getCreditCardDetail(creditCardDetailRequest);
		favouritePaymentDetailRequest.setAccountId(params.beneId.toLong())
		FavouritePaymentDetailResponse favouritePaymentDetailResponse=bmClient.paymentService.getOwnAccountFavouritePayments(favouritePaymentDetailRequest);
		if(favouritePaymentDetailResponse.hasErrors()){
			model<<[errors:favouritePaymentDetailResponse.errors()]
		}else{
			session.removeAttribute("FTR")
			model<<[favPaymentDetailModel:favouritePaymentDetailResponse,cardDetailsModel:creditCardDetailResponse]
		}
	}
	
	def creditcardtransfer(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
	
			FundTransferRequest fundTransferRequest=(FundTransferRequest)getSessionAttribute("FTR");
			FundTransferResponse fundTransferResponse=bmClient.paymentService.creditCardPayment(fundTransferRequest);
				
				if(fundTransferResponse.hasErrors())
				{
					model<<[errors:fundTransferResponse.errors()]
				}
				else
				{
					model<<[transferResponseModel:fundTransferResponse]
			   
				}
		}
	
	def cardpaymentconfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		
		FundTransferRequest fundTransferRequest=(FundTransferRequest) getSessionAttribute("FTR");
		String twoFactorType = fundTransferRequest.twoFactorTypeEnum.toString();
		Long userLoginProfileId = getInvoker().getUserLoginProfileId();
		String secondaryController="payment";
		String secondaryAction="creditcardtransfer";
		String twoFAModule="otp_paynow_div";
		
		if(fundTransferRequest.twoFactorTypeEnum.equals(TwoFactorTypeEnum.NONE)){
			FundTransferResponse fundTransferResponse=bmClient.paymentService.creditCardPayment(fundTransferRequest);
			if(fundTransferResponse.hasErrors()){
				model<<[errors:fundTransferResponse.errors()]
			}else{
				model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId, transferResponseModel:fundTransferResponse]
			}
		}else{
			model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId,requestHeader:fundTransferRequest.getRequestHeader(),secondaryAction:secondaryAction,twoFAModule:twoFAModule,secondaryController:secondaryController]
//			returned requestHeader for IM request in case OTP generation
		}
	}
	

	def creditcardpaylaterconfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		FundTransferRequest fundTransferRequest=(FundTransferRequest) getSessionAttribute("FTR");
		fundTransferRequest.noOfTimes=1L;
		fundTransferRequest.startDate=DateUtils.convertStringToDate(params.paymentDate, DateUtils.YYYY_MM_DD)
		fundTransferRequest.setPaymentType(TransactionTypeEnum.INTCC);
		String twoFactorType = fundTransferRequest.twoFactorTypeEnum.toString();
		Long userLoginProfileId = getInvoker().getUserLoginProfileId();
		String secondaryController="payment";
		String secondaryAction="creditcardpaylater";
		String twoFAModule="otp_later_div";
		
		if(fundTransferRequest.twoFactorTypeEnum.equals(TwoFactorTypeEnum.NONE)){
			FundTransferResponse fundTransferResponse=bmClient.paymentService.payLaterFundTransfer(fundTransferRequest);
			if(fundTransferResponse.hasErrors()){
				model<<[errors:fundTransferResponse.errors()]
			}else{
				model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId, transferResponseModel:fundTransferResponse]
			}
		}else{
			model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId,requestHeader:fundTransferRequest.getRequestHeader(),secondaryAction:secondaryAction,twoFAModule:twoFAModule,secondaryController:secondaryController]
//			returned requestHeader for IM request in case OTP generation
		}
	}
	
	def creditcardpaylater(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		FundTransferRequest fundTransferRequest=(FundTransferRequest) getSessionAttribute("FTR");
		FundTransferResponse fundTransferResponse=bmClient.paymentService.payLaterFundTransfer(fundTransferRequest);
			   
	   if(fundTransferResponse.hasErrors())
		{
			model<<[errors:fundTransferResponse.errors()]
		}
		else
		{
			model<<[transferResponseModel:fundTransferResponse]
	   
		}
	}

	def creditcardschedulepayment(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		FundTransferRequest fundTransferRequest=(FundTransferRequest) getSessionAttribute("FTR");
		FundTransferResponse fundTransferResponse=bmClient.paymentService.schedulePaymentFundTransfer(fundTransferRequest);
			   
	   if(fundTransferResponse.hasErrors())
		{
			model<<[errors:fundTransferResponse.errors()]
		}
		else
		{
			model<<[transferResponseModel:fundTransferResponse]
	   
		}
	}
	def creditcardschedulepaymentconfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		FundTransferRequest fundTransferRequest=(FundTransferRequest) getSessionAttribute("FTR");
		if(params.noOfTimes){
			fundTransferRequest.noOfTimes=params.noOfTimes.toLong();
		}
		fundTransferRequest.setPaymentType(TransactionTypeEnum.INTCC);
		fundTransferRequest.schedulePaymentEnum=params.frequency;
		fundTransferRequest.startDate=DateUtils.convertStringToDate(params.startDate, DateUtils.YYYY_MM_DD)
		String twoFactorType = fundTransferRequest.twoFactorTypeEnum.toString();
		Long userLoginProfileId = getInvoker().getUserLoginProfileId();
		String secondaryController="payment";
		String secondaryAction="creditcardschedulepayment";
		String twoFAModule="otp_repeat_div";
		
		if(fundTransferRequest.twoFactorTypeEnum.equals(TwoFactorTypeEnum.NONE)){
			FundTransferResponse fundTransferResponse=bmClient.paymentService.schedulePaymentFundTransfer(fundTransferRequest);
			if(fundTransferResponse.hasErrors()){
				model<<[errors:fundTransferResponse.errors()]
			}else{
				model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId, transferResponseModel:fundTransferResponse]
			}
		}else{
			model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId,requestHeader:fundTransferRequest.getRequestHeader(),secondaryAction:secondaryAction,twoFAModule:twoFAModule,secondaryController:secondaryController]
//			returned requestHeader for IM request in case OTP generation
		}
	}
	
	def loanPayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		FavouritePaymentDetailRequest favouritePaymentDetailRequest=getBean(FavouritePaymentDetailRequest.class, requestHeader, params);
		favouritePaymentDetailRequest.setAccountId(params.beneId.toLong())
		FavouritePaymentDetailResponse favouritePaymentDetailResponse=bmClient.paymentService.getOwnAccountFavouritePayments(favouritePaymentDetailRequest);
		if(favouritePaymentDetailResponse.hasErrors()) {
			model<<[errors:favouritePaymentDetailResponse.errors()]
		} else {
			model<<[favPaymentDetailModel:favouritePaymentDetailResponse]
		}
	}
	
	def loanpaymentconfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
			FundTransferRequest fundTransferRequest=getBean(FundTransferRequest.class, requestHeader, params);
			 fundTransferRequest	= getFundTranferRequest(params, fundTransferRequest);
			FundTransferResponse fundTransferResponse=bmClient.paymentService.loanPayment(fundTransferRequest);
			if(fundTransferResponse.hasErrors())
			{
				model<<[errors:fundTransferResponse.errors()]
			}
			else
			{
				model<<[transferResponseModel:fundTransferResponse]
			}
	}
	def validateLoanFundTransfer(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		LoanFundTransferCommand loanFundCommand =validateCommandObject(LoanFundTransferCommand.class,params)  
   		if(loanFundCommand.hasErrors()){
			model << [errors:loanFundCommand]
			return
		} 
		validatefundtransfer(params,requestHeader,model);
	}
	
	def saveasDraft(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		//For server side validation		
 		FundTransferCommand  fundTransferCmd=validateCommandObject(FundTransferCommand.class,params)   
   		if(fundTransferCmd.hasErrors()){
			model << [errors:fundTransferCmd]
			return
		}
		FundTransferRequest fundTransferRequest = new FundTransferRequest();  
		fundTransferRequest.setRequestHeader(requestHeader);
		fundTransferRequest = getFundTranferRequest(params, fundTransferRequest);
	    FundTransferResponse fundTransferResponse=bmClient.paymentService.saveDraft(fundTransferRequest);
		if(fundTransferResponse.hasErrors()){
			model<<[errors:fundTransferResponse.errors()]
		}else{
			model<<[transferResponseModel:fundTransferResponse]
		}
	}
	
	def validatefundtransfer(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		//For server side validation		
 		FundTransferCommand  fundTransferCmd=validateCommandObject(FundTransferCommand.class,params)   
   		if(fundTransferCmd.hasErrors()){
			model << [errors:fundTransferCmd]
			return
		}		  
		FundTransferRequest fundTransferRequest=new FundTransferRequest();			  
		SecurityHolder securityHolder=getBean(SecurityHolder.class, requestHeader, params);		
		securityHolder.setSuccessController(PAYMENT_CONTROLLER)
		FundTransferResponse fundTransferResponse=null;
		fundTransferRequest=getFundTranferRequest(params, fundTransferRequest)
		fundTransferRequest.setRequestHeader(requestHeader);
		//IBUserProfileResponse userProfileReponse 			= 			getuserprofilereponse();
		//IBUserProfile ibUserProfile 						= 			userProfileReponse.getIbUserProfile();
		//fundTransferRequest.setCifNumber(ibUserProfile?.primaryUserCif?.customerIdentifier?.cifNumber);
		fundTransferRequest.cifNumber = requestHeader?.invoker?.primaryCIF
		fundTransferRequest.setTransactionType(params?.buttonEvent)		
//		fundTransferRequest.setOtpValue(params?.mpin);
		
		if(PaymentButtonEnum.PAYNOW.toString().equals(params?.buttonEvent))
		{
			fundTransferResponse=bmClient.paymentService.validatePayNow(fundTransferRequest);
			fundTransferRequest.setPaymentScheduleDetailId(null);
			if(StringUtils.hasText(params?.mpin)){
				fundTransferRequest.setMpin(commonService.decryptData(params?.mpin));
			}
			securityHolder.setSuccessAction(PROCESS_PAYNOW_ACTION)
		}else if(PaymentButtonEnum.LATER.toString().equals(params?.buttonEvent))
		{
			PayLaterCommand payLaterCmd =validateCommandObject(PayLaterCommand.class,params) 
			if(payLaterCmd.hasErrors()){  
				model << [errors:payLaterCmd] 
				return
			}
			fundTransferRequest.noOfTimes=1L;
			fundTransferRequest.startDate=DateUtils.convertStringToDate(params.paymentDate, DateUtils.YYYY_MM_DD)
			fundTransferResponse=bmClient.paymentService.validatePayLater(fundTransferRequest);
			securityHolder.setSuccessAction(PROCESS_PAYLATER_ACTION)
		}else if(PaymentButtonEnum.REPEAT.toString().equals(params?.buttonEvent))
		{
			SchedulePayCommand schedulePayCmd =validateCommandObject(SchedulePayCommand.class,params)
			if(schedulePayCmd.hasErrors()){
				model << [errors:schedulePayCmd]
				return
			}
			fundTransferRequest.setSchedulePaymentEnum(SchedulePaymentEnum.valueOf(params.frequency));
			fundTransferRequest.noOfTimes=params?.noOfTimes?.toLong();
			fundTransferRequest.startDate=DateUtils.convertStringToDate(params.startDate, DateUtils.YYYY_MM_DD)
			fundTransferRequest.endDate=DateUtils.convertStringToDate(params.endDate, DateUtils.YYYY_MM_DD)
			fundTransferResponse=bmClient.paymentService.validateRepeat(fundTransferRequest);
			securityHolder.setSuccessAction(PROCESS_REPEAT_ACTION)
		}else if(PaymentButtonEnum.CANCELPAYMENT.toString().equals(params?.buttonEvent)){
			CancelPayCommand cancelPayCmd 	=	validateCommandObject(CancelPayCommand.class,params)
			if(cancelPayCmd.hasErrors()){
				model << [errors:cancelPayCmd]
				return
			}
			fundTransferResponse=bmClient.paymentService.validatePayNow(fundTransferRequest);
			securityHolder.setSuccessAction(CANCEL_PAYMENT_ACTION)
		}/*else if(PaymentButtonEnum.APPROVEPAYMENT.toString().equals(params?.buttonEvent)){	
			Long fromAccountId					=	params.fromAccountId != null ? getIdVersion(params.fromAccountId)[0] : 0L;	
			Long toAccountId					=	params.toAccountId != null ? getIdVersion(params.toAccountId)[0] 	: 0L;
			PaymentTransferResponse response 	= 	getPayerAccountDetails(requestHeader,fromAccountId); 			
			Long fromCurrencyId					=	response?.getPayer()?.getCurrency()?.getId();
			Long createdByULPId					=	params.createdBy?.toLong();
			TransactionLimitResponse transactionLimitResponse = getPayerLimitDetails(requestHeader,toAccountId,fromCurrencyId,createdByULPId);
			setSessionAttribute("LIMIT", transactionLimitResponse)		
			fundTransferRequest.setIsJointAuthRequired(true);
			fundTransferRequest.setCreatedBy(createdByULPId);
			fundTransferResponse				=	bmClient.paymentService.validatePayNow(fundTransferRequest);
			securityHolder.setSuccessAction(APPROVE_PAYMENT_ACTION)
		}else if(PaymentButtonEnum.REJECTPAYMENT.toString().equals(params?.buttonEvent)){	
			Long fromAccountId					=	params.fromAccountId != null ? getIdVersion(params.fromAccountId)[0] : 0L;	
			Long toAccountId					=	params.toAccountId != null ? getIdVersion(params.toAccountId)[0] 	: 0L;
			PaymentTransferResponse response 	= 	getPayerAccountDetails(requestHeader,fromAccountId); 			
			Long fromCurrencyId					=	response?.getPayer()?.getCurrency()?.getId();
			Long createdByULPId					=	params.createdBy?.toLong();
			TransactionLimitResponse transactionLimitResponse = getPayerLimitDetails(requestHeader,toAccountId,fromCurrencyId,createdByULPId);
			setSessionAttribute("LIMIT", transactionLimitResponse)		
			fundTransferRequest.setIsJointAuthRequired(true);
			fundTransferRequest.setCreatedBy(createdByULPId);
			fundTransferResponse				=	bmClient.paymentService.validatePayNow(fundTransferRequest);
			securityHolder.setSuccessAction(REJECT_PAYMENT_ACTION)
		}*/
		if(!fundTransferResponse.hasErrors()){
			setSessionAttribute("FTR", fundTransferResponse.getFundTransferRequest());
			setSessionAttribute("SECHOLD", securityHolder)
		}
		model<<[transferResponseModel:fundTransferResponse]
	}
	
	
	def viewsihistory(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{		
		ViewSchedulePaymentCommand ViewSchdPymtCmd=validateCommandObject(ViewSchedulePaymentCommand.class,params)
		if(ViewSchdPymtCmd.hasErrors()){
			model << [error:ViewSchdPymtCmd]
			return
		}
		Long beneId=params.beneId.toLong();
		SIViewAndUpdateRequest  siViewAndUpdateRequest=getBean(SIViewAndUpdateRequest.class, requestHeader, null)
		siViewAndUpdateRequest.beneficiaryId=beneId;
		siViewAndUpdateRequest.beneficiaryInstructionId=params.beneInsId.toLong();
		siViewAndUpdateRequest.transferType=params.viewValue;
		setSessionAttribute("SIVR", siViewAndUpdateRequest);
		SIViewAndUpdateResponse siViewAndUpdateResponse=bmClient.paymentService.viewSchedulePayment(siViewAndUpdateRequest);
		if(siViewAndUpdateResponse.hasErrors()){
			model<<[errors:siViewAndUpdateResponse.errors()]
		}else{
			model<<[siViewAndUpdateModel:siViewAndUpdateResponse,pagerModel:siViewAndUpdateResponse.getPage()]
		}
	}
	
	def viewsi(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
	}
	
	def stopSIPaymentSeries(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
			
		StopSchedulePaymentCommand stopSchPayCmd=validateCommandObject(StopSchedulePaymentCommand.class,params);
		if(!stopSchPayCmd.hasErrors()){
			
		SIViewAndUpdateRequest  siViewAndUpdateRequest=getBean(SIViewAndUpdateRequest.class, requestHeader, null);
		siViewAndUpdateRequest.paymentScheduleDetailId=params.paySchId.toLong()
		SIViewAndUpdateResponse siViewAndUpdateResponse=bmClient.paymentService.stopSchedulePaymentSeries(siViewAndUpdateRequest);
		if(siViewAndUpdateResponse.hasErrors()){
			model<<[errors:siViewAndUpdateResponse.errors()]
		}else{
			model<<[siViewAndUpdateModel:siViewAndUpdateResponse]
		}
		}else{
			model << [errors:stopSchPayCmd.errors]
		}
	}
	
	def skipSIPayment(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		StopSchedulePaymentCommand stopSchPayCmd=validateCommandObject(StopSchedulePaymentCommand.class,params)
		if(!stopSchPayCmd.hasErrors()){
			
		SIViewAndUpdateRequest  siViewAndUpdateRequest=getBean(SIViewAndUpdateRequest.class, requestHeader, null);
		siViewAndUpdateRequest.paymentScheduleDetailId=params.paySchId.toLong()
		SIViewAndUpdateResponse siViewAndUpdateResponse=bmClient.paymentService.skipSchedulePayment(siViewAndUpdateRequest);
		if(siViewAndUpdateResponse.hasErrors()){
			model<<[errors:siViewAndUpdateResponse.errors()]
		}else{
			model<<[siViewAndUpdateModel:siViewAndUpdateResponse]
		}
		}else{
			model << [errors:stopSchPayCmd.errors]
		}
	
	}
	
	def viewskippedsi(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		SIViewAndUpdateRequest siViewAndUpdateRequest=(SIViewAndUpdateRequest)getSessionAttribute("SIVR");
		SIViewAndUpdateResponse siViewAndUpdateResponse=bmClient.paymentService.viewSkippedSchedulePayment(siViewAndUpdateRequest);
		if(siViewAndUpdateResponse.hasErrors()){
			model<<[errors:siViewAndUpdateResponse.errors()]
		}else{
			model<<[siViewAndUpdateModel:siViewAndUpdateResponse,pagerModel:siViewAndUpdateResponse.getPage(),siViewAndUpdateRequestModel:siViewAndUpdateRequest]
		}
	}
	
	def viewrejectedpayment(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		PastPaymentReviewRequest pastPaymentReviewRequest=(PastPaymentReviewRequest)getSessionAttribute("SIVR");
		PastPaymentReviewResponse pastPaymentReviewResponse=bmClient.paymentService.viewRejectedPayment(pastPaymentReviewRequest);
		if(pastPaymentReviewResponse.hasErrors()){
			model<<[errors:pastPaymentReviewResponse.errors()]
		}else{
			model<<[pastPaymentReviewModel:pastPaymentReviewResponse,pagerModel:pastPaymentReviewResponse.getPage(),pastPaymentReviewRequestModel:pastPaymentReviewRequest]
		}
	}
	
	def viewskippedsipage(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		SIViewAndUpdateRequest siViewAndUpdateRequest=(SIViewAndUpdateRequest)getSessionAttribute("SIVR");
		PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),10);
		siViewAndUpdateRequest.setPageRequest(pageRequest);
		SIViewAndUpdateResponse siViewAndUpdateResponse=bmClient.paymentService.viewSkippedSchedulePaymentPage(siViewAndUpdateRequest);
		if(siViewAndUpdateResponse.hasErrors()){
			model<<[errors:siViewAndUpdateResponse.errors()]
		}else{
			model<<[siViewAndUpdateModel:siViewAndUpdateResponse,pagerModel:siViewAndUpdateResponse.getPage(),siViewAndUpdateRequestModel:siViewAndUpdateRequest]
		}
	}
	
	def viewrejectedpaymentpage(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{

		PastPaymentReviewRequest pastPaymentReviewRequest=(PastPaymentReviewRequest)getSessionAttribute("SIVR");
		PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),10);
		pastPaymentReviewRequest.setPageRequest(pageRequest);
		PastPaymentReviewResponse pastPaymentReviewResponse=bmClient.paymentService.viewRejectedPaymentPage(pastPaymentReviewRequest);
		if(pastPaymentReviewResponse.hasErrors()){
			model<<[errors:pastPaymentReviewResponse.errors()]
		}else{
			model<<[pastPaymentReviewModel:pastPaymentReviewResponse,pagerModel:pastPaymentReviewResponse.getPage(),pastPaymentReviewRequestModel:pastPaymentReviewRequest]
		}
	}
	def viewsihistorypage(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		SIViewAndUpdateRequest siViewAndUpdateRequest=(SIViewAndUpdateRequest)getSessionAttribute("SIVR");
		PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),10);
		siViewAndUpdateRequest.setPageRequest(pageRequest);
		SIViewAndUpdateResponse siViewAndUpdateResponse=bmClient.paymentService.viewSchedulePaymentPage(siViewAndUpdateRequest);
		if(siViewAndUpdateResponse.hasErrors()){
			model<<[errors:siViewAndUpdateResponse.errors()]
		}else{
			model<<[siViewAndUpdateModel:siViewAndUpdateResponse,pagerModel:siViewAndUpdateResponse.getPage(),siViewAndUpdateRequestModel:siViewAndUpdateRequest]
		}
	}
	
	
	def viewexecutedpayment(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
	ViewSchedulePaymentCommand ViewSchdPymtCmd=validateCommandObject(ViewSchedulePaymentCommand.class,params)
		if(ViewSchdPymtCmd.hasErrors()){ 
			model << [error:ViewSchdPymtCmd]
			return
		}
		Long beneId=params.beneId.toLong();
		PastPaymentReviewRequest  pastPaymentReviewRequest=getBean(PastPaymentReviewRequest.class, requestHeader, null)
		pastPaymentReviewRequest.beneficiaryId=beneId;
		pastPaymentReviewRequest.beneficiaryInstructionId=params.beneInsId.toLong();
		pastPaymentReviewRequest.transferType=params.viewValue;
		setSessionAttribute("SIVR", pastPaymentReviewRequest);
	PastPaymentReviewResponse pastPaymentReviewResponse=bmClient.paymentService.viewExecutedPayment(pastPaymentReviewRequest);
	if(pastPaymentReviewResponse.hasErrors()){
		model<<[errors:pastPaymentReviewResponse.errors()]
	}else{
		model<<[pastPaymentReviewModel:pastPaymentReviewResponse,pagerModel:pastPaymentReviewResponse.getPage()]
	}
}

	def viewexecutedpaymentpage(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		PastPaymentReviewRequest pastPaymentReviewRequest=(PastPaymentReviewRequest)getSessionAttribute("SIVR");
		PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),10);
		pastPaymentReviewRequest.setPageRequest(pageRequest);
		PastPaymentReviewResponse PastPaymentReviewResponse=bmClient.paymentService.viewExecutedPaymentPage(pastPaymentReviewRequest);
		if(PastPaymentReviewResponse.hasErrors()){
			model<<[errors:PastPaymentReviewResponse.errors()]
		}else{
			model<<[pastPaymentReviewModel:PastPaymentReviewResponse,pagerModel:PastPaymentReviewResponse.getPage(),pastPaymentReviewRequestModel:pastPaymentReviewRequest]
		}
	}
	
	def showPaymentOriginPage(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
			println params.dump();
			FavouritePaymentDetailRequest paymentDetailRequest 		= new FavouritePaymentDetailRequest()     
			paymentDetailRequest.setRequestHeader(requestHeader);
			paymentDetailRequest.setPaymentDetailId(params.taskInstanceId.toLong());    
			paymentDetailRequest.setPaymentType(params.transactionIdentifier); 
			paymentDetailRequest.isSMEApprovalPayment = ("SME".equals(params?.dtype)) ? true : false;
			def processModel = [:]
			FavouritePaymentDetailResponse paymentDetailResponse 	= bmClient.paymentService.getPaymentDetails(paymentDetailRequest);
			if("SME".equals(params.dtype)){			
				def paymentDetailObject		= 	paymentDetailResponse?.acctBalancePaymentDetail;
				def payeeIns 				= 	(BeneficiaryInstruction)paymentDetailObject?.payeeInstruction	   
				processModel = [
					'fromAccountId'		:paymentDetailObject?.payerInstruction?.idVersion,
					'fromCurrency'		:paymentDetailObject?.payerInstruction?.currency?.code,
					'fromExchangeRate'	:paymentDetailObject?.exchangeRatePair1,
					'debitAmount'		:paymentDetailObject?.paymentAmount,
					'toAccountId'		:paymentDetailObject?.payeeInstruction?.idVersion,
					'toCurrency'		:payeeIns?.currency?.code,
					'toTSTCode'			:payeeIns?.transactionSubType?.serviceApplication?.service?.code,
					'toExchangeRate'	:paymentDetailObject?.exchangeRatePair2,
					'transactionAmount'	:paymentDetailObject?.paymentAmount,
					'transferCurrency'	:paymentDetailObject?.paymentCurrency?.code,
					'remarks'			:paymentDetailObject?.remarks,				
					'chargeExchangeRate':paymentDetailObject?.chargeExchangeRate,
					'chargeAmount'		:paymentDetailObject?.chargeAmount,
					'chargeCurrency'	:paymentDetailObject?.chargeCurrency?.code,				
					'creditAmount'		:paymentDetailObject?.paymentAmount,
					'noOfTransactions'	:paymentDetailObject?.paymentScheduleHeader?.totalPaymentCount,
					'paymentDate'		:paymentDetailObject?.paymentDate,
					'frequency'			:paymentDetailObject?.paymentScheduleHeader?.frequency?.description, 
					'debitCurrencyDisplay'	:payeeIns?.currency?.code,
					'endDate'			:paymentDetailObject?.paymentScheduleHeader?.frequencyEndDate
					]   
				
				if(paymentDetailObject?.chargeExchangeRate == null) {    
					processModel.put("chargeExchangeRate","1")
				}
				
				if(paymentDetailObject?.paymentHeader!=null){           
					processModel.put("maker", paymentDetailObject?.paymentHeader?.ibUserLoginProfile?.userLogin)
				}else{
					processModel.put("maker", paymentDetailObject?.paymentScheduleHeader?.ibUserLoginProfile?.userLogin)
				}	       		
				
				if(payeeIns?.account)  
				{
					processModel.put("beneficiaryNickName", payeeIns?.shortName)
					processModel.put("beneId", payeeIns?.account?.id)
					processModel.put("beneficiaryAccountNumber", payeeIns?.account?.accountNumber)
					def acctType	=	payeeIns?.transactionSubType?.serviceApplication?.service?.code
					processModel.put("cancelAction",PaymentModuleTypeEnum.valueOf(acctType).getKey())
				}else{
					processModel.put("beneficiaryNickName", payeeIns?.beneficiary?.shortName)
					processModel.put("beneId", payeeIns?.beneficiary?.id)
					processModel.put("cancelAction","friendsandfamilypayment")
				}
			
			
			}
			if(paymentDetailResponse.hasErrors()){
				model<<[errors:paymentDetailResponse.errors()]
			}else{
				if(paymentDetailResponse?.isAWarning){
					model<<[postProcessModel:processModel,favPaymentDetailModel:paymentDetailResponse,datelineRef:params?.id,SICancelFlag:params?.dtype,datelineEventRef:params?.dtype,
						isAWarning:paymentDetailResponse?.isAWarning,warningErrorCodes:paymentDetailResponse?.warningErrorCodes,errorClass:"info"]
				}else{
					model<<[postProcessModel:processModel,favPaymentDetailModel:paymentDetailResponse,datelineRef:params?.id,SICancelFlag:params?.dtype,datelineEventRef:params?.dtype]
				}
			}
	}
	
	def editSI(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		FavouritePaymentDetailRequest paymentDetailRequest 		= new FavouritePaymentDetailRequest()
		paymentDetailRequest.setRequestHeader(requestHeader);
		paymentDetailRequest.setPaymentDetailId(params.spdId.toLong());
		paymentDetailRequest.setPaymentType("FT_SI");
		FavouritePaymentDetailResponse paymentDetailResponse 	= bmClient.paymentService.getPaymentDetails(paymentDetailRequest);
		
		if(BusinessFunctionConstants.CREDIT_CARD_TRANS.equals(params?.tstCode)){
			CreditCardDetailRequest creditCardDetailRequest = getBean(CreditCardDetailRequest.class, requestHeader,params);
			creditCardDetailRequest.setAccountId(params?.beneId?.toLong())
			CreditCardDetailResponse creditCardDetailResponse=bmClient.creditCardService.getCreditCardDetail(creditCardDetailRequest);
			model << [cardDetailsModel:creditCardDetailResponse]
		}
		if(paymentDetailResponse.hasErrors()){
			model<<[errors:paymentDetailResponse.errors()]
		}else{
			model<<[favPaymentDetailModel:paymentDetailResponse,SICancelFlag:'SI',datelineEventRef:'SI']      
		}
	}
	
	def showMakePaymentPage(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		FavouritePaymentDetailRequest paymentDetailRequest = new FavouritePaymentDetailRequest()
		paymentDetailRequest.setRequestHeader(requestHeader);
		paymentDetailRequest.setPaymentDetailId(params.taskInstanceId.toLong());
		paymentDetailRequest.setBeneId(params.beneId.toLong());
		paymentDetailRequest.setPaymentType("REM");
		FavouritePaymentDetailResponse paymentDetailResponse = bmClient.paymentService.getPaymentDetails(paymentDetailRequest);
		if(paymentDetailResponse.hasErrors()){
			model<<[errors:paymentDetailResponse.errors()]
		}else{
			model<<[favPaymentDetailModel:paymentDetailResponse,datelineRef:params.id]
		}
	}
		
	def confirmCancelSIPayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		SIViewAndUpdateRequest  siViewAndUpdateRequest 		= 	getBean(SIViewAndUpdateRequest.class, requestHeader, null);
		FundTransferRequest fundTransferRequest				=	(FundTransferRequest)getSessionAttribute("FTR");
		if(fundTransferRequest.datelineReferenceId){
			siViewAndUpdateRequest.datelineReferenceId		=	fundTransferRequest.datelineReferenceId;
		}
		if(fundTransferRequest.paymentScheduleDetailId){
			siViewAndUpdateRequest.paymentScheduleDetailId	=	fundTransferRequest.paymentScheduleDetailId;
		}
		SIViewAndUpdateResponse siViewAndUpdateResponse		=	bmClient.paymentService.skipSchedulePayment(siViewAndUpdateRequest);
		model << [siViewAndUpdateModel:siViewAndUpdateResponse]
	}
	
	
	def showPaymentDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		CommonRequest commonRequest 			= new CommonRequest();
		commonRequest.setRequestHeader(requestHeader);
		List<Object> filterParams 				= new ArrayList<Object>();
		filterParams.add(params.transactionIdentifier);
		commonRequest.setCommonEntityId(params.taskInstanceId?.toLong());
		commonRequest.setFilterParams(filterParams);
		CommonResponse commonResponse     				= 	bmClient.iBCommonService.getDateLineEventDetails(commonRequest);
		if ("FT".equals(params.transactionIdentifier)) {			
			PaymentDetail paymentDetail					=	(PaymentDetail)commonResponse.getCommonEntity();	
			model<<[paymentDetailModel:paymentDetail,transactionIdentifier:params.transactionIdentifier]
		}else if("FT_SI".equals(params.transactionIdentifier) || "CANCEL_SI".equals(params.transactionIdentifier)){	
//			PaymentScheduleHeader paymentScheduleHdr	= 	(PaymentScheduleHeader)commonResponse.getCommonEntity();
			PaymentScheduleDetail paymentScheduleDetail	= 	(PaymentScheduleDetail)commonResponse.getCommonEntity();
			model<<[paymentDetailModel:paymentScheduleDetail,transactionIdentifier:params.transactionIdentifier,isSMEApprovalTimeExpired:commonResponse.isApprovalTimeExpired]
		}else if("SI_HEADER".equals(params.transactionIdentifier)){	
			PaymentScheduleHeader paymentScheduleHdr	= 	(PaymentScheduleHeader)commonResponse.getCommonEntity();
			model<<[paymentScheduleHeaderModel:paymentScheduleHdr,paymentScheduleDetailModel:paymentScheduleHdr.getPaymentScheduleDetail().get(0),transactionIdentifier:params.transactionIdentifier,isSMEApprovalTimeExpired:commonResponse.isApprovalTimeExpired]
		}		
		if(commonResponse.hasErrors())
		{
			model<<[errors:commonResponse.errors()]
		}		
	}
	
	def paymentPostProcess(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		FundTransferRequest fundTransferRequest				=	(FundTransferRequest) getSessionAttribute("FTR");
		TransactionLimitResponse transactionLimitResponse	=	(TransactionLimitResponse)getSessionAttribute("LIMIT")
		AccountBalanceResponse accountBalanceResponse		=	(AccountBalanceResponse)getSessionAttribute("BAL")
		// Set the Limit Utilization if available  
		if(transactionLimitResponse?.getMatchingLimitUtilization()!=null && transactionLimitResponse?.getMatchingLimitUtilization()?.getId()!=null)
		{
			fundTransferRequest.setLimitUtilizationId(transactionLimitResponse.getMatchingLimitUtilization().getId());
		}
		
  		def fromAccountId		=	fundTransferRequest.getFromAccountId();
	  	def toAccountId			=	fundTransferRequest.getToAccountId();
		def transferCurencyId	=	fundTransferRequest.getTransferCurrencyID();
		def fromCurrency,toCurrency,transferCurrency,baseCurrency
		def fromExchangeRate="1",toExchangeRate="1",chargeExchangeRate="1"
		def debitAmount,creditAmount,chargeAmount,totalTransactionAmount
		def fromCurrDesPosition,toCurrDesPosition
		def debitCurrencyDisplay
		def beneficiaryNickName
		def Map<String,String> postProcessModel	=	new HashMap<String, String>();	
		def cancelAction   
		
		//def fromAccountNumber 	= 	fundTransferRequest?.fromAccount?.accountNumber;
		//def toAccountNumber		=	fundTransferRequest?.toAccountNumber;
		//def dummyAccountNumber	=	null;
		//def currencySelection	=	null;
		def fromCurrIsoCode,toCurrIsoCode,transCurrIsoCode
				
		CommonRequest commonRequest		=	getBean(CommonRequest.class, requestHeader, null);
		ExchangeRateResponse exgRateRes	=	null;
		CommonResponse commonResponse	=	null;
		// From Account Currency
		fromCurrency			=		fundTransferRequest?.fromAccount?.currency?.code;
		fromCurrIsoCode  		= 		commonService.getCurrencyFormat(fundTransferRequest?.fromAccount?.currency?.currencyIsoCode?.toString()) 
		fromCurrDesPosition		=		fundTransferRequest?.fromAccount?.currency?.numberOfSubUnits;
		
		// To Account Currency
		Currency toCurrencyobj		=		fundTransferRequest?.toBeneficiaryInstruction?.currency;
		toCurrency					=		toCurrencyobj?.code;
		toCurrDesPosition			=		toCurrencyobj?.numberOfSubUnits;	 
		toCurrIsoCode				=		commonService.getCurrencyFormat(toCurrencyobj?.currencyIsoCode?.toString()) 
		// Transfer Currency
		Currency transferCurrencyObj		=		commonService.getCurrency(transferCurencyId)
		transferCurrency					=		transferCurrencyObj?.code
		transCurrIsoCode					=		commonService.getCurrencyFormat(transferCurrencyObj?.currencyIsoCode?.toString()) 
		
		// currencySelection = (fromCurrency.equals(transferCurrency)) ? 'F' : (toCurrency.equals(transferCurrency)) ? 'T' : getCurrencyFormat(transferCurrencyObj?.currencyIsoCode?.toString()) ;
		// dummyAccountNumber = "F".equals(currencySelection) ? fromAccountNumber : "T".equals(currencySelection) ? toAccountNumber : null;
		 
		commonResponse				=		bmClient.iBCommonService.fetchBaseCurrency(commonRequest)  
		Currency baseCurrencyObj	=		commonResponse?.commonEntity
		baseCurrency				=		baseCurrencyObj?.code;
		// if(fundTransferRequest?.transferType!=null && fundTransferRequest?.transferType.equals("OWNACCTRNSTOINTCC"))
		 //{
			 //dummyAccountNumber = ""; 
			// currencySelection = getCurrencyFormat(transferCurrencyObj?.currencyIsoCode?.toString());
			 
		// }
		 if(!fromCurrency.equals(transferCurrency)){
		 	//exgRateRes			=	commonService.getExchangeCalculator(fromAccountNumber, dummyAccountNumber, fundTransferRequest?.paymentAmount?.toString(),currencySelection,requestHeader)
			exgRateRes			=	commonService.fetchExchangeCalc(transCurrIsoCode,fromCurrIsoCode,fundTransferRequest?.paymentAmount?.toString(),requestHeader);
		 	fromExchangeRate	=	exgRateRes?.exchangeRate
		 	debitAmount			=	exgRateRes?.convertedAmount?.toBigDecimal()//calculateDebitAmount(fromExchangeRate, fundTransferRequest.getPaymentAmount(),fromCurrency,transferCurrency,fromCurrDesPosition)
		 }else{
		 	debitAmount			=	fromExchangeRate.toBigDecimal().multiply(fundTransferRequest?.paymentAmount)
		 } 
		 if(!toCurrency.equals(transferCurrency)){
			 //exgRateRes				=	commonService.getExchangeCalculator(toAccountNumber, dummyAccountNumber,fundTransferRequest?.paymentAmount?.toString(),currencySelection,requestHeader)
			 exgRateRes				=	commonService.fetchExchangeCalc(transCurrIsoCode,toCurrIsoCode,fundTransferRequest?.paymentAmount?.toString(),requestHeader);
			 toExchangeRate			=	exgRateRes?.exchangeRate
			 creditAmount			=	exgRateRes?.convertedAmount?.toBigDecimal()//calculateCreditAmount(toExchangeRate, fundTransferRequest.getPaymentAmount(),fromCurrency,toCurrency,transferCurrency,toCurrDesPosition,baseCurrency)
		 }else{
		 	creditAmount			=	toExchangeRate.toBigDecimal().multiply(fundTransferRequest?.paymentAmount)
		 }
		 if(fromCurrency.equals(baseCurrency)&&(!toCurrency.equals(baseCurrency))&&(!transferCurrency.equals(baseCurrency))&&(!toCurrency.equals(transferCurrency))) {
			 debitCurrencyDisplay	=	fromCurrency   
		 }else{
		 	debitCurrencyDisplay	=	toCurrency
		 }
		/*//Step 1: Get the exchange rate based on from and to account  
		 exgRateRes			=	commonService.getExchangeCalculator(fromCurrency, transferCurrency, "", requestHeader)
		 fromExchangeRate	=	exgRateRes?.exchangeRate
		 debitAmount		=	calculateDebitAmount(fromExchangeRate, fundTransferRequest.getPaymentAmount(),fromCurrency,transferCurrency,fromCurrDesPosition)
		 
		 //Step 2: Get the exchange rate based on to and transfer currency
		 if(fromCurrency.equals(baseCurrency)&&(!toCurrency.equals(baseCurrency))&&(!transferCurrency.equals(baseCurrency))&&(!toCurrency.equals(transferCurrency))) {
			 exgRateRes				=	commonService.getExchangeCalculator(fromCurrency, toCurrency, "", requestHeader)
			 toExchangeRate			=	exgRateRes?.exchangeRate
			 creditAmount			=	calculateCreditAmount(toExchangeRate, debitAmount,fromCurrency,toCurrency,transferCurrency,toCurrDesPosition,baseCurrency)
			 debitCurrencyDisplay	=	fromCurrency
		 } else if(fromCurrency.equals(toCurrency)) {
			 exgRateRes				=	commonService.getExchangeCalculator(fromCurrency, toCurrency, "", requestHeader)	
			 toExchangeRate			=	exgRateRes?.exchangeRate
			 creditAmount			=	calculateCreditAmount(toExchangeRate, debitAmount,fromCurrency,toCurrency,transferCurrency,toCurrDesPosition,baseCurrency)
			 debitCurrencyDisplay	=	toCurrency
		 } else {
			 exgRateRes				=	commonService.getExchangeCalculator(toCurrency, transferCurrency, "", requestHeader)	
			 toExchangeRate			=	exgRateRes?.exchangeRate
			 creditAmount			=	calculateCreditAmount(toExchangeRate, fundTransferRequest.getPaymentAmount(),fromCurrency,toCurrency,transferCurrency,toCurrDesPosition,baseCurrency)
			 debitCurrencyDisplay	=	toCurrency
		 }   */                
		 
     	 ChargeResponse chargeResponse = bmClient.iBCommonService.getCharges(fundTransferRequest);     
		  if(chargeResponse?.currency) {
			  def chargeCurrIsoCode 	=	commonService.getCurrencyFormat(chargeResponse?.chargeCurrency?.currencyIsoCode?.toString()) 
			  if(!transferCurrency.equals(chargeResponse?.currency)){  
				  //exgRateRes				=	commonService.getExchangeCalculator(fromAccountNumber, dummyAccountNumber, chargeResponse?.chargeAmount?.toString(),currencySelection,requestHeader)
				  exgRateRes				=	commonService.fetchExchangeCalc(transCurrIsoCode,chargeCurrIsoCode,chargeResponse?.chargeAmount?.toString(),requestHeader);
				  chargeExchangeRate		=	exgRateRes?.exchangeRate
				  chargeAmount				=	exgRateRes?.convertedAmount?.toBigDecimal()//calculateChargeAmount(fromCurrency, chargeResponse?.currency, chargeExchangeRate, chargeResponse.chargeAmount)
			  }else{
			  	chargeAmount	=	chargeExchangeRate.toBigDecimal().multiply(chargeResponse?.chargeAmount)
			  }
		  }   
		  if(chargeAmount != null){
			  log.info("Charge Amount :::"+chargeAmount);
			  log.info("Payment Amount :::"+fundTransferRequest.getPaymentAmount())
			  totalTransactionAmount = fundTransferRequest.getPaymentAmount().add(chargeAmount)
		  }else{
		  	  totalTransactionAmount = fundTransferRequest.getPaymentAmount()
		  }
		  log.info("Transaction Amount :::"+totalTransactionAmount);
		  fundTransferRequest.setTotalTransactionAmount(totalTransactionAmount);
			Map<String,Object> balanceCheckMap	=	new HashMap<String, Object>(3);
			balanceCheckMap.put("availableBalance", accountBalanceResponse?.availableBalance)
			balanceCheckMap.put("transferCurrency", transCurrIsoCode)
			balanceCheckMap.put("transferAmount", fundTransferRequest.getPaymentAmount());
			balanceCheckMap.put("transactionAmount", debitAmount)
			balanceCheckMap.put("chargeAmount", chargeAmount)
			balanceCheckMap.put("transactionType", fundTransferRequest?.transactionType);
			balanceCheckMap.put("transactionLimit", transactionLimitResponse);
			commonRequest.setRequestParams(balanceCheckMap)
			commonResponse	=	bmClient.iBCommonService.verifyBalanceAndLimits(commonRequest)
			if(commonResponse.hasErrors())
			{
				model<<[errors:commonResponse.errors()]
				return
			}		
		
		  postProcessModel.put("fromAccountId", fromAccountId)
 		  postProcessModel.put("toAccountId", toAccountId)
  		  postProcessModel.put("remarks", fundTransferRequest.getPaymentRemarks())
   		  postProcessModel.put("transactionAmount", fundTransferRequest.getPaymentAmount())
   		  postProcessModel.put("debitAmount", debitAmount)
		  postProcessModel.put("fromCurrency", fromCurrency)
		  postProcessModel.put("toCurrency", toCurrency)
		  postProcessModel.put("transferCurrency", transferCurrency)
		  postProcessModel.put("fromExchangeRate", fromExchangeRate)
		  postProcessModel.put("toExchangeRate", toExchangeRate)
		  postProcessModel.put("creditAmount", creditAmount)
		  postProcessModel.put("debitCurrencyDisplay", debitCurrencyDisplay)
		  postProcessModel.put("buttonEvent", fundTransferRequest?.transactionType)
		  postProcessModel.put("frequency", fundTransferRequest?.schedulePaymentEnum?.toString())
		  postProcessModel.put("startDate", fundTransferRequest?.startDate)
		  postProcessModel.put("endDate", fundTransferRequest?.endDate)
		  postProcessModel.put("totalTransactionAmount", totalTransactionAmount);
		  postProcessModel.put("transactionType", fundTransferRequest?.toBeneficiaryInstruction?.transactionSubType?.serviceApplication?.service?.code);    
		  Boolean dualUser=false;   
		  if("SME".equals(fundTransferRequest.getRequestHeader().getInvoker().getSegmentCode())){    
//			String fromAccountId1 = getIdVersion(fromAccountId)[0]
//			   dualUser = iBCommonUtil.checkSMEAuthMatrixAndDualUser(Long.parseLong(fromAccountId1),fundTransferRequest?.toBeneficiaryInstruction?.id,fundTransferRequest.getRequestHeader().getInvoker().getUserLoginProfileId());    
		  }else{
		  	 	dualUser =true;
		  }
		  
		  postProcessModel.put("userType",dualUser);
		    if(chargeResponse.currency)
		  {
			  postProcessModel.put("chargeExchangeRate", chargeExchangeRate)
			  postProcessModel.put("chargeCurrency", chargeResponse?.currency)
			  postProcessModel.put("chargeAmount", chargeResponse?.chargeAmount)
			  postProcessModel.put("exactChargeAmount", chargeAmount)
			  postProcessModel.put("chargeCode", chargeResponse.getCode());
		  }
		  if(fundTransferRequest?.toBeneficiaryInstruction?.account)
		  {
			  postProcessModel.put("beneficiaryNickName", fundTransferRequest?.toBeneficiaryInstruction?.shortName) 
			  postProcessModel.put("beneId", fundTransferRequest?.toBeneficiaryInstruction?.account?.id)
			  postProcessModel.put("beneficiaryAccountNumber", fundTransferRequest?.toBeneficiaryInstruction?.account?.accountNumber)
			  def acctType	=	fundTransferRequest?.toBeneficiaryInstruction?.transactionSubType?.serviceApplication?.service?.code  
			  postProcessModel.put("cancelAction",PaymentModuleTypeEnum.valueOf(acctType).getKey())
			
		  }else{
			  postProcessModel.put("beneficiaryNickName", fundTransferRequest?.toBeneficiaryInstruction?.beneficiary?.shortName)
			  postProcessModel.put("beneId", fundTransferRequest?.toBeneficiaryInstruction?.beneficiary?.id)
			  postProcessModel.put("cancelAction","friendsandfamilypayment")
			  
		  }
		  fundTransferRequest.setFromExchangeRate(fromExchangeRate.toDouble());
		  fundTransferRequest.setToExchangeRate(toExchangeRate.toDouble());
		  if(chargeResponse.currency)
		  {
			  fundTransferRequest.setChargeExchangeRate(chargeExchangeRate.toDouble());
			  fundTransferRequest.setTransactionCharges(chargeAmount);
			  fundTransferRequest.setTransactionChargesCurrency(chargeResponse?.chargeCurrency?.code);              
		  }
		  fundTransferRequest.dailyUtilizedLimit= transactionLimitResponse?.dailyAmountUtilized>=0 ? transactionLimitResponse?.dailyAmountUtilized.add(debitAmount) : new BigDecimal(0);
		  fundTransferRequest.dailyUtilizedCount=transactionLimitResponse?.dailyUtilizedCount>=0 ? transactionLimitResponse?.dailyUtilizedCount + 1 : new Integer(0);
		  fundTransferRequest.monthlyUtilizedLimit=transactionLimitResponse?.monthlyAmountUtilized>=0 ? transactionLimitResponse?.monthlyAmountUtilized.add(debitAmount) : new BigDecimal(0);
		  fundTransferRequest.monthlyUtilizedCount=transactionLimitResponse?.monthlyUtilizedCount>=0 ? transactionLimitResponse?.monthlyUtilizedCount + 1 : new Integer(0);
		  
		  //To send exact calculated amount to IM incase of cross currency payment
		  fundTransferRequest.creditAmount=creditAmount;
		  fundTransferRequest.debitAmount=debitAmount;
		  fundTransferRequest.transactionCurrency = transferCurrency
		  setSessionAttribute("FTR", fundTransferRequest);
		  String mpin = fundTransferRequest.getMpin();
		  setSessionAttribute("MPIN",mpin);   
		  session.removeAttribute("LIMIT") 
		  
		  if(fundTransferRequest?.isAWarning)
		  {
			  model<<[postProcessModel:postProcessModel,isAWarning:fundTransferRequest?.isAWarning,warningErrorCodes:fundTransferRequest?.warningErrorCodes,errorClass:"info"]
		  }
		  else
		  {  
			  model<<[postProcessModel:postProcessModel,isAWarning:Boolean.FALSE]
		  }  
		 
		
	}
	
	def payLaterPreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		DateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
		Date date = params.configuredPaymentDate ? (Date)formatter.parse(params.configuredPaymentDate):null;
		Date currentDate = formatter.parse(formatter.format(new Date())) 
		date = (date != null) ? date.compareTo(currentDate) > 0 ? date : null : null
		model<<[configuredPaymentDate:  StringUtils.hasText(params?.eventRef) ? date : null];     
	}
	def repeatPreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		DateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");        
		Date startDate = (params.confStartDate && StringUtils.hasText(params?.eventRef)) ? (Date)formatter.parse(params.confStartDate):null;
		Date endDate = (params.confEndDate && StringUtils.hasText(params?.eventRef)) ? (Date)formatter.parse(params.confEndDate):null;
		def confFrequency = (params.confFrequency && StringUtils.hasText(params?.eventRef)) ? params.confFrequency : null
		model<<[confStartDate:startDate,confEndDate:endDate,confFrequency:confFrequency,eventRef:params.eventRef];  
	}
	def approvePreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		model<<[successAction:'approveFundTransfer',serviceCode:params.toTSTCode];
	}
	def approvePreConfirmImps(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		model<<[successAction:'approveFundTransfer',serviceCode:params.toTSTCode];
	}
	
	def rejectPreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		model<<[successAction:'rejectFundTransfer',serviceCode:params.toTSTCode];
	}
	//private methods
	private FundTransferRequest getFundTranferRequest(Map params,FundTransferRequest fundTransferRequest)
	{
		fundTransferRequest.setFromAccountId(params.fromAccountId)
		fundTransferRequest.setToAccountId(params.toAccountId)
		fundTransferRequest.setTransferCurrencyID(params.currencyId)
		fundTransferRequest.setPaymentAmount(params.paymentAmount.toBigDecimal())
		fundTransferRequest.setPaymentDate(new Date())		
		fundTransferRequest.setPaymentRemarks(params.paymentRemarks)
		fundTransferRequest.setCreditCardPaymentAmountType(params.amount_type);
		if(params.paymentScheduleDetailId){
			fundTransferRequest.setPaymentScheduleDetailId(params.paymentScheduleDetailId.toLong());
		}
		if(params.paymentScheduleHeaderId){
			fundTransferRequest.setPaymentScheduleHeaderId(params.paymentScheduleHeaderId.toLong());
		}
		if(params.datelineReferenceId){
			fundTransferRequest.setDatelineReferenceId(params.datelineReferenceId.toLong());
		}
		/// This is only for Loan Payment
		if(params?.loanPayAmtType){
			fundTransferRequest.setLoanPayAmtType(params?.loanPayAmtType);
		}
		/// This is only for Loan Payment
		if(params?.closureIns){
			fundTransferRequest.setClosureInstruction(params?.closureIns);
		}
		// This is only for Pending Transaction Execution
		if(params?.isTransactionAuthorization){
			fundTransferRequest.isTransAuthRequired = true
			fundTransferRequest.paymentDetailId = params?.pendingTransactionId?.toLong()
		}
		//fundTransferRequest.setCharges(Double.parseDouble("12"));
		return fundTransferRequest;
	}
	
	private FundTransferRequest prepareFundTranferRequest(Map params,FundTransferRequest fundTransferRequest)
	{
		fundTransferRequest.setFromAccountId(params.fromAccountId)
		fundTransferRequest.setToAccountId(params.toAccountId)
		fundTransferRequest.setTransferCurrencyID(params.currencyId)
		fundTransferRequest.setPaymentAmount(params.paymentAmount.toBigDecimal())
		fundTransferRequest.setPaymentDate(new Date())
		fundTransferRequest.setPaymentRemarks(params.paymentRemarks)
		fundTransferRequest.setCreditCardPaymentAmountType(params.amount_type);
		if(params.paymentScheduleDetailId){
			fundTransferRequest.setPaymentScheduleDetailId(params.paymentScheduleDetailId.toLong());
		}
		if(params.paymentScheduleHeaderId){
			fundTransferRequest.setPaymentScheduleHeaderId(params.paymentScheduleHeaderId.toLong());
		}
		if(params.datelineReferenceId){
			fundTransferRequest.setDatelineReferenceId(params.datelineReferenceId.toLong());
		}
		/// This is only for Loan Payment
		if(params?.loanPayAmtType){
			fundTransferRequest.setLoanPayAmtType(params?.loanPayAmtType);
		}
		/// This is only for Loan Payment
		if(params?.closureIns){
			fundTransferRequest.setClosureInstruction(params?.closureIns);
		}		
		return fundTransferRequest;
	}	
	
	/*
	 * This method moved to common service
	 * private ExchangeRateResponse getExchangeRate(String fromCurrency,String toCurrency,GenericRequestHeader requestHeader)
	{
		ExchangeRateRequest exchangeRateRequest=getBean(ExchangeRateRequest.class, requestHeader, null);
		exchangeRateRequest.setFromCurrency(fromCurrency);
		exchangeRateRequest.setToCurrency(toCurrency);
		return bmClient.accountService.getExchangeRate(exchangeRateRequest);
	}*/
		
	private  BigDecimal calculateDebitAmount(String exchangeRate,BigDecimal paymentAmount,String fromCurrency,String transferCurrency,BigDecimal fromCurrDesPosition)
	{
		if(fromCurrency.equals(transferCurrency))
		{
			return paymentAmount
		}else{
			return (1.toBigDecimal().divide(exchangeRate.toBigDecimal(),fromCurrDesPosition.toInteger(),RoundingMode.HALF_UP).multiply(paymentAmount))
		}
		
	} 
	
	private  BigDecimal calculateCreditAmount(String exchangeRate,BigDecimal paymentAmount,String fromCurrency,String toCurrency,String transferCurrency,BigDecimal toCurrDesPosition,String baseCurrency)
	{
		if(toCurrency.equals(transferCurrency))
		{
			return paymentAmount
		}
		else if(fromCurrency.equals(baseCurrency)&&(!toCurrency.equals(baseCurrency))&&(!transferCurrency.equals(baseCurrency))&&(!toCurrency.equals(transferCurrency)))
		{
			return exchangeRate.toBigDecimal().multiply(paymentAmount)
		}
		else if(fromCurrency.equals(toCurrency))
		{
			return exchangeRate.toBigDecimal().multiply(paymentAmount)
		}
		else {
			return (1.toBigDecimal().divide(exchangeRate.toBigDecimal(),toCurrDesPosition.toInteger(),RoundingMode.HALF_UP).multiply(paymentAmount))
		}
	
	}
	
	private BigDecimal calculateChargeAmount(String fromCurrency,String chargeCurrency,String chargeExchangeRate,BigDecimal chargeAmount)
	{
			return chargeExchangeRate.toBigDecimal().multiply(chargeAmount)    
	}
	
	private Boolean checkBalance(BigDecimal debitAmount,BigDecimal chargeAmount,BigDecimal availableBalance)
	{
  		if(availableBalance.compareTo(debitAmount.add(chargeAmount))==-1)		
			return Boolean.TRUE;
		else	
			return Boolean.FALSE;
	}
	
	def investmentPayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		FavouritePaymentDetailRequest favouritePaymentDetailRequest=getBean(FavouritePaymentDetailRequest.class, requestHeader, params);
		InvestmentDetailRequest investmentDetailRequest = getBean(InvestmentDetailRequest.class, requestHeader,params);
		investmentDetailRequest.setAccountId(params.beneId.toLong())
		InvestmentDetailResponse investmentDetailResponse=bmClient.investmentService.getInvestmentDetail(investmentDetailRequest);
		favouritePaymentDetailRequest.setAccountId(params.beneId.toLong())
		FavouritePaymentDetailResponse favouritePaymentDetailResponse=bmClient.paymentService.getOwnAccountFavouritePayments(favouritePaymentDetailRequest);
		if(favouritePaymentDetailResponse.hasErrors()){
			model<<[errors:favouritePaymentDetailResponse.errors()]
		}else{
			model<<[favPaymentDetailModel:favouritePaymentDetailResponse,cardDetailsModel:investmentDetailResponse]
		}
	}
	def fetchEMIAmount(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		LoanDetailsRequest loanDetailRequest = getBean(LoanDetailsRequest.class,requestHeader, params);
		long acctId = Long.parseLong(params?.toBeneIdVer.split(",")[0]);
		loanDetailRequest.setAccountId(acctId);
		LoanDetailsResponse response = bmClient.loanService.fetchInstallmentAmount(loanDetailRequest);
		if(response.hasErrors()){
			model<<[errors:response.errors()]
		}else{
			def transferCurrency = [] as HashSet<Currency>;
			transferCurrency.add(response?.loanDetail?.currency);
			model<<[installmentAmt:response?.loanDetail?.nextInstallmentAmount,installmentCur:transferCurrency?.toList()]
		}
	}
		//SI Starts
	def standingInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		
		StandingOrderInformationRequest request = getBean(StandingOrderInformationRequest.class,requestHeader,params)
		request.getCifNumbers().add(requestHeader?.invoker?.primaryCIF)
		StandingOrderInformationResponse response = bmClient.paymentService.getStandingOrderInformations(request)
		model<<[paymentScheduleHeaders:response.paymentScheduleHeaders]    
	}
	def suspendStandingInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		FundTransferRequest ftr = getBean(FundTransferRequest.class,"fundTransferRequest",requestHeader,params) 
		ftr.soFlag = SOFlagEnum.S
		ftr.paymentScheduleHeaderId = params?.long('paymentScheduleHeaderId')
		FundTransferResponse res = bmClient.paymentService.suspendStandingOrder(ftr)
		if(res.hasErrors()){
			model<<[errors:res.errors()]
		}else{
		standingInstruction(params, requestHeader, model)
		setMessage(DEFAULT_DELETED_MESSAGE,[
			"Standing Instruction ",
			params.code+" successfully"
		], model)
		}
	}
	private IBUserProfileResponse getuserprofilereponse(){
		Long loginprofileId = getUserLoginProfile().getId();
		IBUserProfileResponse userProfileResponse = commonService.getIBUserProfileDetails(loginprofileId);
		return userProfileResponse;
	}
	/**
	 * @author elanchezhiyan
	 * @param params
	 * @param requestHeader
	 * @param model
	 * @return
	 * @throws BusinessException
	 */
	def pendingTransactions(Map params, GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		PaymentDetailRequest request	=	getBean(PaymentDetailRequest.class, requestHeader, params);
		def pageNumber = (StringUtils.hasText(params?.gotoPage))? params?.int('gotoPage') : 0;
		PageRequest page = new PageRequest(pageNumber, 5);
		request.setPageRequest(page);
		PaymentDetailResponse response	=	bmClient.paymentService.getPendingTransactions(request);
		model <<[pendingPaymentDetailModel:response.pastPaymentDetail,pagerModel:response?.getPage()];
	}
	/**
	 * @author elanchezhiyan
	 * @param params
	 * @param requestHeader
	 * @param model
	 * @return
	 * @throws BusinessException
	 */
	def pendingTransactionsPage(Map params, GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		pendingTransactions(params, requestHeader, model)
	}
	def viewPendingTransaction(Map params,GenericRequestHeader requestHeader,ModelMap model)throws BusinessException{
		PaymentDetailRequest request	=	getBean(PaymentDetailRequest.class, requestHeader, params);
		request.paymentDetailId = params.long('paymentDetailId')
		PaymentDetailResponse response	=	bmClient.paymentService.getPendingTransaction(request);
		if(response.hasErrors()){
			model<<[errors:response.errors()]
		}else{
			model<<[paymentDetail:response?.acctBalancePaymentDetail]
		}
	}
	def executePendingTransaction(Map params,GenericRequestHeader requestHeader,ModelMap model)throws BusinessException{
		params?.buttonEvent = 'PAYNOW'
		params?.isTransactionAuthorization = 'YES'
		validatefundtransfer(params, requestHeader, model)
		
		AccountBalanceRequest accountBalanceRequest=getBean(AccountBalanceRequest.class, requestHeader, null);
		accountBalanceRequest.accountId = getIdVersion(params.fromAccountId)[0];
		AccountBalanceResponse accountBalanceResponse= commonService.getAccountBalance(accountBalanceRequest);
		setSessionAttribute("BAL", accountBalanceResponse)
		
		TransactionLimitResponse transactionLimitResponse = getPayerLimitDetails(requestHeader,getIdVersion(params.toAccountId)[0],null,getInvoker().getUserLoginProfileId());
		if(transactionLimitResponse.hasErrors()) {
			model<<[errors:transactionLimitResponse.errors()]
		}
		setSessionAttribute("LIMIT", transactionLimitResponse)
		
		paymentPostProcess(params, requestHeader, model)
		
		model<<[success:"SUCCESS"]
		
	}
	def discardPendingTransaction(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		PaymentDetailRequest request = getBean(PaymentDetailRequest.class, "paymentDetailRequest", requestHeader, params)
		request.paymentDetailId = params?.pendingTransactionId?.toLong();
		PaymentDetailResponse response = bmClient.paymentService.discardPendingTransaction(request)
		if(response.hasErrors()){
			model<<[errors:response.errors()]
		} else {
		def pageNumber = (StringUtils.hasText(params?.gotoPage))? params?.int('gotoPage') : 0;
		PageRequest page = new PageRequest(pageNumber, 5);
		request.setPageRequest(page);
		response	=	bmClient.paymentService.getPendingTransactions(request);
		setMessage(DEFAULT_DELETED_MESSAGE,["Pending Transaction ",params.pendingTransactionId+" successfully"], model)
		model <<[pendingPaymentDetailModel:response.pastPaymentDetail,pagerModel:response?.getPage()]; 
		}
	}
	
	/**
	 * This method is used for Credit Card Excess Balance Transfer
	 * 
	 * @param params
	 * @param requestHeader
	 * @param model
	 * @return
	 * @throws BusinessException
	 */
	def ccTransferExcessCredit(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		/*FavouritePaymentDetailRequest favouritePaymentDetailRequest=getBean(FavouritePaymentDetailRequest.class, requestHeader, params);
		CreditCardDetailRequest creditCardDetailRequest = getBean(CreditCardDetailRequest.class, requestHeader,params);
		String creditCardNumber=params.creditCardNumber;
		creditCardDetailRequest.setAccountId(params.beneId.toLong())
		creditCardDetailRequest.setCreditCardNumber(creditCardNumber)
		CreditCardDetailResponse creditCardDetailResponse=bmClient.creditCardService.getCreditCardDetail(creditCardDetailRequest);
		favouritePaymentDetailRequest.setAccountId(params.beneId.toLong())
		FavouritePaymentDetailResponse favouritePaymentDetailResponse=bmClient.paymentService.getOwnAccountFavouritePayments(favouritePaymentDetailRequest);
		if(favouritePaymentDetailResponse.hasErrors()){
			model<<[errors:favouritePaymentDetailResponse.errors()]
		}else{
			session.removeAttribute("FTR")
			model<<[favPaymentDetailModel:favouritePaymentDetailResponse,cardDetailsModel:creditCardDetailResponse]
		}*/
	}
}

//Command Objects
class FundTransferCommand {
	String fromAccountId;
	String toAccountId;
  	String currencyId;
	String paymentAmount;
	String paymentRemarks;
	 
	
	static constraints={
		fromAccountId(blank: false)    
  		toAccountId(blank: false)    
   		currencyId(blank: false)
		paymentRemarks(blank:true,shared : 'remarksConstraint')
		paymentAmount shared:"numericConstraint"
 		paymentAmount validator:{val,obj ->
			if(val=='')
			{
				obj.errors.rejectValue('paymentAmount','fundTransferCommand.paymentAmount.blank')
			}
		};
		
	}
}
class LoanFundTransferCommand {
	String fromAccountId;
	String toAccountId;
	String currencyId;
	String paymentAmount;
	String loanPayAmtType;
	String closureIns;
	static constraints={
		fromAccountId(blank: false)
		toAccountId(blank: false)
		currencyId(blank: false)
		loanPayAmtType blank: false ,validator:{val,obj->
			if(val=="PP")	{
				if(!StringUtils.hasLength(obj.closureIns)){
					obj.errors.rejectValue('loanPayAmtType','loanFundTransferCommand.closureIns.matches.error')
				}
			}
		};
	    paymentAmount shared:"numericConstraint"
		paymentAmount validator:{val,obj ->
			if(val=='')
			{
				obj.errors.rejectValue('paymentAmount','fundTransferCommand.paymentAmount.blank')
			}
			if(StringUtils.hasLength(val))
			{
				BigDecimal bdecimal = new BigDecimal(val);
				if(bdecimal.compareTo(BigDecimal.ZERO) > 0)
				{
					
				}else{
					obj.errors.rejectValue('paymentAmount','loanFundTransferCommand.paymentAmount.invalid')
				}
			}
		};
	}
}
class CancelPayCommand{
	String paymentScheduleDetailId;
	static constraints={
		paymentScheduleDetailId(blank: false)
	}
}

class PayLaterCommand {
	String paymentDate;

	static constraints={
		paymentDate(blank: false)
		paymentDate validator:{val,obj ->
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");   
			Date date = (Date)formatter.parse(val); 
			Date currentDate = formatter.parse(formatter.format(new Date()));
			if(date.compareTo(currentDate) <= 0){
				obj.errors.rejectValue('paymentDate','fundTransferCommand.paymentDate.matches.error')
			}
		};
	}
}
	
class SchedulePayCommand {
	String startDate;
	String frequency;
//	String noOfTimes;
	String endDate;

	static constraints={
		startDate(blank: false)
		frequency(blank:false)
//		noOfTimes(blank:false)
		endDate(blank: false)
		
	}
}
	class ViewSchedulePaymentCommand{
		String beneId;
		String beneInsId;
		static constraints={
			 beneId(blank: false)
			 beneInsId(blank: false)
		 }
	}
	
	class StopSchedulePaymentCommand{
		String paySchId;
		static constraints={
			 paySchId(blank: false)
		 }
	}