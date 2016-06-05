<%@ page import="com.vayana.ib.bm.core.api.model.enums.PayeeTypeEnum"%>
<tbody>
	<tr>
		<td width="20%"></td>
		<td width="20%"></td>
		<td width="20%"></td>
		<td width="15%" class="amt"></td>
		<th width="15%"></th>
		<td width="10%"></td>
	</tr>
	<g:each in="${siViewAndUpdateModel?.paymentScheduleDetails}"
		var="paymentScheduleDetails">
		<tr>
			<td>
				${paymentScheduleDetails?.payeeInstruction?.shortName}
			</td>
			<td><vayana:formatAccount
					currency="${paymentScheduleDetails?.payerInstruction?.currency?.code}"
					accountno="${paymentScheduleDetails?.payerInstruction?.accountNumber}" /></td>
			<td>
				${(PayeeTypeEnum?.BENE.equals(paymentScheduleDetails?.payeeInstruction?.payeeType)) ? vayana.formatFFAccountNumber(beneInsIdVer:paymentScheduleDetails?.payeeInstruction?.idVersion,displayCurrency:'NO') 
										: vayana.formatBPAccountNumber(billInsIdVer:paymentScheduleDetails?.payeeInstruction?.idVersion) }
				<%--<vayana:formatAccount
					currency="${paymentScheduleDetails?.payeeInstruction?.currency?.code}"
					accountno="${paymentScheduleDetails?.payeeInstruction?.accountNumber}" />
					
			--%>
			</td>
			<td class="amt"><vayana:formatAmount
					currency="${paymentScheduleDetails?.paymentCurrency?.code}"
					amount="${paymentScheduleDetails?.paymentAmount}" /> <%--					 ${paymentScheduleDetails?.paymentCurrency?.code}--%>
			</td>
			<td><vayana:formatDate
					date="${paymentScheduleDetails?.paymentDate}" /></td>
			<td>
				${paymentScheduleDetails?.status?.description}
			</td>
		</tr>
	</g:each>
	<vayana:pagerModel />
</tbody>
