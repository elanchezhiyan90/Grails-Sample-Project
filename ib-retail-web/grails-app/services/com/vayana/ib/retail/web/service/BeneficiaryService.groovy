package com.vayana.ib.retail.web.service
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.PageRequest
import org.springframework.social.facebook.api.FacebookProfile
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils

import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.ContextCodeType
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.constants.BusinessFunctionConstants;
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants
import com.vayana.bm.core.api.model.common.LookupValue
import com.vayana.bm.core.api.model.infra.Service
import com.vayana.ib.bm.admin.core.api.beans.Limit.LimitDefinitionDetailRequest
import com.vayana.ib.bm.admin.core.api.beans.Limit.LimitDefinitionDetailResponse
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailsRequest
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailsResponse
import com.vayana.ib.bm.core.api.beans.beneficiary.BeneficiaryInstructionRequest
import com.vayana.ib.bm.core.api.beans.beneficiary.BeneficiaryInstructionResponse
import com.vayana.ib.bm.core.api.beans.beneficiary.BeneficiaryRequest
import com.vayana.ib.bm.core.api.beans.beneficiary.BeneficiaryResponse
import com.vayana.ib.bm.core.api.beans.beneficiary.PayeeBankRequest
import com.vayana.ib.bm.core.api.beans.beneficiary.PayeeBankResponse
import com.vayana.ib.bm.core.api.beans.beneficiary.QuickPayRequest
import com.vayana.ib.bm.core.api.beans.beneficiary.QuickPayResponse
import com.vayana.ib.bm.core.api.beans.beneficiary.TransactionTypeRequest
import com.vayana.ib.bm.core.api.beans.beneficiary.TransactionTypeResponse
import com.vayana.ib.bm.core.api.beans.common.IBCommonRequest
import com.vayana.ib.bm.core.api.beans.common.IBCommonResponse
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardDetailRequest
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardDetailResponse
import com.vayana.ib.bm.core.api.beans.transfers.PaymentTransferRequest
import com.vayana.ib.bm.core.api.beans.transfers.PaymentTransferResponse
import com.vayana.ib.bm.core.api.model.account.Account
import com.vayana.ib.bm.core.api.model.beneficiary.Beneficiary
import com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction
import com.vayana.ib.bm.core.api.model.beneficiary.BeneficiarySocialNetwork
import com.vayana.ib.bm.core.api.model.common.TenantBranch
import com.vayana.ib.bm.core.api.model.enums.PayeeBankTypeEnum
import com.vayana.ib.bm.core.api.model.enums.QuickPayButtonEnum
import com.vayana.ib.bm.core.api.model.payment.DomesticBank
import com.vayana.ib.bm.core.api.model.payment.ForeignBank
import com.vayana.ib.bm.core.api.model.payment.LimitDefinition
import com.vayana.ib.bm.core.api.model.payment.LimitDefinitionDetail
import com.vayana.ib.bm.core.api.model.payment.PayeeBankBranch
import com.vayana.ib.bm.core.impl.service.util.BankBranchUtil
import com.vayana.ib.bm.core.impl.service.util.BaseCommonUtil
import com.vayana.ib.bm.core.impl.service.util.EncryptionUtil
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class BeneficiaryService extends GenericService{

	BmClient bmClient;
	CommonService commonService
	
	@Autowired
	BaseCommonUtil baseCommonUtil;
	
	@Autowired
	EncryptionUtil encryptionUtil;
	
	@Autowired
	BankBranchUtil bankBranchUtil;
	

	def getBeneficiaryDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException {
		BeneficiaryRequest beneficiaryRequest = getBean(BeneficiaryRequest.class, requestHeader,params)
		BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.getBeneficiary(beneficiaryRequest)
		model << [beneficiary:beneficiaryResponse.getBeneficiary()]
	}
	
	def validateAddMaxBene(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException {
		BeneficiaryInstructionRequest beneficiaryInsRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,null)
		BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.getMaxAddBeneficiaryLimit(beneficiaryInsRequest);
		//model << [beneficiary:beneficiaryResponse.getBeneficiary()]
	}
	
	
	//Quick Pay Start
	def loadQuickPay(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
	}
	
	def searchBankCodeDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		PayeeBankRequest request = getBean(PayeeBankRequest.class, requestHeader , params)
		def pageNumber = (StringUtils.hasText(params?.gotoPage))? params?.int('gotoPage') : 0;
		PageRequest page = new PageRequest(pageNumber, 15);
		request.setPageRequest(page);
		def filterValues = []
		request.setPayeeBankType(PayeeBankTypeEnum.valueOf(params.bankType))
		request.setPaymentType(params?.payType)   
		filterValues.add((params.getbankCode)?(params.getbankCode):"")
		filterValues.add((params.getbankName)?(params.getbankName):"")
		filterValues.add((params.getbranchName)?(params.getbranchName):"")
		request.setFilterValues(filterValues)
		PayeeBankResponse response = bmClient.beneficiaryService.fetchBankDetails(request);
		def banks = [];
		if("DOMESTIC".equals(params.bankType)){
			banks = (List<DomesticBank>) response.getPayeeBank();
		}else if("FOREIGN".equals(params.bankType)){
			banks = (List<ForeignBank>) response.getPayeeBank();
		}else if("TENANT".equals(params.bankType)){
			banks = (List<TenantBranch>) response.getPayeeBank();
		}
		model<<[banks:banks,bankType:params.bankType,pagerModel:response.getPage()]
	}

	def validateAccountNumber(Map params,GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		
		CasaAccountDetailsRequest casaRequest = getBean(CasaAccountDetailsRequest.class,requestHeader,params);
		casaRequest.setCustomerId(invoker.getPrimaryCIF());
		casaRequest.setAccountNumber(params.accountId);
		CasaAccountDetailsResponse casaReponse = bmClient.accountService.validateCasaAccount(casaRequest);
		BeneficiaryInstruction beneficiaryInstruction=new BeneficiaryInstruction();
		beneficiaryInstruction.setShortName(casaReponse.getAccountDetail().customerName);
		//beneficiaryInstruction.setAccountType(casaReponse.getAccountDetail().accountType);
		beneficiaryInstruction.setCurrency(casaReponse.getAccountDetail().currency);
		model << [beneficiaryInstruction:beneficiaryInstruction]
		
	}
	
	def validateCreditCardNumber(Map params,GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
	CreditCardDetailRequest ccRequest = getBean(CreditCardDetailRequest.class,requestHeader,params);
	ccRequest.setCreditCardNumber(encryptionUtil.encryptUsing3DES(params.creditcardNo));
	CreditCardDetailResponse ccReponse = bmClient.creditCardService.validateCreditCard(ccRequest);
	BeneficiaryInstruction beneficiaryInstruction=new BeneficiaryInstruction();
	beneficiaryInstruction.setShortName(ccReponse.getCreditCardAccount().getNameOnCard());
	beneficiaryInstruction.setCurrency(ccReponse.getCreditCardAccount().getCurrency());                             
	model << [beneficiaryInstruction:beneficiaryInstruction]
	}
	
	def saveAndPay(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		QuickPayCommand quickPayCmd = validateCommandObject(QuickPayCommand.class,params)
		if(!quickPayCmd.hasErrors()) {
			QuickPayRequest request = prepareQuickPayRequest(params, requestHeader);
			request.buttonEvent	=	QuickPayButtonEnum.SAVEANDPAY  
			QuickPayResponse response = bmClient.beneficiaryService.quickPay(request);
//			if (response.hasErrors()){
//				model << [errors:response.errors()]
//				return;
//			}else{
				def beneId = response.beneficiary.id
				setSessionAttribute("BENEID", beneId);
				model<<[beneId:beneId]    
//			}
		}else{
			model << [errors:quickPayCmd];
		}
	}
	def saveAndPaySuccess(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		def beneId = getSessionAttribute("BENEID")
		session.removeAttribute("BENEID")
		model<<[beneId:beneId]
	} 
	def paySuccess(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		def beneId = getSessionAttribute("BENEID")
		def beneShortName = getSessionAttribute("BENESHORTNAME")
		session.removeAttribute("BENEID")
		session.removeAttribute("BENESHORTNAME")
		model<<[beneId:beneId,isQuickPay:true,beneShortName:beneShortName]
	}   
	/**
	 * @author elanchezhiyan
	 * @param params
	 * @param requestHeader
	 * @return
	 */
	def prepareQuickPayRequest(Map params,GenericRequestHeader requestHeader){
		QuickPayRequest quickPayReq = getBean(QuickPayRequest.class,requestHeader,params);
		quickPayReq.beneficiaryType = params.beneficiaryType;
		quickPayReq.beneficiaryName = params.beneficiaryName
		quickPayReq.beneNickName = params.nickName
		quickPayReq.accountNumber = params.acctNumber
		quickPayReq.confirmAccountNumber = params.cnfmAcctNumber
		if(params?.curremcyIdVersion)
		{
			quickPayReq.currencyIdVersion = params.currencyIdVersion
		}
		else
		{
			quickPayReq.currencyIdVersion  = baseCommonUtil.getCurrencyByCode("INR").getIdVersion();
		}
		
		
		// Set Bank Branch Details
	    setBankBranchForQuickPay(quickPayReq);
		
		return quickPayReq;
	}
	def pay(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException {
		QuickPayCommand quickPayCmd = validateCommandObject(QuickPayCommand.class,params)
		if(!quickPayCmd.hasErrors()) {
			QuickPayRequest request = prepareQuickPayRequest(params, requestHeader);
			request.buttonEvent	=	QuickPayButtonEnum.PAY
			BeneficiaryInstructionRequest benInstRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,null);
			benInstRequest.setAccountNumberConfirm(request.getConfirmAccountNumber());
			checkIfOwnAccount(benInstRequest);
			QuickPayResponse response = bmClient.beneficiaryService.quickPay(request);
			def beneId = response.beneficiary.id
			def beneShortName = response.beneficiary.shortName
			setSessionAttribute("BENEID", beneId);
			setSessionAttribute("BENESHORTNAME", beneShortName);
			model<<[beneId:beneId]
		}else{
			model << [errors:quickPayCmd];
		}
	}
	//Quick Pay End
	def editBeneficiary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException {
		BeneficiaryRequest beneficiaryRequest = getBean(BeneficiaryRequest.class, requestHeader,params)
		BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.getBeneficiary(beneficiaryRequest)
		model << [beneficiary:beneficiaryResponse.getBeneficiary()]
	}

	def addBeneficiary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		FacebookProfile facebookProfile=(FacebookProfile)session.getAttribute("FBPROFILE")
		session.removeAttribute("FBPROFILE")
		Beneficiary beneficiary=new Beneficiary()
		if(facebookProfile) {
			beneficiary.shortName=facebookProfile.getFirstName()+" "+facebookProfile.getLastName()
			beneficiary.emailAddress1=facebookProfile.getEmail()
			List<BeneficiarySocialNetwork> beneficiarySocialNetworks=new ArrayList<BeneficiarySocialNetwork>(1)
			BeneficiarySocialNetwork beneficiarySocialNetwork=new BeneficiarySocialNetwork();
			LookupValue lookupValue=new LookupValue()
			lookupValue.setCode("FB")
			beneficiarySocialNetwork.setSocialNetwork(lookupValue)
			beneficiarySocialNetwork.setSocialNetworkLogin(facebookProfile.getUsername())
			beneficiarySocialNetwork.setId(Long.parseLong(facebookProfile.getId()))
			beneficiarySocialNetworks.add(beneficiarySocialNetwork)
			beneficiary.setBeneficiarysocilaNetwork(beneficiarySocialNetworks)
		}
		BeneficiaryRequest beneficiaryRequest = getBean(BeneficiaryRequest.class, requestHeader, params);
		BeneficiaryInstructionRequest beneficiaryInstructionRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,params)
		beneficiaryRequest.setBeneficiaryCode(beneficiaryRequest.FRIENDS_AND_FAMILY);
		beneficiaryRequest.setBeneStatus("INA");
		BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.validateAddBeneMaxLimit(beneficiaryInstructionRequest)
		if (beneficiaryInstructionResponse.hasErrors()){
			model << [errors:beneficiaryInstructionResponse.errors()]
			return;
		}
		BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.getBeneficiaries(beneficiaryRequest)
		if (beneficiaryResponse.hasErrors()){
			model << [errors:beneficiaryResponse.errors()]
			return;
		}else if(facebookProfile){

			model << [friendsFamilyModel:beneficiaryResponse,beneficiary:beneficiary]
		}else{
			model << [friendsFamilyModel:beneficiaryResponse,beneMaxExceeded :beneficiaryInstructionResponse.beneMaxFlag]
		}
		
		
	}
	
	
	/**
	 * For PMCB This method added.
	 */
	def addBeneMain(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		FacebookProfile facebookProfile=(FacebookProfile)session.getAttribute("FBPROFILE")
		session.removeAttribute("FBPROFILE")
		Beneficiary beneficiary=new Beneficiary()
		if(facebookProfile) {
			beneficiary.shortName=facebookProfile.getFirstName()+" "+facebookProfile.getLastName()
			beneficiary.emailAddress1=facebookProfile.getEmail()
			List<BeneficiarySocialNetwork> beneficiarySocialNetworks=new ArrayList<BeneficiarySocialNetwork>(1)
			BeneficiarySocialNetwork beneficiarySocialNetwork=new BeneficiarySocialNetwork();
			LookupValue lookupValue=new LookupValue()
			lookupValue.setCode("FB")
			beneficiarySocialNetwork.setSocialNetwork(lookupValue)
			beneficiarySocialNetwork.setSocialNetworkLogin(facebookProfile.getUsername())
			beneficiarySocialNetwork.setId(Long.parseLong(facebookProfile.getId()))
			beneficiarySocialNetworks.add(beneficiarySocialNetwork)
			beneficiary.setBeneficiarysocilaNetwork(beneficiarySocialNetworks)
		}
		BeneficiaryRequest beneficiaryRequest = getBean(BeneficiaryRequest.class, requestHeader, params);
		BeneficiaryInstructionRequest beneficiaryInstructionRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,params)
		beneficiaryRequest.setBeneficiaryCode(beneficiaryRequest.FRIENDS_AND_FAMILY);
		beneficiaryRequest.setBeneStatus("INA");
		BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.validateAddBeneMaxLimit(beneficiaryInstructionRequest)
		if (beneficiaryInstructionResponse.hasErrors()){
			model << [errors:beneficiaryInstructionResponse.errors()]
			return;
		}
		BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.getBeneficiaries(beneficiaryRequest)
		if (beneficiaryResponse.hasErrors()){
			model << [errors:beneficiaryResponse.errors()]
			return;
		}else if(facebookProfile){

			model << [friendsFamilyModel:beneficiaryResponse,beneficiary:beneficiary]
		}else{
			model << [friendsFamilyModel:beneficiaryResponse,beneMaxExceeded :beneficiaryInstructionResponse.beneMaxFlag]
		}
	}
	
	

	def searchBankDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		PayeeBankRequest request = getBean(PayeeBankRequest.class, requestHeader , params)
		PayeeBankResponse response
		List<Object> filterParams = new ArrayList<Object>();
		request.setPayeeBankType(PayeeBankTypeEnum.valueOf(params.bankType))
		filterParams.add((params.getbankCode)?(params.getbankCode):"")
		filterParams.add((params.getbankName)?(params.getbankName):"")
		filterParams.add((params.getbranchName)?(params.getbranchName):"")
		request.setFilterParams(filterParams);
		response = bmClient.beneficiaryService.getPayeeBankDetails(request)
		List<PayeeBankBranch> banks = (List<PayeeBankBranch>) response.getPayeeBank();
		model <<[banks:banks,bankType:params.bankType]
	}
	
	def updateBeneficiary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BeneficiaryCommand beneficiaryCommand = validateCommandObject(BeneficiaryCommand.class,params);
		if(!beneficiaryCommand.hasErrors()) {
			BeneficiaryRequest beneficiaryRequest = getBean(BeneficiaryRequest.class, requestHeader,params)
			BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.updateBeneficiary(beneficiaryRequest)
			params.beneficiaryId=beneficiaryResponse.getBeneficiary().getId();
			params.beneficiaryVersion=beneficiaryResponse.getBeneficiary().getVersion();
			model << [beneficiary:beneficiaryResponse.getBeneficiary()]
		}
		else {
			model << [errors:beneficiaryCommand];
		}
	}

	def insertBeneficiary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BeneficiaryCommand beneficiaryCommand = validateCommandObject(BeneficiaryCommand.class,params);
		if(!beneficiaryCommand.hasErrors()) {
			BeneficiaryRequest beneficiaryRequest = getBean(BeneficiaryRequest.class, requestHeader,params)
			BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.insertBeneficiary(beneficiaryRequest)
			params.beneficiaryId=beneficiaryResponse.getBeneficiary().getId();
			params.beneficiaryVersion=beneficiaryResponse.getBeneficiary().getVersion();
			model << [beneficiary:beneficiaryResponse.getBeneficiary(),params:params]
		}
		else {
			model << [errors:beneficiaryCommand];
		}
	}

	def assignBeneInstruction(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException {
		BeneficiaryCommand beneficiaryCommand = validateCommandObject(BeneficiaryCommand.class,params);
		if(!beneficiaryCommand.hasErrors()) {
			BeneficiaryRequest beneficiaryRequest = getBean(BeneficiaryRequest.class, requestHeader,params)
			BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.convertBeneRequestToDomain(beneficiaryRequest)
			model << [beneficiary:beneficiaryResponse.getBeneficiary()]
		}
		else {
			model << [errors:beneficiaryCommand];
		}
	}

	def editBeneficiaryInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException {
		BeneficiaryInstructionRequest beneficiaryInsRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,null)
		beneficiaryInsRequest.setBeneficiaryInstructionId(params.beneficiaryInstructionId);
		beneficiaryInsRequest.setProcessInstanceId(params.processInstanceId);
		beneficiaryInsRequest.setRecordStatus(params.recordStatus);
		BeneficiaryInstructionResponse beneficiaryInsResponse = bmClient.beneficiaryService.getBeneficiaryInstructionById(beneficiaryInsRequest);
		model << [beneficiaryInstruction:beneficiaryInsResponse.getBeneficiaryInstruction(),beneInsRespone:beneficiaryInsResponse]		
		
	}
	
	def showBeneInsDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		BeneficiaryInstructionResponse beneficiaryInsResponse =null
		BeneficiaryInstructionRequest beneficiaryInsRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,null)
		beneficiaryInsRequest.setBeneficiaryInstructionId(params.taskInstanceId);

		if ("BENE_INS".equals(params.transactionIdentifier)&& "IB".equals(params.dataSource)) {
			beneficiaryInsResponse	 = bmClient.beneficiaryService.getBeneficiaryInstructionById(beneficiaryInsRequest);
			model<<[resp:beneficiaryInsResponse]
			if(beneficiaryInsResponse.hasErrors()) {
				model<<[errors:beneficiaryInsResponse.errors()]
			}
		}
	}

	def addBeneficiaryInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException {
		TransactionTypeRequest request = getBean(TransactionTypeRequest.class, requestHeader,params);
		BeneficiaryInstructionRequest beneficiaryInstructionRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader, params);
		request.setTypeIdentifier("SUBMODULE");
		BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.validateAddBeneInsMaxLimit(beneficiaryInstructionRequest);
		if (beneficiaryInstructionResponse.hasErrors()){
			model << [errors:beneficiaryInstructionResponse.errors()]
			return;
		}
		TransactionTypeResponse response = bmClient.beneficiaryService.getTransactionTypes(request);
		
		model << [transactionTypes:response?.tenantServices?.serviceApplication?.service,params:params,beneMaxExceeded :beneficiaryInstructionResponse.beneMaxFlag]
		
		
	}
	

	
	def setBankBranch(BeneficiaryInstructionRequest benInstRequest)
	{
		String transactionSubType = benInstRequest.getTransactionSubTypeId();
		if(StringUtils.hasLength(transactionSubType))
		{
			IBCommonRequest ibCommonRequest = getBean(IBCommonRequest.class, null, null);
			String selectedServiceId = transactionSubType.split(",")[0];
			ibCommonRequest.setCommonEntityId(Long.parseLong(selectedServiceId));
			IBCommonResponse ibCommonResponse = bmClient.iBCommonService.getServiceDetailsByServiceId(ibCommonRequest);

			if(ibCommonResponse!=null)
			{
				Service serviceObj = ibCommonResponse.getCommonEntity();
				if(serviceObj.getCode().equalsIgnoreCase("TPTTRANS") ||serviceObj.getCode().equalsIgnoreCase("INTCC"))
				{
					PayeeBankBranch payeeBank = bankBranchUtil.getPayeeBankBranchByBranchCode("001"); //TO FIX
					benInstRequest.setPayeeBankBranchId(payeeBank.getId()+","+payeeBank.getVersion());
				}
			}
		}
	}
	
	def setBankBranchForQuickPay(QuickPayRequest quickPayReq)
	{
		String transactionSubType = quickPayReq.getBeneficiaryType();
		if(StringUtils.hasLength(transactionSubType))
		{
			IBCommonRequest ibCommonRequest = getBean(IBCommonRequest.class, null, null);
			String selectedServiceId = transactionSubType.split(",")[0];
			ibCommonRequest.setCommonEntityId(Long.parseLong(selectedServiceId));
			IBCommonResponse ibCommonResponse = bmClient.iBCommonService.getServiceDetailsByTenantServiceId(ibCommonRequest);

			if(ibCommonResponse!=null)
			{
				Service serviceObj = ibCommonResponse.getCommonEntity();
				if(serviceObj.getCode().equalsIgnoreCase("TPTTRANS") ||serviceObj.getCode().equalsIgnoreCase("INTCC"))
				{
					PayeeBankBranch payeeBank = bankBranchUtil.getPayeeBankBranchByBranchCode("001");
					quickPayReq.setPayeeBankBranchId(payeeBank.getIdVersion());
					quickPayReq.setBankBranchCode("001");
				}
			}
		}
	}
	
	def beneficiaryInstructionConfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException {
		BeneficiaryInstructionRequest benInstRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,params);
		//Commented accountType for KHCB not required    
		//getAccountTypeId(benInstRequest,params);
		
		// Set the Bank Branch id for Internal Beneficiary since this is not supplied from screen
		if(!StringUtils.hasText(params?.payeeBankBranchId)){    
			setBankBranch(benInstRequest);
		}
		BeneficiaryInstructionCommand beneficiaryInstructionCommand = validateCommandObject(BeneficiaryInstructionCommand.class,params);
		def transferCurrency =null;
		def limitCurrency = null;
		def accounttypeDisplay =null;
		BeneficiaryInstructionResponse uniqueConstraintCheck = null;
		if("true".equals(params.isDraftSubmission)) {

			uniqueConstraintCheck = bmClient.beneficiaryService.checkUniqueKeyForBeneficiaryInstruction(benInstRequest);
			updateBeneInstructionLimitVariables(benInstRequest, params);
			BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.insertBeneficiaryInstruction(benInstRequest)
			beneficiaryInstructionResponse = bmClient.beneficiaryService.listBeneficiaryInstructions(benInstRequest);
			model << [beneInsRespone:beneficiaryInstructionResponse]
		}else if(!beneficiaryInstructionCommand.hasErrors()) {

			if(params?.accountNumber){
				getValidAccountDetails(benInstRequest);
				checkIfOwnAccount(benInstRequest);
				//validateBeneficiaryLimitForBlanks(params);
				checkDuplicateBeneficiaryInstruction(benInstRequest);
			}
			if(grailsApplication.config.beneficiary.limit.display == true)
			{
				validateBeneficiaryInstructionLimit(benInstRequest,params);
				updateBeneInstructionLimitVariables(benInstRequest, params)
			}
			if(params?.accountNumber){
				uniqueConstraintCheck = bmClient.beneficiaryService.checkUniqueKeyForBeneficiaryInstruction(benInstRequest);
			}
			if(params?.currencyId){
				com.vayana.bm.core.api.model.common.Currency transferCurrencyObj=commonService.getCurrency(params.currencyId)
				transferCurrency =transferCurrencyObj?.code
			}
			else if(benInstRequest?.currencyObject)
			{
				transferCurrency = benInstRequest?.currencyObject?.code;
			}
			if(params.iban){
				benInstRequest.setAccountNumber(params.iban);    
			}
			if(params.aadharCardNumber){
				benInstRequest.setAccountNumber(params.aadharCardNumber);    
			}
			if(params?.limitCurrencyId){
				com.vayana.bm.core.api.model.common.Currency limitCurrencyObj=commonService.getCurrency(params.limitCurrencyId)
				limitCurrency =limitCurrencyObj?.code
			}
			if(params?.accountTypeId){
				LookupValue lookupvalueObj=commonService.getAccounttype(params.accountTypeId);
				accounttypeDisplay =lookupvalueObj?.description
			}

			def Map<String,String> postProcessModel=new HashMap<String, String>();

			postProcessModel.put("benenickname", params.shortName)
			postProcessModel.put("beneaccounttype", params.accountTypeId)
			if(params?.accountTypeId){
				postProcessModel.put("accounttypeDisplay", accounttypeDisplay)
			}
			postProcessModel.put("accountNumber", params.accountNumber)
			postProcessModel.put("aadharCardNumber", params.aadharCardNumber)
			postProcessModel.put("mobileNumber", params.mobileNumber)
			postProcessModel.put("iban", params.iban)
			postProcessModel.put("accountcurr", params.currencyId)
			postProcessModel.put("transferCurrency", transferCurrency)
			
			postProcessModel.put("bankcode", params.bankCode)
			postProcessModel.put("bankname", params.bankName)
			postProcessModel.put("branchname", params.branchName)
			postProcessModel.put("bankaddress", params.bankAddress)
			if(params?.limitCurrencyId){
				postProcessModel.put("limitcurr", params.limitCurrencyId)
			}
			if(params?.limitCurrencyId){
				postProcessModel.put("limitCurrency",limitCurrency)
			}
			postProcessModel.put("maxlimit", params.globalMaxAmountParam)
			postProcessModel.put("monthlylimit", params.globalMonthlyMaxAmountParam)
			postProcessModel.put("dailylimit", params.globalDailyMaxAmountParam)
			postProcessModel.put("fromdate", params.effectiveFromDate)
			postProcessModel.put("todate", params.effectiveToDate)
			postProcessModel.put("beneficiaryInstructionId", params.beneficiaryInstructionId)


			setSessionAttribute("BENE", benInstRequest);


			model << [postProcessModel:postProcessModel]
		}
		else{
			model << [errors: beneficiaryInstructionCommand.errors];
		}
	}



	def selectTransactionSubType(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{

		TransactionTypeRequest request = getBean(TransactionTypeRequest.class, requestHeader,params);
		request.setTypeIdentifier("BUSINESSFUNCTION");
		request.setTransactionTypeId(params.selectedTransactionTypeId);
		TransactionTypeResponse response = bmClient.beneficiaryService.getTransactionSubTypes(request);
		model << [transactionSubTypes:response?.tenantServices?.serviceApplication?.service]
	}


	def insertBeneficiaryInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException {
		BeneficiaryInstructionRequest benInstRequest

		if("true".equals(params.isDraftSubmission)){
			benInstRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,params);
			updateBeneInstructionLimitVariables(benInstRequest, params);
		}else{
			benInstRequest = getSessionAttribute("BENE");
		}
		benInstRequest.setOperationFlag("A");
		BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.insertBeneficiaryInstruction(benInstRequest)
		beneficiaryInstructionResponse = bmClient.beneficiaryService.listBeneficiaryInstructions(benInstRequest);
		model << [beneInsRespone:beneficiaryInstructionResponse]

		if(beneficiaryInstructionResponse.hasErrors()){
			model << [errors:beneficiaryInstructionResponse.errors]
		}else{
			session.removeAttribute("BENE")
			setMessage(DEFAULT_CREATED_MESSAGE,["Beneficiary Instruction ",benInstRequest?.shortName+" successfully"], model)
			model << [beneInsRespone:beneficiaryInstructionResponse]
		}
	}

	def getAccountTypeId(BeneficiaryInstructionRequest benInstRequest,Map params) throws BusinessException {
		if(benInstRequest.ccbeneficiaryFlag) {
			BeneficiaryInstructionResponse beneResponse =  bmClient.beneficiaryService.getAccountTypeId(benInstRequest);
			if(beneResponse!=null) {
				BeneficiaryInstruction beneIns = beneResponse.getBeneficiaryInstruction();
				if(beneIns.getAccountType()!=null) {
					benInstRequest.setAccountTypeId(beneIns.getAccountType().getIdVersion());
					params.accountTypeId = beneIns.getAccountType().getIdVersion();
				}
			}
		}
	}

	def checkDuplicateBeneficiaryInstruction(BeneficiaryInstructionRequest benInstRequest) throws BusinessException {
		// Check Duplicate Beneficiary Instruction
		BeneficiaryInstructionResponse beneResponse =  bmClient.beneficiaryService.checkDuplicateBeneficiaryInstruction(benInstRequest);
	}

	def checkIfOwnAccount(BeneficiaryInstructionRequest benInstRequest) throws BusinessException {
		// Check if the Account Number is not an Own Account
		BeneficiaryInstructionResponse beneResponse =  bmClient.beneficiaryService.checkIfOwnAccount(benInstRequest);

	}

	/**
	 * Method used to validate Beneficiary Instruction Limit
	 * 
	 * @param benInstRequest
	 * @param params
	 * @return
	 */
	def validateBeneficiaryInstructionLimit(BeneficiaryInstructionRequest benInstRequest,Map params) throws BusinessException {
		/* Check if there is any applicable Limit for the specified TST. If so perform Limit Validation
		 This step is commented for now since it is mandatory to define beneficiary limit before defining limits for instruction		*/
		//validateAgainstLimitDefinition(benInstRequest,params);

		// Check if there is any  Limit defined at the Beneficiary level. if so compare against the same
		validateAgainstBeneficiaryLimit(benInstRequest,params);
	}

	def validateAgainstBeneficiaryLimit(BeneficiaryInstructionRequest benInstRequest,Map params) throws BusinessException {
		BeneficiaryInstructionResponse beneficiaryInstructionResponses = bmClient.beneficiaryService.getLimitDefinitionForBeneficiary(benInstRequest);
		LimitDefinitionDetail limit = beneficiaryInstructionResponses.getBeneficiaryLimit();
		if(limit!=null) {
			def globalMaxAmountParamDB=limit.getGlobalMaxAmount();
			def globalMinAmountParamDB=limit.getGlobalMinAmount()
			def globalMonthlyMaxAmountParamDB=limit.getGlobalMonthlyMaxAmount();
			def globalDailyMaxAmountParamDB=limit.getGlobalDailyMaxAmount();


			def transactionLimit =  params.globalMaxAmountParam;
			def monthlyLimit =  params.globalMonthlyMaxAmountParam;
			def dailyLimit =  params.globalDailyMaxAmountParam;

			checkValidBigDecimal(transactionLimit);
			checkValidBigDecimal(monthlyLimit);
			checkValidBigDecimal(dailyLimit);

			boolean transLimitValidity = checkGlobalLimitValidity(transactionLimit,globalMaxAmountParamDB,globalMinAmountParamDB);
			boolean monthlyLimitValidity = checkLimitValidity(monthlyLimit,globalMonthlyMaxAmountParamDB);
			boolean dailyLimitValidity = checkLimitValidity(dailyLimit,globalDailyMaxAmountParamDB);

			if(!transLimitValidity) {
				throw new BusinessException(ContextCodeType.CORE, "transaction.limit.violation", "Beneficiary Instruction Validation", null);
			}

			if(!monthlyLimitValidity) {
				throw new BusinessException(ContextCodeType.CORE, "monthly.limit.violation", "Beneficiary Instruction Validation", null);
			}

			if(!dailyLimitValidity) {
				throw new BusinessException(ContextCodeType.CORE, "daily.limit.violation", "Beneficiary Instruction Validation", null);
			}
		}
		else {
			throw new BusinessException(ContextCodeType.CORE, "beneficiary.limit.mandatory", "Beneficiary Instruction Validation", null);
		}
	}

	/**
	 * 
	 * @param benInstRequest
	 * @return
	 */
	def validateAgainstLimitDefinition(BeneficiaryInstructionRequest benInstRequest,Map params) throws BusinessException {
		BeneficiaryInstructionResponse beneficiaryInstructionResponses = bmClient.beneficiaryService.getApplicableLimit(benInstRequest);
		LimitDefinition limit = beneficiaryInstructionResponses.getLimitDefinition();

		if(limit!=null) {
			//Set the LimitDefinition Id to BeneficiaryInstructionRequest. This will be used further in
			// BeneficiarySlipImpl.checkForUniqueConstraints() method to check for unique Key Constraints
			benInstRequest.setLimitDefinitionId(limit.getId());
			def globalMaxAmountParamDB=limit.getGloMaxAmount();
			def globalMinAmountParamDB=limit.getGloMinAmount();
			def globalMonthlyMaxAmountParamDB=limit.getGloMonthlyMaxAmount();
			def globalDailyMaxAmountParamDB=limit.getGloDailyMaxAmount();

			def transactionLimit =  params.globalMaxAmountParam;
			def monthlyLimit =  params.globalMonthlyMaxAmountParam;
			def dailyLimit =  params.globalDailyMaxAmountParam;

			checkValidBigDecimal(transactionLimit);
			checkValidBigDecimal(monthlyLimit);
			checkValidBigDecimal(dailyLimit);

			boolean transLimitValidity = checkGlobalLimitValidity(transactionLimit,globalMaxAmountParamDB,globalMinAmountParamDB);
			boolean monthlyLimitValidity = checkLimitValidity(monthlyLimit,globalMonthlyMaxAmountParamDB);
			boolean dailyLimitValidity = checkLimitValidity(dailyLimit,globalDailyMaxAmountParamDB);

			if(!transLimitValidity)
			{
				throw new BusinessException(ContextCodeType.CORE,"transaction.limit.violation", "Beneficiary Instruction Validation", null);
			}

			if(!monthlyLimitValidity)
			{
				throw new BusinessException(ContextCodeType.CORE, "monthly.limit.violation", "Beneficiary Instruction Validation", null);
			}

			if(!dailyLimitValidity)
			{
				throw new BusinessException(ContextCodeType.CORE, "daily.limit.violation", "Beneficiary Instruction Validation", null);
			}

		}
	}




	/**
	 *
	 * @param beneLimitRequest
	 * @return
	 */
	def validateBeneficiaryAgainstLimitDefinition(LimitDefinitionDetailRequest beneLimitRequest,Map params) throws BusinessException
	{
		LimitDefinitionDetailResponse response = bmClient.beneficiaryService.getBeneficiaryApplicableLimit(beneLimitRequest);
		LimitDefinition limit = response.getLimitDefinition();

		if(limit!=null)
		{
			def globalMaxAmountParamDB=limit.getGloMaxAmount();
			def globalMinAmountParamDB=limit.getGloMinAmount();
			def globalMonthlyMaxAmountParamDB=limit.getGloMonthlyMaxAmount();
			def globalDailyMaxAmountParamDB=limit.getGloDailyMaxAmount();

			def transactionLimit =  params.globalMaxAmountParam;
			def monthlyLimit =  params.globalMonthlyMaxAmountParam;
			def dailyLimit =  params.globalDailyMaxAmountParam;

			checkValidBigDecimal(transactionLimit);
			checkValidBigDecimal(monthlyLimit);
			checkValidBigDecimal(dailyLimit);

			boolean transLimitValidity = checkGlobalLimitValidity(transactionLimit,globalMaxAmountParamDB,globalMinAmountParamDB);
			boolean monthlyLimitValidity = checkLimitValidity(monthlyLimit,globalMonthlyMaxAmountParamDB);
			boolean dailyLimitValidity = checkLimitValidity(dailyLimit,globalDailyMaxAmountParamDB);

			if(!transLimitValidity)
			{
				throw new BusinessException(ContextCodeType.CORE,"transaction.limit.violation", "Beneficiary Validation", null);
			}

			if(!monthlyLimitValidity)
			{
				throw new BusinessException(ContextCodeType.CORE, "monthly.limit.violation", "Beneficiary Validation", null);
			}

			if(!dailyLimitValidity)
			{
				throw new BusinessException(ContextCodeType.CORE, "daily.limit.violation", "Beneficiary Validation", null);
			}

		}
	}

	/**
	 * 
	 * @param value
	 * @return
	 */
	def checkValidBigDecimal(String value) throws BusinessException
	{
		boolean validBD = true;
		if(StringUtils.hasLength(value) )
		{
			if(value.isBigDecimal())
			{
				validBD = true;
			}
			else
			{
				throw new BusinessException(ContextCodeType.CORE, "phonenumber.numeric.error", "Beneficiary Instruction Validation", null);
			}
		}
		return validBD;
	}

	/**
	 *
	 * @param inputValue - Value submitted by the User
	 * @param limitValue - Limit Value from the LD/LDD Table
	 * @return
	 */
	def checkLimitValidity(String inputValue,BigDecimal limitValue)
	{
		boolean result = true;
		if(StringUtils.hasLength(inputValue) && limitValue!=null){
			if(limitValue!=null && inputValue.toBigDecimal() > limitValue)
			{
				result = false;
			}
		}
		return result;
	}


	def checkGlobalLimitValidity(String inputValue,BigDecimal limitMaxValue,BigDecimal limitMinValue)
	{
		boolean result = true;
		if(StringUtils.hasLength(inputValue) && limitMaxValue!=null && limitMinValue!=null)
		{
			if(limitMaxValue!=null && inputValue.toBigDecimal() > limitMaxValue || inputValue.toBigDecimal() < limitMinValue)
			{
				result = false;
			}
		}
		return result;
	}

	def updateBeneficiaryInstruction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		BeneficiaryInstructionRequest benInstRequest = getSessionAttribute("BENE");
		print "benInstRequest"+benInstRequest
		benInstRequest.setOperationFlag("U");
		BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.updateBeneficiaryInstruction(benInstRequest)

		if(beneficiaryInstructionResponse.hasErrors()){
			model << [errors:beneficiaryInstructionResponse.errors]
		}else{
			setMessage(DEFAULT_UPDATED_MESSAGE,["Beneficiary Instruction ",benInstRequest?.shortName+" successfully"], model)
			model << [beneInsRespone:beneficiaryInstructionResponse]
		}

	}

	private updateBeneInstructionLimitVariables(BeneficiaryInstructionRequest benInstRequest, Map params) {
		if(StringUtils.hasLength(params.globalMaxAmountParam)){
			benInstRequest.globalMaxAmount = params.globalMaxAmountParam.toBigDecimal();
		}
		if(StringUtils.hasLength(params.globalMonthlyMaxAmountParam)){
			benInstRequest.globalMonthlyMaxAmount = params.globalMonthlyMaxAmountParam.toBigDecimal();
		}
		if(StringUtils.hasLength(params.globalDailyMaxAmountParam )){
			benInstRequest.globalDailyMaxAmount = params.globalDailyMaxAmountParam.toBigDecimal();
		}
	}

	//insert beneficiary limits
	def insertBeneficiaryLimit(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		LimitDefinitionDetailRequest beneLimitRequest 	= 	getBean(LimitDefinitionDetailRequest.class, requestHeader,params)
		beneLimitRequest.beneId 						= 	params.beneIdVal;
		/*Validate Beneficiary Limits for Blank Values*/
		//validateBeneficiaryLimitForBlanks(params);

		if(StringUtils.hasLength(params.effectiveFromDate))
		{
			beneLimitRequest.effectiveFromDate	=DateUtils.convertStringToDate(params.effectiveFromDate, DateUtils.YYYY_MM_DD)
		}
		if(StringUtils.hasLength(params.effectiveToDate))
		{
			beneLimitRequest.effectiveToDate=	DateUtils.convertStringToDate(params.effectiveToDate, DateUtils.YYYY_MM_DD)
		}
		/*Validate Beneficiary Limits*/
		validateBeneficiaryAgainstLimitDefinition(beneLimitRequest,params);

		if(StringUtils.hasLength(params.globalMaxAmountParam)){
			beneLimitRequest.globalMaxAmount = params.globalMaxAmountParam.toBigDecimal();
		}
		if(StringUtils.hasLength(params.globalMonthlyMaxAmountParam)){
			beneLimitRequest.globalMonthlyMaxAmount = params.globalMonthlyMaxAmountParam.toBigDecimal();
		}
		if(StringUtils.hasLength(params.globalDailyMaxAmountParam)){
			beneLimitRequest.globalDailyMaxAmount = params.globalDailyMaxAmountParam.toBigDecimal();
		}


		LimitDefinitionDetailResponse beneLimitResponse 		= 	bmClient.beneficiaryService.insertBeneficiaryLimit(beneLimitRequest);
		model << [limitDefinitionDetail:beneLimitResponse.getLimitDefinitionDetail()]
		setMessage(DEFAULT_CREATED_MESSAGE, [
			"Benenficiary Limit",
			"Successfully"
		], model);
	}

	def validateBeneficiaryLimitForBlanks(Map params) throws BusinessException
	{
		if(!StringUtils.hasLength(params.effectiveFromDate) && !StringUtils.hasLength(params.effectiveToDate) && !StringUtils.hasLength(params.globalMaxAmountParam)
		&& !StringUtils.hasLength(params.globalMonthlyMaxAmountParam) && !StringUtils.hasLength(params.globalDailyMaxAmountParam))
		{
			throw new BusinessException(ContextCodeType.CORE,"beneficiary.limit.all.blank", "Beneficiary Limit Validation", null);
		}
	}

	def beneficiaryLimits(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		LimitDefinitionDetailRequest limitDefinitionDetailRequest = getBean(LimitDefinitionDetailRequest.class, requestHeader,params)
		if(StringUtils.hasLength(params.beneIdValue))
		{
			limitDefinitionDetailRequest.beneId  = 	params.beneIdValue;
			LimitDefinitionDetailResponse limitDefinitionDetailResponse = bmClient.beneficiaryService.getBeneficiaryLimit(limitDefinitionDetailRequest)
			model << [limitDefinitionDetail:limitDefinitionDetailResponse.getLimitDefinitionDetail()]
		}

	}

	//Update Beneficiary Limits
	def updateBeneficiaryLimit(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		LimitDefinitionDetailRequest beneLimitRequest 	= 	getBean(LimitDefinitionDetailRequest.class, requestHeader,params)
		beneLimitRequest.beneId 						= 	params.beneIdVal;
		beneLimitRequest.idVersion						=   params.beneficiaryLimitId;

		/*Validate Beneficiary Limits for Blank Values*/
		validateBeneficiaryLimitForBlanks(params);

		if(StringUtils.hasLength(params.effectiveFromDate))
		{
			beneLimitRequest.effectiveFromDate	=DateUtils.convertStringToDate(params.effectiveFromDate, DateUtils.YYYY_MM_DD)
		}
		if(StringUtils.hasLength(params.effectiveToDate))
		{
			beneLimitRequest.effectiveToDate=	DateUtils.convertStringToDate(params.effectiveToDate, DateUtils.YYYY_MM_DD)
		}

		/*Validate Beneficiary Limits */
		validateBeneficiaryAgainstLimitDefinition(beneLimitRequest,params);

		if(params.globalMaxAmountParam !="" && params.globalMaxAmountParam != null){
			beneLimitRequest.globalMaxAmount = params.globalMaxAmountParam.toBigDecimal();
		}
		if(params.globalMonthlyMaxAmountParam !="" && params.globalMonthlyMaxAmountParam != null){
			beneLimitRequest.globalMonthlyMaxAmount = params.globalMonthlyMaxAmountParam.toBigDecimal();
		}
		if(params.globalDailyMaxAmountParam !="" && params.globalDailyMaxAmountParam != null){
			beneLimitRequest.globalDailyMaxAmount = params.globalDailyMaxAmountParam.toBigDecimal();
		}

		LimitDefinitionDetailResponse beneLimitResponse 		= 	bmClient.beneficiaryService.updateBeneficiaryLimit(beneLimitRequest);
		model << [limitDefinitionDetail:beneLimitResponse.getLimitDefinitionDetail()]
		setMessage(DEFAULT_UPDATED_MESSAGE, [
			"Benenficiary Limit",
			"Successfully"
		], model);
	}


	def enableBeneficiary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		BeneficiaryRequest beneficiaryRequest = (BeneficiaryRequest)getSessionAttribute("BeneStatusUpdate");
		beneficiaryRequest.setBeneStatus("ACT");
		BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.updateBeneficiaryStatus(beneficiaryRequest)
		model << [beneficiary:beneficiaryResponse.getBeneficiary()]
	}

	def disableBeneficiary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		BeneficiaryRequest beneficiaryRequest = (BeneficiaryRequest)getSessionAttribute("BeneStatusUpdate");
		beneficiaryRequest.setBeneStatus("INA");
		BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.updateBeneficiaryStatus(beneficiaryRequest)
		model << [beneficiary:beneficiaryResponse.getBeneficiary()]
	}

	def confirmBeneficiaryStatusUpdate(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		BeneficiaryRequest beneficiaryRequest = getBean(BeneficiaryRequest.class, requestHeader,params)
		beneficiaryRequest.beneficiaryId=params.beneficiaryId;
		String [] idVers = params.beneficiaryId.split(",");
		if(idVers.length == 2 )
		{
			params.beneId = idVers[0];
		}
		setSessionAttribute("BeneStatusUpdate", beneficiaryRequest)
	}


	def updateBeneInstructionStatus(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException
	{
		BeneficiaryInstructionRequest beneInsrequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,params)
		beneInsrequest.beneficiaryInstructionId = params.beneInstructionId;
		beneInsrequest.beneInstructionStatus = params.status;
		// This step is needed for the IM CALL if applicable
		if(params.status.equalsIgnoreCase("ACT"))          
		{
			beneInsrequest.setOperationFlag("A");
		}
		else if(params.status.equalsIgnoreCase("INA"))
		{
			beneInsrequest.setOperationFlag("D");
		}
		
		// Invoke Basic Details for BeneficiaryInstruction
		BeneficiaryInstructionResponse basicDetails = bmClient.beneficiaryService.getBeneficiaryInstructionBasicDetails(beneInsrequest);
		beneInsrequest.setReferenceNumber(basicDetails.getBeneficiaryInstruction().getReferenceNumber());
		beneInsrequest.setShortName(basicDetails.getBeneficiaryInstruction().getShortName());
		beneInsrequest.setAccountNumber(basicDetails.getBeneficiaryInstruction().getAccountNumber());
		beneInsrequest.setCurrencyId(basicDetails.getBeneficiaryInstruction().getCurrency().getId()+","+basicDetails.getBeneficiaryInstruction().getCurrency().getVersion());
		beneInsrequest.setTransactionSubTypeId(params.paymentmode);
		
		
		BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.updateBeneficiaryInstructionStatus(beneInsrequest)
		beneficiaryInstructionResponse = bmClient.beneficiaryService.listBeneficiaryInstructions(beneInsrequest);
		model << [beneInsRespone:beneficiaryInstructionResponse]
	}

	def getIdVersion(String idVersion)
	{
		return [
			idVersion?.split(",")[0].toLong() ,
			idVersion?.split(",")[1].toLong()
		]
	}

	def displayBeneInstructionInput(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		BeneficiaryInstructionRequest benInsRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,params)
		benInsRequest.setTransactionSubTypeId(params.selectedTransactionTypeId);
		
		/*//  Added to check SME matrix combination for transactionSubType for the sme users starts		
		BeneficiaryInstructionResponse response =bmClient.beneficiaryService.validateSmeMatrix(benInsRequest);	
		//  Added to check SME matrix combination for transactionSubType for the sme users ends
		*/				
		BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.addBeneficiaryInstruction(benInsRequest);
		String beneInsTemplate = beneficiaryInstructionResponse.getBeneInstructionTemplate();
		if("SME".equals(benInsRequest.getRequestHeader().getInvoker().getSegmentCode())){     
		if(beneInsTemplate.contains("IMPS")){
			throw new BusinessException(ContextCodeType.GENERAL,"SMEBENE001");		
		}
		}
		model << [beneInsRespone:beneficiaryInstructionResponse]
	}

	def listBeneficiaryInstructions(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		BeneficiaryInstructionRequest benInsRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,params);
		BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.listBeneficiaryInstructions(benInsRequest);
		model << [beneInsRespone:beneficiaryInstructionResponse];

	}
	def beneficiaryAccountsEdit(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		BeneficiaryInstructionRequest benInsRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,params);
		BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.listBeneficiaryInstructions(benInsRequest);
		model << [beneInsRespone:beneficiaryInstructionResponse];

	}
	def beneficiaryAccounts(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		BeneficiaryInstructionRequest benInsRequest = getBean(BeneficiaryInstructionRequest.class, requestHeader,params);
		if(StringUtils.hasLength(benInsRequest.getBeneficiaryId()))   
		{  
			BeneficiaryInstructionResponse beneficiaryInstructionResponse = bmClient.beneficiaryService.listBeneficiaryInstructions(benInsRequest);
			model << [beneInsRespone:beneficiaryInstructionResponse];
		}
		else
		{
			model << [beneInsRespone:new BeneficiaryInstructionResponse()];
		}


	}
	

	def beneficiaryDetails(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		BeneficiaryRequest benRequest = getBean(BeneficiaryRequest.class, requestHeader,params);
		if(StringUtils.hasLength(benRequest.getBeneficiaryId()))
		{		
			BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.getBeneficiary(benRequest)
			model << [beneficiary:beneficiaryResponse.getBeneficiary()]
		}
	}

	def getValidAccountDetails(BeneficiaryInstructionRequest benInstRequest) throws BusinessException
	{
		String transactionSubType = benInstRequest.getTransactionSubTypeId();
		if(StringUtils.hasLength(transactionSubType))
		{
			IBCommonRequest ibCommonRequest = getBean(IBCommonRequest.class, null, null);
			String selectedServiceId = transactionSubType.split(",")[0];
			ibCommonRequest.setCommonEntityId(Long.parseLong(selectedServiceId));
			IBCommonResponse ibCommonResponse = bmClient.iBCommonService.getServiceDetailsByServiceId(ibCommonRequest);
			if(ibCommonResponse!=null)
			{
				Service serviceObj = ibCommonResponse.getCommonEntity();
				if("TPTTRANS".equalsIgnoreCase(serviceObj.getCode()))
				{
					// If the Account Type is TPT (WITHIN BANK) then validate the account number
					CommonRequest commonRequest 	= 	getBean(CommonRequest.class, "commonRequest", benInstRequest?.requestHeader, null);
					commonRequest?.cifNumber		=	benInstRequest?.requestHeader?.invoker?.primaryCIF;
					commonRequest.setAttribute("ACCOUNT_NUMBER", benInstRequest?.getAccountNumber());
					CommonResponse commonResponse	=	bmClient.accountService.validateAccountDetails(commonRequest);
					if(commonResponse!=null && commonResponse.getCommonEntity() !=null) {
						Account accountDetail = (Account) commonResponse.getCommonEntity();
						if("ACT".equalsIgnoreCase(accountDetail?.accountStatus?.code)) {
							String accountNumber =  accountDetail.getAccountNumber();
							if(!StringUtils.hasLength(accountNumber)) {
								throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.INVALID_USER_ACCOUNT, "Beneficiary Instruction Validation", null);
							} else {
								if(accountDetail.getAcctProduct()	!=	null) {
									benInstRequest.setProductId(accountDetail.getAcctProduct().getIdVersion());
								}
								if(accountDetail.getCurrency()	!=	null) {
									benInstRequest.setCurrencyId(accountDetail.getCurrency().getIdVersion());
									benInstRequest.setCurrencyObject(accountDetail.getCurrency());
								}
								if(accountDetail.getBranch() != null){
									benInstRequest.setPayeeBankBranchId(accountDetail.getBranch().getIdVersion());
								}
								if(accountDetail.getAccountType() != null){
									benInstRequest.setAccountTypeId(accountDetail.getAccountType().getIdVersion());
								}
							}
						} else {
							throw new BusinessException(ContextCodeType.CORE, "beneficiary.accountNumber.invalid", "Beneficiary Instruction Validation", null);
						}
					} else {
						throw new BusinessException(ContextCodeType.CORE, "beneficiary.accountNumber.invalid", "Beneficiary Instruction Validation", null);
					}
				}
			}
		}
	}

	def getValidAccount(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		CommonRequest commonRequest 	= 	getBean(CommonRequest.class, "commonRequest", requestHeader, model);
		commonRequest?.cifNumber		=	requestHeader?.invoker?.primaryCIF;
		commonRequest.setAttribute("ACCOUNT_NUMBER", params?.accountId);
		CommonResponse commonResponse	=	bmClient.accountService.validateAccountDetails(commonRequest);
		BeneficiaryInstruction beneficiaryInstruction	=	new BeneficiaryInstruction();
		if(commonResponse.hasErrors()){
			model << [errors:commonResponse.errors()]
			return;
		}else{
			if(commonResponse!=null && commonResponse.getCommonEntity() !=null) {
				
				Account accountDetail = (Account) commonResponse.getCommonEntity();
				if("ACT".equalsIgnoreCase(accountDetail?.accountStatus?.code)){
					beneficiaryInstruction.setShortName(accountDetail?.accountShortName);
					beneficiaryInstruction.setAccountType(accountDetail?.accountType);
					beneficiaryInstruction.setCurrency(accountDetail?.currency);
					beneficiaryInstruction.setPayeeBankBranch(accountDetail?.branch);
				} else {
					throw new BusinessException(ContextCodeType.CORE, "beneficiary.accountNumber.invalid", "Beneficiary Instruction Validation", null);
				}
			} else {
				throw new BusinessException(ContextCodeType.CORE, "beneficiary.accountNumber.invalid", "Beneficiary Instruction Validation", null);
			}
		}
		/*CasaAccountDetailsRequest casaRequest = getBean(CasaAccountDetailsRequest.class,requestHeader,params);
		casaRequest.setCustomerId(requestHeader?.invoker?.primaryCIF);
		casaRequest.setAccountNumber(params.accountId); 
		CasaAccountDetailsResponse casaReponse = bmClient.accountService.validateCasaAccount(casaRequest);
		BeneficiaryInstruction beneficiaryInstruction=new BeneficiaryInstruction();
		if(casaReponse!=null && casaReponse.getAccountDetail()!=null && casaReponse.getAccountDetail().getAccountStatus().getCode().equalsIgnoreCase("ACT"))
		{
			
			beneficiaryInstruction.setShortName(casaReponse.getAccountDetail().customerName);
			beneficiaryInstruction.setAccountType(casaReponse.getAccountDetail().accountType);
			beneficiaryInstruction.setCurrency(casaReponse.getAccountDetail().currency);
		}
		else
		{
			throw new BusinessException(ContextCodeType.CORE, "beneficiary.accountNumber.invalid", "Beneficiary Instruction Validation", null);
		}*/
		
		model << [beneficiaryInstruction:beneficiaryInstruction]

	}
	
	/*def validateAccountNumber(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		
				CasaAccountDetailsRequest casaRequest = getBean(CasaAccountDetailsRequest.class,requestHeader,params);
				casaRequest.setCustomerId(invoker.getPrimaryCIF());
				casaRequest.setAccountNumber(params.accountId);
				CasaAccountDetailsResponse casaReponse = bmClient.accountService.validateCasaAccount(casaRequest);
				BeneficiaryInstruction beneficiaryInstruction=new BeneficiaryInstruction();
				if(casaReponse!=null && casaReponse.getAccountDetail()!=null && casaReponse.getAccountDetail().getAccountStatus().getCode().equalsIgnoreCase("ACT"))
				{
					
					beneficiaryInstruction.setShortName(casaReponse.getAccountDetail().customerName);
					//beneficiaryInstruction.setAccountType(casaReponse.getAccountDetail().accountType);
					//beneficiaryInstruction.setCurrency(casaReponse.getAccountDetail().currency);
				}
				else
				{
					throw new BusinessException(ContextCodeType.CORE, "beneficiary.accountNumber.invalid", "Beneficiary Instruction Validation", null);
				}
				
				model << [beneficiaryInstruction:beneficiaryInstruction]
		
			}*/
	
	def getValidCreditCard(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
		CreditCardDetailRequest ccRequest = getBean(CreditCardDetailRequest.class,requestHeader,params);
		ccRequest.setCreditCardNumber(encryptionUtil.encryptUsing3DES(params.creditcardNo));
		CreditCardDetailResponse ccReponse = bmClient.creditCardService.validateCreditCard(ccRequest);
		BeneficiaryInstruction beneficiaryInstruction=new BeneficiaryInstruction();
		beneficiaryInstruction.setShortName(ccReponse.getCreditCardAccount().getNameOnCard());
		//beneficiaryInstruction.setAccountType(casaReponse.getAccountDetail().accountType);
		beneficiaryInstruction.setCurrency(baseCommonUtil.getCurrencyByCode("BHD"));
		model << [beneficiaryInstruction:beneficiaryInstruction]
		
	}

}

class BeneficiaryCommand{
	String  buildingNumber, shortName, description, primaryEmailAddress, secondaryEmailAddress,
	firstName, lastName, middleName, primaryMobileNumber, secondaryMobileNumber,
	primaryPhoneNumber,secondaryPhoneNumber,pincode ,streetAddress1, streetAddress2 , streetAddress3,streetAddress4

	String  cityId, countryId , documentId , beneTypeCode , titleId , nationalityId , stateId , userLoginProfileId

	static constraints =  {
//		shortName(blank:false)
		//userLoginProfileId(blank:false)
		//beneTypeCode(blank:false)
		//primaryMobileNumber(blank:false)
		//streetAddress1(blank:false)
		//pincode(blank:false)
		//countryId(blank:false)
		//primaryPhoneNumber(blank:false)
		//primaryEmailAddress(blank:false)
		primaryEmailAddress(email: true, blank: true);
		secondaryEmailAddress(email: true, blank: true);
		shortName blank:false,shared : 'shortNameConstraint',validator : {val,obj ->
			if(!val?.matches("[a-zA-Z0-9 ]+")){
			  obj.errors.rejectValue('shortName','beneficiaryCommand.shortName.match.invalid')
			}
		}
		streetAddress1 validator : { val,obj ->
			if(StringUtils.hasLength(val) && !val?.matches("[a-zA-Z0-9 ]+"))
			{
				obj.errors.rejectValue('streetAddress1','beneficiaryCommand.streetAddress1.match.invalid')
			}

		}
		streetAddress2 validator : { val,obj ->
			if(StringUtils.hasLength(val) && !val?.matches("[a-zA-Z0-9 ]+"))
			{
				obj.errors.rejectValue('streetAddress2','beneficiaryCommand.streetAddress2.match.invalid')
			}

		}
		streetAddress3 validator : { val,obj ->
			if(StringUtils.hasLength(val) && !val?.matches("[a-zA-Z0-9 ]+"))
			{
				obj.errors.rejectValue('streetAddress3','beneficiaryCommand.streetAddress3.match.invalid')
			}

		}
		streetAddress4 validator : { val,obj ->
			if(StringUtils.hasLength(val) && !val?.matches("[a-zA-Z0-9 ]+"))
			{
				obj.errors.rejectValue('streetAddress4','beneficiaryCommand.streetAddress4.match.invalid')
			}

		}
		primaryPhoneNumber validator : { val,obj ->
			if(StringUtils.hasLength(val) && !val.isNumber())
			{
				obj.errors.rejectValue('primaryPhoneNumber','phonenumber.numeric.error')
			}

		}

		primaryMobileNumber validator : { val,obj ->
			if(StringUtils.hasLength(val) &&  !val.isNumber())
			{
				obj.errors.rejectValue('primaryMobileNumber','phonenumber.numeric.error')
			}

		}

		pincode validator : { val,obj ->

			if(StringUtils.hasLength(val) && !val.isNumber()){
				obj.errors.rejectValue('pincode','phonenumber.numeric.error')
			}

		}

		secondaryMobileNumber (validator: { value,obj ->
			if (StringUtils.hasLength(value) && (!value.isNumber())) {
				obj.errors.rejectValue('secondaryMobileNumber','phonenumber.numeric.error')
			}
		})

		secondaryPhoneNumber (validator: { value,obj ->
			if (StringUtils.hasLength(value) && (!value.isNumber())) {
				obj.errors.rejectValue('secondaryPhoneNumber','phonenumber.numeric.error')
			}
		})
	}
}
class QuickPayCommand {
	String beneficiaryType,beneficiaryName,nickName,acctNumber,cnfmAcctNumber,currencyIdVersion,beneBankBranchCode;
	static constraints = {
		beneficiaryType(blank:false)
		beneficiaryName(blank:false)
		nickName(blank:false)
		acctNumber blank:false;
		cnfmAcctNumber(blank:false)
		currencyIdVersion(blank:false)
//		beneBankBranchCode(blank:false)
		
		acctNumber validator : {val,obj->
			if(!val.equals(obj.cnfmAcctNumber)){
				obj.errors.rejectValue('acctNumber','quickPayCommand.acctNumber.match.inavalid')
			}
		}
		
	}
}
class BeneficairyLimitCommand
{
	String currencyId, limitTypeId , beneficiaryId, effectiveFromDate,effectiveToDate
	BigDecimal transactionLimit,monthlyLimit,dailyLimit
}

class BeneficiaryInstructionCommand
{
	//String  accountNumber,accountNumberConfirm,shortName,description,iban,limitCode,limitDescription;
	String  shortName,description,iban,limitCode,limitDescription,accountNumber,accountNumberConfirm,overrideType;    
	//String  bankId , branchId, currencyId , accountTypeId ,transactionSubTypeId , transactionTypeId , beneficiaryId;
	String  bankId , branchId, currencyId ,transactionSubTypeId , transactionTypeId , beneficiaryId;
	String effectiveFromDate,effectiveToDate,mobileNumber,aadharCardNumber,tstCode;
	BigDecimal transactionLimit,monthlyLimit,dailyLimit,globalMaxAmountParamDB,globalMonthlyMaxAmountParamDB,globalDailyMaxAmountParamDB;


	private static int ACCNT_NO_LENGTH = 25
	private static int IBAN_LENGTH = 34
	private static final String OVRERRIDE_ACCT = "acct";
	private static final String OVRERRIDE_IBAN = "iban";
	;
	
	static constraints = {
		//	accountTypeId(blank:false)
		//	accountNumber(blank:false)
		//	accountNumberConfirm(blank:false)
		shortName(blank:false,shared : 'shortNameConstraint',validator : {val,obj ->
			if(StringUtils.hasLength(val) && !val?.matches("[a-zA-Z0-9 ]+")){
				obj.errors.rejectValue('shortName','beneficiaryInstructionCommand.shortName.match.invalid')
			}
		})
		
		/*mobileNumber validator : {val,obj->
			
			if(StringUtils.hasLength(val) && val.size() <10)
			{
				obj.errors.rejectValue('mobileNumber','beneficiaryInstructionCommand.mobileNumber.match.inavalid')
			}
			
	
		}
		aadharCardNumber validator : {val,obj ->
			if((StringUtils.hasLength(val) && val.size() !=12 ))
			{
				obj.errors.rejectValue('aadharCardNumber','beneficiaryInstructionCommand.aadharCardNumber.match.invalid')
			}
		}*/
		overrideType validator : {val,obj ->
			if(val.equals(OVRERRIDE_IBAN)){     
				if(!StringUtils.hasLength(val)){
					obj.errors.rejectValue('iban','iban.invalid.error')
				}
			}else{
				def accntNoConfirm = obj.accountNumberConfirm
				// Check if variable val is accountNumber or IBAN Number accordingly validate the same
				if(StringUtils.hasLength(obj.accountNumber) && obj.accountNumber?.matches("[a-zA-Z0-9]+"))
				{
					if(obj.accountNumber.length() > ACCNT_NO_LENGTH)
					{
					obj.errors.rejectValue('accountNumber','accountNumber.invalid.error')
					}
				}
				else
				{
				/*boolean iBanValid = BaseCommonUtil.isValidIban(val);
				if(!iBanValid)
				{*/
					obj.errors.rejectValue('accountNumber','accountNumber.invalid.error')
				/*}*/
				}
				if(!obj.accountNumber.equals(accntNoConfirm))
				{
				obj.errors.rejectValue('accountNumber','accountNumber.match.error')
				}
			}
		}
		tstCode validator : {val,obj ->
			if(val != null && BusinessFunctionConstants.IMPSP2U.equals(val)){
				if(StringUtils.hasLength(obj.mobileNumber) && obj.mobileNumber.size() <10)
				{
					obj.errors.rejectValue('mobileNumber','beneficiaryInstructionCommand.mobileNumber.match.inavalid')
				}
				else if((StringUtils.hasLength(obj.aadharCardNumber) && obj.aadharCardNumber.size() !=12 ))
				{
					obj.errors.rejectValue('aadharCardNumber','beneficiaryInstructionCommand.aadharCardNumber.match.invalid')
				}
				
			}else if(val != null  && BusinessFunctionConstants.IMPSP2P.equals(val) || BusinessFunctionConstants.IMPSP2M.equals(val) ){
				if(StringUtils.hasLength(obj.mobileNumber) && obj.mobileNumber.size() <10)
				{
					obj.errors.rejectValue('mobileNumber','beneficiaryInstructionCommand.mobileNumber.match.inavalid')
				}
				else if((StringUtils.hasLength(obj.iban) && obj.iban.size() !=7 ))
				{
					obj.errors.rejectValue('iban','beneficiaryInstructionCommand.iban.match.invalid')
				}
				
			}
			
		}
	}
}
