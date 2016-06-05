<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'userregistration.templates.verificationcontent.userregistration.h2.text') }
			</h2>
			<h3>
				${message(code:'customerselfreg.blockedcif.error') }
			</h3>
			<g:form name="registerForm">
				<div class="fields">
					<p>
						<vayana:postablelink  controller="userRegistration" action="userRegistration" linkClass="cancel" linkTitle="${message(code:'user.templates.content.clicktoregister.tooltip.text') }" id="register" formName="registerForm" target="_self">Try Again</vayana:postablelink>				
					</p>
				</div>
			</g:form>			
		</section>
	</div>
</div>
