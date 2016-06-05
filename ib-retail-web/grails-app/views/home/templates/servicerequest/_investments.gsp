
<h3>
	<a href="#"><g:message
			code="home.templates.servicerequest.investment.h3.text" /></a>
</h3>
<ul class="bene-mnu">
	<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'FORE_CLOSURE_DETAIL',userActionLabel:'VIEW')}">
		<li><vayana:postableradio controller="serviceRequest"
				action="serviceRequestStatus"
				urlParams="[tenantServiceCode:'FORECLS']" target="canvas"
				linkTitle="${g.message(code:'home.templates.servicerequest.investment.viewdetails.tooltip.text')}"></vayana:postableradio>
			<vayana:postablelink controller="serviceRequest"
				action="serviceRequestMetaData"
				urlParams="[tenantServiceCode:'FORECLS']" target="canvas"
				linkClass="lnk"
				linkTitle="${g.message(code:'home.templates.servicerequest.investment.foreclosure.tooltip.text')}">
				<g:message
					code="home.templates.servicerequest.investment.foreclosure.label" />
			</vayana:postablelink></li>
	</vayana:fap>
	<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'DEPOSIT_ACCOUNT_MANAGEMENT_DETAIL',userActionLabel:'VIEW')}">
		<li><vayana:postableradio controller="serviceRequest"
				action="serviceRequestStatus"
				urlParams="[tenantServiceCode:'DEPACCMNG']" target="canvas"
				linkTitle="${g.message(code:'home.templates.servicerequest.investment.viewdetails.tooltip.text')}"></vayana:postableradio>
			<vayana:postablelink controller="serviceRequest"
				action="serviceRequestMetaData"
				urlParams="[tenantServiceCode:'DEPACCMNG']" target="canvas"
				linkClass="lnk"
				linkTitle="${g.message(code:'home.templates.servicerequest.investment.depositaccountmanagement.tooltip.text')}">
				<g:message
					code="home.templates.servicerequest.investment.depositaccountmanagement.label" />
			</vayana:postablelink></li>
	</vayana:fap>
	
	<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'ADD_INVESTMENT',userActionLabel:'VIEW')}">
		<li>
			<vayana:postablelink controller="investment"
				action="addDepositAccount"    
				 target="canvas"
				linkClass="lnk"
				linkTitle="Add Deposit Account">
		Add New Deposit
			</vayana:postablelink></li>
	</vayana:fap>

</ul>
