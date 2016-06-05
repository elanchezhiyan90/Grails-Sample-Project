<%--<%@ page trimDirectiveWhitespaces="true" %>--%>
<div class="fields">
	<p>
		<label for="rmrk">Reason/Remarks</label> 
<%--		<textarea rows="1" cols="30" title="Enter Comments" id="comments" name="comments" spellcheck="true"   required></textarea>--%>
		<input type="text" id="comments" name="comments" spellcheck="true" size="30" pattern="^[a-zA-Z0-9_]+( [a-zA-Z0-9_]+)*$" placeholder="Enter Comments" required="required">
		
	</p>
</div>
<br/>
<br/>
<div id="dynamicAuthContents">
	<vayana:securitysetting controller="security" value="Confirm"
			action="fetchSecurityAdviceForAService" successAction="${successAction}"
			successController="billPayment" targetService="${serviceCode}" formName="frmPayment" displayAsPopUp="NO"/>
	<input type="button" name="cancelRemarks" value="Cancel"
		id="cancelRemarks" class="btn_next" />
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
	 $("#dynamicAuthContents").dynamicfieldupdate();
	 $("#messagesDiv").empty();
	 $("#messagesDiv").append(responseText);
	 $("#messagesDiv").dynamicfieldupdate();
	 $("#approve,#reject").attr('disabled','disabled');
	 
 }
</script>