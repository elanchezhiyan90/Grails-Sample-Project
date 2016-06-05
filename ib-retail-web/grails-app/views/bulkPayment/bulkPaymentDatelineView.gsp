<html>
	<head>
		<meta name="layout" content="payment" />
		<parameter name="themeName" value="${params.themeName}" />		
	</head>
	<body>
		<div class="body-scroll">
			<!-- Timeline & form panel Starts Here -->
			<section>
				<vayana:messages />				
					
							<g:form name="bulkPayDatelineView">
								<g:render template="templates/smeBulkPayment/bulkPaymentDatelineView" />
							</g:form>	
			</section>
		</div>
		<!-- End of content -->
<g:javascript>

</g:javascript>
</body>
</html>