<g:form name="prepaidcardmain">
	<!-- Sticky header starts here ----------->
	<div class="start-stick_top"></div>
	<div class="grid_stickyhead_top">
		<table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
			<thead>
				<tr>
					<th width="10%" data-column-message="transactionDate"><g:message
							code="prepaidcard.templates.statement.content.transactiondate.label" /></th>
					<th width="50%" data-column-message="bankReferenceNumber"><g:message
							code="prepaidcard.templates.statement.content.referencenum.label" /></th>
					<th width="20%" data-column-message="transactionAmount" class="amt"><g:message
							code="prepaidcard.templates.statement.content.deditorcredit.label" /></th>
					<th width="20%" data-column-message="runningBalance" class="amt"><g:message
							code="prepaidcard.templates.statement.content.availablebalance.label" /></th>
				</tr>
				<tr>
					<th data-column-message="valueDate"><g:message
							code="prepaidcard.templates.statement.content.valdate.label" /></th>
					<th data-column-message="transactionDescription"><g:message
							code="prepaidcard.templates.statement.content.remark.label" /></th>
					<th data-column-message="" class="amt">&nbsp;</th>
					<th data-column-message="" class="amt">&nbsp;</th>
				</tr>
			</thead>
		</table>
	</div>
	<!-- Sticky header Ends here prepaidCardStatementModel ------------->
	<div id="mainContent">
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
			<vayana:pagerModel></vayana:pagerModel>
		</table>
		<g:if
			test="${prepaidCardStatementModel?.statementHeader?.statementDetails}">
			<br />
			<vayana:download formName="prepaidcardmain"
				reportName="PrepaidCardsReport.rptdesign" />
		</g:if>
	</div>
</g:form>