<%@page import="com.vayana.ib.bm.core.api.model.payment.BillerInstruction"%>
<%@page import="com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction"%>
<%--${paymentDetailModel.dump()}

--%><g:set var="paymentDetail" value="${paymentDetailModel}"/>
<table border="0" cellspacing="0" cellpadding="0">
	<tbody>						
		<tr>
			<td>From Account Number</td>
			<td>${paymentDetail?.payerInstruction?.accountNumber}</td>
		</tr>
		<g:if test="${paymentDetail?.payeeInstruction instanceof BillerInstruction}">
        <%--<tr>
			<td>Biller Account Number</td>
			<td>${paymentDetail?.payeeInstruction?.billerData?.dump()}</td>
		</tr>
        --%><%--
        <tr>
			<td>Biller Short Name</td>
			<td>${paymentDetail?.payeeInstruction?.shortName}</td>
		</tr>
        --%></g:if>
		<g:elseif test="${paymentDetail?.payeeInstruction instanceof BeneficiaryInstruction}">
		<tr>
			<td>To Account Number</td>
			<td>${paymentDetail?.payeeInstruction?.accountNumber}</td>
		</tr>
		<tr>
			<td>Beneficiary Name</td>
			<td>${paymentDetail?.payeeInstruction?.shortName}</td>
		</tr>
		</g:elseif>		
		
		<tr>
			<td>Transfer Type</td>
			<td>${paymentDetail?.transactionSubType?.serviceApplication?.service?.description}</td>
		</tr>
		<tr>
			<td>Payment Amount</td>
			<td>${paymentDetail?.paymentCurrency?.code}&nbsp;<vayana:formatAmount amount="${paymentDetail?.paymentAmount}" currency="${paymentDetail?.paymentCurrency?.code}" /></td>
		</tr>
		<tr>
			<td>Payment Date</td>
			<td><g:formatDate format="dd-MMM-yyyy" date="${paymentDetail?.getPaymentDate()}"/></td>
		</tr>
		<tr>
			<td>Payment Reference Number</td>
			<g:if test="${'PG_PAYMENT'.equals(paymentDetail?.transactionSubType?.serviceApplication?.service?.code)}">
				<td>${(paymentDetail?.getCoreReferenceId() != null && paymentDetail?.getCoreReferenceId() != "") ? paymentDetail?.getCoreReferenceId() : paymentDetail?.referenceTag}</td>
			</g:if>
			<g:else>			
			<td>${paymentDetail?.getCoreReferenceId()}</td>
			</g:else>
		</tr>
		<tr>
			<td>Status</td>
			<td>${paymentDetail?.getStatus().getDescription()}</td>
		</tr>
		<g:if test="${'REJECTED'.equals(paymentDetail?.status?.code)}">
		<tr>
			<td>Reason For Rejection</td>
			<td><vayana:getRejectionReason entityId="${(paymentDetail?.paymentScheduleDetail != null) ? paymentDetail?.paymentScheduleDetail?.id : paymentDetail?.id}" createdBy="${(paymentDetail?.paymentScheduleDetail != null) ? paymentDetail?.paymentScheduleDetail?.paymentScheduleHeader?.createdBy?.id : paymentDetail?.paymentHeader?.createdBy?.id?.toString()}" /></td>
		</tr>
		</g:if>
		<g:if test="${paymentDetail?.paymentHeader?.createdBy != null}">
		<tr>
			<td>Created By</td>
			<td>${paymentDetail?.paymentHeader?.createdBy?.userLogin}</td>
		</tr>
		</g:if>
		<g:if test="${paymentDetail?.paymentHeader?.authBy != null}">
		<tr>
			<td>${('REJECTED'.equals(paymentDetail?.status?.code)) ? 'Rejected By' : 'Auth By'}</td>
			<td>${paymentDetail?.paymentHeader?.authBy?.userLogin}</td>
		</tr>
		</g:if>
	</tbody>
</table>