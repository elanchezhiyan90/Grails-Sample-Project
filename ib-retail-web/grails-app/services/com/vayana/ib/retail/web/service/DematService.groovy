package com.vayana.ib.retail.web.service

import java.util.Map;

import javax.servlet.ServletContext
import javax.servlet.http.HttpSession

import org.apache.http.NameValuePair
import org.apache.http.client.utils.URIBuilder
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.ui.ModelMap;
import org.springframework.web.context.request.RequestContextHolder

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.core.api.beans.common.GenericRequestHeader;
import com.vayana.bm.core.api.beans.common.Invoker
import com.vayana.bm.core.api.constants.LookupCodeConstants
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.model.user.UserLoginProfile;
import com.vayana.ib.bm.core.api.beans.account.AccountSummaryRequest
import com.vayana.ib.bm.core.api.beans.account.AccountSummaryResponse
import com.vayana.ib.bm.core.api.beans.demat.DematRedirectRequest
import com.vayana.ib.bm.core.impl.service.util.AesUtil;
import com.vayana.ib.bm.core.impl.service.util.BaseCommonUtil;






class DematService {
	
	static Logger logger = LoggerFactory.getLogger(DematService.class);
	
	BaseCommonUtil baseCommonUtil;
 
	private @Value('${ib.demat.service.url}') String dematServiceUrl;
	
	private @Value('${ib.demat.checksum.key}') String _CHECKSUMKEY;
	
	
	static String _msgKeyName = "msg";
	
	
			
/*    Boolean isBillDeskAlive() {
		MyHttpClientBuilder httpClientBuilder 			= new MyHttpClientBuilder();
		BillDeskServiceAvailValidationRequest req 		= new BillDeskServiceAvailValidationRequest();
		List<NameValuePair> nameValuePairs 				= new ArrayList<NameValuePair>(2);
		req.setChecksum(getChecksumFromMsg(req.getFormatedMessage()))
		nameValuePairs.add(httpClientBuilder.createPostParmeter(_actionKeyName, "service_check"));
		nameValuePairs.add(httpClientBuilder.createPostParmeter(_msgKeyName, req.getFormatedMessage()));
		String billDeskServerResponse 					= invokeBillDeskService(billDeskServiceUrl,nameValuePairs); //httpClientBuilder.execute(billDeskServiceUrl, nameValuePairs);
		BillDeskServiceAvailValidationResponse	res	    = new BillDeskServiceAvailValidationResponse(billDeskServerResponse);
		//Check the Response Content for Service Available
		if("0811".equals(res?.messageCode) && "Y".equals(res?.alive)){
			return true;
		}
		return false;
	}*/
	
	String getLoginRequestParams(){

		DematRedirectRequest req	=	new DematRedirectRequest();
		Invoker invoker 			= 	null;
		invoker 					=  	SecurityUtils.getInvoker();
		logger.info("getLoginRequestParams:invoker?.primaryCIF ="+invoker?.primaryCIF)
		logger.info("getLoginRequestParams:invoker?.sessionId ="+invoker?.sessionId)
		logger.info("getLoginRequestParams:invoker?.getUserLoginProfileId() ="+invoker?.userLoginProfileId)
		if(invoker != null && invoker?.primaryCIF != null && invoker?.sessionId != null)
		{
			req.setCustNumber(invoker?.primaryCIF)
		//	req.setTraceNumber(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString())
			req.setSessionId(invoker?.sessionId)
			req.setToken(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString())
			URIBuilder uriBuilder 		= 	new URIBuilder();
			uriBuilder.addParameter("CustomerNumber", req.getCustNumber());
			uriBuilder.addParameter("sessionid", req.getSessionId());
			uriBuilder.addParameter("token", req.getToken());
			
			return uriBuilder.build().toString();
		}
		return null;
	}
	
	
      String getDematEncryption() {
		
		  DematRedirectRequest req	=	new DematRedirectRequest();
		String iv = "F27D5C9927726BCEFE7510B1BDD3D137";
		String salt = "3FF2EC019C627B945225DEBAD71A01B6985FE84C95A70EB132882F88C0A59A55";
		String passPhrase = "PMCBSECRETTEXT";
		int keySize=128;
		int iterationCount=1024;
		Invoker invoker 			= 	null;
		invoker 					=  	SecurityUtils.getInvoker();
		AesUtil aesutil = new AesUtil(keySize, iterationCount);
		long current = System.currentTimeMillis();
		String customerNumber = invoker?.primaryCIF;
		String plainText = customerNumber + String.valueOf(current);
		//System.out.println("Plain Text Value ---> "+plainText);
		String encryptedValue = aesutil.encrypt(salt, iv, passPhrase, plainText);
		//System.out.println("Encrypted Value ---> "+encryptedValue);
		String decryptedValue = aesutil.decrypt(salt, iv, passPhrase, encryptedValue);
		//System.out.println("Encrypted Value ---> "+decryptedValue);
		if(invoker != null && invoker != null)
		{
			//req.setCustNumber(invoker?.primaryCIF)
		//	req.setTraceNumber(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString())
			req.setPlainText(plainText);
			req.setEncryptedValue(encryptedValue);
	        req.setDecryptedValue(decryptedValue);
			URIBuilder uriBuilder 		= 	new URIBuilder();
			//uriBuilder.addParameter("CustomerNumber", req.getCustNumber());
			uriBuilder.addParameter("customerid", req.getPlainText());
			uriBuilder.addParameter("encryptedValue", req.getEncryptedValue());
			uriBuilder.addParameter("decryptedValue", req.getEncryptedValue());
			
			return uriBuilder.build().toString();
		}
		
		return null;
	}
	  
	  
	  
	  def demattwofaView(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
	  
	  }
	  
	  def dematOTP(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
	  
	  }
	
	/*Boolean isValidLoginRequest(Map loginReqDataMap,LoginReqValidationRequest req){
		String sessionCrn 			= (String)loginReqDataMap?.get("CRN");
		String sessionTraceNo		= (String)loginReqDataMap?.get("TRACENO");
		String sessionSessionId		= (String)loginReqDataMap?.get("SESSIONID");
		String sessionToken			= (String)loginReqDataMap?.get("TOKEN");
		String requestCrn 			= req?.getCrnNumber();
		String requestTraceNo		= req?.getTraceNumber();
		String requestSessionId		= req?.getSessionId();
		String requestToken			= req?.getToken();
		
		logger.info ("isValidLoginRequest : sessionCrn=" +sessionCrn)
		logger.info ("isValidLoginRequest : sessionTraceNo="+sessionTraceNo)
		logger.info ("isValidLoginRequest : sessionSessionId="+sessionSessionId)
		logger.info ("isValidLoginRequest : sessionToken="+sessionToken)
		logger.info ("isValidLoginRequest : requestCrn=" +requestCrn)
		logger.info ("isValidLoginRequest : requestTraceNo="+requestTraceNo)
		logger.info ("isValidLoginRequest : requestSessionId="+requestSessionId)
		logger.info ("isValidLoginRequest : requestToken="+requestToken)
		logger.info ("isValidLoginRequest : sessionCrn?.equals(requestCrn)="+sessionCrn?.equals(requestCrn))
		logger.info ("isValidLoginRequest : sessionTraceNo?.equals(requestTraceNo)="+sessionTraceNo?.equals(requestTraceNo))
		logger.info ("isValidLoginRequest : sessionSessionId?.equals(requestSessionId)="+sessionSessionId?.equals(requestSessionId))
		logger.info ("isValidLoginRequest : sessionToken?.equals(requestToken)="+sessionToken?.equals(requestToken))
		
		
		
		//if(requestCrn != null && requestTraceNo != null && requestSessionId !=null && requestToken !=null){
			//if(sessionCrn != null && sessionTraceNo !=null && sessionSessionId!=null && sessionToken!=null){
				if(sessionCrn?.equals(requestCrn) && sessionTraceNo?.equals(requestTraceNo) && sessionSessionId?.equals(requestSessionId) && sessionToken?.equals(requestToken)){
					logger.info ("isValidLoginRequest : Passed")
					return true;
				}
			//}
		//}
		logger.info ("isValidLoginRequest : Failed")
		return true;  //TODO FIX ME
	}
	
	Boolean isUserSessionAvailable(Map loginReqDataMap,IBServiceAvailValidationRequest req){
		String sessionCrn 			= (String)loginReqDataMap?.get("CRN");
		String sessionSessionId		= (String)loginReqDataMap?.get("SESSIONID");
		logger.info ("isUserSessionAvailable : sessionCrn="+sessionCrn)
		logger.info ("isUserSessionAvailable : sessionSessionId="+sessionSessionId)
		String requestCrn 			= req?.getCrnNumber();
		String requestSessionId		= req?.getSessionId();
		logger.info ("isUserSessionAvailable : requestCrn="+requestCrn)
		logger.info ("isUserSessionAvailable : requestSessionId="+requestSessionId)
		
		if(requestCrn != null && requestSessionId != null){
			if(sessionCrn != null && sessionSessionId!=null){
				if(sessionCrn?.equals(requestCrn) && sessionSessionId?.equals(requestSessionId)){
					logger.info ("isUserSessionAvailable : Passed")
					return true;
				}
			}
		}
		logger.info ("isUserSessionAvailable : Failed")
		return true; //TODO FIX ME
	}
	
	
	Boolean isUserSessionAvailable(Map loginReqDataMap,IBSessionAvailabilityRequest req){
		logger.info ("IBSessionAvailabilityRequest : Starts");
		String sessionCrn 			= (String)loginReqDataMap?.get("CRN");
		String sessionSessionId		= (String)loginReqDataMap?.get("SESSIONID");
		logger.info ("isUserSessionAvailable : sessionCrn="+sessionCrn)
		logger.info ("isUserSessionAvailable : sessionSessionId="+sessionSessionId)
		String requestCrn 			= req?.getCrnNumber();
		String requestSessionId		= req?.getSessionId();
		logger.info ("isUserSessionAvailable : requestCrn="+requestCrn)
		logger.info ("isUserSessionAvailable : requestSessionId="+requestSessionId)
		
		if(requestCrn != null && requestSessionId != null){
			if(sessionCrn != null && sessionSessionId!=null){
				if(sessionCrn?.equals(requestCrn) && sessionSessionId?.equals(requestSessionId)){
					logger.info ("isUserSessionAvailable : Passed")
					return true;
				}
			}
		}
		logger.info ("isUserSessionAvailable : Failed")
		return true; //TODO FIX ME
	}
	
	
	LoginReqValidationResponse loginValidation(LoginReqValidationRequest req){
		LoginReqValidationResponse	res			= new LoginReqValidationResponse();
		//TODO SENBA
		//Validate CIF, Session ID, Trace No which is sent in login request with Session Values
		logger.info ("loginValidation : req?.getSessionId() ="+req?.getSessionId())
		HttpSession userSession		= getSessionById(req?.getSessionId())
		logger.info ("loginValidation : userSession ="+userSession)
		Map loginReqDataMap 		= getAttributeBySession(userSession, "_LOGINREQDATA")
		logger.info ("loginValidation : loginReqDataMap ="+loginReqDataMap)
		Boolean checkRequest 		= isValidLoginRequest(loginReqDataMap, req)
		logger.info ("loginValidation : checkRequest ="+checkRequest)
		if(checkRequest){
			res.setValid("Y")
			//If Valid Set the Account no and Availble balance in the response, rewrite the _LOGINREQDATA session data or remove if invalid
			String userULPID = (String)loginReqDataMap?.get("ULPID")
			String segmentCode = (String)loginReqDataMap?.get("SEGMENTCODE")
			String accountsInfo 			= getActiveAccountsWithBalance(req.crnNumber,userULPID,segmentCode);
			String [] accountsInfoParams 	= null;
			if(accountsInfo !=""){
				accountsInfoParams 			= 	accountsInfo?.split("\\|");
				if(accountsInfoParams != null){
					res.setNoOfAccounts(accountsInfoParams[0])
					res.setAccountNumbers(accountsInfoParams[1]);
					res.setBalance(accountsInfoParams[2]);
				}
			}
			
			res.setCrnNumber(req.crnNumber); 	//TODO
			String userContactInfo 			= getMobileNoAndEmail(userULPID);
			String [] userContactInfoParams = null;
			if(userContactInfo != null){
				userContactInfoParams		= userContactInfo?.split("\\|");
				res.setMobileNumber(userContactInfoParams[0]);
				res.setEmailId(userContactInfoParams[1]);
			}else{
				res.setMobileNumber("NA"); 	//TODO
				res.setEmailId("NA");		 	//TODO
			}
			
			
		}else{
			res.setValid("N")
			res.setErrorCode("BP001");
		}
		res.setChecksum(getChecksumFromMsg(res.formatedMessage));
		return res;
	}
	
	IBServiceAvailValidationResponse ibServiceAvailCheck(IBServiceAvailValidationRequest req){
		IBServiceAvailValidationResponse res	= new IBServiceAvailValidationResponse();
		//TODO SENBA Validate the session availability against Session Data
		logger.info ("ibServiceAvailCheck : req?.getSessionId() ="+req?.getSessionId())
		HttpSession userSession		= getSessionById(req?.getSessionId())
		logger.info ("ibServiceAvailCheck : userSession ="+userSession)
		Map loginReqDataMap 		= getAttributeBySession(userSession, "_LOGINREQDATA")
		logger.info ("ibServiceAvailCheck : loginReqDataMap ="+loginReqDataMap)
		Boolean checkRequest 		= isUserSessionAvailable(loginReqDataMap, req)
		logger.info ("ibServiceAvailCheck : checkRequest ="+checkRequest)
		if(checkRequest){
			res.setAlive("Y")
		}else{
			res.setAlive("N")
		}
		res.setTraceNumber(req.getTraceNumber())
		res.setCrnNumber(req.getCrnNumber()) //CRN Validation needs to be done :: TODO
		res.setChecksum(getChecksumFromMsg(res.formatedMessage));
		return res;
	}
	
	DebitReqValidationResponse debitRequestValidate(DebitReqValidationRequest req){
		MyHttpClientBuilder httpClientBuilder 		= 	new MyHttpClientBuilder();
		List<NameValuePair> nameValuePairs 			= 	new ArrayList<NameValuePair>(2);
		DebitRequest debitReq 						= 	(DebitRequest) getSessionAttribute("_DEBITREQDATA");
		if(debitReq != null){
			req.setTraceNumber(debitReq?.getTraceNumber());
		}
		
		req.setChecksum(getChecksumFromMsg(req.getFormatedMessage()))
		nameValuePairs.add(httpClientBuilder.createPostParmeter(_actionKeyName, "valid_session"));
		nameValuePairs.add(httpClientBuilder.createPostParmeter(_msgKeyName, req.getFormatedMessage()));
		String debitReqValidationResponse 				=	invokeBillDeskService(billDeskServiceUrl,nameValuePairs);
		DebitReqValidationResponse res					=  new DebitReqValidationResponse(debitReqValidationResponse);
		
		Map debitReqMap = new HashMap()
		debitReqMap.put("USERACCOUNT", res.bankAccountNumber)
		debitReqMap.put("USERCIF", res.crnNumber)
		getSession().setAttribute("_DEBITREQDATA",debitReqMap);
		return res;
	}
	
	PaymentIntimationResponse paymentIntimation(PaymentIntimationRequest req){
		MyHttpClientBuilder httpClientBuilder 			= 	new MyHttpClientBuilder();
		List<NameValuePair> nameValuePairs 				= 	new ArrayList<NameValuePair>(2);
		req.setChecksum(getChecksumFromMsg(req.getFormatedMessage()))
		nameValuePairs.add(httpClientBuilder.createPostParmeter(_actionKeyName, "pymt_ack"));
		nameValuePairs.add(httpClientBuilder.createPostParmeter(_msgKeyName, req.getFormatedMessage()));
		String paymentIntimationResponse 				=	invokeBillDeskService(billDeskServiceUrl,nameValuePairs);
		PaymentIntimationResponse res					=	new PaymentIntimationResponse();
		return res;
	}
	
	IBSessionAvailabilityResponse ibSessionAvailCheck(IBSessionAvailabilityRequest req){
		IBSessionAvailabilityResponse res	= new IBSessionAvailabilityResponse();
		//TODO SENBA Validate the session availability against Session Data
		HttpSession userSession		= getSessionById(req?.getSessionId())
		Map loginReqDataMap 		= getAttributeBySession(userSession, "_LOGINREQDATA")
		Boolean checkRequest 		= isUserSessionAvailable(loginReqDataMap, req)
		if(checkRequest){
			res.setValid("Y")
		}else{
			res.setValid("N")
		}
		res.setCrnNumber(req.getCrnNumber()) //CRN Validation needs to be done :: TODO
		res.setChecksum(getChecksumFromMsg(res.formatedMessage));
		return res;
	}
	
	PaymentIntimationResponse sendPaymentIntimation(String coreRef, String errorCode, String traceNumber){
		PaymentIntimationRequest req					=	new PaymentIntimationRequest();
		req.bankReferenceNo = coreRef;
		req.traceNumber		= traceNumber;
		req.errorCode		= errorCode;
		req.setChecksum(req.getFormatedMessage())
		MyHttpClientBuilder httpClientBuilder 			= 	new MyHttpClientBuilder();
		List<NameValuePair> nameValuePairs 				= 	new ArrayList<NameValuePair>(2);
		nameValuePairs.add(httpClientBuilder.createPostParmeter(_actionKeyName, "pymt_ack"));
		nameValuePairs.add(httpClientBuilder.createPostParmeter(_msgKeyName, req.getFormatedMessage()));
		String paymentIntimationResponse 				=	invokeBillDeskService(billDeskServiceUrl,nameValuePairs);
		PaymentIntimationResponse res					=	new PaymentIntimationResponse();
		return res;
	}
	
	String invokeBillDeskService(String url, List<NameValuePair> nameValuePairs){
		MyHttpClientBuilder httpClientBuilder 	= 	new MyHttpClientBuilder();
		String httpPostResponse 				=	httpClientBuilder.execute(url, nameValuePairs);
		return httpPostResponse;
	}
	
	String getActiveAccountsWithBalance(String cif,String userULPID,String segmentCode){
		String strRes 							= 	"";
		AccountSummaryRequest accountSummary    = 	new AccountSummaryRequest();
		BillPayUtil billPayUtil					=	new BillPayUtil();
		accountSummary.requestHeader			=	billPayUtil.prepareAccountSummaryHeader()
		accountSummary.getRequestHeader().getInvoker().setUserLoginProfileId(Long.parseLong(userULPID));
		accountSummary.getRequestHeader().getInvoker().setSegmentCode(segmentCode);
		logger.info("getActiveAccountsWithBalance:invoker?.primaryCIF---------------------"+cif)
		logger.info("getActiveAccountsWithBalance:invoker?.userLoginProfileId---------------------"+userULPID)
		logger.info("getActiveAccountsWithBalance:invoker?.segmentCode---------------------"+segmentCode)
		accountSummary.getCifBranchMapping().put(cif, "001");
		accountSummary.setBusinessFunction("getcustomacctinq");
		AccountSummaryResponse res 				= null;
		
		try{
			res 				=	billPayBmClient.accountService.getAccountsForCIF(accountSummary)
			logger.info (res.dump())
			String strAccount	="";
			String strBalance	="";
			int accountCount 	=0;
			res.userAccount.each {
						strAccount = strAccount != "" ? strAccount + "~" + it.accountNumber : it.accountNumber;
						strBalance = strBalance != "" ? strBalance + "~" + it.availableBalance : it.availableBalance.toString();
						accountCount++;
			}
			if(accountCount != 0){
				strRes = accountCount + "|" + strAccount + "|" + strBalance;
			}
			logger.info ("---------------------------")
			logger.info ("No of Accounts :"+accountCount)
			logger.info ("Accounts :"+strAccount)
			logger.info ("Balance :"+strBalance)
			logger.info ("---------------------------")
		}catch(BusinessException bex){
			  //throw new EPExce(ERROR.ACCOUNT_SUNMATS);
		}catch(Exception bex){
			//
		}
		return strRes;
	}
	
	String saveDebitRequest(DebitRequest req){
		try {
			getSession().setAttribute("_DEBITREQDATA",req);
		} catch (Exception e) {
			e.printStackTrace()
		}
		return "SUCCESS";
	}
	
	
	Boolean isValidRequestMessage(String msg){
		return BillPayMessageFormattingUtil.isCheckSumValid(msg,_CHECKSUMKEY);
	}
	
	String getChecksumFromMsg(String msg){
		String trimmsg = msg.substring(0,msg.lastIndexOf("|"))
		return BillPayMessageFormattingUtil.getCheckSum(trimmsg,_CHECKSUMKEY);
	}
	
	protected HttpSession getSession() {
		return RequestContextHolder.currentRequestAttributes().getSession(false)
	}
	
	def getSessionAttribute(String key){
		return getSession().getAttribute(key);
	}
	
	protected HttpSession getSessionById(String sid){
		logger.info ("getSessionById : sid =" +sid)
		ServletContext context 			=  session.getServletContext();
		HashMap contextSessionInfoMap 	=  (HashMap)context.getAttribute("contextSessionInfoMap");
		return contextSessionInfoMap.get(sid);
	}
	
	def Map getAttributeBySession(HttpSession sess, String key){
		logger.info("getAttributeBySession : sess ="+sess)
		logger.info("getAttributeBySession : key ="+key)
		Object obj = sess?.getAttribute(key);
		logger.info("getAttributeBySession : Return obj ="+obj)
		return (obj != null) ? (Map)obj : null;
	}
	
	UserLoginProfile getUserLoginProfile(){
		return SecurityUtils.getUserLoginProfile();
	}
	
	IBUserProfileResponse getUserProfileResponse(Long ulpId){
		logger.info("getUserProfileResponse : loginProfileId ="+ulpId)
		IBUserProfileRequest userProfileRequest = new IBUserProfileRequest();
		BillPayUtil billPayUtil					=	new BillPayUtil();
		userProfileRequest.requestHeader		=	billPayUtil.prepareNew()
		userProfileRequest.setIbUserLoginProfileId(ulpId);
		IBUserProfileResponse userProfileResponse = billPayBmClient.iBUserService.getIBUserProfileDetails(userProfileRequest);
		logger.info("getUserProfileResponse : userProfileResponse ="+userProfileResponse?.dump())
		return userProfileResponse;
	}
	
	String getMobileNoAndEmail(String paramUlpId){
		logger.info("getMobileNoAndEmail : paramUlpId="+paramUlpId)
		IBUserProfileResponse bmResponse = getUserProfileResponse(paramUlpId?.toLong());
		logger.info("getMobileNoAndEmail	: bmResponse?.ibUserLoginProfile = "+bmResponse?.ibUserLoginProfile?.dump())
		logger.info("getMobileNoAndEmail	: ibUserLoginProfile?.userContactDetail?.contact = "+bmResponse?.ibUserLoginProfile?.userContactDetail?.contact?.dump())
		String mobileNumber = bmResponse?.ibUserLoginProfile?.userContactDetail?.contact?.primaryMobileNumber;
		String emailId		= bmResponse?.ibUserLoginProfile?.userContactDetail?.contact?.primaryEmailAddress;
		mobileNumber		= mobileNumber ? mobileNumber : "NA";
		emailId				= emailId ? emailId : "NA";
		String returnString = mobileNumber + "|" + emailId;
		logger.info("getMobileNoAndEmail : returnString="+returnString)
		return returnString;
		//return "NA|NA";
	}*/
		
}
