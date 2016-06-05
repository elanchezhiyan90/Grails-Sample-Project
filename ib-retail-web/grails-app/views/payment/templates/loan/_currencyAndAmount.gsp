<p>
	<label for="amount"><g:message code="payment.templates.loan.loanpayment.currencyamount.label" /></label>
	<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
					required="Y" class="cur" currencies="${transferCurrency}"
					data-errormessage="${g.message(code:'payment.templates.loan.loanpayment.currencyamount.error.message') }" />
	
	<input type="number" step="any" name="paymentAmount" maxlength="16"
		id="paymentAmount" class="s_amt" min="1" required="required"
		data-errormessage="${g.message(code:"payment.templates.loan.loanpayment.amount.error.message") }" />
</p>