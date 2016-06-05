<%@ page import="com.vayana.ib.bm.core.api.model.enums.PayeeTypeEnum"%>
<g:form name="viewPendingTransaction">
	<g:set var="paymentDtl" value="${paymentDetail}" />
	<g:hiddenField name="pendingTransactionId" value="${paymentDetail?.id}"/>
	<table cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td>From Account</td>
			<td>
				${paymentDtl?.payerInstruction?.accountNumber}
				<g:hiddenField name="fromAccountId" value="${paymentDtl?.payerInstruction?.idVersion}"/>
			</td>
		</tr>
		<tr>
			<td>To Account</td>
			<td>
			${paymentDtl?.payeeAccountNumber}
<%--				${(PayeeTypeEnum?.BENE.equals(paymentDtl?.payeeInstruction?.payeeType)) ? vayana.formatFFAccountNumber(beneInsIdVer:paymentDtl?.payeeInstruction?.idVersion) --%>
<%--							: vayana.formatBPAccountNumber(billInsIdVer:paymentDtl?.payeeInstruction?.idVersion) }--%>
				<g:hiddenField name="toAccountId" value="${paymentDtl?.payeeInstruction?.idVersion}"/>			
			</td>
		</tr>
		<tr>
			<td>Transfer Currency</td>
			<td>
				${paymentDtl?.paymentCurrency?.code}
				<g:hiddenField name="currencyId" value="${paymentDtl?.paymentCurrency?.idVersion}"/>
			</td>
		</tr>
		<tr>
			<td>Transfer Amount</td>
			<td><vayana:formatAmount
					currency="${paymentDtl?.paymentCurrency?.code}"
					amount="${paymentDtl?.paymentAmount}"></vayana:formatAmount>
				<g:hiddenField name="paymentAmount" value="${paymentDtl?.paymentAmount}"/>	
			</td>
		</tr>
		<tr>
			<td>Payment Remarks</td>
			<td>
				${paymentDtl?.remarks}
				<g:hiddenField name="paymentRemarks" value="${paymentDtl?.remarks}"/>	
			</td>
		</tr>
		<tr>
			<td>Payment Date</td>
			<td><vayana:formatDate date="${paymentDtl?.paymentDate}"
					showTime="false" /></td>
		</tr>
	</table>
	<br/>
	<div id="dynamicAuthContent">
	<div class="buttons" id="exebtndiv">
		<g:submitToRemote action="executePendingTransaction" value="Execute" controller="payment" id="updateBeneficiary" name="updateBeneficiary" update="[success:'dynamicAuthContent',failure:'messagesDiv']"  onSuccess="onExecuteSuccess(data,textStatus);" ></g:submitToRemote>
		<input type="button" id="cancelTxn" value="Discard" name="cancelTxn" class="cancelTxn btn_next" onClick="deleteRecord('${paymentDtl?.id}')"/>
	</div>
	</div>
</g:form>
<script>
function onExecuteSuccess(data,textStatus){
	$("#dynamicAuthContent").dynamicfieldupdate();
}
</script>