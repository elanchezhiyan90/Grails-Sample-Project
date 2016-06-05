
<!-- Form Starts here -->

<%@page import="com.vayana.bm.core.api.model.enums.CommonEntityEnum"%>

<g:set var="favouritePaymentDetail" value="${favPaymentDetailModel?.favouritePaymentDetail}" />	
<g:set var="acctBalancePaymentDetail" value="${favPaymentDetailModel?.acctBalancePaymentDetail}" />
<g:hiddenField name="minimumDueAmount" value="${cardDetailsModel?.creditCardAccount?.minimumAmountDue}" />
<g:hiddenField name="fullDueAmount" value="${cardDetailsModel?.creditCardAccount?.outStandingAmount}" />
<g:hiddenField name="beneInstructionId" id="beneInstructionId"
	value="${favPaymentDetailModel?.acctBalancePaymentDetail?.payeeInstruction?.id}" />
<g:hiddenField name="buttonEvent"/>
<div class="f-panel" id="ftpanel">
	<h2>
		<g:message code="payment.templates.creditcard.creditcardpayment.h2.text" />
		${favPaymentDetailModel?.getBeneficiaryShortName()}
		<g:if test="${favouritePaymentDetail != null }">
		<span id="favpayment"><%--<input type="checkbox" name="checkbox${favouritePaymentDetail?.id}" id="checkbox${favouritePaymentDetail?.id}" 
		onclick="setFavourite(${favouritePaymentDetail?.id},${favouritePaymentDetail?.payeeInstruction?.id},${favouritePaymentDetail?.payerInstruction?.id});${remoteFunction(controller:'payment',update:'f-panel',action:'ownpastpaymentfavourite',params:'\'paymentId=\'+getFavourite()+\'&payInsId=\'+getPayInsId()+\'&payeeId=\'+getPayeeId()+\'&favouriteId=\'+getFavouriteId()' ,onSuccess: 'onFavSuccess(data,textStatus);') } "
		value="dd"
		checked="checked"/>
		--%><g:hiddenField name="paymentFavouriteId" id="paymentFavouriteId" value="${favPaymentDetailModel?.paymentFavourite?.id}"/>
			<g:hiddenField name="paymentFavBeneId" id="paymentFavBeneId" value="${('OA'.equals(favPaymentDetailModel?.paymentFavourite?.favouriteType)) ? favPaymentDetailModel?.paymentFavourite?.payeeInstruction?.id : null}"/>
			<input type="checkbox" name="paymentFavouriteCheckBox"
			id="paymentFavouriteCheckBox" class="fpanelStar"
			onclick="${remoteFunction(controller:'payment',action:'discardPaymentFavourite',params:'\'paymentFavouriteId=\'+getPaymentFavouriteId()+\'&paymentFavBeneId=\'+getPaymentFavBeneId()', after:'removeFavouriteStar()' ,onSuccess: 'onDiscardFavSuccess(data,textStatus);') } "
			checked="checked" />
		</span>
		</g:if>
	</h2>

	<g:form name="transferForm" controller="payment">
		<g:if test="${datelineRef}">
		<g:hiddenField name="datelineReferenceId" value="${datelineRef}" />
		</g:if>		
		<g:hiddenField name="paymentScheduleDetailId" value="${acctBalancePaymentDetail?.id}" />
		<g:hiddenField name="paymentScheduleHeaderId" value="${acctBalancePaymentDetail?.paymentScheduleHeader?.id}" />
		<g:hiddenField name="favouriteAccountCurrency" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentCurrency?.id}"/>
		<g:hiddenField name="configuredPaymentDate" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentDate?.format("dd-MMM-yyyy")}" />
		<g:hiddenField name="confStartDate" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequencyStartDate?.format('dd-MMM-yyyy')}"/>
		<g:hiddenField name="confEndDate" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequencyEndDate?.format('dd-MMM-yyyy')}"/>
		<g:hiddenField name="confFrequency" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency?.code}"/>
		<g:hiddenField name="eventRef" value="${datelineEventRef}"/>
		<%--<div class="mandi-note">
			<span class="mandi"></span>
			<p><g:message code="payment.templates.creditcard.creditcardpayment.mandatory.fields.label" /></p>
		</div>
		--%><div class="fields">
			<p>
				<label for="from_account"><g:message code="payment.templates.creditcard.creditcardpayment.fromaccount.label" /></label>
				<vayana:fromAccountSelect id="fromAccountId" name="fromAccountId"
					type="OA" poptype="CASA" 
					noSelection="${['Select Payer Account':'Select Payer Account']}"
					onchange=" ${remoteFunction( 
					 						    	controller :'payment',
													update:'exchangeRateAndLimit',
											   		action:'ownaccountbalanceandexgrate', 	
													before:'if(checkFromAccount()){return false;}',														  						
					 								params:'\'payerId=\'+payerVal()+\'&payeeId=\'+payeeVal()' ,
													onSuccess: 'onPayerIdSuccess(data,textStatus);'											  		
					 					   			)}"
					required="required" data-errormessage="${g.message(code:"payment.templates.creditcard.creditcardpayment.youraccount.error.message") }" />
				<br> <span class="selected_des"><g:message code="payment.templates.creditcard.creditcardpayment.youraccount.selection.message" />&nbsp;</span>

			</p>
					
       <div class="updater" id="exchangeRateAndLimit" name="exchangeRateAndLimit">			
			</div>	
		</div>

		
			<vayana:toAccountSelect name="toAccountId" id="toAccountId"
			type="OA" poptype="CC" visible="false"
			noSelection="${['Select Payer Account':'Select Payer Account']}"
			required="required" data-errormessage="${g.message(code:"payment.templates.creditcard.creditcardpayment.toaccount.error.message") }" />
	
		<div class="fields">
			<p>
  				<label for="amount_type"><g:message code="payment.templates.creditcard.creditcardpayment.amounttype.label" /></label>
				<vayana:iblookupSelect name="amount_type" id="amount_type" optionKey="code" type="CC_AMOUNT_TYPE" domain = "base" onchange="setAmount(this)" required="required" data-errormessage="${g.message(code:"payment.templates.creditcard.creditcardpayment.amounttype.error.message") }" />
			</p>						
		</div>

		<div class="fields" id="currency">
			<p>
				<label for="amount"><g:message code="payment.templates.creditcard.creditcardpayment.currencyamount.label" /></label>

                   <vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
					required="required" class="cur"
					data-errormessage="${g.message(code:"payment.templates.creditcard.creditcardpayment.currencyamount.error.message") }" />

				<input type="number" step="any" name="paymentAmount"
					id="paymentAmount" class="s_amt" min="1" required="required" maxlength="16"
					data-errormessage="${g.message(code:"payment.templates.creditcard.creditcardpayment.amount.error.message") }" />
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="rmrk"><g:message code="payment.templates.creditcard.creditcardpayment.remarks.label" /></label> <input type="text"
					name="paymentRemarks" id="paymentRemarks" value="${favPaymentModel?.paymentDetail?.remarks}"
					placeholder="${g.message(code:"payment.templates.creditcard.creditcardpayment.remarks.placeholder.text") }" />
			</p>

		</div>
		
	<div class="buttons" id="btns_paynow">
		<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'OWN_CREDIT_CARD_PAYMENT',userActionLabel:'ADD')}" >
		<g:if test="${datelineEventRef.equals(null)}">	
			<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"
				value="${g.message(code:"payment.templates.ownaccount.transfer.paynow.button.text") }"
				enableButton="btns_now" controller="payment"
				action="validatefundtransfer" secondaryAction="paymentPostProcess"
				secondaryController="payment" secondaryDiv="f-panel" />			
			<g:submitToRemote action="payLaterPreConfirm" controller="payment"
				name="prePayLater" id="prePayLater" 
				update="dynamicContent"
				value="${g.message(code:"payment.templates.ownaccount.transfer.paylater.button.text") }"
				onSuccess="onPreTransSuccess(data,textStatus)" 
				onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
				before="if (checkFormValidity()) {return false;};"
				class="btn_next"/>
			
			<g:submitToRemote action="repeatPreConfirm" controller="payment"
				name="preRepeat" id="preRepeat" 
				update="dynamicContent"
				value="${g.message(code:"payment.templates.ownaccount.transfer.repeat.button.text") }"
				onSuccess="onPreTransSuccess(data,textStatus)" 
				onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
				before="if (checkFormValidity()) {return false;};"
				class="btn_next"/>
			</g:if>
			<g:if test="${datelineEventRef.equals('SI')}">		
				<g:render template="/payment/templates/common/standingInstructionButtons"/>			
			</g:if>	
			</vayana:fap>		
		</div>
		<div class="flds-block" id="dynamicContent">		
		</div>
	</g:form>
	<!--Form Ends here -->
</div>



