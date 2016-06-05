<g:submitToRemote action="${action}" controller="${controller}"
							update="dynamicAuthContent"
							before="if (checkFormValidity('${formName}')) {return false;};emptyErrorDiv();emptyConfirmDiv();"
							after="disableForm()"
							onSuccess="onAuthSuccess(data,textStatus);enableForm();"
							onFailure="onAuthFailure(XMLHttpRequest.responseText,'${displayAsPopUp}');enableForm();"
							name="tranXConfirm"
							value="${(value)? value: g.message(code:"payment.templates.friendsandfamily.transfer.paynow.confirm.button.text") }"
							id="tranXConfirm" />
							
			<g:hiddenField name="successController" value="${successController}"/>
			<g:hiddenField name="successAction" value="${successAction}"/>
			<g:hiddenField name="serviceCode" value="${targetService}"/>
			<g:hiddenField name="isdraft" value="false"/>
			<g:hiddenField name="displayAsPopUp" value="${displayAsPopUp}"/>
			
			
		