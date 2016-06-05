<g:if test="${billerServiceType?.toString().equals("Postpaid")}">
	<div class="fields" id="payamounttype">
		<p>
			<label for="amount_type"><g:message code="payment.templates.creditcard.creditcardpayment.amounttype.label" /></label>
			<vayana:iblookupSelect name="amount_type" id="amount_type" optionKey="code" type="BILLER_AMOUNT_TYPE" domain = "base" onchange="" required="required" data-errormessage="${g.message(code:"payment.templates.creditcard.creditcardpayment.amounttype.error.message") }" />
		</p>						
	</div>
</g:if>
<div class="fields">
    <p>
        <label for="paymentDate">Payment Date</label> 
        <vayana:vayanaDate id="paymentDate" name="paymentDate" required="required" min="${new Date(new Date().getTime() + (1000 * 60 * 60 * 24)).toTimestamp()}" value="${(configuredPaymentDate)?configuredPaymentDate:''}"/>
    </p>
</div>
<div class="buttons" id="btns_later">
    <vayana:ftValidate name="confirm" buttonEvent="LATER"
				value="${g.message(code:"payment.templates.ownaccount.transfer.paylater.confirm.button.text") }"
				enableButton="btns_later" controller="billPayment"
				action="validatefundtransfer" secondaryAction="paymentPostProcess"
				secondaryController="billPayment" secondaryDiv="f-panel"/>
    <g:submitButton name="cancelLater" value="Cancel" id="cancelLater" class="btn_next" type="button"/>
</div>


<script>
$("#cancelLater").click(function(){	
	$(".flds-block").fadeOut(function(){$(this).empty();$("#prePayLater").removeClass("btn_show").addClass("btn_next");});
	$("#payNow").removeClass("btn_next");
	$("#preRepeat,#payNow").removeAttr('disabled');
	});
</script>