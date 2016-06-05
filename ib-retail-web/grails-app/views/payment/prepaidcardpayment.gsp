<html>
	<head>
		<meta name="layout" content="payment"/>
		<parameter name="themeName" value="${params.themeName}" />
	</head>
<body>

<div class="body-scroll">
		<!-- Timeline & form panel Starts Here -->
		
		<section class="t-f-panel">
	   <vayana:messages/>	
		<g:form name="frmPayment">	
			
			<!-- Timeline Starts here -->			
			<g:render template="templates/prepaidcard/prepaidcardpaymentfavourite"/>
			<!-- Timeline Ends here -->
			<!-- Form Starts here -->
			<g:render template="templates/prepaidcard/prepaidcardpayment"/>
			<!-- Form Ends here -->
		</g:form>
		</section>		
</div><!-- End of content -->
<g:javascript>              
function payerVal()                            
				 {
 					   var txt = $("#fromAccountId").val(); 					   			 
 					   return txt; 
				 }
                function payeeVal()                            
				{ 
    				var  txt = $("#payeeId").val() ;
					return txt;
				}				
				
function payeeVal()
{
var payeeId;
var selVal = $("#toAccountId option").each(function()
	{
	    
		var thisVar = $(this);					
		$(thisVar).parents("select").trigger("change");		
		payeeId=$('#toAccountId :selected').val()
		payeeId=payeeId.split(',')		
		payeeId=payeeId[0];
	});		
return payeeId;
}

<%--To trigger balance enquiry if favourite payment exist--%>
<g:if test="${favPaymentDetailModel?.acctBalancePaymentDetail!=null}">
$(document).ready(function ()
{
$("#paymentAmount").val('${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentAmount}');
var selVal = $("#fromAccountId option").each(function()
	{
		var passVal = $(this).val()	;	
		var thisVar = $(this);					
		var favacct=$("#favAccountId").val()
		setAccount(passVal,favacct,thisVar)		
	});		
var currVal = $("#currencyId option").each(function()
	{
		var curVal = $(this).val();
		var thisVar = $(this);			
		var currencyVal='${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentCurrency?.id}';		
		setCurrency(curVal,currencyVal,thisVar)				
	});
var selVal = $("#toAccountId option").each(function()
	{
	    var passVal = $(this).val()	;	
		var thisVar = $(this);					
		var beneaccount='${favPaymentDetailModel?.acctBalancePaymentDetail?.payeeInstruction?.id}';	
		setAccount(passVal,beneaccount,thisVar)		
	
	});
	var remarks='${favPaymentDetailModel?.acctBalancePaymentDetail?.remarks}'
	$('#paymentRemarks').val(remarks);
	
});	
</g:if>
$(document).ready(function ()
{
var selVal = $("#toAccountId option").each(function()
	{
	    
		var thisVar = $(this);					
		$(thisVar).parents("select").trigger("change");		
	
	});
<%--	Below Condition added to prevent balance call triggered more than once if one account exist in from account drop down--%>
	<g:if test="${favPaymentDetailModel?.acctBalancePaymentDetail==null}">
	if($('#fromAccountId option').size()==1)
	var selVal = $("#fromAccountId option").each(function()
	{
	    
		var thisVar = $(this);					
		$(thisVar).parents("select").trigger("change");		
	
	});
	</g:if>
	
	
	
});	
function calculateCharges()
{
	var fromAccountId = $("#fromAccountId").val();
	var toAccountId = $("#toAccountId").val();
	var currencyId = $("#currencyId").val();
	var paymentAmount = $("#paymentAmount").val();
	if(toAccountId!=''  && currencyId!='' && paymentAmount!='')
	{
		<g:remoteFunction controller="common" action="getCharges" update="transactionCharges" onSuccess="getChargesSuccess(data,textStatus)" onFailure="getChargesFailure()"
		params="{'toAccountId':toAccountId,'currencyId':currencyId,'paymentAmount':paymentAmount,'fromAccountId':fromAccountId,'requestClassName':'com.vayana.ib.bm.core.api.beans.transfers.FundTransferRequest'}"/>
	}
}

function getChargesSuccess(data,textStatus)
{
	var transactionCharges =  $(data).first().html();
    $("#transactionCharges").html(transactionCharges);
}

function getChargesFailure()
{
	$("#transactionCharges").empty();
}
function getLimits()
{
var payerId=payerVal();
var payeeId=payeeVal();
}
</g:javascript>
</body>
</html>
