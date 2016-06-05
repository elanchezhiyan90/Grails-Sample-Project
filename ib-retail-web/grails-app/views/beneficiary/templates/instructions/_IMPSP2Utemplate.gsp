<g:set var="beneficiaryInstruction" value="${beneInsRespone?.beneficiaryInstruction}" />
<input type="hidden" name="tstCode" id="tstCode" value="${beneInsRespone?.getBeneInstructionTemplate()}"/>
<table width="100%">
<tr>
<td width="50%">
<div class="fields">
<h4><g:message	code="beneficiary.templates.instructions.impsp2utemplate.label" /></h4>
<br />
		<p>
		<label for="shortName"><g:message code="beneficiary.templates.instructions.impsp2utemplate.benenickname.label" /></label>
		<g:textField name="shortName" id="shortName" value="${beneficiaryInstruction?.shortName}" required="required"  
			title="${g.message(code:'beneficiary.templates.instructions.impsp2utemplate.benenickname.tooltip.text')}"	
			data-errormessage="${g.message(code:"beneficiary.templates.instructions.impsp2utemplate.benenickname.error.message")}" />
		</p>
		</div>
		
		<g:hiddenField name="overrideType" value="iban" />
		<div class="fields">
			<p>
				<label for="mobileNumber"><g:message code="beneficiary.templates.instructions.impsp2utemplate.mobilenumber.label" /></label>
				<input type="text" name="mobileNumber" id="mobileNumber" value="${beneficiaryInstruction?.mobileNumber}" required="required"
						pattern="^[0-9]*$" maxlength="10" onkeypress="return isNumber(event)"
						title="${g.message(code:'beneficiary.templates.instructions.impsp2utemplate.mobilenumber.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.impsp2utemplate.mobilenumber.label.error.message")}"/>
				
			</p>
		</div>	
		
		
		<div class="fields">
			<p>
				<label for="aadharCardNumber"><g:message code="beneficiary.templates.instructions.impsp2utemplate.aadharcardnumber.label" /></label>
				<input type="text" name="aadharCardNumber" id="aadharCardNumber" value="${beneficiaryInstruction?.aadharCardNumber}" required="required"
						 maxlength="12" onkeypress="return isNumber(event)"
						title="${g.message(code:'beneficiary.templates.instructions.impsp2utemplate.aadharcardnumber.label.tooltip.text')}"
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.impsp2utemplate.aadharcardnumber.label.error.message")}"/>
				
			</p>
		</div>		

</td>

<g:if test="${grailsApplication.config.beneficiary.limit.display == true}" >
<td width="50%">

		<g:render template="templates/instructions/beneficiaryInstructionLimit"></g:render>
</td>
</g:if>

</tr>
</table>		
<script type="text/javascript">

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

</script>	
	
