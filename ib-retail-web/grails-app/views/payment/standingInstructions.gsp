<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<div class="body-scroll">
		<section>
			<h2>
				Standing Instructions
			</h2>
			<vayana:messages />
			<br />
			<div id="standingInstructionsList">
				<g:render template="/payment/templates/standingInstruction/standingInstructionList"></g:render>
			</div>

		</section>
	</div>
</body>
