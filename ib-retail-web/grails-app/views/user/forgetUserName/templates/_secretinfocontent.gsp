<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'forgetusername.templates.secretinfocontent.h2.text') }
			</h2>
			<p>
				${message(code:'userregistration.templates.secretinfocontent.information.label') }
			</p>
			<br>
			<%--<div class="mandi-note">
				<span class="mandi"></span>
				<p>
					${message(code:'userregistration.templates.secretinfocontent.mandatoryfields.text') }
				</p>
			</div>
			--%><h3>
				${message(code:'userregistration.templates.secretinfocontent.h3.text') }
			</h3>
			<vayana:flowerror />
			<g:form action="forgetUserName" controller="user" name="registrationForm">
				<div class="col-550">
					<vayana:secretQuestions ulpId="${forgetUserNameResponseModel?.ibUserLoginProfile?.id}"/>
					<vayana:secureImages ulpId="${forgetUserNameResponseModel?.ibUserLoginProfile?.id}"/>  
					<g:hiddenField name="ibUserLoginProfileId" id="ibUserLoginProfileId" value="${forgetUserNameResponseModel?.ibUserLoginProfile?.id}"/>
					<g:render template="/user/forgetUserName/templates/loginsecurecolors"/>		
					<div class="buttons">
 						<input type="button" id="cancelTxn" value="cancel" name="cancelTxn" class="cancelTxn btn_next" onclick="onclickCancel()"/>
						<g:submitButton name="usersealinfosubmit" onclick="preCheck()"
							value="${message(code:'userregistration.templates.logininfocontent.continue.button.text') }" />
					</div>
				</div>
			
			</g:form>

		</section>  
	</div>

</div>

<g:javascript>
$('.carousel').carousel({
	itemsPerPage:4,
	itemsPerTransition: 4,
	easing: 'linear',
	noOfRows: 2
});
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
</g:javascript>

