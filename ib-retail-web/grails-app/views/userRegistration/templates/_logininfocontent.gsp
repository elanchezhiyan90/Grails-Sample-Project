<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'userregistration.templates.logininfocontent.h2.text') }
			</h2>
			<p>${message(code:'userregistration.templates.logininfocontent.information.message') }</p>
			<br>
			<%--			<div class="mandi-note">--%>
			<%--				<span class="mandi"></span>--%>
			<%--				<p>--%>
			<%--					${message(code:'userregistration.templates.logininfocontent.mandatoryfields.text') }--%>
			<%--				</p>--%>
			<%--			</div>--%>
			<vayana:flowerror />
			<g:form action="userRegistration" controller="userRegistration" name="registrationForm">
				<div class="col-550">
					<div class="fields">
						<p>
							<label for="ibUserLoginName"> ${message(code:'userregistration.templates.logininfocontent.loginid.label') }</label> 
							<input type="text" name="ibUserLoginName" id="ibUserLoginName" tabindex="1" value="${fcustomerId}" readonly="readonly"
								placeholder="${message(code:'userregistration.templates.logininfocontent.loginid.placeholder.text') }"
								data-errormessage="${message(code:'userregistration.templates.logininfocontent.loginid.error.message') }"
								autocomplete="off" required autofocus
								onblur=" ${remoteFunction( 
													before:'if (checkUserNameNull()) {return false;};',	
					 						    	controller :'userRegistration',
													update:'userNameExist',
											   		action:'usernamevalidator',																																 														  						
					 								params:'\'ibUserLoginName=\'+getIBUserLoginName()' ,onSuccess: 'onValidateUserName(data,textStatus);'											  		
					 					   			)}"
								value="${fibUserName}">
						</p>
						<div class="updater" id="userNameExist"></div>

					</div>
					<div class="fields">
						<p>
							<label for="ibUserEncryptedPassCode"> ${message(code:'userregistration.templates.logininfocontent.loginpassword.label') }
							</label> <input type="password" name="ibUserEncryptedPassCode"
								tabindex="2" id="ibUserEncryptedPassCode"
								placeholder="${message(code:'userregistration.templates.logininfocontent.loginpassword.placeholder.text') }"
								data-errormessage="${message(code:'userregistration.templates.logininfocontent.loginpassword.error.message') }"
								required autocomplete="off" value="" /> <a class="vkey"><img
								src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png"
								width="20" height="20" alt="Virtual Key"
								title="Use Virtual KeyBoard to enter your password"></a>
						</p>
						<!-- <div class="updater">Password strength indicator</div> -->
						<div class="fieldnote">
							<p>
								${message(code:'userregistration.templates.logininfocontent.clickhereabout.message') }
								<g:remoteLink controller="userRegistration" action="showPasswordPolicy" update="pwdPolicyDialog" onSuccess="openPwdPolicy()">
									<g:message code="userregistration.templates.logininfocontent.passwordpolicy.text" />
								</g:remoteLink>
							</p>
						</div>
					</div>

					<div class="fields">
						<p>
							<label for="ibUserEncryptedConfPassCode"> ${message(code:'userregistration.templates.logininfocontent.confirmpassword.label') }</label> 
							<input tabindex="3" placeholder="${message(code:'userregistration.templates.logininfocontent.confirmpassword.placeholder.text') }"
								data-errormessage='{"dependent": "Password did not matched", "typeMismatch": "Please re-type password"}'
								data-dependent-validation="log_pass" type="password" name="ibUserEncryptedConfPassCode" id="ibUserEncryptedConfPassCode" required autocomplete="off"
								value="" /> 
								<a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"
								title="Use Virtual KeyBoard to enter your password"></a>
						</p>
					</div>
					<g:if test="${fApplyTransPassword?.equals("Y")}">
						<g:render template="/userRegistration/templates/transPasswordContent" />
					</g:if>
					<!-- col-280 ends here -->
					<div class="buttons">
						<input type="button" id="cancelTxn" value="Cancel" name="cancelTxn" class="cancelTxn btn_next" onclick="onclickCancel()" />
						<g:submitButton name="userlogininfosubmit" onclick="preCheck()" value="${message(code:'userregistration.templates.logininfocontent.continue.button.text') }" />
					</div>
					<g:render template="/user/templates/vkeyboard" />
			</g:form>
			<div id="pwdPolicyDialog"
				title="${g.message(code:'userregistration.templates.logininfocontent.passwordpolicy.text')}"
				style="display: none; height: 280px; width: 500px;"
				class="body-scroll"></div>
		</section>
	</div>

</div>
<g:javascript>  
function onclickCancel(){
	var link = "<g:createLink action='tenant' controller='index' params='[]' />"
	postUrl('registrationForm',link,'_self')
}
function postUrl(formName, url, targetName){
	var form = $('#'+formName);  
	form.attr('action',url);
	form.attr('method','POST');
	form.attr('target',targetName);
	form.submit();
}
</g:javascript>
