package com.vayana.ib.retail.web.service

import org.springframework.ui.ModelMap

import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.ib.bm.core.api.beans.biller.BillerDetailsRequest
import com.vayana.ib.bm.core.api.beans.biller.BillerDetailsResponse
import com.vayana.ib.bm.core.api.beans.biller.BillerRequest
import com.vayana.ib.bm.core.api.beans.biller.BillerResponse
import com.vayana.ib.bm.core.api.beans.payment.FavouritePaymentDetailRequest
import com.vayana.ib.bm.core.api.beans.payment.FavouritePaymentDetailResponse
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileResponse
import com.vayana.ib.bm.core.api.model.enums.QuickPayButtonEnum
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService


class BillerService extends GenericService{
	
	BmClient bmClient;
	CommonService commonService;
	
	def details(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,requestHeader,params);
		billerDetailsRequest.setBillerId(params.billerId.toLong());
		billerDetailsRequest.setUserLoginProfileId(getUserLoginProfile().getId());
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getActiveInActiveBillerDetails(billerDetailsRequest);
	   	model << [BillerDetailsModel:billerDetailsResponse]
	}
	
	def addBiller(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,requestHeader,params);
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getBillerCategoryDetails(billerDetailsRequest);
		println billerDetailsResponse.dump();
		model << [BillerCategoryDetailsModel:billerDetailsResponse]
	}
	
	def getParentBillerCompany(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,requestHeader,params);
		Long billerCategoryId = getIdVersion(params.selectedBillerCategoryId)[0]
		billerDetailsRequest.setBillerCategoryId(billerCategoryId);
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getBillerDetails(billerDetailsRequest);
		println billerDetailsResponse.dump();
		model << [BillerDetailsModel:billerDetailsResponse]
	}
	
	def getBillerServices(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,requestHeader,params);
		Long billerId = getIdVersion(params.selectedBillerTypeId)[0]
		billerDetailsRequest.setBillerId(billerId);
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getBillerServices(billerDetailsRequest);
		model << [BillerDetailsModel:billerDetailsResponse]
	}
	
	def getBillerServiceMetaData(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,requestHeader,params);
		Long billerServiceId = getIdVersion(params.selectedBillerServiceId)[0]
		billerDetailsRequest.setBillerServiceId(billerServiceId);
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getBillerServiceMetaDataDetails(billerDetailsRequest);
		model << [BillerDetailsModel:billerDetailsResponse]
	}
	
	def getParentBillerMetaData(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,requestHeader,params);
		Long billerId;
		Long parentBillerId;
		billerId = getIdVersion(params.selectedBillerTypeId)[0]
		billerDetailsRequest.setBillerId(billerId);	
		billerDetailsRequest.setParentBillerId(billerId);
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getBillerMetaDataDetails(billerDetailsRequest);		
		model << [BillerDetailsModel:billerDetailsResponse]
	}
	
	
	def getSubBillerMetaData(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,requestHeader,params);
		Long billerId;
		Long parentBillerId;
		billerId = getIdVersion(params.selectedBillerTypeId)[0]
		parentBillerId = getIdVersion(params.parentBillerId)[0]
		billerDetailsRequest.setBillerId(billerId);				
		billerDetailsRequest.setParentBillerId(parentBillerId);
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getBillerMetaDataDetails(billerDetailsRequest);
		model << [BillerDetailsModel:billerDetailsResponse]
	}
	
		
	def getBillerInstructiondetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,requestHeader,params);
		billerDetailsRequest.setBillerInstructionId(params.billerInstructionId.toLong());
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getBillerInstructionDetails(billerDetailsRequest);
		model << [InstructionDetailsModel:billerDetailsResponse]
	}
	
		
	def updateBillerInstructionStatus(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerRequest updateBillerRequest = getBean(BillerRequest.class,requestHeader,params);
		updateBillerRequest.setBillerInstructionId(params.billerInstructionId);
		updateBillerRequest.setStatus(params.status);
				
		if(params.billerId!="" & !params.billerId.equals(null)){
			updateBillerRequest.setBillerId(params.billerId+","+0);
		}		
		if(params.billerServiceId!="" & !params.billerServiceId.equals(null)){
			updateBillerRequest.setBillerServiceId(params.billerServiceId+","+0);
		}
		
		updateBillerRequest.setUserLoginProfileId(getUserLoginProfile().getId().toString());
		updateBillerRequest.setOperationFlag("D");
		
		updateBillerRequest.setCifNumber(invoker.getPrimaryCIF());
		
		BillerResponse updateBillerResponse = bmClient.billerService.deleteBillerInstruction(updateBillerRequest);
		model << [BillerDetailsModel:updateBillerResponse]
	}
	
	def updateBillerStatus(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerRequest updateBillerRequest = getBean(BillerRequest.class,requestHeader,params);		
		updateBillerRequest.setBillerId(params.billerId);
		updateBillerRequest.setStatus(params.status);
		BillerResponse updateBillerResponse = bmClient.billerService.updateBillerStatus(updateBillerRequest);
		model << [BillerDetailsModel:updateBillerRespone]
	}
	
	def addInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,requestHeader,params);
		Long billerId;
		Long parentBillerId;
		billerId = params.billerId.toLong();
		billerDetailsRequest.setBillerId(billerId);
		billerDetailsRequest.setParentBillerId(billerId);
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getBillerServices(billerDetailsRequest);
		model << [BillerDetailsModel:billerDetailsResponse] 
	}	
	
	
	def getautopayfields(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		String autoPayFlag;
		autoPayFlag = params.autopayType.toString();
		model << [AutoPayModel:autoPayFlag] 
	}
	
	def validateBillerInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerRequestCommand billerRequestCommand = validateCommandObject(BillerRequestCommand.class,params);
		if(!billerRequestCommand.hasErrors()){
			BillerRequest billerRequest = getBean(BillerRequest.class,requestHeader,params);		
			billerRequest.effectiveFromDate=DateUtils.convertStringToDate(params.effectiveFromDateparam, DateUtils.YYYY_MM_DD)
			billerRequest.effectiveToDate=DateUtils.convertStringToDate(params.effectiveToDateparam, DateUtils.YYYY_MM_DD)
			billerRequest.setReferenceTag("" + new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()))
			billerRequest.setButtonEvent(params.buttonEvent);
			billerRequest.setOperationFlag("A");			
			billerRequest.setCifNumber(invoker.getPrimaryCIF());			
			
			String autoPayOption = "";
			autoPayOption = params.autoPayOption.toString();
			
			if(autoPayOption!="" & autoPayOption.equals("Y")){
				autoPayOption = params.autoPay.toString()
				billerRequest.setSelectedAutoPayFlag(autoPayOption);
			}else{
				billerRequest.setSelectedAutoPayFlag("N");
			}
			if(params.billerId!="" & !params.billerId.equals(null)){
				billerRequest.setBillerId(params.billerId);
			}else{
				billerRequest.setBillerId(params.parentBillerId);
			}
			
			def billerCategoryId	= params.billerCategoryId;
			def billerCategoryDes,billerShortName,billerServiceCode,billerMetaData,billerMetaDataDes
			def debitAcc,fromDate,toDate,transferCurrency			
			def autoPay				= billerRequest.getSelectedAutoPayFlag();
			def maximumAmount		= billerRequest.getMaximumAmount();
			def transferCurencyId	= billerRequest.getCurrencyId();
			
			if(autoPay!="N"){
				com.vayana.bm.core.api.model.common.Currency transferCurrencyObj=commonService.getCurrency(transferCurencyId)
				transferCurrency=transferCurrencyObj?.code
				
				Date fdate = Date.parse("yyyy-MM-dd",params.effectiveFromDateparam)
				fromDate = fdate.format("dd-MMM-yyyy")
				
				Date tdate = Date.parse("yyyy-MM-dd",params.effectiveToDateparam)
				toDate = tdate.format("dd-MMM-yyyy")
			}
			
			def Map<String,String> billerMetaDataMap=new HashMap<String, String>();
			
			
			com.vayana.ib.bm.core.api.model.payment.BillerService billerServiceobj=(com.vayana.ib.bm.core.api.model.payment.BillerService)commonService.getBillerService(billerRequest.getBillerServiceId())  
			billerServiceCode=billerServiceobj.code
			billerShortName=billerServiceobj.biller.shortName
			billerCategoryId=billerServiceobj.billerBusinessCategory.description
			
			billerMetaData=billerServiceobj.billerMetaData.dataLabel.code 
			//billerMetaDataDes=billerServiceobj.billerMetaData.dataLabelDescription
			
			for(metaValue in billerMetaData){				
				billerMetaDataMap.put(metaValue, params?.get(metaValue))
			}			
			
			if(billerRequest.getAccountId()!="" & !billerRequest.getAccountId().equals(null)){
				com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction userAccountobj=commonService.getUserAccount(billerRequest.getAccountId());
				debitAcc=userAccountobj.account.accountNumber
			}
			
			def Map<String,String> postProcessModel=new HashMap<String, String>();
			
			postProcessModel.put("billerCategoryDes", billerCategoryId)		
			postProcessModel.put("billerName", billerShortName)
			postProcessModel.put("billerServiceDes", billerServiceCode)
			postProcessModel.put("billerNickName", billerRequest.getShortName())
			postProcessModel.put("autoPayFlag", params.autoPayOption.toString())
			postProcessModel.put("autoPay", autoPay)
			postProcessModel.put("fromDate", fromDate)
			postProcessModel.put("toDate", toDate)
			postProcessModel.put("debitAcc", debitAcc)		
			postProcessModel.put("maximumAmount", maximumAmount)
			postProcessModel.put("transferCurrency", transferCurrency)
			postProcessModel.put("cancelAction","addBiller")
			
			BillerResponse validateBillerResponse = null;
			BillerResponse validateBillInquiry = null;
			
			validateBillInquiry = bmClient.billerService.validateBillerNumber(billerRequest);
			if(validateBillInquiry.hasErrors()){
				model<<[errors:validateBillInquiry.errors()]
			}
			
			validateBillerResponse = bmClient.billerService.validateBillerDetails(billerRequest);
			if(!validateBillerResponse.hasErrors()){
				setSessionAttribute("BIR", billerRequest);
			}
			model << [postProcessModel:postProcessModel,postProcessMetaModel:billerMetaDataMap]
		}else{
			model << [errors:billerRequestCommand.errors];
		}
	}
	
	def saveAndPayBillerInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerRequestCommand billerRequestCommand = validateCommandObject(BillerRequestCommand.class,params);
		if(!billerRequestCommand.hasErrors()){
			BillerRequest billerRequest = getBean(BillerRequest.class,requestHeader,params);
			billerRequest.setReferenceTag("" + new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()))
			billerRequest.setSelectedAutoPayFlag("N");
			billerRequest.setButtonEvent(params.buttonEvent);
			billerRequest.setOperationFlag("A");
			if(params.billerId!="" & !params.billerId.equals(null)){
				billerRequest.setBillerId(params.billerId);
			}else{
				billerRequest.setBillerId(params.parentBillerId);
			}
			
			billerRequest.setCifNumber(invoker.getPrimaryCIF());
			
			//Check BillerInstruction exists
			if(!QuickPayButtonEnum.PAY.toString().equals(billerRequest.getButtonEvent())){
				BillerResponse validateBillerResponse = bmClient.billerService.validateBillerDetails(billerRequest);
			}
			//Save Biller Details
			BillerResponse billerResponse = bmClient.billerService.quickPaySaveBiller(billerRequest);
			if(billerResponse.hasErrors()){
				model << [errors:billerResponse.errors]
			}else{
				def billerId = billerResponse.billerInstruction.biller.id
				def billerInsId = billerResponse.billerInstruction.id+','+billerResponse.billerInstruction.version
				setSessionAttribute("BILLERID", billerId);
				setSessionAttribute("BILLERINSID", billerInsId);
				setSessionAttribute("BUTTONEVENT", params.buttonEvent);
				model<<[billerId:billerId]
			}
		}else{
			model << [errors:billerRequestCommand.errors];
		}
	}
	
	def saveAndPaySuccess(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		def billerId = getSessionAttribute("BILLERID")
		def billerInsId = getSessionAttribute("BILLERINSID")
		def buttonEvent = getSessionAttribute("BUTTONEVENT")
		session.removeAttribute("BILLERID")
		session.removeAttribute("BILLERINSID")
		session.removeAttribute("BUTTONEVENT")
		
		FavouritePaymentDetailRequest favouritePaymentDetailRequest=getBean(FavouritePaymentDetailRequest.class, requestHeader, params);
		favouritePaymentDetailRequest.setBeneId(billerId)
		FavouritePaymentDetailResponse favouritePaymentDetailResponse=bmClient.billPaymentService.getFavouriteBillPayments(favouritePaymentDetailRequest);
		favouritePaymentDetailResponse.acctBalancePaymentDetail=null;
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, null);
		CommonResponse commonResponse=null;
		commonResponse=bmClient.iBCommonService.fetchBaseCurrency(commonRequest)
		com.vayana.bm.core.api.model.common.Currency baseCurrencyObj=commonResponse.getCommonEntity()
		
		//,billerNickName:billerNickName
		model<<[billerId:billerId,billerInsId:billerInsId,buttonEvent:buttonEvent,favPaymentDetailModel:favouritePaymentDetailResponse,baseCurrencyModel:baseCurrencyObj,isQuickPay:true]
	} 
	
	def addBillerConfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{		
		BillerRequest addBillerRequest = getSessionAttribute("BIR");												
		BillerResponse addBillerResponse = bmClient.billerService.addBillerInstruction(addBillerRequest);
		
		if(addBillerResponse.hasErrors()){
			model << [errors:addBillerResponse.errors]
		}else{
			  session.removeAttribute("BIR")
			  model << [BillerDetailsModel:addBillerResponse]
		}
		
	}
	
	def validateWithinBillerInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerRequest billerRequest = getBean(BillerRequest.class,requestHeader,params);		
		billerRequest.effectiveFromDate=DateUtils.convertStringToDate(params.effectiveFromDateparam, DateUtils.YYYY_MM_DD)
		billerRequest.effectiveToDate=DateUtils.convertStringToDate(params.effectiveToDateparam, DateUtils.YYYY_MM_DD)
		billerRequest.setReferenceTag("" + new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()))
		billerRequest.buttonEvent	=	QuickPayButtonEnum.SAVE		
		billerRequest.setOperationFlag("A");
		
		billerRequest.setCifNumber(invoker.getPrimaryCIF());
		
		String autoPayOption = "";
		autoPayOption = params.autoPayOption.toString(); 
		
		if(autoPayOption!="" & autoPayOption.equals("Y")){
			autoPayOption = params.autoPay.toString()
			billerRequest.setSelectedAutoPayFlag(autoPayOption);
		}else{
			billerRequest.setSelectedAutoPayFlag("N");
		}
		if(params.billerId!="" & !params.billerId.equals(null)){
			billerRequest.setBillerId(params.billerId);
		}else{
			billerRequest.setBillerId(params.parentBillerId);
		}
		
			def billerCategoryId	= params.billerCategoryId;
			def billerCategoryDes,billerId,billerShortName,billerServiceCode,billerMetaData,billerMetaDataDes
			def debitAcc,fromDate,toDate,transferCurrency			
			def autoPay				= billerRequest.getSelectedAutoPayFlag();
			def maximumAmount		= billerRequest.getMaximumAmount();
			def transferCurencyId	= billerRequest.getCurrencyId();
			
			if(autoPay!="N"){
				com.vayana.bm.core.api.model.common.Currency transferCurrencyObj=commonService.getCurrency(transferCurencyId)
				transferCurrency=transferCurrencyObj?.code
				
				Date fdate = Date.parse("yyyy-MM-dd",params.effectiveFromDateparam)
				fromDate = fdate.format("dd-MMM-yyyy")
				
				Date tdate = Date.parse("yyyy-MM-dd",params.effectiveToDateparam)
				toDate = tdate.format("dd-MMM-yyyy")
			}
			
			def Map<String,String> billerMetaDataMap=new HashMap<String, String>();
			
			
			com.vayana.ib.bm.core.api.model.payment.BillerService billerServiceobj=(com.vayana.ib.bm.core.api.model.payment.BillerService)commonService.getBillerService(billerRequest.getBillerServiceId())  
			billerServiceCode=billerServiceobj.code
			billerId=billerServiceobj.biller.id
			billerShortName=billerServiceobj.biller.shortName
			billerCategoryId=billerServiceobj.billerBusinessCategory.description
			
			billerMetaData=billerServiceobj.billerMetaData.dataLabel.code
			//billerMetaDataDes=billerServiceobj.billerMetaData.dataLabelDescription
			
			for(metaValue in billerMetaData){				
				billerMetaDataMap.put(metaValue, params?.get(metaValue))
			}			
			
			if(billerRequest.getAccountId()!="" & !billerRequest.getAccountId().equals(null)){
				com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction userAccountobj=commonService.getUserAccount(billerRequest.getAccountId());
				debitAcc=userAccountobj.account.accountNumber
			}
			def Map<String,String> postProcessModel=new HashMap<String, String>();
			
			postProcessModel.put("billerCategoryDes", billerCategoryId)	
			postProcessModel.put("billerId", billerId)
			postProcessModel.put("billerName", billerShortName)
			postProcessModel.put("billerServiceDes", billerServiceCode)
			postProcessModel.put("billerNickName", billerRequest.getShortName())
			postProcessModel.put("autoPayFlag", params.autoPayOption.toString())
			postProcessModel.put("autoPay", autoPay)
			postProcessModel.put("fromDate", fromDate)
			postProcessModel.put("toDate", toDate)
			postProcessModel.put("debitAcc", debitAcc)
			postProcessModel.put("maximumAmount", maximumAmount)
			postProcessModel.put("transferCurrency", transferCurrency)
			postProcessModel.put("cancelAction","addInstruction")
		
			BillerResponse validateBillerResponse = null;
			BillerResponse validateBillInquiry = null;
			
			validateBillInquiry = bmClient.billerService.validateBillerNumber(billerRequest);
			if(validateBillInquiry.hasErrors()){
				model<<[errors:validateBillInquiry.errors()]
			}
			
			validateBillerResponse = bmClient.billerService.validateBillerDetails(billerRequest);
			if(!validateBillerResponse.hasErrors()){
				setSessionAttribute("BIR", billerRequest);
			}
		model << [postProcessModel:postProcessModel,postProcessMetaModel:billerMetaDataMap]
	}
	
	def addWithinBillerConfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		
		BillerRequest addBillerRequest = getSessionAttribute("BIR");
		String responseMessage  =  DEFAULT_CREATED_MESSAGE;												
		BillerResponse addBillerResponse = bmClient.billerService.addBillerInstruction(addBillerRequest);
				
		if(addBillerResponse.hasErrors()){
			model << [errors:addBillerResponse.errors]
		}else{
			  session.removeAttribute("BIR")
			  setMessage(responseMessage, ["Biller details "," Successfully"], model);
			  model << [BillerDetailsModel:addBillerResponse]
		}
		
	}
	
	def validateeditBillerInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerRequest updateBillerRequest = getBean(BillerRequest.class,requestHeader,params);
		updateBillerRequest.effectiveFromDate=DateUtils.convertStringToDate(params.effectiveFromDateparam, DateUtils.YYYY_MM_DD)
		updateBillerRequest.effectiveToDate=DateUtils.convertStringToDate(params.effectiveToDateparam, DateUtils.YYYY_MM_DD)
		updateBillerRequest.setReferenceTag("" + new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()))
		updateBillerRequest.setAutopayFlag(params.hautopayFlag)
		
		updateBillerRequest.setOperationFlag("U");
		
		updateBillerRequest.setCifNumber(invoker.getPrimaryCIF());
		
		String autoPayOption = "";
		autoPayOption = params.autoPayOption.toString();
		
		if(autoPayOption!="" & autoPayOption.equals("Y")){
			autoPayOption = params.autoPay.toString()
			updateBillerRequest.setSelectedAutoPayFlag(autoPayOption);
		}else{
			updateBillerRequest.setSelectedAutoPayFlag("N");
		}
		
		if(params.billerId!="" & !params.billerId.equals(null)){
			updateBillerRequest.setBillerId(params.billerId+","+0);
		}
		
		if(params.billerServiceId!="" & !params.billerServiceId.equals(null)){
			updateBillerRequest.setBillerServiceId(params.billerServiceId+","+0);
		}
		
		updateBillerRequest.setBillerInstructionId(params.billerInstructionId);
		
		def billerMetaData,billerMetaDataDes
		def debitAcc,fromDate,toDate,transferCurrency
		def autoPay				= updateBillerRequest.getSelectedAutoPayFlag();
		def maximumAmount		= updateBillerRequest.getMaximumAmount();
		def transferCurencyId	= updateBillerRequest.getCurrencyId();
		
		if(autoPay!="N"){
			com.vayana.bm.core.api.model.common.Currency transferCurrencyObj=commonService.getCurrency(transferCurencyId)
			transferCurrency=transferCurrencyObj?.code
			
			Date fdate = Date.parse("yyyy-MM-dd",params.effectiveFromDateparam)
			fromDate = fdate.format("dd-MMM-yyyy")
			
			Date tdate = Date.parse("yyyy-MM-dd",params.effectiveToDateparam)
			toDate = tdate.format("dd-MMM-yyyy")
		}
		
		def Map<String,String> billerMetaDataMap=new HashMap<String, String>();
		
		com.vayana.ib.bm.core.api.model.payment.BillerService billerServiceobj=(com.vayana.ib.bm.core.api.model.payment.BillerService)commonService.getBillerService(updateBillerRequest.getBillerServiceId())
		billerMetaData=billerServiceobj.billerMetaData.dataLabel.code
		//billerMetaDataDes=billerServiceobj.billerMetaData.dataLabelDescription
		
		for(metaValue in billerMetaData){
			println params?.get(metaValue)
			billerMetaDataMap.put(metaValue, params?.get(metaValue))
		}
		
		if(updateBillerRequest.getAccountId()!="" & !updateBillerRequest.getAccountId().equals(null)){
			com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction userAccountobj=commonService.getUserAccount(updateBillerRequest.getAccountId());
			debitAcc=userAccountobj.account.accountNumber
		}
		
		def Map<String,String> postProcessModel=new HashMap<String, String>();
		postProcessModel.put("billerInstructionId", updateBillerRequest.getBillerInstructionId())
		postProcessModel.put("autoPayFlag", params.autoPayOption.toString())
		postProcessModel.put("autoPay", autoPay)
		postProcessModel.put("fromDate", fromDate)
		postProcessModel.put("toDate", toDate)
		postProcessModel.put("debitAcc", debitAcc)
		postProcessModel.put("maximumAmount", maximumAmount)
		postProcessModel.put("transferCurrency", transferCurrency)
		postProcessModel.put("shortName", params.shortName)
		
		setSessionAttribute("BIR", updateBillerRequest);
		model << [postProcessModel:postProcessModel,postProcessMetaModel:billerMetaDataMap]
	}
	
	def updateBillerConfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerRequest updateBillerRequest = getSessionAttribute("BIR");		
		String responseMessage  =  DEFAULT_UPDATED_MESSAGE;
		BillerResponse updateBillerResponse = bmClient.billerService.updateBillerInstruction(updateBillerRequest);
		
		if(updateBillerResponse.hasErrors()){
			model << [errors:updateBillerResponse.errors]
		}else{
			  session.removeAttribute("BIR")
			  setMessage(responseMessage, ["Biller details "," Successfully"], model);
			 model << [BillerDetailsModel:updateBillerResponse]
		}
	}
	
}

class BillerRequestCommand{
	String billerCategoryId,parentBillerId,billerServiceId,shortName;
	static constraints = {
		billerCategoryId(blank:false)
		parentBillerId(blank:false)
		billerServiceId(blank:false)
		shortName(blank:false,shared : 'shortNameConstraint')
	}
}
