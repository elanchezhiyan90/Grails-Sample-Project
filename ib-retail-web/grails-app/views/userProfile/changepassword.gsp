<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<vayana:errors />
	<g:form name="changepassword">
		<div class="body-scroll">
			<div class="f-panel">
				<h2>
					${message(code:'userprofile.template.changepassword.h2.text')}
				</h2>
				<%--<div class="mandi-note">
			<span class="mandi"></span>
			<p>${message(code:'userprofile.template.changepassword.mandatoryfields.text')}</p>
		</div>
			--%>
				<div class="fields">
					<p>
						<label for="ibUserEncryptedPassCode"> ${message(code:'userprofile.template.changepassword.existingloginpassword.label')}
						</label> <input type="password" name="ibUserEncryptedPassCode"
							id="ibUserEncryptedPassCode"
							placeholder="${message(code:'userprofile.template.changepassword.enterpassword.placeholder.text')}"
							data-errormessage="${message(code:'userprofile.template.changepassword.password1.error.message')}"
							autocomplete="off" required="required" />
					</p>
				</div>
				<div class="fields">
					<p>
						<label for="ibNewEncryptedPassCode"> ${message(code:'userprofile.template.changepassword.newloginpassword.label')}
						</label> <input type="password" name="ibNewEncryptedPassCode"
							id="ibNewEncryptedPassCode"
							placeholder="${message(code:'userprofile.template.changepassword.choosepassword.placeholder.text')}"
							data-errormessage="${message(code:'userprofile.template.changepassword.password2.error.message')}"
							autocomplete="off" required="required" />
					</p>
					<!-- <div class="updater">Password strength indicator</div> -->
					<div class="fieldnote">
						<p>
							${message(code:'userprofile.template.changepassword.clickheretoknowabout.text')}
							<g:remoteLink controller="userProfile"
								action="showPasswordPolicy" update="pwdPolicyDialog"
								onSuccess="openPwdPolicy();">
								<g:message
									code="userregistration.templates.logininfocontent.passwordpolicy.text" />
							</g:remoteLink>

						</p>
					</div>
				</div>
				<div class="fields">
					<p>
						<label for="ibNewConfEncryptedPassCode"> ${message(code:'userprofile.template.changepassword.confirmpassword.label')}
						</label> <input
							placeholder="${message(code:'userprofile.template.changepassword.confirmpassword.placeholder.text')}"
							data-errormessage='{"dependent": "Password did not matched", "typeMismatch": "Please re-type password"}'
							data-dependent-validation="log_pass" type="password"
							name="ibNewConfEncryptedPassCode" id="ibNewConfEncryptedPassCode"
							autocomplete="off" required="required" />
					</p>
				</div>
				<div class="buttons" id="submitNow">
					<g:submitToRemote
						value="${message(code:'userprofile.template.changepassword.submit.button.text')}"
						id="verifySubmit" name="verifySubmit"
						before="if (checkFormValidity()) {return false;}"
						action="verifyloginpasscode" controller="userProfile"
						onSuccess="onVerifySuccess(data,textStatus);"
						onFailure="onVerifyError(XMLHttpRequest.responseText);" />

				</div>
				<div class="success" id="resultsuccess" style="display: none;">
					<span></span>
				</div>

			</div>
		</div>
	</g:form>
	<div id="pwdPolicyDialog"
		title="${g.message(code:'userregistration.templates.logininfocontent.passwordpolicy.text')}"
		style="display: none; height: 280px; width: 500px;"
		class="body-scroll"></div>
	<g:javascript>
function checkFormValidity()
{
	if(!$('form').checkValidity())
	{
	return true;
	}else
	{
	$("#submitNow").hide();
	return false;
	}

}
function onVerifySuccess(data,textStatus)
{
	if(textStatus=='success')
	{
		var response =  $(data).first().html();	
		$("#errorDiv").empty();	
		$("#resultsuccess").show();
		$("#resultsuccess").html(response);
		$("#resultsuccess").dynamicfieldupdate();		
	}
}
function onVerifyError(responseText)
{
	$("#errorDiv").empty();
	$("#errorDiv").append(responseText);
	$("#submitNow").show();
}
</g:javascript>
<script>
function openPwdPolicy()
	{
	alert("GG");
		$("#pwdPolicyDialog").dialog("open");
	}
       
        var pwdPolicyDialog = $( "#pwdPolicyDialog" ).dialog({
            autoOpen: false,
            width:500,
            modal: true,
            resizable: false,
			draggable: false,
            buttons: {
                
                Close: function() {
                    $( this ).dialog( "close" );
                }
            },
            close: function() {
            	$( this ).dialog( "close" );
            }
        });	
</script>
</body>
