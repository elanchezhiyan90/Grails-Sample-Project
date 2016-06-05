
<!-- Form Starts here -->

<%@page import="com.vayana.bm.core.api.model.enums.CommonEntityEnum"%>

<g:hiddenField name="buttonEvent"/>
<div class="f-panel" id="ftpanel">
	<h2>
		<g:message code="payment.templates.creditcard.creditcardpayment.h2.text" />		
	</h2>

	<g:form name="transferForm" controller="payment">
		<g:if test="${datelineRef}">
		<g:hiddenField name="datelineReferenceId" value="${datelineRef}" />
		</g:if>		
		<g:hiddenField name="eventRef" value="${datelineEventRef}"/>
		<g:hiddenField name="transferEvent" id="transferEvent" value="CCExcessTransfer"/>
		<div class="fields">
			<p>
				<label for="from_account"><g:message code="billpayment.template.billpayment.fromaccount.label" /></label>

				<vayana:fromAccountSelect id="fromAccountId" name="fromAccountId"
					type="OA" poptype="CC"
					noSelection="${['Select Payer Account':'Select Payer Account']}"
					onchange=" ${remoteFunction( 
					 						    	controller :'payment',
													update:'balance',
											   		action:'fromaccountbalanceandexgrate', 	
													before:'if(checkFromAccount()){return false;}',													  						
					 								params:'\'payerId=\'+payerVal()+\'&payeeId=\'+payeeVal()+\'&transferEvent=\'+getTransferEvwnt()'  
												    ,onSuccess: 'onPayerIdSuccess(data,textStatus);'													   										  		
					 					   			)}"
					required="required" data-errormessage="${g.message(code:"billpayment.template.billpayment.account.error.message") }" />
				<br> <span class="selected_des" id="fromAccSelect"><g:message code="billpayment.template.billpayment.account.selection.message" />&nbsp;</span>
			</p>

			<div class="updater" id="balance"></div>
		</div>
		
		<div class="fields">
			<p>
				<label for="to_account"> <g:message code="payment.templates.ownaccount.transfer.account.label" /></label>
				<vayana:ownAccountBeneInsSelect id="toAccountId" name="toAccountId" poptype="CASA" noSelection="${['Select Payer Account':'Select Payer Account']}"
					required="required" data-errormessage="${g.message(code:'payment.templates.ownaccount.transfer.account.error.message') }" />
					<br><span class="selected_des" id="toAccSelect"><g:message code="payment.templates.ownaccount.transfer.account.selection.message" />&nbsp;</span>
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
			
			</g:if>			
			</vayana:fap>		
		</div>
		<div class="flds-block" id="dynamicContent">		
		</div>
	</g:form>
	<!--Form Ends here -->
</div>



