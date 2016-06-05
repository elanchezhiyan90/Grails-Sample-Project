<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<div class="body-scroll">
		<section class="col-480">
			<vayana:messages />
				<h2>
					<g:message code="beneficiary.addbeneficiary.h2.text" />
				</h2>
				<g:form name="from" id="from">
					<div id="firstDiv">
						<div class="fields">
							<label><g:message code="beneficiary.main.label" /></label>
							<vayana:postableradio formName="from" controller="beneficiary"
								id="quickPay" name="quickPay" action="loadQuickPay"
								target="canvas"></vayana:postableradio>
							<label for="quickPay"><g:message code="beneficiary.quickpay.label" /></label>
							<vayana:postableradio formName="from" controller="beneficiary"
								id="addFriend" name="addFriend" action="addBeneMain"
								target="canvas"></vayana:postableradio>
							<label for="addFriend">Add a Payee</label> 
						</div>
					</div>
				</g:form>
		</section>
	</div>
	<g:javascript>
$(document).ready(function(){
	$("#firstDiv").buttonset();
 });
</g:javascript>

</body>