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
		<g:form name="frmbillpayment">		
			<!-- Timeline Starts here -->		
			
			<g:render template="/billPayment/templates/billpaymentfavourite"/>
			<!-- Timeline Ends here -->
			<!-- Form Starts here -->
			<g:render template="/billPayment/templates/billpayment"/>
			<!-- Form Ends here -->
		</g:form>
		</section>		
</div><!-- End of content -->
<g:javascript>

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
		var amountype='${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.paymentScheduleDetail?.billPaymentAmountType?.id}'
		
		
		
	<%--  	<g:if test="${datelineEventRef.equals('SI')}">
		  	<g:if test="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency == null}">
						
							 setTimeout(function () {
								$("#prePayLater").trigger('click');
								}, 5000);
						
			</g:if>
			<g:elseif test="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency != null}">
					$( "#preRepeat" ).trigger( "click" );
			</g:elseif>
		</g:if>
	--%>
	});	
	</g:if>

function closefolder()
{
	parent.$(parent.document).find("a.hstry span").addClass("hide").removeClass("show");
}




</g:javascript>
</body>
</html>
