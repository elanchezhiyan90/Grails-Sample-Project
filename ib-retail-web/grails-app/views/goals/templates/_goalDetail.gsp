<style>
progress {
	height: 20px;
	width: 60%;
}
#goals {
}
#goals td a {
	display: block;
}
#goals td label span {
	margin-left: 10%;
	color: #e75e0b;
	display: inline;
}
</style>
<g:set var="goal" value="${goalSIModel}" />
<g:set var="goalInfo" value="${goalHeader}" />
<table class="grid" width="95%" id="goals">
	<tr>
		<td width="50%"></td>
		<td width="15%"></td>
		<td width="10%"></td>
		<td width="10%"></td>
	</tr>
	<tr>
		<td><a href class="ceebox" title="Enfield Bullet"> <label>
					${goalInfo?.code}<span><span class="currency">
							${goalInfo?.targetCurrency?.code}
					</span>
					<vayana:formatAmount currency="${goalInfo?.targetCurrency?.code}"
							amount="${totalPaidAmt}"></vayana:formatAmount></span>
			</label> <progress value="${goalInfo?.totalPaidAmt}"
					max="${ goalInfo?.targetAmount}"> </progress>&nbsp;<span
				class="currency">
					${goalInfo?.targetCurrency?.code}
			</span> <vayana:formatAmount currency="${goalInfo?.targetCurrency?.code}"
					amount="${goalInfo?.targetAmount}"></vayana:formatAmount>
		</a></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<table class="grid_theader">
	<thead>
		<tr>
			<th width="20%">Date</th>
			<th width="20%">Amount</th>
			<th width="20%">Goal Account</th>
			<th width="20%">Given By</th>
			<th width="20%">Status</th>
		</tr>
	</thead>
</table>
<table class="grid">
	<tr>
		<td width="20%"></td>
		<td width="20%"></td>
		<td width="20%"></td>
		<td width="20%"></td>
		<td width="20%"></td>
	</tr>
	<g:each var="${goal}" in="${goalSIModel}">
		<tr>
			<td>
				${goal?.paymentDate}
			</td>
			<td>
				${goal?.paymentAmount}<%--<span class="currency">${goal?.paymentAmount}</span><vayana:formatAmount currency="${goal?.paymentCurrency?.id}" amount="${goal?.paymentAmount}"></vayana:formatAmount>--%>
			</td>
			<td>
				${goal?.payerInstruction?.id}
			</td>
			<td>
				${goal?.payeeInstruction?.id}
			</td>
			<td>
				${goal?.status?.description}
			</td>
		</tr>
	</g:each>
</table>
</div>




