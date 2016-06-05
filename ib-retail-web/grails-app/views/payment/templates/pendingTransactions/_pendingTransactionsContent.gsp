<table border="0" cellpadding="0" cellspacing="0" class="grid">
		<tbody>
			<tr>
				<td width="20%"></td>
				<td width="15%"></td>
				<td width="15%"></td>
				<td width="10%"></td>
				<td width="5%"></td>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="5%"></td>
				<td width="5%"></td>
			</tr>
			<g:if test="${pendingPaymentDetailModel}">
				<g:each in="${pendingPaymentDetailModel}" var="paymentDtl"
					status="index">
					<tr class="has-dtl" id="has-dtl_${index}">
						<td>
							${paymentDtl?.referenceTag}
						</td>
						<td>
						${paymentDtl?.payeeAccountNumber}
<%--							${(PayeeTypeEnum?.BENE.equals(paymentDtl?.payeeInstruction?.payeeType)) ? vayana.formatFFAccountNumber(beneInsIdVer:paymentDtl?.payeeInstruction?.idVersion) --%>
<%--							: vayana.formatBPAccountNumber(billInsIdVer:paymentDtl?.payeeInstruction?.idVersion) }--%>
						</td>
						<td>
							${paymentDtl?.payerInstruction?.accountNumber}
						</td>
						<td><vayana:formatDate date="${paymentDtl?.paymentDate}"
								showTime="false" /></td>
						<td>
							${paymentDtl?.paymentCurrency?.code}
						</td>
						<td><vayana:formatAmount
								currency="${paymentDtl?.paymentCurrency?.code}"
								amount="${paymentDtl?.paymentAmount}"></vayana:formatAmount></td>
						<td>
							${paymentDtl?.status?.code}
						</td>
						<td><g:remoteLink class="edit_row" controller="payment"
								action="viewPendingTransaction"
								params="[paymentDetailId:paymentDtl?.id]"
								update="editDataDiv_${index}"
								onSuccess="resizeEditContainer('${index}');">Edit</g:remoteLink>

						</td>
						<td><g:remoteLink class="remove"
								before="if (!deleteRecord('${paymentDtl?.id}')) {return false;}"
								controller="payment" action="discardPendingTransaction">Delete</g:remoteLink>
						</td>
					</tr>
					<tr class="view-dtl" id="view-dtl_${index}">
						<td colspan="10">
							<div id="editDataDiv_${index}"></div>
						</td>
					</tr>
				</g:each>
			</g:if>
			<g:else>
				<tr>
					<td width="20%"></td>
					<td width="15%"></td>
					<td width="15%">No Record(s) Found</td>
					<td width="10%"></td>
					<td width="5%"></td>
					<td width="15%"></td>
					<td width="10%"></td>
					<td width="5%"></td>
					<td width="5%"></td>
				</tr>
			</g:else>
		</tbody>
		<vayana:pagerModel/>
	</table>
	<script>
/************** Details grid -Show and hide details ***************/
$(".grid tr.has-dtl a.edit_row ").click(function(){
	$("table.grid tr.has-dtl").next("tr").hide();
	$(this).parents("tr.has-dtl").next("tr.view-dtl").fadeToggle(500,function(){$(this).dynamicfieldupdate();});
	$(this).parents("tr.has-dtl").toggleClass('hlt');
});
</script>