
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
			${message(code:'user.templates.footer.copyrights.text') }
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
            <li>
            <a title="Privacy Policy " href="#">${message(code:'user.templates.footer.privacypolicy.text') } </a>
            </li>
            <li>
            <a title="Security" href="#">${message(code:'user.templates.footer.security.text') }</a>
            </li>
            <li>
            <a title="Terms & Conditions" href="#">${message(code:'user.templates.footer.termscondition.text') }</a>
            </li>
            <li>
            <a title="Bank Policies" href="#">${message(code:'user.templates.footer.bankpolicies.text') }</a>
            </li>
            <li>
            <a title="Fair Lending Practice Code" href="#">${message(code:'user.templates.footer.fairlendingpracticecode.text') }</a>
            </li>
            <li>
            <a title="Code of Commitment" href="#">${message(code:'user.templates.footer.codeofcommitment.text') }</a>
            </li>
            <li>
            <a title="Grievance Redressal" href="#">${message(code:'user.templates.footer.grievanceredressal.text') }</a>
            </li>
            <li>
            <a title="Banking Ombudsman" href="#">${message(code:'user.templates.footer.bankingombudsman.text') }</a>
            </li>
            <li>
            <a title="Central Bank" href="#">${message(code:'user.templates.footer.centralbank.text') }</a>
            </li>
        </ul>
   		<div class="foot_right"> 
        	<p>${message(code:'user.templates.footer.copyrights.text') }</p>
        </div>
</footer> --%>