<g:set var="accountBalance" value="${accountBalanceModel}"></g:set>
<div id="exchangeRateAndLimit" class="updater" name="exchangeRateAndLimit">
	<g:message
	
		code="payment.templates.ownaccount.balanceandexgrate.balance.label" />
	<span id="spanBalance"><span class="cur">${accountBalance?.accountCurrency}</span><vayana:formatAmount
			amount="${accountBalance?.availableBalance}"
			currency="${accountBalance?.accountCurrency}" /></span>
			</div>
<p>
	<label for="amount"><g:message
			code="payment.templates.ownaccount.balanceandexgrate.currencyamount.label" />
	</label>

	<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
		required="required" class="cur"
		data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.currencyamount.error.message") }" />

	<input type="number" step="any" name="amount" id="amount" class="s_amt"
		min="1" required="required"
		data-errormessage="${g.message(code:"payment.templates.ownaccount.balanceandexgrate.amount.error.message") }" />
</p>
<%--<g:if test="${exchangeRateModel!=""}">
	<div class="fields">
		<g:message
			code="payment.templates.ownaccount.balanceandexgrate.exchangerate.label" />
		<span id="spanExchangeRate"> ${exchangeRateModel}
		</span>
	</div>
</g:if>
<g:else>
	<div class="fields"></div>
</g:else>
--%><div class="fields" id="updatedCurrency" style="display: none;">
	<%--<g:if
		test="${transactionType != null && transactionType != "" && 'INTSUBMOD'.equals(transactionType)}">
		<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
			required="required" class="cur" currencies="${transferCurrency}"
			data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.currencyamount.error.message") }" />
	</g:if>
	<g:else>
		<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
			required="Y" class="cur"
			data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.currencyamount.error.message") }" />
	</g:else>
--%>
<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
		required="required" class="cur" currencies="${transferCurrency}"
		data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.currencyamount.error.message") }" />
</div>