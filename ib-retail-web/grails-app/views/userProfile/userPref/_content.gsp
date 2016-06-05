<div class="content">
	<div class="content-wrap">
		<section class="app-section">
			<g:form name="registerIPAddress" controller="userProfile">

				<p>
					${message(code:'userl.login.allowedip.register.message')}
				</p>

				<br />

				<div class="buttons">
					<g:actionSubmit
						value="${message(code:'userl.login.allowedip.register.button.nothanks')}"
						action="dontRegisterIPAddress" />
					<g:actionSubmit
						value="${message(code:'userl.login.allowedip.register.button.label')}"
						action="registerIPAddress" />
				</div>

			</g:form>
		</section>
	</div>
</div>