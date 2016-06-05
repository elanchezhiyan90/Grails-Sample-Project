<div class="fields">
    <p>
        <label for="startDate">Start Date</label>      
        <vayana:vayanaDate id="startDate" name="startDate" errormessage="Please Enter The Valid Date" required="required" min="${new Date(new Date().getTime() + (1000 * 60 * 60 * 24)).toTimestamp()?.format('yyyy-MM-dd')}" />    	
    </p>
</div>
<div class="buttons" id="btns_later">

 
    <vayana:ftValidate name="confirm" buttonEvent="LATER"
				value="Confirm"
				enableButton="btns_later" controller="investment"
				action="validateOpenNewDeposit" secondaryAction="openNewDepositConfirm"
				secondaryController="investment" secondaryDiv="f-panel"/>
 
 <g:submitButton name="cancelLater" value="Cancel" id="cancelLater" class="btn_next" type="button"/>  
</div>


<script>
$("#confirm").click(function(){	
	if (checkFormValidity())
		{
			return false;
		}
	$("#prePayLater,#preRepeat,#payNow").attr('disabled','disabled');
	$("#confirm,#cancelLater").attr('disabled','disabled')
});
$("#cancelLater").click(function(){	
	$(".flds-block").fadeOut(function(){$(this).empty();$("#prePayLater").removeClass("btn_show").addClass("btn_next");});
	$("#payNow").removeClass("btn_next");
	$("#preRepeat,#payNow").removeAttr('disabled');
	});
</script>