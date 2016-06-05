	<g:hiddenField name="accountId" value="${params.accountId}"/>
	<g:hiddenField name="accountNumber" value="${params.accountNumber}"/>
	
	<h2>${message(code:'investment.templates.statement.search.h2.statementfor')}
<%--		<vayana:accountNumber value="${params.shortName}"/> --%>
<vayana:accountShortName accountNumber="${params.accountNumber}" />
		
	</h2>
	<fieldset>
		<legend>${message(code:'investment.templates.statement.search.filter.legend')}
		</legend>
			<div class="grid_filter">
		<div class="fields">
			<p>
				<label for=referenceNumberFilter
					placeholder="${g.message(code:"investment.templates.statement.search.search.placeholder.text") }"><g:message
						code="investment.templates.statement.search.search.label" /> </label>
				<g:textField name="referenceNumberFilter" placeholder="Remarks Or Bank Ref No."/>
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="fromDate"><g:message
						code="investment.templates.statement.search.fromdate.label" /> </label>
				<input type="date" name="fromDate" id="fromDate" value="" 
					 min="${new Date().minus(90).toTimestamp()?.format('yyyy-MM-dd')}" max="${new Date().toTimestamp()?.format('yyyy-MM-dd')}" maxlength="10" />
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="uptoDate"><g:message
						code="investment.templates.statement.search.todate.label" /> </label> 
				<input type="date" name="uptoDate" id="uptoDate" value=""
					data-dependent-validation='{"from": "fromDate", "prop": "min"}' max="${new Date().toTimestamp()?.format('yyyy-MM-dd')}" maxlength="10" />
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="debitCreditFilter"><g:message
						code="investment.templates.statement.search.creditordebit.label" /></label>
				<select name="debitCreditFilter" id="debitCreditFilter"
					class="s_txt">
					<option value="B" selected>Both</option>
					<option value="C">Credit</option>
					<option value="D">Debit</option>
				</select>
			</p>
		</div>
		<div class="moreopt">
			<!-- more option div -->
			<div class="fields">
				<p>
					<label for="fromAmountFilter"><g:message
							code="investment.templates.statement.search.fromamount.label" /></label>
					<g:textField type="number" name="fromAmountFilter" class="s_amt" pattern="[0-9]+" disabled="false" 
						step="any" min="0" />
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="toAmountFilter"><g:message
							code="investment.templates.statement.search.toamount.label" /></label>
					<g:textField type="number" name="toAmountFilter" pattern="[0-9]+" class="s_amt" disabled="false"
						step="any" min="1" />
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="monthFilter"><g:message
							code="investment.templates.statement.search.formonthof.label" /></label>
							<vayana:lastNmonthlist name="monthFilter" currentMonthRequired="YES" class="s_num" onChange="clearDatesaAndNTransFilter();" ></vayana:lastNmonthlist>
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="lastNTransactionFilter"><g:message
							code="investment.templates.statement.search.lastntransaction.label" /></label>
					<g:textField id="lastNTransactionFilter" pattern="[0-9]+" maxlength="3" type="number" name="lastNTransactionFilter"
						class="s_num" step="10" min="10" onClick="clearDatesAndMonthFilter();" />
				</p>
			</div>

		</div>
		<!-- end of more option -->

		<div class="fields" id="togglebtn">
			
			<p>
				<!--mainContent can be found in _content.gsp (table) -->
				<vayana:submitToRemote id="filter" update="[success:'mainContent']"
					url="[controller:'investment' , action:'detailedstatement']"
					before="if (checkFormValidity()) {return false;};clearSortBy()"
					onSuccess="onDetailStmtSuccess(data,textStatus)"
					onFailure="onDetailStmtFailure(XMLHttpRequest.responseText)"
					value="${g.message(code:"investment.templates.statement.search.filter.tooltip.text")}"
					class="btn_next" />
				<a href="#" class="more"><g:message
						code="investment.templates.statement.search.more.label" /></a>
			</p>
		</div>
		
	</div>
	
	<!-- end of grid_filter -->
</fieldset>
<g:javascript>
			$(document).ready(function(){
				$("#fromDate").change(function(){
					$("#fromAmountFilter").prop('disabled', false);
					clearMonthFilter();
					clearLastNTransactionFilter();
					enableAmountFilters();
<%--					$(".grid_filter").find("input").not("input[type='button'],input[type='date'],.input-date").val("");--%>
				});
				$("#uptoDate").change(function(){
					clearMonthFilter();
					clearLastNTransactionFilter();
					enableAmountFilters();
					});
			});
			function clearSortBy(){
			setSortOrder("");
			 $("#sortBy").next(".ui-combobox").find("input").val("");
			}
			function clearDatesAndMonthFilter(){
				clearDates();
				clearMonthFilter();
<%--				clearAmountFilters();--%>
				enableAmountFilters();
<%--				disableAmountFilters();--%>
			}
			function clearDatesaAndNTransFilter(){
				clearDates();
				clearLastNTransactionFilter();
				clearAmountFilters();
				disableAmountFilters();
			}
			function enableAmountFilters(){
				$("#fromAmountFilter").prop('disabled', false);
				$("#toAmountFilter").prop('disabled', false);
			}
			function disableAmountFilters(){
				$("#fromAmountFilter").prop('disabled', true);
				$("#toAmountFilter").prop('disabled', true);
			}
			function clearAmountFilters(){
				$("#fromAmountFilter").val("");
				$("#toAmountFilter").val("");
			}
			function clearDates(){
				$("#fromDate").val("");
				$("#uptoDate").val("");
			}
			function clearLastNTransactionFilter(){
	
				$("#lastNTransactionFilter").val("");
			}	
			function clearMonthFilter(){
			$("#monthFilter").val("");
		    $("#monthFilter").next(".ui-combobox").find("input").val("");
			}
			function checkFormValidity() {
				if(!$("#investStmt").checkValidity()) {
					return true;
				} else {
					return false;
				}
			}	
</g:javascript>
	
<%--		<div class="grid_filter">--%>
<%--			<div class="fields">--%>
<%--				<p>--%>
<%--					<label for=referenceNumberFilter placeholder="${message(code:'investment.templates.statement.search.search.placeholder')}">${message(code:'investment.templates.statement.search.search.label')}</label> --%>
<%--					<g:textField name="referenceNumberFilter"/>--%>
<%--				</p>--%>
<%--			</div>--%>
<%--			<div class="fields">--%>
<%--				<p>--%>
<%--					<label for="fromDate">${message(code:'investment.templates.statement.search.fromdate.label')}</label> --%>
<%--					<input type="date" name="fromDate" id="fromDate" value="" data-dependent-validation='{"from": "uptoDate", "prop": "max"}' />--%>
<%--				</p>--%>
<%--			</div>--%>
<%--			<div class="fields">--%>
<%--				<p>--%>
<%--					<label for="uptoDate">${message(code:'investment.templates.statement.search.todate.label')}</label> --%>
<%--					<input type="date" name="uptoDate" id="uptoDate" value="" data-dependent-validation='{"from": "fromDate", "prop": "min"}' />--%>
<%--				</p>--%>
<%--			</div>--%>
<%----%>
<%--			<div class="fields">--%>
<%--				<p>--%>
<%--					<label for="debitCreditFilter">${message(code:'investment.templates.statement.search.crdr.label')}</label> --%>
<%--					<select name="debitCreditFilter" id="debitCreditFilter"  class="s_txt">--%>
<%--						<option value="B" selected>${message(code:'investment.templates.statement.search.both.message')}</option>--%>
<%--						<option value="C">${message(code:'investment.templates.statement.search.credit.message')}</option>--%>
<%--						<option value="D">${message(code:'investment.templates.statement.search.debit.message')}</option>--%>
<%--					</select>--%>
<%--				</p>--%>
<%--			</div>--%>
<%--			<div class="moreopt">--%>
<%--				<!-- more option div -->--%>
<%--				<div class="fields">--%>
<%--					<p>--%>
<%--						<label for="fromAmountFilter">${message(code:'investment.templates.statement.search.fromamount.label')}</label> --%>
<%--						<g:textField type="number" name="fromAmountFilter" class="s_amt" step="any" min="0" />--%>
<%--					</p>--%>
<%--				</div>--%>
<%--				<div class="fields">--%>
<%--					<p>--%>
<%--						<label for="toAmountFilter">${message(code:'investment.templates.statement.search.toamount.label')}</label> --%>
<%--						<g:textField type="number" name="toAmountFilter" class="s_amt" step="any" min="1" />--%>
<%--					</p>--%>
<%--				</div>--%>
<%--				<div class="fields">--%>
<%--					<p>--%>
<%--						<label for="monthFilter">${message(code:'investment.templates.statement.search.formonthof.label')}</label> --%>
<%--						<g:select name="monthFilter" class="s_txt"  from="${monthModel?.entrySet()}" optionKey="key" optionValue="value"  noSelection="['':'Select']" onChange="clearDates();"/>--%>
<%--					</p>--%>
<%--				</div>--%>
<%--				<div class="fields">--%>
<%--					<p>--%>
<%--						<label for="lastNTransactionFilter">${message(code:'investment.templates.statement.search.lastntransaction.label')}</label> --%>
<%--						<g:textField type="number" name="lastNTransactionFilter" class="s_num" step="10" min="10" />--%>
<%--					</p>--%>
<%--				</div>--%>
<%----%>
<%--			</div>--%>
<%--			<!-- end of more option -->--%>
<%----%>
<%--			<div class="fields" id="togglebtn">--%>
<%--				<p>--%>
<%--					<!--mainContent can be found in _content.gsp (table) -->--%>
<%--					<g:submitToRemote id="filter" update="mainContent" url="[controller:'investment' , action:' detailedstatement']" --%>
<%--						onSuccess="onDetailStmtSuccess()" onFailure="onDetailStmtFailure(XMLHttpRequest.responseText);" value="${message(code:'investment.templates.statement.search.filter')}" class="btn_next" /> <a--%>
<%--						href="#" class="more">${message(code:'investment.templates.statement.search.more.text')}</a>--%>
<%--				</p>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<!-- end of grid_filter -->--%>
<%--	</fieldset>--%>
<%--	<script>--%>
<%--			function clearDates(){--%>
<%--				$("#fromDate").val("");--%>
<%--				$("#uptoDate").val("");--%>
<%--			}		--%>
<%--	</script>--%>
