<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'userregistration.templates.sealinfo.h2.text') }
			</h2>
			<p>
				${message(code:'userregistration.templates.logininfocontent.information.message') }
			</p>
			<br>
			<%--			<div class="mandi-note">--%>
			<%--				<span class="mandi"></span>--%>
			<%--				<p>--%>
			<%--					${message(code:'userregistration.templates.logininfocontent.mandatoryfields.text') }--%>
			<%--				</p>--%>
			<%--			</div>--%>
			<vayana:flowerror />
			<g:form action="userRegistration" controller="userRegistration"
				name="registrationForm">
				<g:hiddenField name="selfImageName" id="selfImageName" />
				<div class="col-550">
					<g:if
						test="${grailsApplication.config.secure.color.required == true}">
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
						<g:hiddenField name="imageType" id="imageType" value="PRE" />
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
								from="${secureImageBaskets}" optionKey="id" optionValue="code"
								onchange=" ${remoteFunction( 
					 						    	controller :'userRegistration',
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

					<g:if
						test="${grailsApplication.config.secure.color.required == true}">

						<div class="fields" id="userDefSecureImageContent">
							<p>
								<fileUpload:uploader id="selfImage" url="secureUpload"
									multiple="false" params="[cif:" ${fcustomerId}"]"/>
							</p>
						</div>
					</g:if>
					<div class="secureimage">
						<div class="carousel module" id="secureImageDiv"></div>
					</div>
					<g:if
						test="${grailsApplication.config.secure.color.required == true}">
						<div class="fields">
							<p>
								<b>2. Choose your secure color from the below</b>
							</p>
						</div>

						<g:render template="/userRegistration/templates/loginsecurecolors" />
					</g:if>
					<div class="fields">
						<p>
							<b>2. Enter Personalized Message</b>
						</p>
					</div>

					<div class="fields">
						<p>

							<label for="ibUserSecureMessage"> ${message(code:'userregistration.templates.logininfocontent.personalizedmessage.label') }

							</label> <input
								placeholder="${message(code:'userregistration.templates.logininfocontent.personalizedmessage.placeholder.text') }"
								data-errormessage="${message(code:'userregistration.templates.logininfocontent.personalizedmessage.error.message') }"
								type="text" name="ibUserSecureMessage" id="ibUserSecureMessage"
								required autocomplete="off" value="${fibUserSecureMessage}"  maxlength="10"/>

						</p>
					</div>
					<div class="fields">
						<p>
							<label><input type="checkbox" name="terms" id="terms"
								required="required"
								data-errormessage="You have to agree the terms and condition to proceed" />
								I agree the above terms and conditions</label>
						</p>
					</div>
					<div class="fields">
						<p>&nbsp;</p>
					</div>

					<div class="buttons">
						<input type="button" id="cancelTxn" value="Cancel"
							name="cancelTxn" class="cancelTxn btn_next"
							onclick="onclickCancel()" />
						<g:submitButton name="usersealinfosubmit"
							onclick="preCheck();preSetParams()"
							value="${message(code:'userregistration.templates.logininfocontent.continue.button.text') }" />
					</div>
				</div>
				<g:if
					test="${grailsApplication.config.secure.color.required == true}">
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
				<!-- col-280 ends here -->
			</g:form>
			<div class="info">
				<p>
					<span></span><strong>Terms and Condition</strong>
				</p>
				<p>Terms and condition</p>
			</div>
		</section>
	</div>

</div>
<script>
function onclickCancel(){
	var link = "<g:createLink action='tenant' controller='index' params='[]'/>"
	postUrl('registrationForm',link,'_self')
}
function postUrl(formName, url, targetName){
	var form = $('#'+formName);  
	form.attr('action',url);
	form.attr('method','POST');
	form.attr('target',targetName);
	form.submit();
}
</script>