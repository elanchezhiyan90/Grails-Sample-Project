<table border="0" cellpadding="0" cellspacing="0" class="grid">
	<tbody>
		<g:if
			test="${prepaidCardStatementModel?.statementHeader?.statementDetails}">
			<g:set var="currency"
				value="${prepaidCardStatementModel?.statementHeader?.account?.currency?.code}" />
			<g:each var="stmlDtl"
				in="${prepaidCardStatementModel?.statementHeader?.statementDetails}">
				<tr>
					<td width="10%"><span><vayana:formatDate
								date="${stmlDtl?.transactionDate}" /></span> <vayana:formatDate
							date="${stmlDtl?.valueDate}" /></td>
					<td width="50%"><input type="hidden"
						value="${stmlDtl?.bankReferenceNumber}" /><span> ${stmlDtl?.bankReferenceNumber}
					</span> ${stmlDtl?.transactionDescription}</td>
					<g:if test="${stmlDtl?.transactionFlag == 'C'}">
						<td width="20%" class="amt"><vayana:formatAmount
								currency="${currency}" amount="${stmlDtl?.transactionAmount}" />
							<span class="cur"><g:message
									code="prepaidcard.templates.statement.content.cre.label" /></span></td>
					</g:if>
					<g:else>
						<td width="20%" class="amt dr"><vayana:formatAmount
								currency="${currency}" amount="${stmlDtl?.transactionAmount}" />
							<span class="cur"><g:message
									code="prepaidcard.templates.statement.content.deb.label" /></span></td>
					</g:else>
					<%--<vayana:formatAmount currency="${currency}"
						amount="${stmlDtl?.transactionAmount}" />
					</td>
					--%>
					<td width="20%" class="amt"><vayana:formatAmount
							currency="${currency}" amount="${stmlDtl?.runningBalance}" /></td>
				</tr>
			</g:each>
		</g:if>
		<g:else>
			<tr>
				<td width="20%">&nbsp;</td>
				<td width="20%">&nbsp;</td>
				<td width="20%">No Records Found</td>
				<td width="20%">&nbsp;</td>
				<td width="10%">&nbsp;</td>
				<td width="10%">&nbsp;</td>
			</tr>
		</g:else>
	</tbody>
	<vayana:pagerModel />
</table>
<g:if
	test="${prepaidCardStatementModel?.statementHeader?.statementDetails}">
	<br />
	<vayana:download formName="prepaidcardmain"
		reportName="prepaidCardReport.rptdesign" />
</g:if>