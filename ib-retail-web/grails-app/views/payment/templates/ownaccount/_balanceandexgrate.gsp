<g:set var="accountBalance" value="${accountBalanceModel}"></g:set>

	<g:message
		code="payment.templates.ownaccount.balanceandexgrate.balance.label" />
	<span id="spanBalance"> ${accountBalance?.accountCurrency} <vayana:formatAmount
			amount="${accountBalance?.availableBalance}"
			currency="${accountBalance?.accountCurrency}" /></span>

<div>
	<aside class="related-nav">
		<h2>Transaction Limits</h2>
		<nav class="limits">
			<ul>
				<li>
					<p>
						Min./Per Transaction <span class="amt"><span class="cur">
								${limitModel?.limitCurrency?.code}
						</span> <vayana:formatAmount
								currency="${limitModel?.limitCurrency?.code}"
								amount="${limitModel?.minAmountPerTransaction}" /></span>
					</p>

					<p>
						Max./Per Transaction <span class="amt"><span class="cur">
								${limitModel?.limitCurrency?.code}
						</span> <vayana:formatAmount
								currency="${limitModel?.limitCurrency?.code}"
								amount="${limitModel?.maxAmountPerTransaction}" /> </span>
					</p>
				</li>


				<li>
					<p>
						Daily <span class="amt"><span class="cur"> ${limitModel?.limitCurrency?.code}
						</span> <vayana:formatAmount
								currency="${limitModel?.limitCurrency?.code}"
								amount="${limitModel?.dailyTransactionLimit}" /></span> <span
							class="count"> ${limitModel?.dailyTransactionCount}
						</span>
					</p>

					<p>
						Available <span class="amt"><span class="cur"> ${limitModel?.limitCurrency?.code}
						</span> <vayana:formatAmount
								currency="${limitModel?.limitCurrency?.code}"
								amount="${limitModel?.dailyAvailableLimit}" /></span> <span
							class="count"> ${limitModel?.dailyAvailableCount}
						</span>
					</p>
				</li>


				<li>
					<p>
						Monthly <span class="amt"><span class="cur"> ${limitModel?.limitCurrency?.code}
						</span> <vayana:formatAmount
								currency="${limitModel?.limitCurrency?.code}"
								amount="${limitModel?.monthlyTransactionLimit}" /></span> <span
							class="count"> ${limitModel?.monthlyTransactionCount}
						</span>
					</p>

					<p>
						Available<span class="amt"><span class="cur"> ${limitModel?.limitCurrency?.code}
						</span> <vayana:formatAmount
								currency="${limitModel?.limitCurrency?.code}"
								amount="${limitModel?.monthlyAvailableLimit}" /></span> <span
							class="count"> ${limitModel?.monthlyAvailableCount}
						</span>

					</p>
				</li>
				<%--<li>
			Limit Code <span>${limitModel?.code}</span>
			</li>

			--%></ul>
		</nav>
	</aside>
</div>
<div class="fields" id="updatedCurrency" style="display: none;">
	<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
		required="required" class="cur" currencies="${transferCurrency}"
		data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.currencyamount.error.message") }" />
</div>
