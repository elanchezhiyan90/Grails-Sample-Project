<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'userregistration.templates.verificationcontent.userregistration.h2.text') }
			</h2>
			<h3>
				${message(code:'userregistration.templates.verificationcontent.useralreadyregistered.text') }
			</h3>
			<br>
			<br>
			
			<div class="fields">
			<p>
			<b><g:link controller="tenant">${message(code:'userregistration.templates.clickhere.link.text') }</g:link> ${message(code:'userregistration.templates.goback.text') }</b>
			</p>
			</div>
			<%--<g:form name="forgotpasswordForm">
				<div class="fields">
					<p>
						<vayana:postablelink controller="user" action="forgotPassword" linkClass="cancel" linkTitle="Forgot Password" id="forgotpassword" formName="forgotpasswordForm">${message(code:'user.templates.secure.forgetpassword.text')}</vayana:postablelink>
					</p>
				</div>
			</g:form>
		--%></section>
	</div>
</div>
