<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>
<div class="content">
	<!-- Navigation section starts here-->
	<aside class="nav-section">
		<nav class="accor-nav">
			<form name="frmMainMenu" id="frmMainMenu" method="post">

				<h2>
					<g:message code="home.templates.body.managewealth.h2.text" />
				</h2>
				<%--				<vayana:fap function="${vayana.generateFap(subModuleLabel:'PORTFOLIO_SUB_MODULE')}" >--%>
				<%--					<g:render template="/home/templates/portfolio/portfolio" />--%>
				<%--				</vayana:fap>--%>
				<vayana:fap function="${vayana.generateFap(subModuleLabel:'ACCOUNT_SUB_MODULE')}">
					<vayana:menuItemRemote controller="home" action="accountsummary"
						title="${g.message(code:'home.templates.body.accounts.title')}"
						update="ulaccounts" dirtyFlag="true" />
				</vayana:fap>
				<%--<vayana:fap function="${vayana.generateFap(subModuleLabel:'CREDITCARD_SUB_MODULE')}" >
					<vayana:menuItemRemote controller="home" action="creditcardsummary" title="${g.message(code:'home.templates.body.creditcards.title')}" update="ulCreditCards" dirtyFlag="true"/>
				</vayana:fap>
				--%>
				<%--<vayana:fap function="${vayana.generateFap(subModuleLabel:'PREPAIDCARD_SUB_MODULE')}" >
					<vayana:menuItemRemote controller="home" action="prepaidcardsummary" title="${g.message(code:'home.templates.body.prepaidcards.title')}" update="ulPrepaidCards" dirtyFlag="false"/>
				</vayana:fap>
				--%>

				<g:if test="${actsumModel?.customerIdentifiers && actsumModel?.customerIdentifiers[0]?.depositAccounts?.size()>0 && actsumModel?.customerIdentifiers[0]?.depositAccounts?.count { LookupCodeConstants.ACTIVE.equals(it?.accountStatus?.code) } > 0}"> 
					<vayana:fap function="${vayana.generateFap(subModuleLabel:'INVESTMENT_SUB_MODULE')}">
						<vayana:menuItemRemote controller="home" action="depositsummary"
							title="${g.message(code:'home.templates.body.deposits.title')}"
							update="ulInvestments" dirtyFlag="true"  />
					</vayana:fap>
				</g:if>
				<g:if test="${actsumModel?.customerIdentifiers && actsumModel?.customerIdentifiers[0]?.loanAccounts?.size()>0 && actsumModel?.customerIdentifiers[0]?.loanAccounts?.count { LookupCodeConstants.ACTIVE.equals(it?.accountStatus?.code) } > 0}"> 
					<vayana:fap function="${vayana.generateFap(subModuleLabel:'LOAN_SUB_MODULE')}"> 
					<vayana:menuItemRemote controller="home" action="loansummary"
						title="${g.message(code:'home.templates.body.loans.title')}"
						update="ulLoans" dirtyFlag="true" displayPlusSign="true"
						plusSignAction="addLoanRequest" plusSignController="applyLoan" />
					</vayana:fap>
				</g:if>
				<vayana:fap
					function="${vayana.generateFap(subModuleLabel:'OWN_ACCOUNT_SUB_MODULE')}">
					<h2>
						<g:message code="home.templates.body.managepayment.h2.text" />
					</h2>
				</vayana:fap>
				<g:if test="${actsumModel?.customerIdentifiers && actsumModel?.customerIdentifiers[0]?.casaAccounts?.size()>1 && actsumModel?.customerIdentifiers[0]?.casaAccounts?.count { LookupCodeConstants.ACTIVE.equals(it?.accountStatus?.code) } > 1}">
					<vayana:fap function="${vayana.generateFap(subModuleLabel:'OWN_ACCOUNT_SUB_MODULE')}">
						<vayana:menuItemRemote controller="home" action="ownaccounts"
							title="${g.message(code:'home.templates.sendmoney.ownaccounts.h3.text')}"
							update="ulOwnAccountsPay" dirtyFlag="true" />
					</vayana:fap>
				</g:if>
				<%--<g:render template="/home/templates/sendmoney/owncreditcards"/>
				--%>
				<%--<vayana:menuItemRemote ulClass="bene-mnu" controller="home" action="owncreditcards" title="${g.message(code:'home.templates.body.owncreditcards.title')}" update="ulCreditCardsPay" displayPlusSign="true" plusSignAction="addCreditCard" plusSignController="beneficiary" plusSignUrlParams="[beneficiaryTypeId:friendsfamilyBeneTypeId]"/>
				--%>
				<%--<vayana:fap function="${vayana.generateFap(subModuleLabel:'OWN_CREDITCARD_SUB_MODULE')}" >
					<vayana:menuItemRemote ulClass="bene-mnu" controller="home" action="owncreditcards" title="${g.message(code:'home.templates.body.owncreditcards.title')}" update="ulCreditCardsPay" dirtyFlag="true"/>
				</vayana:fap>
				--%>
				<%--<vayana:fap function="${vayana.generateFap(subModuleLabel:'PREPAIDCARD_SUB_MODULE')}" >
					<vayana:menuItemRemote ulClass="bene-mnu" controller="home" action="prepaidcards" title="${g.message(code:'home.templates.body.ownprepaidcards.title')}" update="ulPrepaidCardsPay" dirtyFlag="false"/>
				</vayana:fap>
				--%>
				<vayana:fap function="${vayana.generateFap(subModuleLabel:'BENEFICIARY_SUB_MODULE')}">
					<vayana:menuItemRemote ulClass="bene-mnu" controller="home"
						action="friendsandfamily"
						title="${g.message(code:'home.templates.body.friendsfamily.title')}"
						update="ulFriendsAndFamilyPay" dirtyFlag="true"
						displayPlusSign="true"
						plusSignAction="${(grailsApplication.config.beneficiary.quickpay.required == true) ? 'addBeneficiary' : 'addBeneMain' }"
						plusSignController="beneficiary"
						plusSignUrlParams="[beneTypeCode:'FF']"
						function="${vayana.generateFap(businessFunctionLabel:'BENEFICIARY',userActionLabel:'ADD')}" />
				</vayana:fap>

				<%--				<vayana:menuItemRemote ulClass="bene-mnu" controller="home" action="standingInstructions" title="Standing Instructions" update="ulStandingInstructionsPay" dirtyFlag="true"/>--%>




				<vayana:fap function="${vayana.generateFap(subModuleLabel:'BILLER_SUB_MODULE')}" >				
					<vayana:menuItemRemote ulClass="bene-mnu" controller="home"
						action="billDesk"
						title="${g.message(code:'home.templates.body.billpay.title')}"
						update="ulBillersPay" dirtyFlag="true"
						function="${vayana.generateFap(businessFunctionLabel:'BILLER',userActionLabel:'ADD')}" />
				<%--					<vayana:menuItemRemote ulClass="bene-mnu" controller="home" action="registeredBillerSummary" title="${g.message(code:'home.templates.body.billpay.title')}" update="ulBillersPay" dirtyFlag="true" function="${vayana.generateFap(businessFunctionLabel:'BILLER',userActionLabel:'ADD')}"/>				--%>
				</vayana:fap>


				<%--				<vayana:menuItemRemote ulClass="bene-mnu" controller="home" action="pendingTransactions" title="Pending Transactions" update="ulPendingTransactionsPay" dirtyFlag="true"/>--%>
				<g:if test="${actsumModel?.customerIdentifiers && actsumModel?.customerIdentifiers[0]?.loanAccounts?.size()>0 && actsumModel?.customerIdentifiers[0]?.loanAccounts?.count { LookupCodeConstants.ACTIVE.equals(it?.accountStatus?.code) } > 0}"> 
					<vayana:fap function="${vayana.generateFap(subModuleLabel:'INTERNAL_TRANSFER',businessFunctionLabel:'LOAN_PAY_TRANS')}">  
						<vayana:menuItemRemote ulClass="bene-mnu" controller="home"
							action="loans"
							title="${g.message(code:'home.templates.body.loans.title')}"
							update="ulLoansPay" dirtyFlag="true" />
					</vayana:fap>
				</g:if>
				<%--<vayana:fap function="${vayana.generateFap(subModuleLabel:'INVESTMENT_SUB_MODULE')}" >	
					<vayana:menuItemRemote ulClass="bene-mnu" controller="home" action="investments" title="${g.message(code:'home.templates.body.investments.title')}" update="ulInvestmentsPay" dirtyFlag="false"/>
				</vayana:fap>	--%>
				
				<!-- For SME Bulk Upload -->
				<vayana:fap function="${vayana.generateFap(subModuleLabel:'SME_BULK_PAYMENT_SUBMOD')}" >	
				<vayana:menuItemRemote ulClass="bene-mnu" controller="home"
						action="smeBulkPayment"
						title="${g.message(code:'home.templates.body.smebulkpay.title')}"
						update="ulSMEBulkPay" dirtyFlag="true"
						function="${vayana.generateFap(businessFunctionLabel:'BILLER',userActionLabel:'ADD')}" />
				</vayana:fap>

				<h2>
					<g:message code="home.templates.body.managerequests.h2.text" />
				</h2>
				<g:if test="${actsumModel?.customerIdentifiers && actsumModel?.customerIdentifiers[0]?.casaAccounts?.size()>0 && actsumModel?.customerIdentifiers[0]?.casaAccounts?.count { LookupCodeConstants.ACTIVE.equals(it?.accountStatus?.code) } > 0}">
					<vayana:fap	function="${vayana.generateFap(subModuleLabel:'ACCOUNT_REQ_SUB_MODULE')}">
						<g:render template="/home/templates/servicerequest/accounts" />
					</vayana:fap>
				</g:if>
				<%--<vayana:fap function="${vayana.generateFap(subModuleLabel:'CREDITCARD_REQ_SUB_MODULE')}" > 	
		        	<g:render template="/home/templates/servicerequest/creditcards" />
		        </vayana:fap>
--%>
				<%--		        <vayana:fap function="${vayana.generateFap(subModuleLabel:'LOAN_REQ_SUB_MODULE')}" > 	--%>
				<%--		        	<g:render template="/home/templates/servicerequest/loans" />--%>
				<%--		        </vayana:fap>	--%>
				 <vayana:fap function="${vayana.generateFap(subModuleLabel:'DEPOSIT_REQ_SUB_MODULE')}" >
		        	<g:render template="/home/templates/servicerequest/investments" />	
		        </vayana:fap>	

				<%--		        <g:render template="/home/templates/servicerequest/others"/>	--%>
			</form>
		</nav>
	</aside>
	<!-- application content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<iframe src="${createLink(controller:'dateline')}" frameborder="0"
				marginheight="0" marginwidth="0" name="canvas" id="canvas"
				onload="$('#spinner').fadeOut();"></iframe>
		</section>
	</div>
</div>