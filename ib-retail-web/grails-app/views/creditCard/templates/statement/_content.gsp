<g:form name="ccardmain">
<g:set var="statementDetails" value="${credditCardStatementModel?.statementHeader?.statementDetails}"/>
	<!-- Sticky header starts here ----------->
	<div class="start-stick_top"></div>
	<div class="grid_stickyhead_top">
		<table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
			<thead>
				<tr>
					<th width="10%" data-column-message="postingDate"><g:message code="creditcard.statement.details.postingdate" /></th>
					<th width="50%" data-column-message="transactionDescription"><g:message code="creditcard.statement.details.transactionDescription" /></th>
					<th width="20%" data-column-message="transactionamount" class="amt"><g:message code="creditcard.statement.details.transactionamount" />
					(${credditCardStatementModel?.statementHeader?.account?.currency?.code})
					</th>
					<th width="20%" data-column-message="billedamount" class="amt"><g:message code="creditcard.statement.details.billedamount" /></th>
				</tr>
				<tr>
					<th data-column-message="purchaseDate"><g:message code="creditcard.statement.details.purchasedate" /></th>
					<th data-column-message="">&nbsp;</th>
					<th data-column-message="" class="amt">&nbsp;</th>
					<th data-column-message="" class="amt">&nbsp;</th>
				</tr>
			</thead>
		</table>
	</div>
	<!-- Sticky header Ends here ----------->
	<vayana:errors />
	<div id="mainContent">
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
	</div>
</g:form>	