<section class="col-480">
    <g:set var="investmentAccount" value="${investmentDetailModel?.depositAccount}"/>
    <g:set var="acntCurr" value="${investmentAccount?.currency?.code}"/>
    <div class="body-scroll">
	<h2>${message(code:'investment.templates.details.content.h2.detailsfor')} <vayana:accountNumber value="${investmentAccount?.accountNumber}"/></h2>
	<g:form>
	
	<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
    			<tr>
                	<td>${message(code:'investment.templates.details.content.fundhousename.label')}</td>
                    <td>${investmentAccount.fundHouseName}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.schemename.label')}</td>
                    <td>${investmentAccount.schemeName}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.accountholdername.label')}</td>
                    <td>${investmentAccount.accountHolderName}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.modeofholding.label')}</td>
                    <td>${investmentAccount.modeOfHolding}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.nomineename.label')}</td>
                    <td>${investmentAccount.nomineeName}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.status.label')}</td>
                    <td>${investmentAccount.status}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.jointholdername.label')}</td>
                    <td>${investmentAccount.jointHolderName}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.jointholdername2.label')}</td>
                    <td>${investmentAccount.jointHolderName2}</td>
                </tr>
                <tr>
                	<td>J${message(code:'investment.templates.details.content.jointholdername3.label')}</td>
                    <td>${investmentAccount.jointHolderName3}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.guardianname.label')}</td>
                    <td>${investmentAccount.guardianName}</td>
                </tr>
        </table> 
		<br/>
     	<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
    			<tr>
                	<td>${message(code:'investment.templates.details.content.emailid.label')}</td>
                    <td>${investmentAccount.emailId}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.mobilenumber.label')}</td>
                    <td>${investmentAccount.mobileNumber}</td>
                </tr>
        </table>
        <br/>    
      	<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
    			<tr>
                	<td>${message(code:'investment.templates.details.content.folionumber.label')}</td>
                    <td>${investmentAccount.folioNumber}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.dividenoption.label')}</td>
                    <td>${investmentAccount.dividenOption}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.numberofunits.label')}</td>
                    <td>${investmentAccount.numberOfUnits}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.unitsonhold.label')}</td>
                    <td>${investmentAccount.unitsOnHold}</td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.costprice.label')}</td>
                     <td class="amt"><vayana:formatAmount amount="${investmentAccount?.costPrice}" currency="${investmentAccount?.currency?.code}" /></td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.nav.label')}</td>
                     <%--<td class="amt"><vayana:formatAmount amount="${investmentAccount?.NAV.toBigDecimal()}" currency="${investmentAccount?.currency?.code}" /></td>--%>
                     <td class="amt">100.00</td>
                     </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.marketvalue.label')}</td>
                    <td class="amt"><vayana:formatAmount amount="${investmentAccount?.marketValue}" currency="${investmentAccount?.currency?.code}" /></td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.purchasedate.label')}</td>
                    <td><vayana:formatDate date="${investmentAccount.purchaseDate}"/></td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.redemptiondate.label')}</td>
                    <td><vayana:formatDate date="${investmentAccount.redemptionDate}"/></td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.realizedprofitloss.label')}</td>
                    <td class="amt"><vayana:formatAmount amount="${investmentAccount?.realizedProfitLoss}" currency="${investmentAccount?.currency?.code}" /></td>
                </tr>
                <tr>
                	<td>${message(code:'investment.templates.details.content.unrealizedprofitloss.label')}</td>
                    <td class="amt"><vayana:formatAmount amount="${investmentAccount?.unrealizedProfitLoss}" currency="${investmentAccount?.currency?.code}" /></td>
                </tr>
        </table>
      <br/>
	
	</g:form>
	</div>
</section>