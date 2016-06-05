<g:submitToRemote value="${value}" id="${name}" name="${name}"
	class="${classStyle}" 
	before="if (checkFormValidity('${formName}')) {return false;};emptyErrorDiv();catchButtonEvent('${buttonEvent}')"
	after="disableForm()"
	action="${action}" controller="${controller}"
	update="${secondaryDiv}"
	onSuccess="onServiceSucess(data,textStatus);enableForm();"
	onFailure="onServiceFailure(XMLHttpRequest.responseText,'${displayAsPopUp}');enableForm();" />

<g:hiddenField name="displayAsPopUp" value="${displayAsPopUp}"/>