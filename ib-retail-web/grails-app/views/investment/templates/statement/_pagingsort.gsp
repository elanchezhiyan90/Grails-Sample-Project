<br />

<div class="grid_head" style="display: none">
	<div class="sorter">
		<table>
			<tr>
<%--				<td><p>--%>
<%--						<g:message--%>
<%--							code="investment.templates.statement.pagingsort.sortby.label" />--%>
<%--					</p></td>--%>
<%--				<td><select name="sortBy" id="sortBy">--%>
<%--				</select></td>--%>
<%--				<td>--%>
<%--					<div id="sortbtns">--%>
<%--						<button type="button" class="ascending">--%>
<%--							<g:message--%>
<%--								code="investment.templates.statement.pagingsort.ascending.label" />--%>
<%--						</button>--%>
<%--						<button type="button" class="descending">--%>
<%--							<g:message--%>
<%--								code="investment.templates.statement.pagingsort.descending.label" />--%>
<%--						</button>--%>
<%--					</div>--%>
<%----%>
<%--				</td>--%>
			</tr>
		</table>
	</div>
	<vayana:pager controller="investment"
		action="detailedstatementgotopage" update="mainContent" />
</div>
