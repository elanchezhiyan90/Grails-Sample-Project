<!doctype html>
<html>
	<head>
		<title>${message(code:'errors.deverror.title')}</title>
		<meta name="layout" content="errorlayout">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
	</head>
	<body>
		Error ${responseModel?.dump()}
	</body>
</html>