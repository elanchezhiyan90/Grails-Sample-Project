<html>
	<head>
		<meta name="layout" content="payment"/>
		<parameter name="themeName" value="${params.themeName}" />
	</head>
<body>
<div class="body-scroll">
		<!-- Timeline & form panel Starts Here -->
		<section class="t-f-panel">
			<!-- Timeline Starts here -->
			  <vayana:messages/>	
			 <g:form name="frmPayment">
				 <g:if test="${datelineEventRef.equals('SME')}"> <!-- SME Auth Confirmation -->
					<g:render template="templates/common/paymentAuthConfirm"/>
				</g:if>
				<g:else>
					<g:render template="/payment/templates/friendsandfamily/transferfavourite"/>			
					<!-- Form Starts here -->
					<g:render template="/payment/templates/friendsandfamily/transfer"/>	
					<!-- Form Ends here -->
				</g:else>
		</g:form>
		</section>		
<br/><br/><br/>		
</div>
<%--To trigger balance enquiry if favourite payment exist--%>
<g:if test="${favPaymentDetailModel?.acctBalancePaymentDetail!=null}">
	<g:javascript>
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
		<g:if test="${datelineEventRef.equals('SI')}">
	  	<g:if test="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency == null}">
					$( "#prePayLater" ).trigger( "click" );
	</g:if>
	<g:elseif test="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency != null}">
			$( "#preRepeat" ).trigger( "click" );
	</g:elseif>
	</g:if>
	});
	</g:javascript>
</g:if>	
<g:javascript>				
function getPayeeVal()
{
var payeeId;
payeeId= $("#toAccountId").val(); 
payeeId=payeeId.split(',')		
payeeId=payeeId[0];
return payeeId;
} 
$(document).ready(function ()
	{
		if($("#toAccountId option").length==1)
		{
			var selVal = $("#toAccountId option").each(function()
			{
			    
				var thisVar = $(this);					
				$(thisVar).parents("select").trigger("change");		
			
			});
		}
		
		$("#currencyId").change(function(){ 
			var selectedVal = $(this).val();
			$("#currencyId option").each(function(){
				if($(this).val() == selectedVal){
					$(this).attr("selected", "selected").siblings('option').removeAttr('selected');
				}
			});	
		});
	});
</g:javascript>
<%--	Below Condition added to prevent balance call triggered more than once if one account exist in from account drop down--%>
<g:if test="${favPaymentDetailModel?.acctBalancePaymentDetail==null}">
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
		
	</g:javascript>
</g:if>
<g:javascript>
function unlockForm(){	
	$("form").find("input, select ").removeAttr("disabled");
}
function lockForm(){
	$("form").find("input, select ").attr("disabled", true);
	$("#btns_paynow").find("input, select ").removeAttr("disabled");
}
function onDraftSuccess(data,textStatus){
	$("#btns_paynow").dynamicfieldupdate();
}
function onDraftFailure(responseText)
{
	$("#messagesDiv").empty();
	$("#messagesDiv").append(responseText);
}
function closefolder()
{
	parent.$(parent.document).find("a.hstry span").addClass("hide").removeClass("show");
}

function onFailure(responseText)
{
	$("#messagesDiv").empty();
	$("#messagesDiv").append(responseText);
	$("#preRepeat,#payNow,#prePayLater").attr('disabled','disabled');

}
$( "#toAccountId" ).change(function() {
$("#preRepeat,#payNow,#prePayLater").removeAttr('disabled');
});
</g:javascript>
</body>
</html>
