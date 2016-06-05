package com.vayana.ib.retail.web.service

import java.math.RoundingMode

import javax.servlet.http.HttpSession

import org.apache.http.client.utils.URIBuilder
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils

import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.common.utils.MoneyUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.ContextCodeType
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.constants.LookupCodeConstants
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants
import com.vayana.ib.bm.core.api.beans.account.AccountBalanceRequest
import com.vayana.ib.bm.core.api.beans.account.AccountBalanceResponse
import com.vayana.ib.bm.core.api.beans.biller.BillerRequest
import com.vayana.ib.bm.core.api.beans.biller.BillerResponse
import com.vayana.ib.bm.core.api.beans.charges.ChargeResponse
import com.vayana.ib.bm.core.api.beans.exchangerate.ExchangeRateRequest
import com.vayana.ib.bm.core.api.beans.exchangerate.ExchangeRateResponse
import com.vayana.ib.bm.core.api.beans.payment.FavouritePaymentDetailRequest
import com.vayana.ib.bm.core.api.beans.payment.FavouritePaymentDetailResponse
import com.vayana.ib.bm.core.api.beans.payment.PaymentDetailRequest
import com.vayana.ib.bm.core.api.beans.payment.PaymentDetailResponse
import com.vayana.ib.bm.core.api.beans.payment.TransactionLimitRequest
import com.vayana.ib.bm.core.api.beans.payment.TransactionLimitResponse
import com.vayana.ib.bm.core.api.beans.security.SecurityHolder
import com.vayana.ib.bm.core.api.beans.transfers.BillPaymentTransferRequest
import com.vayana.ib.bm.core.api.beans.transfers.BillPaymentTransferResponse
import com.vayana.ib.bm.core.api.beans.transfers.PaymentTransferRequest
import com.vayana.ib.bm.core.api.beans.transfers.PaymentTransferResponse
import com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction
import com.vayana.ib.bm.core.api.model.enums.PaymentButtonEnum
import com.vayana.ib.bm.core.api.model.enums.PaymentTypeEnum
import com.vayana.ib.bm.core.api.model.enums.SchedulePaymentEnum
import com.vayana.ib.bm.core.api.model.enums.TransactionTypeEnum
import com.vayana.ib.bm.core.api.model.payment.BillerInstruction
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class BillPaymentService extends GenericService{
	
	BmClient bmClient;
	CommonService commonService
	
/*	@Autowired
	SessionRegistryImpl sessionRegistry;*/
	
	private static final PROCESS_PAYNOW_ACTION="processbillpayment"
	private static final PROCESS_PAYLATER_ACTION="processbillpaymentlater"
	private static final PROCESS_REPEAT_ACTION="processbillschedulepayment"
	private static final PAYMENT_CONTROLLER="billPayment"
	private static final CANCEL_PAYMENT_ACTION="confirmCancelSIPayment";
	
	/*def billpayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
				
		FavouritePaymentDetailRequest favouritePaymentDetailRequest=getBean(FavouritePaymentDetailRequest.class, requestHeader, params);
		favouritePaymentDetailRequest.setBeneId(params.beneId.toLong())
		FavouritePaymentDetailResponse favouritePaymentDetailResponse=bmClient.billPaymentService.getFavouriteBillPayments(favouritePaymentDetailRequest);
		if(QuickPayButtonEnum.PAY.toString().equals(params.buttonEvent)){
			favouritePaymentDetailResponse.acctBalancePaymentDetail=null;
		}
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, null);
		CommonResponse commonResponse=null;
		commonResponse=bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
		com.vayana.bm.core.api.model.common.Currency baseCurrencyObj=commonResponse.getCommonEntity()
		
		if(favouritePaymentDetailResponse.hasErrors()){
			model<<[errors:favouritePaymentDetailResponse.errors()]
		}else{
			session.removeAttribute("FTR")
			model<<[favPaymentDetailModel:favouritePaymentDetailResponse,datelineRef:params.taskId,baseCurrencyModel:baseCurrencyObj]
		}		

	}*/
	
	
	private BillPaymentTransferRequest getBillPaymentRequest(Map params,BillPaymentTransferRequest billPaymentTransferRequest){
		billPaymentTransferRequest.setBillerInstructionId(params.billerInstructionId)
		billPaymentTransferRequest.setFromAccountId(params.fromAccountId)
		billPaymentTransferRequest.setToAccountId(params.toAccountId)
		billPaymentTransferRequest.setTransferCurrencyID(params.billCurrencyId)
		log.info("--------------------------------------------------------------------------");
		log.info("Params Payment Amount =======================>"+params?.paymentAmount);
		billPaymentTransferRequest.setPaymentAmount(new BigDecimal(params?.paymentAmount))
		log.info("Request Payment Amount =======================>"+billPaymentTransferRequest?.paymentAmount)
		log.info("--------------------------------------------------------------------------");
		billPaymentTransferRequest.setPaymentDate(new Date())
		billPaymentTransferRequest.setReferenceTag("" + new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()))
		billPaymentTransferRequest.setPaymentRemarks(params.paymentRemarks)
		billPaymentTransferRequest.setBillPaymentAmountType(params.amount_type);
		if(params.paymentScheduleDetailId){
			billPaymentTransferRequest.setPaymentScheduleDetailId(params.paymentScheduleDetailId.toLong());
		}
		if(params.paymentScheduleHeaderId){
			billPaymentTransferRequest.setPaymentScheduleHeaderId(params.paymentScheduleHeaderId.toLong());
		}
		if(params.datelineReferenceId){
			billPaymentTransferRequest.setDatelineReferenceId(params.datelineReferenceId.toLong());
		}
		billPaymentTransferRequest.setPaymentType(TransactionTypeEnum.BILLPAYMENT);
		//billPaymentTransferRequest.setCharges(Double.parseDouble("12"));
		billPaymentTransferRequest.setThirdPartyReferenceId(params.thirdPartyReferenceId)
		billPaymentTransferRequest.setBeneficiaryName(params?.merchantName)
		billPaymentTransferRequest.setMerchantName(params?.merchantName)
		billPaymentTransferRequest.setPID(params?.PID);
		billPaymentTransferRequest.setReturnUrl(params?.returnUrl);
		return billPaymentTransferRequest;
	}
	
	
	/*def billInquiry(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BillPaymentTransferRequest billPaymentTransferRequest = getBean(BillPaymentTransferRequest.class, requestHeader, params);
		billPaymentTransferRequest.setCifNumber(invoker.getPrimaryCIF());		
		BillPaymentTransferResponse BillPaymentTransferResponse = bmClient.billPaymentService.getBillAmount(billPaymentTransferRequest);
		if(BillPaymentTransferResponse.hasErrors()){
			model<<[errors:BillPaymentTransferResponse.errors()]
		}else{
			model<<[billInquiryModel:BillPaymentTransferResponse]
		}
	}
	
	def billerServiceType(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BillPaymentTransferRequest billPaymentTransferRequest = getBean(BillPaymentTransferRequest.class, requestHeader, params);
		billPaymentTransferRequest.setBillerInstructionId(params.payeeId);
		BillPaymentTransferResponse BillPaymentTransferResponse = bmClient.billPaymentService.getBillerServiceType(billPaymentTransferRequest);
						
		if(BillPaymentTransferResponse.hasErrors()){
			model<<[errors:BillPaymentTransferResponse.errors()]
		}else{
			model<<[billServiceModel:BillPaymentTransferResponse]
		}
	}	
	
	def scheduledfavourite(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		FavouritePaymentRequest favouritePaymentRequest=getBean(FavouritePaymentRequest.class, requestHeader, params);
		favouritePaymentRequest.setPaymentDetailId(params.long('paymentId'))
		favouritePaymentRequest.setIbUserLoginProfileId(getUserLoginProfile().getId())
		favouritePaymentRequest.setPaymentType("SP");
		favouritePaymentRequest.setFavouriteType("BP");
		favouritePaymentRequest.setBeneId(params.long('beneId'))
		favouritePaymentRequest.setBillerId(params.long('beneId'))
		favouritePaymentRequest.setFavouriteFlag(params.favouriteId);
		FavouritePaymentResponse favouritePaymentResponse=bmClient.billPaymentService.createFavouritePayment(favouritePaymentRequest);
		if(favouritePaymentResponse.hasErrors()){
			model<< [errors:favouritePaymentResponse]
		}else{
			model<< [favPaymentModel:favouritePaymentResponse]
		}	
	}
	
	
	def pastpaymentfavourite(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{		
		FavouritePaymentRequest favouritePaymentRequest=getBean(FavouritePaymentRequest.class, requestHeader, params);
		favouritePaymentRequest.setPaymentDetailId(params.long('paymentId'))	
		favouritePaymentRequest.setIbUserLoginProfileId(getUserLoginProfile().getId())
		favouritePaymentRequest.setPaymentType("PP");
		favouritePaymentRequest.setFavouriteType("BP");
		favouritePaymentRequest.setBeneId(params.long('beneId'))
		favouritePaymentRequest.setBillerId(params.long('beneId'))
		favouritePaymentRequest.setFavouriteFlag(params.favouriteId);
		FavouritePaymentResponse favouritePaymentResponse=bmClient.billPaymentService.createFavouritePayment(favouritePaymentRequest);
		if(favouritePaymentResponse.hasErrors()){
			model<< [errors:favouritePaymentResponse]
		}else{
			model<< [favPaymentModel:favouritePaymentResponse]
		}
	 }
	
	def billpaynowconfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		BillPaymentTransferRequest billPaymentTransferRequest	=	(BillPaymentTransferRequest)getSessionAttribute("BPR");
		billPaymentTransferRequest.setTwoFactorTypeEnum(TwoFactorTypeEnum.NONE);		
		//billPaymentTransferRequest.setTransferType(tenantService.getService().getCode());
		String twoFactorType 		= 	billPaymentTransferRequest.twoFactorTypeEnum.toString();
		Long userLoginProfileId 	= 	getInvoker().getUserLoginProfileId();
		String secondaryController	=	"billPayment";
		String secondaryAction		=	"billpaynow";
		String twoFAModule			=	"otp_paynow_div";
		
		if(billPaymentTransferRequest.twoFactorTypeEnum.equals(TwoFactorTypeEnum.NONE)){
			BillPaymentTransferResponse billPaymentTransferResponse		=	bmClient.billPaymentService.billPaymentTransfer(billPaymentTransferRequest);
			if(billPaymentTransferResponse.hasErrors()){
				model<<[errors:billPaymentTransferResponse.errors()]
			}else{
				model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId, transferResponseModel:billPaymentTransferResponse]
			}
		}else{
			model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId,requestHeader:billPaymentTransferRequest.getRequestHeader(),secondaryAction:secondaryAction,twoFAModule:twoFAModule,secondaryController:secondaryController]
//			returned requestHeader for IM request in case OTP generation
		}
	}
	
	def billpaynow(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BillPaymentTransferRequest billPaymentTransferRequest	=	(BillPaymentTransferRequest)getSessionAttribute("BPR");		
		BillPaymentTransferResponse billPaymentTransferResponse	=	bmClient.billPaymentService.billPaymentTransfer(billPaymentTransferRequest);
		if(billPaymentTransferResponse.hasErrors())
		{
			model<<[errors:billPaymentTransferResponse.errors()]
		}
		else
		{
			model<<[transferResponseModel:billPaymentTransferResponse]
		}
	}
	
	
			
	def billpaylaterconfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		FundTransferResponse billPaymentTransferResponse	= null;
		PayLaterCommand payLaterCmd 	=	validateCommandObject(PayLaterCommand.class,params)
		if(payLaterCmd.hasErrors()){
			model << [error:payLaterCmd]
			return
		}
		
		BillPaymentTransferRequest billPaymentTransferRequest	=	(BillPaymentTransferRequest)getSessionAttribute("BPR");
		
		//To Override with Payment Date
		billPaymentTransferRequest.noOfTimes=1L;
		billPaymentTransferRequest.startDate=DateUtils.convertStringToDate(params.paymentDate, DateUtils.YYYY_MM_DD)
		billPaymentTransferRequest.setPaymentType(TransactionTypeEnum.BILLPAYMENT);
		
		if(params.datelineReferenceId){
			billPaymentTransferRequest.datelineReferenceId=params.datelineReferenceId.toLong();
		}
		
		if(params.paymentScheduleDetailId){
			billPaymentTransferRequest.setPaymentScheduleDetailId(params.paymentScheduleDetailId.toLong());
		}
		if(params.paymentScheduleHeaderId){
			billPaymentTransferRequest.setPaymentScheduleHeaderId(params.paymentScheduleHeaderId.toLong());
		}
		
		setSessionAttribute("BPR", billPaymentTransferRequest);
				
		String twoFactorType 		= 	billPaymentTransferRequest.twoFactorTypeEnum.toString();
		Long userLoginProfileId 	= 	getInvoker().getUserLoginProfileId();
		String secondaryController	=	"billPayment";
		String secondaryAction		=	"billpaylater";
		String twoFAModule			=	"otp_later_div";
		
		if(billPaymentTransferRequest.twoFactorTypeEnum.equals(TwoFactorTypeEnum.NONE)){
				billPaymentTransferRequest.noOfTimes		=	1L;
				billPaymentTransferRequest.startDate		=	DateUtils.convertStringToDate(params.paymentDate, DateUtils.YYYY_MM_DD)				
				//FundTransferResponse billPaymentTransferResponse	=	bmClient.paymentService.payLaterFundTransfer(billPaymentTransferRequest);
				if(billPaymentTransferResponse.paymentScheduleDetailId){
					billPaymentTransferResponse=bmClient.paymentService.updateScheduledPaymentFundTransfer(billPaymentTransferRequest);
			   }else{
					billPaymentTransferResponse=bmClient.paymentService.payLaterFundTransfer(billPaymentTransferRequest);
			   }
				
				
		if(billPaymentTransferResponse.hasErrors()){
				model<<[errors:billPaymentTransferResponse.errors()]
			}else{
				model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId, transferResponseModel:billPaymentTransferResponse]
			}
		}else{
			model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId,requestHeader:billPaymentTransferRequest.getRequestHeader(),secondaryAction:secondaryAction,twoFAModule:twoFAModule,secondaryController:secondaryController]
//			returned requestHeader for IM request in case OTP generation
		}
	   
	}
	
	def scheduledbillpayconfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		SchedulePayCommand schedulePayCmd 	=	validateCommandObject(SchedulePayCommand.class,params)
		if(schedulePayCmd.hasErrors()){
			model << [error:schedulePayCmd]
			return
		}
		BillPaymentTransferRequest billPaymentTransferRequest	=	(BillPaymentTransferRequest)getSessionAttribute("BPR");
		billPaymentTransferRequest.schedulePaymentEnum			=	params.frequency;
		billPaymentTransferRequest.startDate					=	DateUtils.convertStringToDate(params.startDate, DateUtils.YYYY_MM_DD)
		if(params.noOfTimes){
			billPaymentTransferRequest.noOfTimes				=	params.noOfTimes.toLong();
		}
		//To Override with Start Date,frequency etc..
		billPaymentTransferRequest.setPaymentType(TransactionTypeEnum.BILLPAYMENT);
		setSessionAttribute("BPR", billPaymentTransferRequest)
		String twoFactorType 		= 	billPaymentTransferRequest.twoFactorTypeEnum.toString();
		Long userLoginProfileId 	= 	getInvoker().getUserLoginProfileId();
		String secondaryController	=	"billPayment";
		String secondaryAction		=	"scheduledbillpay";
		String twoFAModule			=	"otp_repeat_div";
		
		if(billPaymentTransferRequest.twoFactorTypeEnum.equals(TwoFactorTypeEnum.NONE)){
			FundTransferResponse billPaymentTransferResponse		=	bmClient.paymentService.schedulePaymentFundTransfer(billPaymentTransferRequest);
			if(billPaymentTransferResponse.hasErrors()){
				model<<[errors:billPaymentTransferResponse.errors()]
			}else{
				model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId, transferResponseModel:billPaymentTransferResponse]
			}
		}else{
			model<<[twoFactorType:twoFactorType, userLoginProfileId:userLoginProfileId,requestHeader:billPaymentTransferRequest.getRequestHeader(),secondaryAction:secondaryAction,twoFAModule:twoFAModule,secondaryController:secondaryController]
//			returned requestHeader for IM request in case OTP generation
		}
	}
	
	def billpaylater(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		BillPaymentTransferRequest billPaymentTransferRequest	=	(BillPaymentTransferRequest)getSessionAttribute("BPR");
		//FundTransferResponse billPaymentTransferResponse		=		bmClient.paymentService.payLaterFundTransfer(billPaymentTransferRequest);
		FundTransferResponse billPaymentTransferResponse		=   null;
		if(billPaymentTransferRequest.paymentScheduleDetailId){
			billPaymentTransferResponse=bmClient.paymentService.updateScheduledPaymentFundTransfer(billPaymentTransferRequest);
	   }else{
			billPaymentTransferResponse=bmClient.paymentService.payLaterFundTransfer(billPaymentTransferRequest);
	   }
		
		
		if(billPaymentTransferResponse.hasErrors())
		{
			model<<[errors:billPaymentTransferResponse.errors()]
		}
		else
		{
			model<<[transferResponseModel:billPaymentTransferResponse]
		}
	}
	def scheduledbillpay(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		BillPaymentTransferRequest billPaymentTransferRequest		=	(BillPaymentTransferRequest)getSessionAttribute("BPR");
		FundTransferResponse billPaymentTransferResponse		=	bmClient.paymentService.schedulePaymentFundTransfer(billPaymentTransferRequest);
	   if(billPaymentTransferResponse.hasErrors())
		{
			model<<[transferResponseModel:billPaymentTransferResponse.errors()]
		}
		else
		{
			model<<[transferResponseModel:billPaymentTransferResponse]
		}
	}
	
	def showPaymentOriginPage(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		println params.dump();			
			FavouritePaymentDetailRequest paymentDetailRequest = new FavouritePaymentDetailRequest()
			paymentDetailRequest.setRequestHeader(requestHeader);
			paymentDetailRequest.setPaymentDetailId(params.taskInstanceId.toLong());
			paymentDetailRequest.setPaymentType("SI");
			FavouritePaymentDetailResponse paymentDetailResponse = bmClient.paymentService.getPaymentDetails(paymentDetailRequest);			
			if(paymentDetailResponse.hasErrors()){
				model<<[errors:paymentDetailResponse.errors()]
			}else{
				model<<[favPaymentDetailModel:paymentDetailResponse,datelineRef:params.id,SICancelFlag:paymentDetailRequest.getPaymentType()]
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
	}*/
	
	/**
	 * @author nagabhushanam
	 * @param params
	 * @param requestHeader
	 * @param model
	 * @return
	 * @throws BusinessException
	 */
	
	def validatefundtransfer(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		//For server side validation
		 BillPaymentCommand  fundTransferCmd=validateCommandObject(BillPaymentCommand.class,params)
		   if(fundTransferCmd.hasErrors()){
			model << [errors:fundTransferCmd]
			return
		}
		
		BillPaymentTransferRequest billPaymentTransferRequest	=	new BillPaymentTransferRequest();
		SecurityHolder securityHolder=getBean(SecurityHolder.class, requestHeader, params);
		securityHolder.setSuccessController(PAYMENT_CONTROLLER)
		
		BillPaymentTransferResponse billPaymentTransferResponse=null;
		
		billPaymentTransferRequest	=	getBillPaymentRequest(params, billPaymentTransferRequest)
		billPaymentTransferRequest.setRequestHeader(requestHeader)
		billPaymentTransferRequest.setTransactionType(params?.buttonEvent)
		
		
		
		if(PaymentButtonEnum.PAYNOW.toString().equals(params?.buttonEvent))
		{
			billPaymentTransferResponse=bmClient.billPaymentService.validatePayNow(billPaymentTransferRequest);
			securityHolder.setSuccessAction(PROCESS_PAYNOW_ACTION)
		}else if(PaymentButtonEnum.LATER.toString().equals(params?.buttonEvent))
		{
			PayLaterCommand payLaterCmd =validateCommandObject(PayLaterCommand.class,params)
			if(payLaterCmd.hasErrors()){
				model << [errors:payLaterCmd]
				return
			}
			billPaymentTransferRequest.noOfTimes=1L;
			billPaymentTransferRequest.startDate=DateUtils.convertStringToDate(params.paymentDate, DateUtils.YYYY_MM_DD)
			billPaymentTransferResponse=bmClient.billPaymentService.validatePayLater(billPaymentTransferRequest);
			securityHolder.setSuccessAction(PROCESS_PAYLATER_ACTION)
		}else if(PaymentButtonEnum.REPEAT.toString().equals(params?.buttonEvent))
		{
			SchedulePayCommand schedulePayCmd =validateCommandObject(SchedulePayCommand.class,params)
			if(schedulePayCmd.hasErrors()){
				model << [errors:schedulePayCmd]
				return
			}
			billPaymentTransferRequest.setSchedulePaymentEnum(SchedulePaymentEnum.valueOf(params.frequency));
			billPaymentTransferRequest.noOfTimes=params?.noOfTimes?.toLong();
			billPaymentTransferRequest.startDate=DateUtils.convertStringToDate(params.startDate, DateUtils.YYYY_MM_DD)
			billPaymentTransferRequest.endDate=DateUtils.convertStringToDate(params.endDate, DateUtils.YYYY_MM_DD)
			billPaymentTransferResponse=bmClient.billPaymentService.validateRepeat(billPaymentTransferRequest);
			securityHolder.setSuccessAction(PROCESS_REPEAT_ACTION)
		}else if(PaymentButtonEnum.CANCELPAYMENT.toString().equals(params?.buttonEvent)){
			CancelBillPayCommand cancelPayCmd 	=	validateCommandObject(CancelBillPayCommand.class,params)
			if(cancelPayCmd.hasErrors()){
				model << [errors:cancelPayCmd]
				return
			}
			billPaymentTransferResponse=bmClient.billPaymentService.validatePayNow(billPaymentTransferRequest);
			securityHolder.setSuccessAction(CANCEL_PAYMENT_ACTION)
		}
		
		if(!billPaymentTransferResponse.hasErrors()){
			setSessionAttribute("FTR", billPaymentTransferResponse.getBillPaymentTransferRequest());
			setSessionAttribute("SECHOLD", securityHolder)
			setSessionAttribute("BUTTONEVENT", params?.buttonEvent)
		}
		model<<[transferResponseModel:billPaymentTransferResponse]
	}
		
	def paymentPostProcess(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		log.info("**** Inside Payment Post Process Method in Bill Payment Service.Groovy ****");   
		BillPaymentTransferRequest billPaymentTransferRequest = (BillPaymentTransferRequest) getSessionAttribute("FTR");
		TransactionLimitResponse transactionLimitResponse=(TransactionLimitResponse)getSessionAttribute("LIMIT")
		log.info("Transaction Limit Code:::::"+transactionLimitResponse?.code);
		AccountBalanceResponse accountBalanceResponse=(AccountBalanceResponse)getSessionAttribute("BAL")
		billPaymentTransferRequest.setCifNumber(invoker.getPrimaryCIF());
		// Set the Limit Utilization if available
		if(transactionLimitResponse?.getMatchingLimitUtilization()!=null && transactionLimitResponse?.getMatchingLimitUtilization()?.getId()!=null)
		{
			log.info("Limit Utilization Id :::"+transactionLimitResponse?.matchingLimitUtilization?.id);
			billPaymentTransferRequest.setLimitUtilizationId(transactionLimitResponse?.getMatchingLimitUtilization().getId());
		}
		def fromAccountId=billPaymentTransferRequest.getFromAccountId();
		def toAccountId=billPaymentTransferRequest.getToAccountId();
		def transferCurencyId=billPaymentTransferRequest.getTransferCurrencyID();
		def fromCurrency,toCurrency,transferCurrency,baseCurrency
		def fromExchangeRate="1",toExchangeRate="1",chargeExchangeRate="1"
		def debitAmount,creditAmount,chargeAmount
		def fromCurrDesPosition,toCurrDesPosition
		def debitCurrencyDisplay
		def beneficiaryNickName
		def Map<String,String> postProcessModel=new HashMap<String, String>();
		def cancelAction
		
		def fromAccountNumber 	= 	billPaymentTransferRequest?.fromAccount?.accountNumber;
		def toAccountNumber		=	null;
		def dummyAccountNumber	=	null;
		def currencySelection	=	null;
		def fromAccntCurrcyIsoCode = null;
		
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, null);
		ExchangeRateResponse exgRateRes=null;
		CommonResponse commonResponse=null;
		
		fromCurrency=billPaymentTransferRequest?.fromAccount?.currency?.code;
		fromCurrDesPosition=billPaymentTransferRequest?.fromAccount?.currency?.numberOfSubUnits;
		
		//Commented for KHCB implementation, For KHCB toCurrency=baseCurrency
		
		/*com.vayana.bm.core.api.model.common.Currency toCurrencyobj=billPaymentTransferRequest?.billerAccount?.currency;
		toCurrency=toCurrencyobj.getCode();
		toCurrDesPosition=toCurrencyobj?.numberOfSubUnits;*/ 
		
		commonResponse=bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
		com.vayana.bm.core.api.model.common.Currency baseCurrencyObj=commonResponse.getCommonEntity()
		baseCurrency=baseCurrencyObj.code;
		
		//For KHCB toCurrency=baseCurrency
		toCurrency=baseCurrency;
		toCurrDesPosition=baseCurrencyObj?.numberOfSubUnits;
		
		//com.vayana.bm.core.api.model.common.Currency transferCurrencyObj=commonService.getCurrency(transferCurencyId)
		//transferCurrency=transferCurrencyObj?.code
		transferCurrency=baseCurrencyObj.code;
		String transCurrIsoCode	=	commonService.getCurrencyFormat(baseCurrencyObj?.currencyIsoCode?.toString())
		billPaymentTransferRequest.transferCurrencyID = baseCurrencyObj?.idVersion;
		
		/*currencySelection = (fromCurrency.equals(transferCurrency)) ? 'F' : (toCurrency.equals(transferCurrency)) ? 'T' : baseCurrencyObj?.currencyIsoCode?.toString() ;
		dummyAccountNumber = "F".equals(currencySelection) ? fromAccountNumber : "T".equals(currencySelection) ? toAccountNumber : null;*/
		
		dummyAccountNumber = "";
		currencySelection = getCurrencyFormat(baseCurrencyObj?.currencyIsoCode?.toString());
		fromAccntCurrcyIsoCode = getCurrencyFormat(billPaymentTransferRequest?.fromAccount?.currency?.currencyIsoCode?.toString());
		
		 if(!fromCurrency.equals(transferCurrency)){
		 	//exgRateRes			=	commonService.getExchangeCalculator(fromAccountNumber, dummyAccountNumber, billPaymentTransferRequest?.paymentAmount?.toString(),currencySelection,requestHeader)
			//Exchange Rate FromAccount=transferCurrcy,amount,currencycode=fromacccurrency
			exgRateRes			=	commonService.getExchangeCalculator(currencySelection, dummyAccountNumber, billPaymentTransferRequest?.paymentAmount?.toString(),fromAccntCurrcyIsoCode,requestHeader)
		 	fromExchangeRate	=	exgRateRes?.exchangeRate
		 	debitAmount			=	exgRateRes?.convertedAmount?.toBigDecimal()//calculateDebitAmount(fromExchangeRate, billPaymentTransferRequest.getPaymentAmount(),fromCurrency,transferCurrency,fromCurrDesPosition)
		 }else{
		 	debitAmount			=	fromExchangeRate.toBigDecimal().multiply(billPaymentTransferRequest?.paymentAmount)
		 }
		 //KHCB toCurrency=transferCurrency is BHD
		 if(!toCurrency.equals(transferCurrency)){
			 exgRateRes				=	commonService.getExchangeCalculator(toAccountNumber, dummyAccountNumber,billPaymentTransferRequest?.paymentAmount?.toString(),currencySelection,requestHeader)
			 toExchangeRate			=	exgRateRes?.exchangeRate
			 creditAmount			=	exgRateRes?.convertedAmount//calculateCreditAmount(toExchangeRate, billPaymentTransferRequest.getPaymentAmount(),fromCurrency,toCurrency,transferCurrency,toCurrDesPosition,baseCurrency)
		 }else{
		 	creditAmount			=	toExchangeRate.toBigDecimal().multiply(billPaymentTransferRequest?.paymentAmount)
		 }
		 debitCurrencyDisplay	=	toCurrency
		 
				 
		  ChargeResponse chargeResponse = bmClient.iBCommonService.getCharges(billPaymentTransferRequest);
		  
		  if(chargeResponse?.currency) {
			 if(!transferCurrency.equals(chargeResponse?.currency)){
				  exgRateRes				=	commonService.getExchangeCalculator(fromAccountNumber, dummyAccountNumber, chargeResponse?.chargeAmount?.toString(),currencySelection,requestHeader)		
				  chargeExchangeRate		=	exgRateRes?.exchangeRate
				  chargeAmount				=	exgRateRes?.convertedAmount//calculateChargeAmount(fromCurrency, chargeResponse?.currency, chargeExchangeRate, chargeResponse.chargeAmount)
			  }else{
			  	chargeAmount	=	chargeExchangeRate.toBigDecimal().multiply(chargeResponse?.chargeAmount)
			  }
		  }
		
					
			Map<String,Object> balanceCheckMap=new HashMap<String, Object>(3);
			log.info("Avaliable Balance :::"+accountBalanceResponse?.availableBalance);
			balanceCheckMap.put("availableBalance", accountBalanceResponse?.availableBalance)
			balanceCheckMap.put("transactionAmount", debitAmount)
			balanceCheckMap.put("transferCurrency", transCurrIsoCode);
			balanceCheckMap.put("transferAmount", billPaymentTransferRequest.getPaymentAmount());
			balanceCheckMap.put("chargeAmount", chargeAmount)
			balanceCheckMap.put("transactionType", billPaymentTransferRequest?.transactionType);
			balanceCheckMap.put("transactionLimit", transactionLimitResponse);
			commonRequest.setRequestParams(balanceCheckMap)
			commonResponse=bmClient.iBCommonService.verifyBalanceAndLimits(commonRequest)
			if(commonResponse.hasErrors())
			{
				model<<[errors:commonResponse.errors()]
				return
			}
			log.info("Balance Validation Success!!!!!!!!!");
		  postProcessModel.put("fromAccountId", fromAccountId)
		  postProcessModel.put("toAccountId", toAccountId)
		  postProcessModel.put("remarks", billPaymentTransferRequest.getPaymentRemarks())
		  postProcessModel.put("transactionAmount", billPaymentTransferRequest.getPaymentAmount())
		  postProcessModel.put("debitAmount", debitAmount)
		  postProcessModel.put("fromCurrency", fromCurrency)
		  postProcessModel.put("toCurrency", toCurrency)
		  postProcessModel.put("transferCurrency", transferCurrency)
		  postProcessModel.put("fromExchangeRate", fromExchangeRate)
		  postProcessModel.put("toExchangeRate", toExchangeRate)
		  postProcessModel.put("creditAmount", creditAmount)
		  postProcessModel.put("debitCurrencyDisplay", debitCurrencyDisplay)
		  postProcessModel.put("buttonEvent", getSessionAttribute("BUTTONEVENT"))
		  postProcessModel.put("merchantName", billPaymentTransferRequest.getBeneficiaryName())
		  postProcessModel.put("thirdPartyRefId",billPaymentTransferRequest.getThirdPartyReferenceId())		  
		  if(PaymentButtonEnum.LATER.toString().equals(getSessionAttribute("BUTTONEVENT"))){
			  def startDate = billPaymentTransferRequest.getStartDate()
			  def sheduleStartDate = startDate.format('dd-MMM-yyyy')
			  postProcessModel.put("sheduleDate", sheduleStartDate)
		  }else if(PaymentButtonEnum.REPEAT.toString().equals(getSessionAttribute("BUTTONEVENT"))){
		  	  def startDate = billPaymentTransferRequest.getStartDate()
			  def sheduleStartDate = startDate.format('dd-MMM-yyyy')
			  postProcessModel.put("sheduleDate", sheduleStartDate)
		  }
		  
		  if(chargeResponse.currency)
		  {
			  postProcessModel.put("chargeExchangeRate", chargeExchangeRate)
			  postProcessModel.put("chargeCurrency", chargeResponse?.currency)
			  postProcessModel.put("chargeAmount", chargeResponse?.chargeAmount)
			  postProcessModel.put("exactChargeAmount", chargeAmount)
		  }
		  if(billPaymentTransferRequest?.toBillerInstruction?.account)
		  {
			  postProcessModel.put("beneficiaryNickName", billPaymentTransferRequest?.toBillerInstruction?.shortName)
			  postProcessModel.put("beneId", billPaymentTransferRequest?.toBillerInstruction?.account?.id)
			  postProcessModel.put("billerId", billPaymentTransferRequest?.toBillerInstruction?.biller?.id)
			  postProcessModel.put("billerInstrId", billPaymentTransferRequest?.toBillerInstruction?.id)
			  //def acctType	=	billPaymentTransferRequest?.toBillerInstruction?.transactionSubType?.service?.code
			  def acctType = "BILLPAYMENT";
			  //postProcessModel.put("cancelAction",PaymentModuleTypeEnum.valueOf(acctType).getKey())
			  postProcessModel.put("cancelAction","billpayment")
		  }else{
			  postProcessModel.put("beneficiaryNickName", billPaymentTransferRequest?.toBillerInstruction?.biller?.shortName)
			  postProcessModel.put("beneId", billPaymentTransferRequest?.toBillerInstruction?.biller?.id)
			  postProcessModel.put("billerId", billPaymentTransferRequest?.toBillerInstruction?.biller?.id)
			  postProcessModel.put("billerInstrId", billPaymentTransferRequest?.toBillerInstruction?.id)
			  postProcessModel.put("cancelAction","billpayment")
			   //postProcessModel.put("cancelAction","billpaymentcancel")			  
		  }
		  billPaymentTransferRequest.setFromExchangeRate(fromExchangeRate.toDouble());
		  billPaymentTransferRequest.setToExchangeRate(toExchangeRate.toDouble());
		  if(chargeResponse.currency)
		  {
			  billPaymentTransferRequest.setChargeExchangeRate(chargeExchangeRate.toDouble());
			  billPaymentTransferRequest.setTransactionCharges(chargeAmount);
		  }
		 
		  billPaymentTransferRequest.dailyUtilizedLimit= transactionLimitResponse?.dailyAmountUtilized>=0 ? transactionLimitResponse?.dailyAmountUtilized.add(debitAmount) : new BigDecimal(0);
		  billPaymentTransferRequest.dailyUtilizedCount=transactionLimitResponse?.dailyUtilizedCount>=0 ? transactionLimitResponse?.dailyUtilizedCount + 1 : new Integer(0);
		  billPaymentTransferRequest.monthlyUtilizedLimit=transactionLimitResponse?.monthlyAmountUtilized>=0 ? transactionLimitResponse?.monthlyAmountUtilized.add(debitAmount) : new BigDecimal(0);
		  billPaymentTransferRequest.monthlyUtilizedCount=transactionLimitResponse?.monthlyUtilizedCount>=0 ? transactionLimitResponse?.monthlyUtilizedCount + 1 : new Integer(0);
		  
		   
		  //To send exact calculated amount to IM incase of cross currency payment
		  billPaymentTransferRequest.creditAmount=creditAmount;
		  billPaymentTransferRequest.debitAmount=debitAmount;
		  
		  
		   setSessionAttribute("FTR", billPaymentTransferRequest);
		  session.removeAttribute("LIMIT")  
		  

		  
		  if(billPaymentTransferRequest?.isAWarning)
		  {
			  model<<[postProcessModel:postProcessModel,isAWarning:billPaymentTransferRequest?.isAWarning,warningErrorCodes:billPaymentTransferRequest?.warningErrorCodes,errorClass:"info"]
		  }
		  else
		  {
			  model<<[postProcessModel:postProcessModel,isAWarning:Boolean.FALSE]
		  }
	}
	
		
	def processbillpayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD") 
		 if(securityHolder!=null && securityHolder.isValidated)
		{
			BillPaymentTransferResponse billPaymentTransferResponse=null;
			BillPaymentTransferRequest billPaymentTransferRequest=(BillPaymentTransferRequest)getSessionAttribute("FTR");
			String transferType	= billPaymentTransferRequest.transferType;			
			String methodName	=	PaymentTypeEnum.valueOf(transferType).getKey()
			BillPaymentTransferRequest[] ftr	=	new BillPaymentTransferRequest[1];
			ftr[0]	=	billPaymentTransferRequest;
			billPaymentTransferResponse=bmClient.billPaymentService.invokeMethod(methodName, ftr[0])
			//println billPaymentTransferResponse?.paymentHeader?.paymentDetails[0]?.status?.dump() 
		   if(billPaymentTransferResponse.hasErrors())
			{
				model<<[errors:billPaymentTransferResponse.errors()]
			}
			else
			{
				session.removeAttribute("FTR")
				/*This line is added to remove the account summ model from session during login. Refer HomeService.groovy homepage*/
				session.removeAttribute("actsumModel");
				model<<[transferResponseModel:billPaymentTransferResponse,transferRequestModel:billPaymentTransferRequest]
		   
			}
	}else
	{
		throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.UNSUPPORTED_OPERATION, "Security Breach", null)
	}

	}
	
	/*def processbillpaymentlater(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")
		if(securityHolder.isValidated)
		{
			BillPaymentTransferRequest billPaymentTransferRequest=(BillPaymentTransferRequest)getSessionAttribute("FTR");
			BillPaymentTransferResponse billPaymentTransferResponse=null;
			
			if(billPaymentTransferRequest.paymentScheduleHeaderId && billPaymentTransferRequest.paymentScheduleDetailId){ // Update the scheduled payment
				billPaymentTransferResponse=bmClient.billPaymentService.updateScheduledBillPayment(billPaymentTransferRequest);
			}else{			
				billPaymentTransferResponse=bmClient.billPaymentService.payLaterBillPayment(billPaymentTransferRequest);
			}
			
			if(billPaymentTransferResponse.hasErrors())
			{
				model<<[transferResponseModel:billPaymentTransferResponse.errors()]
			}
			else{
				session.removeAttribute("FTR")
				model<<[transferResponseModel:billPaymentTransferResponse]		   
			}
		}else
		{
			throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.UNSUPPORTED_OPERATION, "Security Breach", null)
		}
	}
		
	def processbillschedulepayment(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
				
		BillPaymentTransferRequest billPaymentTransferRequest=(BillPaymentTransferRequest)getSessionAttribute("FTR");
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD")   
		if(securityHolder.isValidated)
		{
			BillPaymentTransferResponse billPaymentTransferResponse=null;
			if(billPaymentTransferRequest.paymentScheduleHeaderId && billPaymentTransferRequest.paymentScheduleDetailId){ // Update the scheduled payment
				billPaymentTransferResponse=bmClient.billPaymentService.updateScheduledBillPayment(billPaymentTransferRequest);
			}else{
				billPaymentTransferResponse=bmClient.billPaymentService.scheduleBillPayment(billPaymentTransferRequest);
			}	   
			if(billPaymentTransferResponse.hasErrors())
			{
				model<<[errors:billPaymentTransferResponse.errors()]
			}
			else{
				session.removeAttribute("FTR")
				model<<[transferResponseModel:billPaymentTransferResponse]	   
			}
		}else
		{
			throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.UNSUPPORTED_OPERATION, "Security Breach", null)
		}
	}
	
	def payLaterPreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		print params.dump()
		DateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
		Date date = params.configuredPaymentDate ? (Date)formatter.parse(params.configuredPaymentDate):null;
		def billerServiceType = params.billerServiceType
		model<<[configuredPaymentDate:date,billerServiceType:billerServiceType];
	}
	
	def repeatPreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		def billerServiceType = params.billerServiceType
		model<<[billerServiceType:billerServiceType];
	}
	
	def billpaymentcancel(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		
		FavouritePaymentDetailRequest favouritePaymentDetailRequest=getBean(FavouritePaymentDetailRequest.class, requestHeader, params);
		favouritePaymentDetailRequest.setBeneId(params.beneId.toLong())
		FavouritePaymentDetailResponse favouritePaymentDetailResponse=bmClient.billPaymentService.getFavouriteBillPayments(favouritePaymentDetailRequest);

	
		BillPaymentTransferRequest billPaymentTransferRequest = (BillPaymentTransferRequest) getSessionAttribute("FTR");
		if(billPaymentTransferRequest){
			def transferCurencyId=billPaymentTransferRequest.getTransferCurrencyID();
			com.vayana.bm.core.api.model.common.Currency transferCurrencyObj=commonService.getCurrency(transferCurencyId)
			def transferCurrency=transferCurrencyObj
			
			if(favouritePaymentDetailResponse.acctBalancePaymentDetail){
				favouritePaymentDetailResponse.acctBalancePaymentDetail.payerInstruction=billPaymentTransferRequest.getFromAccount();
				favouritePaymentDetailResponse.acctBalancePaymentDetail.payeeInstruction=billPaymentTransferRequest.getToBillerInstruction();
				favouritePaymentDetailResponse.acctBalancePaymentDetail.paymentAmount=billPaymentTransferRequest.getPaymentAmount();
				favouritePaymentDetailResponse.acctBalancePaymentDetail.remarks=billPaymentTransferRequest.getPaymentRemarks();
				favouritePaymentDetailResponse.acctBalancePaymentDetail.paymentCurrency=transferCurrency;
			}else{
				PaymentDetail favPaymentDetail=new PaymentDetail();
				favPaymentDetail.payerInstruction=billPaymentTransferRequest.getFromAccount();
				favPaymentDetail.payeeInstruction=billPaymentTransferRequest.getToBillerInstruction();
				favPaymentDetail.paymentAmount=billPaymentTransferRequest.getPaymentAmount();
				favPaymentDetail.remarks=billPaymentTransferRequest.getPaymentRemarks();
				favPaymentDetail.paymentCurrency=transferCurrency;
				favouritePaymentDetailResponse.acctBalancePaymentDetail=favPaymentDetail;
			}
	
		}
	
		def datelineRefid=billPaymentTransferRequest.getDatelineReferenceId()
		def SICancelFlag
		if(datelineRefid){
			SICancelFlag = "SI"
		}else{
			SICancelFlag = " ";
		}
		
		if(favouritePaymentDetailResponse.hasErrors()){
			model<<[errors:favouritePaymentDetailResponse.errors()]
		}else{
			session.removeAttribute("FTR")
			model<<[favPaymentDetailModel:favouritePaymentDetailResponse,SICancelFlag:SICancelFlag,datelineRef:datelineRefid]
		}


	}
	
	def confirmCancelSIPayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		SIViewAndUpdateRequest  siViewAndUpdateRequest 		= 	getBean(SIViewAndUpdateRequest.class, requestHeader, null);//(SIViewAndUpdateRequest)getSessionAttribute("CancelSIPayment");
		BillPaymentTransferRequest billPaymentTransferRequest	=	(BillPaymentTransferRequest)getSessionAttribute("FTR");
		if(billPaymentTransferRequest.datelineReferenceId){
			siViewAndUpdateRequest.datelineReferenceId		=	billPaymentTransferRequest.datelineReferenceId;
		}
		if(billPaymentTransferRequest.paymentScheduleDetailId){
			siViewAndUpdateRequest.paymentScheduleDetailId	=	billPaymentTransferRequest.paymentScheduleDetailId;
		}
		SIViewAndUpdateResponse siViewAndUpdateResponse		=	bmClient.paymentService.skipSchedulePayment(siViewAndUpdateRequest);
		model << [siViewAndUpdateModel:siViewAndUpdateResponse]
	}
*/	
	private ExchangeRateResponse getExchangeRate(String fromCurrency,String toCurrency,GenericRequestHeader requestHeader)
	{
		ExchangeRateRequest exchangeRateRequest=getBean(ExchangeRateRequest.class, requestHeader, null);
		exchangeRateRequest.setFromCurrency(fromCurrency);
		exchangeRateRequest.setToCurrency(toCurrency);
		return bmClient.accountService.getExchangeRate(exchangeRateRequest);
	}
	
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
	
	/*def fromaccountbalanceandexgrate1(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		
		 PaymentTransferRequest paymentRequest = getBean(PaymentTransferRequest.class, requestHeader, null);
		PaymentTransferResponse response ;
		 CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, null);
		List transferCurrency = []
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
				
		if(params?.payeeId) {
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
		
		AccountBalanceRequest accountBalanceRequest=getBean(AccountBalanceRequest.class, requestHeader, null);
		accountBalanceRequest.accountId= getIdVersion(params.payerId)[0];
		AccountBalanceResponse accountBalanceResponse= commonService.getAccountBalance(accountBalanceRequest);
		setSessionAttribute("BAL", accountBalanceResponse)
		//TransactionLimitResponse transactionLimitResponse = null;
		//setSessionAttribute("LIMIT", transactionLimitResponse)
		
		TransactionLimitResponse transactionLimitResponse = getPayerLimitDetails(requestHeader,getIdVersion(params.toAccountId)[0],null,getInvoker().getUserLoginProfileId());
		if(transactionLimitResponse.hasErrors()) {
			model<<[errors:transactionLimitResponse.errors()]
		}
		setSessionAttribute("LIMIT", transactionLimitResponse)
		
		
		model<<[accountBalanceModel:accountBalanceResponse,transferCurrency:transferCurrency,exchangeRateModel:exchangeRate,transactionType:transactionType]
	}*/
	
	def fromaccountbalanceandexgrate(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		log.info("** welcome to fromaccountbalanceandexgrate method **");
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
			log.info("Payer Id ::"+params?.payerId);
			paymentRequest.setPayerId(getIdVersion(params.payerId)[0])
			response = 	bmClient.paymentService.getPayer(paymentRequest);
			fromCurrency=response.getPayer().getCurrency().getCode();
			log.info("From account currency code:::"+fromCurrency);
			fromCurrencyId=response.getPayer().getCurrency().getId();
			log.info("From account currency Id:::"+fromCurrencyId);
			transferCurrency.add(response.getPayer().getCurrency())
		}
				
		if(params?.payeeId) {
	//		To get To Currency from BeneId
			log.info("Payee Id :::"+params?.payeeId);
			commonRequest.setAttribute("beneId", params.payeeId) ;
			com.vayana.bm.core.api.model.common.Currency toCurrencyobj = null;
			log.info("Fetching Currency based on Payee Id!!!");
			CommonResponse commonResponse=bmClient.iBCommonService.getCurrencyByBeneId(commonRequest)
			if(commonResponse.additionalInfoMap != null && !commonResponse.additionalInfoMap?.isEmpty()){
				toCurrencyobj	=	commonResponse.getAttribute("beneCurrency");
				log.info("Payee Currency Code :::"+toCurrencyobj?.code)
				transactionType = 	commonResponse.getAdditionalInfo("TT")
				log.info("Transaction Sub Type:::"+transactionType);
			}else{
				commonResponse=bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
				toCurrencyobj	=	commonResponse.getCommonEntity()
				log.info("Common Currency Code :::"+toCurrencyobj?.code)
			}
			toCurrency		=	toCurrencyobj?.code;
			if(!fromCurrency.equals(toCurrency)){
				transferCurrency.add(toCurrencyobj)
			}
		
		}
		
		AccountBalanceRequest accountBalanceRequest=getBean(AccountBalanceRequest.class, requestHeader, null);
		accountBalanceRequest.accountId= getIdVersion(params.payerId)[0];
		AccountBalanceResponse accountBalanceResponse= commonService.getAccountBalance(accountBalanceRequest); 
		setSessionAttribute("BAL", accountBalanceResponse)
		//TransactionLimitResponse transactionLimitResponse = null;
		//setSessionAttribute("LIMIT", transactionLimitResponse)
		Long payeeId = params?.payeeId?.toLong()
		TransactionLimitResponse transactionLimitResponse = getPayerLimitDetails(requestHeader,payeeId,fromCurrencyId,getInvoker().getUserLoginProfileId());
		log.info("Inside fromaccountbalanceandexgrate method::: Matching Limit Code::::"+transactionLimitResponse?.code);
		if(transactionLimitResponse?.hasErrors()) {
			model<<[errors:transactionLimitResponse.errors()]
		}
		setSessionAttribute("LIMIT", transactionLimitResponse)
		
		model<<[accountBalanceModel:accountBalanceResponse,transferCurrency:transferCurrency?.toList(),exchangeRateModel:exchangeRate,transactionType:transactionType]
	}
	
	
	def exchangeRateAndLimit(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
	PaymentTransferRequest paymentRequest = getBean(PaymentTransferRequest.class, requestHeader, null);
	PaymentTransferResponse response ;
	CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, null);
	TransactionLimitRequest transactionLimitRequest=new TransactionLimitRequest();
	transactionLimitRequest.setRequestHeader(requestHeader);
	List transferCurrency = [];
	String fromCurrency,toCurrency="";
	Long fromCurrencyId;
	String exchangeRate="";
	Long accountId ;
	String transactionType="";
	//		To get From Currency with account ID   
	if(params?.payerId){
	
	paymentRequest.setPayerId(getIdVersion(params.payerId)[0])
	response = 	bmClient.paymentService.getPayer(paymentRequest);
	fromCurrency=response.getPayer().getCurrency().getCode();
	fromCurrencyId=response.getPayer().getCurrency().getId();
	transferCurrency.add(response.getPayer().getCurrency())
	
	}
	if(params?.payeeId && params?.payerId)
	{
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
	
	transactionLimitRequest.setPayeeInstruction(params?.payeeId.toLong())
	transactionLimitRequest.setFromCurrencyId(fromCurrencyId)
	  
	Long userLoginProfileId = getInvoker().getUserLoginProfileId();  
	transactionLimitRequest.setUserLoginProfileId(userLoginProfileId);
	TransactionLimitResponse transactionLimitResponse=bmClient.paymentService.fetchTransactionalLimit(transactionLimitRequest)
	setSessionAttribute("LIMIT", transactionLimitResponse) 
	model<<[exchangeRateModel:exchangeRate,limitModel:transactionLimitResponse,transactionType:transactionType,transferCurrency:transferCurrency]
	}
	
	public String getCurrencyFormat(String currencyCode){
		int currencyLength = currencyCode.length();
		if(currencyLength == 1){
			currencyCode = "00"+currencyCode;
		}else if(currencyLength == 2){
			currencyCode = "0"+currencyCode;
		}
		return currencyCode;
	}
	
	//SI Starts
	/*def utilityStandingInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
				
		BillPaymentTransferRequest request = getBean(BillPaymentTransferRequest.class,requestHeader,params)
		BillPaymentTransferResponse response = bmClient.billPaymentService.getStandingOrderInformations(request)
		model<<[paymentScheduleHeaders:response.paymentScheduleHeaders]
	}
	
	def editSI(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		FavouritePaymentDetailRequest paymentDetailRequest 		= new FavouritePaymentDetailRequest()
		paymentDetailRequest.setRequestHeader(requestHeader);
		paymentDetailRequest.setPaymentDetailId(params.spdId.toLong());
		paymentDetailRequest.setPaymentType("FT_SI");
		FavouritePaymentDetailResponse paymentDetailResponse 	= bmClient.paymentService.getPaymentDetails(paymentDetailRequest);
		
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, null);
		CommonResponse commonResponse=null;
		commonResponse=bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
		com.vayana.bm.core.api.model.common.Currency baseCurrencyObj=commonResponse.getCommonEntity()
		
		if(paymentDetailResponse.hasErrors()){
			model<<[errors:paymentDetailResponse.errors()]
		}else{
			model<<[favPaymentDetailModel:paymentDetailResponse,SICancelFlag:'SI',datelineEventRef:'SI',baseCurrencyModel:baseCurrencyObj]
		}
	}
	
	def suspendStandingInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		
		SIViewAndUpdateRequest  siViewAndUpdateRequest=getBean(SIViewAndUpdateRequest.class, requestHeader, null);
		siViewAndUpdateRequest.paymentScheduleDetailId=params.paymentScheduleDetailId.toLong()
		SIViewAndUpdateResponse siViewAndUpdateResponse=bmClient.billPaymentService.suspendStandingOrder(siViewAndUpdateRequest);

		if(siViewAndUpdateResponse.hasErrors()){
			model<<[errors:siViewAndUpdateResponse.errors()]
		}else{
		utilityStandingInstruction(params, requestHeader, model)
		setMessage(DEFAULT_DELETED_MESSAGE,[
			"Standing Instruction ",
			params.code+" successfully"
		], model)
		}
	}
*/	
/*	def getSessionInfo(Map params,GenericRequestHeader requestHeader,ModelMap model)throws BusinessException{
		println ("getSessionInfo"+params.sid)		
		SessionInformation sessionInfo = sessionRegistry.getSessionInformation(params.sid)
		println sessionInfo?.principal?.dump()
		println (sessionInfo?.dump())
		//HttpSession    session = arg0.getSession();
		ServletContext context = session.getServletContext();
		HashMap contextSessionInfoMap =  (HashMap)context.getAttribute("contextSessionInfoMap");	
		println contextSessionInfoMap?.dump()
		HttpSession    tempSession =contextSessionInfoMap.get(params.sid);
		println "--------------------------"
		println tempSession?.dump()
		println tempSession?.getAttribute("_LOGINREQDATA")
		
	}*/
	
	def billDeskTransaction(Map params,GenericRequestHeader requestHeader,ModelMap model)throws BusinessException{
		
		Map debitTransactionMap = getSessionAttribute("_DEBITREQDATA")
		
		log.info("BillPaymentService    :  billDeskTransaction : debitTransactionMap="+debitTransactionMap?.dump());
		
		//Fetch PayeeInstruction From Account
		CommonRequest commonRequest		=	getBean(CommonRequest.class, requestHeader, null);
		def requestParams=["filterParam":debitTransactionMap?.get("USERACCOUNT")];
		commonRequest.setRequestParams(requestParams);		
		CommonResponse commonResponse	=	bmClient.iBCommonService.fetchPayeeInstructionByAccountNumberULP(commonRequest);
		BeneficiaryInstruction payeeIns		=	commonResponse?.getCommonEntity()
		
		//Fetch Biller Instruction
		BillerRequest req	= getBean(BillerRequest.class,	requestHeader, null );
		BillerResponse res	= bmClient.billerService.fetchBillDeskBillerInstruction(req);
		
		//Fetch Currency 
		commonResponse=bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
		com.vayana.bm.core.api.model.common.Currency baseCurrencyObj=commonResponse.getCommonEntity()
		String baseCurrency=baseCurrencyObj.code;			
		
		String strPayerInstruction = payeeIns?.account?.idVersion
		String strPayeeInstruction = res?.billerInstruction?.idVersion
		
		log.info("BillPaymentService    :  billDeskTransaction : strPayerInstruction="+strPayerInstruction);
		log.info("BillPaymentService    :  billDeskTransaction : strPayeeInstruction="+strPayeeInstruction);		
		
		model <<[mapModel:debitTransactionMap,PayerInsModel:strPayerInstruction,PayeeInstModel:strPayeeInstruction,TransCurModel:baseCurrency]
		
	}
	
	
	def executeBillDeskPayment(Map params,GenericRequestHeader requestHeader,ModelMap model)throws BusinessException{
		params?.buttonEvent = 'PAYNOW'
		params?.isTransactionAuthorization = 'YES'
		validatefundtransfer(params, requestHeader, model)
		
		AccountBalanceRequest accountBalanceRequest=getBean(AccountBalanceRequest.class, requestHeader, null);
		accountBalanceRequest.accountId = getIdVersion(params.fromAccountId)[0];
		AccountBalanceResponse accountBalanceResponse= commonService.getAccountBalance(accountBalanceRequest);
		setSessionAttribute("BAL", accountBalanceResponse)
		
		//Fetch Currency
		CommonRequest commonRequest		=	getBean(CommonRequest.class, requestHeader, null);
		CommonResponse commonResponse	=	bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
		com.vayana.bm.core.api.model.common.Currency baseCurrencyObj=commonResponse.getCommonEntity()
		
		TransactionLimitResponse transactionLimitResponse = getPayerLimitDetails(requestHeader,getIdVersion(params.toAccountId)[0],baseCurrencyObj?.id,getInvoker().getUserLoginProfileId());
		if(transactionLimitResponse.hasErrors()) {
			model<<[errors:transactionLimitResponse.errors()]
		}
		setSessionAttribute("LIMIT", transactionLimitResponse)
		
		paymentPostProcess(params, requestHeader, model)
		
		model<<[success:"SUCCESS"]
		
	}
	
	
	
	
	def pgTransaction(Map params,GenericRequestHeader requestHeader,ModelMap model)throws BusinessException{
		
		Map loginReqDataMap 		= getSessionAttribute("_PGPARAMDATA") //TODO EXCEPTION HANDLING
		
		//Fetch Merchant(PG) Instruction
		BillerRequest req	= getBean(BillerRequest.class,	requestHeader, null );
		BillerResponse res	= bmClient.billerService.fetchPGInstruction(req);
		
		//Fetch Currency
		CommonRequest commonRequest		=	getBean(CommonRequest.class, requestHeader, null);
		CommonResponse commonResponse	=	bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
		com.vayana.bm.core.api.model.common.Currency baseCurrencyObj=commonResponse.getCommonEntity()
		String baseCurrency				=	baseCurrencyObj.code;
		
		String strPayeeInstruction 		= 	res?.billerInstruction?.idVersion
		
		log.info("BillPaymentService    :  pgTransaction : pgRequestMap="+loginReqDataMap);
		log.info("BillPaymentService    :  pgTransaction : PayeeInstModel="+strPayeeInstruction);
		log.info("BillPaymentService    :  pgTransaction : TransCurModel="+baseCurrency);
		
		model<<[pgRequestMap:loginReqDataMap, PayeeInstModel:strPayeeInstruction,TransCurModel:baseCurrency]
		
	}
		
	
	def pgCallBackOnSuccess(Map params,GenericRequestHeader requestHeader,ModelMap model)throws BusinessException{		
		log.info("BillPaymentService    :  pgCallBackOnSuccess : params="+params?.dump);
		String paymentStatus = "F";
		if(params?.paymentStatus && LookupCodeConstants.SUCCESS.equals(params?.paymentStatus)){
			paymentStatus = "H"
		}
		String callBackURL = getPgReturnURLParams(paymentStatus, params?.coreRef);
		log.info("BillPaymentService    :  pgCallBackOnSuccess : callBackURL="+callBackURL);
		model<<[callBackURLModel : callBackURL]; 
	}
	
	
	def cancelPGTransaction(Map params,GenericRequestHeader requestHeader,ModelMap model)throws BusinessException{
		String paymentStatus = "F";
		log.info("BillPaymentService    :  cancelPGTransaction : params="+params?.dump);
		String callBackURL = getPgReturnURLParams(paymentStatus, "");
		log.info("BillPaymentService    :  cancelPGTransaction : callBackURL="+callBackURL);
		model<<[callBackURLModel : callBackURL];
	}
	
	/**
	 * This method return the Payment Gateway return URL with params
	 * @param status
	 * @param coreReference
	 * @return
	 */
	String getPgReturnURLParams(String status, String coreReference){
		log.info("BillPaymentService    :  getPgReturnURLParams : status="+status);
		log.info("BillPaymentService    :  getPgReturnURLParams : coreReference="+coreReference);
		Map loginReqDataMap 		= 	getSessionAttribute("_PGPARAMDATA") //TODO EXCEPTION HANDLING
		URIBuilder uriBuilder 		= 	new URIBuilder();
		String pgReturnUrl			=	(String)loginReqDataMap.get("RU");
		uriBuilder.addParameter("STATFLG", status); //H for SUCCESS and F for FAILURE
		uriBuilder.addParameter("PRN", loginReqDataMap.get("PRN")); //BillDesk Reference Number
		uriBuilder.addParameter("ITC", loginReqDataMap.get("ITC")); //ItemCode
		uriBuilder.addParameter("BID", coreReference);	//Bank reference number generate by bank
		uriBuilder.addParameter("AMT", loginReqDataMap.get("AMT")); //Transaction Amount
		String uriParams			=	uriBuilder.build().toString();
		log.info("BillPaymentService    :  getPgReturnURLParams : uriParams="+uriParams);
		return pgReturnUrl?.concat(uriParams);
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
		log.info "Into getPayerLimitDetails ulpId " + ulpId;
		log.info "Into getPayerLimitDetails payerCurrencyId " + payerCurrencyId;
		log.info "Into getPayerLimitDetails payeeInstructionId " + payeeInstructionId;
		TransactionLimitResponse transactionLimitResponse	=	bmClient.paymentService.fetchTransactionalLimit(transactionLimitRequest);
		log.info "Into getPayerLimitDetails transactionLimitResponse code  " + transactionLimitResponse?.code;
		return transactionLimitResponse;
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
			def payeeIns 				= 	(BillerInstruction)paymentDetailObject?.getPayeeInstruction()
			processModel = [
				'fromAccountId'		:paymentDetailObject?.payerInstruction?.idVersion,
				'fromCurrency'		:paymentDetailObject?.payerInstruction?.currency?.code,
				'fromExchangeRate'	:paymentDetailObject?.exchangeRatePair1,
				'debitAmount'		:paymentDetailObject?.paymentAmount,
				'toAccountId'		:paymentDetailObject?.payeeInstruction?.idVersion,
				'toCurrency'		:payeeIns?.currency?.code,
				'toTSTCode'			:paymentDetailObject?.transactionSubType?.serviceApplication?.service?.code,
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
				'endDate'			:paymentDetailObject?.paymentScheduleHeader?.frequencyEndDate,
				'merchantName'		:paymentDetailObject?.ITC,
				'thirdPartyRefId'	:paymentDetailObject?.thirdPartyReferenceId,
				'bankReferenceNumber':paymentDetailObject?.referenceTag,
				'paymentDetailId'	:paymentDetailObject?.id
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
				//def acctType	=	payeeIns?.transactionSubType?.serviceApplication?.service?.code
				//processModel.put("cancelAction",PaymentModuleTypeEnum.valueOf(acctType).getKey())
			}else{
				processModel.put("beneficiaryNickName", payeeIns?.biller?.shortName)
				processModel.put("beneId", payeeIns?.biller?.id)
				processModel.put("cancelAction","friendsandfamilypayment")
			}
			processModel.put("isValid", isValidPayment(processModel?.paymentDate));
		    
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
	
	def approvePGPreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		model<<[successAction:'approvePGTransaction',serviceCode:'PAYMENTGATEWAY'];
	}
	
	def rejectPGPreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		model<<[successAction:'rejectPGTransaction',serviceCode:'PAYMENTGATEWAY'];
	}
	
	def isValidPayment(Date paymentDate){
		log.info("----------------------------------------------------------------");
		log.info("Payment Date ::: "+paymentDate);
		log.info("Current Date ::: "+new Date());
		Calendar cal = Calendar.getInstance();
		cal.setTime(paymentDate);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		Calendar currDt = Calendar.getInstance();
		currDt.setTime(new Date());
		currDt.set(Calendar.HOUR_OF_DAY, 0);
		currDt.set(Calendar.MINUTE, 0);
		currDt.set(Calendar.SECOND, 0);
		currDt.set(Calendar.MILLISECOND, 0);
		Boolean isValid = cal.compareTo(currDt) == 0 ? true : false ;
		log.info("Is Valid ::: "+isValid);
		log.info("----------------------------------------------------------------");
		return isValid;
	}
	
	def validatePGPayment(String paymentDetailId){
		log.info("Inside validatePGPayment Closure")
		if(StringUtils.hasText(paymentDetailId)){
			PaymentDetailRequest request = getBean(PaymentDetailRequest.class,"paymentDetailRequest", null, null)
			request.setPaymentDetailId(Long.parseLong(paymentDetailId));
			PaymentDetailResponse response = bmClient.billPaymentService.fetchPaymentDetailById(request);
			if(response.hasErrors()){
				return null;
			}else{
				def pg = response?.getAcctBalancePaymentDetail();
				log.info("PG Status :: "+pg?.status?.code);
				def amount = MoneyUtils.formatAmount(pg?.paymentAmount, new Locale("en_IN"), "INR");
				log.info("####"+amount+"####"+amount?.length()+"####");
				amount = amount?.replace(",", "");
				log.info("####"+amount+"####"+amount?.length()+"####");
				amount = amount?.substring(1, amount.length())?.trim();
				log.info("####"+amount+"####"+amount?.length()+"####");
				def pgDetails = [
									'AMT'	:	amount,
									'PID'	: 	pg?.PID,
									'PRN'	: 	pg?.thirdPartyReferenceId,
									'ITC'	:	pg?.ITC,
									'BID'	: 	pg?.referenceTag,
									'STATFLG' 	: 	("SUCCESS".equals(pg?.status?.code)) ? 'S' : 'H',
									'RU'	: 	pg?.return_URL 
								]
				log.info("PG Details :: "+pgDetails)
				return pgDetails;
			}
			
		}
		return null;
		
	}
	
}

//Command Objects
class BillPaymentCommand {
	String fromAccountId;
	String toAccountId;
	String paymentAmount;
	String paymentRemarks;
	
	 
	
	static constraints={
		fromAccountId(blank: false)
		toAccountId(blank: false)
		paymentRemarks(blank:true,shared : 'remarksConstraint')
		//paymentAmount shared:"numericConstraint"
		paymentAmount validator:{val,obj ->
			if(val=='')
			{
				obj.errors.rejectValue('paymentAmount','fundTransferCommand.paymentAmount.blank')
			}
		};
		
	}
}

class CancelBillPayCommand{
	String paymentScheduleDetailId;
	static constraints={
		paymentScheduleDetailId(blank: false)
	}
}
