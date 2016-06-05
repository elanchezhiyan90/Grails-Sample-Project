
<head>
		<meta name="layout" content="payment"/>
		<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
<div class="body-scroll">
		<!-- Timeline & form panel Starts Here -->
		<section class="t-f-panel">
			<!-- Timeline Starts here -->
<vayana:messages/>	

      
		<div class="f-panel" id="ftpanel">
				
         <g:render template="templates/openDeposit/openNewDeposit"></g:render> 
</div>

</section>
</div>
</body>
<g:javascript>
	
function unlockForm(){	
	$("form").find("input, select ").removeAttr("disabled");
}
function lockForm(){
	$("form").find("input, select ").attr("disabled", true);
	$("#btns_paynow").find("input, select ").removeAttr("disabled");
}


</g:javascript>

