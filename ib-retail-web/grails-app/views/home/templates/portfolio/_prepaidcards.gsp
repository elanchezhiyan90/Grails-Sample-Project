<g:set var="customerIdentifiers"
	value="${prepaidCardSummaryModel?.customerIdentifiers}" />
	<g:if test="${customerIdentifiers}">
<g:each var="cif" in="${customerIdentifiers}">
	<g:each var="prepaidcard" in="${cif?.prepaidCardAccounts}">
		<li><vayana:postableradio controller="prepaidCard" action="details" id="dtl-${prepaidcard?.accountNumber}"
					target="canvas"
					urlParams="[accountId: prepaidcard?.id]"    
					linkTitle="${g.message(code:'home.templates.portfolio.prepaidcards.viewdetails.tooltip.text')}">
				</vayana:postableradio> <vayana:postablelink controller="prepaidCard" action="ministatement" id="${prepaidcard?.accountNumber}"
					target="canvas"
					urlParams="[accountId: prepaidcard?.accountNumber]" linkClass="lnk"
					linkTitle="${g.message(code:'home.templates.portfolio.prepaidcards.viewstatement.tooltip.text')}">
					<span class="nick-${prepaidcard?.accountNumber}">${prepaidcard?.accountShortName}</span><span class="amt"><vayana:formatAmount
							amount="${prepaidcard?.availablePrepaidLimit}"
							currency="${prepaidcard?.currency.code}" /><span class="cur"> ${prepaidcard?.currency.code}
					</span> </span>
				</vayana:postablelink></li>
	</g:each>
</g:each>
</g:if>
<g:else>
    <li class="norecord">
    
		<span>${message(code:'common.template.prepaidcards.norecordsfound.label')}</span>
	
	</li>

</g:else>