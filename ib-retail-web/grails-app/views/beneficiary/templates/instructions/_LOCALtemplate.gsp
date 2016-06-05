<g:set var="beneficiaryInstruction" value="${beneInsRespone?.beneficiaryInstruction}" />
<g:if test="${beneficiaryInstruction?.payeeBankBranch instanceof com.vayana.ib.bm.core.api.model.payment.DomesticBank}">
	<g:set var="bankDetails" value="${(com.vayana.ib.bm.core.api.model.payment.DomesticBank)beneficiaryInstruction?.payeeBankBranch}" />
</g:if>
<g:elseif test="${beneficiaryInstruction?.payeeBankBranch instanceof com.vayana.ib.bm.core.api.model.payment.ForeignBank}">
	<g:set var="bankDetails" value="${(com.vayana.ib.bm.core.api.model.payment.ForeignBank)beneficiaryInstruction?.payeeBankBranch}" />
</g:elseif>
<g:hiddenField name="payeeBankBranchId" id="payeeBankBranchId" value=""/>
<input type="hidden" name="tstCode" id="tstCode" value="${beneInsRespone?.getBeneInstructionTemplate()}"/>
<%--<g:hiddenField name="payeeBankBranchId" id="payeeBankBranchId" value="${bankDetails?.idVersion}"/>--%>
<table width="100%">
<tr>
<td width="50%">
<div class="fields">
<h4>Payee Account Details</h4>
<br />
	<p>
		<label for="bene_label"><g:message code="beneficiary.templates.instructions.swifttemplate.benenickname.label" /></label>
		<g:textField name="shortName" id="shortName" value="${beneficiaryInstruction?.shortName}" required="required"
			title="${g.message(code:'beneficiary.templates.instructions.swifttemplate.benenickname.tooltip.text')}"	
			data-errormessage="${g.message(code:"beneficiary.templates.instructions.swifttemplate.benenickname.error.message")}" />
		</p>
	</p>
</div>

<%--
Commented for KHCB
<div class="fields">
	<p>
		<label for="bene_label"><g:message	code="beneficiary.templates.instructions.swifttemplate.beneaccounttype.label" /></label>
		<vayana:lookupSelect name="accountTypeId" id="accountTypeId" value="${beneficiaryInstruction?.accountType?.idVersion}"	required="required" type="ACCOUNTYPE" 
		data-errormessage="${g.message(code:"beneficiary.templates.instructions.swifttemplate.beneaccounttype.error.message")}"/>
	</p>
</div>

--%><div class="fields">
	<p>
		<label for="accountNumber"><g:message	code="beneficiary.templates.instructions.swifttemplate.accountnumber.label" /></label>
		<g:passwordField name="accountNumber" id="accountNumber" value="${beneficiaryInstruction?.accountNumber}" required="required" 
			title="${g.message(code:'beneficiary.templates.instructions.swifttemplate.accountnumber.tooltip.text')}"	
			data-errormessage="${g.message(code:"beneficiary.templates.instructions.swifttemplate.accountnumber.label.error.message")}"
		/>
	</p>
</div>
<g:hiddenField name="overrideType" value="acct" />
<div class="fields">
	<p>
		<label for="accountNumberConfirm"><g:message	code="beneficiary.templates.instructions.swifttemplate.confirmaccountno.label" /></label>
		<g:textField name="accountNumberConfirm" id="accountNumberConfirm" value="${beneficiaryInstruction?.accountNumber}" required="required"
			title="${g.message(code:'beneficiary.templates.instructions.swifttemplate.confirmaccountno.label.tooltip.text')}"	
			data-errormessage="${g.message(code:"beneficiary.templates.instructions.swifttemplate.confirmaccountno.label.error.message")}" />
	</p>
</div>

<div class="fields">
	<p>
		<label for="currencyId"><g:message	code="beneficiary.templates.instructions.swifttemplate.accountcurrency.label" /></label>
		<vayana:currencySelect name="currencyId" id="currencyId" type="CURRENCIES" findBy="SWIFT_CURR" domain="ib" value="${beneficiaryInstruction?.currency?.idVersion}" />
	</p>
</div>


<div class="fields">
			<p>
				<label for="bankCode"><g:message code="beneficiary.templates.instructions.nefttemplate.bankcode.label"/></label>
				 <g:textField name="bankCode" id="bankCode" value="${beneficiaryInstruction?.payeeBankBranch?.electronicClearingCode}" required="required"
					title="${g.message(code:'beneficiary.templates.instructions.nefttemplate.bankcode.label.tooltip.text')}"	
					readonly="true" data-errormessage="${g.message(code:"beneficiary.templates.instructions.nefttemplate.bankcode.label.error.message")}" />
					&nbsp;&nbsp;		
					<g:remoteLink  controller="beneficiary" action="loadsearchBankForm" update="bankdialog" onSuccess="openBankDialog()" params="[bankType:'ALL']">
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
</td>
<g:if test="${grailsApplication.config.beneficiary.limit.display == true}" >
<td width="50%">		
<g:render template="templates/instructions/beneficiaryInstructionLimit"></g:render>
</td>
</g:if>
</tr>
</table>

<div id="bankdialog" title="${g.message(code:'beneficiary.templates.instructions.swifttemplate.addcode.tooltip.text')}" style="display: none;"></div>
<script>

function openBankDialog()
{
$( "#bankdialog" ).dialog("open");
}	

		
		// Start of Bank Code Search - RTGS
		// modal dialog init: custom buttons and a "close" callback reseting the form inside
        var bankdialog = $( "#bankdialog" ).dialog({
            autoOpen: false,
            modal: true,
			width: 'auto',
            buttons: {
                Add: function() {
                    addBankInfo();
                    $( this ).dialog( "close" );
                },
                Cancel: function() {
                    $( this ).dialog( "close" );
               
               
                }
            },
            close: function() {
               // form[ 0 ].reset();
            	$( this ).dialog( "close" );
            },
            open:function(){
            	// addBankInfo form: calls addBankInfo function on submit and closes the dialog
        var form = $("#bankdialog").find( "#getBankInfo" ).submit(function( event ) {
            addBankInfo();
            bankdialog.dialog( "close" );
            event.preventDefault();
        });
            }
        }).dynamicfieldupdate();
 
        
 
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
	        

            
</script>