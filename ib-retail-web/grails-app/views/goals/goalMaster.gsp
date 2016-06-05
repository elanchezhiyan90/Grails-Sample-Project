<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<section>
		<h2>
			Goals 
				
				<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'NEW_GOAL_REQUEST',userActionLabel:'ADD')}" >
			<g:remoteLink controller="goal" action="addNewGoal" 
						 class="add ceebox" title="Add New Goal"/>
						 	</vayana:fap>
		</h2>
		
		<div class="info">
		<span></span>
		<p>"one person can save for many goals .. Use targeted saving and split your money into several different targets each of which is named for a specific savings goal .. Create your targeted account and start saving"</p>
		</div>
			<span></span>
		<vayana:messages/>
		<g:form name="customerUserForm">
			<div id="displayGoalTemplates">
				<g:render template="/goals/templates/goalList"></g:render>

			</div>
		</g:form>
	</section>
<g:javascript>
$(document).ready(function(){
	$(".ceebox").ceebox();	
	if(!Modernizr.touch){
		$("#cee_ajax").find("select" ).combobox();
		$("#cee_ajax").find("form").updatePolyfill();//update polyfill on after ajax load.
	}
});

function updateIcon(data,textStatus){
		var eid;	
		$('.inststatus').each(function(){
				if($(this).is(":checked")){						
						$(this).button({label: "Enabled", text: false,icons: {primary: "ui-icon-check"}})							
				}
				else {
					$(this).button({label: "Disabled",text: false,icons: {primary: "ui-icon-power"}})					
				}
	});
}
function checkFormValidity()
{
	if(!$('form').checkValidity())
	{
		return true;
	}else
	{
		return false;
	}
}	
</g:javascript>
</body>
