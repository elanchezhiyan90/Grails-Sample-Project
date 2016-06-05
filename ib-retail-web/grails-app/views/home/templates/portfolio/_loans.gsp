<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>
<g:set var="customerIdentifiers" value="${loanSummaryModel?.customerIdentifiers}" />
<g:if test="${customerIdentifiers[0]?.loanAccounts?.size() >=1 && customerIdentifiers[0]?.loanAccounts?.count { LookupCodeConstants.ACTIVE.equals(it?.accountStatus?.code) } >=1}">    
<g:each var="cif" in="${customerIdentifiers}">
	<g:each var="loan" in="${cif?.loanAccounts}">
	<g:if test="${LookupCodeConstants.ACTIVE.equals(loan?.accountStatus?.code)}">
		<li>					
					<vayana:postableradio controller="loan" action="details" id="dtl-${loan?.accountNumber}"
					target="canvas"
					urlParams="[accountNumber: loan?.accountNumber,accountId: loan?.id]"
					linkTitle="${g.message(code:'home.templates.portfolio.loans.viewdetails.tooltip.text')}">
					</vayana:postableradio>	
										
					<vayana:postablelink controller="loan" action="statement" id="${loan?.accountNumber}"
					target="canvas"
					urlParams="[loanNumber: loan?.accountNumber,accountId: loan?.id,shortName:loan?.accountShortName,accountNumber: loan?.accountNumber]" linkClass="lnk"
					linkTitle="${g.message(code:'home.templates.portfolio.loans.viewstatement.tooltip.text')}">
					<span class="nick-${loan?.accountNumber}">${loan?.accountShortName}</span>
					<span class="amt">
						<span class="cur">${loan?.currency?.code}</span>
						<vayana:formatAmount
								amount="${loan?.principalBalance}"
								currency="${loan?.currency?.code}" />							
					</span>
					</vayana:postablelink>									
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