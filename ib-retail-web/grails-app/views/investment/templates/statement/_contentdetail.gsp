<table border="0" cellpadding="0" cellspacing="0" class="grid">
	<tbody>
		<tr>
			<td width="10%"></td>
			<td width="30%"></td>
			<td width="20%"></td>
			<td width="20%"></td>
			<td width="20%"></td>

		</tr>
		<g:if test="${StatementModel?.statementSummary?.depositStatementDetails}">

			<g:each var="stmlDtl" in="${StatementModel?.statementSummary?.depositStatementDetails}">
				<tr>
					<td><span>
						<vayana:formatDate date="${stmlDtl?.transactionDate}" /></span> 
						<vayana:formatDate date="${stmlDtl?.depositDate}" />
					</td>
					<td>
						<input type="hidden" value="${stmlDtl?.bankReferenceNumber}" /><span> ${stmlDtl?.bankReferenceNumber}
						</span> ${stmlDtl?.transactionDescription}
					</td>
					<%--<g:if test="${stmlDtl?.transactionFlag == 'C'}">
								<td width="20%" class="amt"><vayana:formatAmount
										currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.transactionAmount}" />
									<span class="cur"><g:message
											code="account.templates.statement.content.cre.label" /></span></td>
							</g:if>
							<g:else>
								<td width="20%" class="amt dr"><vayana:formatAmount
										currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.transactionAmount}" />
									<span class="cur"><g:message
											code="account.templates.statement.content.deb.label" /></span></td>
							</g:else>--%>
					<td class="amt dr">
						<g:if test="${stmlDtl?.transactionFlag == 'D'}">
							<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.transactionAmount}" />
							<span class="cur"><g:message code="account.templates.statement.content.deb.label" /></span>
						</g:if>
					</td>
					<td class="amt">
						<g:if test="${stmlDtl?.transactionFlag == 'C'}">
							<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.transactionAmount}" />
							<span class="cur"><g:message code="account.templates.statement.content.cre.label" /></span>
						</g:if>
					</td>
					<g:if test="${(stmlDtl?.availableBalance.compareTo(BigDecimal.ZERO) < 0)}">
									<td class="amt dr"><vayana:formatAmount
									currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.availableBalance.negate()}" />
									<span class="cur"><g:message code="account.templates.statement.content.deb.label" /></span>
									</td>
								</g:if>
								<g:else>
									<td class="amt"><vayana:formatAmount
										currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.availableBalance}" />
										<span class="cur"><g:message code="account.templates.statement.content.cre.label" /></span>
									</td>
								</g:else>	
<%--					<td class="amt">--%>
<%--						<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.availableBalance}" />--%>
<%--					</td>--%>
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
	test="${StatementModel?.statementSummary?.depositStatementDetails}">
	<br />
	<div class="grid_foot">
		<vayana:download formName="investmentmain1"
			reportName="InvestmentStatement.rptdesign" />
	</div>
</g:if>