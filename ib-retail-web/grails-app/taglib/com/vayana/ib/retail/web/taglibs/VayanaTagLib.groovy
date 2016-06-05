package com.vayana.ib.retail.web.taglibs

import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
import org.codehaus.groovy.grails.web.util.WebUtils
import org.springframework.context.NoSuchMessageException
import org.springframework.util.StringUtils
import org.springframework.web.servlet.support.RequestContextUtils as RCU

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.common.utils.MoneyUtils
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.user.UserSecureImageResponse
import com.vayana.bm.core.api.constants.BusinessFunctionConstants
import com.vayana.bm.core.api.constants.LookupCodeConstants;
import com.vayana.bm.core.api.constants.SubModuleConstants
import com.vayana.bm.core.api.constants.UserActionConstants
import com.vayana.bm.core.api.model.common.QuestionBasket
import com.vayana.bm.core.api.model.common.QuestionBasketDetail
import com.vayana.bm.core.api.model.enums.CommonEntityEnum
import com.vayana.bm.core.api.model.enums.FindByEnum
import com.vayana.bm.core.api.model.enums.YesNoEnum
import com.vayana.bm.core.api.model.security.ColorPaleteBasketDetail
import com.vayana.bm.core.api.model.user.UserColorPalete
import com.vayana.ib.bm.core.api.beans.common.IBUserInformationResponse
import com.vayana.ib.bm.core.api.model.account.Account;
import com.vayana.ib.bm.core.api.model.enums.PayeeBankTypeEnum
import com.vayana.ib.bm.core.api.model.payment.DomesticBank
import com.vayana.ib.bm.core.api.model.payment.ForeignBank
import com.vayana.ib.bm.core.impl.service.util.BaseCommonUtil
import com.vayana.ib.retail.web.service.CommonService
import com.vayana.ib.bm.core.impl.service.util.ProductTypeComparator

class VayanaTagLib {
	static namespace ="vayana"
	CommonService commonService
	BaseCommonUtil baseCommonUtil
	/**
	 * @attr formName required
	 * @attr reportName required
	 */
	def download = {attrs, body ->
		def reportName = attrs.reportName;
		def formName = attrs.formName;
		out << render(template:"/common/downloadreport", model:[reportName:reportName, formName:formName]);
	}
	
	String messageHelper(code, defaultMessage = null, args = null, locale = null) {
		if (locale == null) {
			locale = RCU.getLocale(request)
		}
		def messageSource = grailsAttributes.applicationContext.messageSource
		def message
		try {
			message = messageSource.getMessage(code, args == null ? null : args.toArray(), locale)
		}
		catch (NoSuchMessageException e) {
			if (defaultMessage != null) {
				if (defaultMessage instanceof Closure) {
					message = defaultMessage()
				}
				else {
					message = defaultMessage as String
				}
			}
		}
		return message
	}

	def postablelink = {attrs,body ->
		def formName = attrs.formName
		formName = formName?formName:"frmMainMenu"
		def target = attrs.target
		def action = attrs.action
		def controller = attrs.controller
		def urlParams = attrs.urlParams
		def linkClass = attrs.linkClass
		def linkTitle = attrs.linkTitle
		def spinnerRequired = (attrs.spinnerRequired)?attrs.spinnerRequired:''
		def idParamForAnchor = attrs.id
		if (!formName) {
			throwTagError("Tag [postablelink] is missing required attribute [formName]")        }
		
		generateLink(formName,action, controller, urlParams,target,body,linkClass,linkTitle,idParamForAnchor,spinnerRequired)
		
	}
	
	def postableradio = {attrs,body ->
		def formName = attrs.formName
		formName = formName?formName:"frmMainMenu"
		def target = attrs.target
		def action = attrs.action
		def controller = attrs.controller
		def urlParams = attrs.urlParams
		def linkTitle = attrs.linkTitle
		def idParamForRadio = attrs.id
		def radioName=attrs.name
		generateRadioLink(formName,action, controller, urlParams,target,body,linkTitle,idParamForRadio,radioName)
		
	}
	
	def generateLink(formName,action, controller, urlParams,target,body,linkClass,linkTitle, idParamForAnchor,spinnerRequired){
		def writer = getOut()
		StringBuffer sb = new StringBuffer()
		def link = g.createLink(action:action,controller:controller,params:urlParams)
		if(spinnerRequired != null && spinnerRequired != ""){
            sb << """
                <a href="javascript:void(0)" onclick="postUrl('${formName}','${link}','${target}');onPostableLinkSuccess();" title="${linkTitle}" class="${linkClass}" id="${idParamForAnchor}">
            """
        }else{
            sb << """
                <a href="javascript:void(0)" onclick="postUrl('${formName}','${link}','${target}');" title="${linkTitle}" class="${linkClass}" id="${idParamForAnchor}">
            """
        }
		writer << sb.toString().trim()
		writer << body().trim()
		writer << "</a>"
	}
	
	def generateRadioLink(formName,action, controller, urlParams,target,body,linkTitle,idParamForRadio,radioName){
		def writer = getOut()
		StringBuffer sb = new StringBuffer()
		def link = g.createLink(action:action,controller:controller,params:urlParams)
		
		sb << """
		   <input type="radio"  value="javascript:void(0)" onclick="postUrl('${formName}','${link}','${target}');" title="${linkTitle}" id="${idParamForRadio}" name="${radioName}"/>
		"""
		writer << sb.toString()
	}
	
	
/*	def selectWithOptGroup = { attrs, body ->
		def name = attrs.remove('name')
		def from = attrs.remove('from')
		def groupBy = attrs.remove('groupBy')
		def optionKey = attrs.remove('optionKey')
		def optionValue = attrs.remove('optionValue')
		def target = attrs.target
		Set optGroupSet = new TreeSet()
	
		//Make that sure the object we're working with, has groupBy, optionKey, and optionValue properties that actually
		//exist
		//def link = g.createLink(action:action,controller:controller,params:urlParams)
		if(from.size() > 0) {
			if(!from[0].properties[groupBy]) {
				throw new MissingPropertyException("No such property: ${groupBy} for class: ${from[0].class.name}")
			}
	
			else if(!from[0].properties[optionKey]) {
				throw new MissingPropertyException("No such property: ${optionKey} for class: ${from[0].class.name}")
			}
	
			else if(!from[0].properties[optionValue]) {
				throw new MissingPropertyException("No such property: ${optionValue} for class: ${from[0].class.name}")
			}
		}
	
		from.each {
			optGroupSet.add(it.properties[groupBy])
		}
	
		out << "<select id =\"combo\"  name=\"${name}\" "
	
		attrs.each{key, value ->
			out << "${key}=\"${value.encodeAsHTML()}\" "
		}
	
		out << ">"
			
		for(optGroup in optGroupSet) {
			out << " <optgroup label=\"${optGroup.encodeAsHTML()}\">\n"
			for(option in from) {
				if(option.properties[groupBy].equals(optGroup)) {
					out << "  <option value=\"${option.properties[optionKey]}\">${option.properties[optionValue]} </option>\n"
				}
			}
			out << " </optgroup>\n"
		}
	
		out << "</select>\n"
	}
	*/
	
	/**
	 * @attr name required
	 */
//    def select = { attrs, body ->
//		def name = attrs.remove('name')
//		def from = attrs.remove('from')
//		def id = attrs.remove('id')
//		id =id?id:name
//		def groupBy = "shortName"
//		def optionKey = "key"
//		def optionValue = "value"
//		def target = attrs.target
//		Set optGroupSet = new TreeSet()
//		if (!name){
//			throwTagError("Tag [fromAccount] is missing required attribute [name]")
//		}
//		//Make that sure the object we're working with, has groupBy, optionKey, and optionValue properties that actually
//		//exist
//		//def link = g.createLink(action:action,controller:controller,params:urlParams)
//		if(from.size() > 0) {
//			/*if(!from[0].properties[groupBy]) {
//				throw new MissingPropertyException("No such property: ${groupBy} for class: ${from[0].class.name}")
//			}*/
//
//			if(!from[0].properties[optionKey]) {
//				throw new MissingPropertyException("No such property: ${optionKey} for class: ${from[0].class.name}")
//			}
//
//			else if(!from[0].properties[optionValue]) {
//				throw new MissingPropertyException("No such property: ${optionValue} for class: ${from[0].class.name}")
//			}
//		}
//
//		if(from[0].properties[groupBy]) {
//			from.each {
//				optGroupSet.add(it.properties[groupBy])
//			}
//		}
//		out << "<select id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" "
//
//		attrs.each{key, value ->
//			out << "${key}=\"${value.encodeAsHTML()}\" "
//		}
//
//		out << ">"
//		if(from[0].properties[groupBy]) {
//			for(optGroup in optGroupSet) {
//				out << " <optgroup label=\"${optGroup.encodeAsHTML()}\">\n"
//				for(option in from) {
//					if(option.properties[groupBy].equals(optGroup)) {
//						String optkey = option.properties[optionKey]
//						String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
//						out << "  <option value=\"${encOptkey}\">${option.properties[optionValue]}</option>\n"
//					}
//				}
//				out << " </optgroup>\n"
//			}
//		}else{
//			for(option in from) {
//					String optkey = option.properties[optionKey]
//					String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
//					out << "  <option value=\"${encOptkey}\">${option.properties[optionValue]} </option>\n"
//			}
//		}
//		out << "</select>\n"
//	}
//
	/**
	 * @attr type required
	 * @attr poptype required
	 */
	//poptype possible values
	// CASA-Current and Saving Account
	// CC-Credit Cards
	// PC-Prepaid Cards
	// DA-DepositAccount
	//BOTH-both CASA,CC,PC,DA
	def fromAccountSelect = { attrs, body ->
		def name = attrs.remove('name')
		def type = attrs.remove('type')	       	
		def popType = (attrs?.poptype)?attrs.poptype:'CASA'
		def opsIns	=	(attrs?.opsIns)?attrs.opsIns:'YES'
		def tdOpsIns	=	(attrs?.tdOpsIns) ? attrs.tdOpsIns : 'NO'
		def pgIdentifier = (attrs?.pgIdentifier)?attrs?.pgIdentifier:'NO'
		List from = commonService.getFromOwnCasaAcounts(params,type,popType,opsIns,tdOpsIns,pgIdentifier)         
		def id = attrs.remove('id')
		id =id?id:name  
		def groupBy = "category"
		def optionKey = (attrs.optionKey)?attrs.optionKey:'accountIdVersion'
		def optionValue = "accountNumber"
		def target = attrs.target
		Set optGroupSet = new TreeSet(new ProductTypeComparator());
				if (!name){
			throwTagError("Tag [fromAccount] is missing required attribute [name]")
		}
		//Make that sure the object we're working with, has groupBy, optionKey, and optionValue properties that actually
		//exist
		//def link = g.createLink(action:action,controller:controller,params:urlParams)
		if(from?.size() > 0) {                 
			/*if(!from[0].properties[groupBy]) {
				throw new MissingPropertyException("No such property: ${groupBy} for class: ${from[0].class.name}")
			}*/
				
			if(!from[0].properties[optionKey]) {
				throw new MissingPropertyException("No such property: ${optionKey} for class: ${from[0].class.name}")
			}
	
			else if(!from[0].properties[optionValue]) {
				throw new MissingPropertyException("No such property: ${optionValue} for class: ${from[0].class.name}")
			}
		
		
		if(from[0].properties[groupBy]) {
			from.each {
				optGroupSet.add(it.properties[groupBy])
			}
		}
		
		out << "<select id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" "
	
		attrs.each{key, value ->
			out << "${key}=\"${value.encodeAsHTML()}\" "
		}
	
		out << ">"
		
		if (from.size() > 1){
			out << "<option value=\"\" selected>Select</option>\n"
		}
		
		if(from[0].properties[groupBy]) {
			for(optGroup in optGroupSet) {
				
				out << "<optgroup label=\"${optGroup.encodeAsHTML()}\">\n"
				for(option in from) {
					if(option.properties[groupBy].equals(optGroup)) {
						String optkey = option.properties[optionKey]
						String accountShortName=option.shortName
						String curerncy=option.currency.code
						String accountNumber=option.accountNumber+"("+curerncy+")"
						String formattedAccountNumber = ""
						if(LookupCodeConstants.CREDITCARD.equals(option.accountType?.code)){
							formattedAccountNumber = commonService.maskCreditCardNumber(option.accountNumber) + "|" + curerncy + "|" + option.accountType?.description
						}else{
//							formattedAccountNumber = option.accountNumber + "|" + curerncy + "|" + option.accountType?.description
							formattedAccountNumber = option.accountNumber
						}
						
						//String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
						out << " <option value=\"${optkey}\" data-msg=\"${accountShortName}\">${formattedAccountNumber}</option>\n"
					}
				}
				out << " </optgroup>\n"
			}
		}else{
			for(option in from) {
					String optkey = option.properties[optionKey]
					//String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
					out << "<option value=\"\" selected>Select</option>\n  <option value=\"${optkey}\">${option.properties[optionValue]} </option>\n"
			}
		}
		out << "</select>\n"
		}else{   
			out << "<select id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" "
			attrs.each{key, value -> out << "${key}=\"${value.encodeAsHTML()}\" "}     
			out << ">"
			out << "<option value=\"\" selected>No Valid Accounts Avaliable</option>"
			out << "</select>"
		}
	}
	/**
	 * @attr name required
	 * @attr id required
	 */
	def loanAmtType = {attrs,body->  
		def name = attrs.remove('name')    
		def domain = 'base'
		def type = 'LN_AMOUNT_TYPE'	
		List from = commonService.getLookupValuesByType(type,domain)
		def id = attrs.remove('id')
		id =id?id:name  
		def groupBy = "code"
		def optionKey = (attrs.optionKey)?attrs.optionKey:'idVersion'
		def optionValue = "description"
		Set optGroupSet = new TreeSet()
				if (!name){
			throwTagError("Tag [loanAmtType] is missing required attribute [name]")
		}
		if(from.size() > 0) {
			if(!from[0].properties[optionKey]) {
				throw new MissingPropertyException("No such property: ${optionKey} for class: ${from[0].class.name}")
			}
	
			else if(!from[0].properties[optionValue]) {
				throw new MissingPropertyException("No such property: ${optionValue} for class: ${from[0].class.name}")
			}
		
		
		if(from[0].properties[groupBy]) {
			optGroupSet.add('EMI');
			//optGroupSet.add('Loan Sevicing');
			optGroupSet.add('Others');
			/*from.each {
				optGroupSet.add((it.code.equals("EMI"))?'EMI':'Loan Sevicing')
			}*/
		}
		out << "<select id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" "
	
		attrs.each{key, value ->
			out << "${key}=\"${value.encodeAsHTML()}\" "
		}
	
		out << ">"
		
		if (from.size() > 1){
			out << "<option value=\"\" selected>Select</option>\n"
		}
		attrs.date = new Date()
		attrs.format = "MMM-yyyy"
		if(from[0].properties[groupBy]) {
			for(optGroup in optGroupSet) {
				
				out << "<optgroup label=\"${optGroup.encodeAsHTML()}\">\n"
				for(option in from) {
					if('EMI'.equals(optGroup) && option.code.equals(optGroup)) {
						String optkey = option.properties[optionKey]
						String shortName=option.code+" Payment";//+" for "+g.formatDate(attrs)
						out << " <option value=\"${optkey}\" data-msg=\"${shortName}\">${shortName}</option>\n"
					} else if('Loan Sevicing'.equals(optGroup) && !option.code.equals('EMI')) {
						String optkey = option.properties[optionKey]
						String shortName=option.description
						out << " <option value=\"${optkey}\" data-msg=\"${shortName}\">${shortName}</option>\n"
					} else if('Others'.equals(optGroup) && !(['PP','FP','EMI'].contains(option?.code))) {
						String optkey = option.properties[optionKey]
						String shortName=option.description
						out << " <option value=\"${optkey}\" data-msg=\"${shortName}\">${shortName}</option>\n"
					}
				}
				out << " </optgroup>\n"
			}
		}
		out << "</select>\n"
		}else{
		out << "No Valid Amount Type Avaliable"
		}
		
	}
	/**
	 * @attr type required
	 * @attr poptype required
	 */
	//poptype possible values
	// CASA-Current and Saving Account
	// CC-Credit Cards
	//PC-Prepaid Cards
	//BOTH-both CASA and CC
	def toAccountSelect = { attrs, body ->
		def name = attrs.remove('name')
		 def type = attrs.remove('type')
		def visible = attrs.remove('visible')
		def popType = (attrs.poptype)?attrs.poptype:'CASA'
		def from = commonService.getToOwnCasaAcounts(params,popType)
		def id = attrs.remove('id')
		id =id?id:name
		def groupBy = "category"
		def optionKey = "idVersion"
		def optionValue = "accountNumber"
		def target = attrs.target
		Set optGroupSet = new TreeSet()
				if (!name){
			throwTagError("Tag [fromAccount] is missing required attribute [name]")
		}
		//Make that sure the object we're working with, has groupBy, optionKey, and optionValue properties that actually
		//exist
		//def link = g.createLink(action:action,controller:controller,params:urlParams)
		if(from.size() > 0) {
			/*if(!from[0].properties[groupBy]) {
				throw new MissingPropertyException("No such property: ${groupBy} for class: ${from[0].class.name}")
			}*/
				
			if(!from[0].properties[optionKey]) {
				throw new MissingPropertyException("No such property: ${optionKey} for class: ${from[0].class.name}")
			}
	
			else if(!from[0].properties[optionValue]) {
				throw new MissingPropertyException("No such property: ${optionValue} for class: ${from[0].class.name}")
			}
		
		
		if(from[0].properties[groupBy]) {
			from.each {
				optGroupSet.add(it.properties[groupBy])
			}
		}
		if(("false").equals(visible)){
			String hiddenValue = from[0].properties[optionKey];
			println "VayanaTagLib	:   HiddenValue >> "+hiddenValue;
			out << "<input type='hidden' id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" value =\"${hiddenValue}\" />"
			return;
		}
			out << "<select id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" "
	
		attrs.each{key, value ->
			out << "${key}=\"${value.encodeAsHTML()}\" "
		}
	
		out << ">"
		if(from[0].properties[groupBy]) {
			for(optGroup in optGroupSet) {
				out << " <optgroup label=\"${optGroup.encodeAsHTML()}\">\n"
				for(option in from) {
					if(option.properties[groupBy].equals(optGroup)) {
						String optkey = option.properties[optionKey]
						String accountShortName=option.shortName
						String curerncy=option.currency.code
						String accountNumber=option.accountNumber+"("+curerncy+")"
//						String formattedAccountNumber = option.accountNumber + "|" + curerncy + "|" + option.accountType?.description
						String formattedAccountNumber = option.accountNumber
						//String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
						out << "  <option value=\"${optkey}\" data-msg=\"${accountShortName}\">${formattedAccountNumber}</option>\n"
					}
				}
				out << " </optgroup>\n"
			}
		}else{
			for(option in from) {
					String optkey = option.properties[optionKey]
					//String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
					out << "  <option value=\"${optkey}\">${option.properties[optionValue]} </option>\n"
			}
		}
		out << "</select>\n"
		}else
		{
			 out << "<select id =\"${id}\" name=\"${name}\" required=\"required\" data-errormessage=\"Please select an account\" data-encrypt=\"yes\" >"
			 out << "</select>\n"
		}
	}
	
	
		def toFFAccountSelect = { attrs, body ->
		def name = attrs.remove('name')
		def type = attrs.remove('type')
		def beneId=params.beneId
		def isQuickPay= params.isQuickPay ? params.isQuickPay : false;
		def from = commonService.getFriendsAndFamilyAccounts(beneId.toLong(),isQuickPay.toBoolean())
		def id = attrs.remove('id')        
		id =id?id:name
		def groupBy = "category"
		def optionKey = "idVersion"
		def optionValue = "accountNumber"
		def target = attrs.target
		Set optGroupSet = new TreeSet()
				if (!name){
			throwTagError("Tag [fromAccount] is missing required attribute [name]")
		}
		//Make that sure the object we're working with, has groupBy, optionKey, and optionValue properties that actually
		//exist
		//def link = g.createLink(action:action,controller:controller,params:urlParams)
		if(from.size() > 0) {
			/*if(!from[0].properties[groupBy]) {
				throw new MissingPropertyException("No such property: ${groupBy} for class: ${from[0].class.name}")
			}*/
				
			if(!from[0].properties[optionKey]) {
				throw new MissingPropertyException("No such property: ${optionKey} for class: ${from[0].class.name}")
			}
	
			else if(!from[0].properties[optionValue]) {
				throw new MissingPropertyException("No such property: ${optionValue} for class: ${from[0].class.name}")
			}
		
		
		if(from[0].properties[groupBy]) {
			from.each {
				if(it.properties[groupBy] != null){
					optGroupSet.add(it.properties[groupBy])
				}
			}
		}
		out << "<select id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" "
	
		attrs.each{key, value ->
			out << "${key}=\"${value.encodeAsHTML()}\" "
		}
		out << ">"
		
		if (from.size() > 1){
			out << "<option value=\"\" selected>Select</option>\n"
		}
		if(from[0].properties[groupBy]) {
			for(optGroup in optGroupSet) {
				out << " <optgroup label=\"${optGroup.encodeAsHTML()}\">\n"
				for(option in from) {
					if(option.properties[groupBy].equals(optGroup)) {
						String optkey = option.properties[optionKey]
						def accountShortName=option.shortName
						def currency=option.currency.code
						def currencyId=option.currency.id
						def transType =option.transactionSubType?.serviceApplication?.service?.code
						def accountNumber=option.accountNumber+"("+currency+")"  
						def formattedAccountNumber =option.accountNumber+"|"+transType  //+ " | " + currency + " | " + option.accountType?.description
						def payeeBranchDType=option?.payeeBankBranch?.payeeBankType
						def payeeBankBranch=''
						def bankName=''
						def bankCity=''
						def bankCountry=''
						def bankCode=''
						def bankBranch=''
						if(payeeBranchDType!= null && PayeeBankTypeEnum.DOMESTIC.equals(payeeBranchDType))
						{
							payeeBankBranch= option?.payeeBankBranch ? (DomesticBank)option?.payeeBankBranch : ""; 
							bankName=payeeBankBranch?.bankName
							bankCity=payeeBankBranch?.city
							bankCountry=payeeBankBranch?.country?.code
							bankCode=payeeBankBranch?.bankCode
							bankBranch=payeeBankBranch?.branchName
						}else if(payeeBranchDType!=null && PayeeBankTypeEnum.FOREIGN.equals(payeeBranchDType))
						{
							payeeBankBranch=option?.payeeBankBranch ? (ForeignBank)option?.payeeBankBranch : "";
							bankName=payeeBankBranch?.name1
							bankCity=payeeBankBranch?.cityCode
							bankCountry=payeeBankBranch?.countryCode
							bankCode=payeeBankBranch?.bankCode
							bankBranch=payeeBankBranch?.branch1
						}
						//String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
						out << "  <option value=\"${optkey}\" data-msg=\"${accountShortName}\" data-code=\"${bankCode}\" data-bank=\"${bankName}\" data-branch=\"${bankBranch}\" data-city=\"${bankCity}\" data-country=\"${bankCountry}\" data-curncy=\"${currencyId}\">${formattedAccountNumber}</option>\n"
					}
				}
				out << " </optgroup>\n"
				
			}
		}else{
			for(option in from) {
					String optkey = option.properties[optionKey]
					//String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
					def accountShortName=option.shortName
					def currency=option.currency.code
					def currencyId=option.currency.id
					def transType =option.transactionSubType?.serviceApplication?.service?.code
					def accountNumber=option.accountNumber+"("+currency+")"
					attrs.code = 'beneficiary.templates.accountdtl'+option.transactionSubType?.serviceApplication?.service?.code
					def paymentType = g.message(attrs)
					def formattedAccountNumber = option.accountNumber+"|"+transType //+ " | " + currency + " | " + paymentType
					def payeeBranchDType=option?.payeeBankBranch?.payeeBankType       
					def payeeBankBranch
					def bankName
					def bankCity
					def bankCountry
					def bankCode
					def bankBranch
					if(payeeBranchDType!= null && PayeeBankTypeEnum.DOMESTIC.equals(payeeBranchDType))
					{
						payeeBankBranch= option?.payeeBankBranch ? (DomesticBank)option?.payeeBankBranch : "";
						bankName=payeeBankBranch?.bankName
						bankCity=payeeBankBranch?.city
						bankCountry=payeeBankBranch?.country?.code
						bankCode=payeeBankBranch?.bankCode
						bankBranch=payeeBankBranch?.branchName
					}else if(payeeBranchDType!=null && PayeeBankTypeEnum.FOREIGN.equals(payeeBranchDType))
					{
						payeeBankBranch=option?.payeeBankBranch ? (ForeignBank)option?.payeeBankBranch : "";
						bankName=payeeBankBranch?.name1
						bankCity=payeeBankBranch?.cityCode
						bankCountry=payeeBankBranch?.countryCode
						bankCode=payeeBankBranch?.bankCode
						bankBranch=payeeBankBranch?.branch1
					}
					out << "  <option value=\"${optkey}\" data-msg=\"${accountShortName}\" data-code=\"${bankCode}\" data-bank=\"${bankName}\" data-branch=\"${bankBranch}\" data-city=\"${bankCity}\" data-country=\"${bankCountry}\" data-curncy=\"${currencyId}\">${formattedAccountNumber}</option>\n"
					//out << "  <option value=\"${optkey}\">${option.properties[optionValue]} </option>\n"
			}
		}
		out << "</select>\n"
		}else
		{
			 out << "<select id =\"${id}\" name=\"${name}\" required=\"required\" data-errormessage=\"Please select an account\" data-encrypt=\"yes\" >"
			 out << "</select>\n"
		}
	}
	def errors = {attrs, body ->
		out << render(template:"/common/errors")
	}
	
//	<vayana:iblookupSelect name="accountTypeId" id="accountTypeId"
//	type="CRY-SCHEME" domain = "ib"/>

	/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 */
	def lookupSelect = {attrs, body ->
		def type = attrs.type
		if (type) {
			String domain = (attrs.domain)?attrs.domain:'base'
			String optkey = 	(attrs.optionKey)?attrs.optionKey:'idVersion'
			List fromList = []
			fromList = commonService.getLookupValuesByType(type,domain)
			fromList.each { it.idVersion = it.id+','+it.version}
			attrs.from = fromList
			attrs.optionKey = optkey
			attrs.optionValue = "description"
			attrs.remove("domain")
			attrs.remove("type")
			//attrs.noSelection=['':'Select']
			out << g.select(attrs)
		}
	}
	
	/**
	 * @attr name required
	 */
	
	def tenantOpsCountrySelect= {attrs,body ->
	
		List fromList = []
		fromList=commonService.getTenantOperatingCountries()
		attrs.from=fromList
		attrs.optionKey = (attrs.optionKey)?attrs.optionKey:'idVersion'		
		attrs.optionValue="description"
		out<< g.select(attrs)
	}
	
	
	def getBranchList= {attrs,body ->
		
			List fromList = []
			fromList=commonService.getBranchList()
			attrs.from=fromList
			attrs.optionKey = (attrs.optionKey)?attrs.optionKey:'code'
			attrs.optionValue="description"
			out<< g.select(attrs)
		}
	
	def creditcards  = {attrs,body ->
		def tenantServiceCode = attrs.remove('tenantServiceCode')
		List fromList = []
		fromList=commonService.getCreditCardList(tenantServiceCode)
		attrs.from=fromList
		attrs.optionKey = (attrs.optionKey)?attrs.optionKey:'accountIdVersion'
		attrs.optionValue="maskedCCNumber"
		out<< g.select(attrs)
	}
/*	def tenantApplicationLocaleSelect= {attrs,body ->
		
			List fromList = []
			def from=commonService.getTenantApplicationLocales()
			from.each {
				fromList.add(idVersion:it.idVersion, value:it.locale.description)
			}
			attrs.from=fromList
			attrs.optionKey="idVersion"
			attrs.optionValue="value"
			out<< g.select(attrs)
		}*/
	
	def tenantApplicationLocaleSelect= {attrs,body ->
		def defaultLocaleFlag = attrs.remove('defaultLocaleFlag')
		List fromList = []
		def from=commonService.getTenantApplicationLocales(defaultLocaleFlag)
		from.each {
			fromList.add(idVersion:it.idVersion, value:it.locale.description)
		}
		attrs.from=fromList
		attrs.optionKey="idVersion"
		attrs.optionValue="value"
		out<< g.select(attrs)
	}
	
	/**
	 * @attr name required
	 */
	def tenantOpsCurrencySelect={attrs,body ->
		
		List fromList = [] 
		def required=attrs.required
		attrs.remove('required')
		def currencies = attrs.remove('currencies')
		if(currencies == null || currencies.isEmpty()){  
			fromList=commonService.getTenantOperatingCurrencies()
		}else{
			fromList = currencies;
		}
		attrs.from=fromList
		attrs.optionKey = (attrs.optionKey)?attrs.optionKey:'idVersion'		
		attrs.optionValue="code"
		if("Y".equals(required))
		{
		attrs.required=required
		}
		out<< g.select(attrs)
	}
	
	def tenantBaseCurrencySelect={attrs,body ->
		
		
		def required=attrs.required
		def invoker = SecurityUtils.getInvoker()
		attrs.remove('required')
		def fromListAllCurr=commonService.getTenantOperatingCurrencies()
		def fromListBaseCurr=baseCommonUtil.fetchBaseCurrency(invoker.getOperatingCountryId())
		attrs.from=fromListAllCurr
		attrs.value=fromListBaseCurr?.idVersion
		attrs.optionKey = (attrs.optionKey)?attrs.optionKey:'idVersion'
		attrs.optionValue="code"
		if(YesNoEnum.Y==required)
		{
		attrs.required=required
		}
		out<< g.select(attrs)
	}
	
	def tenantBaseCcySelect={attrs,body ->
		
		
		def required=attrs.required
		def invoker = SecurityUtils.getInvoker()
		attrs.remove('required')
		def fromListBaseCurr=baseCommonUtil.fetchBaseCurrency(invoker.getOperatingCountryId())
		attrs.from=fromListBaseCurr
		attrs.value=fromListBaseCurr?.idVersion
		attrs.optionKey = (attrs.optionKey)?attrs.optionKey:'idVersion'
		attrs.optionValue="code"
		if(YesNoEnum.Y==required)
		{
		attrs.required=required
		}
		out<< g.select(attrs)
	}
	
	def tenantServicesSelect = { attrs, body ->
		def selectedValue = attrs.remove('value')
		def module = attrs.remove('module')
		def businessfunction = attrs.remove('businessFunction')
		def transactionFlagCode =attrs.remove('transactionFlagCode')
		def from = commonService.getTenantServices(module, businessfunction,transactionFlagCode)
		def name = attrs.remove('name')
		def id = attrs.remove('id')
		id =id?id:name
		def groupBy = "serviceCategory"
		def optionKey = "idVersion"
		def optionValue = "serviceApplication"
		Set optGroupSet = new TreeSet()
		if (!module){
			throwTagError("Tag [tenantServicesSelect] is missing required attribute [module]")
		}
		//Make that sure the object we're working with, has groupBy, optionKey, and optionValue properties that actually
		//exist
		//def link = g.createLink(action:action,controller:controller,params:urlParams)
		if(from.size() > 0) {
			/*if(!from[0].properties[groupBy]) {
			 throw new MissingPropertyException("No such property: ${groupBy} for class: ${from[0].class.name}")
			 }*/

			if(!from[0].properties[optionKey]) {
				throw new MissingPropertyException("No such property: ${optionKey} for class: ${from[0].class.name}")
			}

			else if(!from[0].properties[optionValue]) {
				throw new MissingPropertyException("No such property: ${optionValue} for class: ${from[0].class.name}")
			}
		}

		if(from[0].properties[groupBy]) {
			from.each {
				optGroupSet.add(it.properties[groupBy])
			}
		}
		out << "<select id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" "

		attrs.each{key, value ->
			out << "${key}=\"${value.encodeAsHTML()}\" "
		}
		out << ">"

		if (from.size() > 1){
			out << "<option value=\"\" selected>Select</option>\n"
		}
	if(from[0].properties[groupBy]) {
			for(optGroup in optGroupSet) {
				out << " <optgroup label=\"${optGroup.encodeAsHTML()}\">\n"
				for(option in from) {
					if(option.properties[groupBy].equals(optGroup)) {
						String optkey = option.properties[optionKey]
						String code	=	option.serviceApplication.service.code  
						String description=option.serviceApplication.service.description              						
						//String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)						
						if(description.equals(selectedValue)){
							out << "  <option value=\"${optkey}\" data-code=\"${code}\" selected>${description}</option>\n"
						}else{
						out << "  <option value=\"${optkey}\" data-code=\"${code}\">${description}</option>\n"
						}
						
						
					}
				}
				out << " </optgroup>\n"
			}
		}else{
			for(option in from) {
				String optkey = option.properties[optionKey]
				//String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
				out << "  <option value=\"${optkey}\" >${option.properties[optionValue]} </option>\n"
			}
		}
		out << "</select>\n"
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 */
	def iblookupSelect = {attrs, body ->
		def type = attrs.type 
		def domain = attrs.domain
		def required=attrs.required  
		if (type) {
			attrs.remove("type")
			attrs.remove("domain")			
			List fromList = []
			fromList = commonService.getLookupValuesByType(type,domain)
			def messagePrefix = attrs.remove("messagePrefix");
			fromList.each { it.idVersion = it.id+','+it.version}
			attrs.from = fromList
			def optionKey = attrs.optionKey
			attrs.optionKey = optionKey?optionKey:"optionKey"
			if(YesNoEnum.N==required)  
			{
				attrs.required=required
			}
			/*if(optionKey == null){
				attrs.optionKey = "idVersion"
			}*/
			if(messagePrefix != null && messagePrefix !=""){    
				attrs.valueMessagePrefix = messagePrefix
			} else {
				attrs.optionValue = "description"   
			}    
//			attrs.noSelection=['':'Select']
			out << g.select(attrs)
		}
	}


	
	/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 * @attr findBy required
	 */
	//<vayana:select name="secondaryCurrencyId" id="secondaryCurrencyId"
	//	  optvalue="code" type="${CURRENCIES}" findBy="${ALL}"
	//	  domain="base"></vayana:select>
	def select = {attrs, body ->
		CommonEntityEnum type = CommonEntityEnum.valueOf(attrs.type);
		FindByEnum findBy = (attrs.findBy)?FindByEnum.valueOf(attrs.findBy):null 
		print attrs.domain
		String domain = (attrs.domain)?attrs.domain:'base'
		String optvalue = 	(attrs.optvalue)?attrs.optvalue:'description'
		def optionkey = 	(attrs.optionKey)?attrs.optionKey:'idVersion'
		def required=attrs.required
			print domain
			List fromList = []
			fromList = commonService.getCommonObjects(type,findBy,domain)
			//print fromList.size();
			fromList.each { it.idVersion = it.id+','+it.version
				print it.idVersion
			}
			attrs.from = fromList
			attrs.optionKey = optionkey
			attrs.optionValue = optvalue
//			attrs.noSelection=['null':'Select']
			attrs.remove("selectedObject")
			attrs.remove("type")
			attrs.remove("optvalue")
			attrs.remove("domain")
			attrs.remove("required")
			if(YesNoEnum.N==required)
			{
				attrs.required=required
			}
			out << g.select(attrs)
		
	}
	/**
	 * @author elanchezhiyan
	 */
	def tenantBranchSelect = {attrs, body ->
		CommonEntityEnum type = CommonEntityEnum.valueOf("BRANCH");
		FindByEnum findBy = FindByEnum.valueOf("ALL");
		def domain = "ib";     
		def optionValue = 	(attrs.optionValue)?attrs.optionValue:'description'
		def optionKey = 	(attrs.optionKey)?attrs.optionKey:'idVersion'
		List fromList = []
		fromList = commonService.getCommonObjects(type,findBy,domain)    
		fromList.each { it.idVersion = it.id+','+it.version;}
		attrs.from = fromList
		attrs.optionKey = optionKey
		attrs.optionValue = optionValue   
		out << g.select(attrs)
	}
	def customerBranch={ attrs, body ->
		def val = attrs.remove("value");
		if(val != null && val != ""){
			def cBranch = commonService.fetchBranchById(val);
			if(cBranch != null){
				out << "<input type='hidden' name='${attrs?.name}' id='${attrs?.id}' value='${cBranch?.idVersion}'/>"
				out << "<input type='text' name='tenantBranchDesc' id='tenantBranchDesc' required='required' value='${cBranch?.description}'/>"
			}
		}
	}
	
	/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 * @attr findBy required
	 */
	def ibSelect = {attrs, body ->
		CommonEntityEnum type = attrs.type
		FindByEnum findBy = attrs.findBy
			attrs.remove("type")
			List fromList = []
			fromList = commonService.getIBCommonObjects(type,findBy)
			fromList.each { it.idVersion = it.id+','+it.version}
			attrs.from = fromList
			attrs.optionKey = "idVersion"
			attrs.optionValue = "description"
//			attrs.noSelection=['null':'Select']
			attrs.remove("selectedObject")
			out << g.select(attrs)
		
	}
	
	
	/**
	 * @attr name required
	 * @attr id required
	 */
	def accountSelect = {attrs, body ->
		print "The attrs of ${attrs}"
			attrs?.from?.each { it.idVersion = it.id+','+it.version}
			attrs.optionKey = "idVersion"
			attrs.optionValue = "accountNumber"
//			attrs.noSelection=['null':'Select']
			out << g.select(attrs)
		
	}
	
	/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 */
	def vayanaSelect = {attrs, body ->
		print "The attrs of ${attrs}"
			attrs?.from?.each { it.idVersion = it.id+','+it.version}
			attrs.optionKey = "idVersion"
			attrs.optionValue = attrs.type
			attrs.remove("type")
//			attrs.noSelection=['null':'Select']
			out << g.select(attrs)
		
	}
	
	/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 *
	 */
	def currencySelect = {attrs, body ->
		CommonEntityEnum type = attrs.type
		FindByEnum findBy = attrs.findBy
		print "The attrs of ${attrs}"
		if (type) {
			String domain = (attrs.domain)?attrs.domain:'base'
			attrs.remove("type")
			attrs.remove("findBy")
			attrs.remove("domain")
			List fromList = []
			fromList = commonService.getCommonObjects(type , findBy , domain)
			fromList.each { it.idVersion = it.id+','+it.version}
			attrs.from = fromList
			attrs.optionKey = "idVersion"
			attrs.optionValue = "code"
			//attrs.placeholder = "Select"
//			attrs.noSelection=['null':'Select']
			out << g.select(attrs)
		}
	}
	
	/**
	 *
	 */
	def transactionTypeSelect = {attrs, body ->
			List fromList = []
			fromList = attrs.from
			fromList.each { it.code = it.code+','+it.id}
			attrs.remove("type")
			attrs.from = fromList
			attrs.optionKey = "id"
			attrs.optionValue = "description"
			out << g.select(attrs)
	}
	
	/**
	 * @attr amount required
	 * @attr currency required
	 */
	def formatAmount= {attrs, body ->
		if (!attrs.containsKey('amount')) {
			throwTagError("Tag [formatAmount] is missing required attribute [amount]")
		}
		if (!attrs.containsKey('currency')) {
			throwTagError("Tag [formatAmount] is missing required attribute [currency]")
		}
		def amount = attrs.amount
		def currency = attrs.currency
		Locale locale = null;
		if ("INR".equals(currency)) {
			locale = new Locale("en_IN");
		}else if ("USD".equals(currency)) {
			locale = new Locale("en_US");
		}else{
			locale = Locale.getDefault();
		}
		def formatted = null;
		if (amount != null && amount !=""){
			formatted = MoneyUtils.formatAmount(amount, locale, currency);
		}
		if(formatted){
			out << formatted.trim();
		}else if(currency != null && currency !=''){
		formatted = MoneyUtils.formatAmount(null, locale, currency);
		out << formatted;
		}
				
	}
	
	def accountNumber = {attrs, body ->
		if (!attrs.containsKey('value')) {
			throwTagError("Tag [value] is missing required attribute [amount]")
		}
		def acNo = attrs.value
		out << acNo;
	}
	
	/**
	 * @attr dir required
	 * @attr file required
	 */
	def tenantimg  = {attrs, body ->
		if (!attrs.containsKey('dir')) {
			throwTagError("Tag [dir] is missing required attribute [tenantimg]")
		}
		if (!attrs.containsKey('file')) {
			throwTagError("Tag [file] is missing required attribute [tenantimg]")
		}
		def directory = attrs.dir
		attrs.dir ="themes/default_theme/" + directory
		out << g.img(attrs)
	}
	
	/**
	 * @attr documentDetailId required
	*/
	def img = {attrs, body ->
		if (!attrs.containsKey('documentDetailId')) {
			throwTagError("Tag [documentDetailId] is missing required attribute [img]")
		}
		String documentDetailId = attrs.documentDetailId;
		attrs.remove("documentDetailId");
		
		//def src="${createLink(controller:'userProfile', action:'image', id:documentDetailId)}"
		def src;		
		if(attrs.containsKey('isSecured') && "Y".equals(attrs.isSecured)){
			src="${createLink(controller:'userProfile', action:'image', id:documentDetailId)}"
		}else{
			src="${createLink(controller:'user', action:'image', id:documentDetailId)}"
		}		
		
		
		def outString ="<img src=${src} ";
		if (attrs.containsKey('height')) {
			def height=attrs.height;
			outString += " height='${height}'"
		}
		if (attrs.containsKey('width')) {
			def width=attrs.width;
			outString += " width='${width}'"
		}
		if (attrs.containsKey('isSecureImage')) {
			def isSecureImage = attrs.remove("isSecureImage");
			outString = "<label>"+ outString + "/> <input type='checkbox' value='${documentDetailId}' name='secureImg' id='secureImg${documentDetailId}' checked='checked' class='group-required' data-errormessage='Please select two of yor secure images'></label>"
		}else{
			outString += "/>"
		}
		out << outString
	}
	
	 /**
	 * Outputs the given <code>Date</code> object in the specified format. If
	 * the <code>date</code> is not given, then the current date/time is used.
	 * If the <code>format</code> option is not given, then the date is output
	 * using the default format.<br/>
	 *
	 * e.g., &lt;vayana:formatDate date="${myDate}" format="yyyy-MM-dd HH:mm" /&gt;<br/>
	 *
	 * @see java.text.SimpleDateFormat
	 *
	 * @emptyTag
	 *
	 * @attr date the date object to display; defaults to now if not specified
	 * @attr format The formatting pattern to use for the date, see SimpleDateFormat
	 * @attr formatName Look up format from the default MessageSource / ResourceBundle (i18n/*.properties file) with this key. If format and formatName are empty, format is looked up with 'default.date.format' key. If the key is missing, 'yyyy-MM-dd HH:mm:ss z' formatting pattern is used.
	 * @attr type The type of format to use for the date / time. format or formatName aren't used when type is specified. Possible values: 'date' - shows only date part, 'time' - shows only time part, 'both'/'datetime' - shows date and time
	 * @attr timeZone the time zone for formatting. See TimeZone class.
	 * @attr locale Force the locale for formatting.
	 * @attr style Use default date/time formatting of the country specified by the locale. Possible values: SHORT (default), MEDIUM, LONG, FULL . See DateFormat for explanation.
	 * @attr dateStyle Set separate style for the date part.
	 * @attr timeStyle Set separate style for the time part.
	 * @attr showTime whether to show time or not
	 */
	def formatDate  = {attrs, body ->
		def defaultformat = "dd-MMM-yyyy";
		def dateStyle = "SHORT"
		def showTime = "false"
		if (!attrs.containsKey('date')) {
			throwTagError("Tag [date] is missing required attribute [formatDate]")
		}
		
		showTime = attrs.showTime;
		if (showTime == "true"){
			attrs.format = defaultformat + " hh:mm aa";                
		}
		
		def format = attrs.format;
		if (!format){
			attrs.format = defaultformat;
		}
	
		out << g.formatDate(attrs)
	}
	
	def vayanaDate = {
		attrs, body ->
		def errMsg = attrs.remove('errormessage')
		errMsg = (errMsg != null && errMsg != "") ? errMsg : 'Please Enter Date'
		//Date date = DateFormat.getInstance().parse(attrs.value)
		def date = (attrs.value == "")?"":attrs.value?.format("yyyy-MM-dd")
		def required=(attrs.required=="")?"":attrs?.required
		def min = attrs.remove("min");
		if(attrs.value == '' )
		{
			if(required=='')
			out <<  "<input type='date' name="+ attrs.name+" id = "+attrs.id+" value=''  data-errormessage=\'"+errMsg+"\' min=\'"+min+"\'  />"
			else
			out <<  "<input type='date' name="+ attrs.name+" id = "+attrs.id+" value=''  data-errormessage=\'"+errMsg+"\' min=\'"+min+"\' required=\"${required}\" />"
		}
		else
		{
			if(required=='')
			out <<  "<input type='date' name="+ attrs.name+" id = "+attrs.id+" value="+attrs.value?.format("yyyy-MM-dd")+"  data-errormessage=\'"+errMsg+"\' min=\'"+min+"\' />"
			else
			out <<  "<input type='date' name="+ attrs.name+" id = "+attrs.id+" value="+attrs.value?.format("yyyy-MM-dd")+"  data-errormessage=\'"+errMsg+"\' min=\'"+min+"\' required=\"${required}\" />"
			
		}
	}
	
	def formatDateLabel = {
		attrs, body ->
		def date =  attrs.value?.format("yyyy-MM-dd")
		out<<date
	}
	
	/**
	 * @attr controller required
	 * @attr action required
	 * @attr update required
	*/
	def pager = {attrs, body ->
		def controller = attrs.remove("controller")
		def action = attrs.remove("action")
		def update = attrs.remove("update")
		def paramsModel = attrs.remove("paramsModel")
		out << render(template:"/common/pager", model:[controller:controller, action:action, update:update ,paramsModel:paramsModel])
	}
	
	def pagerModel = {attrs, body ->
		out << render(template:"/common/pagerModel")
	}
	
	/**
	 * 	@attr controller required
	 *  @attr action required
	 *  @attr update required
	 *  @attr title required
	*/
	def menuItemRemote = {attrs, body ->
		def controller = attrs.remove("controller")
		def action = attrs.remove("action")
		def update = attrs.remove("update")
		def title = attrs.remove("title")
		def displayPlusSign = false;
		def dirtyFlag = attrs.remove("dirtyFlag");
		dirtyFlag = (dirtyFlag!=null && dirtyFlag!='') ? dirtyFlag : false;
		/*def function = attrs.remove("function");
		if (StringUtils.hasText(function) && hasAccess(attrs)) {
			displayPlusSign = attrs.remove("displayPlusSign")
		}*/
		//Temporarily Commenting for KHCB
		//if (hasAccess(attrs)) {
			displayPlusSign = attrs.remove("displayPlusSign")
		//}
		def plusSignController = attrs.remove("plusSignController")
		def plusSignAction = attrs.remove("plusSignAction")
		def plusSignUrlParams = attrs.remove("plusSignUrlParams")
		def ulClass = attrs.remove("ulClass")
		out << render(template:"/common/menuItem", model:[controller:controller, action:action, update:update,dirtyFlag:dirtyFlag,title:title, displayPlusSign:displayPlusSign, plusSignController:plusSignController,plusSignAction:plusSignAction,plusSignUrlParams:plusSignUrlParams,ulClass:ulClass])
	}

	
		
	def secureColors = {attrs, body->
		def ulpId = attrs.remove("ulpId");
		def tenAppId = attrs.remove("tenAppId");
		CommonResponse commResModel = null;
		List<ColorPaleteBasketDetail> colorPaleteBasketDetails = null;
		UserColorPalete userSelectedColor = null;
		if(ulpId && tenAppId)
		{
			commResModel = commonService.getSecureColorForUser(ulpId.toLong(),tenAppId.toLong());
			colorPaleteBasketDetails = (List<ColorPaleteBasketDetail>)commResModel.getAttribute("basketColors");
			userSelectedColor= (UserColorPalete)commResModel.getAttribute("userSelectedColor");
		}
		else
		{
			throwTagError("Tag [secureColors] is missing required attribute [ulpId]");
		}
		out << render(template:"/common/loginsecurecolors",model:[basketColors:colorPaleteBasketDetails,userSelectedColor:userSelectedColor] );
	}
	
	/**
	 * 	@attr ulpId required
	 */
	def secureImages = {attrs, body ->
		def ulpId = attrs.remove("ulpId");
		UserSecureImageResponse secureImagesModel = null;
		if (ulpId){
			secureImagesModel = commonService.getSecureImagesForUser(ulpId);
			List<String> userSecureImages = new ArrayList<String>();
			secureImagesModel.getUserSecureImages().each {
				userSecureImages.add(it.toString())
			}
			session.userSecureImages = userSecureImages;
		}else{
			throwTagError("Tag [secureImages] is missing required attribute [ulpId]");
		}
		out << render(template:"/common/secureImages", model:[secureImagesModel:secureImagesModel]);
	}
	
	/**
	* 	@attr name required
	*   @attr value required
	*  */
	def ftValidate={attrs,body ->
		def name=attrs.remove("name")
		def buttonEvent=attrs.remove("buttonEvent")
		def value=attrs.remove("value")
		def enableButton=attrs.remove("enableButton")
		def classStyle=attrs.remove("class")
		def controller=attrs.remove("controller")
		def action =attrs.remove("action")
		def secondaryAction=attrs.remove("secondaryAction")
		def secondaryController=attrs.remove('secondaryController')
		def secondaryDiv=attrs.remove('secondaryDiv')
		out << render(template:"/common/ftValidate", model:[name:name,value:value,enableButton:enableButton,classStyle:classStyle,controller:controller,action:action,secondaryAction:secondaryAction,secondaryController:secondaryController,secondaryDiv:secondaryDiv,buttonEvent:buttonEvent])
	}
	
	def twoFaGenerate={attrs,body ->
		def twoFactorType=attrs.remove("twofactortype")
		def userLoginProfileId=attrs.remove("userLoginProfileId")
		def genericRequestHeader=attrs.remove("requestHeader")
		def secondaryAction=attrs.remove("secondaryAction")
		def twoFAModule=attrs.remove("twoFAModule")
		def secondaryController=attrs.remove("secondaryController")
		def otpgenmodel=commonService.getOTPGenerationResponse(userLoginProfileId.toString(),genericRequestHeader)
		out << render(template:"/common/twoFaModel", model:[otpgenmodel:otpgenmodel,twofactortype:twoFactorType,secondaryController:secondaryController,secondaryAction:secondaryAction,twoFAModule:twoFAModule])
		
	}
	
	def twoFAButton={attrs,body ->
		def buttonid=attrs.remove("buttonid")
		def controller=attrs.remove("controller")
		def action=attrs.remove("action")
		def value=attrs.remove("value")
		def twoFAModule=attrs.remove("twoFAModule")
		out << render(template:"/common/twoFaButton",model:[controller:controller, action:action,buttonid:buttonid,value:value,twoFAModule:twoFAModule])
	}
	
	//	<vayana:radioGroup name="radioName" id="radioId" type="CHEQUE_BOOK_LEAVE" checked="25" required="required" />
	/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 */
	def radioGroup = {attrs, body ->
		def type = attrs.type  
		def name = attrs.name
		def mandi = attrs.required
		def defaultvalue = attrs.checked
		def invoker = SecurityUtils.getInvoker()
		if (type) {
			String domain = (attrs.domain)?attrs.domain:'base'
			List fromList = []
			if(domain.equals('tenant')){
				fromList = commonService.getTenantLookUpValuesByType(type?.toString())
			}else{			
				fromList = commonService.getLookupValuesByType(type)
			}
			fromList.each {
				it.idVersion = it.id+','+it.version  
				println it.idVersion
			}
			println defaultvalue
			attrs.values = fromList
			attrs.labels = fromList
			attrs.remove("domain")
			attrs.remove("type")
			attrs.remove("required")
			attrs.remove("checked")
			out << "<p>"
			fromList.each {
				out << "<label for=\"${it.code}\">${it.code}</label>"
				out << "<input type='radio' name=\"${name}\" id=\"${it.code}\" value=\"${it.code}\" checked=\"checked\" data-nullable=\"${mandi}\" />"
			}
			out << "</p>"
		}
	}
	
	
	
	
	/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 */
	def radioManagerCheque = {attrs, body ->
		def type = attrs.type
		def name = attrs.name
		def mandi = attrs.required
		def defaultvalue = attrs.checked
		def invoker = SecurityUtils.getInvoker()
		if (type) {
			String domain = (attrs.domain)?attrs.domain:'base'
			List fromList = []
			if(domain.equals('tenant')){
				fromList = commonService.getTenantLookUpValuesByType(type?.toString())
			}else{
				fromList = commonService.getLookupValuesByType(type)
			}
			fromList.each {
				it.idVersion = it.id+','+it.version
				println it.idVersion
			}
			println defaultvalue
			attrs.values = fromList
			attrs.labels = fromList
			attrs.remove("domain")
			attrs.remove("type")
			attrs.remove("required")
			attrs.remove("checked")
			out << "<p>"
			fromList.each {
				out << "<label for=\"${it.code}\">${it.description}</label>"
				if(it?.code.equals("M")){
					out << "<input type='radio' name=\"${name}\" id=\"${it.code}\" value=\"${it.code}\"/>"
				}else if(it?.code.equals("D")){
					out << "<input type='radio' name=\"${name}\" id=\"${it.code}\" value=\"${it.code}\" />"
				}
				
			}
			out << "</p>"
		}
	}
	
	//	<vayana:representativeInfo />
	def representativeInfo = {attrs,body ->
			def personName = "";
			def homeBranch = "";
			def identyDetails = "";
			def accountId = (attrs.accountNumber)?attrs.accountNumber:null
			Long loginprofileId = commonService.getUserLoginProfile().getId();
			IBUserInformationResponse userInfo = commonService.getUserBranchInformation(loginprofileId, accountId);
			personName = userInfo.getCustomerFullName();
			identyDetails = userInfo.getUserIdentyDetails();
			homeBranch = userInfo.getHomeBranch()?.getId();
			attrs.remove("accountNumber");
			out << render(template:"/common/representativeInfo",model:[customerName:personName,customerIdenty:identyDetails,homeBranchName:homeBranch])
	}
	
	def actionSubmit ={ attrs,body->
		out << g.actionSubmit(attrs)
	}
	
	def checkBox ={ attrs,body->
		out << g.checkBox(attrs)
	}
	def createLink ={ attrs,body->
		out << g.createLink(attrs)
	}
	def field ={ attrs,body->
		out << g.field(attrs)
	}
	def fieldValue ={ attrs,body->
		out << g.fieldValue(attrs)
	}
	def form ={ attrs,body->
		out << g.form(attrs)
	}
	def formRemote ={ attrs,body->
		out << g.formRemote(attrs)
	}
	def formatBoolean ={ attrs,body->
		out << g.formatBoolean(attrs)
	}
	def formatDateNew ={ attrs,body->
		out << g.formatDate(attrs)
	}
	def formatNumber ={ attrs,body->
		out << g.formatNumber(attrs)
	}
	def hiddenField ={ attrs,body->
		out << g.hiddenField(attrs)
	}
	def imgNew ={ attrs,body->
		out << g.img(attrs)
	}
	def link ={ attrs,body->
		out << g.link(attrs)
	}
	def message ={ attrs,body->
		out << g.message(attrs)
	}
	def passwordField ={ attrs,body->
		out << g.passwordField(attrs)
	}
	def radio ={ attrs,body->
		out << g.radio(attrs)
	}
	def radioGroupNew ={ attrs,body->
		out << g.radioGroup(attrs)
	}
	def remoteField ={ attrs,body->
		out << g.remoteField(attrs)
	}
	def remoteFunction ={ attrs,body->
		out << g.remoteFunction(attrs)
	}
	def remoteLink ={ attrs,body->
		out << g.remoteLink(attrs)
	}
	def render ={ attrs,body->
		out << g.render(attrs)
	}
	def renderErrors ={ attrs,body->
		out << g.renderErrors(attrs)
	}
	def resource ={ attrs,body->
		out << g.resource(attrs)
	}
	def selectNew ={ attrs,body->
		out << g.select(attrs)
	}
	def set ={ attrs,body->
		out << g.set(attrs)
	}
	
	
	/**
	 *
	 */
	def submitButton = {attrs, body ->
		def controller = attrs.controller
		def action = 	attrs.action
		def update = attrs.update
		def success = attrs.onSuccess
		def displayName = attrs.displayname ? attrs.displayname:"Save"
		def hideSaveFlag = attrs.hideSaveFlag ? attrs.hideSaveFlag : "false" 
		// For Save Starts
		if(hideSaveFlag.equals("false"))
		{
			attrs.action=action
			attrs.controller=controller
			attrs.value=displayName
			attrs.params=[isdraft:"false"]
			attrs.before="if (checkFormValidity()) {return false;}"
			attrs.update = update
			attrs.onSuccess = "${attrs.onSuccess};${remoteFunction(action:'messages', controller:'generic', update:'messagesDiv')};"
			out<< g.submitToRemote(attrs)
		}
		
		//For Save Ends
		//For Draft Starts
		attrs.name="isDraftSubmission"
		attrs.id = "isDraftSubmission"
		attrs.value = false
		out<< g.hiddenField(attrs)
		attrs.remove("name")
		attrs.id = "isDraftSubmissionbutton"
		attrs.remove("value")
		attrs.remove("controller")
		attrs.remove("action")
		attrs.action=action
		attrs.controller=controller
		attrs.params = params + ['isdraft':true]
		attrs.value="Save as Draft"
		attrs.before="jQuery('#isDraftSubmission').val(true);"
		attrs.onSuccess = "${attrs.onSuccess};${remoteFunction(action:'messages', controller:'generic', update:'messagesDiv')};${success};"
		attrs.class="cancelForm btn_next"
		out<< g.submitToRemote(attrs)
		//For Draft Ends
	}
	
	def submitToRemote = {attrs, body ->
		attrs.after="disableForm()"
		attrs.onSuccess = "${attrs.onSuccess};${remoteFunction(action:'messages', controller:'generic', update:'messagesDiv')};enableForm();"
		attrs.onFailure = "${attrs.onFailure};enableForm();"
		out << g.submitToRemote(attrs)
	}
	def textArea ={ attrs,body->
		out << g.textArea(attrs)
	}
	def textField ={ attrs,body->
		out << g.textField(attrs)
	}
	
	/**
	 * @attr accountno required
	 * @attr currency required
	 */
	def formatAccount ={attrs,body->
		def accountno=attrs.remove("accountno")
		def currency=attrs.remove("currency")
		
		out << accountno+"("+currency+")"
		
	}
	
	/*
	 * To get Beneficiary for ULP
	 */
	def beneficiarySelect = {attrs, body ->
		List fromList = []
		fromList = commonService.getBeneficiaries();
		//fromList.each { it.code = it.code+','+it.id}
		//attrs.remove("type")
		attrs.from = fromList
		attrs.optionKey = "id"
		attrs.optionValue = "shortName"
		out << g.select(attrs)
	}
	
	/*
	 * To get Beneficiary Ins for ULP
	 */
	def beneficiaryInstructionSelect = {attrs, body ->
		List fromList = []
		//def name = attrs.remove('name')
		def type = attrs.remove('type')
		def beneId=attrs.remove('beneId')
		fromList = commonService.getFriendsAndFamilyAccount(beneId.toLong())
		Set categorySet = new HashSet()
		attrs.from = fromList
		attrs.optionKey = "idVersion"
		attrs.optionValue = "shortName"
		out << g.select(attrs)
		
	}
	
	
	/*
	 * To get Registered Biller for ULP from DB
	 */
	def billerSelect = {attrs, body ->
		List fromList = []
		fromList = commonService.getActiveBillerSummmary();
		//fromList.each { it.code = it.code+','+it.id}
		//attrs.remove("type")
		attrs.from = fromList
		attrs.optionKey = "id"
		attrs.optionValue = "shortName"
		out << g.select(attrs)
	}
	
	/*To get Biller Instruction for ULP */
	def billerInstructionSelect = { attrs, body ->
		//def name = attrs.remove('name')
		def type = attrs.remove('type')
		def billerId=attrs.remove('billerId')
		def fromList = commonService.getBillerInstructionDetails(billerId.toLong())
		Set categorySet = new HashSet()
		attrs.from = fromList
		attrs.optionKey = "idVersion"
		attrs.optionValue = "shortName"
		out << g.select(attrs)
	}
	
	
	
	/*
	 * Biller Instructions
	 */
	def toBPAccountSelect = { attrs, body ->
		def name = attrs.remove('name')
		def type = attrs.remove('type')
		def beneId=params.beneId
		def billerInsIdVer = (params.billerInsId)?params.billerInsId:''
		def buttonEvent = (params.buttonEvent)?params.buttonEvent:''
		def from = commonService.getBillerInstructions(beneId.toLong(),buttonEvent)
		def id = attrs.remove('id')		
		id =id?id:name
		def groupBy = "category"
		def optionKey = "idVersion"
		def optionValue = "shortName"
		def target = attrs.target
		Set optGroupSet = new TreeSet()
				if (!name){
			throwTagError("Tag [fromAccount] is missing required attribute [name]")
		}
		//Make that sure the object we're working with, has groupBy, optionKey, and optionValue properties that actually
		//exist
		//def link = g.createLink(action:action,controller:controller,params:urlParams)
		if(from.size() > 0) {
			/*if(!from[0].properties[groupBy]) {
				throw new MissingPropertyException("No such property: ${groupBy} for class: ${from[0].class.name}")
			}*/
				
			if(!from[0].properties[optionKey]) {
				throw new MissingPropertyException("No such property: ${optionKey} for class: ${from[0].class.name}")
			}
	
			else if(!from[0].properties[optionValue]) {
				throw new MissingPropertyException("No such property: ${optionValue} for class: ${from[0].class.name}")
			}
		}
		
		if(from[0].properties[groupBy]) {
			from.each {
				optGroupSet.add(it.properties[groupBy])
			}
		}
		out << "<select id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" "
	
		attrs.each{key, value ->
			out << "${key}=\"${value.encodeAsHTML()}\" "
		}
		out << ">"
		
		if (from.size() > 1){
			out << "<option value=\"\" selected>Select</option>\n"
		}
		if(from[0].properties[groupBy]) {
			for(optGroup in optGroupSet) {
				out << "<optgroup label=\"${optGroup.encodeAsHTML()}\">\n"
				for(option in from) {
					if(option.properties[groupBy].equals(optGroup)) {
						String optkey = option.properties[optionKey]
						String accountShortName=option.shortName
						String mobileNo=option.billerData[0].dataVarcharValue
						//String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
						if(optkey.equals(billerInsIdVer)){
							out << "  <option value=\"${optkey}\" data-msg=\"${accountShortName}\" selected>${mobileNo}</option>\n"
						}else{
							out << "  <option value=\"${optkey}\" data-msg=\"${accountShortName}\">${mobileNo}</option>\n"
						}
					}
				}
				out << " </optgroup>\n"
			}
		}else{
			for(option in from) {
					String optkey = option.properties[optionKey]
					//String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
					out << "  <option value=\"${optkey}\">${option.properties[optionValue]} </option>\n"
			}
		}
		out << "</select>\n"
	}
	
	
	/*
	 * Last N Months List
	 */
	def lastNmonthlist = {attrs,body->
		int N = 6;
		def flag = attrs.remove('currentMonthRequired')
		flag = (flag != null && flag != "") ? flag : "NO" 
		List fromList = []
		int startWith = ("YES".equalsIgnoreCase(flag)) ? 0 : 1
		for(int i=startWith;i < N;i++){
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH,-i);
			fromList << cal.getTime().format('MMM-yyyy')
		}
		attrs.from = fromList;
		out << g.select(attrs)
	}
	
	def messages = {attrs, body ->
		out << render(template:"/common/messages")
	}
	
	def popupMessages = {attrs, body ->
		out << render(template:"/common/popupmessages")
	}
	
	def flowerror={attrs,body ->
		out << render(template:"/common/flowerror")
	}
		
	/**
	 * @attr secondaryAction required
	 * @attr secondaryController required
	 * @attr primaryModel required
	 * @attr moduleType required
	 *
	 */
	def favouriteSchPayment={attrs,body ->
		def secondaryAction=attrs.remove('secondaryAction')
		  def secondaryController=attrs.remove('secondaryController')
		   def primaryModel=attrs.remove('primaryModel')
		def moduleType=attrs.remove('moduleType')
		def payeeInsOrBeneId
		def templatePage
		if(!primaryModel?.paymentScheduleDetail?.isEmpty())
		{
			if("OA".equals(moduleType))
			{
				payeeInsOrBeneId=primaryModel?.paymentScheduleDetail?.get(0)?.payeeInstruction?.id
			}else if("FF".equals(moduleType)){
				payeeInsOrBeneId=primaryModel?.paymentScheduleDetail?.get(0)?.payeeInstruction?.beneficiary?.id
			}
		}
		out <<render(template:"/common/futurepaymentfavourite",model:[secondaryAction:secondaryAction,secondaryController:secondaryController,favPaymentDetailModel:primaryModel,payeeInsOrBeneId:payeeInsOrBeneId])

	}
	/**
	 * @attr secondaryAction required
	 * @attr secondaryController required
	 * @attr primaryModel required
	 * @attr moduleType required
	 */
	 
	 def favouritePastPayment={attrs,body ->
		def secondaryAction=attrs.remove('secondaryAction')
		def secondaryController=attrs.remove('secondaryController')
		def primaryModel=attrs.remove('primaryModel')
		def moduleType=attrs.remove('moduleType')
		def payeeInsOrBeneId
		def templatePage
		if(!primaryModel?.pastPaymentDetail?.isEmpty())
		{
			if("OA".equals(moduleType))
			{
				payeeInsOrBeneId=primaryModel?.pastPaymentDetail?.get(0)?.payeeInstruction?.id
			}else if("FF".equals(moduleType)){
				payeeInsOrBeneId=primaryModel?.pastPaymentDetail?.get(0)?.payeeInstruction?.beneficiary?.id
			}else if("BP".equals(moduleType)){
				payeeInsOrBeneId=primaryModel?.pastPaymentDetail?.get(0)?.payeeInstruction?.biller?.id
			}
		}
		out <<render(template:"/common/pastpaymentfavourite",model:[secondaryAction:secondaryAction,secondaryController:secondaryController,favPaymentDetailModel:primaryModel,payeeInsOrBeneId:payeeInsOrBeneId])

		}
	
	def messageSubject = {attrs, body->
		def tenantlookupcode = attrs.tenantlookupcode
		if (tenantlookupcode) {
		  
			List fromList = []
			fromList = commonService.getMessageSubject(tenantlookupcode)
			fromList.each {
				it.idVersion = it.id+','+it.version
				it.subjectDescription = it.messageSubject.description
				}
			attrs.from = fromList
			attrs.optionKey = "idVersion"
			attrs.optionValue = "subjectDescription"
			out << g.select(attrs)
		}
		
	}
	
	/**
	 * @attr accountId required
	 */
	def formatFromAccount={attrs,body ->
		def accountId=attrs.remove('accountId')
		def beneInstruction=commonService.getUserAccount(accountId)
		def acctNum = "${beneInstruction?.accountNumber}"    
		out <<"<p>${beneInstruction?.shortName}-${beneInstruction?.accountType?.description}</p>"
		if(BusinessFunctionConstants.CREDIT_CARD_TRANS.equals(beneInstruction?.transactionSubType?.serviceApplication?.service?.code)){
			out << "<p>"+commonService.maskCreditCardNumber(acctNum)+" (${beneInstruction?.currency?.code})</p>"
		} else {
			out <<"<p>${acctNum} (${beneInstruction?.currency?.code})</p>"
		}
	}
	
	/**
	 * @attr beneInstructionId required
	 */
	def formatFFAccount={attrs,body ->
		def beneInsId=attrs.remove('beneInstructionId')
		def beneInstruction=commonService.getFFAccount(beneInsId)
		def payeeBranchDType=beneInstruction?.payeeBankBranch?.payeeBankType
		def payeeBankBranch
		def bankName
		def bankCity
		def bankCountry
		def formatBeneBankDetails
		if(payeeBranchDType!=null && PayeeBankTypeEnum.DOMESTIC.equals(payeeBranchDType))
		{
			payeeBankBranch=beneInstruction?.payeeBankBranch ? (DomesticBank)beneInstruction?.payeeBankBranch : ""; 
			bankName=payeeBankBranch?.bankName
			bankCity=payeeBankBranch?.city
			bankCountry=payeeBankBranch?.country?.code
		}else if(PayeeBankTypeEnum.FOREIGN.equals(payeeBranchDType))
		{
			payeeBankBranch=beneInstruction?.payeeBankBranch ? (ForeignBank)beneInstruction?.payeeBankBranch  : ""; 
			bankName=payeeBankBranch?.name1
			bankCity=payeeBankBranch?.cityCode
			bankCountry=payeeBankBranch?.countryCode
		}
		def accountNum = "${beneInstruction?.accountNumber}" 
		if(BusinessFunctionConstants.OWN_ACCOUNT_TRANS.equals(beneInstruction?.transactionSubType?.serviceApplication?.service?.code)){
			out <<"<p>${beneInstruction?.shortName}-${beneInstruction?.accountType?.description}</p>"
		}else{
			out << "<p>${beneInstruction?.shortName}</p>"  
		}
		
		if(BusinessFunctionConstants.CREDIT_CARD_TRANS.equals(beneInstruction?.transactionSubType?.serviceApplication?.service?.code)){
		  out << "<p>"+commonService.maskCreditCardNumber(accountNum)+" (${beneInstruction?.currency?.code})</p>"
	   }else{
	   	  out << "<p>${accountNum} (${beneInstruction?.currency?.code})</p>"   
	   }
		
		
		if(bankName != null){
			formatBeneBankDetails = bankName;
			//out << "<p> ${bankName}, ${bankCity}, ${bankCountry}.</p>"
		}		
		if(bankCity != null){
			formatBeneBankDetails = formatBeneBankDetails.concat(",").concat(bankCity);
		}		
		if(bankCountry !=null){
			formatBeneBankDetails = formatBeneBankDetails.concat(",").concat(bankCountry);
		}		
		if(formatBeneBankDetails!=null){
			out << "<p> ${formatBeneBankDetails}.</p>"
		}
		
	}
	
	def formatTransactionAmount={attrs,body ->
		def transactionAmount=attrs.remove('transactionAmount')
		def transactionCurrency=attrs.remove('transactionCurrency')
		
				
		Locale locale = null;
		if ("INR".equals(transactionCurrency)) {
			locale = new Locale("en_IN");
		}else if ("USD".equals(transactionCurrency)) {
			locale = new Locale("en_US");
		}else{
			locale = Locale.getDefault();
		}
		def formatted = null;
		if (transactionAmount && transactionCurrency){
			formatted = MoneyUtils.formatAmount(transactionAmount, locale, transactionCurrency);
		
		out <<"<span class=\"cur\">${transactionCurrency}</span>&nbsp;<span class=\"amt\">${formatted}</span>" ;
		}
		
		}
	/**
	 * @attr action required
	 * @attr controller required
	 * @attr successAction required
	 * @attr successController required
	 * @attr targetService required
	 * @attr formName required
	 */
	def securitysetting={attrs,body->
		def action=attrs.remove("action")
		def value = attrs.remove("value")
		def controller=attrs.remove("controller")
		def successAction=attrs.remove("successAction")
		def successController=attrs.remove("successController")
		def targetService=attrs.remove("targetService") 
		def formName=attrs.remove("formName")
		def displayAsPopUp=attrs.remove("displayAsPopUp")
		displayAsPopUp=displayAsPopUp?displayAsPopUp:'NO'		
		out<< render(template:"/common/security/securitysetting",model:[action:action,controller:controller,successController:successController,successAction:successAction,value:value,targetService:targetService,formName:formName,displayAsPopUp:displayAsPopUp])
	}
	
	/**
	 * @attr action required
	 * @attr controller required
	 * @attr successAction required
	 * @attr successController required
	 * @attr targetService required
	 * @attr formName required
	 */
	def securitysettingBulkPay={attrs,body->
		def action=attrs.remove("action")
		def value = attrs.remove("value")
		def controller=attrs.remove("controller")
		def successAction=attrs.remove("successAction")
		def successController=attrs.remove("successController")
		def targetService=attrs.remove("targetService")
		def formName=attrs.remove("formName")
		def displayAsPopUp=attrs.remove("displayAsPopUp")
		displayAsPopUp=displayAsPopUp?displayAsPopUp:'NO'
		out<< render(template:"templates/smeBulkPayment/securitySetting",model:[action:action,controller:controller,successController:successController,successAction:successAction,value:value,targetService:targetService,formName:formName,displayAsPopUp:displayAsPopUp])
	}
	
	
	def wfsearchFilter={attrs,body ->
		def controller = attrs.remove("controller")
		def action = attrs.remove("action")
		def update = attrs.remove("update")
		def onSuccess = attrs.remove("onSuccess");
		out << render(template:"/common/wfSearch", model:[controller:controller, action:action, update:update,onSuccess:onSuccess])
	}
/**
 * @attr tagLibParameter required
 * @attr tagLibName required
 * @attr tagLibId required
 */
	def tagLibParser={attrs, body ->
		def tagLibParameter=attrs.remove("tagLibParameter") 
		def tagLibName=attrs.remove("tagLibName")  
		def tagLibId=attrs.remove("tagLibId")		
		def outPutTagLib="<vayana:${tagLibName}"
		if(tagLibId){
			outPutTagLib+=" id=\"${tagLibId}\" name=\"${tagLibId}\"/>"
		}
		out << outPutTagLib 
		out << body()
	}	
	
	/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 */
	def radioBranchPickUp = {attrs, body ->
		def type = attrs.type
		def name = attrs.name
		def mandi = attrs.required
		def defaultvalue = attrs.checked
		if (type) {
			String domain = (attrs.domain)?attrs.domain:'base'
			List fromList = []
			if(domain.equals('tenant')){
				fromList = commonService.getTenantLookUpValuesByType(type?.toString())
			}else{
				fromList = commonService.getLookupValuesByType(type)
			}
			fromList.each {
				it.idVersion = it.id+','+it.version				
			}			
			attrs.values = fromList
			attrs.labels = fromList
			attrs.remove("domain")
			attrs.remove("type")
			attrs.remove("required")
			attrs.remove("checked")
			out << "<p>"
			fromList.each {
				out << "<label for=\"${it.id}\">${it.code}</label>"
				if(it?.code.equals("NO")){
					out << "<input type='radio' name=\"${name}\" id=\"${it.id}\" value=\"${it.code}\" data-nullable=\"${mandi}\" checked=\"checked\" onclick=\"${remoteFunction(controller:'serviceRequest',action:'getBranchPickUp',update:'dynamicBranchContent',params:'\'collectionType=\'+\'NO\'+\'&branchMetaDataId=\'+getBranchMetaData()',onSuccess:'pickUpSuccess(data,textStatus)',onFailure:'pickUpFailure(XMLHttpRequest.responseText)')}\" />"
				}else{
					out << "<input type='radio' name=\"${name}\" id=\"${it.id}\" value=\"${it.code}\" data-nullable=\"${mandi}\" onclick=\"${remoteFunction(controller:'serviceRequest',action:'getBranchPickUp',update:'dynamicBranchContent',params:'\'collectionType=\'+\'YES\'+\'&branchMetaDataId=\'+getBranchMetaData()',onSuccess:'pickUpSuccess(data,textStatus)',onFailure:'pickUpFailure(XMLHttpRequest.responseText)')}\" />"
				}
			}
			out << "</p>"
		}
	}

	/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 */
	def radioChequeRange = {attrs, body ->
		def type = attrs.type
		def name = attrs.name
		def mandi = attrs.required
		def defaultvalue = attrs.checked
		if (type) {
			String domain = (attrs.domain)?attrs.domain:'base'
			List fromList = []
			if(domain.equals('tenant')){
				fromList = commonService.getTenantLookUpValuesByType(type?.toString())
			}else{
				fromList = commonService.getLookupValuesByType(type)
			}
			fromList.each {
				it.idVersion = it.id+','+it.version
			}
			attrs.values = fromList
			attrs.labels = fromList
			attrs.remove("domain")
			attrs.remove("type")
			attrs.remove("required")
			attrs.remove("checked")
			out << "<p>"
			fromList.each {
				out << "<label for=\"${it.id}\">${it.code}</label>"
				if(it?.code.equals("NO")){
					out << "<input type='radio' name=\"${name}\" id=\"${it.id}\" value=\"${it.code}\" data-nullable=\"${mandi}\" checked=\"checked\" onclick=\"showChequeNoDiv()\" />"
				}else{
					out << "<input type='radio' name=\"${name}\" id=\"${it.id}\" value=\"${it.code}\" data-nullable=\"${mandi}\" onclick=\"showChequeRangeDiv()\" />"
				}
			}
			out << "</p>"
		}
	}
	/**
	 * @author elanchezhiyan
	 */
	def radioGroupWithOnClick = { attrs,body ->
		def type = attrs.type
		def name = attrs.name
		def mandi = attrs.required
		def defaultvalue = attrs.checked
		def onClickRequired = (attrs.onClickRequired) ? attrs.onClickRequired : 'NO'
		if (type) {
			String domain = (attrs.domain)?attrs.domain:'base'
			List fromList = []
			if(domain.equals('tenant')){
				fromList = commonService.getTenantLookUpValuesByType(type?.toString())
			}else{
				fromList = commonService.getLookupValuesByType(type)
			}
			fromList.each {
				it.idVersion = it.id+','+it.version
			}
			attrs.values = fromList
			attrs.labels = fromList
			attrs.remove("domain")
			attrs.remove("type")
			attrs.remove("required")
			attrs.remove("checked")
			out << "<p>"
			fromList.each {
				out << "<label for=\"${it.id}\">${it.code}</label>"
				if(it?.code.equals("NO")){
					if("YES".equalsIgnoreCase(onClickRequired)) {
						out << "<input type='radio' name=\"${name}\" id=\"${it.id}\" value=\"${it.code}\" data-nullable=\"${mandi}\" checked=\"checked\" onclick=\"onClickNo()\" />"
					} else {
						out << "<input type='radio' name=\"${name}\" id=\"${it.id}\" value=\"${it.code}\" data-nullable=\"${mandi}\" checked=\"checked\" />"
					}
				}else{
					if("YES".equalsIgnoreCase(onClickRequired)) {
						out << "<input type='radio' name=\"${name}\" id=\"${it.id}\" value=\"${it.code}\" data-nullable=\"${mandi}\" onclick=\"onClickYes()\" />"
					} else {
						out << "<input type='radio' name=\"${name}\" id=\"${it.id}\" value=\"${it.code}\" data-nullable=\"${mandi}\"  />"
					}
				}
			}
			out << "</p>"
		}
	}

	/**
	 * @attr genericSRModel required
	 */
	def innerMetaData={attrs,body->
		def genericSRModel=attrs.genericSRModel
		out << render(template:"/common/innermetadata",model:[genericSRModel:genericSRModel])
	}
	
	/**
	 * @attr name required
	 * @attr id required
	 * @attr type required
	 */
	def tenantLookupSelect = {attrs, body ->
		def type = attrs.type
		if (type) {
			String domain = (attrs.domain)?attrs.domain:'base'
			String optkey = 	(attrs.optionKey)?attrs.optionKey:'idVersion'         
			List fromList = []  
			fromList = commonService.getTenantLookUpValuesByType(type?.toString()) 
			 def messagePrefix = attrs.remove("messagePrefix");   
			fromList.each { it.idVersion = it.id+','+it.version;}    
			attrs.from = fromList  
			attrs.optionKey = optkey
			attrs.optionValue=attrs.optionValue?attrs.optionValue:'code'
			attrs.remove("domain")
			attrs.valueMessagePrefix = messagePrefix
			attrs.remove("type")
			//attrs.noSelection=['':'Select']
			out << g.select(attrs)
		}
	}
	

	
	/**
	 * @attr billerInstructionId required
	 */
	def formatBPAccount={attrs,body ->
		def billerInsId=attrs.remove('beneInstructionId')
		def billerInstruction = commonService.getBPAccount(billerInsId)
		def billerNumber	=	commonService.getBillerNumber(billerInsId)
		out << "<p>${billerInstruction?.biller.shortName}-${billerInstruction?.shortName}</p>"
		//out << "<p>${billerNumber?.dataVarcharValue}</p>"
	}
	
	/**
	 * 	@attr name required
	 *   @attr value required
	 *  */
	 def serviceValidate={attrs,body ->
		 def name=attrs.remove("name")
		 def buttonEvent=attrs.remove("buttonEvent")
		 def value=attrs.remove("value")		 
		 def classStyle=attrs.remove("class")
		 def controller=attrs.remove("controller")
		 def action =attrs.remove("action")		 
		 def secondaryDiv=attrs.remove('secondaryDiv')
		 def formName=attrs.remove("formName")
		 def displayAsPopUp=attrs.remove("displayAsPopUp")
		 displayAsPopUp=displayAsPopUp?displayAsPopUp:'NO'
		 out << render(template:"/common/serviceValidate", model:[name:name,value:value,classStyle:classStyle,controller:controller,action:action,secondaryDiv:secondaryDiv,formName:formName,displayAsPopUp:displayAsPopUp,buttonEvent:buttonEvent] )
	 }
	 def deleteFunction = {attrs, body ->
		 attrs.onSuccess = "${attrs.onSuccess};${remoteFunction(action:'messages', controller:'generic', update:'messagesDiv')}"
		 out << g.remoteFunction(attrs)
	 }
	 
	 def captcha = {attrs,body ->
		 GrailsWebRequest webRequest = WebUtils.retrieveGrailsWebRequest()
		 if(grailsApplication.config.simpleCaptcha != null && grailsApplication.config.simpleCaptcha){
			 def session = webRequest.session
			 // remove the CAPTCHA so a new one will be generated next time one is requested
			 session.removeAttribute("captcha")
			 session.removeAttribute("captchaImage")
		 }
		 def writer = getOut()
		 StringBuffer sb = new StringBuffer();
		 
		 sb << """ <img src="${createLink(controller: 'simpleCaptcha', action: 'captcha')}"/>
		 <label for="captcha">Type the letters above in the box below:</label>
		 <input type="text" name="captcha" required="required"/>    
		 <input type="hidden" name="hidcaptchaflag" value="true" />	
		 """
		 writer << sb.toString()
	 }
	 /**
	  * @author elanchezhiyan
	  * @attr name required
	  * @attr paramsHolderName required
	  * @attr isRequired required
	  */
	 def userLoginAutoCompleter={attrs,body ->
		 def name = attrs.remove("name")
		 def paramsHolderName = attrs.remove("paramsHolderName")
		 def required = attrs.remove("isRequired");
		 out << render(template:"/common/userLoginAutoCompleter", model:[name:name, paramsHolderName:paramsHolderName,isRequired:required?.toUpperCase()])
	 }
	 /**
	  * Renders the body if the specified expression (a String; the 'expression' attribute)
	  * evaluates to <code>true</code> or if the specified URL is allowed.
	  *
	  * @attr expression the expression to evaluate
	  * @attr url the URL to check
	  * @attr method the method of the URL, defaults to 'GET'
	  */
	 def fap = { attrs, body ->
		 if (hasAccess(attrs)) {
			 out << body()
		 }
	 }
	 
	protected boolean hasAccess(attrs)
	{
        boolean access = false;
		if (!SecurityUtils.isAuthenticated()) {
			access =  false;
		}
		String functionValue = attrs.remove('function')
		access = SecurityUtils.validateFap(functionValue);
		return access;
	}
	
	/**
	 * @author elanchezhiyan
	 * @attr moduleLabel 
	 * @attr subModuleLabel 
	 * @attr businessFunctionLabel 
	 * @attr userActionLabel 
	 */
	def generateFap={attrs, body ->
		def moduleLabel = attrs.remove("moduleLabel")
		def subModuleLabel = attrs.remove("subModuleLabel")
		def businessFunctionLabel = attrs.remove("businessFunctionLabel")
		def userActionLabel = attrs.remove("userActionLabel")
		String fapTree = "";
		if(StringUtils.hasText(subModuleLabel)){
			def value = SubModuleConstants.getAt(subModuleLabel)
			fapTree = (StringUtils.hasText(fapTree)) ? fapTree+":"+value : value
		}
		if(StringUtils.hasText(businessFunctionLabel)){
			def value = BusinessFunctionConstants.getAt(businessFunctionLabel)
			fapTree = (StringUtils.hasText(fapTree)) ? fapTree+":"+value : value
		}
		if(StringUtils.hasText(userActionLabel)){
			def value = UserActionConstants.getAt(userActionLabel)
			fapTree = (StringUtils.hasText(fapTree)) ? fapTree+":"+value : value
		}
		out<<fapTree
	}
	
	
	/**
	* 	@attr ulpId required
	*/
   def secretQuestions = {attrs, body ->
	   def ulpId = attrs.remove("ulpId");
	   List<QuestionBasketDetail> questionBasketDetails = null;
	   if (ulpId){
		   questionBasketDetails = commonService.getSecretQuestionForUser(ulpId);     
		   
	   }else{
		   throwTagError("Tag [secretQuestions] is missing required attribute [ulpId]");
	   }
	   out << render(template:"/common/secretQuestions", model:[questionBaskets:questionBasketDetails]);  
   }
   /**
    * This is only for Pending Transaction module
    * @attr beneInsIdVer required
    */
   def formatFFAccountNumber={attrs,body->
	   def beneInsIdVer = attrs.remove('beneInsIdVer')
	   def displayCurrency = attrs.remove('displayCurrency')
	   displayCurrency = (displayCurrency != null && displayCurrency !='') ? displayCurrency : "NO"
	   def beneInstruction = (beneInsIdVer != null && beneInsIdVer != "") ? commonService.getFFAccount(beneInsIdVer) : null;
	   def acctNum = "${beneInstruction?.accountNumber}";
	   def currencyCode = "${beneInstruction?.currency?.code}";
	   if(BusinessFunctionConstants.CREDIT_CARD_TRANS.equals(beneInstruction?.transactionSubType?.serviceApplication?.service?.code)){
		   if('YES'.equalsIgnoreCase(displayCurrency)){
			   out << commonService.maskCreditCardNumber(acctNum)+"("+currencyCode+")"
		   }else{
		   	   out << commonService.maskCreditCardNumber(acctNum)
		   }
		   
	   }else{
		   if('YES'.equalsIgnoreCase(displayCurrency)){
			   out << acctNum+"("+currencyCode+")"
		   }else{
			  out << acctNum
		   }
	   }
   }
   /**
	* This is only for Pending Transaction module
	* @attr billInsIdVer required
	*/
   def formatBPAccountNumber={attrs,body->
	   def billInsIdVer = attrs.remove('billInsIdVer')
	   def billerInstruction = (billInsIdVer != null && billInsIdVer != "") ? commonService.getBPAccount(billInsIdVer) : null;
	   out << "${billerInstruction?.account?.accountNumber}"
   }
   /**
    * @attr creditCardNumber required
    */
   def maskCCNumber={attrs,body->
	   def ccNum = attrs.remove('creditCardNumber')
	   if (!StringUtils.hasText(ccNum)){
		   throwTagError("Tag [maskCCNumber] is missing required attribute [creditCardNumber]")
	   }
	   out << commonService.maskCreditCardNumber(ccNum)
   }
   
   def sequenceNumber = {attrs, body ->
	   List fromList = []
	   int seqSize = attrs.remove("seqsize");
	   for (int i = 1; i <= seqSize; i++) 
	   {
		   fromList.add(String.valueOf(i));
	   }
	   attrs.remove("seqsize")
	   attrs.from = fromList
	   out << g.select(attrs)
   }
   
   /**
	* @author elanchezhiyan
	* @attr poptype required
	*
	* poptype possible values
	* CASA-Current and Saving Account
	* CC-Credit Cards
	* PC-Prepaid Cards
	* BOTH-both CASA and CC
	*/
   def ownAccountBeneInsSelect = { attrs, body ->
	   def name 		= attrs.remove('name')
	   def visible 	= attrs.remove('visible')
	   def popType 	= (attrs.poptype)?attrs.poptype:'CASA'
	   def from 		= commonService.getOwnAcountBeneIns(popType)
	   def id 			= attrs.remove('id')
	   id 				= id?id:name
	   def groupBy 	= "category"
	   def optionKey 	= "idVersion"
	   def optionValue = "accountNumber"
	   def target 		= attrs.target
	   Set optGroupSet = new TreeSet()
	   if(!name) {
		   throwTagError("Tag [fromAccount] is missing required attribute [name]")
	   }
	   //Make that sure the object we're working with, has groupBy, optionKey, and optionValue properties that actually
	   //exist
	   //def link = g.createLink(action:action,controller:controller,params:urlParams)
	   if(from.size() > 0) {
		   /*if(!from[0].properties[groupBy]) {
			throw new MissingPropertyException("No such property: ${groupBy} for class: ${from[0].class.name}")
			}*/
		   if(!from[0].properties[optionKey]) {
			   throw new MissingPropertyException("No such property: ${optionKey} for class: ${from[0].class.name}")
		   } else if(!from[0].properties[optionValue]) {
			   throw new MissingPropertyException("No such property: ${optionValue} for class: ${from[0].class.name}")
		   }
		   if(from[0].properties[groupBy]) {
			   from.each {
				   optGroupSet.add(it.properties[groupBy])
			   }
		   }
		   if(("false").equals(visible)) {
			   String hiddenValue = from[0].properties[optionKey];
			   println "VayanaTagLib	:   HiddenValue >> "+hiddenValue;
			   out << "<input type='hidden' id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" value =\"${hiddenValue}\" />"
			   return;
		   }
		   out << "<select id =\"${id}\" name=\"${name}\" data-encrypt=\"yes\" "
		   attrs.each {key, value ->
			   out << "${key}=\"${value.encodeAsHTML()}\" "
		   }
		   out << ">"
		   if(from[0].properties[groupBy]) {
			   for(optGroup in optGroupSet) {
				   out << " <optgroup label=\"${optGroup.encodeAsHTML()}\">\n"
				   for(option in from) {
					   if(option.properties[groupBy].equals(optGroup)) {
						   String optkey = option.properties[optionKey]
						   String accountShortName=option.shortName
						   String curerncy=option.currency.code
						   String accountNumber=option.accountNumber+"("+curerncy+")"
						   String formattedAccountNumber = option.accountNumber + "|" + curerncy + "|" + option.accountType?.description
						   //String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
						   out << "  <option value=\"${optkey}\" data-msg=\"${accountShortName}\">${formattedAccountNumber}</option>\n"
					   }
				   }
				   out << " </optgroup>\n"
			   }
		   } else {
			   for(option in from) {
				   String optkey = option.properties[optionKey]
				   //String encOptkey = SecurityUtils.encrypt(optkey, session.invoker.secretKey)
				   out << "  <option value=\"${optkey}\">${option.properties[optionValue]} </option>\n"
			   }
		   }
		   out << "</select>\n"
	   } else {
		   out << "<select id =\"${id}\" name=\"${name}\" required=\"required\" data-errormessage=\"Please select an account\" data-encrypt=\"yes\" >"
		   out << "</select>\n"
	   }
   }
   
   /**
    * @required accountNumber
    */
   def accountShortName = {attrs,body ->
	   
	   def actNum = attrs.remove('accountNumber')
	   def shrtName = commonService.fetchAccountByAccountNumber(actNum)
	   out << shrtName
	   
   }
   
   /*
	* To get the rejection reason for EntityId 
	*/
   def getRejectionReason = {attrs, body->
	   String entityId = attrs.entityId ? attrs.entityId : null
	   String createdBy = attrs.createdBy ? attrs.createdBy : null
	   if (!attrs.containsKey('entityId')) {
		   throwTagError("Tag [entityId] is missing required attribute [entityId]")
	   }
	   
	   def rejectionReason 		=	commonService.getRejectionReasonForEntityId(entityId,createdBy);
	   if(rejectionReason != "" && rejectionReason != null){
			out << rejectionReason
	   }else{
	   		out << "-"
	   }
   }
   
   /*
	* To get the dateline task initiator User Info
	*/
   def getDatelineTaskInitiator = {attrs, body->
	   def taskCreatedBy = attrs.taskCreatedBy ? attrs.taskCreatedBy : null
	   if (!attrs.containsKey('taskCreatedBy')) {
		   throwTagError("Tag [getDatelineTaskInitiator] is missing required attribute [taskCreatedBy]")
	   }
	   if(taskCreatedBy != "" && taskCreatedBy != null){
		   def userInfo 	= 	IBUserProfileDetailsByULP(taskCreatedBy.toLong());
		   out << userInfo?.userLogin
	   }
   }
   
   def IBUserProfileDetailsByULP(Long ulpId){
	   return commonService.getUserLoginProfileDetails(ulpId.toLong());
   }
   
   def depositTypes = {attrs, body->
		   String optkey = 	(attrs.optionKey)?attrs.optionKey:'idVersion'
		   String optVal = 	(attrs.optionValue)?attrs.optionValue:'idVersion'
		   List fromList = []
		   fromList = commonService.fetchDepositTypes();
		   fromList.each { it.idVersion = it.id+','+it.version;}
		   attrs.from = fromList
		   attrs.optionKey = optkey
		   attrs.optionValue= optVal
		   out << g.select(attrs)
   }
}