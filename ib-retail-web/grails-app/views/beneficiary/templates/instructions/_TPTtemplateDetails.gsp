<%--Commented Template Details as  pmcb Does not want this for now. Instead Kept it as a hidden Field --%>
<div class="fields">
	<p>
		<label for="shortName"><g:message code="beneficiary.templates.instructions.ifttemplate.benenickname.label" /></label>
		<g:textField name="shortName" id="shortName" value="${beneficiaryInstruction?.shortName?.trim()}" required="required" class="shortname"
			title="${g.message(code:'beneficiary.templates.instructions.ifttemplate.benenickname.tooltip.text')}" pattern="[a-zA-Z0-9 ]+" maxlength="25"
			data-errormessage="${g.message(code:"beneficiary.templates.instructions.ifttemplate.benenickname.error.message")}" />
	</p>
</div>
<%-- 
<div class="fields">
	<p>
		<label for="accountTypeCode"><g:message code="beneficiary.templates.instructions.ifttemplate.beneaccounttype.label" /></label>
		<vayana:lookupSelect name="accountTypeId" id="accountTypeId" value="${beneficiaryInstruction?.accountType?.idVersion}"	required="required" type="ACCOUNTYPE" 
		data-errormessage="${g.message(code:"beneficiary.templates.instructions.ifttemplate.beneaccounttype.error.message")}" />
		<g:textField name="accountTypeCode" id="accountTypeCode" value="${beneficiaryInstruction?.accountType?.description}" required="required" readonly="true"/>
		<g:hiddenField value="${beneficiaryInstruction?.accountType?.idVersion}" name="accountTypeId" />
	</p>
</div>

<div class="fields">
	<p>
		<label for="currencyId"><g:message	code="beneficiary.templates.instructions.ifttemplate.accountcurrency.label" /></label>
		<g:textField name="currencycode" id="currencycode" value="${beneficiaryInstruction?.currency?.code}" required="required" readonly="true"/>
		<g:hiddenField value="${beneficiaryInstruction?.currency?.idVersion}" name="currencyId" />
	</p>
</div>
--%>
<g:hiddenField value="${beneficiaryInstruction?.accountType?.idVersion}" name="accountTypeId" />
<g:hiddenField name="currencyId" value="${beneficiaryInstruction?.currency?.idVersion}"  />
<g:hiddenField name="payeeBankBranchId" value="${beneficiaryInstruction?.payeeBankBranch?.idVersion}" />	

