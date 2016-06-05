<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'userregistration.templates.secretinfocontent.h2.text') }
			</h2>
			<p>
				${message(code:'userregistration.templates.secretinfocontent.information.label') }
			</p>
			<br>
<%--			<div class="mandi-note">--%>
<%--				<span class="mandi"></span>--%>
<%--				<p>--%>
<%--					${message(code:'userregistration.templates.secretinfocontent.mandatoryfields.text') }--%>
<%--				</p>--%>
<%--			</div>--%>
			<h3>
				${message(code:'userregistration.templates.secretinfocontent.h3.text') }
			</h3>
			<vayana:flowerror />
			<g:form action="userRegistration" controller="userRegistration" name="registrationForm">

				<div class="col-550">
					<g:each in="${userSelfRegistrationResponseModel?.questionBasket}"
						var="questionBasket">
						<div class="fields">
							<p>

								<g:select name="ibUserSecretQuestionId"
									id="ibUserSecretQuestionId" required="true"
									from="${questionBasket.questionBasketDetails.question}"
									optionKey="id" optionValue="description"
									data-errormessage="Please select secret question" />

								<br /> <br /> <br /> <input type="text"
									name=ibUserSecretAnswer id="ibUserSecretAnswer"
									placeholder="${message(code:'userregistration.templates.secretinfocontent.secretanswer.placeholder.text') }"
									autocomplete="off" autofocus required="required" 
									data-errormessage="Please enter secret answer" />

							</p>

						</div>
					</g:each>
					<%--<div class="fields">
						<p>
							<label for="agree"><input type="checkbox" id="agree"
								required data-errormessage="Please accept the bank policy"
								class="agree" />&nbsp;&nbsp;${message(code:'userregistration.templates.secretinfocontent.bankagree.label') }
								<li><g:remoteLink controller="user" action="terms"
										class="ceebox"
										title="${message(code:'userregistration.templates.secretinfocontent.termsconditions.text') }">
										${message(code:'userregistration.templates.secretinfocontent.termsconditions.text') }
									</g:remoteLink></li>
						</p>
					</div>
					--%>
					<div class="buttons">
 					<input type="button" id="cancelTxn" value="Cancel" name="cancelTxn" class="cancelTxn btn_next" onclick="onclickCancel()"/>
					<g:submitButton name="usersecretinfosubmit"
							value="${message(code:'userregistration.templates.logininfocontent.continue.button.text') }" 
							onclick="preCheck()"/>
					</div>
					
				</div>
				<!-- col-280 ends here -->
			</g:form>

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