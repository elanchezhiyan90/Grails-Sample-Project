<h2>Add Reminder</h2>
<vayana:popupMessages/><br/>
<div class="remi_panel">
 
 <g:form name="addReminderForm">
       
  	<div class="fields">
		<p>
 				<label for="date">${message(code:'dateline.addreminder.date.label')}</label>
				<input type="date" name="reminderDateTime" id="reminderDateTime" required min="${new Date().format('yyyy-MM-dd')}" data-errormessage="${g.message(code:"dateline.addreminder.date.error.message")}"/>				
		</p>						
	</div>
    
     <div class="fields">
			<p>
  				<label for="reminder_type">${message(code:'dateline.addreminder.remindertype.label')}</label>
				<vayana:iblookupSelect name="reminderCategoryCode" id="reminderCategoryCode" optionKey="code" type="REMINDER_CATEGORY" 
						domain = "base" required="required" data-errormessage="${g.message(code:"dateline.addreminder.remindertype.error.message")}"
						noSelection="['':'select']"
						onchange="${ remoteFunction( 
		 							controller :'reminder',
								    action:'getReminderMetaData', 														  						
								    update:'divReminderMetaData',								 
								  	params:'\'selectedReminderCategory=\'+this.value',onSuccess:'onReminderCategorySuccess(data,textStatus);', onFailure: 'onReminderCategoryFailure();'														
								   )}"						
						/>
			</p>						
		</div>
	
		<div id="divReminderMetaData" >					
		</div>	
		
		<div id="divPayeeInstruction">
		</div>
		<div id="divBeneficiaryInstruction">
		</div>
		<div class="buttons" id="btns_add" style="display: none;">								
				
				<g:submitToRemote controller="reminder"
							name="saveReminder" action="savereminder"
							id="saveReminder"
							value="Save"
							before="if (checkFormValidity()) {return false;}"
							onSuccess="saveresponseData(data,textStatus)"
							onFailure="onSaveFailure(XMLHttpRequest.responseText)"
							></g:submitToRemote>				
								
				<input type="button" id="cancel" value="Cancel" name="cancel" class="cancelForm btn_next">
		</div>
		
		
</g:form>
</div>
<br />
<h4>Previous Reminders</h4><br />
<g:render template="templates/previousreminders"/>
<script>

//mandifunc();

$(function () {

 $(".cancelForm").on("click",function() {
		 $.fn.ceebox.closebox();
	});
});


$(".remi_panel").dynamicfieldupdate();

function onReminderCategorySuccess(){
	$("#divPayeeInstruction").empty();
	$("#divReminderMetaData").dynamicfieldupdate();	
	$("#btns_add").show();
}

function onReminderCategoryFailure(){
	
}

function checkFormValidity()
{
	if(!$("#addReminderForm").checkValidity())
	{
	 	return true;
	}else
	{
	 	return false;
	}
}	

function saveresponseData(data,textStatus){
	$("#btns_add").hide();
	$("#datelinehome",window.parent.document).trigger("click");	
	$.fn.ceebox.closebox();	
}

function onSaveFailure(resp)
 { 
	 $("#popupMessagesDiv").html(resp);
 }
	 
function onPayeeInstructionSuccess(){
	$("#divPayeeInstruction").dynamicfieldupdate();	
	$("#btns_add").show();	
}
function onBeneficiaryInstructionSuccess(){
	$("#divBeneficiaryInstruction").dynamicfieldupdate();	
	$("#btns_add").show();
}


function onReminderCategoryFailure(){
	
}

</script>			    		

