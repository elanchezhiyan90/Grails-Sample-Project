<!DOCTYPE HTML>
<body>
<div>

<section>
    <h2>Preferences</h2> 
	<vayana:messages/>   
	    <div id="preferences">
		
	                <ul>
						<li><g:link  action="usersettings" controller="userProfile" >${message(code:'userprofile.template.preferences.usersettings.label')}</g:link></li>
						<li><g:link  action="changepassword" controller="UserProfile">${message(code:'userprofile.template.preferences.changepassword.label')}</g:link></li>
						<li><g:link  action="transactionpassword" controller="UserProfile">${message(code:'userprofile.template.preferences.transactionpassword.label')}</g:link></li>
					    <li><g:link  action="changesecureaccess" controller="UserProfile">${message(code:'userprofile.template.preferences.changesecureaccess.label')}</g:link></li>
<%--					    <li><g:link  action="smsalertnotification" controller="UserProfile">${message(code:'userprofile.template.preferences.smsalertnotification.label')}</g:link></li>--%>
<%--	                	<li><g:link  action="setnamesequence" controller="UserProfile" params="[productType: 'A']">${message(code:'userprofile.template.preferences.updatenamesequence.label')}</g:link></li>--%>
	                </ul>
	                               
	    </div>
	

 </section>        
</div>
<script>

$(function () {
$( "#preferences" ).tabs();

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

function onSecureImageSuccess(data,textStatus){
	$("#secureImageDiv").empty().append(data);
	$("#secureImageDiv").carousel({
		itemsPerPage:4,
		itemsPerTransition: 4,
		easing: 'linear',
		noOfRows: 2
	});
}

</script>
</body>