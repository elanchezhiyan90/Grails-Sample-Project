	<g:hiddenField name="accountId" value="${params.accountId}"/>
	<g:hiddenField name="loanNumber" value="${params.loanNumber}"/>
	<h2>
		${message(code:'loan.templates.statement.search.statementfor.h2.text')} <vayana:accountNumber value="${params.loanNumber}"/> 
	</h2>
	<fieldset>
		<legend>${message(code:'loan.templates.statement.search.fiter.label')}</legend>
		<div class="grid_filter">
		<div class="fields">
			<p>
				<label for=referenceNumberFilter placeholder="${g.message(code:"loan.templates.statement.search.search.label") }"><g:message
						code="account.templates.statement.search.search.label" /> </label>
				<g:textField name="referenceNumberFilter" placeholder="Remarks Or Bank Ref No."/>
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="fromDate"><g:message
						code="loan.templates.statement.search.fromdate.label" /> </label>
				<input type="date" name="fromDate" id="fromDate" value="" 
					 min="${new Date().minus(90).toTimestamp()?.format('yyyy-MM-dd')}" max="${new Date().toTimestamp()?.format('yyyy-MM-dd')}" maxlength="10" />
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="uptoDate"><g:message
						code="loan.templates.statement.search.todate.label" /> </label> 
				<input type="date" name="uptoDate" id="uptoDate" value=""
					data-dependent-validation='{"from": "fromDate", "prop": "min"}' max="${new Date().toTimestamp()?.format('yyyy-MM-dd')}" maxlength="10"/>
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="debitCreditFilter"><g:message
						code="loan.templates.statement.search.crdr.label" /></label>
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
							code="loan.templates.statement.search.fromamount.label" /></label>
					<g:textField type="number" name="fromAmountFilter" class="s_amt" pattern="[0-9]+" disabled="false" 
						step="any" min="0" />
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="toAmountFilter"><g:message
							code="loan.templates.statement.search.toamount.label" /></label>
					<g:textField type="number" name="toAmountFilter" pattern="[0-9]+" class="s_amt" disabled="false"
						step="any" min="1" />
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="monthFilter"><g:message
							code="loan.templates.statement.search.formonthof.label" /></label>
							<vayana:lastNmonthlist name="monthFilter" class="s_num" currentMonthRequired="YES" onChange="clearDatesaAndNTransFilter();" ></vayana:lastNmonthlist>
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="lastNTransactionFilter"><g:message
							code="loan.templates.statement.search.lastntransaction.label" /></label>
					<g:textField id="lastNTransactionFilter" pattern="[0-9]+" maxlength="3" type="number" name="lastNTransactionFilter"
						class="s_num" step="10" min="10" onClick="clearDatesAndMonthFilter();" />
				</p>
			</div>

		</div>
		<!-- end of more option -->

		<div class="fields" id="togglebtn">
			
			<p>
				<!--mainContent can be found in _content.gsp (table) -->
				<vayana:submitToRemote id="filter" update="[failure:'messagesDiv',success:'mainContent']"
					url="[controller:'loan' , action:'detailedStatement']"
					before="if (checkFormValidity()) {return false;};clearSortBy()"
					onSuccess="onDetailStmtSuccess(data,textStatus)"
					value="${g.message(code:"account.templates.statement.search.filter.tooltip.text")}"
					class="btn_next" />
				<a href="#" class="more"><g:message
						code="loan.templates.statement.search.more.label" /></a>
			</p>
		</div>
	</div>	
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
				if(!$("#loanStmt").checkValidity()) {
					return true;
				} else {
					return false;
				}
			}	
</g:javascript>
