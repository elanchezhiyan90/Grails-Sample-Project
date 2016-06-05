<head>
<meta name="layout" content="payment" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<div class="body-scroll">
		<section class="col-480">
			<vayana:messages />
			<h2>
				<g:message code="beneficiary.quickpay.label" />
			</h2>
			<div>
				<g:render template="/beneficiary/templates/quickPay/quickPayMainTemplate"/>
			</div>
		</section>
	</div>
<g:javascript>
</g:javascript>
</body>
