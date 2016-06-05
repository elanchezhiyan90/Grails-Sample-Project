 <g:hiddenField name="payeeBankBranchId" id="payeeBankBranchId" />
<input type="hidden" name="tstCode" id="tstCode" value="${beneInsRespone?.getBeneInstructionTemplate()}"/>
		<div class="fields">
			<p>
				<label for="bene_label"><g:message code="beneficiary.templates.instructions.ifttemplate.benenickname.label"/></label> 
				<input type="text" name="shortName" id="shortName" value="${beneficiaryInstruction?.shortName}" required />
			</p>
		</div>
		<g:hiddenField name="overrideType" value="acct" />
		<div class="fields">
			<p>
				<label for="bene_label"><g:message code="beneficiary.templates.instructions.ifttemplate.accountnumber.label"/></label>
				 <input type="text" name="accountNumber" id="accountNumber" title="${g.message(code:'beneficiary.templates.instructions.ifttemplate.accountnumber.tooltip.text')}"
					value="${beneficiaryInstruction?.accountNumber}" required />
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="bene_label"><g:message code="beneficiary.templates.instructions.ifttemplate.confirmaccountno.label"/></label> <input
					type="text" name="coniban" id="coniban" title="${g.message(code:'beneficiary.templates.instructions.ifttemplate.accountnumber.tooltip.text')}"
					value="${beneficiaryInstruction?.accountNumber}" required />
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="bene_label"><g:message code="beneficiary.templates.instructions.ifttemplate.accountcurrency.label"/></label>
					<vayana:currencySelect name="currencyId" id="currencyId" type="CURRENCIES" findBy="ALL" />
    		</p>
		</div>	
		<div class="fields">
			<p>
				<label for="bene_label"><g:message code="beneficiary.templates.instructions.ifttemplate.beneaccounttype.label"/></label>
				 <vayana:lookupSelect name="accountTypeId" id="accountTypeId"
				  value="${beneficiaryInstruction?.accountType?.idVersion}"
				  type="ACCOUNTYPE"/>
			</p>		
		</div>
		
		<div class="fields">
			<p>
				<label for="bene_label"><g:message code="beneficiary.templates.instructions.nefttemplate.bankcode.label"/></label>
				 <input type="text" name="bankCode" id="bankCode"  required />
			</p>
			<div class="fieldnote">
					<p><g:remoteLink  controller="beneficiary" action="loadsearchBankForm" update="bankdialog" onSuccess="openBankDialog()" params="[bankType:'DOMESTIC']"><g:message code="beneficiary.templates.instructions.nefttemplate.search.label"/></g:remoteLink></p>
			</div>
		</div>

		<div class="fields">
			<p>
				<label for="bene_label"><g:message code="beneficiary.templates.instructions.nefttemplate.bankname.label"/></label>
				<input type="text" name="bankName" id="bankName"  required />
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="bene_label"><g:message code="beneficiary.templates.instructions.nefttemplate.branchname.label"/></label>
				<input type="text" name="branchName" id="branchName"  required />
			</p>
		</div>		
		<div class="fields">
			<p>
				<label for="bene_label"><g:message code="beneficiary.templates.instructions.nefttemplate.branchaddress.label"/></label>
				<input type="text" name="bankAddr" id="bankAddr" required />
			</p>
		</div>		

		<g:render template="templates/instructions/beneficiaryInstructionLimit"></g:render>	
		
	
	<div id="bankdialog" title="${g.message(code:'beneficiary.templates.instructions.ifttemplate.addcode.tooltip.text')}" style="display:none;">
    
</div>
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
			//alert('Address '+$(".searchResult .bankAddress").val());
			//alert('IdVersion '+$(".searchResult .payeeBankBranchId").val());			
			var bankcode = $(".searchResult").find('.bankCode').text();
			var bankname = $(".searchResult").find('.bankName').text();
			var bankbranch = $(".searchResult").find('.branchName').text();
			var bankAddress = $(".searchResult .bankAddress").val();	
			var bankIdVersion   = $(".searchResult .payeeBankBranchId").val();
			//alert("Bank Code : " + bankcode + "Bank Name : " + bankname + "Branch Name : " + bankbranch );
			$("#bankCode").val(bankcode);
			$("#bankName").val(bankname);
			$("#branchName").val(bankbranch);
			$("#bankAddress").val(bankAddress);
			$("#payeeBankBranchId").val(bankIdVersion);
			//alert($("#payeeBankBranchId").val());							
		
        }
		
		// end of add folder ***********************************/
		
		// start of search bank code results ***********************************/		
		
	$("#searchBank").click(function(){
		$(".searchResult").show();
    });
	
	$(".loadBankValue").click(function(){
		var bankcode = $(".searchResult").find('.bankCode').text();
		var bankname = $(".searchResult").find('.bankName').text();
		var bankbranch = $(".searchResult").find('.branchName').text();
		var bankaddr = $(".searchResult").find('.bankAddr').text();					
		//alert("Bank Code : " + bankcode + "Bank Name : " + bankname + "Branch Name : " + bankbranch );
    });	
	
		// end of search bank code results ***********************************/
	        

            
</script>