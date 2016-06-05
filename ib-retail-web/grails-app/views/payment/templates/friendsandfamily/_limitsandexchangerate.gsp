
	<%--<g:if test="${exchangeRateModel!=""}">
		<div class="fields">
			<g:message
				code="payment.templates.friendsandfamily.exchangerate.exchangerate.label" />
			<span id="spanExchangeRate">
				${exchangeRateModel}
			</span>
		</div>
	</g:if>
	<g:else>
		<div class="fields"></div>
	</g:else>
	--%><div>
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
								amount="${limitModel?.maxAmountPerTransaction}" /></span>
					</p>
				</li>


				<li>
					<p>
						Daily <span class="amt"><span class="cur">
								${limitModel?.limitCurrency?.code}
						</span> <vayana:formatAmount
								currency="${limitModel?.limitCurrency?.code}"
								amount="${limitModel?.dailyTransactionLimit}" /></span> <span
							class="count">
							${limitModel?.dailyTransactionCount}
						</span>
					</p>

					<p>
						Available <span class="amt"><span class="cur">
								${limitModel?.limitCurrency?.code}
						</span> <vayana:formatAmount
								currency="${limitModel?.limitCurrency?.code}"
								amount="${limitModel?.dailyAvailableLimit}" /></span> <span
							class="count">
							${limitModel?.dailyAvailableCount}
						</span>
					</p>
				</li>


				<li>
					<p>
						Monthly <span class="amt"><span class="cur">
								${limitModel?.limitCurrency?.code}
						</span> <vayana:formatAmount
								currency="${limitModel?.limitCurrency?.code}"
								amount="${limitModel?.monthlyTransactionLimit}" /></span> <span
							class="count">
							${limitModel?.monthlyTransactionCount}
						</span>
					</p>

					<p>
						Available<span class="amt"><span class="cur">
								${limitModel?.limitCurrency?.code}
						</span> <vayana:formatAmount
								currency="${limitModel?.limitCurrency?.code}"
								amount="${limitModel?.monthlyAvailableLimit}" /></span> <span
							class="count">
							${limitModel?.monthlyAvailableCount}
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

<div class="fields" id="updatedCurrency" style="display:none;">  
	<g:if
		test="${transactionType != null && transactionType != "" && 'INTSUBMOD'.equals(transactionType)}">
		<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
			required="Y" class="cur" currencies="${transferCurrency}"
			data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.currencyamount.error.message") }" />
	</g:if>
	<g:else>
		<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
			required="Y" class="cur"
			data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.currencyamount.error.message") }" />
	</g:else>
</div>
<div id ="impsTransTypes" >
<g:hiddenField name="impsTransType"  id ="impsTransType" value="${transactionSubType}"></g:hiddenField>        
<%--<g:hiddenField name="impsTransType"  value="${transactionType}"></g:hiddenField>  --%>
</div>

<%--<div class="fields">--%>
<%--						<p>--%>
<%--							<label for="rmrk">transactioSubType</label> <input type="text"--%>
<%--							name="transactioSubType" id="transactioSubType" value="${transactionSubType}"--%>
<%--							placeholder="${g.message(code:"payment.templates.friendsandfamily.transfer.remarks.placeholder.text") }" />--%>
<%--						</p>--%>
<%----%>
<%--</div>--%>