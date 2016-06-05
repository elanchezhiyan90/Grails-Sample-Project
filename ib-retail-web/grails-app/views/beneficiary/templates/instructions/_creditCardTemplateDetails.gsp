 <div class="fields">
	<p>
		<label for="shortName"><g:message code="beneficiary.templates.instructions.ifttemplate.benenickname.label" /></label>
		<g:textField name="shortName" id="shortName" value="${beneficiaryInstruction?.shortName}" required="required" class="shortname"
			title="${g.message(code:'beneficiary.templates.instructions.ifttemplate.benenickname.tooltip.text')}"	
			data-errormessage="${g.message(code:"beneficiary.templates.instructions.ifttemplate.benenickname.error.message")}" />
	</p>
</div>

<div class="fields">
	<p>
		<label for="currencyId"><g:message	code="beneficiary.templates.instructions.nefttemplate.creditcardcurrency.label" /></label>
		<g:textField name="currencycode" id="currencycode" value="${beneficiaryInstruction?.currency?.code}" required="required" readonly="true"/>
		<g:hiddenField value="${beneficiaryInstruction?.currency?.idVersion}" name="currencyId" />
	</p>
</div>