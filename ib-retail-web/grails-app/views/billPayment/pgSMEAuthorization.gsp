<html>
	<head>
		<meta name="layout" content="payment" />
		<parameter name="themeName" value="${params.themeName}" />
	</head>
	<body>
		<div class="body-scroll">
			<!-- Timeline & form panel Starts Here -->
			<section class="t-f-panel">
				<vayana:messages />
				<g:form name="frmPayment">
					<!-- Form Starts here -->
						<!-- SME Auth Confirmation -->
						<g:render template="/billPayment/templates/pg/pgSMEWorkFlowView" />
				</g:form>
			</section>
		</div>
		<!-- End of content -->
<g:javascript> 
</g:javascript>
</body>
</html>
  