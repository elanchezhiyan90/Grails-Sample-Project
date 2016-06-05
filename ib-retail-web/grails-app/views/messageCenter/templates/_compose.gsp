<g:form name="frmComposeMessage">
<section>
<h4>Send a Message</h4>
<div class="fields">
	<p>
		<label for="subjectId">${g.message(code:'msgcenter.subject.label')}</label>
		<vayana:messageSubject name="subjectId" id="subjectId" tenantlookupcode="MESSAGE_SUBJECT" required="required" maxlength="35" data-errormessage="${g.message(code:"msgcenter.subject.error.message") }"/>
	</p>	
</div>

<div class="fields" id="displayMessageSubject">
	<p>
		<label for="messageSubject">${g.message(code:'msgcenter.messageSubject.label')}</label>
		<g:textField name="messageSubject" id="messageSubject" maxlength="35"/>
	</p>
</div>

<div class="fields">
	<p>
		<label for="messageBody">${g.message(code:'msgcenter.body.label')}</label>
		<g:textArea class="ckeditor" name="messageBody" rows="5" cols="100" required="required"  data-errormessage="${g.message(code:"msgcenter.body.error.message")}" />
	</p>
	<%-- <ckeditor:config/>
	<ckeditor:editor name="composeBox"/>--%>
</div>

<div class="fields">
			<p>		
	               <g:submitToRemote controller="messageCenter" name="saveAsDraft" action="saveAsDraft" update="messagesDiv" id="saveAsDraft"
	               onSuccess="onDraftSuccess(data,textStatus)" onFailure="onDraftFailure()" value="${g.message(code:'msgcenter.button.saveAsDraft')}" 
	               before="if (checkFormValidity()) {return false;}"/>
	               
	               <g:submitToRemote class="" controller="messageCenter" name="sendMessage" action="sendMessage" 
	               update="[failure:'messagesDiv']" id="sendMessage"
	               onSuccess="onSendSuccess(data,textStatus)"
	               value="${g.message(code:'msgcenter.button.send')}" 
	               before="if (checkFormValidity()) {return false;}"/>
	               
	               <input type="button" id="cancel" value="${g.message(code:'msgcenter.button.cancel')}" name="cancel" class="cancelForm btn_next"/>       
			</p>
    </div>
</section>
</g:form>
<script>

$(document).ready(function() {

	$(".pd_btns").hide();
	
	$(".fields").dynamicfieldupdate();
	
	$(".cancelForm").click(function(){
		$("#inboxsubmit").trigger("click");		
	});

	//On Page Load hide Message Subject 
	$("#displayMessageSubject").hide();
	
	$("#subjectId").change(function(){
		if($("#subjectId option:selected").text() == 'Others')
		{
			$("#displayMessageSubject").show();
		}
		else
		{
			$("#messageSubject").val("");
			$("#displayMessageSubject").hide();
		}
	});

	
	if (CKEDITOR.instances['messageBody']) {
           delete CKEDITOR.instances['messageBody'];
           CKEDITOR.remove('messageBody');
    }
   
   CKEDITOR.replace( 'messageBody', {
		toolbar: [																			
		{ name: 'basicstyles', items: ['Bold', 'Italic', '-', 'NumberedList', 'BulletedList'] }
		],
		//uiColor : '#0579b3',
		resize_enabled: false,
		height: 200,
        width: 600
	});
	
});

function onSendSuccess(data,textStatus)
{
	$("#messageBody").val('');
	$("#inboxsubmit").trigger("click");
}

function checkFormValidity()
{
	if (CKEDITOR.instances['messageBody']) {
		for(var instanceName in CKEDITOR.instances)
		{
			CKEDITOR.instances[instanceName].updateElement();
		}
	}
	
	if(!$('form').checkValidity())
	{
	return true;
	}else
	{
	return false;
	}

}

</script>