
<tbody>
	<tr>
	<%--  <td width="5%"></td>     --%>
		<td width="10%"></td>
		<td width="15%"></td>
		<td width="20%"></td>
		<td width="20%"></td>
		<td width="15%" class="amt"></td>
		<td width="20%"></td>
	</tr>
	<g:each in="${pastPaymentReviewModel?.paymentDetails}"
		var="paymentDetails">
		<tr>
<%--        <td> </td>	                                   --%>
			<td><vayana:formatDate date="${paymentDetails?.paymentDate}" /></td>
			<td>
				${paymentDetails?.payeeInstruction?.shortName}
			</td>
			<td><vayana:formatAccount
					currency="${paymentDetails?.payerInstruction?.currency?.code}"
					accountno="${paymentDetails?.payerInstruction?.accountNumber}" /></td>
			<td><vayana:formatAccount
					currency="${paymentDetails?.payeeInstruction?.currency?.code}"
					accountno="${paymentDetails?.payeeInstruction?.accountNumber}" /></td>
			<td class="amt"><vayana:formatAmount
					currency="${paymentDetails?.paymentCurrency?.code}"
					amount="${paymentDetails?.paymentAmount}" /> ${paymentDetails?.paymentCurrency?.code}
			</td>
			<td>
				${paymentDetails?.coreReferenceId}
			</td>
		</tr>
	</g:each>
	<vayana:pagerModel />
</tbody>
