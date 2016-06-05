<g:set var="beneficiaryInstruction" value="${beneInsRespone?.beneficiaryInstruction}" />
<input type="hidden" name="tstCode" id="tstCode" value="${beneInsRespone?.getBeneInstructionTemplate()}"/>
<table width="100%">
<tr>
<td width="50%">
<div class="fields">
<h4><g:message	code="beneficiary.templates.instructions.accountDetails.label" /></h4>
<br />
<p>
		<label for="accountNumber"><g:message	code="beneficiary.templates.instructions.ifttemplate.accountnumber.label" /></label>
		<g:passwordField name="accountNumber" id="accountNumber" value="${beneficiaryInstruction?.accountNumber}" required="required" maxlength="25"
			title="${g.message(code:'beneficiary.templates.instructions.ifttemplate.accountnumber.tooltip.text')}"	
			data-errormessage="${g.message(code:"beneficiary.templates.instructions.ifttemplate.accountnumber.label.error.message")}" pattern="[a-zA-Z0-9]+"
		/>
	</p>
</div>
<g:hiddenField name="overrideType" value="acct" />
<div class="fields">
	<p>
		<label for="accountNumberConfirm"><g:message	code="beneficiary.templates.instructions.ifttemplate.confirmaccountno.label" /></label>
		<g:textField name="accountNumberConfirm" id="accountNumberConfirm" value="${beneficiaryInstruction?.accountNumber}" required="required" maxlength="25"
			title="${g.message(code:'beneficiary.templates.instructions.ifttemplate.confirmaccountno.label.tooltip.text')}"	
			data-errormessage="${g.message(code:"beneficiary.templates.instructions.ifttemplate.confirmaccountno.label.error.message")}" pattern="[a-zA-Z0-9]+" 
			onblur=" ${remoteFunction( 
				 	  controller :'beneficiary',
			                  update:[failure:'popupMessagesDiv',success:'accountDetailsDiv'],
					  action:'getValidAccount',																																 														  						
				 	  params:'\'accountId=\'+getAccountNo()' ,onSuccess: 'onValidateAccount(data,textStatus);',onFailure:'onFailureAccount(textStatus)'											  		
				 	  )}"/>
	</p>
</div>

<div id="accountDetailsDiv">
	<g:render template="templates/instructions/TPTtemplateDetails"></g:render>
</div>

<div class="fields">
	<p>
		<label for="bankName"><g:message	code="beneficiary.templates.instructions.ifttemplate.bankName.label" /></label>
		<g:textField name="bankName" id="bankName" value="${g.message(code:'beneficiary.templates.instructions.ifttemplate.bankName.pmcb')}" readOnly="true"/>
		
	</p>
</div>	
<div class="fields">
			<p>
				<label><input type="checkbox" name="terms" id="terms"
							required="required"
							data-errormessage="You have to agree the terms and conditions to proceed" />
							I agree the <g:remoteLink  controller="beneficiary" action="showTermsAndConditions" update="termsAndConditionsDialog" onSuccess="openTermsAndConditionsDialog()">
										${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.text')}
										</g:remoteLink>
				</label>
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


<div id="termsAndConditionsDialog" title="${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.ceebox.text')}" style="display:none;" class="body-scroll">    
</div>


<script>
function openTermsAndConditionsDialog()
{
	$( "#termsAndConditionsDialog" ).dialog( "open" );
}
var termsAndConditionsDialog = $( "#termsAndConditionsDialog" ).dialog({
            autoOpen: false,
            modal: true,
            resizable: false,
			 width:700,
            close: function() {
            	$( this ).dialog( "close" );
            }
 });
function getAccountNo(){
	return $("#accountNumberConfirm" ).val();
}
    
function onValidateAccount()
{
	$("#accountDetailsDiv").dynamicfieldupdate();
}  

function onFailureAccount(textStatus){
	$("#currencycode").val(""); 
	$(".shortname").val(""); 
}
</script>