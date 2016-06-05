
<g:set var="brachdisply" value="${genericSRModel}" />


<br>
<table class="grid_theader">
	<thead>
		<tr>
			<th width="10%">BranchCode</th>
			<th width="15%">BranchName</th>
			<th width="15%">AddressLine1</th>
			<th width="15%">AddressLine2</th>
			<th width="15%">AddressLine3</th>
			<th width="15%">TelNo</th>
			<th width="15%">FaxNo</th>
		</tr>
	</thead>
</table>
<table class="grid">
	<tr>
		<td width="10%"></td>
		<td width="15%"></td>
		<td width="15%"></td>
		<td width="15%"></td>
		<td width="15%"></td>
		<td width="15%"></td>
		<td width="15%"></td>
	</tr>
	
	<g:each var="${brachdisply}" in="${genericSRModel}">
		<tr>
			<td>
				${brachdisply?.code}
			</td>
			<td>
				${brachdisply?.description}
			</td>
			<td>
				
			</td>
			<td>
				
			</td>
			<td>
				
			</td>
			<td>
				
			</td>
			<td>
				
			</td>
			
		</tr>
	</g:each>
</table>
</div>
