		<div class="fields">
				<p>
					<label for="start_dte"> <g:message code="payment.templates.ownaccount.transfer.startdate.label" /></label>
					<vayana:vayanaDate id="startDate" name="startDate"  min="${(confStartDate) ? confStartDate.toTimestamp()?.format('yyyy-MM-dd') : new Date(new Date().getTime() + (1000 * 60 * 60 * 24)).toTimestamp()?.format('yyyy-MM-dd')}" value="${(confStartDate) ? confStartDate.toTimestamp() :''}" required="required" />
				</p>

		</div>
		<div class="fields">
				<p>
					<label for="frequency"><g:message code="payment.templates.ownaccount.transfer.frequency.label" /></label>
					<vayana:tenantLookupSelect name="frequency" type="SI_FREQUENCY_TYPE" id="frequency"  optionValue="description" value="${(confFrequency) ? confFrequency : 'MON'}" required="required"></vayana:tenantLookupSelect>
				</p>

			</div>
		<div class="fields">
				<p>
					<label for="no_times"><g:message code="payment.templates.ownaccount.transfer.numberoftimes.label" /></label> 
						<vayana:tenantLookupSelect 
						name="noOfTimes" type="NO_OF_TIMES" id="noOfTimes"
						required="required" data-errormessage="Please select value"></vayana:tenantLookupSelect>
				</p>
		</div>
		
		<div class="buttons" id="btns_repeat">
								
				<vayana:ftValidate name="confirm" buttonEvent="REPEAT"
									value="${g.message(code:"payment.templates.ownaccount.transfer.repeat.confirm.button.text") }"
									enableButton="btns_later" controller="investment"
									action="validateOpenNewDeposit" secondaryAction="openNewDepositConfirm"
									secondaryController="investment" secondaryDiv="f-panel"/>
							<input type="button" name="cancelRepeat" value="Cancel" id="cancelRepeat" class="btn_next" />
		</div>
							
<script>
$(function(){
	var test = $("#startDate").val();
	if(test!=null && test != ""){
		$("#endDate").removeAttr('disabled');
	}
	$("#startDate").change(function(){
		var value =  $(this).val();
		if(value != null && value != ""){
			$("#endDate").removeAttr('disabled');
		}else{
			$("#endDate").val('');
			$("#endDate").attr('disabled','true');
		}
	});
});
$("#confirm").click(function(){	 
	if (checkFormValidity())
		{
			return false;
		}
	$("#prePayLater,#preRepeat,#payNow").attr('disabled','disabled');
	$("#confirm,#cancelRepeat").attr('disabled','disabled')
});
$("#cancelRepeat").click(function(){	
	$(".flds-block").fadeOut(function(){$(this).empty();$("#preRepeat").removeClass("btn_show").addClass("btn_next");});
	$("#payNow").removeClass("btn_next");
	$("#prePayLater,#payNow").removeAttr('disabled');
	});
</script>							