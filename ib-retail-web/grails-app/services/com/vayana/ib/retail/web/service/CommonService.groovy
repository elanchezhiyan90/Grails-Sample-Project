package com.vayana.ib.retail.web.service;
import org.springframework.ui.ModelMap

import java.util.Map;

import org.activiti.engine.impl.persistence.entity.CommentEntity
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.common.utils.CollectionUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.DocumentRequest
import com.vayana.bm.core.api.beans.common.DocumentResponse
import com.vayana.bm.core.api.beans.common.GenericRequest
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.beans.common.Invoker
import com.vayana.bm.core.api.beans.common.LookUpResponse
import com.vayana.bm.core.api.beans.user.UserSecureImageRequest
import com.vayana.bm.core.api.beans.user.UserSecureImageResponse
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.model.common.Country
import com.vayana.bm.core.api.model.common.Currency
import com.vayana.bm.core.api.model.common.DocumentDetail
import com.vayana.bm.core.api.model.common.GenericEntity
import com.vayana.bm.core.api.model.common.LookupValue
import com.vayana.bm.core.api.model.common.QuestionBasket
import com.vayana.bm.core.api.model.common.QuestionBasketDetail
import com.vayana.bm.core.api.model.common.TenantApplicationCurrency
import com.vayana.bm.core.api.model.common.TenantApplicationLocale
import com.vayana.bm.core.api.model.common.TenantOperatingCountry
import com.vayana.bm.core.api.model.configuration.PasswordPolicyConfiguration
import com.vayana.bm.core.api.model.enums.CommonEntityEnum
import com.vayana.bm.core.api.model.enums.FindByEnum
import com.vayana.bm.core.api.model.infra.workflow.WorkflowUserActivity
import com.vayana.bm.core.api.model.user.UserLoginProfile
import com.vayana.bm.core.impl.service.utils.AesUtil
import com.vayana.bm.infra.workflow.WorkflowService
import com.vayana.ib.bm.core.api.beans.account.AccountBalanceRequest
import com.vayana.ib.bm.core.api.beans.account.AccountBalanceResponse
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailsRequest
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailsResponse
import com.vayana.ib.bm.core.api.beans.beneficiary.BeneficiaryRequest
import com.vayana.ib.bm.core.api.beans.beneficiary.BeneficiaryResponse
import com.vayana.ib.bm.core.api.beans.biller.BillerDetailsRequest
import com.vayana.ib.bm.core.api.beans.biller.BillerDetailsResponse
import com.vayana.ib.bm.core.api.beans.biller.BillerSummaryRequest
import com.vayana.ib.bm.core.api.beans.biller.BillerSummaryResponse
import com.vayana.ib.bm.core.api.beans.charges.ChargeResponse
import com.vayana.ib.bm.core.api.beans.common.IBCommonRequest
import com.vayana.ib.bm.core.api.beans.common.IBCommonResponse
import com.vayana.ib.bm.core.api.beans.common.IBLookUpRequest
import com.vayana.ib.bm.core.api.beans.common.IBLookUpResponse
import com.vayana.ib.bm.core.api.beans.common.IBUserInformationRequest
import com.vayana.ib.bm.core.api.beans.common.IBUserInformationResponse
import com.vayana.ib.bm.core.api.beans.constants.AttributeConstants
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardDetailRequest
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardDetailResponse
import com.vayana.ib.bm.core.api.beans.exchangerate.ExchangeRateRequest
import com.vayana.ib.bm.core.api.beans.exchangerate.ExchangeRateResponse
import com.vayana.ib.bm.core.api.beans.otp.OTPGenerationRequest
import com.vayana.ib.bm.core.api.beans.otp.OTPGenerationResponse
import com.vayana.ib.bm.core.api.beans.payment.FriendsAndFamilyAccountRequest
import com.vayana.ib.bm.core.api.beans.payment.FriendsAndFamilyAccountResponse
import com.vayana.ib.bm.core.api.beans.payment.OwnAccountRequest
import com.vayana.ib.bm.core.api.beans.payment.OwnAccountResponse
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardDetailRequest
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardDetailResponse
import com.vayana.ib.bm.core.api.beans.servicerequest.ChequeBookRequest
import com.vayana.ib.bm.core.api.beans.servicerequest.GenericSRRequest
import com.vayana.ib.bm.core.api.beans.servicerequest.GenericSRResponse
import com.vayana.ib.bm.core.api.beans.transfers.FundTransferRequest
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileRequest
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileResponse
import com.vayana.ib.bm.core.api.model.account.Account
import com.vayana.ib.bm.core.api.model.account.CasaAccount
import com.vayana.ib.bm.core.api.model.account.CreditCardAccount
import com.vayana.ib.bm.core.api.model.account.PrepaidCardAccount
import com.vayana.ib.bm.core.api.model.beneficiary.Beneficiary
import com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction
import com.vayana.ib.bm.core.api.model.common.TenantBranch
import com.vayana.ib.bm.core.api.model.common.TenantLookupValue
import com.vayana.ib.bm.core.api.model.enums.AccountFilterEnum
import com.vayana.ib.bm.core.api.model.payment.Biller
import com.vayana.ib.bm.core.api.model.payment.BillerData
import com.vayana.ib.bm.core.api.model.payment.BillerInstruction
import com.vayana.ib.bm.core.api.model.servicerequest.DepositDetail
import com.vayana.ib.bm.core.impl.service.util.IBUserUtil
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class CommonService extends GenericService{

	BmClient bmClient;
	
	WorkflowService workflowService;
	
	@Autowired
	IBUserUtil ibUserUtil;
	
	/**
	 * @author elanchezhiyan
	 * @param accountNumber
	 * @return
	 */
	String fetchAccountByAccountNumber(String accountNumber){
		CommonRequest request = getBean(CommonRequest.class, null,null)
		request.setAttribute(AttributeConstants.ACCOUNT_NUMBER, accountNumber)
		CommonResponse response = bmClient.accountService.getAccountNickName(request);
		return response.getAttribute(AttributeConstants.ACCOUNT_SHORT_NAME);
	}
	
	List<GenericEntity> getLookupValuesByType(String lookupTypeName , String domain){
		LookUpResponse lookupResponse = new LookUpResponse();
		if(domain == 'base')
		{
			IBLookUpRequest iblookUpRequest = getBean(IBLookUpRequest.class, null, null);
			iblookUpRequest.setTypeName(lookupTypeName);
			lookupResponse = bmClient.iBCommonService.getLookupValuesByType(iblookUpRequest);
		}
		else if(domain == 'ib')
		{
			IBLookUpRequest iblookUpRequest = getBean(IBLookUpRequest.class, null, null);
			iblookUpRequest.setTypeName(lookupTypeName);
			lookupResponse =(IBLookUpResponse) bmClient.iBCommonService.getIBLookupValuesByType(iblookUpRequest);
		
		}
		return lookupResponse.getLookupValue();
	}
	
	List<GenericEntity> getCommonObjects(CommonEntityEnum commonTypeName , FindByEnum findByEnum , String packageproperty){
		CommonResponse commonResponse = new CommonResponse()
		if(packageproperty == 'base') 
		{ 
			CommonRequest commonRequest = getBean(CommonRequest.class, null, null);
			commonRequest.setCommonEntity(commonTypeName);
			commonRequest.setFindByParams(findByEnum);
			commonResponse = bmClient.iBCommonService.getCommonEntities(commonRequest);
		}
		else if(packageproperty == 'ib')
		{
			 IBCommonRequest ibCommonRequest = getBean(IBCommonRequest.class, null, null);
			 ibCommonRequest.setCommonEntity(commonTypeName);
			 ibCommonRequest.setFindByParams(findByEnum);
			 commonResponse = (CommonResponse) bmClient.iBCommonService.getIBCommonEntities(ibCommonRequest);
		}
		return commonResponse.getCommonEntities();
	}
	
	TenantBranch fetchBranchById(String value){
		IBCommonRequest ibCommonRequest = getBean(IBCommonRequest.class, null, null);
		ibCommonRequest.setId(value);
		IBCommonResponse res = bmClient.iBCommonService.fetchBranchById(ibCommonRequest);
		return res.getCommonEntity() != null ? (TenantBranch)res.getCommonEntity() : null;
	}
	
	
	List<GenericEntity> getLookupValuesByType(String lookupTypeName ){
		IBLookUpRequest iblookUpRequest = getBean(IBLookUpRequest.class, null, null);
		iblookUpRequest.setTypeName(lookupTypeName);
		LookUpResponse lookupResponse = bmClient.iBCommonService.getLookupValuesByType(iblookUpRequest);
		return lookupResponse.getLookupValue();
	}
	
	DocumentDetail getDocumentDetailById(Long documentDetailId){
		DocumentRequest documentRequest = getBean(DocumentRequest.class, null, null);
		documentRequest.setDocumentDetailId(documentDetailId);
		DocumentResponse documentResponse = bmClient.iBCommonService.getDocumentDetail(documentRequest);
		return documentResponse.documentDetail;
	}
	
	List<BeneficiaryInstruction> getFromOwnCasaAcounts(params,type,popType,opsIns,tdOpsIns,pgIdentifier)
	{		
		def accountId = params?.toAccount;		
		OwnAccountRequest ownAccountRequest=getBean(OwnAccountRequest.class, null, null);		
		ownAccountRequest.setIbUserLoginProfileId(getUserLoginProfile().getId());
//		ownAccountRequest.setAccountFilter(popType);
		ownAccountRequest.setAccountFilterEnum(AccountFilterEnum.valueOf(popType));
		ownAccountRequest.setPgIdentifier(pgIdentifier);
		OwnAccountResponse ownAccountResponse=bmClient.paymentService.getOwnAccounts(ownAccountRequest);		
		List<BeneficiaryInstruction> beneficiaryInstructionList = new ArrayList<BeneficiaryInstruction>(ownAccountResponse.getBeneficiaryInstruction());
		List<BeneficiaryInstruction> tempbeneficiaryInstructionList=new ArrayList<BeneficiaryInstruction>();
		if('YES'.equalsIgnoreCase(opsIns)){
			//Filter based on Operating Instruction Master
			OwnAccountRequest  oprModeRequest = getBean(OwnAccountRequest.class, null, null);
			oprModeRequest.setOwnAccountList(beneficiaryInstructionList);
			oprModeRequest.setTenantServiceCode(params?.tenantServiceCode);
			oprModeRequest.setPgIdentifier(pgIdentifier);
			OwnAccountResponse oprModeResponse = bmClient.paymentService.filterByOperatingInstruction(oprModeRequest);	
			beneficiaryInstructionList = oprModeResponse.getBeneficiaryInstruction();
		}
		if('YES'.equalsIgnoreCase(tdOpsIns))
		{
			OwnAccountRequest  oprModeRequest = getBean(OwnAccountRequest.class, null, null);
			oprModeRequest.setOwnAccountList(beneficiaryInstructionList);
			OwnAccountResponse oprModeResponse = bmClient.paymentService.filterTDByOperatingInstruction(oprModeRequest);
			beneficiaryInstructionList = oprModeResponse.getBeneficiaryInstruction();
		}
		//to check the account type
		if(type.equals("OA"))
		{
			for(BeneficiaryInstruction beneList:beneficiaryInstructionList)
			{
				if(!params?.beneId?.toString().equals(beneList.account.id.toString()))
				{
					tempbeneficiaryInstructionList.add(beneList);
				}
			}
			return tempbeneficiaryInstructionList
		}else{
			return beneficiaryInstructionList
		}
	}
	List<BeneficiaryInstruction> getToOwnCasaAcounts(params,popType)
	{		
		OwnAccountRequest ownAccountRequest=getBean(OwnAccountRequest.class, null, null);
		ownAccountRequest.setIbUserLoginProfileId(getUserLoginProfile().getId());
//		ownAccountRequest.setAccountFilter(popType);
		ownAccountRequest.setAccountFilterEnum(AccountFilterEnum.valueOf(popType));
		OwnAccountResponse ownAccountResponse=bmClient.paymentService.getOwnAccounts(ownAccountRequest);
		List<BeneficiaryInstruction> beneficiaryInstructionList = new ArrayList<BeneficiaryInstruction>(ownAccountResponse.getBeneficiaryInstruction());
		List<BeneficiaryInstruction> tempbeneficiaryInstructionList=new ArrayList<BeneficiaryInstruction>();
		for(BeneficiaryInstruction beneList:beneficiaryInstructionList)
		{
			
			if(params.beneId.toString().equals(beneList.account.id.toString()))
			{
				tempbeneficiaryInstructionList.add(beneList);
			
			}
		}
			return tempbeneficiaryInstructionList
	}
		
	
	List<BeneficiaryInstruction> getFriendsAndFamilyAccounts(payeeID,isQuickPay)
	{
		FriendsAndFamilyAccountRequest  friendsAndFamilyAccountRequest=getBean(FriendsAndFamilyAccountRequest.class, null, null);		
		friendsAndFamilyAccountRequest.setBeneId(payeeID)
		friendsAndFamilyAccountRequest.setQuickPay(isQuickPay)    
		FriendsAndFamilyAccountResponse friendsAndFamilyAccountResponse=bmClient.paymentService.getFriendsAndFamilyAccounts(friendsAndFamilyAccountRequest);
		List<BeneficiaryInstruction> friendsAndFamilyInstructionList=new ArrayList<BeneficiaryInstruction>(friendsAndFamilyAccountResponse.getBeneficiaryInstruction());		
		return friendsAndFamilyInstructionList;
	}
	
	UserSecureImageResponse getSecureImagesForUser(Long userLoginProfile){
		UserSecureImageResponse secureImageResponse = null;
		if (userLoginProfile != null) {
			UserSecureImageRequest secureImageRequest  = getBean(UserSecureImageRequest.class, null, null);
			secureImageRequest.userLoginProfileId = userLoginProfile;
			secureImageResponse = bmClient.userService.getSecureImageforUser(secureImageRequest);
		}
		return secureImageResponse;
	}
	
	IBUserProfileResponse getIBUserProfileDetails(Long userLoginProfileId){
		IBUserProfileRequest userProfileRequest = getBean(IBUserProfileRequest.class, null, null);   
		userProfileRequest.setIbUserLoginProfileId(userLoginProfileId);
		IBUserProfileResponse userProfileResponse = bmClient.iBUserService.getIBUserProfileDetails(userProfileRequest);
		return userProfileResponse;
	}
	/**
	 * @author elanchezhiyan
	 * @param requestHeader
	 * @return
	 */
	def fetchPasswordPolicyConfig(GenericRequestHeader requestHeader){
		CommonRequest commonRequest = getBean(CommonRequest.class, null, null);
		commonRequest.requestHeader = requestHeader
		CommonResponse response = bmClient.iBCommonService.fetchPPC(commonRequest);
		return (PasswordPolicyConfiguration)response.commonEntity
	}
	/**
	 * @author sirajudeen
	 * @param request
	 * @return
	 */
	def getCifNumber(GenericRequest request){
		IBUserProfileResponse upr = getIBUserProfileDetails(request?.requestHeader?.invoker?.userLoginProfileId)
		return upr?.ibUserProfile?.primaryUserCif?.customerIdentifier?.cifNumber?.toString();
	}
	AccountBalanceResponse getAccountBalance(AccountBalanceRequest accountBalanceRequest)
	{
		AccountBalanceResponse accountBalanceResponse = new AccountBalanceResponse();
		CommonRequest commonRequest = getBean(CommonRequest.class, null, null);
		commonRequest.setCommonEntityId(accountBalanceRequest.getAccountId());
		CommonResponse accountResponse = bmClient.accountService.getAccountById(commonRequest);
		
		Account accountInstance = (Account) accountResponse.getCommonEntity();
		
		if(accountInstance instanceof CasaAccount)
		{
			CasaAccountDetailsRequest casaAccountDetailsRequest=getBean(CasaAccountDetailsRequest.class, accountBalanceRequest.getRequestHeader(), null);			
			casaAccountDetailsRequest.setAccountId(accountBalanceRequest.getAccountId());
			CasaAccountDetailsResponse casaAccountDetailsResponse=bmClient.accountService.getCasaAccountDetails(casaAccountDetailsRequest);
			if(casaAccountDetailsResponse!=null)
			{
				accountBalanceResponse.setAvailableBalance(casaAccountDetailsResponse.getAccountDetail().getAvailableBalance());
				accountBalanceResponse.setAccountCurrency(casaAccountDetailsResponse.getAccountDetail().getCurrency().getCode());
				accountBalanceResponse.setAccountBranch(casaAccountDetailsResponse.getAccountDetail().getBranch());
			}  			
			
		}
		else if(accountInstance instanceof CreditCardAccount)
		{
			CreditCardDetailRequest creditCardDetailRequest= getBean(CreditCardDetailRequest.class, accountBalanceRequest.getRequestHeader(), null);			
			creditCardDetailRequest.setAccountId(accountBalanceRequest.getAccountId());
			CreditCardDetailResponse creditCardDetailResponse=bmClient.creditCardService.getCreditCardDetail(creditCardDetailRequest);
			if(creditCardDetailResponse!=null)
			{
				accountBalanceResponse.setAvailableBalance(creditCardDetailResponse.getCreditCardAccount().getAvailableCreditLimit());
				accountBalanceResponse.setAccountCurrency(creditCardDetailResponse.getCreditCardAccount().getCurrency().getCode());
				//Below lines for Credit Card Transfer Excess Credit Module
				accountBalanceResponse.totalCreditLimit = creditCardDetailResponse?.creditCardAccount?.totalCreditLimit
				accountBalanceResponse.outStandingAmount = creditCardDetailResponse?.creditCardAccount?.outStandingAmount
			}			
			
		}else if(accountInstance instanceof PrepaidCardAccount){
			PrepaidCardDetailRequest prepaidCardDetailRequest=getBean(PrepaidCardDetailRequest.class, accountBalanceRequest.getRequestHeader(), null)
			prepaidCardDetailRequest.setAccountId(accountBalanceRequest.getAccountId());
			PrepaidCardDetailResponse prepaidCardDetailResponse=bmClient.prepaidCardService.getPrepaidCardDetail(prepaidCardDetailRequest);
			if(prepaidCardDetailResponse!=null){  
				accountBalanceResponse.setAvailableBalance(prepaidCardDetailResponse.getPrepaidCardAccount().getAvailablePrepaidLimit());
				accountBalanceResponse.setAccountCurrency(prepaidCardDetailResponse.getPrepaidCardAccount().getCurrency().getCode());
			}
		}
	 
		return accountBalanceResponse;
		
	}
	
	OTPGenerationResponse getOTPGenerationResponse(String userLoginProfileId,GenericRequestHeader genericRequestHeader){ 

		String otpTransactionId = java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong();
		OTPGenerationRequest otpGenerationRequest = getBean(OTPGenerationRequest.class, null, null)
		otpGenerationRequest.setLoginProfileId(userLoginProfileId.toLong());
		otpGenerationRequest.setTransactionId(otpTransactionId);
		otpGenerationRequest.setRequestHeader(genericRequestHeader);
		OTPGenerationResponse otpGenerationResponse=bmClient.twoFactorService.otpGeneration(otpGenerationRequest);
		otpGenerationResponse.setTransactionId(otpTransactionId);
		return otpGenerationResponse;
	}
	
	IBUserInformationResponse getUserBranchInformation(Long userLoginProfileId, String accountId)
	{
		IBUserInformationRequest userInformationRequest = getBean(IBUserInformationRequest, null, null);
		userInformationRequest.setIbUserLoginProfileId(userLoginProfileId);
		userInformationRequest.setAccountId(accountId);
		IBUserInformationResponse userInformationResponse = bmClient.serviceRequestService.getUserBranchInformation(userInformationRequest);
		return userInformationResponse;
	}
	
	List<Country> getTenantOperatingCountries()
	{
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		CommonResponse commonResponse=bmClient.iBCommonService.getTenantOperatingCountries(commonRequest);  
		
		List<Country> countries=new ArrayList<Country>(commonResponse.getCommonEntities().size());	   	
		for(GenericEntity genericEntity:commonResponse.getCommonEntities())
		{
			TenantOperatingCountry tenantOperatingCountry=(TenantOperatingCountry)genericEntity;
			countries.add(tenantOperatingCountry.getCountry());
           
		}
				
		return countries;
	}
	
	
	List<TenantBranch> getBranchList()   
	{
		//GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class, null, null);
		GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",null,null);
		genericSRRequest.requestHeader.invocationSource.channelId="RIB"
		genericSRRequest.requestHeader.invocationSource.mainModule="servicerequest"
		GenericSRResponse genericSRResponse=bmClient.serviceRequestService.getBranchList(genericSRRequest);			  
		return genericSRResponse.getBranchList();  
		
	}
	
	
	List<Account> getCreditCardList(String tenantServiceCode)
	{
		//GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class, null, null);
		GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",null,null);
		genericSRRequest.requestHeader.invocationSource.channelId="RIB"
		genericSRRequest.requestHeader.invocationSource.mainModule="servicerequest"
		genericSRRequest.requestHeader.invocationSource.mediaType="WEB"
		
		genericSRRequest.tenantServiceCode = tenantServiceCode;  
		GenericSRResponse genericSRResponse=bmClient.serviceRequestService.getCreditCardList(genericSRRequest);
		return genericSRResponse.getCreditCardList();
		
	}
	
	
	List<Currency> getTenantOperatingCurrencies()
	{
		Invoker invoker=SecurityUtils.getInvoker();
		Map<String,String> requestParams=new HashMap<String, String>(1);

//		requestParams.put("applicationId", invoker.getApplicationId());
		requestParams.put("operatingCountryId",invoker.getOperatingCountryId())
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		commonRequest.setCommonEntityId(invoker.getTenantApplicationId());
		commonRequest.setRequestParams(requestParams);
		CommonResponse commonResponse=bmClient.iBCommonService.getTenantOperatingCurrencies(commonRequest);
		List<Currency> currencies=new ArrayList<Currency>(commonResponse.getCommonEntities().size());
		for(GenericEntity genericEntity:commonResponse.getCommonEntities())
		{
			TenantApplicationCurrency tenantApplicationCurrency=(TenantApplicationCurrency)genericEntity;
			currencies.add(tenantApplicationCurrency.getCurrency());

		}

		return currencies;
	}
	
	List<TenantService> getTenantServices(String moduleName,String businnessFunction,String transactionFlagCode)
	{
		Invoker invoker=SecurityUtils.getInvoker();
		Map<String,String> requestParams=new HashMap<String, String>(4);
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		requestParams.put("module", moduleName);
		requestParams.put("businessFunction", businnessFunction);
		requestParams.put("operatingCountryId",invoker.getOperatingCountryId());
		requestParams.put("transactionFlagCode", transactionFlagCode);  
		commonRequest.setCommonEntityId(invoker.getTenantApplicationId());
		commonRequest.setRequestParams(requestParams);
		CommonResponse commonResponse=bmClient.iBCommonService.getTenantServices(commonRequest);		
		return (List<TenantService>) commonResponse.getCommonEntities();	
		
	}
	
	List <Beneficiary> getBeneficiaries(){
		BeneficiaryRequest beneficiaryRequest = getBean(BeneficiaryRequest.class, null, null);
		beneficiaryRequest.setBeneficiaryCode(beneficiaryRequest.FRIENDS_AND_FAMILY);
		beneficiaryRequest.setBeneStatus("ACT");
		BeneficiaryResponse beneficiaryResponse 	= 	bmClient.beneficiaryService.getBeneficiaries(beneficiaryRequest)
		List<Beneficiary> beneficiaryList			=	new ArrayList<Beneficiary>();
		for(Beneficiary beneficiary		:	beneficiaryResponse.getBeneficiaries()){
			beneficiaryList.add(beneficiary);
		}
		return beneficiaryList;
		}
	List <Biller> getRegisteredBillers(){
		BillerSummaryRequest billerSummaryRequest 	= 	getBean(BillerSummaryRequest.class,null,null);
		BillerSummaryResponse billerSummaryResponse = 	bmClient.billerService.getRegisteredBillerSummmary(BillerSummaryRequest);
		List<Biller> billerList						=	new ArrayList<Biller>();
		for(Biller biller		:	billerSummaryResponse.getRegisteredBillers()){
			billerList.add(biller);
		}
		return billerList;
		}
	
	List <BillerInstruction> getBillerInstructions(billerId,buttonEvent){
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,null,null);
		billerDetailsRequest.setBillerId(billerId);
		billerDetailsRequest.setUserLoginProfileId(getUserLoginProfile().getId());
		billerDetailsRequest.setButtonEvent(buttonEvent);
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getRegisteredBillerDetails(billerDetailsRequest);
		List<BillerInstruction> BillerInstructionList=new ArrayList<BillerInstruction>(billerDetailsResponse.getBillerInstructions());
		return BillerInstructionList;
	}
	/**
	 * 
	 * @return active BillerSummary from IM Call
	 */
	List <Biller> getRegisteredBillerSummmary(){
		BillerSummaryRequest billerSummaryRequest = getBean(BillerSummaryRequest.class,null,null);
		billerSummaryRequest.setUserLoginProfileId(getUserLoginProfile().getId());
		billerSummaryRequest.setCifNumber(invoker.getPrimaryCIF());
		BillerSummaryResponse billerSummaryResponse = bmClient.billerService.getRegisteredBillerSummmary(billerSummaryRequest);
		List<Biller> billerList			=	new ArrayList<Biller>();
		for(Biller biller : billerSummaryResponse.getRegisteredBillers()){
			billerList.add(biller);
		}
		return billerList;
	}
	
	/**
	 * 
	 * @return active BillerSummary from DB
	 */
	List <Biller> getActiveBillerSummmary(){
		BillerSummaryRequest billerSummaryRequest = getBean(BillerSummaryRequest.class,null,null);
		billerSummaryRequest.setUserLoginProfileId(getUserLoginProfile().getId());
		billerSummaryRequest.setCifNumber(invoker.getPrimaryCIF());
		BillerSummaryResponse billerSummaryResponse = bmClient.billerService.getActiveBillerSummmary(billerSummaryRequest);
		List<Biller> billerList			=	new ArrayList<Biller>();
		for(Biller biller : billerSummaryResponse.getRegisteredBillers()){
			billerList.add(biller);
		}
		return billerList;
	}
	
	List <BillerInstruction> getBillerInstructionDetails(Long billerId){
		BillerDetailsRequest billerDetailsRequest = getBean(BillerDetailsRequest.class,null,null);
		billerDetailsRequest.setBillerId(billerId);
		billerDetailsRequest.setUserLoginProfileId(getUserLoginProfile().getId());
		BillerDetailsResponse billerDetailsResponse = bmClient.billerService.getRegisteredBillerDetails(billerDetailsRequest);
		List<BillerInstruction> billerInstructionList			=	new ArrayList<BillerInstruction>();
		for(BillerInstruction billerInstruction : billerDetailsResponse.getBillerInstructions()){
			billerInstructionList.add(billerInstruction);
		}
		return billerInstructionList;
		}
	List<BeneficiaryInstruction> getFriendsAndFamilyAccount(Long beneId)
	{
		FriendsAndFamilyAccountRequest  friendsAndFamilyAccountRequest=getBean(FriendsAndFamilyAccountRequest.class, null, null);
		friendsAndFamilyAccountRequest.setBeneId(beneId)
		FriendsAndFamilyAccountResponse friendsAndFamilyAccountResponse=bmClient.paymentService.getFriendsAndFamilyAccounts(friendsAndFamilyAccountRequest);
		List<BeneficiaryInstruction> friendsAndFamilyInstructionList=new ArrayList<BeneficiaryInstruction>(friendsAndFamilyAccountResponse.getBeneficiaryInstruction());
		return friendsAndFamilyInstructionList;
	}
	
	/**
	 * User to calculate Charges for applicable Modules
	 * 
	 * @param params
	 * @param requestHeader
	 * @param model
	 * @return
	 * @throws
	 */
	def getCharges(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		Object requiredTypeObject = null;
		String requestClassName = params.requestClassName;
		if (requestClassName){
			requiredTypeObject = Class.forName(requestClassName).newInstance();
			if(requiredTypeObject!=null && requiredTypeObject instanceof ChequeBookRequest)
			{
				ChequeBookRequest chequeBookRequest = (ChequeBookRequest)requiredTypeObject;
				chequeBookRequest.setAccountId(params.accountId);
				chequeBookRequest.setRequestHeader(requestHeader);
				ChargeResponse chargeResponse = bmClient.iBCommonService.getCharges(chequeBookRequest);
				model << [chargeResponse:chargeResponse];
				
			}
			else if(requiredTypeObject!=null && requiredTypeObject instanceof FundTransferRequest)
			{
					FundTransferRequest fundTransferRequest=new FundTransferRequest();
					fundTransferRequest.setFromAccountId(params.fromAccountId)
					fundTransferRequest.setToAccountId(params.toAccountId)
					fundTransferRequest.setTransferCurrencyID(params.currencyId)
					fundTransferRequest.setPaymentAmount(params.paymentAmount?.toBigDecimal())
					fundTransferRequest.setRequestHeader(requestHeader);
					ChargeResponse chargeResponse = bmClient.iBCommonService.getCharges(fundTransferRequest);
					model << [chargeResponse:chargeResponse];
			}
			
		}
		
	}

	/**
	 * 
	 * @param type
	 * @return
	 */
	List<GenericEntity> getMessageSubject(String tenantlookupcode){
		IBCommonResponse ibCommonResponse = new IBCommonResponse()
		IBCommonRequest ibCommonRequest = getBean(IBCommonRequest.class, null, null);
		Map<String,Object> filterParams = new HashMap<String, Object>()
		filterParams.put("TENANT_LOOKUP_CODE",tenantlookupcode);
		ibCommonRequest.setIbFilterParams(filterParams);
		ibCommonResponse = bmClient.iBCommonService.getMessageSubject(ibCommonRequest);
		return ibCommonResponse.getCommonEntities();
	}
	
	/**
	 *
	 * @param accountIdVesrion
	 * @return BeneficiaryInstruction
	 */
	def BeneficiaryInstruction getUserAccount(String accountIdVesrion)
	{
		CommonRequest commonRequest=getBean(CommonRequest.class,"commonRequest", null, null);
		commonRequest.setCommonEntityId(accountIdVesrion?.split(",")[0].toLong());
		CommonResponse commonResponse=bmClient.iBCommonService.getUserAccount(commonRequest);
		 return (BeneficiaryInstruction)commonResponse.getCommonEntity();
	}
	
	/**
	 *
	 * @param beneInsIdVesrion
	 * @return BeneficiaryInstruction
	 */
	def BeneficiaryInstruction getFFAccount(String beneInsIdVesrion)
	{
		CommonRequest commonRequest= getBean(CommonRequest.class,"commonRequest",null, null);
		commonRequest.setCommonEntityId(beneInsIdVesrion?.split(",")[0].toLong());
		CommonResponse commonResponse=bmClient.iBCommonService.getBeneInstruction(commonRequest);
		 return (BeneficiaryInstruction)commonResponse.getCommonEntity();
	}
	/**
	 *
	 * @param currencyIdVersion
	 * @return Currency
	 */
	def com.vayana.bm.core.api.model.common.Currency getCurrency(String currencyIdVersion)
	{
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		commonRequest.setCommonEntityId(currencyIdVersion?.split(",")[0].toLong());
		CommonResponse commonResponse=bmClient.iBCommonService.getCurrency(commonRequest);
		 return (com.vayana.bm.core.api.model.common.Currency)commonResponse.getCommonEntity();
	}
	
	/**
	 *
	 * @param lookupvalueIdVersion
	 * @return LookupValue
	 */
	def LookupValue getAccounttype(String lookupvalueIdVersion)
	{
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		commonRequest.setCommonEntityId(lookupvalueIdVersion?.split(",")[0].toLong());
		CommonResponse commonResponse=bmClient.iBCommonService.getAccounttype(commonRequest);
		 return (LookupValue)commonResponse.getCommonEntity();
	}
	
	
	
/*	List<TenantApplicationLocale> getTenantApplicationLocales()
	{
		Invoker invoker=SecurityUtils.getInvoker();
		Map<String,String> requestParams=new HashMap<String, String>(1);		
		requestParams.put("tenantApplicationId", invoker.getTenantApplicationId());
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		commonRequest.setCommonEntityId(invoker.getTenantApplicationId());
		commonRequest.setRequestParams(requestParams);
		CommonResponse commonResponse=bmClient.iBCommonService.getTenantApplicationLocales(commonRequest);
		
		List<TenantApplicationLocale> tenantApplicationLocale = commonResponse.getCommonEntities();
				
		return tenantApplicationLocale;
	}*/
	
	
	List<TenantApplicationLocale> getTenantApplicationLocales(String defaultLocaleFlag)
	{
		Invoker invoker=SecurityUtils.getInvoker();
		Map<String,String> requestParams=new HashMap<String, String>(1);
		requestParams.put("tenantApplicationId", invoker.getTenantApplicationId());
		requestParams.put("defaultLocaleFlag", defaultLocaleFlag);
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		commonRequest.setCommonEntityId(invoker.getTenantApplicationId());
		commonRequest.setRequestParams(requestParams);
		CommonResponse commonResponse=bmClient.iBCommonService.getTenantApplicationLocales(commonRequest);
		
		List<TenantApplicationLocale> tenantApplicationLocale = commonResponse.getCommonEntities();
				
		return tenantApplicationLocale;
	}
	
	List<TenantLookupValue> getTenantLookUpValuesByType(String lookupTypeCode){ 
		Invoker invoker=SecurityUtils.getInvoker();     
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		Map<String,Object> requestParams=new HashMap<String, Object>(2);
		requestParams.put("tenantLookTypeCode", lookupTypeCode)
		requestParams.put("channelCode", "WEB")
		commonRequest.setRequestParams(requestParams);
		CommonResponse commonResponse=bmClient.iBCommonService.getTenantLookUpValuesByType(commonRequest);
		return (List<TenantLookupValue>)commonResponse.getCommonEntities()
	}
	
	/**
	 * 
	 * @param billerInsIdVesrion
	 * @return BillerInstruction
	 */
	def BillerInstruction getBPAccount(String billerInsIdVesrion)
	{
		CommonRequest commonRequest=getBean(CommonRequest.class,"commonRequest", null, null);
		commonRequest.setCommonEntityId(billerInsIdVesrion?.split(",")[0].toLong());
		CommonResponse commonResponse=bmClient.iBCommonService.getBillerInstruction(commonRequest);
		return (BillerInstruction)commonResponse.getCommonEntity();

	}
	
	def BillerData getBillerNumber(String billerInsIdVesrion)
	{
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		commonRequest.setCommonEntityId(billerInsIdVesrion?.split(",")[0].toLong());
		CommonResponse commonResponse=bmClient.iBCommonService.getBillerNumber(commonRequest);
		return (BillerData)commonResponse.getCommonEntity();
	}
		
	def GenericEntity getBillerService(String billerServiceIdVersion)
	{
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		commonRequest.setCommonEntityId(billerServiceIdVersion?.split(",")[0].toLong());
		CommonResponse commonResponse=bmClient.iBCommonService.getBillerService(commonRequest);
		return commonResponse.getCommonEntity();
	}
	
	def String getWorkflowUserActivityByProcessInstanceId(String processInstanceId)
	{
		CommonRequest commonRequest		=	getBean(CommonRequest.class, null, null);
		commonRequest.setEntityId(processInstanceId);
		CommonResponse commonResponse	=	bmClient.iBCommonService.getWorkflowUserActivityByProcessInstanceId(commonRequest);
		WorkflowUserActivity wua 		=	(WorkflowUserActivity)commonResponse.getCommonEntity();
		return wua?.getTaskInstanceId();
	}
	def userIdAutoCompleter(Map params,GenericRequestHeader requestHeader,ModelMap model){
		CommonRequest commonRequest=getBean(CommonRequest.class, requestHeader, null);
		def requestParams=["filterParam":params?.term];
		commonRequest.setRequestParams(requestParams);
		CommonResponse commonResponse=bmClient.iBCommonService.getAllUserIds(commonRequest);
		model<<[commonResponse:commonResponse]
	}
	
	CommonResponse getSecureColorForUser(Long userLoginProfile,Long tenantApplicationId)
	{
		CommonRequest commonRequest=getBean(CommonRequest.class, null, null);
		commonRequest.setAttribute("userLoginprofileId",userLoginProfile);
		commonRequest.setAttribute("tenantApplicationId",tenantApplicationId);
		CommonResponse commonResponse=bmClient.iBUserService.getSecureColorForUser(commonRequest); 
		return commonResponse;
	}
	
		List<QuestionBasket> getSecretQuestionForUser(Long userLoginProfile){
			IBCommonRequest ibCommonRequest = getBean(IBCommonRequest.class, null, null);
			ibCommonRequest.setCommonEntityId(userLoginProfile)
			IBCommonResponse ibCommonResponse = bmClient.iBUserService.getSecretQuestionForUser(ibCommonRequest);  
			List<QuestionBasketDetail> questionBasketDetails = ibCommonResponse.getCommonEntities();  
			
		return questionBasketDetails;    
	}
	/**
	 * @author elanchezhiyan
	 * @param fromCurrency
	 * @param toCurrency
	 * @param amount
	 * @param requestHeader
	 * @return
	 */
	public ExchangeRateResponse getExchangeCalculator(String fromCurrency,String toCurrency,String amount,String currencyIndicator,GenericRequestHeader requestHeader){
		ExchangeRateRequest request		=	getBean(ExchangeRateRequest.class, requestHeader, null);
		//IBUserProfileResponse upr		= 	getIBUserProfileDetails(request.getRequestHeader().getInvoker().getUserLoginProfileId());
		request.cifNumber				=	requestHeader?.invoker?.primaryCIF //upr?.ibUserProfile?.primaryUserCif?.customerIdentifier?.cifNumber;
		request.fromCurrency 			=	fromCurrency;
		request.toCurrency 				=	toCurrency;
		request.transferAmount			=	(StringUtils.hasText(amount)) ? amount :'1';
		request.transferCurrency		=	currencyIndicator;
		ExchangeRateResponse response	=	bmClient.accountService.getExchangeRate(request);
		return response;
	}
	/**
	 * @author elanchezhiyan
	 * @param fromCurrIsoCode
	 * @param toCurrIsoCode
	 * @param amount
	 * @param requestHeader
	 * @return
	 */
	public ExchangeRateResponse fetchExchangeCalc(String fromCurrIsoCode,String toCurrIsoCode,String amount,GenericRequestHeader requestHeader){
		ExchangeRateRequest request		=	getBean(ExchangeRateRequest.class, requestHeader, null);
		request.cifNumber				=	requestHeader?.invoker?.primaryCIF
		request.fromCurrency 			=	fromCurrIsoCode;
		request.transferAmount			=	(StringUtils.hasText(amount)) ? amount :'1';
		request.transferCurrency		=	toCurrIsoCode;
		ExchangeRateResponse response	=	bmClient.accountService.getExchangeRate(request);
		return response;
	}
	/**
	 * @author elanchezhiyan
	 * @param currencyISOCode
	 * @return
	 */
	public String getCurrencyFormat(String currencyISOCode){
		int currencyLength = currencyISOCode.length();
		if(currencyLength == 1){
			currencyISOCode = "00"+currencyISOCode;
		}else if(currencyLength == 2){
			currencyISOCode = "0"+currencyISOCode;
		}
		return currencyISOCode;
	}
	
	public String encryptData(String plainValue)
	{
		String iv = grailsApplication.config.security.aes.iv;
		String salt = grailsApplication.config.security.aes.salt;
		String passPhrase = grailsApplication.config.security.aes.passPhrase;
		int keySize = grailsApplication.config.security.aes.keySize;
		int iterations = grailsApplication.config.security.aes.iterations;
		String cipherText = "";
		AesUtil util = new AesUtil(keySize, iterations);
		cipherText = util.encrypt(salt, iv, passPhrase, plainValue);
		return cipherText;
		
	}
	
	public String decryptData(String cipherText)
	{
		String iv = grailsApplication.config.security.aes.iv;
		String salt = grailsApplication.config.security.aes.salt;
		String passPhrase = grailsApplication.config.security.aes.passPhrase;
		int keySize = grailsApplication.config.security.aes.keySize;
		int iterations = grailsApplication.config.security.aes.iterations;
		String plainVaue = "";
		AesUtil util = new AesUtil(keySize, iterations);
		plainVaue = util.decrypt(salt, iv, passPhrase, cipherText);
		return plainVaue;
		
	}
	
	public Currency getBaseCurrency(Long operatingCountryId) {
		Currency baseCurrency = null;
		CommonRequest  commonRequest = getBean(CommonRequest.class,null,null);
		CommonResponse commonResponse = bmClient.iBCommonService.fetchBaseCurrency(commonRequest);
		baseCurrency = (Currency)commonResponse.getCommonEntity();
		return baseCurrency;
	}
	/**
	 * @author elanchezhiyan
	 */
	def maskCreditCardNumber(String ccnum){
		
		return maskCardNumber(ccnum,"######XXXXXX####");
	}
	/**
	 * Applies the specified mask to the card number.
	 *
	 * @param cardNumber The card number in plain format
	 * @param mask The number mask pattern. Use # to include a digit from the
	 * card number at that position, use x to skip the digit at that position
	 *
	 * @return The masked card number
	 */
	public static String maskCardNumber(String cardNumber, String mask) {

		// format the number
		int index = 0;
		StringBuilder maskedNumber = new StringBuilder();
		for (int i = 0; i < mask.length(); i++) {
			char c = mask.charAt(i);
			if (c == '#') {
				maskedNumber.append(cardNumber.charAt(index));
				index++;
			} else if (c == 'X') {
				maskedNumber.append(c);
				index++;
			} else {
				maskedNumber.append(c);
			}
		}

		// return the masked number
		return maskedNumber.toString();
	}
	
	public List<Account> getUserDAPDetails(Long userLoginProfileId,String serviceCode)
	{
		List<Account> resultList = new ArrayList<Account>();
		CommonRequest commonRequest = getBean(CommonRequest.class, null, null);
		Long tenantApplicationId = SecurityUtils.getInvoker().getTenantApplicationId();
		Map requestParams  = new HashMap();
		requestParams.put("ULP", userLoginProfileId);
		requestParams.put("serviceCode",serviceCode);
		requestParams.put("tenantApplicationId",tenantApplicationId);
		commonRequest.setRequestParams(requestParams);
		CommonResponse resp = bmClient.iBCommonService.getUserDAPDetails(commonRequest);
		
		if(resp.getCommonEntities()!=null && !resp.getCommonEntities().isEmpty())
		{
			resultList = (List<Account>)resp.getCommonEntities(); 
		}
		return resultList;
	}
	
	List<BeneficiaryInstruction> getOwnAcountBeneIns(popType) {
		OwnAccountRequest ownAccountRequest=getBean(OwnAccountRequest.class, null, null);
		ownAccountRequest.setIbUserLoginProfileId(getUserLoginProfile().getId());
		ownAccountRequest.setAccountFilterEnum(AccountFilterEnum.valueOf(popType));
		OwnAccountResponse ownAccountResponse=bmClient.paymentService.getOwnAccounts(ownAccountRequest);
		List<BeneficiaryInstruction> beneficiaryInstructionList = new ArrayList<BeneficiaryInstruction>(ownAccountResponse.getBeneficiaryInstruction());
		
		return beneficiaryInstructionList;
	}
	
	public String getRejectionReasonForEntityId(String entityId,String createdBy){ 
		CommonRequest commonRequest			=	getBean(CommonRequest.class, null, null);
		commonRequest.setEntityId(entityId);
		if(StringUtils.hasText(createdBy)){      
			commonRequest.setCustomerULPId(createdBy);     
		}else{
			commonRequest.setCustomerULPId(SecurityUtils.invoker?.userLoginProfileId?.toString());
		}
		CommonResponse commonResponse		=	bmClient.iBCommonService.getWorkflowUserActivityByEntityIdAndStatus(commonRequest);
		WorkflowUserActivity wuat			=	(WorkflowUserActivity)commonResponse?.getCommonEntity();
		String processInstanceId			=	wuat?.getProcessInstanceId();
		List<CommentEntity> commentEntityObj	= 	workflowService.viewHistoricDetailByProcessInstanceId(processInstanceId);
		String rejectionComment				= !CollectionUtils.isEmpty(commentEntityObj) ? commentEntityObj[0]?.fullMessage : null;
		return rejectionComment;
	}
	
	UserLoginProfile getUserLoginProfileDetails(Long userLoginProfileId){
		
		return ibUserUtil.getUserLoginProfile(userLoginProfileId);
	}
	
	List<DepositDetail> fetchDepositTypes(){
		CommonRequest commonRequest			=	getBean(CommonRequest.class, null, null);
		CommonResponse res	=bmClient.serviceRequestService.fetchDepositTypes(commonRequest);
		return (List<DepositDetail>)res.getCommonEntities();
	}
	
	def fetchAccountBalance(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		AccountBalanceRequest accountBalanceRequest=getBean(AccountBalanceRequest.class, requestHeader, null);
		accountBalanceRequest.accountId= getIdVersion(params?.accountIdVersion)[0];
		AccountBalanceResponse accountBalanceResponse= getAccountBalance(accountBalanceRequest);
		setSessionAttribute("_BAL", accountBalanceResponse)
		model<<[accountBalanceModel:accountBalanceResponse]
	}
	
}