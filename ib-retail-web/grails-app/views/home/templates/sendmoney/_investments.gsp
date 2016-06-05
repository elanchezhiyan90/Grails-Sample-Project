<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>
<g:set var="customerIdentifiers" value="${investmentSummaryModel?.customerIdentifiers}" />
<g:if test="${customerIdentifiers}">
<g:each var="cif" in="${customerIdentifiers}">
	<g:each var="investment" in="${cif?.investmentAccounts}">
		<g:if test="${LookupCodeConstants.ACTIVE.equals(investment?.accountStatus?.code)}">
		<li>
					<vayana:postableradio controller="investment" action="details" id="dtl-${investment?.accountNumber}"
					target="canvas"
					urlParams="[accountNumber: investment?.accountNumber]"
					linkTitle="${g.message(code:'home.templates.sendmoney.investments.viewdetails.tooltip.text')}">
					</vayana:postableradio>	
										
					<vayana:postablelink controller="payment" action="investmentPayment" id="${investment?.accountNumber}"
					target="canvas"
					urlParams="[beneId: investment?.id, payeeNickName:investment?.accountShortName,payeeCurrency:investment?.currency.code]" linkClass="lnk"
					linkTitle="${g.message(code:'home.templates.sendmoney.investments.viewstatement.tooltip.text')}">
					<span class="nick-${investment?.accountNumber}">${investment?.accountShortName}</span><span class="amt"><vayana:formatAmount
							amount="${investment?.principalBalance}"
							currency="${investment?.currency?.code}" /><span class="cur"> ${investment?.currency?.code}
					</span> </span>
					</vayana:postablelink>
					<g:remoteLink controller="payment" action="investmentpaymentfavourite" id="${investment?.accountNumber}" class="hstry"  update="ulpastpayment" title="${g.message(code:'home.templates.sendmoney.owncreditcards.viewhistory.tooltip.text')}"><span class="hide">&nbsp;</span></g:remoteLink>							
			</li>
		</g:if>
	</g:each>
</g:each>
</g:if>
<g:else>
     <li class="norecord">
    
		<span>${message(code:'common.template.investments.norecordsfound.label')}</span>
	
	</li>

</g:else>



