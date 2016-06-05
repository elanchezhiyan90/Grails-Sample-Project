<g:set var="friendsFamily" value="${friendsFamilyModel?.beneficiaries}" />
	<g:if test="${friendsFamily}">
		<g:each in="${friendsFamily}">
			<li><vayana:postableradio action="editBeneficiary"
					controller="beneficiary"
					target="canvas" urlParams="[beneficiaryId:it.idVersion]"
					linkTitle="${g.message(code:'home.templates.sendmoney.friendsandfamily.viewdetails.tooltip.text')}" id="benedtl-${it?.id}">
				</vayana:postableradio> <vayana:postablelink action="friendsandfamilypayment" controller="payment"
					target="canvas"
					urlParams="[beneId:it.id,beneNickName:it.shortName]" linkClass="lnk"
					linkTitle="${g.message(code:'home.templates.sendmoney.friendsandfamily.sendmoney.tooltip.text')}" id="bene-${it?.id}">
				    <span class="photo">
				    	<g:if test="${it?.photoUrl}">
				    		<g:img uri="${it?.photoUrl}" alt="${it?.shortName}"/>
				    	</g:if>
				    	<g:else>
				    		<g:img dir="themes/pmcb_theme/img/branding" file="user_pic.jpg" alt="${it?.shortName}"/>
				    	</g:else>
				    </span>
					<span class="nme">${it?.shortName}</span>
				</vayana:postablelink> 
			 <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'BENEFICIARY_PAYMENT_HISTORY',userActionLabel:'VIEW')}" >		
				<g:remoteLink controller="payment" action="friendsandfamilyfavourite" id="hstry-${it?.id}" class="hstry"  update="ulpastpayment" title="View History"><span class="hide">&nbsp;</span></g:remoteLink>
				</vayana:fap>
				</li>
		</g:each>
	</g:if>
	<g:else>
    <li class="norecord">

		<span>${message(code:'common.template.beneficiary.norecordsfound.label')}</span>
		
	</li>

</g:else>