<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>

<g:set var="customerIdentifiers" value="${investmentSummaryModel?.customerIdentifiers}" />
<g:if test="${customerIdentifiers[0]?.depositAccounts?.size() >=1 && customerIdentifiers[0]?.depositAccounts?.count { LookupCodeConstants.ACTIVE.equals(it?.accountStatus?.code) } >=1}"> 
<g:each var="cif" in="${customerIdentifiers}">
	<g:each var="deposit" in="${cif?.depositAccounts}">
	<g:if test="${LookupCodeConstants.ACTIVE.equals(deposit?.accountStatus?.code)}">
		<li>
					<vayana:postableradio controller="investment" action="details" id="dtl-${deposit?.accountNumber}"
					target="canvas"
					urlParams="[accountNumber: deposit?.accountNumber,accountId: deposit?.id]"
					linkTitle="${g.message(code:'home.templates.portfolio.investments.viewdetails.tooltip.text')}">
					</vayana:postableradio>	
										
					<vayana:postablelink controller="investment" action="statement" id="${deposit?.accountNumber}"
					target="canvas"
					urlParams="[accountNumber: deposit?.accountNumber, shortName:deposit?.accountShortName]" linkClass="lnk"
					linkTitle="${g.message(code:'home.templates.portfolio.investments.viewstatement.tooltip.text')}">
					<span class="nick-${deposit?.accountNumber}">${deposit?.accountShortName}</span>
					<span class="amt">
					<span class="cur"> ${deposit?.currency?.code}</span>
					<vayana:formatAmount
							amount="${deposit?.principalBalance}"
							currency="${deposit?.currency?.code}" /> 
					</span>
					</vayana:postablelink>									
													
			</li>
			</g:if>
	</g:each>
</g:each>
</g:if>
<g:else>
    <li class="norecord">
   
		<span>${message(code:'common.template.deposits.norecordsfound.label')}</span>
		
	</li>

</g:else>



