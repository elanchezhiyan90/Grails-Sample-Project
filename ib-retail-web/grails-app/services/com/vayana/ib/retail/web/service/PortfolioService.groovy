package com.vayana.ib.retail.web.service

import java.math.MathContext;
import java.math.RoundingMode
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.model.common.Currency
import com.vayana.ib.bm.core.api.beans.exchangerate.ExchangeRateRequest
import com.vayana.ib.bm.core.api.beans.exchangerate.ExchangeRateResponse
import com.vayana.ib.bm.core.api.beans.portfolio.PortfolioRequest
import com.vayana.ib.bm.core.api.beans.portfolio.PortfolioResponse
import com.vayana.ib.bm.core.api.beans.user.IBUserProfileResponse
import com.vayana.ib.bm.core.api.model.account.CasaAccount
import com.vayana.ib.bm.core.api.model.account.CreditCardAccount
import com.vayana.ib.bm.core.api.model.account.InvestmentAccount
import com.vayana.ib.bm.core.api.model.account.LoanAccount
import com.vayana.ib.bm.core.api.model.common.CustomerIdentifier
import com.vayana.ib.bm.core.api.model.user.IBUserProfile
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService


class PortfolioService extends GenericService{
	
	BmClient bmClient;
	CommonService commonService;
	public static final BigDecimal ONE_HUNDRED = BigDecimal.TEN.multiply(BigDecimal.TEN);
	/**
	 * @author elanchezhiyan
	 * @param params
	 * @param requestHeader
	 * @param model
	 * @return
	 * @throws Exception
	 */
	def portfoliomaster(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception { 
		PortfolioRequest portfolioRequest 					= 			getBean(PortfolioRequest.class,requestHeader, params);
		IBUserProfileResponse userProfileReponse 			= 			getuserprofilereponse(); 
		IBUserProfile ibUserProfile 						= 			userProfileReponse.getIbUserProfile();
		portfolioRequest.setCifNumber(ibUserProfile.getPrimaryUserCif().getCustomerIdentifier().getCifNumber().toString());
		PortfolioResponse portfolioResponse 				= 			bmClient.portfolioService.getPortfolio(portfolioRequest);
		if(!portfolioResponse.hasErrors()) {
			setSessionAttribute("PR", portfolioResponse);
		}
		Currency baseCurrency 								= 			null;
		def tempCalculations								= 			[];
		BigDecimal zeroBigdecimalBal 						= 			BigDecimal.ZERO; 
		baseCurrency										=			getBaseCurrency(invoker.operatingCountryId);
		List<CustomerIdentifier> cifs						= 			portfolioResponse.getCustomerIdentifiers();
		BigDecimal totalCasaAccountBal 						= 			getCasaAccTotalBal(cifs,baseCurrency?.code?.toString(),baseCurrency?.code?.toString(),requestHeader,null)
		BigDecimal totalInvestmentAccountBal 				= 			getInvestAccTotalBal(cifs,baseCurrency?.code,baseCurrency?.code,requestHeader,null)
		BigDecimal totalCreditCardAccountBal 				= 			getCreditCardAccTotalBal(cifs,baseCurrency?.code,baseCurrency?.code,requestHeader,null)
		BigDecimal totalLoanAccountBal 						= 			getLoanAccTotalBal(cifs,baseCurrency?.code,baseCurrency?.code,requestHeader,null)
		BigDecimal total 									= 			zeroBigdecimalBal.add(totalLoanAccountBal).add(totalCreditCardAccountBal).add(totalInvestmentAccountBal).add(totalCasaAccountBal);
		BigDecimal assetTotal 								= 			zeroBigdecimalBal.add(totalInvestmentAccountBal).add(totalCasaAccountBal);
		BigDecimal liabilitiesTotal 						= 			zeroBigdecimalBal.add(totalLoanAccountBal).add(totalCreditCardAccountBal);
		int noOfSubUnits 									= 			baseCurrency?.numberOfSubUnits?.toInteger();
		BigDecimal assetPercent 							= 			calcPercentage(assetTotal, total, noOfSubUnits, RoundingMode.HALF_UP);//(assetTotal.divide(total,baseCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		BigDecimal liabilitiesPercent 						=			calcPercentage(liabilitiesTotal, total, noOfSubUnits, RoundingMode.HALF_UP);//(liabilitiesTotal.divide(total,baseCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		BigDecimal casaPercent 								= 			calcPercentage(totalCasaAccountBal, assetTotal, noOfSubUnits, RoundingMode.HALF_UP);//(totalCasaAccountBal.divide(assetTotal,baseCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		BigDecimal depositPercent 							= 			calcPercentage(totalInvestmentAccountBal, assetTotal, noOfSubUnits, RoundingMode.HALF_UP);//(totalInvestmentAccountBal.divide(assetTotal,baseCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		BigDecimal creditCardPercent 						=			calcPercentage(totalCreditCardAccountBal, liabilitiesTotal, noOfSubUnits, RoundingMode.HALF_UP);// (totalCreditCardAccountBal.divide(liabilitiesTotal,baseCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		BigDecimal loanPercent 								= 			calcPercentage(totalLoanAccountBal, liabilitiesTotal, noOfSubUnits, RoundingMode.HALF_UP);//(totalLoanAccountBal.divide(liabilitiesTotal,baseCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		tempCalculations = [
			"totalCasaAccountBal"		:	totalCasaAccountBal,
			"totalInvestmentAccountBal" :	totalInvestmentAccountBal,
			"totalCreditCardAccountBal" :	totalCreditCardAccountBal,
			"totalLoanAccountBal"		:	totalLoanAccountBal,
			"assetPercent"				:	assetPercent,
			"liabilitiesPercent"		:	liabilitiesPercent,
			"casaPercent"				:	casaPercent,
			"depositPercent"			:	depositPercent,
			"creditCardPercent"			:	creditCardPercent,
			"loanPercent"				:	loanPercent
		]
		if(portfolioResponse.hasErrors()) {
			model << [errors:portfolioResponse.errors()]
			return;
		}
		else {
			model << [portfolioModel:portfolioResponse,tempCalcModel:tempCalculations,baseCurrencyModel:baseCurrency]
		}
	}
	/**
	 * 
	 * @param customerIdentifiers,baseCurrencyCode,preferredCurrencyCode,exchangeRate
	 * @return BigDecimal of Total Casa Account balance in Base Currency 
	 */
	private BigDecimal getCasaAccTotalBal(List<CustomerIdentifier> customerIdentifiers,String baseCurrencyCode,String preferredCurrencyCode,GenericRequestHeader requestHeader,String preferredCurrISOCode) {
		BigDecimal totalBal = BigDecimal.ZERO;
		customerIdentifiers.each {customerIdentifier->
			def casaAccounts = customerIdentifier.getCasaAccounts();
			casaAccounts.each {casaAccount->
				baseCurrencyCode = (baseCurrencyCode)? baseCurrencyCode : casaAccount?.currency?.code;
				def availableBalance = casaAccount.getAvailableBalanceBaseCurrency()
				if(baseCurrencyCode.equals(preferredCurrencyCode)) {
					totalBal=totalBal + availableBalance;
				}else {
					BigDecimal exchangedAmount = convertedAmount(casaAccount?.accountNumber,null,casaAccount?.availableBalance?.toString(),preferredCurrISOCode,requestHeader)
					totalBal=totalBal+exchangedAmount;
				}
			}
		}
		return totalBal;
	}
	/**
	 * 
	 * @param customerIdentifiers,baseCurrencyCode,preferredCurrencyCode,exchangeRate
	 * @return BigDecimal of Total Investment Account balance in Base Currency
	 */
	private BigDecimal getInvestAccTotalBal(List<CustomerIdentifier> customerIdentifiers,String baseCurrencyCode,String preferredCurrencyCode,GenericRequestHeader requestHeader,String preferredCurrISOCode) {
		BigDecimal totalBal = BigDecimal.ZERO;
		customerIdentifiers.each {customerIdentifier->
			def investmentAccounts = customerIdentifier.getInvestmentAccounts();
			investmentAccounts.each {investmentAccount->
				baseCurrencyCode = (baseCurrencyCode)? baseCurrencyCode : investmentAccount?.currency?.code;
				def availableBalance = investmentAccount.getAvailableBalanceBaseCurrency()
				if(baseCurrencyCode.equals(preferredCurrencyCode)) {
					totalBal=totalBal + availableBalance;
				}
				else {
					BigDecimal exchangedAmount = convertedAmount(investmentAccount?.accountNumber,null,investmentAccount?.availableBalance?.toString(),preferredCurrISOCode,requestHeader)
					totalBal=totalBal+exchangedAmount;
				}
			}
		}
		return totalBal;
	}
	/**
	 * 
	 * @param customerIdentifiers,baseCurrencyCode,preferredCurrencyCode,exchangeRate
	 * @return BigDecimal of Total Credit Card Account balance in Base Currency
	 */
	private BigDecimal getCreditCardAccTotalBal(List<CustomerIdentifier> customerIdentifiers,String baseCurrencyCode,String preferredCurrencyCode,GenericRequestHeader requestHeader,String preferredCurrISOCode) {
		BigDecimal totalBal = BigDecimal.ZERO;
		customerIdentifiers.each {customerIdentifier->
			def creditCardAccounts = customerIdentifier.getCreditCardAccounts();
			creditCardAccounts.each {creditCardAccount->
				baseCurrencyCode = (baseCurrencyCode)? baseCurrencyCode : creditCardAccount?.currency?.code;
				def availableBalance = creditCardAccount.getOutStandingAmountBaseCurrency()
				if(baseCurrencyCode.equals(preferredCurrencyCode)) {
					totalBal=totalBal + availableBalance;
				}
				else {
					BigDecimal exchangedAmount = convertedAmount(creditCardAccount?.accountNumber,null,creditCardAccount?.availableBalance?.toString(),preferredCurrISOCode,requestHeader)
					totalBal=totalBal+exchangedAmount;
				}
			}
		}
		return totalBal;
	}
	/**
	 *
	 * @param customerIdentifiers,baseCurrencyCode,preferredCurrencyCode,exchangeRate
	 * @return BigDecimal of Total Loan Account balance in Base Currency
	 */
	private BigDecimal getLoanAccTotalBal(List<CustomerIdentifier> customerIdentifiers,String baseCurrencyCode,String preferredCurrencyCode,GenericRequestHeader requestHeader,String preferredCurrISOCode) {
		BigDecimal totalBal =BigDecimal.ZERO;
		customerIdentifiers.each {customerIdentifier->
			def loanAccounts = customerIdentifier.getLoanAccounts();
			loanAccounts.each {loanAccount->
				baseCurrencyCode = (baseCurrencyCode)? baseCurrencyCode : loanAccount?.currency?.code;
				def availableBalance = loanAccount.getOutstandingAmountBaseCurrency()
				if(baseCurrencyCode.equals(preferredCurrencyCode)) {
					totalBal=totalBal + availableBalance;
				}
				else {
					
					BigDecimal exchangedAmount = convertedAmount(loanAccount?.accountNumber,null,loanAccount?.availableBalance?.toString(),preferredCurrISOCode,requestHeader)
					totalBal=totalBal+exchangedAmount;
				}
			}
		}
		return totalBal;
	}
	/**
	 * 
	 * @param operatingCountryId
	 * @return Currency of given OperatingCountryId
	 */
	private Currency getBaseCurrency(Long operatingCountryId) {
		Currency baseCurrency = null;
		CommonRequest  commonRequest = getBean(CommonRequest.class,null,null);
		CommonResponse commonResponse = bmClient.iBCommonService.fetchBaseCurrency(commonRequest);
		baseCurrency = (Currency)commonResponse.getCommonEntity();
		return baseCurrency;
	}
	/**
	 * 
	 * @return
	 */
	private IBUserProfileResponse getuserprofilereponse(){
		Long loginprofileId = getUserLoginProfile().getId();
		IBUserProfileResponse userProfileResponse = commonService.getIBUserProfileDetails(loginprofileId);
		return userProfileResponse;
	}
	/**
	 * @author elanchezhiyan
	 * @param fromCurrency
	 * @param toCurrency
	 * @param requestHeader
	 * @return
	 */
	private BigDecimal convertedAmount(String fromAcctNum,String toAcctNum,String amount,String preferedCurrency,GenericRequestHeader requestHeader) {
		
		ExchangeRateResponse res = commonService.getExchangeCalculator(fromAcctNum, toAcctNum, amount, preferedCurrency, requestHeader)
		/*ExchangeRateRequest exchangeRateRequest=getBean(ExchangeRateRequest.class, requestHeader, null);
		exchangeRateRequest.setFromCurrency(fromCurrency);
		exchangeRateRequest.setToCurrency(toCurrency);
		exchangeRateRequest.setCifNumber(toCurrency);
		exchangeRateRequest.setTransferCurrency(toCurrency);
		exchangeRateRequest.setTransferAmount(toCurrency);
		ExchangeRateResponse exchangeRateResponse=bmClient.accountService.getExchangeRate(exchangeRateRequest);*/
		BigDecimal convertedAmount	=	BigDecimal.ZERO;	
		//return BigDecimal.valueOf(convertedAmount);
		
		if(!res.hasErrors()){			
			convertedAmount	=	res?.convertedAmount?.toBigDecimal();
		}
		
		return convertedAmount;
		
	}
	/**
	 * @author elanchezhiyan
	 * @param id
	 * @return
	 */
	private Currency getCurrencyById(String id){
		Currency currency = null;
		CommonRequest  commonRequest = getBean(CommonRequest.class,null,null);
		commonRequest.setCommonEntityId(Long.valueOf(id));
		CommonResponse commonResponse = bmClient.iBCommonService.getCurrency(commonRequest);
		currency = (Currency)commonResponse.getCommonEntity();
		return currency;
	}
	/**
	 * @author elanchezhiyan
	 * @param params
	 * @param requestHeader
	 * @param model
	 * @return
	 * @throws Exception
	 */
	def preferredCurrencyChange(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		Currency preferredCurrency 					= 		getCurrencyById(params?.preferredCurrency?.split(",")[0]);
		String preferredCurrencyCode				=		preferredCurrency?.code;
		String preferredCurrencyIsoCode				=		commonService.getCurrencyFormat(preferredCurrency?.currencyIsoCode?.toString())
		String baseCurrencyCode 					= 		params?.baseCurrencyCode;
		PortfolioResponse portfolioResponse 		= 		getSessionAttribute("PR");
		//BigDecimal exchangeRate						= 		new BigDecimal(exchangeRate(baseCurrencyCode,preferredCurrencyCode,requestHeader));
		List<CustomerIdentifier> cifs				= 		portfolioResponse.getCustomerIdentifiers();
		def tempCalculations						= 		[];
		BigDecimal totalCasaAccountBal 				= 		getCasaAccTotalBal(cifs, null, preferredCurrencyCode, requestHeader,preferredCurrencyIsoCode)
		BigDecimal totalInvestmentAccountBal 		= 		getInvestAccTotalBal(cifs, null, preferredCurrencyCode, requestHeader,preferredCurrencyIsoCode)
		BigDecimal totalCreditCardAccountBal 		= 		getCreditCardAccTotalBal(cifs, null, preferredCurrencyCode, requestHeader,preferredCurrencyIsoCode)
		BigDecimal totalLoanAccountBal 				= 		getLoanAccTotalBal(cifs, null, preferredCurrencyCode, requestHeader,preferredCurrencyIsoCode)
		BigDecimal totalAct 						=		totalLoanAccountBal.add(totalCreditCardAccountBal).add(totalInvestmentAccountBal).add(totalCasaAccountBal);
		BigDecimal assetTotal 						= 		totalInvestmentAccountBal.add(totalCasaAccountBal);
		BigDecimal liabilitiesTotal 				= 		totalLoanAccountBal.add(totalCreditCardAccountBal);
		int noOfSubUnits 							= 		preferredCurrency?.numberOfSubUnits?.toInteger();
		BigDecimal assetPercent 					= 		calcPercentage(assetTotal, totalAct, noOfSubUnits , RoundingMode.HALF_UP);//(assetTotal.divide(totalAct,preferredCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		BigDecimal liabilitiesPercent 				=		calcPercentage(liabilitiesTotal, totalAct, noOfSubUnits , RoundingMode.HALF_UP);//(liabilitiesTotal.divide(totalAct,preferredCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		BigDecimal casaPercent 						= 		calcPercentage(totalCasaAccountBal, assetTotal, noOfSubUnits , RoundingMode.HALF_UP);//(totalCasaAccountBal.divide(assetTotal,preferredCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		BigDecimal depositPercent 					= 		calcPercentage(totalInvestmentAccountBal, assetTotal, noOfSubUnits , RoundingMode.HALF_UP);//(totalInvestmentAccountBal.divide(assetTotal,preferredCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		BigDecimal creditCardPercent 				= 		calcPercentage(totalCreditCardAccountBal, liabilitiesTotal, noOfSubUnits , RoundingMode.HALF_UP);//(totalCreditCardAccountBal.divide(liabilitiesTotal,preferredCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		BigDecimal loanPercent 						= 		calcPercentage(totalLoanAccountBal, liabilitiesTotal, noOfSubUnits , RoundingMode.HALF_UP);//(totalLoanAccountBal.divide(liabilitiesTotal,preferredCurrency?.numberOfSubUnits?.toInteger(),RoundingMode.HALF_EVEN)).multiply(ONE_HUNDRED);
		tempCalculations = [
			"totalCasaAccountBal"   	:	totalCasaAccountBal,
			"totalInvestmentAccountBal" :	totalInvestmentAccountBal,
			"totalCreditCardAccountBal"	:	totalCreditCardAccountBal,
			"totalLoanAccountBal"		:	totalLoanAccountBal,
			"assetPercent"				:	assetPercent,
			"liabilitiesPercent"		:	liabilitiesPercent,
			"casaPercent"				:	casaPercent,
			"depositPercent"			:	depositPercent,
			"creditCardPercent"			:	creditCardPercent,
			"loanPercent"				:	loanPercent
		]

		if(portfolioResponse.hasErrors())		{
			model << [errors:portfolioResponse.errors()]
			return;
		}
		else {
			model << [portfolioModel:portfolioResponse,tempCalcModel:tempCalculations,baseCurrencyModel:preferredCurrency]
		}
	}
	/**
	 * @author elanchezhiyan
	 * @param dividend
	 * @param divisor
	 * @param numberOfSubUnits
	 * @param roundingMode
	 * @return
	 */
	private BigDecimal calcPercentage(BigDecimal dividend,BigDecimal divisor,int numberOfSubUnits,RoundingMode roundingMode) {
		BigDecimal percentage = BigDecimal.ZERO;
		if(!dividend.equals(BigDecimal.ZERO) && !divisor.equals(BigDecimal.ZERO))
		{
			percentage = dividend.divide(divisor,numberOfSubUnits,roundingMode).multiply(ONE_HUNDRED);
		}
		
		return percentage;
	}

}
