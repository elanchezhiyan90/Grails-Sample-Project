<div class="fields">
<p>
	<label for="beneficiaryName"><g:message	code="beneficiary.quickpay.beneName" /></label>
	<g:textField name="beneficiaryName" id="beneficiaryName" value="${beneficiaryInstruction?.shortName}" required="required"
			title="${g.message(code:'beneficiary.quickpay.beneName')}"	
			data-errormessage="${g.message(code:"beneficiary.quickpay.benename.error.message")}" />
</p>
</div>
<g:hiddenField name="currencyId" value="${beneficiaryInstruction?.currency?.idVersion}"  />
<%-- 
<div class="fields">		
<p>
	<label for="currencyId"><g:message	code="beneficiary.templates.instructions.ifttemplate.accountcurrency.label" /></label>
	<g:textField name="currencycode" id="currencycode" value="${beneficiaryInstruction?.currency?.code}" required="required" readonly="true"/>
	<g:hiddenField value="${beneficiaryInstruction?.currency?.idVersion}" name="currencyIdVersion" />
</p>
</div>
--%>