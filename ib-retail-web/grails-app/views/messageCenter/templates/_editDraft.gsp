<g:form name="editDraft">
<section>
<div class="col-280">

<g:if test="${messageCenterResponse?.message?.subjectId}">

<div class="fields">
	<p>
		<label for="subjectId">${g.message(code:'msgcenter.subject.label')}</label>
		<vayana:messageSubject name="subjectId" id="subjectId" tenantlookupcode="MESSAGE_SUBJECT" required="required" 
		data-errormessage="${g.message(code:"msgcenter.subject.error.message") }"
		value="${messageCenterResponse?.message?.subjectId?.idVersion}"
		/>
	</p>	
</div>
</g:if>

<g:if test="${messageCenterResponse?.message?.messageSubject}">
<div class="fields" id="displayMessageSubject">
	<p>
		<label for="code">${g.message(code:'msgcenter.messageSubject.label')}</label>
		<g:textField name="messageSubject" id="messageSubject" required="required" value="${messageCenterResponse?.message?.messageSubject}" readonly="readonly"/>
	</p>
</div>
</g:if>

<div class="fields">
	<p>
		<label for="messageBody">${g.message(code:'msgcenter.body.label')}</label>
		<g:textArea class="ckeditor" name="messageBody" rows="5" cols="100" required="required" data-errormessage="${g.message(code:"msgcenter.body.error.message")}" 
		value="${messageCenterResponse?.message?.messageText}"
		/>
	</p>
	<%-- <ckeditor:config/>
	<ckeditor:editor name="composeBox"/>--%>
</div>
</div>
<div class="fields">
			<p>		
	               <g:submitToRemote controller="messageCenter" name="saveAsDraft" action="saveAsDraft" update="" id="saveAsDraft"
	               onSuccess="onDraftSuccess(data,textStatus)" onFailure="onDraftFailure()" value="${g.message(code:'msgcenter.button.saveAsDraft')}" 
	               before="if (checkFormValidity()) {return false;}" />
	               
	               <g:submitToRemote class="btn_next" controller="messageCenter" name="sendMessage" action="sendMessage" update="" id="sendMessage"
	               onSuccess="onSendSuccess(data,textStatus)" onFailure="onSendFailure()" value="${g.message(code:'msgcenter.button.send')}" 
	               before="if (checkFormValidity()) {return false;}"/>
	               
	               <input type="button" id="cancel" value="${g.message(code:'msgcenter.button.cancel')}" name="cancel" class="cancelForm btn_next">
	               
	               <g:hiddenField name="messageThreadId" value="${messageCenterResponse?.message?.messageThread?.idVersion}"/>
	               <g:hiddenField name="messageId" value="${messageCenterResponse?.message?.idVersion}"/>
			</p>
</div>
</section>
</g:form>
<p>&nbsp;</p>

<script>

$(document).ready(function(){
	// Hide the Back to Inbox and REPLY Buttons
	$("#reply").hide();

	$(".cancelForm").click(function(){
		$("#inboxsubmit").trigger("click");		
	});

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

function onDraftSuccess(data,textStatus)
{
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
	}
	else
	{
		return false;
	}
}
</script>