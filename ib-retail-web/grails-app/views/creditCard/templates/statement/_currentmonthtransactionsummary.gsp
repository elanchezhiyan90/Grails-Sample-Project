<g:if test="${credditCardStatementModel?.statementHeader}">
	<g:render
		template="/creditcard/templates/statement/currentstatementsummary" />
</g:if>
<br />
<g:form>
	<g:hiddenField name="sortOrder" value=""></g:hiddenField>
	<g:render template="/creditcard/templates/statement/pagingsort" />
</g:form>

<!-- Sticky header starts here ----------->
			<div class="start-stick_top"></div>
			<div class="grid_stickyhead_top">
				<table border="0" cellpadding="0" cellspacing="0"
					class="grid_theader">
					<thead>
						<tr>
							<th width="15%" data-column-message="transactionDate"><g:message code="creditcard.statement.details.postingdate" /></th>
							<th width="35%" data-column-message="transactionDescription"><g:message code="creditcard.statement.details.transactionDescription" /></th>
							<th width="15%" data-column-message="purchasedate"><g:message code="creditcard.statement.details.purchasedate" /></th>
							<th width="15%" data-column-message="transactionamount" class="amt"><g:message code="creditcard.statement.details.transactionamount" /></th>
							<th width="15%" data-column-message="billedamount"><g:message code="creditcard.statement.details.billedamount" /></th>
						</tr>
					</thead>
				</table>
			</div>
			<!-- Sticky header Ens here ----------->
			
			
<div id="mainContent">
				<table border="0" cellpadding="0" cellspacing="0" class="grid">
					<tbody>
						<g:if test="${statementDetails!=null && statementDetails.size() > 0}">
							<g:each var="ccstmtdetail" in="${statementDetails}">
									<tr>
										<td width="15%"><span><vayana:formatDate date="${ccstmtdetail?.valueDate}" /><span></td>
										<td width="35%"><span>${ccstmtdetail?.transactionDescription}</td>
										<td width="15%"><span><vayana:formatDate date="${ccstmtdetail?.transactionDate}" /><span></td>
										<g:if test="${ccstmtdetail?.transactionFlag== 'D'}">
											<td class="amt dr" width="25%"><vayana:formatAmount
													currency="${ccstmtdetail?.transactionCurrencyId?.code}"
													amount="${ccstmtdetail?.transactionAmount}" /> <span
												class="cur">Dr.</span><span>${ccstmtdetail?.transactionCurrencyId?.code}</span>
											</td>
										</g:if>
										<g:else>
											<td class="amt" width="15%">
												<vayana:formatAmount	currency="${ccstmtdetail?.transactionCurrencyId?.code}" amount="${ccstmtdetail?.transactionAmount}" /> 
												<span class="cur">Cr.</span><span>${ccstmtdetail?.transactionCurrencyId?.code}</span>
											</td>
										</g:else>
										<td class="amt" width="15%">
												<vayana:formatAmount	currency="${ccstmtdetail?.billedCurrency?.code}" amount="${ccstmtdetail?.billedAmount}" /> 
												<span>${ccstmtdetail?.billedCurrency?.code}</span>
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
<script>
$(function(){
	/********* Ceebox for grid catergory ***************/
		$(".cat a").attr('rel',"width:400px; height:380px");
		$(".ceebox").ceebox();
});
</script>