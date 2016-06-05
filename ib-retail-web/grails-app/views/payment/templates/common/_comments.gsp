<div class="fields">
	<p>
		<label for="comments">Comments</label>
		<textarea rows="1" cols="30" title="Enter Comments" id="comments" name="comments" required ></textarea>
	</p>
</div>

<div class="buttons" id="btns_auth">
    <vayana:ftValidate name="confirm" buttonEvent="APPROVE"
				value="APPROVE"
				enableButton="btns_approve" controller="payment"
				action="validatefundtransfer" secondaryAction="paymentPostProcess"
				secondaryController="payment" secondaryDiv="f-panel"/>
    <g:submitButton name="cancelAuth" value="Cancel" id="cancelAuth" class="btn_next" type="button"/>
</div>
<script>
$("#cancelAuth").click(function(){	
	$(".flds-block").fadeOut(function(){$(this).empty();$("#prePayLater").removeClass("btn_show").addClass("btn_next");});
	$("#payNow").removeClass("btn_next");
	$("#preRepeat,#payNow").removeAttr('disabled');
	});
</script>