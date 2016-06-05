<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'firsttimelogin.templates.logininfocontent.h2.text') }
			</h2>
			<p>
				${message(code:'userregistration.templates.logininfocontent.information.message') }
			</p>
			<br>
			<%--<div class="mandi-note">
				<span class="mandi"></span>
				<p>
					${message(code:'userregistration.templates.logininfocontent.mandatoryfields.text') }
				</p>
			</div>
			--%>
			<vayana:flowerror />
			<g:form action="firstTimeLogin" controller="userProfile">
				<g:hiddenField name="selfImageName" id="selfImageName" />
				<div class="col-550">
					<div class="fields">
						<p>
							<label for="ibUserLoginName"> ${message(code:'userregistration.templates.logininfocontent.loginid.label') }
							</label> <input type="text" name="ibUserLoginName" id="ibUserLoginName"
								placeholder="${message(code:'userregistration.templates.logininfocontent.loginid.placeholder.text') }"
								data-errormessage="${message(code:'userregistration.templates.logininfocontent.loginid.error.message') }"
								autocomplete="off" autofocus value="${fibUserName}" readonly required>
						</p>
						<div class="updater" id="userNameExist"></div>

					</div>
					<div class="fields">
						<p>
							<label for="ibUserEncryptedPassCode"> ${message(code:'userregistration.templates.logininfocontent.loginpassword.label') }
							</label> <input type="password" name="ibUserEncryptedPassCode"
								id="ibUserEncryptedPassCode"
								placeholder="${message(code:'userregistration.templates.logininfocontent.loginpassword.placeholder.text') }"
								data-errormessage="${message(code:'userregistration.templates.logininfocontent.loginpassword.error.message') }"
								required autocomplete="off" value="" />
						</p>
						<p>
							<br> <a class="vkey"><img
								src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png"
								width="20" height="20" alt="Virtual Key"></a>
						</p>
						<!-- <div class="updater">Password strength indicator</div> -->
						<div class="fieldnote">
							<p>
								${message(code:'userregistration.templates.logininfocontent.clickhereabout.message') }
								<g:remoteLink  controller="userProfile" action="showPasswordPolicy" update="pwdPolicyDialog" onSuccess="openPwdPolicy()">
					<g:message code="userregistration.templates.logininfocontent.passwordpolicy.text"/>
					</g:remoteLink>
							</p>
						</div>
					</div>

					<div class="fields">
						<p>
							<label for="ibUserEncryptedConfPassCode"> ${message(code:'userregistration.templates.logininfocontent.confirmpassword.label') }
							</label> <input
								placeholder="${message(code:'userregistration.templates.logininfocontent.confirmpassword.placeholder.text') }"
								data-errormessage='{"dependent": "Password did not matched", "typeMismatch": "Please re-type password"}'
								data-dependent-validation="ibUserEncryptedPassCode" type="password"
								name="ibUserEncryptedConfPassCode"
								id="ibUserEncryptedConfPassCode" required autocomplete="off"
								value="" />

						</p>
					</div>
					<g:if test="${fApplyTransPassword?.equals("Y")}">
						<g:render
							template="/userProfile/firstTimeLogin/template/transPasswordContent" />
					</g:if>
					<g:if test="${grailsApplication.config.secure.color.required == true}">
					<div class="fields">
						<p>
							<g:radio name="imageType" value="PRE" id="imageType"
								checked="true" onclick="onSecureImageClick('PRE')" />
							PreDefined Image
							<g:radio name="imageType" value="PSZL" id="imageType"
								onclick="onSecureImageClick('PSZL')" />
							Personalized Image
						</p>
					</div>
					</g:if>
					<g:else>
						<g:hiddenField name="imageType" id="imageType" value="PRE"/>
					</g:else>
					<div class="fields">
						<p>
							<b>1. Choose your secure access image from the below</b>
						</p>
					</div>



					<div class="fields" id="preDefSecureImageContent">
						<p>
							<label for="ibUserSecureImageId1"> ${message(code:'userregistration.templates.logininfocontent.selectcategory.label') }
							</label>

							<g:select name="ibUserSecureImageId1" required="true"
								from="${userSelfRegistrationResponseModel?.secureImageBaskets}"
								optionKey="id" optionValue="code"
								onchange=" ${remoteFunction( 
					 						    	controller :'userProfile',
													update:'secureImageDiv',
											   		action:'loginsecureimage', 														  						
					 								params:'\'ibUserSecureImageId=\'+getIBUserSecureImageId()' ,onSuccess: 'onSecureImageSuccess(data,textStatus);'											  		
					 					   			)}"
								data-errormessage="Please select secure image category"
								value="${fibUserSecureImageId1}" />
						</p>

						<%--<p>
							${message(code:'userregistration.templates.logininfocontent.choosesecureimage.message') }
						</p>
					--%></div>


					<div class="fields" id="userDefSecureImageContent">
						<p>
							<fileUpload:uploader id="selfImage" url="secureUpload"
								multiple="false" params="[cif:" ${fcustomerId}"]"/>
						</p>
					</div>

					<div class="secureimage">
						<div class="carousel module" id="secureImageDiv"></div>
					</div>

					<g:if test="${grailsApplication.config.secure.color.required == true}">
						<div class="fields">
							<p>
								<b>2. Choose your secure color from the below</b>
							</p>
						</div>
	
						<g:render template="/userProfile/firstTimeLogin/template/loginsecurecolors" />
					</g:if>
					<div class="fields">
						<p>

							<label for="ibUserSecureMessage"> ${message(code:'userregistration.templates.logininfocontent.personalizedmessage.label') }
							</label> <input
								placeholder="${message(code:'userregistration.templates.logininfocontent.personalizedmessage.placeholder.text') }"
								data-errormessage="${message(code:'userregistration.templates.logininfocontent.personalizedmessage.error.message') }"
								type="text" name="ibUserSecureMessage" id="ibUserSecureMessage"
								required autocomplete="off" value="${fibUserSecureMessage}" maxlength="10" />

						</p>
					</div>
					<div class="buttons">
						<g:submitButton name="firstTimeLoginInfoSubmit"
							onclick="preCheck();preSetParams()"
							value="${message(code:'userregistration.templates.logininfocontent.continue.button.text') }" />
					</div>
					
					
				<div class="fields">
				<p>&nbsp;</p>
				</div>
				<div class="fields">
				<p>&nbsp;</p>
				</div>
				
				
				
				</div>
				<g:if test="${grailsApplication.config.secure.color.required == true}">
				<div class="layer_preview">
					<div class="fields">
						<p>
							<b>Security Seal Preview</b>
						</p>
					</div>
					<div class="sec_prvw" style="background: #f1f1f1;">
						<div>
							<p align="center">
								<img />
							</p>
							<br />
							<p align="center">
								<b><i>Your Short Message</i></b>
							</p>
						</div>
					</div>
				</div>
				</g:if>
				<g:render template="/user/templates/vkeyboard" />
				<!-- col-280 ends here -->
			</g:form>
				<div id="pwdPolicyDialog" title="${g.message(code:'userregistration.templates.logininfocontent.passwordpolicy.text')}" style="display:none;height:280px; width:500px; !important;" class="body-scroll">
    
	</div>
		</section>
	</div>

</div>

