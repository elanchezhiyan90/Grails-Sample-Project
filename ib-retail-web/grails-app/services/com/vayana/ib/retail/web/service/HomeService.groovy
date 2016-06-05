
package com.vayana.ib.retail.web.service

import org.springframework.social.connect.ConnectionRepository
import org.springframework.social.facebook.api.Facebook
import org.springframework.ui.ModelMap

import com.vayana.bm.core.api.beans.common.ContextCodeType
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.InterfaceException;
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants;
import com.vayana.ib.bm.core.api.beans.account.AccountSummaryRequest
import com.vayana.ib.bm.core.api.beans.account.AccountSummaryResponse
import com.vayana.ib.bm.core.api.beans.beneficiary.BeneficiaryRequest
import com.vayana.ib.bm.core.api.beans.beneficiary.BeneficiaryResponse
import com.vayana.ib.bm.core.api.beans.biller.BillerSummaryRequest
import com.vayana.ib.bm.core.api.beans.biller.BillerSummaryResponse
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardSummaryRequest
import com.vayana.ib.bm.core.api.beans.creditcard.CreditCardSummaryResponse
import com.vayana.ib.bm.core.api.beans.investment.InvestmentSummaryRequest
import com.vayana.ib.bm.core.api.beans.investment.InvestmentSummaryResponse
import com.vayana.ib.bm.core.api.beans.loan.LoanSummaryRequest
import com.vayana.ib.bm.core.api.beans.loan.LoanSummaryResponse
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardSummaryRequest
import com.vayana.ib.bm.core.api.beans.prepaidcard.PrepaidCardSummaryResponse
import com.vayana.ib.bm.core.api.beans.user.CustomerInquiryRequest
import com.vayana.ib.bm.core.api.beans.user.CustomerInquiryResponse
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileResponse
import com.vayana.ib.bm.core.api.model.user.IBUserProfile
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class HomeService extends GenericService{
	BmClient bmClient;
	CommonService commonService;
	ConnectionRepository connectionRepository;
	Facebook facebook;

	/*def homepage(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
	 CasaAccountSummaryRequest casaAccountSummary = getBean(CasaAccountSummaryRequest.class, requestHeader, params)
	 IBUserProfileResponse userProfileReponse = getuserprofilereponse();
	 IBUserProfile ibUserProfile = userProfileReponse.getIbUserProfile();
	 casaAccountSummary.setCifNumbers(ibUserProfile.getCifNumbers());
	 CasaAccountSummaryResponse casaAccountSummaryResponse = bmClient.accountService.getCasaAccountSummary(casaAccountSummary);
	 if (casaAccountSummaryResponse.hasErrors()){
	 model << [errors:casaAccountSummaryResponse.errors()]
	 return;
	 }else{
	 if (connectionRepository.findPrimaryConnection(Facebook)){
	 FacebookProfile fbProfile = facebook.userOperations().getUserProfile();
	 userProfileReponse.setFaceBookId(fbProfile.getId());
	 }
	 model << [actsumModel:casaAccountSummaryResponse, userProfileModel:userProfileReponse];
	 }
	 }*/

	def changelocale(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception {
		IBUserProfileResponse userProfileReponse = getuserprofilereponse(requestHeader);
		model <<[userProfileModel:userProfileReponse]
	}

	def homepage(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws BusinessException{
		try{
			AccountSummaryRequest accountSummary = getBean(AccountSummaryRequest.class, requestHeader, params)
			IBUserProfileResponse userProfileReponse = getuserprofilereponse(requestHeader);
			IBUserProfile ibUserProfile = userProfileReponse.getIbUserProfile();
			List<String> cifNumbers = ibUserProfile.getCifNumbers();
			if(cifNumbers!=null && cifNumbers.size()>0) {
				/*ListIterator<String> lstItr = cifNumbers.listIterator();
				 String cifNumber = "";
				 while(lstItr.hasNext())
				 {
				 cifNumber = lstItr.next();
				 if(cifNumber != null && !cifNumber.equalsIgnoreCase(""))
				 {
				 accountSummary.getCifBranchMapping().put(cifNumber, "001");
				 }
				 }*/
				accountSummary.setCifNumbers(cifNumbers);
				AccountSummaryResponse accountSummaryResponse = null;
				accountSummaryResponse = bmClient.accountService.getAccountSummary(accountSummary);
				if (accountSummaryResponse.hasErrors()){
					model << [errors:accountSummaryResponse.errors()]
					return;
				}else{   
					if(!"SME".equals(accountSummary.getRequestHeader().getInvoker().getSegmentCode())){   
						CustomerInquiryRequest custRequest = getBean(CustomerInquiryRequest.class, requestHeader, params);
						custRequest.setCifNumber(requestHeader.getInvoker().getPrimaryCIF());
						CustomerInquiryResponse custResponse = bmClient.iBUserService.updateUserProfile(custRequest);
					}
					session.setAttribute("actsumModel",accountSummaryResponse);
					model << [actsumModel:accountSummaryResponse, userProfileModel:userProfileReponse];
					return;
				}
			}
			else {
				throw new BusinessException(ContextCodeType.CORE, "user.accountsummary.noaccounts", "Error Occcured Fetching your Account Details. Please contact the Bank", null);
			}
		}catch(Exception e){
			model << [messageType:"failure", errorCode:ErrorCodeConstants.IM_CONN_ERR]
			return;
		}
	}

	def friendsandfamily(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BeneficiaryRequest beneficiaryRequest = getBean(BeneficiaryRequest.class, requestHeader, params);
		beneficiaryRequest.setBeneficiaryCode(beneficiaryRequest.FRIENDS_AND_FAMILY);
		beneficiaryRequest.setBeneStatus("ACT");
		BeneficiaryResponse beneficiaryResponse = bmClient.beneficiaryService.getActiveBeneficiaries(beneficiaryRequest)
		if (beneficiaryResponse.hasErrors()){
			model << [errors:beneficiaryResponse.errors()]
			return;
		}else{
			model << [friendsFamilyModel:beneficiaryResponse]
		}
	}


	def accountsummary(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception {
		String dirtyFlag = params.dirtyFlag;
		/* This piece code will be executed on load of home page using trigger click . In this case read the value from session 
		 * Remove this value from the session. During Payment In PaymentService.groovy processfundtransfer this attribute is removed from session.
		 * 
		 */
		AccountSummaryResponse accountSummaryResponse = session.getAttribute("actsumModel");
		if(accountSummaryResponse!=null) {

			model << [actsumModel:accountSummaryResponse];
		}

		else if(dirtyFlag!=null && !dirtyFlag.equals("") && dirtyFlag.equals("true")) {
			AccountSummaryRequest accountSummary = getBean(AccountSummaryRequest.class, requestHeader, params)
			IBUserProfileResponse userProfileReponse = getuserprofilereponse(requestHeader);
			IBUserProfile ibUserProfile = userProfileReponse.getIbUserProfile();
			List<String> cifNumbers = ibUserProfile.getCifNumbers();
			if(cifNumbers!=null && cifNumbers.size()>0) {
				accountSummary.setCifNumbers(cifNumbers);

				accountSummaryResponse = bmClient.accountService.getAccountSummary(accountSummary);

				if (accountSummaryResponse.hasErrors()){
					model << [errors:accountSummaryResponse.errors()]
					return;
				}else{

					model << [actsumModel:accountSummaryResponse];
				}
			}else {
				throw new BusinessException(ContextCodeType.CORE, "user.accountsummary.noaccounts", "Error Occcured Fetching your Account Details. Please contact the Bank", null);
			}
		}   
		else {
			model << [actsumModel:accountSummaryResponse];
		}
	}

	def ownaccounts(Map params,GenericRequestHeader requestHeader, ModelMap model) throws Exception {
		String dirtyFlag = params.dirtyFlag;
		/* This piece code will be executed on load of home page using trigger click . In this case read the value from session 
		 * Remove this value from the session. During Payment In PaymentService.groovy processfundtransfer this attribute is removed from session.
		 * 
		 */
		AccountSummaryResponse accountSummaryResponse = session.getAttribute("actsumModel");
		if(accountSummaryResponse!=null) {
			model << [actsumModel:accountSummaryResponse];
		}

		else if(dirtyFlag!=null && !dirtyFlag.equals("") && dirtyFlag.equals("true")) {
			AccountSummaryRequest accountSummary = getBean(AccountSummaryRequest.class, requestHeader, params)
			IBUserProfileResponse userProfileReponse = getuserprofilereponse(requestHeader);
			IBUserProfile ibUserProfile = userProfileReponse.getIbUserProfile();
			accountSummary.setCifNumbers(ibUserProfile.getCifNumbers());
			List<String> cifNumbers = ibUserProfile.getCifNumbers();
			if(cifNumbers!=null && cifNumbers.size()>0) {
				/*ListIterator<String> lstItr = cifNumbers.listIterator();
				 String cifNumber = "";
				 while(lstItr.hasNext())
				 {
				 cifNumber = lstItr.next();
				 if(cifNumber != null && !cifNumber.equalsIgnoreCase(""))
				 {
				 accountSummary.getCifBranchMapping().put(cifNumber, "001");
				 }
				 }*/
				accountSummary.setCifNumbers(cifNumbers);
				accountSummaryResponse = bmClient.accountService.getAccountSummary(accountSummary);

				if (accountSummaryResponse.hasErrors()){
					model << [errors:accountSummaryResponse.errors()]
					return;
				}else{
					model << [actsumModel:accountSummaryResponse];
				}
			}
		}
	}

	def creditcardsummary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		CreditCardSummaryRequest creditCardSummaryRequest = getBean(CreditCardSummaryRequest.class, requestHeader, params);
		creditCardSummaryRequest.setCifNumbers(cifNumbers())
		CreditCardSummaryResponse creditCardSummaryResponse = bmClient.creditCardService.getCreditCardSummary(creditCardSummaryRequest);
		if (creditCardSummaryResponse.hasErrors()){
			model << [errors:creditCardSummaryResponse.errors()]
			return;
		}else{
			model << [creditCardSummaryModel:creditCardSummaryResponse]
		}
	}

	def prepaidcardsummary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		PrepaidCardSummaryRequest prepaidCardSummaryRequest = getBean(PrepaidCardSummaryRequest.class, requestHeader, params);
		prepaidCardSummaryRequest.setCifNumbers(cifNumbers())
		PrepaidCardSummaryResponse prepaidCardSummaryResponse = bmClient.prepaidCardService.getPrepaidCardSummary(prepaidCardSummaryRequest);
		if (prepaidCardSummaryResponse.hasErrors()){
			model << [errors:prepaidCardSummaryResponse.errors()]
			return;
		}else{
			model << [prepaidCardSummaryModel:prepaidCardSummaryResponse]
		}
	}

	/*def loansummary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
	 LoanSummaryRequest loanSummaryRequest =  getBean(LoanSummaryRequest.class, requestHeader, params);
	 loanSummaryRequest.setCifNumbers(cifNumbers());
	 LoanSummaryResponse loanSummaryResponse = bmClient.loanService.getLoanSummary(loanSummaryRequest);
	 if (loanSummaryResponse.hasErrors()){
	 model << [errors:loanSummaryResponse.errors()]
	 return;
	 }else{
	 model << [loanSummaryModel:loanSummaryResponse]
	 }
	 }*/

	
	def owncreditcards(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		CreditCardSummaryRequest creditCardSummaryRequest =getBean(CreditCardSummaryRequest.class, requestHeader, params);
		creditCardSummaryRequest.setCifNumbers(cifNumbers())
		CreditCardSummaryResponse creditCardSummaryResponse = bmClient.creditCardService.getCreditCardSummary(creditCardSummaryRequest);
		if (creditCardSummaryResponse.hasErrors()){
			model << [errors:creditCardSummaryResponse.errors()]
			return;
		}else{
			model << [creditCardSummaryModel:creditCardSummaryResponse]
		}
	}

	def prepaidcards(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		PrepaidCardSummaryRequest prepaidCardSummaryRequest =getBean(PrepaidCardSummaryRequest.class, requestHeader, params);
		prepaidCardSummaryRequest.setCifNumbers(cifNumbers())
		PrepaidCardSummaryResponse prepaidCardSummaryResponse = bmClient.prepaidCardService.getPrepaidCardSummary(prepaidCardSummaryRequest);
		if (prepaidCardSummaryResponse.hasErrors()){
			model << [errors:prepaidCardSummaryResponse.errors()]
			return;
		}else{
			model << [prepaidCardSummaryModel:prepaidCardSummaryResponse]
		}
	}

	def investmentsummary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		InvestmentSummaryRequest investmentSummaryRequest = getBean(InvestmentSummaryRequest.class, requestHeader, params);
		investmentSummaryRequest.setCifNumbers(cifNumbers());
		InvestmentSummaryResponse investmentSummaryResponse = bmClient.investmentService.getInvestmentSummary(investmentSummaryRequest);
		if (investmentSummaryResponse.hasErrors()){
			model << [errors:investmentSummaryResponse.errors()]
			return;
		}else{
			model << [investmentSummaryModel:investmentSummaryResponse]
		}
	}
	
	def loansummary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		AccountSummaryRequest accountSummary = getBean(AccountSummaryRequest.class, requestHeader, params)
		IBUserProfileResponse userProfileReponse = getuserprofilereponse(requestHeader);
		IBUserProfile ibUserProfile = userProfileReponse.getIbUserProfile();
		accountSummary.setCifNumbers(ibUserProfile.getCifNumbers());
		List<String> cifNumbers = ibUserProfile.getCifNumbers();
		if(cifNumbers!=null && cifNumbers.size()>0) {
			accountSummary.setCifNumbers(cifNumbers);
			AccountSummaryResponse accountSummaryResponse = bmClient.accountService.getAccountSummary(accountSummary);
			if (accountSummaryResponse.hasErrors()){
				model << [errors:accountSummaryResponse.errors()]
				return;
			}else{
				model << [loanSummaryModel:accountSummaryResponse, userProfileModel:userProfileReponse]
			}
		}
		else {
			throw new BusinessException(ContextCodeType.CORE, "user.accountsummary.noaccounts", "Error Occcured Fetching your Account Details. Please contact the Bank", null);
		}		
	}

	def depositsummary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		AccountSummaryRequest accountSummary = getBean(AccountSummaryRequest.class, requestHeader, params)
		IBUserProfileResponse userProfileReponse = getuserprofilereponse(requestHeader);
		IBUserProfile ibUserProfile = userProfileReponse.getIbUserProfile();
		accountSummary.setCifNumbers(ibUserProfile.getCifNumbers());
		List<String> cifNumbers = ibUserProfile.getCifNumbers();
		if(cifNumbers!=null && cifNumbers.size()>0) {
			/*ListIterator<String> lstItr = cifNumbers.listIterator();
			 String cifNumber = "";
			 while(lstItr.hasNext()) {
			 cifNumber = lstItr.next();
			 if(cifNumber != null && !cifNumber.equalsIgnoreCase("")) {
			 accountSummary.getCifBranchMapping().put(cifNumber, "001");
			 }
			 }*/
			accountSummary.setCifNumbers(cifNumbers);
			AccountSummaryResponse accountSummaryResponse = bmClient.accountService.getAccountSummary(accountSummary);
			if (accountSummaryResponse.hasErrors()) {
				model << [errors:accountSummaryResponse.errors()]
				return;
			} else {
				model << [investmentSummaryModel:accountSummaryResponse, userProfileModel:userProfileReponse];
			}
		} else {
			throw new BusinessException(ContextCodeType.CORE, "user.accountsummary.noaccounts", "Error Occcured Fetching your Account Details. Please contact the Bank", null);
		}
	}

	def registeredBillerSummary(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		BillerSummaryRequest billerSummaryRequest = getBean(BillerSummaryRequest.class,requestHeader,params);
		billerSummaryRequest.setUserLoginProfileId(getUserLoginProfile().getId());

		billerSummaryRequest.setCifNumber(invoker.getPrimaryCIF());

		BillerSummaryResponse billerSummaryResponse = bmClient.billerService.getRegisteredBillerSummmary(billerSummaryRequest);
		if (billerSummaryResponse.hasErrors()){
			model << [errors:billerSummaryResponse.errors()]
			return;
		}else{

			model << [BillerSummaryModel:billerSummaryResponse]
		}
	}

	List<String> cifNumbers(){
		IBUserProfile ibUserProfile = getuserprofilereponse().getIbUserProfile();
		List cifNumbers = ibUserProfile.getCifNumbers();
		return cifNumbers;
	}

	IBUserProfileResponse getuserprofilereponse(){
		Long loginprofileId = getUserLoginProfile().getId();
		IBUserProfileResponse userProfileResponse = commonService.getIBUserProfileDetails(loginprofileId);
		return userProfileResponse;
	}




	def loans(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		/*LoanSummaryRequest loanSummaryRequest =  getBean(LoanSummaryRequest.class, requestHeader, params);
		loanSummaryRequest.setCifNumbers(cifNumbers());
		LoanSummaryResponse loanSummaryResponse = bmClient.loanService.getLoanSummary(loanSummaryRequest);
		if (loanSummaryResponse.hasErrors()){
			model << [errors:loanSummaryResponse.errors()]
			return;
		}else{
			model << [loanSummaryModel:loanSummaryResponse]
		}*/
		
		String dirtyFlag = params.dirtyFlag;   
		/* This piece code will be executed on load of home page using trigger click . In this case read the value from session
		 * Remove this value from the session. During Payment In PaymentService.groovy processfundtransfer this attribute is removed from session.
		 *
		 */
		AccountSummaryResponse accountSummaryResponse = session.getAttribute("actsumModel");
		if(accountSummaryResponse!=null) {
			model << [loanSummaryModel:accountSummaryResponse];
		}

		else if(dirtyFlag!=null && !dirtyFlag.equals("") && dirtyFlag.equals("true")) {
			AccountSummaryRequest accountSummary = getBean(AccountSummaryRequest.class, requestHeader, params)
			IBUserProfileResponse userProfileReponse = getuserprofilereponse(requestHeader);
			IBUserProfile ibUserProfile = userProfileReponse.getIbUserProfile();
			accountSummary.setCifNumbers(ibUserProfile.getCifNumbers());
			List<String> cifNumbers = ibUserProfile.getCifNumbers();
			if(cifNumbers!=null && cifNumbers.size()>0) {
				/*ListIterator<String> lstItr = cifNumbers.listIterator();
				 String cifNumber = "";
				 while(lstItr.hasNext())
				 {
				 cifNumber = lstItr.next();
				 if(cifNumber != null && !cifNumber.equalsIgnoreCase(""))
				 {
				 accountSummary.getCifBranchMapping().put(cifNumber, "001");
				 }
				 }*/
				accountSummary.setCifNumbers(cifNumbers);
				accountSummaryResponse = bmClient.accountService.getAccountSummary(accountSummary);

				if (accountSummaryResponse.hasErrors()){
					model << [errors:accountSummaryResponse.errors()]
					return;
				}else{
					model << [loanSummaryModel:accountSummaryResponse];
				}
			}
		}
	}



	def investments(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		InvestmentSummaryRequest investmentSummaryRequest = getBean(InvestmentSummaryRequest.class, requestHeader, params);
		investmentSummaryRequest.setCifNumbers(cifNumbers());
		InvestmentSummaryResponse investmentSummaryResponse = bmClient.investmentService.getInvestmentSummary(investmentSummaryRequest);
		if (investmentSummaryResponse.hasErrors()){
			model << [errors:investmentSummaryResponse.errors()]
			return;
		}else{
			model << [investmentSummaryModel:investmentSummaryResponse]
		}
	}

	IBUserProfileResponse getuserprofilereponse(GenericRequestHeader requestHeader){
		Long loginprofileId = requestHeader.getInvoker().getUserLoginProfileId();
		IBUserProfileResponse userProfileResponse = commonService.getIBUserProfileDetails(loginprofileId);
		return userProfileResponse;
	}
}