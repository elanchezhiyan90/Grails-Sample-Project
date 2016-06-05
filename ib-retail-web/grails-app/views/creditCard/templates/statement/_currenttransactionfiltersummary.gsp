<table border="0" cellpadding="0" cellspacing="0" class="grid">
	<tbody>
		<g:if
			test="${credditCardStatementModel?.statementHeader?.statementDetails}">
			<g:each var="ccstmtdetail"
				in="${credditCardStatementModel?.statementHeader?.statementDetails}">
				<tr>
					<td width="25%"><span><vayana:formatDate
								date="${ccstmtdetail?.transactionDate}" /><span></td>
					<td class="click-dtl" width="35%"><input type="hidden"
						value="${ccstmtdetail?.bankReferenceNumber}" /><span> ${ccstmtdetail?.bankReferenceNumber}
					</span> ${ccstmtdetail?.transactionDescription}</td>
					<g:if test="${ccstmtdetail?.transactionFlag== 'D'}">
						<td class="amt dr" width="25%"><vayana:formatAmount
								currency="${ccstmtdetail?.statementHeader?.account?.currency?.code}"
								amount="${ccstmtdetail?.transactionAmount}" /> <span
							class="cur">Dr.</span></td>
					</g:if>
					<g:else>
						<td class="amt" width="25%"><vayana:formatAmount
								currency="${ccstmtdetail?.statementHeader?.account?.currency?.code}"
								amount="${ccstmtdetail?.transactionAmount}" /> <span
							class="cur">Cr.</span></td>
					</g:else>
					<g:if
						test="${ccstmtdetail?.transactionAmount > 100 && ccstmtdetail?.transactionFlag== 'D'}">
						<td width="25%"><g:link controller="serviceRequest"
								action="transactiontoEmi"
								params="[tenantServiceCode:'CNVTRNEMI']" title="Convert to EMI"
								class="ceebox">Convert to EMI</g:link></td>
					</g:if>
					<g:else>
						<td></td>
					</g:else>
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
	test="${credditCardStatementModel?.statementHeader?.statementDetails?.size() > 0}">
	<br />
	<vayana:download formName="Creditcardmain"
		reportName="creditcardreport.rptdesign" />
</g:if>
