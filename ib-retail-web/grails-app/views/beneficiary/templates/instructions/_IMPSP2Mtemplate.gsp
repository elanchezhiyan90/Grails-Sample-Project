<g:set var="beneficiaryInstruction" value="${beneInsRespone?.beneficiaryInstruction}" />
 <g:hiddenField name="payeeBankBranchId" id="payeeBankBranchId" />	
 <input type="hidden" name="tstCode" id="tstCode" value="${beneInsRespone?.getBeneInstructionTemplate()}"/>
<table width="100%">
<tr>
<td width="50%">
<div class="fields">
<h4><g:message	code="beneficiary.templates.instructions.impsp2m.label" /></h4>
<br />		
		
		
		
		
		<div class="fields">
			<p>
				<label for="shortName"><g:message	code="beneficiary.templates.instructions.impsp2p.benenickname.label" /></label>
				<g:textField name="shortName" id="shortName" value="${beneficiaryInstruction?.shortName}" required="required"
					title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.confirmaccountno.label.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.impsp2p.benenickname.error.message")}" pattern="[a-zA-Z0-9]+"/>
			</p>
		</div>
		
	
			<g:hiddenField name="overrideType" value="iban" />
	<div class="fields">
			<p>
				<label for="iban"><g:message code="beneficiary.templates.instructions.impsp2p.mmid.label"/></label>
				<input type="text" name="iban" id="iban" value="${beneficiaryInstruction?.iban}" required="required"
						 maxlength="7" onkeypress="return isNumber(event)"
						title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.bankname.label.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.impsp2p.mmid.error.message")}"  />
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="mobileNumber"><g:message code="beneficiary.templates.instructions.impsp2p.mobilenumber.label"/></label>
				<input type="text" name="mobileNumber" id="mobileNumber" value="${beneficiaryInstruction?.mobileNumber}" required="required"
						pattern="^[0-9]*$" maxlength="10" onkeypress="return isNumber(event)"
						title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.branchname.label.tooltip.text')}"
						data-errormessage="${g.message(code:"beneficiary.templates.instructions.impsp2p.mobilenumber.error.message")}" />				
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
		
				

	

        
         