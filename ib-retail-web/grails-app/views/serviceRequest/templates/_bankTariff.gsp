<br>
<table class="grid_theader">
	<thead>
		<tr>
			<th width="10%">TransactionType</th>
			<th width="10%">Charges</th>
			
		</tr>
	</thead>
</table>
<table class="grid">
	<tr>
		
		<td width="50%"></td>
		<td width="50%"></td>
		<td width="50%"></td>
		
	</tr>
	
	
	<g:each in="${bankTariffModel.entrySet()}" var="${entry}">
		<tr>
			<td>
			<g:message code="banktariff.${entry.getKey()}.label"/>
				
			</td>
			<td>
				${entry.getValue()}
			</td>
			
		</tr>
	</g:each>
</table>
