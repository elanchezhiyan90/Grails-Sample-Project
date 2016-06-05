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

<%--<!doctype html>
<html>
	<head>
		<title>${message(code:'errors.error500.title')}</title>
		<meta name="layout" content="errorlayout">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
	</head>
	<body>
		<h1 style="margin-left:20px;color:#006dba;" >
            ${message(code:'errors.error500.unexpected.error.message')}             <br/>
            ${message(code:'errors.error500.tryagain.error.message')} 
              <a href="mailto:ibsupport@pmcbank.com?
              subject= [${GrailsUtil.environment}]  ${message(code:'errors.error500.application.error.message')}  '${exception?.message?.encodeAsHTML()}'">
              ${message(code:'errors.error500.contact.error.message')}
              </a> ${message(code:'errors.error500.itteam.error.message')}

      	</h1>
	</body>
</html>--%>