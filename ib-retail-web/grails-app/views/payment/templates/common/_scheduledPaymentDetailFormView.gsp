<%--<%@page import="com.vayana.ib.bm.core.api.model.payment.BillerInstruction"%>
<%@page import="com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction"%>
<g:set var="paymentHeader" value="${paymentDetailModel}"/>
<g:set var="paymentDetail" value="${paymentHeader?.paymentScheduleDetail[0]}"/>
 
<table border="0" cellspacing="0" cellpadding="0">
	<tbody>						
		<tr>
			<td>From Account Number</td>
			<td>${paymentDetail?.payerInstruction?.accountNumber}</td>
		</tr>
		<g:if test="${paymentDetail?.payeeInstruction instanceof BillerInstruction}">
        <tr>
			<td>Biller Account Number</td>
			<td>${paymentDetail?.payeeInstruction?.billerData?.dump()}</td>
		</tr>
        
        <tr>
			<td>Biller Short Name</td>
			<td>${paymentDetail?.payeeInstruction?.shortName}</td>
		</tr>
        </g:if>
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
			<td>Payment Scheduled Start Date</td>
			<td><g:formatDate format="dd-MMM-yyyy" date="${paymentHeader?.frequencyStartDate}"/></td>
		</tr>
		<tr>
			<td>Payment Scheduled End Date</td>
			<td><g:formatDate format="dd-MMM-yyyy" date="${paymentHeader?.frequencyEndDate}"/></td>
		</tr>
		<tr>
			<td>Payment Frequency</td>			
			<td>${paymentHeader?.frequency?.description}</td>
		</tr>
		<tr>
			<td>Payment Reference Number</td>			
			<td>${paymentHeader?.coreReferenceTag}</td>
		</tr>
		<tr>
			<td>Status</td>
			<td>${paymentDetail?.status.description}</td>
		</tr>
		
	
	</tbody>
</table>--%>

<%@page import="com.vayana.ib.bm.core.api.model.payment.BillerInstruction"%>
<%@page import="com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction"%>
<g:set var="paymentDetail" value="${paymentDetailModel}"/>
<table border="0" cellspacing="0" cellpadding="0">
	<tbody>						
		<tr>
			<td>From Account Number</td>
			<td>${paymentDetail?.payerInstruction?.accountNumber}</td>
		</tr>
		<g:if test="${paymentDetail?.payeeInstruction instanceof BillerInstruction}">
        <tr>
			<td>Biller Short Name</td>
			<td>${paymentDetail?.payeeInstruction?.shortName}</td>
		</tr>
        </g:if>
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
			<td>Payment Scheduled Date</td>
			<td><g:formatDate format="dd-MMM-yyyy" date="${paymentDetail?.getPaymentDate()}"/></td>
		</tr>
		<tr>
			<td>Payment Reference Number</td>			
			<td>${paymentDetail?.referenceTag}</td>
		</tr>
		<tr>
			<td>Status</td>
			<td>${paymentDetail?.status?.description}</td>
		</tr>
		<g:if test="${paymentDetail?.paymentScheduleHeader?.createdBy != null}">
		<tr>
			<td>Created By</td>
			<td>${paymentDetail?.paymentScheduleHeader?.createdBy?.userLogin}</td>
		</tr>
		</g:if>
		<g:if test="${paymentDetail?.paymentScheduleHeader?.authBy != null}">
		<tr>
			<td>${('REJECTED'.equals(paymentDetail?.status?.code)) ? 'Rejected By' : 'Auth By'}</td>
			<td>${paymentDetail?.paymentScheduleHeader?.authBy?.userLogin}</td>
		</tr>
		</g:if>
		<g:if test="${'REJECTED'.equals(paymentDetail?.status?.code)}">
		<tr>
			<td>Reason For Rejection</td>
			<td><vayana:getRejectionReason entityId="${paymentDetail?.id}" /></td>
		</tr>
		</g:if>
		<g:if test="${'FAILURE'.equals(paymentDetail?.status?.code) && ('FT').equals(transactionIdentifier)}">
		<tr>
			<td>Reason For Failure</td>
			<td>${paymentDetail?.coreReferenceId}</td>
		</tr>
		</g:if>
		<g:if test="${isSMEApprovalTimeExpired == true &&'PENDING_AUTH'.equals(paymentDetail?.status?.code) && ('FT_SI').equals(transactionIdentifier)}">
		<tr>
			<td colspan="2">
				<div class="failure">
					<p>
						<g:message code="payment.templates.common.scheduledPaymentDetailFormView.transexpiry.message" />
					</p>
				</div>
			</td>
		</tr>
		</g:if>
		
	</tbody>
</table>