<!doctype html>
<html>
	<head>
		<title>${message(code:'errors.deverror.title')}</title>
		<meta name="layout" content="applayout">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
	</head>
	<body>
		<g:renderException exception="${exception}" />
		<g:hasErrors>
			<div class="failure">
				<span></span>
				<g:eachError var="err" bean="${errors}">
					<li><g:message error="${err}" /></li>
				</g:eachError>
			</div>
		</g:hasErrors>
		<g:if test="${errorCode}">
			<div class="${messageType}">
				<span></span>
				<g:message code="${errorCode}" args="${args}" />
			</div>
		</g:if>
	</body>
</html>