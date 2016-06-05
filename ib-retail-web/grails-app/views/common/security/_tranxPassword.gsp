<div class="fields">
	<p>
		<label for="txnPassword">${message(code:'taglib.tranxPassword.enterpwd.label')}</label>
		<g:passwordField name="txnPassword" id="txnPassword" required="required" 
			data-errormessage="${message(code:'taglib.tranxPassword.pleaseenterpwd.error.message')}" />
		<vayana:submitToRemote
			url="[controller:'security',action:'validateTxnPwd']"
			name="txnPwdSubmit" id="txnPwdSubmit" value="Ok"
			update="[failure:'messagesDiv',success:'dynamicAuthContent']"
			before="if (checkFormValidity()) {return false;};encryptTXN();emptyErrorDiv();"
			onSuccess="onAuthSuccess(data,textStatus)"
			onFailure="onAuthFailure(XMLHttpRequest.responseText,'${params?.displayAsPopUp}')" />

		<g:hiddenField name="userLoginProfileId" value="${params?.userLoginProfileId}" />
		<g:hiddenField name="groupId" value="${params?.groupId}" />
		<g:hiddenField name="tenantApplicationId" value="${params?.tenantApplicationId}" />
		<g:hiddenField name="loginId" value="${params?.loginId}" />
	</p>
	<g:if
		test="${securityHolder?.securitySettings && securityHolder?.securitySettings?.size() == 1}">
		<g:hiddenField name="securityHolderSize" value="true" />
	</g:if>
	<g:else>
		<g:hiddenField name="securityHolderSize" value="false" />
	</g:else>
	<g:hiddenField name="displayAsPopUp" value="${params?.displayAsPopUp}" />
	<g:render template="/common/security/templates/securityUtils" />
</div>
<script>
$(function(){
	$("#txnPassword").focus();
	$("#txnPassword").keydown(function (e){
	  	if(e.keyCode == 13){
	    	$("#txnPwdSubmit").trigger("click");
	    	return false;
	  	}
	});
});
function encryptTXN()
{
	var txnValue = $("#txnPassword").val();
	var cipher = encrypt(txnValue);
	$("#txnPassword").val(cipher);
}
</script>