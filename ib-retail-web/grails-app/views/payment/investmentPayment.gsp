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
			<g:render template="templates/investment/investmentpaymentfavourite"/>
			<!-- Timeline Ends here -->
			<!-- Form Starts here -->
			<g:render template="templates/investment/investmentpayment"/>
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
</g:javascript>
</body>
</html>