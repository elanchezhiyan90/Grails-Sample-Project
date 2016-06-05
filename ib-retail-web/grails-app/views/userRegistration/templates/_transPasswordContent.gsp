<div class="fields">
	<p>
		<label for="ibUserEncryptedTransPassCode"> ${message(code:'userregistration.templates.logininfocontent.transpassword.label') }</label> 
		<input type="password" name="ibUserEncryptedTransPassCode" id="ibUserEncryptedTransPassCode" tabindex="4" 
			placeholder="${message(code:'userregistration.templates.logininfocontent.transpassword.placeholder.text') }"
			data-errormessage="${message(code:'userregistration.templates.logininfocontent.transpassword.error.message') }"
			required autocomplete="off" value="" /> 
			<a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key" title="Use Virtual KeyBoard to enter your password"></a>
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
		<label for="ibUserEncryptedTransConfPassCode"> ${message(code:'userregistration.templates.logininfocontent.confirmtranspassword.label') }</label> 
		<input tabindex="5" placeholder="${message(code:'userregistration.templates.logininfocontent.confirmtranspassword.placeholder.text') }"
			data-errormessage='{"dependent": "Password did not matched", "typeMismatch": "Please re-type password"}' data-dependent-validation="log_pass" type="password"
			name="ibUserEncryptedTransConfPassCode" id="ibUserEncryptedTransConfPassCode" required autocomplete="off" value="" /> 
			<a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key" title="Use Virtual KeyBoard to enter your password"></a>
	</p>
</div>