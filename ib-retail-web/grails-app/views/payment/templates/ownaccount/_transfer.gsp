
<!-- Form Starts here -->

<%@page import="com.vayana.bm.core.api.model.enums.CommonEntityEnum"%>

	<%--                 <g:set var="beneInstruction" value = "${beneficiary.beneficiaryInstruction}"/>--%>
<g:set var="favouritePaymentDetail" value="${favPaymentDetailModel?.favouritePaymentDetail}" />	
<g:set var="acctBalancePaymentDetail" value="${favPaymentDetailModel?.acctBalancePaymentDetail}" />
<g:hiddenField name="buttonEvent"/>
<div class="f-panel" id="ftpanel">
	<h2>
		<g:message code="payment.templates.ownaccount.transfer.h2.text" />
		${favPaymentDetailModel?.getBeneficiaryShortName()}
		<g:if test="${favouritePaymentDetail != null }">
		<span id="favpayment">
		<%--<input type="checkbox" class="fpanelStar" name="checkbox${favouritePaymentDetail?.id}" id="checkbox${favouritePaymentDetail?.id}" 
		onclick="setFavourite(${favouritePaymentDetail?.id},${favouritePaymentDetail?.payeeInstruction?.id},${favouritePaymentDetail?.payerInstruction?.id});${remoteFunction(controller:'payment',update:'f-panel',action:'ownpastpaymentfavourite',params:'\'paymentId=\'+getFavourite()+\'&payInsId=\'+getPayInsId()+\'&payeeId=\'+getPayeeId()+\'&favouriteId=\'+getDiscardFavFlag()' ,onSuccess: 'onFavSuccess(data,textStatus);') } "
		value="dd"
		checked="checked"/>--%>
			<g:hiddenField name="paymentFavouriteId" id="paymentFavouriteId" value="${favPaymentDetailModel?.paymentFavourite?.id}"/>
			<g:hiddenField name="paymentFavBeneId" id="paymentFavBeneId" value="${('OA'.equals(favPaymentDetailModel?.paymentFavourite?.favouriteType)) ? favPaymentDetailModel?.paymentFavourite?.payeeInstruction?.id : null}"/>
			<input type="checkbox" name="paymentFavouriteCheckBox"
			id="paymentFavouriteCheckBox" class="fpanelStar"
			onclick="${remoteFunction(controller:'payment',action:'discardPaymentFavourite',params:'\'paymentFavouriteId=\'+getPaymentFavouriteId()+\'&paymentFavBeneId=\'+getPaymentFavBeneId()', after:'removeFavouriteStar()' ,onSuccess: 'onDiscardFavSuccess(data,textStatus);') } "
			checked="checked" />
		</span>
		</g:if>
	</h2>

	<g:form name="transferForm" controller="payment">   
	<g:hiddenField name="favouriteAccountCurrency" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentCurrency?.id}"/>
		<g:if test="${datelineEventRef.equals('SI')}">					
			<g:hiddenField name="paymentScheduleDetailId" value="${acctBalancePaymentDetail?.id}" />
			<g:hiddenField name="paymentScheduleHeaderId" value="${acctBalancePaymentDetail?.paymentScheduleHeader?.id}" />		
			<g:hiddenField name="configuredPaymentDate" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentDate?.format("dd-MMM-yyyy")}" />
			<g:hiddenField name="confStartDate" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequencyStartDate?.format('dd-MMM-yyyy')}"/>
			<g:hiddenField name="confEndDate" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequencyEndDate?.format('dd-MMM-yyyy')}"/>
			<g:hiddenField name="confFrequency" value="${favPaymentDetailModel?.acctBalancePaymentDetail?.paymentScheduleHeader?.frequency?.code}"/>
		</g:if>
		<g:hiddenField name="eventRef" value="${datelineEventRef}"/>
		<%--<div class="mandi-note">
			<span class="mandi"></span>
			<p><g:message code="payment.templates.ownaccount.transfer.mandatory.fields.label" /></p>
		</div>
		--%><div class="fields">
			<p>
				<label for="from_account"><g:message code="payment.templates.ownaccount.transfer.fromaccount.label" /></label>
				<vayana:fromAccountSelect id="fromAccountId" name="fromAccountId" 
					type="OA" poptype="CASA"
					noSelection="${['Select Payer Account':'Select Payer Account']}"
					onchange=" ${remoteFunction( 
					 						    	controller :'payment',
													update:'exchangeRateAndLimit',
											   		before:'if(emptyDropDown(this.value)){return false;}',
													action:'ownaccountbalanceandexgrate', 														  						
					 								params:'\'payerId=\'+payerVal()+\'&payeeId=\'+payeeVal()' ,
													onFailure:'onFailure(XMLHttpRequest.responseText)',
													onSuccess: 'onPayerIdSuccess(data,textStatus);'											  		
					 					   			)}"
					required="required" data-errormessage="${g.message(code:'payment.templates.ownaccount.transfer.youraccount.error.message') }" />
				<br> <span class="selected_des" id="fromAccSelect"><g:message code="payment.templates.ownaccount.transfer.youraccount.selection.message" />&nbsp;</span>

			</p>

			<div class="updater" id="exchangeRateAndLimit" name="exchangeRateAndLimit">			
			</div>
		</div>
		<div class="fields">
			<p>
				<label for="to_account"> <g:message code="payment.templates.ownaccount.transfer.account.label" /></label>
				<vayana:toAccountSelect name="toAccountId" id="toAccountId"
					type="OA" poptype="CASA"
					noSelection="${['Select Payer Account':'Select Payer Account']}" 
					required="required" data-errormessage="${g.message(code:'payment.templates.ownaccount.transfer.account.error.message') }" />
					<br><span class="selected_des" id="toAccSelect"><g:message code="payment.templates.ownaccount.transfer.account.selection.message" />&nbsp;</span>

				<%-- calling a function in the java script before ajax call before = "{{mfgAreaLoc()}}"--%>
			</p>
			
		</div>
		<div class="fields" id="currency">
			<p>
				<label for="amount"><g:message code="payment.templates.ownaccount.transfer.currencyamount.label" /> </label>
					<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId" 
					required="Y" class="cur"
					data-errormessage="${g.message(code:'payment.templates.ownaccount.transfer.currencyamount.error.message') }" />

				<input type="number" step="any" name="paymentAmount" placeholder="Enter Amount"
					id="paymentAmount" class="s_amt" min="1" required="required"  maxlength="16" 
					data-errormessage="${g.message(code:'payment.templates.ownaccount.transfer.amount.error.message') }" />
			</p>
			<div class="updater" id="transactionCharges"></div>
		</div>

		<div class="fields">
			<p>
				<label for="rmrk"><g:message code="payment.templates.ownaccount.transfer.remarks.label" /></label> <input type="text"
					name="paymentRemarks" id="paymentRemarks"  value="${favPaymentModel?.paymentDetail?.remarks}" maxlength="25"
					placeholder="${g.message(code:'payment.templates.ownaccount.transfer.remarks.placeholder.text') }"  />
			</p>

		</div>
		<div class="fields">
			<p>
				<label><input type="checkbox" name="terms" id="terms"
							required="required"
							data-errormessage="You have to agree the terms and conditions to proceed" />
							I agree the <g:remoteLink controller="payment" action="termsAndConditions"
											class="ceebox" title="${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.ceebox.text')}">
											${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.text')}
										</g:remoteLink>
							
				</label>
			</p>
		</div>
		
		<div class="buttons" id="btns_paynow">
		<br>
			<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'OWN_ACCOUNT_TRANSFER',userActionLabel:'ADD')}" >	 
					<g:if test="${datelineEventRef.equals(null)}">	
				<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"
					value="${g.message(code:'payment.templates.ownaccount.transfer.paynow.button.text') }"
					enableButton="btns_now" controller="payment"
					action="validatefundtransfer" secondaryAction="paymentPostProcess"
					secondaryController="payment" secondaryDiv="f-panel" />			
				<g:submitToRemote action="payLaterPreConfirm" controller="payment"
					name="prePayLater" id="prePayLater" 
					update="dynamicContent"
					value="${g.message(code:'payment.templates.ownaccount.transfer.paylater.button.text') }"
					onSuccess="onPreTransSuccess(data,textStatus)" 
					onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
					before="if (checkFormValidity()) {return false;};unlockForm();"
					class="btn_next"/>
				<g:submitToRemote action="repeatPreConfirm" controller="payment"
					name="preRepeat" id="preRepeat" 
					update="dynamicContent"
					value="${g.message(code:'payment.templates.ownaccount.transfer.repeat.button.text') }"
					onSuccess="onPreTransSuccess(data,textStatus)" 
					onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
					before="if (checkFormValidity()) {return false;};unlockForm();"
					class="btn_next"/>
			<%--	<g:submitToRemote action="saveasDraft" controller="payment"
					name="saveDraft" id="saveDraft" 
					update="btns_paynow"
					value="Save As Draft"
					onSuccess="onDraftSuccess(data,textStatus)" 
					onFailure="onDraftFailure(XMLHttpRequest.responseText)"
					before="if (checkFormValidity()) {return false;};unlockForm();"
					class="btn_next"/>
			--%></g:if>			
			
			<g:if test="${datelineEventRef.equals('SI')}">	
				<g:render template="/payment/templates/common/standingInstructionButtons"/>
			</g:if>
				
			<g:if test="${datelineEventRef.equals('SME')}">		
				<vayana:ftValidate name="approvePayment" buttonEvent="APPROVEPAYMENT"
				value="Approve"
				enableButton="btns_cancelpayment" controller="payment"
				action="validatefundtransfer" secondaryAction="paymentPostProcess"
				secondaryController="payment" secondaryDiv="f-panel" />
				<vayana:ftValidate name="rejectPayment" buttonEvent="REJECTPAYMENT"
				value="Reject"
				enableButton="btns_cancelpayment" controller="payment"
				action="validatefundtransfer" secondaryAction="paymentPostProcess"
				secondaryController="payment" secondaryDiv="f-panel" class="btn_next" />			
			</g:if><%--		
			
			<g:if test="${datelineEventRef.equals('CREATE_DRAFT')}">	
				<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"
					value="${g.message(code:'payment.templates.ownaccount.transfer.paynow.button.text') }"
					enableButton="btns_now" controller="payment"
					action="validatefundtransfer" secondaryAction="paymentPostProcess"
					secondaryController="payment" secondaryDiv="f-panel" />	
				<g:submitToRemote action="saveasDraft" controller="payment"
					name="saveDraft" id="saveDraft" 
					update="btns_paynow"
					value="Save"
					onSuccess="onDraftSuccess(data,textStatus)" 
					onFailure="onDraftFailure(XMLHttpRequest.responseText)"
					before="if (checkFormValidity()) {return false;};unlockForm();"
					class="btn_next"/>	
			</g:if>		
			--%></vayana:fap>
		</div>
		<div class="flds-block" id="dynamicContent">		
		</div>
		
</g:form>
	<!--Form Ends here -->
</div>



