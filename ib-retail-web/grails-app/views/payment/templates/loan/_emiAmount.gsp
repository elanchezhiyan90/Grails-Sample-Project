<%--<div id="emiAmt">--%>
<p>
	<label for="amount"><g:message code="payment.templates.loan.loanpayment.currencyamount.label" /></label>
	<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
					required="Y" class="cur" currencies="${installmentCur}"
					data-errormessage="${g.message(code:'payment.templates.loan.loanpayment.currencyamount.error.message') }" />
	<input type="number" step="any" name="paymentAmount"
					id="paymentAmount" class="s_amt" min="1" required="required" value="${installmentAmt}" readonly="readonly"
					data-errormessage="${g.message(code:'payment.templates.loan.loanpayment.amount.error.message') }" />
</p>
<%--</div>--%>