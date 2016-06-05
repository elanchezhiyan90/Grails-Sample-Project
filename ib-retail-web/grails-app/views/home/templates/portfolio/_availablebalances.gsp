<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>
<ul >
	<g:set var="customerIdentifiers" value="${actsumModel?.customerIdentifiers}" />
	<g:if test="${customerIdentifiers[0]?.casaAccounts?.size() >=1 && customerIdentifiers[0]?.casaAccounts?.count { LookupCodeConstants.ACTIVE.equals(it?.accountStatus?.code) } >=1}"> 
	<g:each var="cif" in="${customerIdentifiers}">
		<g:each var="acnt" in="${cif?.casaAccounts}">
			<g:if test="${LookupCodeConstants.ACTIVE.equals(acnt?.accountStatus?.code)}">
				<li>
				   <vayana:postableradio controller="account" action="details" id="dtl-${acnt?.accountNumber}"
						target="canvas"
						urlParams="[accountNumber: acnt?.accountNumber]"
						linkTitle="${g.message(code:'home.templates.portfolio.availablebalances.viewdetails.tooltip.text')}">
					</vayana:postableradio> 
					<vayana:postablelink controller="account" action="ministatement" id="${acnt?.accountNumber}"
						target="canvas"
						urlParams="[accountNumber: acnt?.accountNumber,accountShortName:acnt?.accountShortName]" linkClass="lnk"
						linkTitle="${g.message(code:'home.templates.portfolio.availablebalances.viewstatement.tooltip.text')}">
						<span class="nick-${acnt?.accountNumber}">${acnt?.accountShortName}</span>
						<span class="amt">
							<span class="cur"> ${acnt?.currency.code}</span>
								<vayana:formatAmount
										amount="${acnt?.availableBalance}"
										currency="${acnt?.currency.code}" />					 
						</span>
				    </vayana:postablelink>
			  </li>
		  </g:if>
		</g:each>
	</g:each>
	</g:if>
<g:else>
  	 <li class="norecord">
   
		<span>${message(code:'common.template.accounts.norecordsfound.label')}</span>
		
	</li>

</g:else>
</ul>
