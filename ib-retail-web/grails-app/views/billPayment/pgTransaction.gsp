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
					
		<%--${pgRequestMap?.dump()}--%>
	<g:render template="/billPayment/templates/pg/payment"/>
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
$(document).ready(function ()
{
if($('#fromAccountId option').size()==1)
	var selVal = $("#fromAccountId option").each(function()
	{
	    
		var thisVar = $(this);					
		$(thisVar).parents("select").trigger("change");		
	
	});
});	

function onExecuteSuccess(data,textStatus){
	$("#dynamicAuthContent").dynamicfieldupdate();
	$("#gotoApplication").show();	
}

function payerVal()                            
{
	var txt = $("#fromAccountId").val(); 	
	return txt; 
 }

function billerInstructionVal()                            
{ 
	var payeeId= $("#toAccountId").val();
	payeeId=payeeId.split(',')		
	payeeId=payeeId[0];
	return payeeId;
}

function unlockForm(){	
	$("form").find("input, select ").removeAttr("disabled");
}

function onAuthSuccess(data,textStatus) 
 {     
	 $("#dynamicAuthContent").dynamicfieldupdate();
	 //postUrl('frmPgPayment','/ib-retail-web/billPayment/cancelPGTransaction','_self');		
 }

</g:javascript>
</body>
</html>