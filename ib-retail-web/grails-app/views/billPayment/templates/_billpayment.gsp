
<%-- Form Starts here --%>

<%@page import="com.vayana.bm.core.api.model.enums.CommonEntityEnum"%>
<g:set var="favouritePaymentDetail" value="${favPaymentDetailModel?.favouritePaymentDetail}" />	
<g:set var="acctBalancePaymentDetail" value="${favPaymentDetailModel?.acctBalancePaymentDetail}" />
<g:hiddenField name="buttonEvent"/>
<div class="f-panel" id="ftpanel">
	<%--                 <g:set var="beneInstruction" value = "${beneficiary.beneficiaryInstruction}"/>--%>

	<h2>
		${message(code:'billpayment.template.billpayment.h2.text') }
		${favPaymentDetailModel?.getBeneficiaryShortName()}
		<g:if test="${favouritePaymentDetail != null }">		
		<span id="favpayment"><input type="checkbox" name="checkbox${favouritePaymentDetail?.id}" id="checkbox${favouritePaymentDetail?.id}" 
		onclick="setFavourite(${favouritePaymentDetail?.id},${params.beneId},${favouritePaymentDetail?.payerInstruction?.id});${remoteFunction(controller:'billPayment',update:'f-panel',action:'pastpaymentfavourite',params:'\'paymentId=\'+getFavourite()+\'&beneId=\'+getBeneId()+\'&payeeId=\'+getPayeeId()+\'&favouriteId=\'+getFavouriteId()' ,onSuccess: 'onFavSuccess(data,textStatus);') } "
		value="dd"
		checked="checked"/></span>
		
		</g:if>
	</h2>
		
	<g:form name="transferForm" controller="billPayment">
	<g:if test="${datelineRef}">
		<g:hiddenField name="datelineReferenceId" value="${datelineRef}" />
	</g:if>
	
	<g:hiddenField name="paymentScheduleDetailId" value="${acctBalancePaymentDetail?.id}" />
	<g:hiddenField name="paymentScheduleHeaderId" value="${acctBalancePaymentDetail?.paymentScheduleHeader?.id}" />
	<g:hiddenField name="favouriteAccountCurrency" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentCurrency?.id}"/>
	<g:hiddenField name="configuredPaymentDate" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentDate?.format("dd-MMM-yyyy")}" />
	<g:hiddenField name="otpTransactionId" />	
	
	<g:if test="${isQuickPay}">
		<g:hiddenField name="quickpayFlag" value="${isQuickPay}" />
	</g:if>
		
		<div class="fields">
			<p>
				<label for="from_account"><g:message code="billpayment.template.billpayment.fromaccount.label" /></label>

				<vayana:fromAccountSelect id="fromAccountId" name="fromAccountId"
					type="FF" poptype="CASACC" 
					noSelection="${['Select Payer Account':'Select Payer Account']}"
					onchange=" ${remoteFunction( 
					 						    	controller :'billPayment',
													update:'balance',
											   		action:'fromaccountbalanceandexgrate', 	
													before:'if(checkFromAccount()){return false;}',													  						
					 								params:'\'payerId=\'+payerVal()+\'&payeeId=\'+billerInstructionVal()' 
												    ,onSuccess: 'onPayerIdSuccess(data,textStatus);'													   										  		
					 					   			)}"
					required="required" data-errormessage="${g.message(code:"billpayment.template.billpayment.account.error.message") }" />
				<br> <span class="selected_des" id="fromAccSelect"><g:message code="billpayment.template.billpayment.account.selection.message" />&nbsp;</span>
			</p>

			<div class="updater" id="balance"></div>
		</div>
		
		<div class="fields">
			<p>
				<label for="to_account"> <g:message code="billpayment.template.billpayment.toaccount.label" /></label>
				<vayana:toBPAccountSelect name="toAccountId" id="toAccountId"
					type="BP"
					noSelection="${['Select Payer Account':'Select Payee Account']}"
					required="required"
					onchange="getService();getExchangeRateAndLimit();cancelSI()"
					data-errormessage="${g.message(code:"billpayment.template.billpayment.nickname.error.message") }" />					
				<br> <span class="selected_des" id="toAccSelect"><g:message code="payment.templates.friendsandfamily.transfer.account.selection.message" />&nbsp;</span>
			</p>			
			<div class="updater" id="exchangeRateAndLimit" name="exchangeRateAndLimit">	</div>			
		</div>		
		
		<div class="fields" id="updateBillInquiry" style="display: none;">
		
		</div>	
					
					
		<div class="fields">
			<p>
				<label for="amount">${message(code:'billpayment.templates.billpayment.currency&amount.label')}</label>
					
				<vayana:tenantOpsCurrencySelect name="billCurrencyId" id="billCurrencyId" 
					required="required" class="cur" currencies="${[baseCurrencyModel]}"  
					data-errormessage="${g.message(code:"payment.templates.ownaccount.transfer.currencyamount.error.message") }" />					
				
				<span id="amount">						
					<input type="number" step="any" name="paymentAmount" maxlength="16"
					id="paymentAmount" class="s_amt" min="1"
					data-errormessage="${message(code:'billpayment.templates.billpayment.amount.error.message')}" value="" />
									
				</span>		
						
				</p>
		</div>

		<div class="fields">
			<p>
				<label for="rmrk">${message(code:'billpayment.templates.billpayment.remarks.label')}</label> <input type="text"
					name="paymentRemarks" id="paymentRemarks" value="${favPaymentModel?.paymentDetail?.remarks}"
					placeholder="${message(code:'billpayment.templates.billpayment.remarks.placeholder.text')}" />
			</p>
		</div>
		
		<div class="buttons" id="btns_paynow">
		 <%--<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'BILL_PAYMENT_TRANS',userActionLabel:'ADD')}" >	
			--%>
		<g:if test="${datelineEventRef.equals(null)}">
			<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"
				value="${g.message(code:"payment.templates.ownaccount.transfer.paynow.button.text") }"
				enableButton="btns_now" controller="billPayment"
				action="validatefundtransfer" secondaryAction="paymentPostProcess"
				secondaryController="billPayment" secondaryDiv="f-panel" />		
			<g:if test="${!isQuickPay.equals(true)}">		
			<g:submitToRemote action="payLaterPreConfirm" controller="billPayment"
				name="prePayLater" id="prePayLater" 
				update="dynamicContent"
				value="${g.message(code:"payment.templates.ownaccount.transfer.paylater.button.text") }"
				onSuccess="onPreTransSuccess(data,textStatus)" 
				onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
				before="if (checkFormValidity()) {return false;};"
				class="btn_next"/>
			<g:if test="${datelineRef.equals(null)}">
			<g:submitToRemote action="repeatPreConfirm" controller="billPayment"
				name="preRepeat" id="preRepeat" 
				update="dynamicContent"
				value="${g.message(code:"payment.templates.ownaccount.transfer.repeat.button.text") }"
				onSuccess="onPreTransSuccess(data,textStatus)" 
				onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
				before="if (checkFormValidity()) {return false;};"
				class="btn_next"/>
			</g:if>
			<%--<g:if test="${SICancelFlag.equals('SI')}">		
				<vayana:ftValidate name="cancel" buttonEvent="CANCELPAYMENT"
				value="Cancel Payment"
				enableButton="btns_cancelpayment" controller="billPayment"
				action="validatefundtransfer" secondaryAction="paymentPostProcess"
				secondaryController="billPayment" secondaryDiv="f-panel" class="btn_next" />			
			</g:if>
			--%>
			</g:if>
			</g:if>
			<g:if test="${datelineEventRef.equals('SI')}">	
				<g:render template="/billPayment/templates/utilityStandingInstructionButtons"/>
			</g:if>
			<%--</vayana:fap>						
		--%></div>
		<div class="flds-block" id="dynamicContent">		
		</div>
		
		
		</g:form>
	
</div>
<script>
function payerVal()                            
{
	var txt = $("#fromAccountId").val(); 	
	return txt; 
 }

function billerInstructionVal()                            
{ 

	var payeeId= $("#toAccountId").val();
	payeeId=payeeId.split(',')		
	payeeId=payeeId[0];
	return payeeId;
}

function getService(){

var billerins = billerInstructionVal();
	if(billerins != null && billerins != ""){
		<g:remoteFunction controller="billPayment" action="billerServiceType" params="\'&payeeId=\'+billerInstructionVal()" update="amount" onSuccess=""/>
	}
	
}

function getExchangeRateAndLimit(){
var payerins = payerVal();
	if(payerins != null && payerins != ""){
		<g:remoteFunction controller="billPayment" action="exchangeRateAndLimit" params="\'payerId=\'+payerVal()+\'&payeeId=\'+billerInstructionVal()" update="exchangeRateAndLimit" onSuccess="onPayeeIdSuccess(data,textStatus)"/>
	}
}


function cancelSI(){
	$(".flds-block").fadeOut(function(){$(this).empty();$("#prePayLater").removeClass("btn_show").addClass("btn_next");});
	$("#payNow").removeClass("btn_next");
	$("#preRepeat,#payNow").removeAttr('disabled');
	
	$(".flds-block").fadeOut(function(){$(this).empty();$("#preRepeat").removeClass("btn_show").addClass("btn_next");});
	$("#payNow").removeClass("btn_next");
	$("#prePayLater,#payNow").removeAttr('disabled');
	
}

function unlockForm(){	
	$("form").find("input, select ").removeAttr("disabled");
}

function onBillInquirySuccess(data,textStatus)
{	
	var billamount = $("#billamountdue").val(); 	
	$("#paymentAmount").dynamicfieldupdate();
	$("#paymentAmount").attr("value",billamount)
}

function onBillInquiryFailure(responseText)
{
	 $("#messagesDiv").empty();
	 $("#messagesDiv").append(responseText);
}
</script>
