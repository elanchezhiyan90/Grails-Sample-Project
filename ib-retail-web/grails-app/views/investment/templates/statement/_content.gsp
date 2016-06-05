<!-- Sticky header starts here ----------->
<g:form name="investmentmain1">
	<!-- Sticky header Ends here ----------->
	<g:hiddenField name="accountNumber" value="${params.accountNumber}" />
		<table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
			<thead>
				<tr>
					<th width="10%" data-column-message="transactionDate"><g:message code="account.templates.statement.content.transactiondate.label" /></th>
					<th width="30%" data-column-message="bankReferenceNumber"><g:message code="account.templates.statement.content.referencenum.label" /></th>
					<%--<th width="20%" data-column-message="transactionAmount" class="amt"><g:message
							code="account.templates.statement.content.deditorcredit.label" /></th>--%>
					<th width="20%" data-column-message="" class="amt"><g:message code="account.templates.statement.content.debit.label" /> <%--${actstmtModel?.statementSummary?.account?.currency?.code} 	--%></th>
					<th width="20%" data-column-message="" class="amt"><g:message code="account.templates.statement.content.credit.label" /> <%--					${actstmtModel?.statementSummary?.account?.currency?.code} 	--%></th>
					<th width="20%" data-column-message="availableBalance" class="amt"><g:message code="account.templates.statement.content.availablebalance.label" /></th>
				</tr>
				<tr>
					<th data-column-message="valueDate"><g:message code="account.templates.statement.content.valdate.label" /></th>
					<th data-column-message="transactionDescription"><g:message code="account.templates.statement.content.remark.label" /></th>
					<th data-column-message="" class="amt">&nbsp;</th>
					<th data-column-message="" class="amt">&nbsp;</th>
					<th data-column-message="" class="amt">&nbsp;</th>
				</tr>
			</thead>
			</table>
			<div id="mainContent">
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
							<td><span><vayana:formatDate date="${stmlDtl?.transactionDate}" /></span> <vayana:formatDate 
									date="${stmlDtl?.depositDate}" /></td>
							<td><input type="hidden"
								value="${stmlDtl?.bankReferenceNumber}" /><span> ${stmlDtl?.bankReferenceNumber}
							</span> ${stmlDtl?.transactionDescription}</td>

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
								</g:if></td>

							<td class="amt">
								<g:if test="${stmlDtl?.transactionFlag == 'C'}">
									<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.transactionAmount}" />
									<span class="cur"><g:message code="account.templates.statement.content.cre.label" /></span>
								</g:if></td>
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

							<%--<td class="amt"><vayana:formatAmount
									currency="${stmlDtl?.transactionCurrency?.code}"
									amount="${stmlDtl?.availableBalance}" /></td>
						--%></tr>
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
			<vayana:pagerModel></vayana:pagerModel>
		</table>
	</div>

</g:form>
