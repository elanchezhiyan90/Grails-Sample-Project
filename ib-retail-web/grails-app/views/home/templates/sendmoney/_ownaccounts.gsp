<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>
<ul class="bene-mnu">
	<g:set var="customerIdentifiers"
		value="${actsumModel?.customerIdentifiers}" />
		<g:if test="${customerIdentifiers}">
	<g:each var="cif" in="${customerIdentifiers}">
		<g:each var="acnt" in="${cif?.casaAccounts}">
			<g:if test="${LookupCodeConstants.ACTIVE.equals(acnt?.accountStatus?.code)}">
				<li>
				<vayana:postableradio controller="account" action="details" id="dtl-${acnt?.accountNumber}"
					target="canvas"
					urlParams="[accountNumber: acnt?.accountNumber]"
					linkTitle="${g.message(code:'home.templates.sendmoney.ownaccounts.viewdetails.tooltip.text')}">
				</vayana:postableradio>					
				<vayana:postablelink controller="payment" action="ownaccountpayment" id="${acnt?.accountNumber}"
					target="canvas"
					urlParams="[beneId: acnt?.id,payeeNickName: acnt?.accountShortName,payeeCurrency:acnt?.currency.code]" 
					linkClass="lnk"
					linkTitle="${g.message(code:'home.templates.sendmoney.ownaccounts.selectaccount.tooltip.text')}">
					<span class="nick-${acnt?.accountNumber}">${acnt?.accountShortName}</span>
					<span class="amt">
					<span class="cur"> ${acnt?.currency.code}</span> 
					<vayana:formatAmount
							amount="${acnt?.availableBalance}"
							currency="${acnt?.currency.code}" /></span>
				</vayana:postablelink>			
<%--				<vayana:postablelink controller="payment" action="ownaccountfavourite" id="hstry-${acnt?.accountNumber}"--%>
<%--					target="canvas"--%>
<%--					urlParams="payeeId:acnt?.id]" linkClass="hstry"--%>
<%--					linkTitle="View History"><span class="hide">&nbsp;</span>				--%>
<%--				</vayana:postablelink>--%>
				<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'OWN_ACCOUNT_PAYMENT_HISTORY',userActionLabel:'VIEW')}" >	
				<g:remoteLink controller="payment" action="ownaccountfavourite" id="${acnt?.accountNumber}" class="hstry"  update="ulpastpayment" title="${g.message(code:'home.templates.sendmoney.ownaccounts.viewhistory.tooltip.text')}"><span class="hide">&nbsp;</span></g:remoteLink>					
				</vayana:fap>
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