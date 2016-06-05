<html>
<head>
<meta name="layout" content="tenant" />
</head>
<body class="nonapp">
<div class="fields">
<p>
	${message(code:'user.thankyou.logout.success.message') }
	<g:link controller="tenant">${message(code:'user.thankyou.loginagain.text') }</g:link>
	</p>
	</div>
	<div class="fields">
	<p>
	${message(code:'user.thankyou.logout.security.message') }
	</p>
	</div>	
</body>
</html>