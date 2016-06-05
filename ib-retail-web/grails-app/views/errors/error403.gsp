<!doctype html>
<html>
	<head>
		<title>${message(code:'errors.error403.title')}</title>
		<meta name="layout" content="errorlayout">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
	</head>
	<body>
		${message(code:'errors.error403.error.message')}
		<g:renderException exception="${exception}" />
	</body>
</html>