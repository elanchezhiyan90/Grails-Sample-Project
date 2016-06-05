<%@page import="com.vayana.ib.bm.core.api.model.payment.BillerInstruction"%>
<%@page import="com.vayana.ib.bm.core.api.model.beneficiary.BeneficiaryInstruction"%>
<g:set var="psh" value="${paymentScheduleHeaderModel}"/>
<g:set var="psd" value="${paymentScheduleDetailModel}"/>
<table border="0" cellspacing="0" cellpadding="0">
	<tbody>						
		<tr>
			<td>From Account Number</td>
			<td>${psd?.payerInstruction?.accountNumber}</td>
		</tr>
		<g:if test="${psd?.payeeInstruction instanceof BillerInstruction}">
        <tr>
			<td>Biller Short Name</td>
			<td>${psd?.payeeInstruction?.shortName}</td>
		</tr>
        </g:if>
		<g:elseif test="${psd?.payeeInstruction instanceof BeneficiaryInstruction}">
		<tr>
			<td>To Account Number</td>
			<td>${psd?.payeeInstruction?.accountNumber}</td>
		</tr>
		<tr>
			<td>Beneficiary Name</td>
			<td>${psd?.payeeInstruction?.shortName}</td>
		</tr>
		</g:elseif>		
		<tr>
			<td>Transfer Type</td>
			<td>${psd?.transactionSubType?.serviceApplication?.service?.description}</td>
		</tr>
		<tr>
			<td>Payment Amount</td>
			<td>${psd?.paymentCurrency?.code}&nbsp;<vayana:formatAmount amount="${psd?.paymentAmount}" currency="${psd?.paymentCurrency?.code}" /></td>
		</tr>
		<tr>
			<td>Start Date</td>
			<td><g:formatDate format="dd-MMM-yyyy" date="${psh?.frequencyStartDate}"/></td>
		</tr>
		<tr>
			<td>End Date</td>
			<td><g:formatDate format="dd-MMM-yyyy" date="${psh?.frequencyEndDate}"/></td>
		</tr>
		<tr>
			<td>Frequency</td>
			<td>${psh?.frequency?.description}</td>
		</tr>
		<tr>
			<td>Payment Reference Number</td>			
			<td>${psh?.referenceTag}</td>
		</tr>
		<%--<tr>
			<td>Status</td>
			<td>${paymentDetail?.status?.description}</td>
		</tr>
		--%><g:if test="${psh?.createdBy != null}">
		<tr>
			<td>Created By</td>
			<td>${psh?.createdBy?.userLogin}</td>
		</tr>
		</g:if>
		<g:if test="${psh?.authBy != null}">
		<tr>
			<td>Authorized/Rejected By</td>
			<td>${psh?.authBy?.userLogin}</td>
		</tr>
		</g:if>
		<g:if test="${'REJECTED'.equals(psd?.status?.code)}">
		<tr>
			<td>Reason For Rejection</td>
			<td><vayana:getRejectionReason entityId="${psd?.id}" /></td>
		</tr>
		</g:if>
		<%--<g:if test="${psh?.paymentScheduleDetail}">
			<tr>
				<table>
					<thead>
						<tr>
							<th>Payment Date</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
					<g:each var="psd" in="${psh?.paymentScheduleDetail}">
					<tr>
						<td align="center"><g:formatDate format="dd-MMM-yyyy" date="${psd?.paymentDate}"/></td>
						<td align="center">${psd?.status?.description}</td>
					<tr>
					</g:each>
					</tbody>
				</table>
			<tr>
		</g:if>
		--%><g:if test="${isSMEApprovalTimeExpired == true &&'PENDING_AUTH'.equals(psd?.status?.code) && ['FT_SI','SI_HEADER'].contains(transactionIdentifier)}">
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