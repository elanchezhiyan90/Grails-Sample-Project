<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'forgetusername.templates.verificationcontent.h2.text') }			</h2>
			<p>
				${message(code:'forgetusername.templates.verificationcontent.information.label') }
			</p>
			<br>
			<vayana:flowerror/>
			<g:form action="forgetUserName" controller="user"
				name="registrationForm">    
				<div class="col-450">

					<div class="fields">
						<p>
							<label for="customerId"> ${message(code:'forgetusername.forgetusername.userverification.cpr.text') }
							</label> <input type="text" name="customerId" id="customerId"
								placeholder="${message(code:'forgetusername.templates.verificationcontent.customerid.placeholder.text') }"
								pattern="[0-9]*"
								data-errormessage="${message(code:'forgetusername.templates.verificationcontent.customerid.error.message') }"
								autocomplete="off" autofocus="off" required="required"
								value="" />
						</p>

					</div>
					</div>
					<div class="buttons">
						 <input type="button" id="cancelTxn" value="cancel" name="cancelTxn" class="cancelTxn btn_next" onclick="onclickCancel()"/>
						<g:submitButton name="userIdentificationSubmit"
							value="${message(code:'forgetusername.templates.verificationcontent.continue.button.text') }" 
							/>
					</div>
			</g:form>
		</section>
	</div>

</div>
<script>

function onclickCancel(){
	var link = "<g:createLink action='user' controller='index' params='[]'/>"
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