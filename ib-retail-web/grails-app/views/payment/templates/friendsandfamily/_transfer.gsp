
<!-- Form Starts here -->

<%@page import="com.vayana.bm.core.api.model.enums.CommonEntityEnum"%>
<g:set var="favouritePaymentDetail"	value="${favPaymentDetailModel?.favouritePaymentDetail}" />
<g:set var="acctBalancePaymentDetail" value="${favPaymentDetailModel?.acctBalancePaymentDetail}" />
<%--<g:hiddenField name="beneInstructionId" id="beneInstructionId"
	value="${favPaymentDetailModel?.acctBalancePaymentDetail?.payeeInstruction?.id}" />
	
--%><g:hiddenField name="isQuickPay" id="isQuickPay" value="${isQuickPay}" />
	
	
<g:hiddenField name="buttonEvent"/>
<div class="f-panel" id="ftpanel">
	<h2>
		<g:message code="payment.templates.friendsandfamily.transfer.sendmoneyto.h2.text" />
		${(isQuickPay) ? beneShortName : favPaymentDetailModel?.getBeneficiaryShortName()}
	</h2>
	<g:if test="${favouritePaymentDetail != null }">
		<span id="favpayment">
			<%--<input type="checkbox"
			name="checkbox${favouritePaymentDetail?.id}"
			id="checkbox${favouritePaymentDetail?.id}" class="fpanelStar"
			onclick="setFavourite(${favouritePaymentDetail?.id},${favouritePaymentDetail?.payeeInstruction?.beneficiary?.id},${favouritePaymentDetail?.payerInstruction?.id});${remoteFunction(controller:'payment',update:'ftpanel',action:'benescheduledfavourite',params:'\'paymentId=\'+getFavourite()+\'&beneId=\'+getBeneId()+\'&payeeId=\'+getPayeeId()+\'&favouriteId=\'+getDiscardFavFlag()' ,onSuccess: 'onFavSuccess(data,textStatus);') } "
			value="dd" checked="checked" />
			--%><g:hiddenField name="paymentFavouriteId" id="paymentFavouriteId" value="${favPaymentDetailModel?.paymentFavourite?.id}"/>
			<g:hiddenField name="paymentFavBeneId" id="paymentFavBeneId" value="${('FF'.equals(favPaymentDetailModel?.paymentFavourite?.favouriteType)) ? favPaymentDetailModel?.paymentFavourite?.bene?.id : null}"/>
			<input type="checkbox" name="paymentFavouriteCheckBox"
			id="paymentFavouriteCheckBox" class="fpanelStar"
			onclick="${remoteFunction(controller:'payment',action:'discardPaymentFavourite',params:'\'paymentFavouriteId=\'+getPaymentFavouriteId()+\'&paymentFavBeneId=\'+getPaymentFavBeneId()', after:'removeFavouriteStar()' ,onSuccess: 'onDiscardFavSuccess(data,textStatus);') } "
			checked="checked" />
		</span>
	</g:if>
	<g:form name="transferForm" controller="payment">
		<g:hiddenField name="datelineReferenceId" value="${datelineRef}" />
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
		<div class="fields">
			<p>
				<label for="from_account"><g:message code="payment.templates.friendsandfamily.transfer.fromaccount.label" /></label>

				<vayana:fromAccountSelect id="fromAccountId" name="fromAccountId"
					type="FF" poptype="CASA"
					noSelection="${['Select Payer Account':'Select Payer Account']}"
					onchange=" ${remoteFunction( 
					 						    	controller :'payment',
													update:'balance',
											   		action:'fromaccountbalanceandexgrate', 	
													before:'if(checkFromAccount()){return false;}',													  						
					 								params:'\'payerId=\'+payerVal()+\'&payeeId=\'+getPayeeVal()' 
												    ,onSuccess: 'onPayerIdSuccess(data,textStatus);'													   										  		
					 					   			)}"
					required="required" data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.youraccount.error.message") }" />
				<br> <span class="selected_des" id="fromAccSelect"><g:message code="payment.templates.friendsandfamily.transfer.youraccount.selection.message" />&nbsp;</span>
			</p>

			<div class="updater" id="balance"></div>
		</div>
		<div class="fields">
			<p>
				<label for="to_account"> <g:message code="payment.templates.friendsandfamily.transfer.account.label" /></label>
				<vayana:toFFAccountSelect name="toAccountId" id="toAccountId"
					type="FF"
					noSelection="${['Select Payer Account':'Select Payee Account']}"
					required="required"
					onchange=" ${remoteFunction( 
					 						    	controller :'payment',
													update:'exchangeRateAndLimit',
											   		action:'exchangeRateAndLimit', 	
													before:'if(checkToAccount()){return false;}',														  						
					 								params:'\'payerId=\'+payerVal()+\'&payeeId=\'+getPayeeVal()',
						 							onFailure:'onFailure(XMLHttpRequest.responseText)',
													onSuccess: 'onPayeeIdSuccess(data,textStatus);'													   										  		
					 					   			)}"
					data-errormessage="${g.message(code:'payment.templates.friendsandfamily.transfer.account.error.message') }" />
					<span class="selectedDetailWrap"><a href="#" class="selectedDetail ui-icon ui-icon-info">info</a></span>
				<br> <span class="selected_des" id="toAccSelect"><g:message code="payment.templates.friendsandfamily.transfer.account.selection.message" />&nbsp;</span>
				<%-- calling a function in the java script before ajax call before = "{{mfgAreaLoc()}}"--%>
			</p>

			<div class="updater" id="exchangeRateAndLimit" name="exchangeRateAndLimit">			
			</div>			
		</div>
		<div class="fields" id="currency">
			<p>
				<label for="amount"><g:message code="payment.templates.friendsandfamily.transfer.currencyamount.label" /></label>			
			
			<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
					required="Y" class="cur"
					data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.currencyamount.error.message") }" />

				<input type="number" step="any" name="paymentAmount" placeholder="Enter Amount"
					id="paymentAmount" class="s_amt" min="1" maxlength="16" required="required"
					data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.amount.error.message") }" />
			</p>
			
		</div>

		<div class="fields">
			<p>
				<label for="rmrk"><g:message code="payment.templates.friendsandfamily.transfer.remarks.label" /></label> <input type="text"
					name="paymentRemarks" id="paymentRemarks"
					placeholder="${g.message(code:"payment.templates.friendsandfamily.transfer.remarks.placeholder.text") }" />
			</p>

		</div>
		
		<div id="mpinId">
			<div class="fields">
				<p>
					<label for="mpin">MPIN</label> <input type="password"    
					name="mpin" id="mpin" onchange="encryptMPIN()"
					placeholder="Enter MPIN" />
				</p>
			</div>
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
<%--		 <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'BENEFICIARY',userActionLabel:'ADD')}" >	--%>
		 <g:if test="${datelineEventRef.equals(null)}">
			<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"
				value="${g.message(code:"payment.templates.ownaccount.transfer.paynow.button.text") }"
				enableButton="btns_now" controller="payment"
				action="validatefundtransfer" secondaryAction="paymentPostProcess"
				secondaryController="payment" secondaryDiv="f-panel" />	</g:if>	
<%--		<g:if test="${!isQuickPay.equals(true)}">			--%>
			<g:submitToRemote action="payLaterPreConfirm" controller="payment"
				name="prePayLater" id="prePayLater" 
				update="dynamicContent"
				value="${g.message(code:"payment.templates.ownaccount.transfer.paylater.button.text") }"
				onSuccess="onPreTransSuccess(data,textStatus)" 
				onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
				before="if (checkFormValidity()) {return false;};unlockForm();"
				class="btn_next"/>
			
			<g:submitToRemote action="repeatPreConfirm" controller="payment"
				name="preRepeat" id="preRepeat" 
				update="dynamicContent"
				value="${g.message(code:"payment.templates.ownaccount.transfer.repeat.button.text") }"
				onSuccess="onPreTransSuccess(data,textStatus)" 
				onFailure="onPreTransFailure(XMLHttpRequest.responseText)"
				before="if (checkFormValidity()) {return false;};unlockForm();"
				class="btn_next"/>
			
			<%--<g:submitToRemote action="saveasDraft" controller="payment"
				name="saveDraft" id="saveDraft" 
				update="btns_paynow"
				value="Save As Draft"
				onSuccess="onDraftSuccess(data,textStatus)" 
				onFailure="onDraftFailure(XMLHttpRequest.responseText)"
				before="if (checkFormValidity()) {return false;};unlockForm();"
				class="btn_next"/>
			</g:if>	
			</g:if>
			<g:if test="${datelineEventRef.equals('SI')}">	
				<g:render template="/payment/templates/common/standingInstructionButtons"/>
			</g:if>--%>
					
			<%--<g:if test="${SICancelFlag.equals('Y')}">
			<g:submitToRemote controller="payment" name="cancel" action="cancelSITransaction" id="cancel" update="otp_cancelpay_div" value="Cancel" class="btn_next"></g:submitToRemote>			
			</g:if>
				
			--%><%--<g:if test="${datelineEventRef.equals('CREATE_DRAFT')}">	
				<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"
					value="${g.message(code:"payment.templates.ownaccount.transfer.paynow.button.text") }"
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
			--%>
<%--			</vayana:fap>--%>
		</div>
		<div class="flds-block" id="dynamicContent">
		
		</div>
		
	</g:form>
	
	<!--Form Ends here -->
</div>
<g:render template="/common/security/templates/securityUtils" />
<script>
$(document).ready(function ()
	{
	
	$("#mpinId").hide();
	});
function encryptMPIN(){
	var mpin = $("#mpin").val();
	var cipher = encrypt(mpin);
	$("#mpin").val(cipher);
}
</script>
