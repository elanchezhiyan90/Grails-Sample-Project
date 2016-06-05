<g:set var="charge" value="${chargeResponse}"></g:set>
<g:if test="${charge?.chargeAmount!=null && charge?.currency!=null}">
	<div class="fields">
		<g:message code="payment.fees.label" />
		<span id="spanCharges">
		<vayana:formatAmount amount="${charge?.chargeAmount}" currency="${charge?.currency}"/> ${charge?.currency}</span>
	</div>
</g:if>
<g:else>
	<div class="fields">
		<g:message code="payment.fees.label" />
		<span id="spanCharges">0.00</span>
	</div>
</g:else>
