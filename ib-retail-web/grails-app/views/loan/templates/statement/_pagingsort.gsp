<!---------- Statements Starts Here------------------------>
<br />
<div class="grid_head" style="display: none">
	<div class="sorter">
		<table>
			<tr>
<%--				<td><p>--%>
<%--						${message(code:'loan.templates.statement.pagingsort.sortby.label')}--%>
<%--					</p></td>--%>
<%--				<td><select name="sortBy" id="sortBy">--%>
<%--						<option value="transactionDate">${message(code:'loan.templates.statement.pagingsort.transactiondate.label')}</option>--%>
<%--						<option value="valueDate">${message(code:'loan.templates.statement.pagingsort.valuedate.label')}</option>--%>
<%--						<option value="bankReferenceNumber">${message(code:'loan.templates.statement.pagingsort.referencenumber.label')}</option>--%>
<%--						<option value="transactionDescription">${message(code:'loan.templates.statement.pagingsort.remarks.label')}</option>--%>
<%--						<option value="closingPrincipal">${message(code:'loan.templates.statement.pagingsort.balance.label')}</option>--%>
<%--				</select></td>--%>
<%--				<td>--%>
<%--					<div id="sortbtns">--%>
<%--						<button type="button" class="ascending">--%>
<%--							<g:message--%>
<%--								code="account.templates.statement.pagingsort.ascending.label" />--%>
<%--						</button>--%>
<%--						<button type="button" class="descending">--%>
<%--							<g:message--%>
<%--								code="account.templates.statement.pagingsort.descending.label" />--%>
<%--						</button>--%>
<%--					</div>--%>
<%--				</td>--%>
			</tr>
		</table>
	</div>
	<vayana:pager controller="loan" action="detailedstatementgotopage"
		update="mainContent" />
</div>
