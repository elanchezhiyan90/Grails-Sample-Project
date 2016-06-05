<!doctype html>
<html>
<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
<div class="body-scroll">
 <h2>Demat Application</h2>
<section>   
  <vayana:messages/>
   

  <g:form name="dematForm">
        
<div id="dynamicAuthContent">
						<vayana:securitysetting controller="security" displayAsPopUp="NO"
							action="fetchSecurityAdviceForAService" successAction="demat"
							successController="demat" targetService="DEMAT" 
							formName="dematForm" value="Click here to generate OTP" />

					
						
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
					</div>
					
			


</g:form>
</section>        

</div>

<g:javascript>
$(document).ready(function(){ 
});
function onDematSuccess(data,textStatus){

	$("#dematapp").dynamicfieldupdate();
}
function onDraftFailure(responseText)
{
	$("#messagesDiv").empty();
	$("#messagesDiv").append(responseText);
}
</g:javascript>
</body>
</html>
