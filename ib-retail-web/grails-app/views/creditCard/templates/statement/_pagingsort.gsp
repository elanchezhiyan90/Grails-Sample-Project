<!---------- Statements Starts Here------------------------>
<br />

<div class="grid_head" style="display: none">
	<div class="sorter">
		<table>
			<tr>
				<td><p>
						<g:message
							code="account.templates.statement.pagingsort.sortby.label" />
					</p></td>
				<td><select name="sortBy" id="sortBy">
				</select></td>
				<td>
					<div id="sortbtns">
						<button type="button" class="ascending">
							<g:message
								code="account.templates.statement.pagingsort.ascending.label" />
						</button>
						<button type="button" class="descending">
							<g:message
								code="account.templates.statement.pagingsort.descending.label" />
						</button>
					</div>

				</td>
			</tr>
		</table>
	</div>
	<vayana:pager controller="creditCard"
		action="statementgotopage" update="mainContent" />
</div>
