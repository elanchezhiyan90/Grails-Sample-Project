<html>
	<head>
		<meta name="layout" content="payment" />
		<parameter name="themeName" value="${params.themeName}" />		
	</head>
	<body>
		<div class="body-scroll">
			<!-- Timeline & form panel Starts Here -->
			<section>
				<vayana:messages />				
					<g:form name="frmPayment">
						<g:if test="${datelineEventRef.equals('SME')}">
							<g:render template="templates/smeBulkPayment/authReviewFileContent" />
						</g:if>
					<g:else>
						<g:render template="templates/smeBulkPayment/payment" />					
							<div id="pendingTransactionList">
								<g:render template="templates/smeBulkPayment/reviewHeaderList" />
							</div>
					</g:else>					
					</g:form>
			</section>
		</div>
		<!-- End of content -->
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
	<g:if test="${datelineEventRef.equals('SI')}">
		<g:if test="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency == null}">
			$("#prePayLater" ).trigger( "click" );
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
<%--		$("#currencyId").next(".ui-combobox").find("input").attr('disabled',true);--%>
			<%--		lockForm();--%>
	</g:if>
	
	$("#currencyId").change(function()
	{ 
		var selectedVal = $(this).val();
		$("#currencyId option").each(function()
		{
			if($(this).val() == selectedVal)
			{
				$(this).attr("selected", "selected").siblings('option').removeAttr('selected');
			}
		});	
	});
});	  

function lockForm()
{
	$("form").find("input, select ").attr("disabled", true);
	$("#btns_paynow").find("input, select ").removeAttr("disabled");
}

function unlockForm()
{	
	$("form").find("input, select ").removeAttr("disabled");
}

function calculateCharges()
{
	var fromAccountId = $("#fromAccountId").val();
	var toAccountId = $("#toAccountId").val();
	var currencyId = $("#currencyId").val();
	var paymentAmount = $("#paymentAmount").val();
	if(toAccountId!=''  && currencyId!='' && paymentAmount!='')
	{
		<g:remoteFunction controller="common" action="getCharges"
			update="transactionCharges"
			onSuccess="getChargesSuccess(data,textStatus)"
			onFailure="getChargesFailure()"
			params="{'toAccountId':toAccountId,'currencyId':currencyId,'paymentAmount':paymentAmount,'fromAccountId':fromAccountId,'requestClassName':'com.vayana.ib.bm.core.api.beans.transfers.FundTransferRequest'}" />
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

function emptyDropDown(param)
{				
	if(param==""||param=="ALL")
	{
		return true;
	}
	else
	{
		return false;
	}
}

function onDraftSuccess(data,textStatus)
{
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
function deleteRecord(id,refTag){
		
		var x = "Are you sure you want to take this action";
			
		    $('<div>' + x + '</div>').dialog({
		        resizable: false,
		        height:140,
		        title:"Confirm Delete?",
		        position:['middle',200],
		        draggable: false,
		        modal:true,
		        buttons: {
		            "Yes": function() {						            	
		                $(this).dialog("close");		       
		                <vayana:deleteFunction controller="payment" action="discardBulkPaymentTransaction" params="\'pendingTransactionId=\'+id+\'&referenceTag=\'+refTag" update="pendingTransactionList" onSuccess="onDiscardSuccess(data,textStatus)" />					                
		            },
		            Cancel: function() {
		                $(this).dialog("close"); //close confirmation
		            }
		        }
		    
		});
}
function onDiscardSuccess(data,textStatus){
	$("#pendingTransactionList").dynamicfieldupdate();
}
function checkFormValidity()
{
	//alert('1');
	if(!$('form').checkValidity())
	{
		return true;
	}else
	{
		return false;
	}
}

</g:javascript>
</body>
</html>