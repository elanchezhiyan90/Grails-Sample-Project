<%--<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"--%>
<%--	value="${g.message(code:"payment.templates.ownaccount.transfer.paynow.button.text") }"--%>
<%--	enableButton="btns_now" controller="payment"--%>
<%--	action="validatefundtransfer" secondaryAction="paymentPostProcess"--%>
<%--	secondaryController="payment" secondaryDiv="f-panel" />--%>
<g:if test="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency == null}">
<g:submitToRemote action="payLaterPreConfirm" controller="payment"
	name="prePayLater" id="prePayLater" update="dynamicContent"
	value="${g.message(code:'payment.templates.ownaccount.transfer.paylater.button.text') }"
	onSuccess="onPreTransSuccess(data,textStatus)"
	onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
	before="if (checkFormValidity()) {return false;};unlockForm();"
	class="btn_next" />
</g:if>
<g:elseif test="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency != null}">
<g:submitToRemote action="repeatPreConfirm" controller="payment"
				name="preRepeat" id="preRepeat" 
				update="dynamicContent"
				value="${g.message(code:"payment.templates.ownaccount.transfer.repeat.button.text") }"
				onSuccess="onPreTransSuccess(data,textStatus)" 
				onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
				before="if (checkFormValidity()) {return false;};unlockForm();"
				class="btn_next"/>
</g:elseif>
<%--<vayana:ftValidate name="cancel" buttonEvent="CANCELPAYMENT"--%>
<%--	value="Cancel Payment" enableButton="btns_cancelpayment"--%>
<%--	controller="payment" action="validatefundtransfer"--%>
<%--	secondaryAction="paymentPostProcess" secondaryController="payment"--%>
<%--	secondaryDiv="f-panel" class="btn_next" />--%>