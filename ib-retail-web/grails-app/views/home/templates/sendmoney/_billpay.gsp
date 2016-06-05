<%--<g:each var="biller" in="${BillerSummaryModel?.registeredBillers}">
	<li>
				
					<vayana:postableradio controller="Biller" action="details" id="dtl-${biller?.id}"
					target="canvas"
					urlParams="[billerId: biller?.id]"
					linkTitle="${g.message(code:'home.templates.sendmoney.billpay.viewdetails.tooltip.text')}">
					</vayana:postableradio>	
										
					<vayana:postablelink controller="billPayment" action="billpayment" id="${biller?.shortName}"
					target="canvas" 
					urlParams="[beneId: biller?.id,billerNickName: biller?.shortName]" linkClass="lnk"
					linkTitle="Pay to ${biller?.shortName}">
					<g:set var="img" value="${biller.getDocument().getDocumentDetails().iterator().next().getId()}"/>
					<span class="photo"><vayana:img documentDetailId="${img}" /></span>
					
					<span class="nme">${biller?.shortName}</span>
					</vayana:postablelink>	
					 <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'BILLER_PAYMENT_HISTORY',userActionLabel:'VIEW')}" >	
					<g:remoteLink controller="billPayment" action="billpaymentfavourite" id="${biller?.id}" class="hstry"  update="ulpastpayment" title="${g.message(code:'home.templates.sendmoney.billpay.viewhistory.tooltip.text')}"><span class="hide">&nbsp;</span></g:remoteLink>
					</vayana:fap>		
	</li>
</g:each>--%>
 <li><g:link controller="billPayment" action="billDesk" class="lnk" target="_self">BillDesk</g:link></li>