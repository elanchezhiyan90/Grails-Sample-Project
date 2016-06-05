<div class="fields">
	<p>
		<label for="start_dte">
			${message(code:'taglib.twofamodel.enterotp.label')}
		</label>
							
		<g:passwordField name="otpValue" id="otpValue"
			required="required"
			data-errormessage="${message(code:'taglib.twofamodel.pleaseenterotp.error.message')}" />
		<vayana:submitToRemote url="[controller:'security',action:'validateTwoFa']"  name="otpSubmit"
			id="otpSubmit"  value="Ok"
			update="[failure:'messagesDiv',success:'dynamicAuthContent']"
			before="if (checkFormValidity()) {return false;};encryptOTP();emptyErrorDiv();"
			onSuccess="onAuthSuccess(data,textStatus)"
			onFailure="onAuthFailure(XMLHttpRequest.responseText,'${params?.displayAsPopUp}')" />
		<vayana:submitToRemote controller="security" action="resendOTP"
			before="clearOldOTP()" name="resendButton" value="Resend"
			id="resendButton" onSuccess="onResendSuccess(data,textStatus)"
			onFailure="onResendFailure(XMLHttpRequest.responseText)" />

	</p>
	<g:if
		test="${securityHolder?.securitySettings && securityHolder?.securitySettings?.size() == 1}">
		<g:hiddenField name="securityHolderSize" value="true" />
	</g:if>
	<g:else>
		<g:hiddenField name="securityHolderSize" value="false" />
	</g:else>
	<g:hiddenField name="displayAsPopUp" value="${params?.displayAsPopUp}" />
	<g:hiddenField name="resendTimeInterval" value="${resendInterval}" />
	<g:render template="/common/security/templates/securityUtils" />
</div>

<script>
$(function() {
	$("#otpValue").focus();
	$("#otpValue").keydown(function (e){
	  	if(e.keyCode == 13){
	    	$("#otpSubmit").trigger("click");
	    	return false;
	  	}
	});
	$('#resendButton').hide();
	setTimeout('enableResend()',$('#resendTimeInterval').val());
});

function onResendSuccess(data,status)
{
$('#resendButton').hide();
setTimeout('enableResend()',$('#resendTimeInterval').val());
}
function onResendFailure(responseText)
{

}
function enableResend()
{
$('#resendButton').show();
}

function encryptOTP()
{
	var otpValue = $("#otpValue").val();
	var cipher = encrypt(otpValue);
	$("#otpValue").val(cipher);
}
function clearOldOTP(){
	$("#otpValue").val('');
}
</script>