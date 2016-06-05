<table border="0" cellpadding="0" cellspacing="0" width="100%" class="grid">
	<thead>
		<tr class="grid_theader">
			<th>ChequeNumber</th>
			<th>ChequeStatus</th>
			<th>BeneficiaryName</th>
			<th>ChequeAmount</th>
<%--			<th>PostingDate</th>--%>
		</tr>
	</thead>
	<tbody>
			<g:each var="chqStatus" in="${ResponseModel?.chequeStatus}">
				<tr>
					<td><span>${chqStatus?.chequeNumber}</span></td>
					<td><span>${chqStatus?.chequeStatus}</span></td>
					<td><span>${chqStatus?.beneficiaryName}</span></td>
					<td><span>${chqStatus?.chequeAmount}</span></td>
<%--					<td><span>${chqStatus?.postingDate}</span></td>--%>
				</tr>
			</g:each>
	</tbody>
</table>
