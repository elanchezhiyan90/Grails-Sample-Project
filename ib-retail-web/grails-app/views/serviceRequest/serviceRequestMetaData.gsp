<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
<section class="body-scroll">
<vayana:messages/>
<g:form name="serviceRequestForm">
<h2>
${genericSRModel?.serviceRequestMetaDatas?.tenantService?.serviceApplication?.service?.description.get(0)}
</h2>
<div id="servicepanel">

   <g:render template="templates/metadata"></g:render> 
</div>
 </g:form> 
</section>

<g:javascript>
$(document).ready(function () {
var termsAndConditionsDialog = $("#termsAndConditionsDialog").dialog({
	autoOpen : false,
	modal : true,
	resizable : false,
	width : 600,
	close : function() {
		$(this).dialog("close");
	}
});

$("#branchpickup input").on("change",function()
{
	
		if( $(this).is(":checked")){
			
			var opt=$(this).val();
			if(opt=="YES")
			{
				$("#continue").attr('disabled','disabled')

			}
		}
		
});


$("#servicepanel").dynamicfieldupdate();

	$("#ChequeRangeDiv1").hide();
	$("#ChequeRangeDiv2").hide();
	$("#ChequeRangeDiv1Txt").val("0");
	$("#ChequeRangeDiv2Txt").val("0");
    $('.dataLabels').each(function() {
      var forButtonset = $(this).attr('id');      
      $("#"+forButtonset).buttonset();    	  
	});

	$('input').each(function(){
	var formFieldId=$(this).attr('id');
	var nullable = $("#"+formFieldId).data('nullable');	
		if(nullable=='N')
		{	
			$("#"+formFieldId).attr("required",true);
			 $("#formMainContent").dynamicfieldupdate();
		}
	});
	
	
	 $('input:radio').click(function() {
       		var formFieldId=$(this).attr('id');      
     		 $('input:text').each(function(){
      			if(formFieldId=='YES')
      			{
      	  			var formField=$(this).attr('id');
	      			var textLabel=$("#"+formField).data('text')
	      			if(textLabel=='Person Name'){
	       				$("#"+formField).attr("value",$("#customerName").val());
	       			}
      			}else if(formFieldId=='NO'){
      				var formField=$(this).attr('id');
      				$("#"+formField).attr("value",'');
      			}   
	      	 });
     });
	
	
	$('.dataLabels').each(function() {
    	var forButtonset = $(this).attr('id');      
    	$("#"+forButtonset).buttonset();    	  
	});
	
});
	function catchButtonEvent(buttonName)
	{	
		$("#buttonEvent").val(buttonName);
	}
	
	$("#continue").click(function(){
		if (checkFormValidity("serviceRequestForm")) {
			return false;
		}
		$("#continue").attr('disabled','disabled');
	});
	   
	</g:javascript>     
</body>