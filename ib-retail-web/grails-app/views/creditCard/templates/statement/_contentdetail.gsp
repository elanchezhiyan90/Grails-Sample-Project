<g:set var="statementDetails" value="${credditCardStatementModel?.statementHeader?.statementDetails}"/>
<table border="0" cellpadding="0" cellspacing="0" class="grid">
	<tbody>
		<g:if test="${statementDetails!=null && statementDetails.size() > 0}">
			<g:each var="ccstmtdetail" in="${statementDetails}">
					<tr>
						<td width="10%"><span><vayana:formatDate date="${ccstmtdetail?.valueDate}" /><span><vayana:formatDate date="${ccstmtdetail?.transactionDate}" /></td>
						<td width="50%"><span>${ccstmtdetail?.transactionDescription}</td>
						<g:if test="${ccstmtdetail?.transactionFlag== 'D'}">							
							<td class="amt dr" width="20%">
								<vayana:formatAmount
										currency="${ccstmtdetail?.transactionCurrencyId?.code}"
										amount="${ccstmtdetail?.transactionAmount}" />
								<span class="cur">Dr.</span>
							</td>
						</g:if>
						<g:else>							
							<td class="amt" width="20%">									
								<vayana:formatAmount	currency="${ccstmtdetail?.transactionCurrencyId?.code}" amount="${ccstmtdetail?.transactionAmount}" /> 
								<span class="cur">Cr.</span>
							</td>
						</g:else>
						<td class="amt" width="20%">								
								<vayana:formatAmount currency="${ccstmtdetail?.billedCurrency?.code}" amount="${ccstmtdetail?.billedAmount}" /> 
						</td>
						
					</tr>
			</g:each>
		</g:if>
		<g:else>
			<tr>
				<td></td>
				<td align="center">No Records Found</td>
				<td></td>
			</tr>
		</g:else>
	</tbody>
	<vayana:pagerModel />
</table>
<g:if
	test="${statementDetails!=null && statementDetails.size() > 0}">
	<br />
	<vayana:download formName="Creditcardmain"
		reportName="creditcardreport.rptdesign" />
</g:if>