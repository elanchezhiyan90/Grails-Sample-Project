<!DOCTYPE HTML>
<body>
<div class="body-scroll">

<section>
    <h2>Apply for home loan</h2>
    <vayana:messages />
<g:form name="customerUserForm" >
    <div id="loan">
 
                <ul>
					<li><g:link  action="propertydetails" controller="applyLoan">Property Details</g:link></li>
					<li><g:link  action="incomedetails" controller="applyLoan">Income Details</g:link></li>
					<li><g:link  action="transactionpassword" controller="applyLoan">Loan Eligibility</g:link></li>
				    <li><g:link  action="changesecureaccess" controller="applyLoan">Application Status</g:link></li>
                </ul>
                               
    </div>
</g:form>

 </section>        
</div>
<script><%--<%--

$(function () {

 
//   $( "#preferences" ).tabs();
   
      $( "#preferences" ).tabs({
   show: function(event, ui) {},
   fx: { height: 'toggle', opacity: 'toggle'}
});
   

   
});	
--%>



$(function () {
$( "#loan" ).tabs();

   $( ".salarycredits" ).buttonset(); 
   $( ".chequebounce" ).buttonset(); 
   $( ".emidue" ).buttonset(); 
   $( ".debitcardswipe" ).buttonset();          
   $( ".dailyaccbal" ).buttonset(); 
   $( ".transactionfailure" ).buttonset(); 
   $( ".billpayreminder" ).buttonset(); 
   $( ".sipayreminder" ).buttonset();          
   $( ".depositmaturingalert" ).buttonset(); 
   $( ".emioverduealert" ).buttonset(); 
   $( ".belowbalancealert" ).buttonset(); 
   
   $( ".preferredmode" ).buttonset(); 
 
   $( "#tabs" ).tabs({
   show: function(event, ui) {reinitialiseScrollPane();},
   fx: { height: 'toggle', opacity: 'toggle'}
});
	
});		


</script>
