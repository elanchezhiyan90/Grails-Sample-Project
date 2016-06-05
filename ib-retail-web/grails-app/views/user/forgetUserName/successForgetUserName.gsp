<head>
	<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">${message(code:'forgetusername.forgetusername.userverification.h1.text ') }</a></h1>
  </div>
</header>
<br/>
<br/>
 	<g:render template="/user/forgetUserName/templates/successUserName"/> 
<br/>
<br/>
<%-- <g:elseif test="${"BM-10001".equals(errorModel?.errorCode)}">--%>
<%-- 	<g:render template="/userRegistration/templates/existingUserWarningInfo"/> --%>
<%-- </g:elseif>--%>
 <g:render template="/user/templates/footer"/>
</body>
</html>
