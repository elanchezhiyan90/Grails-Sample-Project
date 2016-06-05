<g:form name="alertsMainContentForm">
<h2>${message(code:'userprofile.template.smsalerts.h2.text')}</h2>
<div class="fields" id="alertsMainContent">  
						<p>
							<label for="fromAccount">${message(code:'userprofile.template.smsalerts.accountnumber.label') }</label>
							<vayana:fromAccountSelect id="accountNumber"
								name="accountNumber" poptype="CASA" required="required" optionKey="accountNumber" 
								data-errormessage="${message(code:'servicerequest.template.smsalerts.error.message') }" />
						</p>	
		<div class="fields">    
			<p>
				<label for="primaryPhoneNumber"><g:message code="userprofile.template.profile.mobilenumber.label"/></label>
				<g:textField name="primaryPhoneNumber" id="primaryPhoneNumber" required="required"
					value=" ${userProfileResponseModel?.ibUserLoginProfile?.userContactDetail?.contact?.primaryMobileNumber}"/>   
			</p>
	   </div>
	   <br/>
	   <br/>
	   <div id="displaysmsalerts">
	   
	   </div>
		
			<div class="buttons" id="button">				
						<vayana:submitToRemote value="${message(code:'userprofile.template.changesecureaccess.submit.button.text')}"
						   action="displaysmsalerts" controller="userProfile"
						   id="verifySubmit" name="verifySubmit"						
						   before="if (checkFormValidity()) {return false;}"
						  update="[failure:'messagesDiv',success:'displaysmsalerts']"        
						   onSuccess="updateFormData(data,textStatus)"
						/>
	
			</div>				
								
</div>
</g:form>
<script>
 $(document).ready(function () {
       $("#alertsMainContent").dynamicfieldupdate();
	});
function updateFormData(data,textStatus){
 $("#button").hide();
}
$( "#accountNumber" ).change(function() {
	$("#button").show();
	$("#displaysmsalerts").empty();
});
function checkFormValidity()
		{
		
			if(!$("#alertsMainContentForm").checkValidity())
		 	{
			 	return true;
		 	}else
		 	{
			 	return false;
		 	}
	 	}
</script>