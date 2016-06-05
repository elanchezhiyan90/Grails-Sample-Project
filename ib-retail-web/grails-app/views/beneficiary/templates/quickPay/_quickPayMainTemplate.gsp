
<g:form name="quickPayForm" id="quickPayForm">
	<g:hiddenField name="payeeBankBranchId" id="payeeBankBranchId" value=""/>
	<div class="col-280">
		<div class="fields">
			<p>
				<label for="beneficiaryType">Beneficiary Type</label>
					<vayana:tenantServicesSelect name="beneficiaryType" id="beneficiaryType"
						module="MNGPAYMOD" businessFunction="ALL" required="required"   
							transactionFlagCode="Y">
					</vayana:tenantServicesSelect>
			</p>
		</div>
		
		<div class="fields">
			<p>
				<%--<label for="acctNumber">Account Number</label>
				<input type="text" name="acctNumber" id="acctNumber" required="required" pattern="[0-9]+" />
				--%>
				<label for="acctNumber"><g:message	code="beneficiary.templates.instructions.ifttemplate.accountnumber.label" /></label>
				<g:passwordField name="acctNumber" id="acctNumber" required="required" 
					title="${g.message(code:'beneficiary.templates.instructions.ifttemplate.accountnumber.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.ifttemplate.accountnumber.label.error.message")}" pattern="[a-zA-Z0-9]+"
				/>
			</p>
		</div>
		<div class="fields">
			<p>
				<%--<label for="cnfmAcctNum">Confirm Account Number</label>
				<input type="text" name="cnfmAcctNumber" id="cnfmAcctNumber"  required="required" pattern="[0-9]+"  />
				--%>
				<label for="cnfmAcctNumber"><g:message	code="beneficiary.templates.instructions.ifttemplate.confirmaccountno.label" /></label>
				<g:textField name="cnfmAcctNumber" id="cnfmAcctNumber" required="required"
					title="${g.message(code:'beneficiary.templates.instructions.ifttemplate.confirmaccountno.label.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.ifttemplate.confirmaccountno.label.error.message")}" pattern="[a-zA-Z0-9]+" 
				/>
			</p>
		</div>
		
		<div class="fields" id="currency">
			<g:render template="/beneficiary/templates/quickPay/tenantApplicationCurrency"/>
		</div>
		
		<div class="fields">
			<p>
				<%--<label for="nickName">Nick Name</label>
				<input type="text" name="nickName" id="nickName" required="required" />
				--%>
				<label for="nickName"><g:message code="beneficiary.templates.instructions.ifttemplate.benenickname.label" /></label>
				<g:textField name="nickName" id="nickName" required="required" class="shortname"
					title="${g.message(code:'beneficiary.templates.instructions.ifttemplate.benenickname.tooltip.text')}"	
					data-errormessage="${g.message(code:"beneficiary.templates.instructions.ifttemplate.benenickname.error.message")}" />
			</p>
		</div>
		
		<div id="bankDetails">
		<div class="fields">
			<p>
				<label for="bankBranchCode"><g:message code="beneficiary.templates.instructions.nefttemplate.bankcode.label"/></label>
				 <g:textField name="bankBranchCode" id="bankBranchCode" value="" required="required"
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
		</div>
	</div>
	<div class="buttons">
		
		<g:submitToRemote controller="beneficiary" action="pay" name="quickPay" id="quickPay" class="cancelForm" value="Pay" before="if(checkFormValidity()){return false;}" update="[failure:'messagesDiv']" onSuccess="onSubmitPay(data,textStatus)"></g:submitToRemote>
		<input type="button" id="cancel" value="Cancel" name="cancel" onClick="cancelQuickPay()" class="cancelForm btn_next"/>
		</div>
<div id="bankdialog" title="${g.message(code:'beneficiary.templates.instructions.swifttemplate.addcode.tooltip.text')}" style="display: none;"></div>
</g:form>

<g:javascript>
$(document).ready(function(){
	
	$(".searchCeebox").ceebox();
	var groupName = '';
	var acctType = '';
	
	$("#beneficiaryType").change(function (){
	
	$("#acctNumber").val("");
	$("#cnfmAcctNumber").val("");
	$("#nickName").val("");
	$("#bankBranchCode").val("");
	$("#bankName").val("");
	$("#beneficiaryName").val("");
	$("#currencyIdVersion").val("");
	
	var selected = $(':selected', this).data("code");
		if(selected == "INTCC") {
		$("label[for = acctNumber]").text("CreditCard Number");
		$("label[for = cnfmAcctNum]").text("Confirm CreditCard Number");
		}else{
		$("label[for = acctNumber]").text("Account Number");
		$("label[for = cnfmAcctNum]").text("Confirm Account Number");
		
		}
    	var optGroup = $(':selected', this).closest('optgroup').attr('label');
    	if(optGroup != null && selected != null){
    		groupName = optGroup;
    		acctType = selected;
    	}
    	
    	if(selected != null && selected != "" && selected == "EXT_PAYMENT"){
    		$("#bankDetails").show();
   			$("label[for = acctNumber]").text("IBAN Number");
			$("label[for = cnfmAcctNum]").text("Confirm IBAN Number");
			$("#currencyElement").show();
   			
   		} else if(selected!=null && selected!="" && (selected == "TPTTRANS" || selected == "INTCC")){
   			$("#bankDetails").hide();
   			$("#bankBranchCode").removeAttr("required");	
   			$("#bankName").removeAttr("required");
   			$("#currencyElement").hide();
   		}
   		
	});
	
	$("#cnfmAcctNumber").on("change",function() {
		var selected = $('#beneficiaryType :selected').data("code");
		if(selected == "TPTTRANS") {
			var acctNum 		= $("#acctNumber").val();
			var confirmAccNum 	= $("#cnfmAcctNumber").val();
			var acctType = selected;	
			if(acctNum !='' && acctNum == confirmAccNum){
				<g:remoteFunction controller="beneficiary" action="validateAccountNumber" update="currency" params="\'accountId=\'+acctNum"  onSuccess="onAcctNumSuccess(data,textStatus)" onFailure="onValidationFailure(XMLHttpRequest.responseText)" />
			}else{
				alert('Account Number and Confirm Account Number is Mismatching');
				 $("#cnfmAcctNumber").val("");
			}			
		}
		else if(selected == "INTCC"){
		var acctNum 		= $("#acctNumber").val();
		var creditcardNo = $("#cnfmAcctNumber").val();
			var acctType = selected;			
			if(acctNum !='' && acctNum == creditcardNo){
				<g:remoteFunction controller="beneficiary" action="validateCreditCardNumber" update="currency" params="\'creditcardNo=\'+creditcardNo" onSuccess="onAcctNumSuccess(data,textStatus)" onFailure="onValidationFailure(XMLHttpRequest.responseText)"/>
			}else{
				alert('CreditCard Number and Confirm CreditCard Number is Mismatching');
				 $("#cnfmAcctNumber").val("");
			}			
		}
		
		
		else 
		{
			var acctNum 		= $("#acctNumber").val();
			var confirmAccNum 	= $("#cnfmAcctNumber").val();
			if(acctNum !='' && acctNum == confirmAccNum){
				<g:remoteFunction controller="beneficiary" action="loadTenantApplicationCurrency" update="currency"  onSuccess="onAcctNumSuccess(data,textStatus)"/>
			}else{
				alert('Account Number and Confirm Account Number is Mismatching');
				 $("#cnfmAcctNumber").val("");
			}
			
		}
	});
	
	
});


function onValidationFailure(responseText){
	//alert('Err'+responseText);
	 $("#dynamicAuthContent").dynamicfieldupdate();
	 $("#messagesDiv").empty();
	 $("#messagesDiv").append(responseText);
	 $("#acctNumber").val("");
	 $("#cnfmAcctNumber").val("");
}

function onAcctNumSuccess(data,textStatus){
$("#currency").dynamicfieldupdate();
}

function checkFormValidity() {
	if(!$("#quickPayForm").checkValidity()) {
		return true;  
	}else {
		return false;
	}
}
function cancelQuickPay(){

var link = "<g:createLink action='addBeneficiary' controller='beneficiary' params='[]'/>"
postUrl('quickPayForm',link,'canvas')
}



function onSubmitPay(data,textStatus){
	var link = "<g:createLink action='paySuccess' controller='beneficiary' params='[isQuickPay:'true']'/>"
	postUrl('quickPayForm',link,'canvas')
}
function onSubmitSaveAndPay(data,textStatus){
<%--	//$("#ulFriendsAndFamilyPay li",window.parent.document).remove();
	//$("#ulFriendsAndFamilyPayh3",window.parent.document).trigger("click");
	$("#ulFriendsAndFamilyPayPlusLink",window.parent.document).trigger("click");--%>

	var link = "<g:createLink action='saveAndPaySuccess' controller='beneficiary' params='[]'/>"
	postUrl('quickPayForm',link,'canvas')
}
function postUrl(formName, url, targetName){
	var form = $('#'+formName);  
	form.attr('action',url);
	form.attr('method','POST');
	form.attr('target',targetName);
	form.submit();
}

<%-- Bank Related Script Defintiion --%>

	function openBankDialog()
	{
	$( "#bankdialog" ).dialog("open");
	}	

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
	function addBankInfo() 
	{
		var bankcode = $('.loadBankValue:checked').data('bankcode');
		var bankname = $('.loadBankValue:checked').data('bankname');
		var bankidversion = $('.loadBankValue:checked').data('bankidversion');
		$("#bankBranchCode").val(bankcode);
		$("#bankName").val(bankname);
		$("#payeeBankBranchId").val(bankidversion);			  	
    }
	
	$("#searchBank").click(function(){
		$(".searchResult").show();
    });
	
	// end of search bank code results ***********************************/
</g:javascript>