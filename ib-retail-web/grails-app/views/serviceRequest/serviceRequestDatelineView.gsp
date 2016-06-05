<head>
<meta name="layout" content="payment" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
<div class="body-scroll">
	<section class="t-f-panel">
				<vayana:messages/>  
				<br/>
				<g:form name="serviceRequestConfirm">
					<g:render template="templates/serviceRequestAuthConfirm" />
				</g:form>
		</section>		
	</div>	
	


<g:javascript>
$(document).ready(function () {

}	   
	</g:javascript>     
</body>