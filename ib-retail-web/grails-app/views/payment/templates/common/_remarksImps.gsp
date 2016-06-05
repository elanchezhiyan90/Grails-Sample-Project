<div class="fields">
	<p>
		<label for="rmrk">Remarks</label> 
		<textarea rows="1" cols="30" title="Enter Comments" id="comments" name="comments" required></textarea>
	</p>
</div>
<div id="dynamicAuthContents">
	<vayana:securitysetting controller="security" value="Confirm"
			action="fetchSecurityAdviceForAImpsService" successAction="${successAction}"
			successController="payment" targetService="${serviceCode}" formName="frmPayment" displayAsPopUp="NO"/>
	<input type="button" name="cancelRemarks" value="Cancel"
		id="cancelRemarks" class="btn_next" />
</div>
<script>
$("#cancelRemarks").click(function(){	
	//$(".flds-block").fadeOut(function(){$(this).empty();$("#prePayLater").removeClass("btn_show").addClass("btn_next");});
	//$("#payNow").removeClass("btn_next");
	$("#approve,#reject").removeClass("btn_show");
	$("#dynamicContent").css("display","none");
	$("#approve,#reject").removeAttr('disabled');
	$("#dynamicContent").empty();
	});
	
function onAuthFailure(responseText)
 {
	 $("#dynamicAuthContents").dynamicfieldupdate();
	 $("#messagesDiv").empty();
	 $("#messagesDiv").append(responseText);
	 $("#messagesDiv").dynamicfieldupdate();
	 $("#approve,#reject").attr('disabled','disabled');
	 
 }
</script>