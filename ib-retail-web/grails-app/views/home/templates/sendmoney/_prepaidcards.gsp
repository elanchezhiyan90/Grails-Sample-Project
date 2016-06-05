<g:set var="customerIdentifiers"
	value="${prepaidCardSummaryModel?.customerIdentifiers}" />
<g:each var="cif" in="${customerIdentifiers}">
	<g:each var="prepaidcard" in="${cif?.prepaidCardAccounts}">
		<li><vayana:postableradio controller="prepaidCard" action="details" id="dtl-${prepaidcard?.accountNumber}"
					target="canvas"
					urlParams="[accountId: prepaidcard?.id]"
					linkTitle="${g.message(code:'home.templates.sendmoney.ownprepaidcards.viewdetails.tooltip.text')}">
			</vayana:postableradio> 
			<vayana:postablelink controller="payment" action="prepaidcardpayment" id="${prepaidcard?.accountNumber}"
					target="canvas"
					urlParams="[beneId: prepaidcard?.id,payeeNickName: prepaidcard?.accountShortName,payeeCurrency:prepaidcard?.currency.code]" linkClass="lnk"
					linkTitle="Payment to ${prepaidcard?.accountNumber}">
					<span class="nick-${prepaidcard?.accountNumber}">${prepaidcard?.accountShortName}</span><span class="amt"><vayana:formatAmount
							amount="${prepaidcard?.availablePrepaidLimit}"
							currency="${prepaidcard?.currency.code}" /><span class="cur"> ${prepaidcard?.currency.code}
					</span> </span>
				</vayana:postablelink>
				
			<g:remoteLink controller="payment" action="prepaidcardpaymentfavourite" id="${prepaidcard?.accountNumber}" class="hstry"  update="ulpastpayment" title="${g.message(code:'home.templates.sendmoney.ownprepaidcards.viewhistory.tooltip.text')}"><span class="hide">&nbsp;</span></g:remoteLink>					
		</li>
	</g:each>
</g:each>
