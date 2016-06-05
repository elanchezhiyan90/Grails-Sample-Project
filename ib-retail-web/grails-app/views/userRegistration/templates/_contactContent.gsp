<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'userregistration.templates.verificationcontent.h2.text') }
			</h2>
			<p>
				${message(code:'userregistration.templates.verificationcontent.information.label') }
			</p>
			<br>
<%--			<div class="mandi-note">--%>
<%--				<span class="mandi"></span>--%>
<%--				<p>--%>
<%--					${message(code:'userregistration.templates.verificationcontent.mandatoryfields.text') }--%>
<%--				</p>--%>
<%--			</div>--%>
			<vayana:flowerror />
			<g:form action="userRegistration" controller="userRegistration"
				name="registrationForm">
				<div class="col-450">

					<div class="fields">
						<p>
							<label for="ibUserMobileNumber"> ${message(code:'userregistration.templates.verificationcontent.ibUserMobileNumber.label') }
							</label> <input type="text" name="ibUserMobileNumber" id="ibUserMobileNumber"
								placeholder="${message(code:'userregistration.templates.verificationcontent.ibUserMobileNumber.placeholder.text') }"
								pattern="[0-9]*"
								data-errormessage="${message(code:'userregistration.templates.verificationcontent.ibUserMobileNumber.error.message') }"
								autocomplete="off" autofocus="off" required="required"
								value=""  />
						</p>

					</div>
					<div class="fields">
						<p>
							<label for="ibUserEmailId"> ${message(code:'userregistration.templates.verificationcontent.ibUserEmailId.label') }
							</label> <input type="email" name="ibUserEmailId" id="ibUserEmailId"
								placeholder="${message(code:'userregistration.templates.verificationcontent.ibUserEmailId.placeholder.text') }"								
								data-errormessage="${message(code:'userregistration.templates.verificationcontent.ibUserEmailId.error.message') }"
								autocomplete="off" required="required" value="" />
						</p>
					</div>

					<div class="buttons">
						<g:submitButton class ="btn_next" name= "" value="Cancel"/> 
						<g:submitButton name="usercontactinfosubmit"
							value="${message(code:'userregistration.templates.verificationcontent.continue.button.text') }" 
							onclick="preCheck()"/>
					</div>

				</div>				
			</g:form>
		</section>
	</div>

</div>