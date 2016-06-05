<%@ page import="com.vayana.bm.core.api.constants.LookupCodeConstants"%>
<g:set var="customerIdentifiers" value="${creditCardSummaryModel?.customerIdentifiers}" />
<g:if test="${customerIdentifiers}">
	<g:each var="cif" in="${customerIdentifiers}">
		<g:each var="creditcard" in="${cif?.creditCardAccounts}">
			<g:if test="${LookupCodeConstants.ACTIVE.equals(creditcard?.accountStatus?.code)}">
				<li><vayana:postableradio controller="creditCard"
						action="details" id="dtl-${creditcard?.id}" target="canvas"
						urlParams="[creditCardNumber: creditcard?.id]"
						linkTitle="${g.message(code:'home.templates.sendmoney.owncreditcards.viewdetails.tooltip.text')}">
					</vayana:postableradio> <vayana:postablelink controller="payment"
						action="creditcardpayment" id="${creditcard?.id}" target="canvas"
						urlParams="[beneId: creditcard?.id,creditCardNumber: creditcard?.maskedCCNumber,payeeNickName: creditcard?.accountShortName,payeeCurrency:creditcard?.currency.code]"
						linkClass="lnk"
						linkTitle="Payment to ${creditcard?.maskedCCNumber}">
						<span class="nick-${creditcard?.id}">
							${creditcard?.accountShortName}
						</span>
						<span class="amt"> <span class="cur"> ${creditcard?.currency.code}</span>
							<vayana:formatAmount amount="${creditcard?.outStandingAmount}"
								currency="${creditcard?.currency.code}" />
						</span>
					</vayana:postablelink> <vayana:fap
						function="${vayana.generateFap(businessFunctionLabel:'OWN_CREDIT_CARD_PAYMENT_HISTORY',userActionLabel:'VIEW')}">
						<g:remoteLink controller="payment"
							action="creditcardpaymentfavourite" id="${creditcard?.id}"
							class="hstry" update="ulpastpayment"
							title="${g.message(code:'home.templates.sendmoney.owncreditcards.viewhistory.tooltip.text')}">
							<span class="hide">&nbsp;</span>
						</g:remoteLink>
					</vayana:fap>
				</li>
			</g:if>
		</g:each>
	</g:each>
</g:if>
<g:else>
	<li class="norecord"><span>
			${message(code:'common.template.creditcards.norecordsfound.label')}
	</span></li>

</g:else>