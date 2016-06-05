<!DOCTYPE HTML>
<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />

</head>
<body>


<section>   
    <h2>Apply for home loan</h2>
  <vayana:messages />
 <%-- <g:form name="customerUserForm">
        --%><div class="body-scroll">
    	<div class="applyloan">
 
				<ul>
                	<li><a href="#propertyDetails"><g:message code="applyforloan.template.propertydetails.label"/></a></li>
                	<li><a href="#incomeDetails"><g:message code="applyforloan.template.incomedetails.label"/></a></li>
                	<li><a href="#loaneligibility"><g:message code="applyforloan.template.loaneligiblity.label"/></a></li>
                	<li><a href="#applicationStatus"><g:message code="applyforloan.template.applicationstatus.label"/></a></li>
                </ul>
                
               <g:render template="templates/propertydetails"/>	
                <g:render template="templates/incomedetails"/>	
           	      	           
		           <g:render template="templates/loaneligibility"/>	
		           <g:render template="templates/loanapplicationstatus"/>	           

                               
    	</div>
    	</div>
<%--</g:form>

 --%></section>        


<g:javascript>


 $(document).ready(function ()
		{			
		
	
		/* For enabling/ disabling tabs on Forms */
		$(".applyloan").tabs( { disabled: [1,2,3] });
		
		
		  
		   
		   $( "#datepicker" ).datepicker();
		   
		   
		   
		   $( "#amount" ).slider({
		   
		   range: "max",
      min: 1,
      max: 1000000,
      value: 100,
		slide: function( event, ui ) {
			$( "#amount_val" ).val(ui.value );
			showpay();
		}
	});
	$("#amount_val" ).val($("#amount").slider( "value" ));



	$( "#interest" ).slider({
	slide: function( event, ui ) {
	$( "#interest_val" ).val(ui.value );
	showpay();
	}
	});
	$("#interest_val" ).val($("#interest").slider( "value" ));



	
	$( "#time" ).slider({
	slide: function( event, ui ) {
	$( "#time_val" ).val(ui.value );
	showpay();
	}
	});
	$("#time_val" ).val($("#amount").slider( "value" ));


	/****************** sticky grid header *********************/
	 $(window).scroll(sticky_relocate_top);
	 //sticky_relocate_top();
		   
        });	
        
        
        
        
        


</g:javascript>
</body>
</html>
