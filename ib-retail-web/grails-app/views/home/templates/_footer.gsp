
<footer class="footwrap">
	<ul class="foot-menu">


		<li><g:remoteLink controller="user" action="terms"
				class="ceebox" 
				title="${message(code:'user.templates.footer.termscondition.text') }">
				${g.message(code:'home.templates.footer.legal.tooltip.text')}
			</g:remoteLink></li>
			
			<li><g:remoteLink controller="user" action="legalDisclaimer"
				class="ceebox"
				title="${g.message(code:'home.templates.footer.legalDis.tooltip.text')}">
				${g.message(code:'home.templates.footer.legalDis.tooltip.text')}
			</g:remoteLink></li>

		<li><g:remoteLink controller="user" action="privacyStatement"
				class="ceebox"
				title="${g.message(code:'home.templates.footer.privacypolicy.tooltip.text')}">
				${g.message(code:'home.templates.footer.privacypolicy.tooltip.text')}
			</g:remoteLink></li>

		<li><g:remoteLink controller="user" action="contact"
		 class="ceebox"
				title="${g.message(code:'home.templates.footer.contact.tooltip.text')}">
				${g.message(code:'home.templates.footer.contact.tooltip.text')}
			</g:remoteLink></li>
			
			</ul>
	<div class="foot_right">
		<p>
			<g:message code="home.templates.footer.lastlogin.label" />
			<vayana:formatDate date='${userProfileModel?.ibUserLoginProfile?.lastSuccessLogin}' showTime="true"/>
			<a href="#"><g:message code="home.templates.footer.details.label" /></a>
		</p>
		<br />
		<p>
			<g:message code="home.templates.footer.copyright.label" />
		</p>
	</div>

<g:javascript>
$(document).ready(function(){
	$(".ceebox").ceebox();	
	if(!Modernizr.touch){
		$("#cee_ajax").find("select" ).combobox();
		$("#cee_ajax").find("form").updatePolyfill();//update polyfill on after ajax load.
	}
});
</g:javascript>

</footer> 

















<%--<footer class="footwrap">

	<ul class="foot-menu">
		<li><a
			title="${g.message(code:'home.templates.footer.privacypolicy.tooltip.text')}"
			href="#"><g:message
					code="home.templates.footer.privacypolicy.label" /></a></li>
		<li><a
			title="${g.message(code:'home.templates.footer.security.tooltip.text')}"
			href="#"><g:message code="home.templates.footer.security.label" /></a>
		</li>
		<li><a
			title="${g.message(code:'home.templates.footer.term&conditions.tooltip.text')}"
			href="#"><g:message
					code="home.templates.footer.term&conditions.label" /></a></li>
		<li><a
			title="${g.message(code:'home.templates.footer.bankpolicies.tooltip.text')}"
			href="#"><g:message
					code="home.templates.footer.bankpolicies.label" /></a></li>
		<li><a
			title="${g.message(code:'home.templates.footer.fairpracticecode.tooltip.text')}"
			href="#"><g:message
					code="home.templates.footer.fairpracticecode.label" /></a></li>
		<li><a
			title="${g.message(code:'home.templates.footer.codecommitment.tooltip.text')}"
			href="#"><g:message
					code="home.templates.footer.codecommitment.label" /></a></li>
		<li><a
			title="${g.message(code:'home.templates.footer.grievanceredressal.tooltip.text')}"
			href="#"><g:message
					code="home.templates.footer.grievanceredressal.label" /></a></li>
		<li><a
			title="${g.message(code:'home.templates.footer.bankingombudsman.tooltip.text')}"
			href="#"><g:message
					code="home.templates.footer.bankingombudsman.label" /></a></li>
		<li><a
			title="${g.message(code:'home.templates.footer.centralbank.tooltip.text')}"
			href="#"><g:message
					code="home.templates.footer.centralbank.label" /></a></li>
	</ul>
	<div class="foot_right">
		<p>
			<g:message code="home.templates.footer.lastlogin.label" />
			<vayana:formatDate date='${userProfileModel?.ibUserLoginProfile?.lastSuccessLogin}' showTime="true"/>
			<a href="#"><g:message code="home.templates.footer.details.label" /></a>
		</p>
		<br />
		<p>
			<g:message code="home.templates.footer.copyright.label" />
		</p>
	</div>
</footer>
--%>