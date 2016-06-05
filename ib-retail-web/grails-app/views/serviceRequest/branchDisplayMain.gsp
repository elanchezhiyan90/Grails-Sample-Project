<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
<section class="body-scroll">
<vayana:messages/>
<g:form name="branchdisplayForm" >
<h2>
Branch Display
</h2>
<div id="branchdisplay">

   <g:render template="templates/branchDisplay"></g:render> 
</div>
 </g:form> 
</section>
</body>