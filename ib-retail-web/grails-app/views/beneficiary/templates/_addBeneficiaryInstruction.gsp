<%@page import="com.vayana.bm.core.api.constants.BusinessFunctionConstants"%>
<div class="servicepanel" id="servicepanel">
<g:form name="addBeneficiaryInstruction" id="addBeneficiaryInstruction">
<g:hiddenField name="buttonEvent"/>
<g:if test="${beneMaxExceeded =='true'}">
			<h2>
			<g:message code="beneficiary.addbeneficiaryInstruction.limitexceed.text" />
			</h2>
</g:if>
<g:else>
<vayana:popupMessages/> 
<g:hiddenField name="beneficiaryId" value="${params?.beneficiaryId}" />
<g:set var="code"  value="${beneficiaryInstruction?.transactionSubType?.serviceApplication?.service?.code}"/>
<g:if test="${beneficiaryInstruction?.id || beneficiaryInstruction?.processInstanceId}">
	<g:hiddenField name="entityId" value="${beneficiaryInstruction?.id}"/>
	<g:hiddenField name="beneficiaryInstructionId" value="${beneficiaryInstruction?.idVersion}" />
	<g:hiddenField name="transactionTypeId" value="${beneficiaryInstruction?.transactionTypeId}" />
	<g:hiddenField name="transactionSubTypeId" value="${beneficiaryInstruction?.transactionSubType?.serviceApplication?.service?.idVersion}" />
	<g:hiddenField name="processInstanceId" value="${params?.processInstanceId}"/>
	<g:hiddenField name="referenceNumber" value="${beneficiaryInstruction?.referenceNumber}"/>
	
		<g:if test ="${BusinessFunctionConstants.WITHIN_BANK.equals(code)}">  
			<g:render template="/beneficiary/templates/instructions/TPTtemplate"></g:render>
		</g:if>
		<g:if test ="${BusinessFunctionConstants.RTGS.equals(code)}"> 
			<g:render template="/beneficiary/templates/instructions/RTGStemplate"></g:render>
		</g:if>
		<g:elseif test ="${BusinessFunctionConstants.NEFT.equals(code)}">
			<g:render template="/beneficiary/templates/instructions/NEFTtemplate"></g:render>
		</g:elseif>
		<g:elseif test ="${BusinessFunctionConstants.OVERSEAS_PAYMENT.equals(code)}">
			<g:render template="/beneficiary/templates/instructions/SWIFTtemplate"></g:render>
		</g:elseif>
		<g:elseif test ="${BusinessFunctionConstants.LOCAL_TRANSFER.equals(code)}">
			<g:render template="/beneficiary/templates/instructions/LOCALtemplate"></g:render>
		</g:elseif>
		<g:elseif test ="${BusinessFunctionConstants.CREDIT_CARD_TRANS.equals(code)}">
			<g:render template="/beneficiary/templates/instructions/creditCardTemplate"></g:render>
		</g:elseif>
		<g:elseif test ="${BusinessFunctionConstants.IMPSP2P.equals(code)}">
			<g:render template="/beneficiary/templates/instructions/IMPSP2Ptemplate"></g:render>
		</g:elseif>
		<g:elseif test ="${BusinessFunctionConstants.IMPSP2M.equals(code)}">
			<g:render template="/beneficiary/templates/instructions/IMPSP2Mtemplate"></g:render>
		</g:elseif>
		<g:elseif test ="${BusinessFunctionConstants.IMPSP2U.equals(code)}">   
			<g:render template="/beneficiary/templates/instructions/IMPSP2Utemplate"></g:render>
		</g:elseif> 
		
		<g:elseif test ="${BusinessFunctionConstants.IMPSP2A.equals(code)}">               
			<g:render template="/beneficiary/templates/instructions/IMPSP2Atemplate"></g:render>   
		</g:elseif>    
</g:if>

<g:else>

		<div class="fields">
		<p>
			<label for="transactionTypeId"><g:message
					code="beneficiary.templates.beneficiaryInstruction.paymenttype.label" /></label>
			<vayana:vayanaSelect id="transactionTypeId"	name="transactionTypeId" type="description"
				from="${transactionTypes}" required="required" data-errormessage="${g.message(code:"beneficiary.templates.beneficiaryInstruction.paymenttype.error.message") }"
				onchange="${ remoteFunction( 
 							controller :'beneficiary',
						    action:'selectTransactionSubType', 														  						
						    update:'divTransactionSubType',								 
						  	params:'\'selectedTransactionTypeId=\'+this.value',onSuccess: 'ontransactionTypeSuccess();')}" />
		</p></div>
	

	<div class="" id="divTransactionSubType"></div>
	
																
	
                    
</g:else>

<g:if test="${beneficiaryInstruction?.id}">
<div class="buttons" id="dynamicAuthContent">
	<%--<vayana:submitButton controller="beneficiary" action="updateBeneficiaryInstruction" name="btnupdateBeneficiaryInstruction" id="btnupdateBeneficiaryInstruction" 
		update="[success:'beneficiaryAccountDetails',failure:'popupMessagesDiv']"  onSuccess="closeSaveDialogue(data,textStatus)" onFailure="" value="Update" hideSaveFlag="true" 
		before="if (checkFormValidity()) {return false;}"/>
		
	 --%><vayana:serviceValidate name="Confirm"
					value="Confirm" formName="addBeneficiaryInstruction" buttonEvent="Confirm"
					enableButton="btns_now" controller="beneficiary" update="[success:'beneficiaryAccountDetails',failure:'popupMessagesDiv']" 
					action="beneficiaryInstructionConfirm" secondaryDiv="servicepanel" displayAsPopUp="YES"/>		
		
		<input type="button" id="cancel" value="Cancel" name="cancel" class="cancelForm btn_next" onclick="closeSaveDialogue()" />
		
	</div>
</g:if>
<g:else>
	<div class="buttons" id="dynamicAuthContent">
	
	<%--<span id="buttonsDisplay" style="display:none">
	   <vayana:submitButton controller="beneficiary" action="insertBeneficiaryInstruction" name="btnsaveBeneficiaryInstruction" id="btnsaveBeneficiaryInstruction" 
		update="[success:'beneficiaryAccountDetails',failure:'popupMessagesDiv']"  onSuccess="closeSaveDialogue(data,textStatus)" onFailure="" value="Save" hideSaveFlag="true"
		before="if (checkFormValidity()) {return false;}" />
		
	--%><vayana:serviceValidate name="Confirm"
					value="Confirm" formName="addBeneficiaryInstruction" buttonEvent="Confirm"
					enableButton="btns_now" controller="beneficiary" update="[success:'beneficiaryAccountDetails',failure:'popupMessagesDiv']" 
					action="beneficiaryInstructionConfirm" secondaryDiv="servicepanel"  displayAsPopUp="YES"/>		
		
		
	
	<input type="button" id="cancel" value="Cancel" name="cancel" class="cancelForm btn_next" onclick="closeSaveDialogue()" />
	
	</span>
		
	</div>
</g:else>
</g:else>
</g:form>
</div>

<script>

$("#addBeneficiaryInstruction").dynamicfieldupdate();

//$("#dynamicAuthContent").hide();

function closeSaveDialogue(data,textStatus) {
	 $("#beneficiaryAccountDetails").html(data);
	 $("#beneficiaryAccountDetails").dynamicfieldupdate();	
	 $.fn.ceebox.closebox();
	 
	 <%--$("a.add ceebox").click(function(event){
		event.preventDefault();
		var url=$(this).attr("href");
		$.fn.ceebox();
		$.fn.ceebox.popup("<a href='"+url+"' title='Edit'>edit</a>","")
		});
	 $("#beneficiaryAccountDetails").dynamicfieldupdate(); --%>	
}

function ontransactionTypeSuccess()
{
	$("#buttonsDisplay").hide();
	$("#divTransactionSubType").dynamicfieldupdate();
}

function checkFormValidity(){

	if(!$("#addBeneficiaryInstruction").checkValidity()){ 
	      return true;   
	}else{
		   return false;
	}
}

function onAuthSuccess(data,textStatus)
{
	var securityHolderSize = $(data).filter("#securityHolderSize").val();
	if(securityHolderSize!='undefined' && securityHolderSize =='true')
	{
		closeSaveDialogue(data,textStatus);
		
	}
}
function onFailure(responseText)
{
	$("#popupMessagesDiv").empty();
	$("#popupMessagesDiv").append(responseText);
	$("#dynamicAuthContent").hide();

}

function ontransactionSubTypeFailure(responseText)
{
	$("#popupMessagesDiv").empty();
	$("#popupMessagesDiv").append(responseText);
	$("#dynamicAuthContent").hide();
	$("#beneInstructionInput").html("");

}

</script>