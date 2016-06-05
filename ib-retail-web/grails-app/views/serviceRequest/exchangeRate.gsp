<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
<section class="body-scroll">
<vayana:messages/>
<g:form name="exchangeRateForm" >
<h2>
Exchange Rate
</h2>
<div id="exchangerate">

   <g:render template="templates/exchangeRate"></g:render> 
</div>
 </g:form> 
</section>
</body>