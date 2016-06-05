<g:set var="accountBalance" value="${accountBalanceModel?.accountDetail }"></g:set>
<div class="fields">
${message(code:'billpayment.templates.balanceandexgrate.balance.text') }<span id="spanBalance"><vayana:formatAmount amount="${accountBalance?.availableBalance}" currency="INR"/></span>
</div>
<p>
							<label for="amount">${message(code:'billpayment.templates.balanceandexgrate.currency&amount.label')}</label>
                           	 <vayana:vayanaSelect name="currencyId" id="currencyId" type="code"
                           	 from = "${transferCurrency}"
			                   noSelection="${['null':'Select']}"
			              />
							
 							<input type="number"  step="any" name="amount" id="amount" class="s_amt"  min="1"   required="required" data-errormessage="${message(code:'billpayment.templates.balanceandexgrate.amount.error.message') }"  />
 						</p>
						<div class="fields">
${message(code:'billpayment.templates.balanceandexgrate.exchangerate.text') }<span id="spanExchangeRate">${exchangeRateModel}INR</span>
</div>