<html>
<head>
<meta name="layout" content="tenant" />
</head>
<body  >
<div class="fields">
<p>
	${message(code:'user.invalidsession.invalidsession.message') }
	<g:link controller="tenant">${message(code:'user.invalidsession.loginagain.text') }</g:link>
	</p>
	</div>
	<g:hiddenField name="sessionvalidity" value="false" />
</body>
</html>
<g:javascript>
$(document).ready(function(){


	if(parent.location.href!=location.href) {top.location.href=location.href;}
});

</g:javascript>