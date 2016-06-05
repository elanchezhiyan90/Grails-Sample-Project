

<div class="content">
	<div class="content-wrap">
		<section class="app-section">
		<div class="login_page">		
		
		
		
		<div>
		
		   <g:form name="registerForm">
			<h2>${message(code:'user.templates.content.h2.text') }</h2>
<%--			<h4>${message(code:'user.templates.content.h4.text') }</h4>--%>
			<br/>
			
<%--			<vayana:postablelink  controller="userRegistration" action="userRegistration" linkClass="enrol_btn" linkTitle="${message(code:'user.templates.content.clicktoregister.tooltip.text') }" id="register" formName="registerForm" target="_self">${message(code:'user.templates.content.clicktoregister.text')}</vayana:postablelink>--%>
			</g:form>
			
			</div>    
		
			
<%--			<h2>${message(code:'user.templates.securesingin.h2.text') }</h2>--%>
			
			<div>
			<g:form name="registerForm">
				<p>
					${message(code:'user.templates.content.existinguserinfo.message') }<vayana:postablelink  controller="userRegistration" action="userRegistration" linkClass="cancel" linkTitle="${message(code:'user.templates.content.clicktoregister.tooltip.text') }" id="register" formName="registerForm" target="_self">${message(code:'user.templates.content.clickhere.text')}</vayana:postablelink>				
					</p>
			</g:form>
			</div>
			
			<div class="login_panel col-370">
			
			<div class="mandi-note">
				<span class="mandi"></span>
				<p>${message(code:'user.templates.content.mandatoryfields.text') }</p>
			</div>
			
			<vayana:messages />
			
<%--			<div id =forgetUserName>--%>
<%--			<g:form name="forgetUserNameForm">  --%>
<%--			${message(code:'user.templates.content.forgetusername.message') }<vayana:postablelink  controller="user" action="forgetUserName" linkClass="cancel" linkTitle="${message(code:'user.templates.content.clickhere.tooltip.text') }" id="forgetUserLoginName" formName="forgetUserNameForm" target="_self">${message(code:'user.templates.content.clickhere.text')}</vayana:postablelink>--%>
<%--			</g:form>--%>
<%--			</div>--%>
			<form  name="loginForm" id="loginForm" autocomplete='off' action="/ib-retail-web/j_spring_security_filter" method="post">
				
					<div class="fields">
						<p>
							<label for="login">${message(code:'user.templates.content.loginid.label')}</label> 
							<input type="text" tabindex="1"
								name="login" id="login" value="" pattern="[a-zA-Z0-9]+"
								placeholder="${message(code:'user.templates.content.loginid.placeholder') }" required="required"
								data-errormessage="${message(code:'user.templates.content.loginid.error.message') }" autocomplete="off"
								autofocus />
						</p>
					</div>
					<div id="preLogin" class="buttons">
						<g:submitToRemote id="preLoginSubmit" name="preLoginSubmit"
							value="Continue" url="[action:'preloginIntermediate']" update="[failure:'messagesDiv']"
							before="if (checkFormValidity()) {return false;};"
							onSuccess="loadSuccess(data,textStatus);"
							onFailure="loadFailure(XMLHttpRequest.responseText);" />
					</div>
					<div id="loginDiv">
						
					</div>
					<g:hiddenField name="groupId" value="40000"/>
					<g:hiddenField name="tenantShortDescription" value="PMCB"/>
					<g:hiddenField name="tenantApplicationId" value="50000"/>
					<g:render template="/user/templates/vkeyboard"/>
				
				
			</form>
			</div>
			
			<div class="banner_section">
			
			<h1 class="banner_caption">Punjab & Maharashtra Co-operative Bank</h1>
			<div class="banner_img"></div>
			</div>
	</div>
		</section>
	</div>
</div>
