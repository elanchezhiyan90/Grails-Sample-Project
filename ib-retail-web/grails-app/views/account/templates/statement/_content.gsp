<g:form name="accountmain">
	<!-- Sticky header starts here ----------->

	<!-- Sticky header Ends here ----------->
	<vayana:errors />
	
		<table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
		<thead>
				<tr>
					<th width="10%" data-column-message="transactionDate"><g:message
							code="account.templates.statement.content.transactiondate.label" /></th>
					<th width="30%" data-column-message="customerReferenceNumber"><g:message
							code="account.templates.statement.content.referencenum.label" /></th>
					<%--<th width="20%" data-column-message="transactionAmount" class="amt"><g:message
							code="account.templates.statement.content.deditorcredit.label" />
					${actstmtModel?.statementSummary?.account?.currency?.code} 	
				    </th>--%>
				    <th width="20%" data-column-message="" class="amt"><g:message
							code="account.templates.statement.content.debit.label" />
					${actstmtModel?.statementSummary?.account?.currency?.code} 	
				    </th>
				    <th width="20%" data-column-message="" class="amt"><g:message
							code="account.templates.statement.content.credit.label" />
					${actstmtModel?.statementSummary?.account?.currency?.code} 	
				    </th>
				    <th width="20%" data-column-message="runningBalance" class="amt"><g:message
							code="account.templates.statement.content.availablebalance.label" /></th>
				</tr>
				<tr>
					<th data-column-message="valueDate"><g:message
							code="account.templates.statement.content.valdate.label" /></th>
					<th data-column-message="transactionDescription"><g:message
							code="account.templates.statement.content.remark.label" /></th>
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
				<g:if
					test="${actstmtModel?.statementSummary?.casaAccountStatementDetails}">
<%--					<g:set var="currency"--%>
<%--						value="${actstmtModel?.statementSummary?.account?.currency?.code}" />--%>
					<g:each var="stmlDtl" in="${actstmtModel?.statementSummary?.casaAccountStatementDetails}" status="index">
			
				<g:if test="${stmlDtl?.bankReferenceNumber?.trim() !=null && stmlDtl?.bankReferenceNumber?.trim() !=''}">
					<tr class="has-dtl" id="has-dtl-${index}">
						<td><span> <vayana:formatDate date="${stmlDtl?.transactionDate}" /></span><vayana:formatDate date="${stmlDtl?.valueDate}" /></td>
						<td class="click-dtl">
							<input type="hidden" name="chequeNo" id="chequeNo${index}" value="${stmlDtl?.bankReferenceNumber}" />
							<input type="hidden" name="clearingDate" id="clearingDate${index}" value="${stmlDtl?.transactionDate}" />
							<input type="hidden" name="accountNumber" id="accountNumber${index}" value="${stmlDtl?.casaAccountStatementSummary?.account?.accountNumber}" />
							<span> ${stmlDtl?.bankReferenceNumber} </span> ${stmlDtl?.transactionDescription}
						</td>
						<%--<g:if test="${stmlDtl?.transactionType == 'C'}">
						<td width="20%" class="amt"><vayana:formatAmount
								currency="${currency}" amount="${stmlDtl?.transactionAmount}" />
							<span class="cur"><g:message
									code="account.templates.statement.content.cre.label" /></span></td>
					</g:if>
					<g:else>
						<td width="20%" class="amt dr"><vayana:formatAmount
								currency="${currency}" amount="${stmlDtl?.transactionAmount}" />
							<span class="cur"><g:message
									code="account.templates.statement.content.deb.label" /></span></td>
					</g:else>--%>
						<td class="amt dr">
							<g:if test="${stmlDtl?.transactionType == 'D'}">
								<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.transactionAmount}" />
								<span class="cur"><g:message code="account.templates.statement.content.deb.label" /></span>
							</g:if>
						</td>
						<td class="amt">
							<g:if test="${stmlDtl?.transactionType == 'C'}">
								<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.transactionAmount}" />
								<span class="cur"><g:message code="account.templates.statement.content.cre.label" /></span>
							</g:if>
						</td>
						<g:if test="${(stmlDtl?.runningBalance.compareTo(BigDecimal.ZERO) < 0)}">
							<td class="amt dr">
								<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.runningBalance.negate()}" /> 
								<span class="cur"><g:message code="account.templates.statement.content.deb.label" /></span>
							</td>
						</g:if>
						<g:else>
							<td class="amt">
								<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.runningBalance}" /> 
								<span class="cur"><g:message code="account.templates.statement.content.cre.label" /></span>
							</td>
						</g:else>
					</tr>
					<tr class="view-dtl" id="view-dtl-${index}">
						<td colspan="5"></td>
					</tr>
				</g:if>
				<g:else>
					<tr>
						<td><span> <vayana:formatDate date="${stmlDtl?.transactionDate}" /></span><vayana:formatDate date="${stmlDtl?.valueDate}" /></td>
						<td>
							<input type="hidden" name="chequeNo" id="chequeNo${index}" value="${index}" />
							<input type="hidden" name="clearingDate" id="clearingDate${index}" value="${stmlDtl?.transactionDate}" />
							<input type="hidden" name="accountNumber" id="accountNumber${index}" value="${stmlDtl?.casaAccountStatementSummary?.account?.accountNumber}" />
							<span> ${stmlDtl?.bankReferenceNumber} </span> ${stmlDtl?.transactionDescription}
						</td>
						<%--<g:if test="${stmlDtl?.transactionType == 'C'}">
						<td width="20%" class="amt"><vayana:formatAmount
								currency="${currency}" amount="${stmlDtl?.transactionAmount}" />
							<span class="cur"><g:message
									code="account.templates.statement.content.cre.label" /></span></td>
					</g:if>
					<g:else>
						<td width="20%" class="amt dr"><vayana:formatAmount
								currency="${currency}" amount="${stmlDtl?.transactionAmount}" />
							<span class="cur"><g:message
									code="account.templates.statement.content.deb.label" /></span></td>
					</g:else>--%>
						<td class="amt dr">
							<g:if test="${stmlDtl?.transactionType == 'D'}">
								<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.transactionAmount}" />
								<span class="cur"><g:message code="account.templates.statement.content.deb.label" /></span>
							</g:if>
						</td>
						<td class="amt">
							<g:if test="${stmlDtl?.transactionType == 'C'}">
								<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.transactionAmount}" />
								<span class="cur"><g:message code="account.templates.statement.content.cre.label" /></span>
							</g:if>
						</td>
						<g:if test="${(stmlDtl?.runningBalance.compareTo(BigDecimal.ZERO) < 0)}">
							<td class="amt dr">
								<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.runningBalance.negate()}" /> 
								<span class="cur"><g:message code="account.templates.statement.content.deb.label" /></span>
							</td>
						</g:if>
						<g:else>
							<td class="amt">
								<vayana:formatAmount currency="${stmlDtl?.transactionCurrency?.code}" amount="${stmlDtl?.runningBalance}" /> 
								<span class="cur"><g:message code="account.templates.statement.content.cre.label" /></span>
							</td>
						</g:else>
					</tr>
					
				</g:else>
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
		<script>
/************** Account summary grid -Show and hide details ***************/
 $(".grid tr.has-dtl").click(function(event){
  if ( $(event.target).closest(".grid tr .cat,.grid tr .isdisp a ").get(0) == null ){
 	var chequeNo = $(this).find('td.click-dtl input[id^="chequeNo"]').val();
 	var clearDate = $(this).find('td.click-dtl input[id^="clearingDate"]').val();
 	var accountNumber = $(this).find('td.click-dtl input[id^="accountNumber"]').val();
 	var $that =$(this);
 	//<g:remoteFunction controller="account" action="fetchChequeImage" params="\'chequeNo=\'+chequeNo+\'&clearDate=\'+clearDate+\'&accountNumber=\'+accountNumber" onSuccess="updateImage(data,textStatus,this)"/>
 	$.ajax({
				type 	: "POST",
				url 	: "<%=request.getContextPath()%>/account/fetchChequeImage",
				data 	: {'chequeNo':chequeNo,'clearDate':clearDate,'accountNumber':accountNumber},
				success : function(data) {	
						$that.next("tr.view-dtl").find("td").html(data);
						$that.siblings("tr.view-dtl").hide();
						$that.siblings("tr.has-dtl").removeClass('hlt');
					  	$that.next("tr.view-dtl").fadeToggle(500,function(){$('.body-scroll').jScrollPane();});
					  	$that.toggleClass('hlt');
					  	$('.body-scroll').jScrollPane();
				},
				error : function() {
					alert('an error occurred!');
				}
		});	 
 	
 
  }
  
 });
 
</script>
	</div>
</g:form>