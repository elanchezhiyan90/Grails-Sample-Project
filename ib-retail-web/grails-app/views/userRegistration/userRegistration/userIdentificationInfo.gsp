<head>
	<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">${message(code:'userregistration.userregistration.userverification.h1.text')}</a></h1>
  </div>
</header>
<!--  . 
<vayana:flowerror/>
-->

<g:if test="${!errorModel}">
 	<g:render template="/userRegistration/templates/identificationContent"/>
 </g:if> 
 <g:elseif test="${"BM-10001".equals(errorModel?.errorCode)}">
 	<g:render template="/userRegistration/templates/existingUserWarningInfo"/> 
 </g:elseif>
 <g:elseif test="${"BM-90007".equals(errorModel?.errorCode)}">
 	<g:render template="/userRegistration/templates/userBlockedFromRegistration"/> 
 </g:elseif>
  <g:else>
 	<g:render template="/userRegistration/templates/invalidIdentityWarningInfo"/> 
 </g:else>
 <g:render template="/user/templates/footer"/>
 
</body>
</html>
