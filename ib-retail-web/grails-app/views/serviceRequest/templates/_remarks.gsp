<div class="fields">
	<p>
		<label for="rmrk">Remarks</label> 
		<textarea rows="1" cols="30" title="Enter Comments" id="comments" name="comments" required></textarea>
	</p>
</div>

         <div id="dynamicAuthContent">
									<vayana:securitysetting controller="security" value="Confirm" 
										action="fetchSecurityAdviceForAServiceRequest" successAction="${successAction}"
										successController="serviceRequest" targetService="${serviceCode}" formName="serviceRequestConfirm" displayAsPopUp="NO"/>
									
									<input type="button" name="cancelRemarks" value="Cancel" id="cancelRemarks" class="btn_next" />
			
			 </div>

<script>
$("#cancelRemarks").click(function(){	
	
	$("#approve,#reject").removeClass("btn_show");
	$("#dynamicContent").css("display","none");
	$("#approve,#reject").removeAttr('disabled');
	$("#dynamicContent").empty();
	});
	
function onAuthFailure(responseText)
 {
	 $("#dynamicAuthContent").dynamicfieldupdate();
	 $("#messagesDiv").empty();
	 $("#messagesDiv").append(responseText);
	 $("#messagesDiv").dynamicfieldupdate();
 }
</script>