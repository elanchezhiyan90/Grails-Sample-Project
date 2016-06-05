<div class="fields">
<p>
	<label for="beneficiaryName"><g:message	code="beneficiary.quickpay.beneName" /></label>
	<g:textField name="beneficiaryName" id="beneficiaryName" value="" required="required"
			title="${g.message(code:'beneficiary.quickpay.beneName')}"	
			data-errormessage="${g.message(code:"beneficiary.quickpay.benename.error.message")}" />
</p>
</div>
<div class="fields" id="currencyElement">
<p>
	<label for="currency">Currency</label>
	<vayana:tenantOpsCurrencySelect name="currencyIdVersion"
		id="currencyIdVersion" required="Y"></vayana:tenantOpsCurrencySelect>
</p>
</div>