<g:set var="accountBalance" value="${accountBalanceModel}"></g:set>
<div id="accountBalance" class="updater" name="accountBalance">
<g:hiddenField name="tenantBranch" id="tenantBranch"  value="${accountBalance?.accountBranch?.idVersion}" />
<g:hiddenField name="tenantBranchdesc" id="tenantBranchdesc"  value="${accountBalance?.accountBranch?.description}" />
	<g:message code="payment.templates.ownaccount.balanceandexgrate.balance.label" />
	<span id="spanBalance"><span class="cur"> ${accountBalance?.accountCurrency}
	</span> <vayana:formatAmount amount="${accountBalance?.availableBalance}"
			currency="${accountBalance?.accountCurrency}" /></span>
</div>