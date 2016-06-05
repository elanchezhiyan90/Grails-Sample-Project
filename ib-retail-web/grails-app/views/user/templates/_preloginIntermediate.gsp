<g:form controller="user" action="index">
<br/>
<p>
<b><label>${message(code:'taglib.allowedIp.error.message')}</label></b>
</p>
<br/>
<g:hiddenField name="userLogin" value="${userLoginProfileModel?.userLoginProfile?.id}"/>
<g:hiddenField name="login" value="${params.login}"/>
<g:hiddenField name="allowedIp" value="${allowedIp}"/>

<g:if test="${!userLoginProfileModel?.userLoginProfile?.loginStatus?.code.equals('FAC')}">

<g:each in="${secretQuestions}" var="userSecretQuestion">
<div class="fields">
	<p>
        <label for="ibUserSecretQuestionDesc">${userSecretQuestion?.questionBasketDetail?.question?.description}</label>
        <g:hiddenField name="ibUserSecretQuestionId" value="${userSecretQuestion?.questionBasketDetail?.question?.id}"/>
		<br/>
		<input type="text"	name=ibUserSecretAnswer id="ibUserSecretAnswer"	placeholder="${message(code:'userregistration.templates.secretinfocontent.secretanswer.placeholder.text') }"
			autocomplete="off" autofocus required="required" data-errormessage="Please enter secret answer" />
	</p>
</div>
</g:each>
<div class="fields">
<p>
<vayana:secureImages ulpId="${userLoginProfileModel?.userLoginProfile?.id}"/>
</p>
</div>
<div class="fields">
	<p>
	<vayana:secureColors ulpId="${userLoginProfileModel?.userLoginProfile?.id}" tenAppId="50000" />
	</p>
</div>
</g:if>
<br/>
<br/>
<br/>

<div class="buttons">
	<g:submitToRemote id="preLoginIntermediateSubmit" name="preLoginIntermediateSubmit"
		value="Continue" url="[controller:'user',action:'preLoginIntermediateSubmit']" update="[success:'loginDiv',failure:'messagesDiv']"
		before="if (checkFormValidity()) {return false;};"
		onSuccess="onIntermediateSuccess(data,textStatus);"
		onFailure="loadFailure(XMLHttpRequest.responseText);"
		/>
	<input type="button" name="loginCancel" id="loginCancel" value="${message(code:'user.templates.secure.cancel.button.text') }" class="btn_next" />
</div>

</g:form>

<script>

	$(document).ready(function(){
		// Hide navigateToLogin
		$("#forgetUserName").empty();
		$("#navigateToLogin").hide();
		
		/* Script for login Secure Images*/
            $( "input[name=secureImg]" ).change(function() {
	              if($(this).is( ":checked" )){
	                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').siblings().removeClass('active').find('.ticker').detach('.ticker');  
	                }
    		}).change();
		
		$( "input[name=userSecureColor]" ).change(function() {
              if($(this).is( ":checked" )){
                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').parent().siblings().find('label').removeClass('active').find('.ticker').detach('.ticker');  
                var color=$(this).val();                
                $('.sec_prvw').css("background-color","#"+color);
                }
            }).change();
		
	});	
	
	function onIntermediateSuccess(data,textStatus){
		$("#messagesDiv").empty();
		$("#pwd").focus();
		$("#login").attr('readonly', 'readonly');
	}
		
</script>