<g:set var="beneficiaryInstruction" value="${beneInsRespone?.beneficiaryInstruction}" />
 <g:hiddenField name="payeeBankBranchId" id="payeeBankBranchId" value="${beneficiaryInstruction?.payeeBankBranch?.idVersion}" />
 <input type="hidden" name="tstCode" id="tstCode" value="${beneInsRespone?.getBeneInstructionTemplate()}"/>		
<table width="100%">
<tr>
<td width="50%">
<div class="fields">
<h4><g:message	code="beneficiary.templates.instructions.accountDetails.label" /></h4>
<br />		
		<p>
		<label for="shortName"><g:message code="beneficiary.templates.instructions.nefttemplate.benenickname.label" /></label>
		<g:textField name="shortName" id="shortName" value="${beneficiaryInstruction?.shortName}" required="required" pattern="[a-zA-Z0-9 ]+"
			title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.benenickname.tooltip.text')}" maxlength="25"	
			data-errormessage="${g.message(code:"beneficiary.templates.instructions.nefttemplate.benenickname.error.message")}" />
		</p>
		</div>
		<div class="fields">
			<p>
				<label for="accountTypeId"><g:message code="beneficiary.templates.instructions.nefttemplate.beneaccounttype.label" /></label>
				<vayana:lookupSelect name="accountTypeId" id="accountTypeId" value="${beneficiaryInstruction?.accountType?.idVersion}"	required="required" type="ACCOUNTYPE" 
				required="required" data-errormessage="${g.message(code:"beneficiary.templates.instructions.nefttemplate.beneaccounttype.error.message")}" />
				
			</p>
		</div>
		<g:hiddenField name="overrideType" value="acct" />
		<div class="fields">
			<p>
				<label for="accountNumber"><g:message	code="beneficiary.templates.instructions.nefttemplate.accountnumber.label" /></label>
				<g:passwordField name="accountNumber" id="accountNumber" value="${beneficiaryInstruction?.accountNumber}" required="required" 
					title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.accountnumber.tooltip.text')}" 	maxlength="25"
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.nefttemplate.accountnumber.label.error.message")}" pattern="[a-zA-Z0-9]+"
				/>
			</p>
		</div>
		
		<div class="fields">
			<p>
				<label for="accountNumberConfirm"><g:message	code="beneficiary.templates.instructions.nefttemplate.confirmaccountno.label" /></label>
				<g:textField name="accountNumberConfirm" id="accountNumberConfirm" value="${beneficiaryInstruction?.accountNumber}" required="required"
					title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.confirmaccountno.label.tooltip.text')}"	maxlength="25"
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.nefttemplate.confirmaccountno.label.error.message")}" pattern="[a-zA-Z0-9]+"/>
			</p>
		</div>
		
		<div class="fields">
			<p>
				<label for="currencyId"><g:message	code="beneficiary.templates.instructions.nefttemplate.accountcurrency.label" /></label>
				<vayana:tenantBaseCurrencySelect name="currencyId" id="currencyId" required="Y" value="${beneficiaryInstruction?.currency?.idVersion}" />
			</p>
		</div>
		
		
		<div class="fields">
			<p>
				<label for="bankCode"><g:message code="beneficiary.templates.instructions.nefttemplate.bankcode.label"/></label>
				 <g:textField name="bankCode" id="bankCode" value="${beneficiaryInstruction?.payeeBankBranch?.electronicClearingCode}" required="required"
					title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.bankcode.label.tooltip.text')}"	
					readonly="true" data-errormessage="${g.message(code:"beneficiary.templates.instructions.nefttemplate.bankcode.label.error.message")}" />
					&nbsp;&nbsp;		
					<g:remoteLink  controller="beneficiary" action="loadsearchBankForm" update="bankdialog" onSuccess="openBankDialog()" params="[bankType:'DOMESTIC',payType:'NEFT']">
					<g:message code="beneficiary.templates.instructions.nefttemplate.search.label"/>
					</g:remoteLink>
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="bankName"><g:message code="beneficiary.templates.instructions.nefttemplate.bankname.label"/></label>
				<g:textField name="bankName" id="bankName" value="${beneficiaryInstruction?.payeeBankBranch?.bankName}" required="required"
					title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.bankname.label.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.nefttemplate.bankname.label.error.message")}" />
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="branchName"><g:message code="beneficiary.templates.instructions.nefttemplate.branchname.label"/></label>
				<g:textField name="branchName" id="branchName" value="${beneficiaryInstruction?.payeeBankBranch?.branchName}" required="required"
					title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.branchname.label.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.nefttemplate.branchname.label.error.message")}" />
			</p>
		</div>		
		<div class="fields">
			<p>
				<label for="bankAddress"><g:message code="beneficiary.templates.instructions.nefttemplate.branchaddress.label"/></label>
				<g:textField name="bankAddress" id="bankAddress" value="${beneficiaryInstruction?.payeeBankBranch?.address1}"
					title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.bankAddress.label.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.nefttemplate.bankAddress.label.error.message")}" />
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
		
				
	<div id="bankdialog" title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.addcode.tooltip.text')}" style="display:none;" class="body-scroll">
    
	</div>
	<div id="termsAndConditionsDialog" title="${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.ceebox.text')}" style="display:none;" class="body-scroll">    
</div>
<script>
function openBankDialog()
{
	$( "#bankdialog" ).dialog( "open" );
}
       
		// Start of Bank Code Search
		// modal dialog init: custom buttons and a "close" callback reseting the form inside
        var bankdialog = $( "#bankdialog" ).dialog({
            autoOpen: false,
            modal: true,
            resizable: false,
			width: 'auto',
          //  buttons: {
              //  Add: function() {
              //      addBankInfo();
                  
                 //   $( this ).dialog( "close" );
               // },
               // Cancel: function() {
              //      $( this ).dialog( "close" );
              //  }
           // },
            close: function() {
                //form[ 0 ].reset();
            	$( this ).dialog( "close" );
            }
        });
 
        // addBankInfo form: calls addBankInfo function on submit and closes the dialog
        var form = bankdialog.find( "#getBankInfo" ).submit(function( event ) {
            addBankInfo();
            bankdialog.dialog( "close" );
            event.preventDefault();
        });
 
        // actual addBankInfo function: adds new tab using the input from the form above
         function addBankInfo() {
			
			var bankcode = $('.loadBankValue:checked').data('bankcode');
			var bankname = $('.loadBankValue:checked').data('bankname');
			var branchname = $('.loadBankValue:checked').data('branchname');
			var bankaddress = $('.loadBankValue:checked').data('bankaddress');
			var bankidversion = $('.loadBankValue:checked').data('bankidversion');
			
			//alert("bankidversion:::"+bankidversion);
			
			$("#bankCode").val(bankcode);
			$("#bankName").val(bankname);
			$("#branchName").val(branchname);      
			$("#bankAddress").val(bankaddress);
			$("#payeeBankBranchId").val(bankidversion);				

        }
		
		// end of add folder ***********************************/
		
		// start of search bank code results ***********************************/		
		
	$("#searchBank").click(function(){
		$(".searchResult").show();
    });
	

	
		// end of search bank code results ***********************************/
/*** Terms And Conditions Scripts Starts here ***/	        
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
/*** Terms And Conditions Scripts Ends here ***/
</script>