<g:set var="beneficiaryInstruction" value="${beneInsRespone?.beneficiaryInstruction}" />
 		<g:hiddenField name="payeeBankBranchId" id="payeeBankBranchId" value="${beneficiaryInstruction?.payeeBankBranch?.idVersion}"/>
 	<input type="hidden" name="tstCode" id="tstCode" value="${beneInsRespone?.getBeneInstructionTemplate()}"/>		
<table width="100%">
<tr>
<td width="50%">
<div class="fields">
<h4><g:message	code="beneficiary.templates.instructions.impsp2atemplate.label" /></h4>
<br />
<%--<g:hiddenField name="impsCode" value="IMPS_BY_IFSC"/>--%>
		<p>
		<label for="shortName"><g:message code="beneficiary.templates.instructions.impsp2atemplate.benenickname.label" /></label>
		<g:textField name="shortName" id="shortName" value="${beneficiaryInstruction?.shortName}" required="required"
			title="${g.message(code:'beneficiary.templates.instructions.impsp2atemplate.benenickname.tooltip.text')}"	
			data-errormessage="${g.message(code:"beneficiary.templates.instructions.impsp2atemplate.benenickname.error.message")}" />
		</p>
		</div>
		
		
		<div class="fields">
			<p>
				<label for="accountNumber"><g:message code="beneficiary.templates.instructions.impsp2atemplate.accountnumber.label" /></label>
				<g:passwordField name="accountNumber" id="accountNumber" value="${beneficiaryInstruction?.accountNumber}" required="required" 
					title="${g.message(code:'beneficiary.templates.instructions.impsp2atemplate.accountnumber.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.impsp2atemplate.accountnumber.label.error.message")}"
					pattern="[a-zA-Z0-9]+"	/>
			</p>
		</div>
		
		<div class="fields">
			<p>
				<label for="accountNumberConfirm"><g:message code="beneficiary.templates.instructions.impsp2atemplate.confirmaccountno.label" /></label>
				<g:textField name="accountNumberConfirm" id="accountNumberConfirm" value="${beneficiaryInstruction?.accountNumber}" required="required"
					title="${g.message(code:'beneficiary.templates.instructions.impsp2atemplate.confirmaccountno.label.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.impsp2atemplate.confirmaccountno.label.error.message")}" pattern="[a-zA-Z0-9]+"/>
			</p>
		</div>
		
		<g:hiddenField name="overrideType" value="acct" />

		<div class="fields">
			<p>
				<label for="bankCode"><g:message code="beneficiary.templates.instructions.impsp2atemplate.bankcode.label"/></label>
				 <g:textField name="bankCode" id="bankCode" value="${beneficiaryInstruction?.payeeBankBranch?.electronicClearingCode}" required="required"
					title="${g.message(code:'beneficiary.templates.instructions.impsp2atemplate.bankcode.label.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.impsp2atemplate.bankcode.label.error.message")}" />
					&nbsp;&nbsp;		
					<g:remoteLink  controller="beneficiary" action="loadsearchBankForm" update="bankdialog" onSuccess="openBankDialog()" params="[bankType:'ALL']">
					<g:message code="beneficiary.templates.instructions.impsp2atemplate.search.label"/>
					</g:remoteLink>
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
	
	<div id="bankdialog" title="${g.message(code:'beneficiary.templates.instructions.impsp2atemplate.addcode.tooltip.text')}" style="display:none;"></div>
	
	
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
<%--			var bankname = $('.loadBankValue:checked').data('bankname');--%>
<%--			var branchname = $('.loadBankValue:checked').data('branchname');--%>
<%--			var bankaddress = $('.loadBankValue:checked').data('bankaddress');--%>
			var bankidversion = $('.loadBankValue:checked').data('bankidversion');
			
<%--			alert("bankidversion:::"+bankidversion);    --%>
			
			$("#bankCode").val(bankcode);
<%--			$("#bankName").val(bankname);--%>
<%--			$("#branchName").val(branchname);      --%>
<%--			$("#bankAddress").val(bankaddress);--%>
			$("#payeeBankBranchId").val(bankidversion);	
						

        }
		
		// end of add folder ***********************************/
		
		// start of search bank code results ***********************************/		
		
	$("#searchBank").click(function(){
		$(".searchResult").show();
    });
	

	
		// end of search bank code results ***********************************/
	        

            
</script>