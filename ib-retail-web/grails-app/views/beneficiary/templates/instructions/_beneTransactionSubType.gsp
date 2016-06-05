<div class="fields">
	<p>
		<label for="transactionSubTypeId"><g:message code="beneficiary.templates.instructions.transactionsubtypetemplate.paymentmode.label" /></label>
		<vayana:vayanaSelect id="transactionSubTypeId"
							name="transactionSubTypeId" type="description" from="${transactionSubTypes}"
							required="required" data-errormessage="${g.message(code:"beneficiary.templates.beneficiaryInstruction.paymentmode.error.message") }"
							onchange="${ remoteFunction( 
			 							controller :'beneficiary',
									    action:'displayBeneInstructionInput', 														  						
									    update:'beneInstructionInput',								 
									  	params:'\'selectedTransactionTypeId=\'+this.value',
										onFailure:'ontransactionSubTypeFailure(XMLHttpRequest.responseText)',
										onSuccess: 'ontransactionSubTypeSuccess();')}" />		
	</p>
</div>

<div id="beneInstructionInput"></div>

<script>
	
	$(document).ready(function(){
	
	// On Page Load Benficiary Template
	var transSubTypeLen = $("#transactionSubTypeId option").length;
	
	if(transSubTypeLen == 1)
	{
		<g:remoteFunction controller="beneficiary" action="displayBeneInstructionInput" params="\'selectedTransactionTypeId=\'+getTransactionSubType()" update="beneInstructionInput" onSuccess="ontransactionSubTypeSuccess()" onFailure="ontransactionSubTypeFailure(XMLHttpRequest.responseText)" />
	}
	});
	
	function ontransactionSubTypeSuccess()
	{
	    $("#buttonsDisplay").show();
		$("#beneInstructionInput").dynamicfieldupdate();
		$("#dynamicAuthContent").show();
 	}
 	
 	function getTransactionSubType()
	{
		var value = $("#transactionSubTypeId").val();
		return value;
	}
 	
						
</script>