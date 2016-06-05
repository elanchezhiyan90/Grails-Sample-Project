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
						
			<!-- <g:render template="templates/creditcard/creditcardbalancetransferfavourite"/> -->
			
			<!-- Form Starts here -->
			<g:render template="templates/creditcard/ccardbalancetransfer"/>
			<!-- Form Ends here -->
		</g:form>
		</section>
</div><!-- End of content -->

<g:javascript>

function getTransferEvwnt(){
	return "CCExcessTransfer";
}

function payeeVal()
{
	var payeeId="";	
	payeeId= $("#toAccountId").val(); 
	payeeId=payeeId.split(',')		
	payeeId=payeeId[0];
	return payeeId;
}

<%--To trigger balance enquiry if favourite payment exist--%> 
<g:if test="${favPaymentDetailModel?.acctBalancePaymentDetail!=null}">
$(document).ready(function ()
{

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
		//alert(currencyVal);	
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

	// Amount Type CC Payments	
	var amtType = '${favPaymentDetailModel?.acctBalancePaymentDetail?.creditCardAmountType?.code}';
		var amtTypeVal = $("#amount_type option").each(function()
		{
			var passVal = $(this).val();
			var thisVar = $(this);	
			if(amtType == passVal)
			{
			setAmountType(passVal,amtType,thisVar)		
			}	
		});
	$("#paymentAmount").val('${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentAmount}');
	<g:if test="${datelineEventRef.equals('SI')}">
	<g:if test="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency == null}">
					$( "#prePayLater" ).trigger( "click" );
	</g:if>
	<g:elseif test="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency != null}">
			$( "#preRepeat" ).trigger( "click" );
	</g:elseif>
	</g:if>
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
	
	<g:if test="${datelineEventRef.equals('SI')}">
		$("#toAccountId").next(".ui-combobox").find("input").attr('disabled',true);
	</g:if>
		
		$("#currencyId").change(function(){ 
		var selectedVal = $(this).val();
		$("#currencyId option").each(function(){
			if($(this).val() == selectedVal){
				$(this).attr("selected", "selected").siblings('option').removeAttr('selected');
			}
		});	
	});
});	

function lockForm(){
	$("form").find("input, select ").attr("disabled", true);
	$("#btns_paynow").find("input, select ").removeAttr("disabled");
}

function unlockForm(){	
	$("form").find("input, select ").removeAttr("disabled");
}
function setAmount(obj){
   if(obj.value=='FA'){
    $("#paymentAmount").val($("#fullDueAmount").val());                  
    $('#paymentAmount').attr('readonly', false);
     }else if(obj.value=='MA'){
      $("#paymentAmount").val($("#minimumDueAmount").val());
       $('#paymentAmount').attr('readonly', false);
     }else{
      $("#paymentAmount").val('');
      $('#paymentAmount').attr('readonly', false);
      }                   
 }
 
 function setAmountType(passVal,amtType,thisVar)
{
		//passVal=passVal.split(',');
		//alert(amtType+'-----'+passVal);
		if(amtType == passVal)
		{							
			$(thisVar).attr("selected","selected").siblings('option').removeAttr('selected');
			var sel=$(thisVar).val(passVal).text();
			$(thisVar).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(sel);
			$(thisVar).parents("select").trigger("change");			
		}
		$("#amount_type").dynamicfieldupdate();
}
function closefolder()
{
	parent.$(parent.document).find("a.hstry span").addClass("hide").removeClass("show");
} 


</g:javascript>
</body>
</html>