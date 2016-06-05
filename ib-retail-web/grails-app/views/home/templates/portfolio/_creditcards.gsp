<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>
<g:set var="customerIdentifiers"
	value="${creditCardSummaryModel?.customerIdentifiers}" />

<g:if test="${customerIdentifiers[0]?.creditCardAccounts?.size() >=1}"> 
<g:each var="cif" in="${customerIdentifiers}">
	<g:each var="creditcard" in="${cif?.creditCardAccounts}">
		<g:if test="${LookupCodeConstants.ACTIVE.equals(creditcard?.accountStatus?.code)}">
		<li><vayana:postableradio controller="creditCard" action="details" id="dtl-${creditcard?.id}"
					target="canvas"
					urlParams="[creditCardNumber: creditcard?.id]"    
					linkTitle="${g.message(code:'home.templates.portfolio.creditcards.viewdetails.tooltip.text')}">
				</vayana:postableradio> <vayana:postablelink controller="creditCard" action="ministatement" id="${creditcard?.id}"
					target="canvas"
					urlParams="[accountId: creditcard?.id,currencyCode:creditcard?.currency?.code,cardNumber:creditcard?.maskedCCNumber]" linkClass="lnk"
					linkTitle="${g.message(code:'home.templates.portfolio.creditcards.viewstatement.tooltip.text')}">
					<span class="nick-${creditcard?.id}">${creditcard?.accountShortName}</span>
					<span class="amt">
						<span class="cur"> ${creditcard?.currency.code}</span>
						<vayana:formatAmount
								amount="${creditcard?.outStandingAmount}"
								currency="${creditcard?.currency.code}" />
					 </span>
				</vayana:postablelink></li>
			</g:if>

	</g:each>
</g:each>
</g:if>

<g:else>
    	 <li class="norecord">
    
		<span>${message(code:'common.template.creditcards.norecordsfound.label')}</span>
		
	</li>

</g:else>