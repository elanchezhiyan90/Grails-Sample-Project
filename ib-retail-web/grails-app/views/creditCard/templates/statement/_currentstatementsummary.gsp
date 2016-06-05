
<h3>Statement Summary</h3>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<g:set var="curCode" id="curCode"
		value="${credditCardStatementModel?.statementHeader?.account?.currency?.code}" />
	<tr>
		<td width="50%">
			<table border="0" cellpadding="0" cellspacing="0" class="dtl_view"
				width="100%" style="border: solid 1px #EEE;">
				
				<tr>
					<td><g:message code="creditcard.statement.outstandingBalance" /></td>
					<td class="amt"><vayana:formatAmount currency="${curCode}"
							amount="${credditCardStatementModel?.statementHeader?.totalOutstanding}" /></td>
				</tr>
				<tr>
					<td><g:message code="creditcard.statement.serviceCharges" /></td>
					<td class="amt"><vayana:formatAmount currency="${curCode}"
							amount="${credditCardStatementModel?.statementHeader?.serviceCharges}" /></td>
				</tr>
				<tr>
					<td><g:message code="creditcard.statement.monthlyCharges" /></td>
					<td class="amt"><vayana:formatAmount currency="${curCode}"
							amount="${credditCardStatementModel?.statementHeader?.monthlyCharges}" /></td>
				</tr>
				
				<tr>
					<td><g:message code="creditcard.statement.discount" /></td>
					<td class="amt"><vayana:formatAmount currency="${curCode}"
							amount="${credditCardStatementModel?.statementHeader?.discount}" /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- STATEMENT SUMMARY ENDS -->

<br />
<!-- ACCOUNT SUMMARY ENDS -->