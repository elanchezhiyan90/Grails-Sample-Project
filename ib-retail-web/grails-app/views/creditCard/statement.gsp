<head>
<title>Demo Bank</title>
<meta name="layout" content="applayout"/>
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
<div class="body-scroll">
 <section>               
        <h2> Card No ${params.cardNumber}</h2>
        <vayana:messages></vayana:messages>
		<div id="tabs">
            <ul>
                <li><g:link action="currentstatement" controller="creditCard" params="[accountId:params.accountId,currencyCode:params.currencyCode , filter:'BILL']">Mini Statement</g:link></li>
                <li><g:link action="currentstatement" controller="creditCard" params="[accountId:params.accountId ,currencyCode:params.currencyCode , filter:'UNBILL']">Unbilled Transactions</g:link></li>
                <li><g:link action="currentstatement" controller="creditCard" params="[accountId:params.accountId ,currencyCode:params.currencyCode , filter:'PEN']">Hold Of Funds</g:link></li>
            </ul>
		</div>
      	<div id="disputebox" title="Mark Dispute" style="display:none;">
            <form id="disputeform" method="post">
                <fieldset class="ui-helper-reset">
                    <label for="dispdtl">Enter Detail</label>
                    <textarea name="dispdtl" id="dispdtl" cols="" rows=""  class="ui-widget-content ui-corner-all"  required></textarea>
                </fieldset>
            </form>
        </div>
   </section>
</div> 
<g:javascript>
$(document).ready(function(){
	$( "#tabs" ).tabs({
		 beforeActivate: function( event, ui ) {
			 ui.oldPanel.empty();
		 },		  
		   show: function(event, ui) {reinitialiseScrollPane();},
		   fx: { height: 'toggle', opacity: 'toggle'}
		});
		
});
          
	
	
function clearFields(){	
	
	if ($(monthFilter).val() != "") {	
		$("#referenceNumberFilter").val('');
		$("#fromDate").val('');
		$("#uptoDate").val('');
		$("#debitCreditFilter").val('');
		$("#fromAmountFilter").val('');
		$("#toAmountFilter").val('');
		$("#lastNTransactionFilter").val('');
			    
	}
}
</g:javascript>      
</body>
