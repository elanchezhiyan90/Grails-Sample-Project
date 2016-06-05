<g:submitToRemote value="${value}" id="${name}" name="${name}"
	class="${classStyle}" before="if (checkFormValidity()) {return false;};unlockForm();catchButtonEvent('${buttonEvent}')"
	action="${action}" controller="${controller}"
	onSuccess="onValidateSuccess(data,textStatus,'${enableButton}');
				${remoteFunction(
					action:"${secondaryAction}",
					controller:"${secondaryController}",
					update:"${secondaryDiv}",
					onSuccess: 'onFTValidateSucess(data,textStatus);',
					onFailure: 'onFTValidateFailure(XMLHttpRequest.responseText);') }"
	onFailure="onError(XMLHttpRequest.responseText);" />

