<g:form name="confirmStatusUpdate" id="confirmStatusUpdate">
<vayana:popupMessages/>

<div class="fields" align="right">
    <p><span></span><strong>${message(code:'beneficiary.status.confirm')}</strong></p>
</div>
<g:set var="statusCode" value="${params.statusCode}" />
<div id="dynamicAuthContent" class="fields" align="center">
<g:if test="${statusCode=='INA'}">
		<vayana:securitysetting controller="security" action="fetchSecurityAdviceForAService" 
		successAction="enableBeneficiary" successController="beneficiary" 
		targetService="BENE" formName="confirmStatusUpdate" displayAsPopUp="YES" />
				
</g:if>
<g:else test="${statusCode=='ACT'}">
		<vayana:securitysetting controller="security" action="fetchSecurityAdviceForAService" 
		successAction="disableBeneficiary" successController="beneficiary" 
		targetService="BENE" formName="confirmStatusUpdate" displayAsPopUp="YES" />
	
</g:else>
<input type="button" value="Cancel" class="btn_next" id="canceltrans"  onclick="cancelDialog()" />
</div>
</g:form>

<script>

function onAuthSuccess(data,textStatus)
{	
	var securityValidation = $(data).find("#securityValidation").val();
	var eventName = $(data).find("#eventName").val();
	var beneficiaryId = $(data).find("#beneficiaryId").val();
	if(securityValidation =='')
	{
		
		var beneIdArray = $('#beneficiaryId').val().split(",");
		var beneId = beneIdArray[0];
		var beneIdIndex = "benedtl-"+beneId;
		if(eventName == 'enableBeneficiary')
		{
			$("#ulFriendsAndFamilyPay li",window.parent.document).remove();
			$("#ulFriendsAndFamilyPayh3",window.parent.document).trigger("click");
			  
		}
		else if(eventName == 'disableBeneficiary')
		{
		
			$("#ulFriendsAndFamilyPayPlusLink",window.parent.document).trigger("click");   
			$("#ulFriendsAndFamilyPay li",window.parent.document).remove();
			$("#ulFriendsAndFamilyPayh3",window.parent.document).trigger("click");
			
			
		}
		
		$.fn.ceebox.closebox();		
		$("#benedtl-beneIdIndex",window.parent.document).trigger("click"); 
	}
}

function cancelDialog()
{
	$.fn.ceebox.closebox();
}

function checkFormValidity()
{
	if(!$("#confirmStatusUpdate").checkValidity())
 	{
 		return true;
 	}else
 	{
 		return false;
 	}
}
</script>