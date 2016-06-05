<!-- Form Starts here -->
<%@page import="com.vayana.bm.core.api.model.enums.CommonEntityEnum"%>
<div class="f-panel">
<g:set var="favouritePaymentDetail" value="${favPaymentDetailModel?.favouritePaymentDetail}" />	
<g:set var="acctBalancePaymentDetail" value="${favPaymentDetailModel?.acctBalancePaymentDetail}" />
<g:hiddenField name="buttonEvent"/>
<div class="f-panel" id="ftpanel">
<h2>
		<g:message code="payment.templates.creditcard.creditcardpayment.h2.text" />
		${params.payeeNickName} 
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
	
		<g:hiddenField name="datelineReferenceId" value="${datelineRef}" />
		<g:hiddenField name="paymentScheduleDetailId" value="${acctBalancePaymentDetail?.id}" />
		<g:hiddenField name="paymentScheduleHeaderId" value="${acctBalancePaymentDetail?.paymentScheduleHeader?.id}" />
		<g:hiddenField name="favouriteAccountCurrency" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentCurrency?.id}" />
		<%--<div class="mandi-note">
			<span class="mandi"></span>
			<p><g:message code="payment.templates.creditcard.creditcardpayment.mandatory.fields.label" /></p>
		</div>
		
		--%><div class="fields">
				<p>
					<label for="from_account"><g:message code="payment.templates.prepaidcard.prepaidcardpayment.fromaccount.label" /></label>
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
						required="required"
						data-errormessage="${g.message(code:"payment.templates.prepaidcard.prepaidcardpayment.youraccount.error.message") }" />
					<br> 
						<span class="selected_des">
							<g:message code="payment.templates.prepaidcard.prepaidcardpayment.youraccount.selection.message" />&nbsp;
						</span>
				</p>
				<div class="updater" id="exchangeRateAndLimit" name="exchangeRateAndLimit">	</div>
		</div>
		<div class="fields">
				<p>
					<label for="from_account"><g:message code="payment.templates.prepaidcard.prepaidcardpayment.account.label" /></label>
					<vayana:toAccountSelect name="toAccountId" id="toAccountId"
						type="OA" poptype="DA" visible="true"
						noSelection="${['Select Payer Account':'Select Payer Account']}"
						required="required"
						data-errormessage="${g.message(code:"payment.templates.prepaidcard.prepaidcardpayment.toaccount.error.message") }" />
					<br> 
					<span class="selected_des">
						<g:message code="payment.templates.prepaidcard.prepaidcardpayment.account.selection.message" />&nbsp;
					</span>
				</p>
		</div>
		<div class="fields" id="currency">
				<p>
					<label for="amount"><g:message code="payment.templates.prepaidcard.prepaidcardpayment.currencyamount.label" /></label>
					<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId" type="code"
						class="cur"	 required="required"
						data-errormessage="${g.message(code:"payment.templates.prepaidcard.prepaidcardpayment.currencyamount.error.message") }" />

					<input type="number" step="any" name="paymentAmount"
						id="paymentAmount" class="s_amt" min="1" required="required" maxlength="16"
						data-errormessage="${g.message(code:"payment.templates.prepaidcard.prepaidcardpayment.amount.error.message") }" />
				</p>
		</div>		
		<div class="fields">
				<p>
					<label for="rmrk"><g:message code="payment.templates.prepaidcard.prepaidcardpayment.remarks.label" /></label>
					<input type="text" name="paymentRemarks" id="paymentRemarks"
						value="${favPaymentModel?.paymentDetail?.remarks}"
						placeholder="${g.message(code:"payment.templates.prepaidcard.prepaidcardpayment.remarks.placeholder.text") }" />
				</p>
		</div>
		<div class="buttons" id="btns_paynow">
				<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"
					value="${g.message(code:"payment.templates.prepaidcard.prepaidcardpayment.paynow.button.text") }"
					enableButton="btns_now" controller="payment"
					action="validatefundtransfer" secondaryAction="paymentPostProcess"
					secondaryController="payment" secondaryDiv="f-panel" />
				<g:submitToRemote action="payLaterPreConfirm" controller="payment"
					name="prePayLater" id="prePayLater" update="dynamicContent"
					value="${g.message(code:"payment.templates.prepaidcard.prepaidcardpayment.paylater.button.text") }"
					onSuccess="onPreTransSuccess(data,textStatus)"
					onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
					before="if (checkFormValidity()) {return false;};" class="btn_next" />
				<g:if test="${datelineRef.equals(null)}">
					<g:submitToRemote action="repeatPreConfirm" controller="payment"
						name="preRepeat" id="preRepeat" update="dynamicContent"
						value="${g.message(code:"payment.templates.prepaidcard.prepaidcardpayment.repeat.button.text") }"
						onSuccess="onPreTransSuccess(data,textStatus)"
						onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
						before="if (checkFormValidity()) {return false;};"
						class="btn_next" />
				</g:if>
				<g:if test="${SICancelFlag.equals('Y')}">
					<g:submitToRemote controller="payment" name="cancel"
						action="cancelSITransaction" id="cancel"
						update="otp_cancelpay_div" value="Cancel" class="btn_next"></g:submitToRemote>
				</g:if>
			</div>
			<div class="flds-block" id="dynamicContent"></div>	
	</g:form>
</div>
</div>