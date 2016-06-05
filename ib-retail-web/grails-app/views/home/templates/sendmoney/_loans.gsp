<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>
<g:set var="customerIdentifiers" value="${loanSummaryModel?.customerIdentifiers}" />
<g:if test="${customerIdentifiers}">
<g:each var="cif" in="${customerIdentifiers}">

	<g:each var="loan" in="${cif?.loanAccounts}">
		<g:if test="${LookupCodeConstants.ACTIVE.equals(loan?.accountStatus?.code)}">
		<li>					
					<vayana:postableradio controller="loan" action="details" id="dtl-${loan?.accountNumber}"
					target="canvas"
					urlParams="[accountNumber: loan?.accountNumber,accountId: loan?.id]"
					linkTitle="${g.message(code:'home.templates.sendmoney.loans.viewdetails.tooltip.text')}">
					</vayana:postableradio>	
										
					<vayana:postablelink controller="payment" action="loanPayment" id="${loan?.accountNumber}"
					target="canvas"
					urlParams="[beneId: loan?.id,payeeNickName: loan?.accountShortName,payeeCurrency: loan?.currency?.code,accountNumber: loan?.accountNumber]" linkClass="lnk"
					linkTitle="${g.message(code:'home.templates.sendmoney.loans.viewstatement.tooltip.text')}">
					<span class="nick-${loan?.accountNumber}">${loan?.accountShortName}</span><span class="amt"><vayana:formatAmount
							amount="${loan?.principalBalance}"
							currency="INR" /><span class="cur"> ${loan?.currency?.code}
					</span> </span>
					</vayana:postablelink>	
					 <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'LOANS_PAYMENT_HISTORY',userActionLabel:'VIEW')}" >	
					<g:remoteLink controller="payment" action="loanPaymentFavourite" id="${loan?.accountNumber}" class="hstry"  update="ulpastpayment" title="${g.message(code:'home.templates.sendmoney.loans.viewhistory.tooltip.text')}"><span class="hide">&nbsp;</span></g:remoteLink>								
			        </vayana:fap>
			</li>
		</g:if>
	</g:each>
</g:each>
</g:if>
<g:else>
    <li class="norecord">
    
		<span>${message(code:'common.template.finance.norecordsfound.label')}</span>
	
	</li>

</g:else>


