

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="grid">
	<thead>
		<tr class="grid_theader">
			<th>CurrencyCode</th>
			<th>CurrencyName</th>
			<th>CurrencyMnemonic</th>
			<th>BuyRate</th>
			<th>SellRate</th>
		</tr>
		
	</thead>
	<tbody>
			<g:each var="exchangeRate" in="${exchangeRateModel?.exchangeRates}">
				<tr>
					<td><span>${exchangeRate?.currencyCode}</span></td>
					<td><span>${exchangeRate?.currencyName}</span></td>
					<td><span>${exchangeRate?.currencyMnemonic}</span></td>
					<td><span>${exchangeRate?.buyRate}</span></td>
					<td><span>${exchangeRate?.sellRate}</span></td>
				</tr>
			</g:each>
	</tbody>
</table>
