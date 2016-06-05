<h3>
	<a href="#"><g:message
			code="home.templates.servicerequest.others.h3.text" /></a>
</h3>
<ul class="bene-mnu">
		<li><vayana:postableradio controller="serviceRequest"
				action="serviceRequestStatus"
				urlParams="[tenantServiceCode:'UFTI']" target="canvas"
				linkTitle="${g.message(code:'home.templates.servicerequest.others.viewdetails.tooltip.text')}"></vayana:postableradio>
			<vayana:postablelink controller="serviceRequest"
				action="serviceRequestMetaData"
				urlParams="[tenantServiceCode:'UFTI']" target="canvas"
				linkClass="lnk"
				linkTitle="${g.message(code:'home.templates.servicerequest.others.userinstruction.tooltip.text')}">
				<g:message
					code="home.templates.servicerequest.others.userinstruction.label" />
			</vayana:postablelink></li>
			<li>
			<vayana:postablelink controller="serviceRequest"
				action="getBranchDisplay"
			    target="canvas"
				linkClass="lnk"
				linkTitle="${g.message(code:'home.templates.servicerequest.others.branchdiplay.tooltip.text')}">
				<g:message
					code="home.templates.servicerequest.others.branchdiplay.label" />
			</vayana:postablelink></li>
			
			<li>
			<vayana:postablelink controller="serviceRequest"
				action="getExchangerate"
				target="canvas"
				linkClass="lnk"
				linkTitle="${g.message(code:'home.templates.servicerequest.others.exchangerate.tooltip.text')}">
				<g:message
					code="home.templates.servicerequest.others.exchangerate.label" />
			</vayana:postablelink></li>
</ul>
