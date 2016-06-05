<div class="t-panel">
	<g:hiddenField name="paymentId" id="paymentId" />
	<g:hiddenField name="payeeInsBeneId" id="payeeInsBeneId" />
	<g:hiddenField name="payeeId" id="payeeId" />
	<g:hiddenField name="favouriteId" id="favouriteId" />
	<g:hiddenField name="favAccountId" id="favAccountId" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.payerInstruction?.id}"/>

	<h2><g:message code="payment.templates.friendsandfamily.transferfavourite.h2.text" /></h2>	
	<h3>
		<g:message code="payment.templates.friendsandfamily.transferfavourite.h3.text" />
<g:if test="${!favPaymentDetailModel?.paymentScheduleDetail?.isEmpty()}">
		<g:link controller="payment" action="viewsi"
			title="Scheduled Payments" class="ui-icon ui-icon-extlink max ceebox"
			params="[beneInsId:"${favPaymentDetailModel?.paymentScheduleDetail?.iterator()?.next()?.getPayeeInstruction()?.getId()}",beneId:"${favPaymentDetailModel?.paymentScheduleDetail?.iterator()?.next()?.getPayeeInstruction()?.getBeneficiary()?.getId()}",viewValue:"FF",viewType:"SI"]">SI Review</g:link>
</g:if>
  </h3>	
  	<g:if test="${favPaymentDetailModel}">
  	<vayana:favouriteSchPayment primaryModel="${favPaymentDetailModel}" secondaryAction="benescheduledfavourite" secondaryController="payment" moduleType="FF" />
  	</g:if>
	<h3><g:message code="payment.templates.friendsandfamily.transferfavourite.pastpayments.label" />
	<g:if test="${!favPaymentDetailModel?.pastPaymentDetail?.isEmpty()}">
		<g:link controller="payment" action="viewsi"
			title="Past Payments" class="ui-icon ui-icon-extlink max ceebox"
			params="[beneInsId:"${favPaymentDetailModel?.pastPaymentDetail?.iterator()?.next()?.getPayeeInstruction()?.getId()}",beneId:"${favPaymentDetailModel?.pastPaymentDetail?.iterator()?.next()?.getPayeeInstruction()?.getBeneficiary()?.getId()}",viewValue:"FF",viewType:"PP"]">Payment Review</g:link>
	</g:if>
	</h3>
	<g:if test="${favPaymentDetailModel}">	
	<vayana:favouritePastPayment primaryModel="${favPaymentDetailModel}" secondaryAction="benepastpaymentfavourite" secondaryController="payment" moduleType="FF" />
	</g:if>	
</div>

