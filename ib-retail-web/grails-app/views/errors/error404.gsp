<!doctype html>
<html>
	<head>
		<title>${message(code:'errors.error404.title')}</title>
		<meta name="layout" content="errorlayout">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
	</head>
	<body>
	     <h1 style="margin-left:20px;">
         <p style="margin-left:20px;width:80%">
            ${message(code:'errors.error404.pagerequest.error.message')}
         </p>
         </h1>
	</body>
</html>