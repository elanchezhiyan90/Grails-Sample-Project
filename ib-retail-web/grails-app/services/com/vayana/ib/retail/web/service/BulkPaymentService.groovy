package com.vayana.ib.retail.web.service

import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.Map;

import javax.servlet.http.HttpServletRequest

import org.apache.http.NameValuePair
import org.apache.http.client.utils.URIBuilder
import org.codehaus.groovy.grails.commons.GrailsApplication;
import org.springframework.data.domain.PageRequest
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.common.utils.CollectionUtils;
import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.ContextCodeType
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.constants.BusinessFunctionConstants
import com.vayana.bm.core.api.constants.LookupCodeConstants
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants;
import com.vayana.bm.core.api.model.common.Currency
import com.vayana.bm.infra.workflow.WorkflowService
import com.vayana.dateline.ib.connector.DatelineIBUtils
import com.vayana.dateline.model.DatelineTask
import com.vayana.ib.bm.core.api.beans.account.AccountBalanceRequest;
import com.vayana.ib.bm.core.api.beans.account.AccountBalanceResponse
import com.vayana.ib.bm.core.api.beans.bulkpayment.BulkPaymentDetailRequest
import com.vayana.ib.bm.core.api.beans.bulkpayment.BulkPaymentDetailResponse
import com.vayana.ib.bm.core.api.beans.bulkpayment.BulkPaymentRequest
import com.vayana.ib.bm.core.api.beans.bulkpayment.BulkPaymentResponse
import com.vayana.ib.bm.core.api.beans.exchangerate.ExchangeRateResponse
import com.vayana.ib.bm.core.api.beans.payment.TransactionLimitRequest;
import com.vayana.ib.bm.core.api.beans.payment.TransactionLimitResponse
import com.vayana.ib.bm.core.api.beans.security.SecurityHolder
import com.vayana.ib.bm.core.api.beans.transfers.FundTransferResponse
import com.vayana.ib.bm.core.api.beans.transfers.PaymentTransferRequest;
import com.vayana.ib.bm.core.api.beans.transfers.PaymentTransferResponse;
import com.vayana.ib.bm.core.api.model.enums.BulkPaymentTypeEnum
import com.vayana.ib.bm.core.api.model.enums.PaymentButtonEnum
import com.vayana.ib.bm.core.api.model.enums.PaymentModuleTypeEnum
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.FileUploadService
import com.vayana.ib.retail.web.service.common.GenericService
import com.vayana.ib.retail.web.taglibs.exception.FileUploadException

import org.springframework.dao.DataAccessException

class BulkPaymentService extends GenericService{
	GrailsApplication grailsApplication
	BmClient bmClient
	CommonService commonService
	FileUploadService fileUploadService
	WorkflowService workflowService;
	DatelineIBUtils datelineIBUtils;
	
	private static final PAYMENT_CONTROLLER="bulkPayment"
	private static final PROCESS_BULKPAYNOW_ACTION="processBulkPayment"
	private static final CANCEL_PAYMENT_ACTION="confirmCancelSIPayment";
		
	/* ---------------------------SME Bulk Payment Starts ----------------------------*/
	
	def smeBulkPayment(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BulkPaymentDetailRequest bulkPayDetailRequest 	= getBean(BulkPaymentDetailRequest.class, requestHeader, params);
		bulkPayDetailRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());  
		//Added for Pagination
		
		def pageNumber = (StringUtils.hasText(params?.gotoPage))?
		params?.int('gotoPage') : 0;
		PageRequest page = new PageRequest(pageNumber,5);
		bulkPayDetailRequest.setPageRequest(page);	
		def tenantServiceCode = params?.tenantServiceCode;
		if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && tenantServiceCode.equals(BusinessFunctionConstants.SALARY_PAYMENTS))
		{
			bulkPayDetailRequest.setBulkPaymentType(BulkPaymentTypeEnum.SP)
		}
		else if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && tenantServiceCode.equals(BusinessFunctionConstants.VENDOR_PAYMENTS))
		{
			bulkPayDetailRequest.setBulkPaymentType(BulkPaymentTypeEnum.VP)
		}
		BulkPaymentDetailResponse paymentDetailResponse	= bmClient.bulkPaymentService.getBulkPaymentsListPage(bulkPayDetailRequest);
			
		log.info("Header List>>"+paymentDetailResponse?.bulkPaymentHeaderList?.dump());
		if(paymentDetailResponse?.hasErrors()){
			model<<[errors:paymentDetailResponse.errors()]
		}
		model<<[bulkPaymentHeaderModel:paymentDetailResponse?.bulkPaymentHeaderList,toTSTService:params?.tenantServiceCode,pagerModel:paymentDetailResponse.getPage()]
	}
	

	
	def prepareFileForProcess(HttpServletRequest request, Map params) throws BusinessException 
	{
		try
		{
			log.info("prepareFileForProcess Starts...");
			StringBuffer tenantPath = getTenantFilePathLocal(params);
			log.info("Server Path="+tenantPath);
			String fileName 		= params.qqfile;
			log.info("File Name="+fileName);
			String newFileName = fileName + "_" + System.currentTimeMillis()
			log.info("New File Name="+newFileName);
			File uploaded 		= File.createTempFile("temp", ".csv")   //.createTempDir("temp", ".csv")  //createTemporaryFile(tenantPath, newFileName);
			InputStream inputStream = selectInputStream(request)
			log.info("File Stream Uploaded ="+inputStream?.dump());
			fileUploadService.upload(inputStream, uploaded)
			log.info("File Uploaded ="+uploaded?.dump());
			session.removeAttribute("UPLOADED_FILE")
			setSessionAttribute("UPLOADED_FILE", uploaded)
			uploaded.deleteOnExit();
			log.info("File Uploaded Successfully...");
			
		}
		catch(FileUploadException fe)
		{
			throw new BusinessException(ContextCodeType.GENERAL, "BM-BULKPAY-002", "Error in Uploading the File", null);
		}
		catch(Exception e)
		{
			throw new BusinessException(ContextCodeType.GENERAL, "BM-BULKPAY-002", "Error in Uploading the File", null);
		}
		
	}
		
	private InputStream selectInputStream(HttpServletRequest request) {
		if (request instanceof MultipartHttpServletRequest) {
			MultipartFile uploadedFile = ((MultipartHttpServletRequest) request).getFile('qqfile')
			return uploadedFile.inputStream
		}
		log.info("else")
		return request.inputStream
	}
	
	private File createTemporaryFile(StringBuffer filePath, String fileName) {
		File fullPath=  new File(filePath.toString());
		if (!fullPath.exists()) {
			fullPath.mkdirs();
		}
		String fullPathFileName = filePath.append("/").append(fileName).toString();
		File uploadedFile = new File(fullPathFileName)
		return uploadedFile
	}
	
	protected StringBuffer getTenantFilePathLocal(Map params){
		def config = grailsApplication.getConfig()
		String uploadFileLocation = config.fileUpload?.location;
		String ulpId = SecurityUtils.invoker.userLoginProfileId
		StringBuffer sb = new StringBuffer();
		sb.append(uploadFileLocation).append(params.groupShortDescription).append("/").append(params.tenantShortDescription).append("/").append(ulpId).append("/");
		return sb;
	}
	
	def bulkPaymentFileSubmit(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		/*BulkPaymentCommand  blukPaymentCmd		=	validateCommandObject(BulkPaymentCommand.class,params)
		if(blukPaymentCmd.hasErrors()){
			 model << [errors:blukPaymentCmd]
			 return
		}*/
	}
	
	def validateVendorPayment(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		BulkPaymentCommand  blukPaymentCmd		=	validateCommandObject(BulkPaymentCommand.class,params)
		if(blukPaymentCmd.hasErrors()){
		 model << [errors:blukPaymentCmd]
		 return
		}
		BulkPaymentRequest bulkPaymentRequest	=	new BulkPaymentRequest();
		bulkPaymentRequest.setBulkPaymentType(BulkPaymentTypeEnum.VP);
		validateBulkPayment(bulkPaymentRequest,params,requestHeader,model);
	}
	
	def validateSalaryPayment(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		BulkPaymentCommand  blukPaymentCmd		=	validateCommandObject(BulkPaymentCommand.class,params)
		if(blukPaymentCmd.hasErrors()){
		 model << [errors:blukPaymentCmd]
		 return
		}
		BulkPaymentRequest bulkPaymentRequest	=	new BulkPaymentRequest();
		bulkPaymentRequest.setBulkPaymentType(BulkPaymentTypeEnum.SP);
		validateBulkPayment(bulkPaymentRequest,params,requestHeader,model);
	}
	
	def validateBulkPayment(BulkPaymentRequest bulkPaymentRequest,Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
		SecurityHolder securityHolder			=	getBean(SecurityHolder.class, requestHeader, params);
		securityHolder.setSuccessController(PAYMENT_CONTROLLER)
		FundTransferResponse fundTransferResponse	=	null;
		bulkPaymentRequest	=	prepareFundTranferRequestForBulkPayment(params, bulkPaymentRequest, requestHeader)
		bulkPaymentRequest.setRequestHeader(requestHeader);
		bulkPaymentRequest.cifNumber = requestHeader?.invoker?.primaryCIF
		bulkPaymentRequest.setTransactionType(params?.buttonEvent)
		if(PaymentButtonEnum.BULKPAY.toString().equals(params?.buttonEvent))
		{
			fundTransferResponse	=	bmClient.bulkPaymentService.validateBulkPayment(bulkPaymentRequest);
			bulkPaymentRequest.setPaymentScheduleDetailId(null);
			securityHolder.setSuccessAction(PROCESS_BULKPAYNOW_ACTION)
		}else if(PaymentButtonEnum.CANCELPAYMENT.toString().equals(params?.buttonEvent))
		{
			CancelPayCommand cancelPayCmd 	=	validateCommandObject(CancelPayCommand.class,params)
			if(cancelPayCmd.hasErrors())
			{
				model << [errors:cancelPayCmd]
				return
			}
			fundTransferResponse	=	bmClient.bulkPaymentService.validateBulkPayment(bulkPaymentRequest);
			securityHolder.setSuccessAction(CANCEL_PAYMENT_ACTION)
		}
		if(!fundTransferResponse?.hasErrors()){
			setSessionAttribute("FTR", fundTransferResponse.getFundTransferRequest());
			setSessionAttribute("SECHOLD", securityHolder)
		}
		model<<[transferResponseModel:fundTransferResponse]
	}
	
	def bulkpaymentPostProcess(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		log.info("Into bulkpaymentPostProcess");
		BulkPaymentRequest bulkPaymentRequest				=	(BulkPaymentRequest) getSessionAttribute("FTR");
		TransactionLimitResponse transactionLimitResponse	=	(TransactionLimitResponse)getSessionAttribute("LIMIT")
		AccountBalanceResponse accountBalanceResponse		=	(AccountBalanceResponse)getSessionAttribute("BAL")
		
		// Set the Limit Utilization if available
		if(transactionLimitResponse?.getMatchingLimitUtilization()!=null && transactionLimitResponse?.getMatchingLimitUtilization()?.getId()!=null)
		{
			log.info("Into bulkpaymentPostProcess Limit Utilization Id"+transactionLimitResponse?.getMatchingLimitUtilization()?.getId());
			bulkPaymentRequest.setLimitUtilizationId(transactionLimitResponse.getMatchingLimitUtilization().getId());
		}
		
		BulkPaymentTypeEnum bulkPaymentType = bulkPaymentRequest?.bulkPaymentType;
		log.info("BulkPayment Type >>"+bulkPaymentType);
		def bulkPayType = "";
		if(bulkPaymentType !=null && BulkPaymentTypeEnum.SP.equals(bulkPaymentType)){
			bulkPayType=BusinessFunctionConstants.SALARY_PAYMENTS;
		}else if(bulkPaymentType !=null && BulkPaymentTypeEnum.VP.equals(bulkPaymentType)){
			bulkPayType=BusinessFunctionConstants.VENDOR_PAYMENTS;
		}
		
		def fromAccountId		=	bulkPaymentRequest.getFromAccountId();
		def transferCurencyId	=	bulkPaymentRequest.getTransferCurrencyID();
		def fromCurrency,toCurrency,transferCurrency,baseCurrency
		def fromExchangeRate="1",toExchangeRate="1",chargeExchangeRate="1"
		def debitAmount,creditAmount,chargeAmount,totalTransactionAmount
		def fromCurrDesPosition,toCurrDesPosition
		def debitCurrencyDisplay
		def beneficiaryNickName
		def Map<String,String> postProcessModel	=	new HashMap<String, String>();
		def cancelAction
		def fromCurrIsoCode,toCurrIsoCode,transCurrIsoCode
				
		// From Account Currency
		fromCurrency			=		bulkPaymentRequest?.fromAccount?.currency?.code;
		fromCurrIsoCode  		= 		commonService.getCurrencyFormat(bulkPaymentRequest?.fromAccount?.currency?.currencyIsoCode?.toString())
		fromCurrDesPosition		=		bulkPaymentRequest?.fromAccount?.currency?.numberOfSubUnits;
		
		
		CommonRequest commonRequest		=	getBean(CommonRequest.class, requestHeader, null);
		CommonResponse commonResponse	=	null;
		commonResponse				=		bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
		Currency baseCurrencyObj	=		commonResponse?.commonEntity
		baseCurrency				=		baseCurrencyObj?.code;
		
		// To Account Currency
		Currency toCurrencyobj		=		baseCurrencyObj; //bulkPaymentRequest?.toBeneficiaryInstruction?.currency;
		toCurrency					=		toCurrencyobj?.code;
		toCurrDesPosition			=		toCurrencyobj?.numberOfSubUnits;
		toCurrIsoCode				=		commonService.getCurrencyFormat(toCurrencyobj?.currencyIsoCode?.toString())
		// Transfer Currency
		Currency transferCurrencyObj		=		baseCurrencyObj;//commonService.getCurrency(transferCurencyId)
		transferCurrency					=		transferCurrencyObj?.code
		transCurrIsoCode					=		commonService.getCurrencyFormat(transferCurrencyObj?.currencyIsoCode?.toString())
		
		ExchangeRateResponse exgRateRes	=	null;
		 if(!fromCurrency.equals(transferCurrency)){
			 exgRateRes			=	commonService.fetchExchangeCalc(transCurrIsoCode,fromCurrIsoCode,bulkPaymentRequest?.paymentAmount?.toString(),requestHeader);
			 fromExchangeRate	=	exgRateRes?.exchangeRate
			 debitAmount			=	exgRateRes?.convertedAmount?.toBigDecimal();
		 }else{
			 debitAmount			=	fromExchangeRate.toBigDecimal().multiply(bulkPaymentRequest?.paymentAmount)
		 }
		 
		 /* ChargeResponse chargeResponse = bmClient.iBCommonService.getCharges(bulkPaymentRequest);
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
			  log.info("Payment Amount :::"+bulkPaymentRequest.getPaymentAmount())
			  totalTransactionAmount = bulkPaymentRequest.getPaymentAmount().add(chargeAmount)
		  }else{
				totalTransactionAmount = bulkPaymentRequest.getPaymentAmount()
		  }*/
		  totalTransactionAmount = bulkPaymentRequest.getPaymentAmount()
		  log.info("Total Transaction Amount :::"+totalTransactionAmount);
		  bulkPaymentRequest.setTotalTransactionAmount(totalTransactionAmount);
			Map<String,Object> balanceCheckMap	=	new HashMap<String, Object>(3);
			balanceCheckMap.put("availableBalance", accountBalanceResponse?.availableBalance)
			balanceCheckMap.put("transferCurrency", transCurrIsoCode)
			balanceCheckMap.put("transferAmount", bulkPaymentRequest.getPaymentAmount());
			balanceCheckMap.put("transactionAmount", debitAmount)
			balanceCheckMap.put("chargeAmount", chargeAmount)
			
			DateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
			Date paymentDate = bulkPaymentRequest?.paymentDate;
			Date currentDate = formatter.parse(formatter.format(new Date()))
			def transType = paymentDate.compareTo(currentDate) == 0 ? 'PAYNOW' : 'PAYLATER';
			
			balanceCheckMap.put("transactionType", transType);
			transactionLimitResponse.setValidRecords(bulkPaymentRequest.getValidRecords());
			transactionLimitResponse.setFailedRecords(bulkPaymentRequest.getFailedRecords());
			transactionLimitResponse.setBulkPayment(Boolean.TRUE);
			balanceCheckMap.put("transactionLimit", transactionLimitResponse);
			commonRequest.setRequestParams(balanceCheckMap)
			commonResponse	=	bmClient.iBCommonService.verifyBalanceAndLimits(commonRequest)
			if(commonResponse.hasErrors())
			{
				model<<[errors:commonResponse.errors()]
				return
			}
		
		  postProcessModel.put("fromAccountId", fromAccountId)
		  //postProcessModel.put("toAccountId", toAccountId)
		  postProcessModel.put("remarks", bulkPaymentRequest.getPaymentRemarks())
		  postProcessModel.put("transactionAmount", bulkPaymentRequest.getPaymentAmount())
		  postProcessModel.put("debitAmount", debitAmount)
		  postProcessModel.put("fromCurrency", fromCurrency)
		  postProcessModel.put("toCurrency", toCurrency)
		  postProcessModel.put("transferCurrency", transferCurrency)
		  postProcessModel.put("fromExchangeRate", fromExchangeRate)
		  postProcessModel.put("toExchangeRate", toExchangeRate)
		  postProcessModel.put("creditAmount", creditAmount)
		  postProcessModel.put("debitCurrencyDisplay", debitCurrencyDisplay)
		  postProcessModel.put("buttonEvent", bulkPaymentRequest?.transactionType)
		  postProcessModel.put("frequency", bulkPaymentRequest?.schedulePaymentEnum?.toString())
		  postProcessModel.put("startDate", bulkPaymentRequest?.startDate)
		  postProcessModel.put("endDate", bulkPaymentRequest?.endDate)
		  postProcessModel.put("totalTransactionAmount", bulkPaymentRequest.getTotalAmount());
		  postProcessModel.put("totalTransactions", bulkPaymentRequest?.totalTransactions);
		  postProcessModel.put("paymentDate", bulkPaymentRequest?.getPaymentDate());
		  postProcessModel.put("fileName", bulkPaymentRequest?.getFileName());
		  postProcessModel.put("tenantServiceCode", bulkPayType);
		  
		  
		  /*if(chargeResponse.currency)
		  {
			  postProcessModel.put("chargeExchangeRate", chargeExchangeRate)
			  postProcessModel.put("chargeCurrency", chargeResponse?.currency)
			  postProcessModel.put("chargeAmount", chargeResponse?.chargeAmount)
			  postProcessModel.put("exactChargeAmount", chargeAmount)
			  postProcessModel.put("chargeCode", chargeResponse.getCode());
		  }*/
		  if(bulkPaymentRequest?.toBeneficiaryInstruction?.account)
		  {
			  postProcessModel.put("beneficiaryNickName", bulkPaymentRequest?.toBeneficiaryInstruction?.shortName)
			  postProcessModel.put("beneId", bulkPaymentRequest?.toBeneficiaryInstruction?.account?.id)
			  postProcessModel.put("beneficiaryAccountNumber", bulkPaymentRequest?.toBeneficiaryInstruction?.account?.accountNumber)
			  def acctType	=	bulkPaymentRequest?.toBeneficiaryInstruction?.transactionSubType?.serviceApplication?.service?.code
			  postProcessModel.put("cancelAction",PaymentModuleTypeEnum.valueOf(acctType).getKey())
		  }else{
			  postProcessModel.put("beneficiaryNickName", bulkPaymentRequest?.toBeneficiaryInstruction?.beneficiary?.shortName)
			  postProcessModel.put("beneId", bulkPaymentRequest?.toBeneficiaryInstruction?.beneficiary?.id)
			  postProcessModel.put("cancelAction","friendsandfamilypayment")
			  
		  }
		  bulkPaymentRequest.setFromExchangeRate(fromExchangeRate.toDouble());
		  bulkPaymentRequest.setToExchangeRate(toExchangeRate.toDouble());
		  /*if(chargeResponse.currency)
		  {
			  bulkPaymentRequest.setChargeExchangeRate(chargeExchangeRate.toDouble());
			  bulkPaymentRequest.setTransactionCharges(chargeAmount);
		  }*/
		  bulkPaymentRequest.dailyUtilizedLimit= transactionLimitResponse?.dailyAmountUtilized>=0 ? transactionLimitResponse?.dailyAmountUtilized.add(debitAmount) : new BigDecimal(0);
		  bulkPaymentRequest.dailyUtilizedCount=transactionLimitResponse?.dailyUtilizedCount>=0 ? transactionLimitResponse?.dailyUtilizedCount + 1 : new Integer(0);
		  bulkPaymentRequest.monthlyUtilizedLimit=transactionLimitResponse?.monthlyAmountUtilized>=0 ? transactionLimitResponse?.monthlyAmountUtilized.add(debitAmount) : new BigDecimal(0);
		  bulkPaymentRequest.monthlyUtilizedCount=transactionLimitResponse?.monthlyUtilizedCount>=0 ? transactionLimitResponse?.monthlyUtilizedCount + 1 : new Integer(0);

		  //To send exact calculated amount to IM incase of cross currency payment
		  bulkPaymentRequest.creditAmount=creditAmount;
		  bulkPaymentRequest.debitAmount=debitAmount;
		  bulkPaymentRequest.transactionCurrency = transferCurrency
		  setSessionAttribute("FTR", bulkPaymentRequest);
		  session.removeAttribute("LIMIT")
		  
		  if(bulkPaymentRequest?.isAWarning)
		  {
			  model<<[postProcessModel:postProcessModel,isAWarning:bulkPaymentRequest?.isAWarning,warningErrorCodes:bulkPaymentRequest?.warningErrorCodes,errorClass:"info"]
		  }
		  else
		  {
			  model<<[postProcessModel:postProcessModel,isAWarning:Boolean.FALSE]
		  }
		  log.info("Leaving bulkpaymentPostProcess");
	}
	
	
	def uploadBulkPaymentFile(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BulkPaymentRequest bulkPaymentRequest		=	(BulkPaymentRequest)getSessionAttribute("FTR")
		FundTransferResponse fundTransferResponse	=	bmClient.bulkPaymentService.insertBulkPaymentDetails(bulkPaymentRequest)
		if(fundTransferResponse?.hasErrors()){
			model<<[errors:fundTransferResponse.errors()]
		}
		model<<[bulkUploadResponseModel:fundTransferResponse,fileUpladReference:fundTransferResponse?.bulkPaymentHeader?.referenceTag]
		
	}
	
	
	
	private BulkPaymentRequest prepareFundTranferRequestForBulkPayment(Map params,BulkPaymentRequest bulkPaymentRequest, GenericRequestHeader requestHeader)  throws BusinessException
	{
		bulkPaymentRequest.setFromAccountId(params.fromAccountId)
		Currency baseCur = getBaseCurrency(requestHeader);
		bulkPaymentRequest.setTransferCurrencyID(baseCur?.idVersion?.toString());
		bulkPaymentRequest.setPaymentDate(DateUtils.convertStringToDate(params.paymentDate, DateUtils.YYYY_MM_DD))
		bulkPaymentRequest.setPaymentRemarks(params.paymentRemarks)
		bulkPaymentRequest.setFileName(params.uploadedFileName)
		File uploaded = (File) getSessionAttribute("UPLOADED_FILE");
		bulkPaymentRequest.bulkUploadFile=uploaded;
		return bulkPaymentRequest;
	}
	
	private Currency getBaseCurrency(GenericRequestHeader requestHeader){
		CommonRequest commonRequest		=	getBean(CommonRequest.class, requestHeader, null);
		CommonResponse commonResponse	=	null;
		commonResponse				=		bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
		Currency baseCurrencyObj	=		commonResponse?.commonEntity
		return baseCurrencyObj;
	}
	
	def showBulkFileContent(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BulkPaymentDetailRequest paymentDetailRequest 	= getBean(BulkPaymentDetailRequest.class, requestHeader, params);
		paymentDetailRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
		paymentDetailRequest.setPaymentHeaderId(params?.hdrId);
		
		//Added for Pagination      
		
		def pageNumber = (StringUtils.hasText(params?.gotoPage))?
		params?.int('gotoPage') : 0;
		PageRequest page = new PageRequest(pageNumber, 20);
		paymentDetailRequest.setPageRequest(page);
		                                                                                
		BulkPaymentDetailResponse paymentDetailResponse	= bmClient.bulkPaymentService.getBulkPaymentDetailsByHeaderId(paymentDetailRequest);
		log.info("Header >>"+paymentDetailResponse?.bulkPaymentHeader?.dump());
		if(paymentDetailResponse?.hasErrors()){
			model<<[errors:paymentDetailResponse.errors()]
		}
		model<<[bulkPaymentHeaderModel:paymentDetailResponse?.bulkPaymentHeader,bulkPaymentDetailsModel:paymentDetailResponse?.bulkpaymentDetails,pagerModel:paymentDetailResponse.getPage()]
	}
	                 
	def proceedForApproval(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BulkPaymentRequest bulkPaymentRequest 		= getBean(BulkPaymentRequest.class, requestHeader, params);
		bulkPaymentRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
		def hdrList = params.list('chkBox');
		bulkPaymentRequest.setBulkPaymentHeaderIds(hdrList?.collect{it.toLong()});
		BulkPaymentResponse bulkPaymentResponse  = bmClient.bulkPaymentService.proceedBulkPaymentForApproval(bulkPaymentRequest);
		def recordsFoundForApproval = false;
		def bulkPayWithNoAuthorization = false;
		def bulkPaySMEFailures = false;
		def bulkPayWithAuthorization = false;
		if(bulkPaymentResponse?.hasErrors()){
			model<<[errors:bulkPaymentResponse.errors()]
		}
		if(bulkPaymentResponse?.recordsFoundForApproval)
		{
			recordsFoundForApproval = true;
		}
		
		if(!CollectionUtils.isEmpty(bulkPaymentResponse.getBulkPaymentHeadersWithNoAuthorization()))
		{
			bulkPayWithNoAuthorization = true;
		}
		if(!CollectionUtils.isEmpty(bulkPaymentResponse.getBulkPaymentHeadersWithAuthorization()))
		{
			bulkPayWithAuthorization = true;
		}
		if(!CollectionUtils.isEmpty(bulkPaymentResponse.getBulkPaymentHeaderSMEFailures()))
		{
			bulkPaySMEFailures = true;
		}
		model<<[bulkPaymentHeaderModel:bulkPaymentResponse,
			recordsFoundForApproval:recordsFoundForApproval,
			bulkPayWithNoAuthorization:bulkPayWithNoAuthorization,
			bulkPaySMEFailures:bulkPaySMEFailures,bulkPayWithAuthorization:bulkPayWithAuthorization]
	}
	
	def discardBulkPaymentTransaction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BulkPaymentRequest bulkPaymentRequest 		= getBean(BulkPaymentRequest.class, requestHeader, params);
		bulkPaymentRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
		//bulkPaymentRequest.bulkPaymentHeaderId(params?.pendingTransactionId?.toLong());
		bulkPaymentRequest.setBulkPaymentHeaderId(params?.pendingTransactionId?.toLong());
		BulkPaymentResponse bulkPaymentResponse  = bmClient.bulkPaymentService.discardBulkPaymentTransaction(bulkPaymentRequest);
		
		if(bulkPaymentResponse.hasErrors()){
			model<<[errors:bulkPaymentResponse.errors()]
		}else {
			BulkPaymentDetailRequest bulkPayDetailRequest 	= getBean(BulkPaymentDetailRequest.class, requestHeader, params);
		bulkPayDetailRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
		//Added for Pagination
		
		def pageNumber = (StringUtils.hasText(params?.gotoPage))?
		params?.int('gotoPage') : 0;
		PageRequest page = new PageRequest(pageNumber,5);
		bulkPayDetailRequest.setPageRequest(page);
		
		def tenantServiceCode = params?.tenantServiceCode;
		if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && tenantServiceCode.equals(BusinessFunctionConstants.SALARY_PAYMENTS))
		{
			bulkPayDetailRequest.setBulkPaymentType(BulkPaymentTypeEnum.SP)
		}
		else if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && tenantServiceCode.equals(BusinessFunctionConstants.VENDOR_PAYMENTS))
		{
			bulkPayDetailRequest.setBulkPaymentType(BulkPaymentTypeEnum.VP)
		}
		
//		if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && tenantServiceCode.equals("SP"))
//		{
//			bulkPayDetailRequest.setBulkPaymentType(BulkPaymentTypeEnum.SP)
//		}
//		else if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && tenantServiceCode.equals("VP"))
//		{
//			bulkPayDetailRequest.setBulkPaymentType(BulkPaymentTypeEnum.VP)
//		}
		
		BulkPaymentDetailResponse paymentDetailResponse	= bmClient.bulkPaymentService.getBulkPaymentsListPage(bulkPayDetailRequest);
		log.info("Header List>>"+paymentDetailResponse?.bulkPaymentHeaderList?.dump());
		if(paymentDetailResponse?.hasErrors()){
			model<<[errors:paymentDetailResponse.errors()]
		}
		setMessage(DEFAULT_DELETED_MESSAGE,["Bulk Payment Transaction with reference ",params.referenceTag+" successfully"], model)
		model<<[bulkPaymentHeaderModel:paymentDetailResponse?.bulkPaymentHeaderList,toTSTService:params?.tenantServiceCode,pagerModel:paymentDetailResponse.getPage()]
		}
	}
	
	def showBulkPaymentDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BulkPaymentDetailRequest paymentDetailRequest 	= getBean(BulkPaymentDetailRequest.class, requestHeader, params);
		paymentDetailRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
		paymentDetailRequest.setPaymentHeaderId(params?.taskInstanceId);
					
		/*
		 * added for payment Header for pagination
		 */
		def editurl = params?.editUrl;
		if(paymentDetailRequest.getPaymentHeaderId() == null){
			paymentDetailRequest.setPaymentHeaderId(params?.hdrId);
		}
		
		def pageNumber = (StringUtils.hasText(params?.gotoPage))?params?.int('gotoPage') : 0;
		print "pageNumber::::::::::::::"+pageNumber;
		PageRequest page = new PageRequest(pageNumber, 20);
		paymentDetailRequest.setPageRequest(page);
		BulkPaymentDetailResponse paymentDetailResponse	= bmClient.bulkPaymentService.getBulkPaymentDetailsByHeaderId(paymentDetailRequest);
		log.info("Header >>"+paymentDetailResponse?.bulkPaymentHeader?.dump());
		def bulkPaytype = paymentDetailResponse?.bulkPaymentHeader?.bulkPaymentType;
		log.info("BulkPayment Type >>"+bulkPaytype);
		if(bulkPaytype!=null && BulkPaymentTypeEnum.SP.equals(bulkPaytype)){
			bulkPaytype=BusinessFunctionConstants.SALARY_PAYMENTS;
		}else{
			bulkPaytype=BusinessFunctionConstants.VENDOR_PAYMENTS;
		}
		if(paymentDetailResponse?.hasErrors()){
			model<<[errors:paymentDetailResponse.errors()]
		}
		BigDecimal totalSuccessAmount = BigDecimal.ZERO;
		paymentDetailResponse?.bulkPaymentHeader?.bulkPaymentDetails?.each{it->
			if('SUCCESS'.equals(it?.status?.code)){
				totalSuccessAmount = totalSuccessAmount.add(it?.paymentAmount);
			}else{
				totalSuccessAmount = totalSuccessAmount.add(BigDecimal.ZERO);
			}
		}
		model<<[bulkPaymentHeaderModel:paymentDetailResponse?.bulkPaymentHeader,editurl:editurl,bulkpaymentDetails:paymentDetailResponse.bulkpaymentDetails,datelineEventRef:params?.dtype,datelineRef:params?.id,toTSTCode:bulkPaytype,checkers:params?.checkers,isTransExpired:paymentDetailResponse?.isTransactionExpired,totalSuccessAmount:totalSuccessAmount,,pagerModel:paymentDetailResponse.getPage()]
	}
	
	
	def showBulkPaymentDatelineDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BulkPaymentDetailRequest paymentDetailRequest 	= getBean(BulkPaymentDetailRequest.class, requestHeader, params);
		paymentDetailRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
		paymentDetailRequest.setPaymentHeaderId(params?.taskInstanceId);
		
		//Added for Pagination
		def editurl = params?.editUrl;
		
		/*
		 * added for payment Header for pagination
		 */
		if(paymentDetailRequest.getPaymentHeaderId() == null){
			paymentDetailRequest.setPaymentHeaderId(params?.hdrId);
		}
		
		def pageNumber = (StringUtils.hasText(params?.gotoPage))?params?.int('gotoPage') : 0;
		print "pageNumber::::::::::::::"+pageNumber;
		PageRequest page = new PageRequest(pageNumber, 20);
		paymentDetailRequest.setPageRequest(page);
		BulkPaymentDetailResponse paymentDetailResponse	= bmClient.bulkPaymentService.getBulkPaymentDatelineRecordsForPagination(paymentDetailRequest);
		log.info("Header >>"+paymentDetailResponse?.bulkPaymentHeader?.dump());
		def bulkPaytype = paymentDetailResponse?.bulkPaymentHeader?.bulkPaymentType;
		log.info("BulkPayment Type >>"+bulkPaytype);
		if(bulkPaytype!=null && BulkPaymentTypeEnum.SP.equals(bulkPaytype)){
			bulkPaytype=BusinessFunctionConstants.SALARY_PAYMENTS;
		}else{
			bulkPaytype=BusinessFunctionConstants.VENDOR_PAYMENTS;
		}
		if(paymentDetailResponse?.hasErrors()){
			model<<[errors:paymentDetailResponse.errors()]
		}
		model<<[bulkPaymentHeaderModel:paymentDetailResponse?.bulkPaymentHeader,editurl:editurl,bulkpaymentDetails:paymentDetailResponse.bulkpaymentDetails,datelineEventRef:params?.dtype,datelineRef:params?.id,toTSTCode:bulkPaytype,checkers:params?.checkers,isTransExpired:paymentDetailResponse?.isTransactionExpired,pagerModel:paymentDetailResponse.getPage()]
	}
	
	
	def authReviewFileContentDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BulkPaymentDetailRequest paymentDetailRequest 	= getBean(BulkPaymentDetailRequest.class, requestHeader, params);
		paymentDetailRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
		paymentDetailRequest.setPaymentHeaderId(params?.taskInstanceId);
		
		//Added for Pagination
		def editurl = params?.editUrl;
		
		/*
		 * added for payment Header for pagination
		 */
		if(paymentDetailRequest.getPaymentHeaderId() == null){
			paymentDetailRequest.setPaymentHeaderId(params?.hdrId);
		}
		
		def pageNumber = (StringUtils.hasText(params?.gotoPage))?params?.int('gotoPage') : 0;
		print "pageNumber::::::::::::::"+pageNumber;
		PageRequest page = new PageRequest(pageNumber, 20);
		paymentDetailRequest.setPageRequest(page);
		BulkPaymentDetailResponse paymentDetailResponse	= bmClient.bulkPaymentService.getBulkPaymentDatelineRecordsForPagination(paymentDetailRequest);
		log.info("Header >>"+paymentDetailResponse?.bulkPaymentHeader?.dump());
		def bulkPaytype = paymentDetailResponse?.bulkPaymentHeader?.bulkPaymentType;
		log.info("BulkPayment Type >>"+bulkPaytype);
		if(bulkPaytype!=null && BulkPaymentTypeEnum.SP.equals(bulkPaytype)){
			bulkPaytype=BusinessFunctionConstants.SALARY_PAYMENTS;
		}else{
			bulkPaytype=BusinessFunctionConstants.VENDOR_PAYMENTS;
		}
		if(paymentDetailResponse?.hasErrors()){
			model<<[errors:paymentDetailResponse.errors()]
		}
		model<<[bulkPaymentHeaderModel:paymentDetailResponse?.bulkPaymentHeader,editurl:editurl,bulkpaymentDetails:paymentDetailResponse.bulkpaymentDetails,datelineEventRef:params?.dtype,datelineRef:params?.id,toTSTCode:bulkPaytype,checkers:params?.checkers,isTransExpired:paymentDetailResponse?.isTransactionExpired,pagerModel:paymentDetailResponse.getPage()]
	}
	
	
	
	
	def bulkPaymentDatelineView(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BulkPaymentDetailRequest bulkPayRequest 	= getBean(BulkPaymentDetailRequest.class, requestHeader, params);
		bulkPayRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
		bulkPayRequest.setPaymentHeaderId(params?.taskInstanceId);
		BulkPaymentDetailResponse bulkPayResponse	= bmClient.bulkPaymentService.getBulkPaymentDetailsByHeaderId(bulkPayRequest);
		log.info("Header >>"+bulkPayResponse?.bulkPaymentHeader?.dump());
		def bulkPaytype = bulkPayResponse?.bulkPaymentHeader?.bulkPaymentType;
		log.info("BulkPayment Type >>"+bulkPaytype);
		if(bulkPaytype!=null && bulkPaytype.equals(BulkPaymentTypeEnum.SP)){
			bulkPaytype=BusinessFunctionConstants.SALARY_PAYMENTS;
		}else{
			bulkPaytype=BusinessFunctionConstants.VENDOR_PAYMENTS;
		}
		if(bulkPayResponse?.hasErrors()){
			model<<[errors:bulkPayResponse.errors()]
		}
		BigDecimal totalSuccessAmount = BigDecimal.ZERO;
		bulkPayResponse?.bulkPaymentHeader?.bulkPaymentDetails?.each{it->
			if('SUCCESS'.equals(it?.status?.code)){
				totalSuccessAmount = totalSuccessAmount.add(it?.paymentAmount);
			}else{
				totalSuccessAmount = totalSuccessAmount.add(BigDecimal.ZERO);
			}
		}
		model<<[bulkPaymentHeaderModel:bulkPayResponse?.bulkPaymentHeader,datelineEventRef:params?.dtype,datelineRef:params?.id,toTSTCode:bulkPaytype,checkers:params?.checkers,isTransExpired:bulkPayResponse?.isTransactionExpired,
			totalSuccessAmount:totalSuccessAmount]
	}
	
	def approveBulkPaymentPreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		log.info("approveBulkPaymentPreConfirm... Params="+params?.dump());
		model<<[successAction:'approveBulkPayment',serviceCode:params.toTSTCode];
	}
	def rejectBulkPaymentPreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		model<<[successAction:'rejectBulkPayment',serviceCode:params.toTSTCode];
	}
	
	
	def approveBulkPayment(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		log.info("approveBulkPayment... Params="+params?.dump());
		pushDatelineUrlParametersIntoGrailsParams(params?.datelineReferenceId, params);
		Map<String,Object> taskVariables = new HashMap<String,Object>();
		String loggedInUser = SecurityUtils.invoker.userLoginProfileId
		taskVariables.put("authorizeAction", "approve");
		String errorCode = null;
		Object[] args    = null;
		try
		{
			
			BulkPaymentRequest bulkPaymentRequest 		= getBean(BulkPaymentRequest.class, requestHeader, params);
			/* Set the Bulk Payment Header Id */
			def bulkPaymentHeaderId = params?.bulkPaymentHeaderId;
			bulkPaymentRequest.setBulkPaymentHeaderId(Long.valueOf(bulkPaymentHeaderId));
			
			BulkPaymentResponse bulkPaymentResponse	  = bmClient.bulkPaymentService.getPendingAuthBulkPaymentDetailsByHeaderId(bulkPaymentRequest);
			List<Long> fileDetailList = bulkPaymentResponse.getBulkPaymentDetailIds();
			/*fileDetailList.eachWithIndex { item, index ->
				workflowService.completeTaskWithFormData(item.toString(), taskVariables,loggedInUser,params.comments);
			}*/
			bulkPaymentRequest.setLoggedInUser(loggedInUser);
			bulkPaymentRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
			bulkPaymentRequest.setStatus(LookupCodeConstants.PENDING.toString());
			bulkPaymentRequest.setCheckerComments(params.comments);
			bulkPaymentRequest.setIsAuthorized(Boolean.TRUE);
			/*Set Auth Users*/
			if(params.checkers)
			{
				log.info("approveBulkPayment... checkers="+params.checkers);
				def checkers = params?.checkers;
				bulkPaymentRequest.setJointAuthULPs(checkers);
				bulkPaymentRequest.setUsersToNotify(checkers)
			}
			else
			{
				log.info("approveBulkPayment... NO CHECKERS FOUND.ABout to throw BusinessException"+params.checkers);
				throw new BusinessException(ContextCodeType.GENERAL, ErrorCodeConstants.BULK_PAY_NO_AUTH_CONFIGURED);
			}
			
			fileDetailList.eachWithIndex { item, index ->
				bulkPaymentRequest.getRecordsChosenforAuthorization().add(item);
			}
			BulkPaymentResponse bulkPaymentResponse1  = bmClient.bulkPaymentService.approveBulkPaymentRequest(bulkPaymentRequest);
			
			//Check for Subtask
			long pendingCount = workflowService.getPendingSubTasksCountByParentTaskId(params?.taskId)
			log.info("approveBulkPaymentPreConfirm... pendingCount="+pendingCount);
			if(pendingCount == 0){
				workflowService.completeTaskWithFormData(params?.taskId, taskVariables,loggedInUser,params.comments);
			}
			model<<[taskId:params.taskId,messageType:"success"];
		}catch(BusinessException be){
			be.printStackTrace();
		   	log.error("BusinessException occured in BulkPaymentService approveBulkPayment "+be)
			errorCode 	= be.getErrorCode();
			args 		= be.getArguments();
			model<<[taskId:params.taskId,messageType:"failure",errorCode:errorCode,args:args];
		}catch(DataAccessException dae){
			dae.printStackTrace();
			log.error("DataAccessException occured in BulkPaymentService approveBulkPayment "+dae)
			errorCode 		= dae.getClass().getName();			
			model<<[taskId:params.taskId,messageType:"failure",errorCode:errorCode,args:args];
		}catch(Exception e){
			e.printStackTrace();
			log.error("Exception occured in BulkPaymentService approveBulkPayment "+e)
			errorCode 		= e.message;
			model<<[taskId:params.taskId,messageType:"failure",errorCode:errorCode,args:args];
		}
	}
	
	def rejectBulkPayment(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		log.info("rejectBulkPayment... Params="+params?.dump());
		pushDatelineUrlParametersIntoGrailsParams(params?.datelineReferenceId, params);
		Map<String,Object> taskVariables = new HashMap<String,Object>();
		String loggedInUser = SecurityUtils.invoker.userLoginProfileId
		taskVariables.put("authorizeAction", "reject");
		String errorCode = null;
		Object[] args    = null;
		try
		{
			
			BulkPaymentRequest bulkPaymentRequest 		= getBean(BulkPaymentRequest.class, requestHeader, params);
			/* Set the Bulk Payment Header Id */
			def bulkPaymentHeaderId = params?.bulkPaymentHeaderId;
			bulkPaymentRequest.setBulkPaymentHeaderId(Long.valueOf(bulkPaymentHeaderId));
			
			BulkPaymentResponse bulkPaymentResponse	  = bmClient.bulkPaymentService.getPendingAuthBulkPaymentDetailsByHeaderId(bulkPaymentRequest);
			List<Long> fileDetailList = bulkPaymentResponse.getBulkPaymentDetailIds();
			/*fileDetailList.eachWithIndex { item, index ->
				workflowService.completeTaskWithFormData(item.toString(), taskVariables,loggedInUser,params.comments);
			}*/
			bulkPaymentRequest.setLoggedInUser(loggedInUser);
			bulkPaymentRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
			bulkPaymentRequest.setStatus(LookupCodeConstants.REJECTED.toString());
			bulkPaymentRequest.setCheckerComments(params.comments);
			
			/*Set Auth Users*/
			if(params.checkers)
			{
				log.info("approveBulkPayment... checkers="+params.checkers);
				def checkers = params?.checkers;
				bulkPaymentRequest.setJointAuthULPs(checkers);
				bulkPaymentRequest.setUsersToNotify(checkers)
			}
			else
			{
				log.info("approveBulkPayment... NO CHECKERS FOUND.ABout to throw BusinessException"+params.checkers);
				throw new BusinessException(ContextCodeType.GENERAL, ErrorCodeConstants.BULK_PAY_NO_AUTH_CONFIGURED);
			}
			
			fileDetailList.eachWithIndex { item, index ->
				bulkPaymentRequest.getRecordsChosenforAuthorization().add(item);
			}
			BulkPaymentResponse bulkPaymentResponse1  = bmClient.bulkPaymentService.rejectBulkPaymentRequest(bulkPaymentRequest);
			
			//Check for Subtask
			long pendingCount = workflowService.getPendingSubTasksCountByParentTaskId(params?.taskId)
			log.info("approveBulkPaymentPreConfirm... pendingCount="+pendingCount);
			if(pendingCount == 0){
				workflowService.completeTaskWithFormData(params?.taskId, taskVariables,loggedInUser,params.comments);
			}
			model<<[taskId:params.taskId,messageType:"success"];
		}catch(BusinessException be){
			be.printStackTrace();
			log.error("BusinessException occured in BulkPaymentService approveBulkPayment "+be)
			errorCode 	= be.getErrorCode();
			args 		= be.getArguments();
			model<<[taskId:params.taskId,messageType:"failure",errorCode:errorCode,args:args];
		}catch(DataAccessException dae){
			dae.printStackTrace();	
			log.error("DataAccessException occured in BulkPaymentService approveBulkPayment "+dae)
			errorCode 		= dae.getClass().getName();			
			model<<[taskId:params.taskId,messageType:"failure",errorCode:errorCode,args:args];
		}catch(Exception e){
			e.printStackTrace();
			log.error("Exception occured in BulkPaymentService approveBulkPayment "+e)
			errorCode 		= e.message;
			model<<[taskId:params.taskId,messageType:"failure",errorCode:errorCode,args:args];
		}
		
	}
	
	
	def pushDatelineUrlParametersIntoGrailsParams(String datelineTaskIdentifier, Map params){
		DatelineTask task = datelineIBUtils.getDateLineService().getDatelineTaskById(Long.parseLong(datelineTaskIdentifier))
		URIBuilder builder = new URIBuilder(task.getTargetUrlParam());
		List<NameValuePair> parameters = builder.getQueryParams();
		for (NameValuePair parameter : parameters) {
			params.put(parameter.getName(), parameter.getValue());
		}
	}
	
	def exchangeRateAndLimit(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		log.info("Into Bulk Payment exchangeRateAndLimit");
		PaymentTransferRequest paymentRequest = getBean(PaymentTransferRequest.class, requestHeader, null);		
		PaymentTransferResponse paymentResponse =null;
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, null);
		def transferCurrency = [] as HashSet<Currency>;
		String fromCurrency,toCurrency="";   
		String exchangeRate="";
		String transactionType='';
		Long accountId ;
		Long fromCurrencyId;
		
		log.info("Into Bulk Payment exchangeRateAndLimit ---> params.payerId ---> "+params.payerId);
		if(params.payerId){
			paymentRequest.setPayerId(getIdVersion(params.payerId)[0])
			paymentResponse = 	bmClient.paymentService.getPayer(paymentRequest);
			fromCurrency=paymentResponse.getPayer().getCurrency().getCode();
			fromCurrencyId=paymentResponse.getPayer().getCurrency().getId();
			log.info("Into Bulk Payment exchangeRateAndLimit ---> fromCurrencyId ---> "+fromCurrencyId);
			transferCurrency.add(paymentResponse.getPayer().getCurrency())
		}
		
		log.info("Into Bulk Payment exchangeRateAndLimit ---> Obtain Account Balance ");		
		AccountBalanceRequest accountBalanceRequest=getBean(AccountBalanceRequest.class, requestHeader, null);
		accountBalanceRequest.accountId= getIdVersion(params.payerId)[0];
		AccountBalanceResponse accountBalanceResponse= commonService.getAccountBalance(accountBalanceRequest);
		setSessionAttribute("BAL", accountBalanceResponse);
		
		TransactionLimitRequest transactionLimitRequest=new TransactionLimitRequest();
		transactionLimitRequest.setRequestHeader(requestHeader);
		transactionLimitRequest.setFromCurrencyId(fromCurrencyId);
		Long userLoginProfileId = getInvoker().getUserLoginProfileId();
		log.info("Into Bulk Payment exchangeRateAndLimit ---> userLoginProfileId "+userLoginProfileId);
		transactionLimitRequest.setUserLoginProfileId(userLoginProfileId);
		String tenantServiceCode = params.tenantServiceCode;
		log.info("Into Bulk Payment exchangeRateAndLimit ---> tenantServiceCode "+tenantServiceCode);
		transactionLimitRequest.setBulkPayment(true);
		if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && BusinessFunctionConstants.SALARY_PAYMENTS.equalsIgnoreCase(tenantServiceCode))
		{
			transactionLimitRequest.setBulkPaymentType(BulkPaymentTypeEnum.SP);
		}
		else if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && BusinessFunctionConstants.VENDOR_PAYMENTS.equalsIgnoreCase(tenantServiceCode))
		{
			transactionLimitRequest.setBulkPaymentType(BulkPaymentTypeEnum.VP);
		}
		
		TransactionLimitResponse transactionLimitResponse=bmClient.paymentService.fetchTransactionalLimit(transactionLimitRequest)
		setSessionAttribute("LIMIT", transactionLimitResponse)
		
		model<<[accountBalanceModel:accountBalanceResponse,transferCurrency:transferCurrency?.toList(),exchangeRateModel:exchangeRate,transactionType:transactionType,limitModel:transactionLimitResponse]
		log.info("Into Bulk Payment exchangeRateAndLimit");
	}
	
	def deleteBulkPaymentTransaction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BulkPaymentRequest bulkPaymentRequest 		= getBean(BulkPaymentRequest.class, requestHeader, params);
		bulkPaymentRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
		//bulkPaymentRequest.bulkPaymentHeaderId(params?.pendingTransactionId?.toLong());
		bulkPaymentRequest.setBulkPaymentHeaderId(params?.pendingTransactionId?.toLong());
		BulkPaymentResponse bulkPaymentResponse  = bmClient.bulkPaymentService.deleteBulkPaymentTransaction(bulkPaymentRequest);
		
		if(bulkPaymentResponse.hasErrors()){
			model<<[errors:bulkPaymentResponse.errors()]
		} else {
			BulkPaymentDetailRequest bulkPayDetailRequest 	= getBean(BulkPaymentDetailRequest.class, requestHeader, params);
		bulkPayDetailRequest.setCustomerULPId(getUserLoginProfile()?.getId()?.toString());
		def tenantServiceCode = params?.tenantServiceCode;
		//Added for Pagination
		
		def pageNumber = (StringUtils.hasText(params?.gotoPage))?
		params?.int('gotoPage') : 0;
		PageRequest page = new PageRequest(pageNumber,5);
		bulkPayDetailRequest.setPageRequest(page);
		
//		if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && tenantServiceCode.equals("SP"))
//		{
//			bulkPayDetailRequest.setBulkPaymentType(BulkPaymentTypeEnum.SP)
//		}
//		else if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && tenantServiceCode.equals("VP"))
//		{
//			bulkPayDetailRequest.setBulkPaymentType(BulkPaymentTypeEnum.VP)
//		}
		if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && tenantServiceCode.equals(BusinessFunctionConstants.SALARY_PAYMENTS))
		{
			bulkPayDetailRequest.setBulkPaymentType(BulkPaymentTypeEnum.SP)
		}
		else if(tenantServiceCode!=null && !tenantServiceCode.equalsIgnoreCase("") && tenantServiceCode.equals(BusinessFunctionConstants.VENDOR_PAYMENTS))
		{
			bulkPayDetailRequest.setBulkPaymentType(BulkPaymentTypeEnum.VP)
		}
		BulkPaymentDetailResponse paymentDetailResponse	= bmClient.bulkPaymentService.getBulkPaymentsListPage(bulkPayDetailRequest);
		log.info("Header List>>"+paymentDetailResponse?.bulkPaymentHeaderList?.dump());
		if(paymentDetailResponse?.hasErrors()){
			model<<[errors:paymentDetailResponse.errors()]
		}
		setMessage(DEFAULT_DELETED_MESSAGE,["Bulk Payment Transaction with reference ",params.referenceTag+" successfully"], model)
		model<<[bulkPaymentHeaderModel:paymentDetailResponse?.bulkPaymentHeaderList,toTSTService:params?.tenantServiceCode,pagerModel:paymentDetailResponse.getPage()]
		}
		
	
		
			
	}
			
	/* ------------------SME Bulk Payment Ends----------------------- */
	
}

class BulkPaymentCommand {
	String fromAccountId;
	String uploadedFileName;
	String paymentRemarks;
	String paymentDate;
	static constraints={
			fromAccountId(blank: false)
			uploadedFileName(blank: false)
			paymentDate(blank: false)
			uploadedFileName validator:{val,obj ->
				if(val=='')
				{
					obj.errors.rejectValue('uploadedFileName','File Attachment is missing')
				}
			}
			paymentDate validator:{val,obj ->
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Date date = (Date)formatter.parse(val);
				Date currentDate = formatter.parse(formatter.format(new Date()));
				if(date.compareTo(currentDate) < 0){
					obj.errors.rejectValue('paymentDate','fundTransferCommand.paymentDate.matches.error')
				}
			};
			paymentRemarks(blank:true,shared : 'remarksConstraint')
		};
	}
