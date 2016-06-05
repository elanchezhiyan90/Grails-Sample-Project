<html>
	<head>
		<meta name="layout" content="gateway"/>		
		<parameter name="themeName" value="${params.themeName}" />
		</head>
<body >
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">Logo</a></h1>
  </div> 
</header>

<div class="content">
<vayana:messages/>
<g:form name="frmPgPayment">
<section class="app-section" id="app-section">		
		<h1 style="margin-left:20px;">
         <p style="margin-left:20px;width:80%">
             <g:message code="pg.user.login.validation.error" />
         </p>
         </h1>
</section>
</g:form>
</div>
<footer class="footwrap">
	<div class="foot_right">
		<p>
			<g:message code="home.templates.footer.copyright.label" />
		</p>
	</div>
</footer>
<g:javascript>

</g:javascript>
</body>
</html>


