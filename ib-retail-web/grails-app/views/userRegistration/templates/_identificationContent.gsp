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
			<vayana:flowerror/>
			<g:form action="userRegistration" controller="userRegistration"
				name="registrationForm">
				<div class="col-450">
					<div class="fields">
						<p>
							<label for="customerId"> ${message(code:'userregistration.userregistration.userverification.cpr.text') }
							</label> <input type="text" name="customerId" id="customerId"
								placeholder="${message(code:'userregistration.templates.verificationcontent.customerid.placeholder.text') }"
								pattern="[0-9]*" maxlength="12"
								data-errormessage="${message(code:'userregistration.templates.verificationcontent.customerid.error.message') }"
								autocomplete="off" autofocus="off" required="required"
								value="" />
						</p>
					</div>
					</div>
					<div class="buttons">
						 <input type="button" id="cancelTxn" value="Cancel" name="cancelTxn" class="cancelTxn btn_next" onclick="onclickCancel()"/>
						<g:submitButton name="userIdentificationSubmit"
							value="${message(code:'userregistration.templates.verificationcontent.continue.button.text') }" 
							/>
					</div>
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