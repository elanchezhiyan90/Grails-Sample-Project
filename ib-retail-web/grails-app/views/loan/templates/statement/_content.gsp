<g:form name="Loanmain">
	<!-- Sticky header starts here ----------->
	<div class="start-stick_top"></div>
	<div class="grid_stickyhead_top">
		<table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
			<thead>
				<tr>
					<th width="10%" data-column-message="">
						${g.message(code:'loan.templates.statement.content.transdate.label')}</th>

					
					<th width="30%" data-column-message="">
						${g.message(code:'loan.templates.statement.content.referenceno.label')}
					</th>
<%--					<th width="20%" class="amt" data-column-message="instalmentAmount">--%>
<%--						${g.message(code:'loan.templates.statement.content.debitcredit.label')}--%>
<%--					</th>--%>
					<th width="20%" data-column-message="" class="amt">
						${g.message(code:'loan.templates.statement.content.debit.label')}
					</th>
					<th width="20%" data-column-message="" class="amt">
						${g.message(code:'loan.templates.statement.content.credit.label')}
					</th>					
					<th width="20%" class="amt" data-column-message="">
						${g.message(code:'loan.templates.statement.content.balance.label')}
					</th>
				</tr>
				<tr>
					<th data-column-message="">
						${g.message(code:'loan.templates.statement.content.valuedate.label')}
					</th>
					<th data-column-message="">
						${g.message(code:'loan.templates.statement.content.remarks.label')}
					</th>
					<th class="amt" data-column-message="">&nbsp;</th>
					<th class="amt" data-column-message="">&nbsp;</th>
					<th class="amt" data-column-message="">&nbsp;</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- Sticky header Ends here ----------->
	<div id="mainContent">
		<g:hiddenField name="loanNumber" value="${params.loanNumber}" />

		<table border="0" cellpadding="0" cellspacing="0" class="grid">
			<tbody>
				<tr>
					<td width="10%"></td>
					<td width="30%"></td>
					<td width="20%"></td>
					<td width="20%"></td>
					<td width="20%"></td>
				</tr>
				<g:if test="${LoanStatementModel?.statementHeader?.statementDetails}">
					<g:set var="currency" value="${LoanStatementModel?.statementHeader?.loanAccount?.currency?.code}" />
					<g:each var="stmlDtl" in="${LoanStatementModel?.statementHeader?.statementDetails}">
						<tr>
							<td><span><vayana:formatDate
										date="${stmlDtl?.instalmentReceiptDate}" /></span> <vayana:formatDate
									date="${stmlDtl?.valueDate}" /></td>
							<td><input type="hidden"
								value="${stmlDtl?.bankReferenceNumber}" /><span> ${stmlDtl?.bankReferenceNumber}
							</span> ${stmlDtl?.transactionDescription}</td>
							
							<td class="amt dr"><g:if
									test="${stmlDtl?.transactionType == 'D'}">
									<vayana:formatAmount
										currency="${currency}"
										amount="${stmlDtl?.transactionAmount}" />
									<span class="cur"><g:message
											code="loan.templates.statement.content.deb.label" /></span>
								</g:if></td>

							<td class="amt"><g:if
									test="${stmlDtl?.transactionType == 'C'}">
									<vayana:formatAmount
										currency="${currency}"
										amount="${stmlDtl?.transactionAmount}" />
									<span class="cur"><g:message
											code="loan.templates.statement.content.cre.label" /></span>
								</g:if></td>
							
<%--							<g:if test="${stmlDtl?.transactionType == 'C'}">--%>
<%--								<td width="20%" class="amt"><vayana:formatAmount--%>
<%--										currency="BHD" amount="${stmlDtl?.transactionAmount}" />--%>
<%--									<span class="cur">Cr.</span></td>--%>
<%--							</g:if>--%>
<%--							<g:else>--%>
<%--								<td width="20%" class="amt dr"><vayana:formatAmount--%>
<%--										currency="BHD" amount="${stmlDtl?.transactionAmount}" />--%>
<%--									<span class="cur">Dr.</span></td>--%>
<%--							</g:else>--%>
<%--							<td width="20%" class="amt">--%>
<%--									${stmlDtl?.closingPrincipal} </td>--%>
									
									
									<g:if test="${(stmlDtl?.closingPrincipal.compareTo(BigDecimal.ZERO) < 0)}">
									<td class="amt dr"><vayana:formatAmount
									currency="${currency}" amount="${stmlDtl?.closingPrincipal.negate()}" />
									<span class="cur"><g:message code="loan.templates.statement.content.deb.label" /></span>
									</td>
								</g:if>
								<g:else>
									<td class="amt"><vayana:formatAmount
										currency="${currency}" amount="${stmlDtl?.closingPrincipal}" />
										<span class="cur"><g:message code="loan.templates.statement.content.cre.label" /></span>
									</td>
								</g:else>
						
							<%--<td width="20%" class="amt"><vayana:formatAmount
									 amount="${stmlDtl?.closingPrincipal}" /></td>
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
