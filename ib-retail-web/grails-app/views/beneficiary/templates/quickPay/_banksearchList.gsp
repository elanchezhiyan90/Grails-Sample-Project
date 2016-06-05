<table border="0" cellpadding="0" cellspacing="0" class="grid" id="mainContent">
	<thead class="grid_theader">
		<tr>
			<th width="5%"></th>
			<th width="30%">ECC/Swift</th>
			<th width="20%">Bank Name</th>
			<th width="20%">Branch Name</th>
			<th width="25%">Address</th>
		</tr>
	</thead>
	<tbody >
	<tr>
		<td width="5%"></td>
		<td width="30%"></td>
		<td width="20%"></td>
		<td width="20%"></td>
		<td width="25%"></td>
	</tr>
	<g:if test="${banks}">
		<g:each in="${banks}">
			<g:if test="${bankType == 'DOMESTIC'}">
				<tr class="searchResult">
					<td><input type="radio" class="loadBankValue"
						name="loadBankValue" id="${it.electronicClearingCode}"
						value="${it.electronicClearingCode}"
						data-bankcode="${it.electronicClearingCode}"
						data-bankname="${it.bankName}" data-branchname="${it.branchName}"
						data-bankaddress="${it.address1}"
						data-bankidversion="${it.idVersion}" /></td>
					<td><p>
							<label for="bankCode"><span class="bankCode"> ${it.electronicClearingCode}
							</span></label>
						</p></td>
					<td><p>
							<label for="bankName"><span class="bankName"> ${it.bankName}
							</span></label>
						</p></td>
					<td><p>
							<label for="branchName"><span class="branchName">
									${it.branchName}
							</span></label>
						</p></td>
					<td><p>
							<label for="bankAddress"><span class="bankAddress">
									${it.address1}
							</span></label>
						</p></td>
					<g:hiddenField name="payeeBankBranchId" class="payeeBankBranchId"
						value="${it.idVersion}" />
					<g:hiddenField name="bankAddress" class="bankAddress"
						value="${it.address1}" />
				</tr>
			</g:if>
			<g:elseif test="${bankType == 'FOREIGN'}">
				<tr class="searchResult">
					<td><input type="radio" class="loadBankValue"
						name="loadBankValue" id="${it.swiftCode}" value="${it.swiftCode}"
						data-bankcode="${it.swiftCode}" data-bankname="${it.name1}"
						data-branchname="${it.branch1}" data-bankaddress="${it.address1}"
						data-bankidversion="${it.idVersion}" /></td>
					<td><p>
							<label for="bankCode"><span class="bankCode"> ${it.swiftCode}
							</span></label>
						</p></td>
					<td><p>
							<label for="bankName"><span class="bankName"> ${it.name1}
							</span></label>
						</p></td>
					<td><p>
							<label for="branchName"><span class="branchName">
									${it.branch1}
							</span></label>
						</p></td>
					<td><p>
							<label for="bankAddress"><span class="bankAddress">
									${it.address1}
							</span></label>
						</p></td>
					<g:hiddenField name="payeeBankBranchId" class="payeeBankBranchId"
						value="${it.idVersion}" />
					<g:hiddenField name="bankAddress" class="bankAddress"
						value="${it.address1}" />
				</tr>
			</g:elseif>
		</g:each>
	</g:if>
	<g:else>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>No Record Found</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>

		</tr>
	</g:else>
	<vayana:pagerModel></vayana:pagerModel>
	</tbody>
</table>
<script>
$(function(){
	<g:if test='${banks}'>
		$("#add").removeAttr('disabled');
	</g:if>
	<g:else>
		$("#add").attr('disabled','true');
	</g:else>
});
</script>
