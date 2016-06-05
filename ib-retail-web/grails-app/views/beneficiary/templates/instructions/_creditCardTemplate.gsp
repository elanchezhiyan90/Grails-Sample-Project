<g:set var="beneficiaryInstruction" value="${beneInsRespone?.beneficiaryInstruction}" />
 
 <g:hiddenField name="ccbeneficiaryFlag" id="ccbeneficiaryFlag" value="true"/>		
<table width="100%">
<tr>
<td width="50%">
		
		
		<div class="fields">
			<p>
				<label for="accountNumber"><g:message	code="beneficiary.templates.instructions.creditcardnumber.label" /></label>
				<g:passwordField name="accountNumber" id="accountNumber" value="${beneficiaryInstruction?.accountNumber}" required="required" 
					title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.accountnumber.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.creditcardnumber.label.error.message")}" pattern="[a-zA-Z0-9]+"
				/>
			</p>
		</div>
		
		<div class="fields">
			<p>
				<label for="accountNumberConfirm"><g:message	code="beneficiary.templates.instructions.creditcardnumber.confirm.label" /></label>
				<g:textField name="accountNumberConfirm" id="accountNumberConfirm" value="${beneficiaryInstruction?.accountNumber}" required="required"
					title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.confirmaccountno.label.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.nefttemplate.confirmaccountno.label.error.message")}" pattern="[a-zA-Z0-9]+"
					onblur=" ${remoteFunction(controller :'beneficiary', update:[failure:'popupMessagesDiv',success:'ccDetailsDiv'],
					  action:'getValidCreditCard',																																 														  						
				 	  params:'\'creditcardNo=\'+getCreditCardNo()' ,onSuccess: 'onValidateCC(data,textStatus);',onFailure:'onFailureCC(textStatus)'											  		
				 	  )}"/>
						
			</p>
		</div>
		
		<div id="ccDetailsDiv">
			<g:render template="templates/instructions/creditCardTemplateDetails"></g:render>
		</div>
		
				
</td>
<g:if test="${grailsApplication.config.beneficiary.limit.display == true}" >
<td width="50%">
		<g:render template="templates/instructions/beneficiaryInstructionLimit"></g:render>
</td>
</g:if>
</tr>
</table>
		
<script>
	
	function getCreditCardNo(){
		return $("#accountNumber" ).val();
	}
	    
	function onValidateCC()
	{
		$("#accountDetailsDiv").dynamicfieldupdate();
	}  
	
	function onFailureCC(textStatus){
		$("#currencycode").val(""); 
		$(".shortname").val(""); 
	}
	
</script>