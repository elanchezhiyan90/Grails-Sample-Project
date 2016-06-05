<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>

<g:set var="customerIdentifiers" value="${investmentSummaryModel?.customerIdentifiers}" />
<g:if test="${customerIdentifiers[0]?.investmentAccounts?.size() >=1}">    
<g:each var="cif" in="${customerIdentifiers}">
	<g:each var="investment" in="${cif?.investmentAccounts}">
		<g:if test="${LookupCodeConstants.ACTIVE.equals(investment?.accountStatus?.code)}">
		<li>
					<vayana:postableradio controller="investment" action="details" id="dtl-${investment?.accountNumber}"
					target="canvas"
					urlParams="[accountNumber: investment?.accountNumber,accountId: investment?.id]"
					linkTitle="${g.message(code:'home.templates.portfolio.investments.viewdetails.tooltip.text')}">
					</vayana:postableradio>	
										
					<vayana:postablelink controller="investment" action="statement" id="${investment?.accountNumber}"
					target="canvas"
					urlParams="[accountNumber: investment?.accountNumber, shortName:investment?.accountShortName]" linkClass="lnk"
					linkTitle="${g.message(code:'home.templates.portfolio.investments.viewstatement.tooltip.text')}">
					<span class="nick-${investment?.accountNumber}">${investment?.accountShortName}</span>
					<span class="amt">
					<span class="cur"> ${investment?.currency?.code}</span>
					<vayana:formatAmount
							amount="${investment?.principalBalance}"
							currency="${investment?.currency?.code}" />							 
					</span>
					</vayana:postablelink>									
													
			</li>
			</g:if>
	</g:each>
</g:each>
</g:if>
<g:else>
    <li>
    
		<span>${message(code:'common.template.investments.norecordsfound.label')}</span>
	</li>

</g:else>




