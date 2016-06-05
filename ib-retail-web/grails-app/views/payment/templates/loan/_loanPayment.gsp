<!-- Form Starts here -->

<%@page import="com.vayana.bm.core.api.model.enums.CommonEntityEnum"%>
<g:set var="favouritePaymentDetail" value="${favPaymentDetailModel?.favouritePaymentDetail}" />	
<g:set var="acctBalancePaymentDetail" value="${favPaymentDetailModel?.acctBalancePaymentDetail}" />
<g:hiddenField name="buttonEvent" />
<div class="f-panel" id="ftpanel">
	<h2>
		<g:message code="payment.templates.loan.loanpayment.h2.text" />
		${params.payeeNickName} 
		<g:if test="${favouritePaymentDetail != null }">
		<span id="favpayment">
		<%-- <input type="checkbox" name="checkbox${favouritePaymentDetail?.id}" id="checkbox${favouritePaymentDetail?.id}" 
		onclick="setFavourite(${favouritePaymentDetail?.id},${favouritePaymentDetail?.payeeInstruction?.id},${favouritePaymentDetail?.payerInstruction?.id});${remoteFunction(controller:'payment',update:'f-panel',action:'ownpastpaymentfavourite',params:'\'paymentId=\'+getFavourite()+\'&payInsId=\'+getPayInsId()+\'&payeeId=\'+getPayeeId()+\'&favouriteId=\'+getFavouriteId()' ,onSuccess: 'onFavSuccess(data,textStatus);') } "
		value="dd"
		checked="checked"/>--%>
			<g:hiddenField name="paymentFavouriteId" id="paymentFavouriteId" value="${favPaymentDetailModel?.paymentFavourite?.id}"/>
			<g:hiddenField name="paymentFavBeneId" id="paymentFavBeneId" value="${('OA'.equals(favPaymentDetailModel?.paymentFavourite?.favouriteType)) ? favPaymentDetailModel?.paymentFavourite?.payeeInstruction?.id : null}"/>
			<input type="checkbox" name="paymentFavouriteCheckBox"
			id="paymentFavouriteCheckBox" class="fpanelStar"
			onclick="${remoteFunction(controller:'payment',action:'discardPaymentFavourite',params:'\'paymentFavouriteId=\'+getPaymentFavouriteId()+\'&paymentFavBeneId=\'+getPaymentFavBeneId()', after:'removeFavouriteStar()' ,onSuccess: 'onDiscardFavSuccess(data,textStatus);') } "
			checked="checked" />
		</span>
		</g:if>
	</h2>

	<g:form name="transferForm" controller="payment">
	<g:if test="${datelineEventRef.equals('SI')}">	
<%--		<g:hiddenField name="datelineReferenceId" value="${datelineRef}" />--%>
		<g:hiddenField name="paymentScheduleDetailId" value="${acctBalancePaymentDetail?.id}" />
		<g:hiddenField name="paymentScheduleHeaderId" value="${acctBalancePaymentDetail?.paymentScheduleHeader?.id}" />
	</g:if>
		<g:hiddenField name="favouriteAccountCurrency" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentCurrency?.id}" />
		<g:hiddenField name="toAccountId" value="${favPaymentDetailModel?.toAccountBeneInstruction?.idVersion}"/>
		<g:hiddenField name="toAccountIdVersion" value="${favPaymentDetailModel?.toAccountBeneInstruction?.account?.idVersion}"/>
		<g:hiddenField name="eventRef" value="${datelineEventRef}"/>
		<%--<div class="mandi-note">
			<span class="mandi"></span>
			<p><g:message code="payment.templates.loan.loanpayment.mandatory.fields.label" /></p>
		</div>
		--%><div class="fields">
			<p>
				<label for="from_account"><g:message code="payment.templates.loan.loanpayment.fromaccount.label" /></label>
				<vayana:fromAccountSelect id="fromAccountId" name="fromAccountId"
					type="OA" poptype="CASA"
					noSelection="${['Select Payer Account':'Select Payer Account']}"
					onchange=" ${remoteFunction( 
					 						    	controller :'payment',
													update:'exchangeRateAndLimit',
											   		action:'fromaccountbalanceandexgrate', 
													before:'if(checkFromAccount()){return false;}',															  						
					 								params:'\'payerId=\'+payerVal()' ,onSuccess: 'onLoanPayerIdSuccess(data,textStatus);'											  		
					 					   			)}"
					required="required" data-errormessage="${g.message(code:"payment.templates.loan.loanpayment.youraccount.error.message") }" />
				<br> <span class="selected_des"><g:message code="payment.templates.loan.loanpayment.youraccount.selection.message" />&nbsp;</span>

			</p>
			<div class="updater" id="balance">	</div>			
		</div>
		<div class="fields">
			<p>
  				<label for="amount_type"><g:message code="payment.templates.loan.loanpayment.amounttype.label" /></label>
				<vayana:loanAmtType id="loanPayAmtType" name="loanPayAmtType" required="required" optionKey="code" data-errormessage="Please choose the Amount Type"/>
			</p>						
		</div>
		<div class="fields" id="currency">
			<g:render template="/payment/templates/loan/currencyAndAmount"/>
		</div>

		<div class="fields" id="autoPay">
		</div>
		<div class="fields">
			<p>
				<label for="rmrk"><g:message code="payment.templates.loan.loanpayment.remarks.label" /></label> <input type="text"
					name="paymentRemarks" id="paymentRemarks" value="${favPaymentModel?.paymentDetail?.remarks}"
					placeholder="${g.message(code:"payment.templates.loan.loanpayment.remarks.placeholder.text") }" />
			</p>

		</div>
		<div class="fields">
			<p>
				<label><input type="checkbox" name="terms" id="terms"
							required="required"
							data-errormessage="You have to agree the terms and conditions to proceed" />
							I agree the <g:remoteLink controller="payment" action="termsAndConditions"
											class="ceebox" title="${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.ceebox.text')}">
											${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.text')}
										</g:remoteLink>
							
				</label>
			</p>
		</div>
		<div class="buttons" id="btns_paynow">
		<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'LOAN_PAY_TRANS',userActionLabel:'ADD')}" >	
				<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"
					value="${g.message(code:"payment.templates.prepaidcard.prepaidcardpayment.paynow.button.text") }"
					enableButton="btns_now" controller="payment"
					action="validateLoanFundTransfer" secondaryAction="paymentPostProcess"
					secondaryController="payment" secondaryDiv="f-panel" />
				<%--<g:submitToRemote action="payLaterPreConfirm" controller="payment"
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
				</g:if>--%>
				<g:if test="${SICancelFlag.equals('Y')}">
					<g:submitToRemote controller="payment" name="cancel"
						action="cancelSITransaction" id="cancel"
						update="otp_cancelpay_div" value="Cancel" class="btn_next"></g:submitToRemote>
				</g:if>
				</vayana:fap>
			</div>
			<div class="flds-block" id="dynamicContent"></div>
	</g:form>
	<!--Form Ends here -->
</div>

<g:javascript>
$("#loanPayAmtType").change(function(){
	var type = $("#loanPayAmtType :selected").val();
	if("PP" == type) {
		<g:remoteFunction action="currencyAndAmount" controller="payment" update="currency" onSuccess="onFetchingEMIAmtSuccess(data,textStatus);"/>
		<g:remoteFunction action="autoPay" controller="payment" update="autoPay" onSuccess="onAutoPaySuccess(data,textStatus);" />
	} else if("EMI" == type) {
		$("#autoPay").empty();
		<g:remoteFunction action="fetchEMIAmount" controller="payment" update="currency" params="\'toBeneIdVer=\'+getToBeneInsIdVer()" onSuccess="onFetchingEMIAmtSuccess(data,textStatus);"/>
	} else {
		<g:remoteFunction action="currencyAndAmount" controller="payment" update="currency" onSuccess="onFetchingEMIAmtSuccess(data,textStatus);"/>
		$("#autoPay").empty();
	}
});				
function onAutoPaySuccess(data,textStatus){
	$("#autoPay").dynamicfieldupdate();
}	
function onFetchingEMIAmtSuccess(data,textStatus) {
<%--	var emi = "1080"--%>
<%--	$("#paymentAmount").val(emi);--%>
<%--	$('#paymentAmount').prop('readonly',true);--%>
		$("#currency").dynamicfieldupdate();
}
function getToBeneInsIdVer(){
	var toBeneInsId = $("#toAccountIdVersion").val();
	return toBeneInsId;
}

function onLoanPayerIdSuccess(data,textStatus)
{									
    var corebal =  $(data).first().html();
    $("#balance").empty().html(corebal);
	$("#balance").dynamicfieldupdate();
}			
</g:javascript>

