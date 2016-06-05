<div class="f-panel" id="ftpanel">
<h2>
	Send Money to
	${postProcessModel?.beneficiaryNickName}
</h2>
<g:if test="${true.equals(isAWarning)}">
	<g:each in="${warningErrorCodes}" var="errorCode">
		<div class="${errorClass}">
			<g:message code="${errorCode}" />
		</div>
	</g:each>
</g:if>
	<g:if test="${datelineRef}">
			<g:hiddenField name="datelineReferenceId" value="${datelineRef}" />
	</g:if>
	<h3>
		${(postProcessModel?.noOfTransactions && postProcessModel?.noOfTransactions != 0 ) ? (postProcessModel?.noOfTransactions >= 1 && postProcessModel?.frequency != null) ? 'Repeat' : 'Pay Later' : 'Pay Now'}
	</h3>

	<ul class="payment_dtls">

		<li><p class="hdr">From</p></li>
		
		
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
				<p class="hdr">Maker</p>
				</div>
				<div class="rht_dtl">
					<p class="hdr">${postProcessModel?.maker}</p>
				</div>
			</div>
			
		</li>
		
			
			
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<vayana:formatFromAccount
						accountId="${postProcessModel?.fromAccountId}" />
				</div>
				<div class="rht_dtl">
					<p>Exchange Rate</p>
					<p>
						${postProcessModel?.transferCurrency}
						${postProcessModel?.fromExchangeRate}
					</p>
				</div>
			</div>
			<div class="amt_dtl">
				<p>Debiting Amount</p>
				<p>
					<vayana:formatTransactionAmount
						transactionAmount="${postProcessModel?.debitAmount}"
						transactionCurrency="${postProcessModel?.fromCurrency}" />
				</p>
			</div>
		</li>
		<li><p class="hdr">To</p></li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<vayana:formatFFAccount
						beneInstructionId="${postProcessModel?.toAccountId}" />
				</div>
				<div class="rht_dtl">
					<p>Exchange Rate</p>
					<p>
						${postProcessModel?.debitCurrencyDisplay}
						${postProcessModel?.toExchangeRate}
					</p>
				</div>
			</div>
			<div class="amt_dtl">
				<p>Crediting Amount</p>
				<p>
					<vayana:formatTransactionAmount
						transactionAmount="${postProcessModel?.creditAmount}"
						transactionCurrency="${postProcessModel?.toCurrency}" />
				</p>
			</div>
		</li>
		<li><p class="hdr">Transfer Amount</p></li>
		<li>
			<div class="amt_dtl">
				<p>Currency &amp; Amount</p>
				<%--                <p><span class="cur">AED</span>&nbsp;<span class="amt">52,000.00</span></p>--%>
				<p>
					<vayana:formatTransactionAmount
						transactionAmount="${postProcessModel?.transactionAmount}"
						transactionCurrency="${postProcessModel?.transferCurrency}" />
				</p>
			</div>
		</li>
		<li><p class="hdr">Remarks</p></li>
		<li>
			<p>
				${postProcessModel?.remarks}
			</p>
		</li>
		<li><p class="hdr">Bank Fee</p></li>
		
		<li>
			<div class="dtl_wralp">
				<g:if test="${!postProcessModel?.chargeCurrency.equals(null)}">
					<div class="lft_dtl">
						<p>
							Transfer Fee (${postProcessModel?.chargeCode})
						</p>
						<p>
							${postProcessModel?.chargeCurrency}<vayana:formatAmount
								currency="${postProcessModel?.chargeCurrency}"
								amount="${postProcessModel?.chargeAmount}" />
							=
							${postProcessModel?.chargeCurrency}
							<vayana:formatAmount currency="${postProcessModel?.chargeCurrency}"
								amount="${postProcessModel?.chargeAmount}" />
						</p>
					</div>
					<div class="rht_dtl">
						<p>Exchange rate</p>
						<p>
							${postProcessModel?.chargeCurrency}
							${postProcessModel?.chargeExchangeRate}
						</p>
					</div>
				</g:if>
			</div>
		</li>
			
		
		<g:if test="${postProcessModel?.noOfTransactions && postProcessModel?.noOfTransactions != 0}">
			<li><p class="hdr">
					${(postProcessModel?.noOfTransactions >= 1 && postProcessModel?.frequency != null) ? 'Repeat' : 'Pay Later'}
				</p></li>
			<li>
				<p>
					<span class="lft_dtl"> ${(postProcessModel?.noOfTransactions >= 1 && postProcessModel?.frequency != null) ? 'Start Date' : 'Payment Date'}
					</span> <span class="rht_dtl"><vayana:formatDate
							date="${postProcessModel?.paymentDate}" showTime="false" /></span>
				</p>
			</li>
			<g:if test="${postProcessModel?.noOfTransactions >= 1 && postProcessModel?.frequency != null}">
				<li>
					<p>
						<span class="lft_dtl">Frequency</span> <span class="rht_dtl">
							${postProcessModel?.frequency}
						</span>
					</p>
				</li>
				<li>
					<p>
						<%--<span class="lft_dtl">Number Of Times</span> <span class="rht_dtl">
							${postProcessModel?.noOfTransactions}
						</span>
					--%>
					<span class="lft_dtl">End Date</span> <span class="rht_dtl"><vayana:formatDate
							date="${postProcessModel?.endDate}" showTime="false" /></span>
					
					</p>
				</li>
			</g:if>
		</g:if>
		
	</ul>

<%--<div class="info">--%>
<%--	<p>--%>
<%--		<span></span><strong>Terms and Condition</strong>--%>
<%--	</p>--%>
<%--	<p>Terms and condition will come here.</p>--%>
<%--</div>--%>
	<g:hiddenField name="toTSTCode" id="toTSTCode"
		value="${postProcessModel?.toTSTCode}" />
<%--	<br />--%>
<%--	<p>--%>
<%--		<label><input type="checkbox" name="terms" id="terms"--%>
<%--			required="required"--%>
<%--			data-errormessage="You have to agree the terms and condition to proceed" />--%>
<%--			I agree the above terms and conditions</label>--%>
<%--	</p>--%>   
<br />
<br />
<br />
<g:if test="${postProcessModel?.toTSTCode.contains('IMPS')}">
   <g:if test="${favPaymentDetailModel?.expiryDaysCount < favPaymentDetailModel?.transactionExpiryPeriod}">                                       
	<div id="dynamicAuthContent">
	<div class="buttons" id="btns_paynow">
		<g:submitToRemote name="approve" value="Approve" id="approve" class="btn_next"
			action="approvePreConfirmImps" controller="payment"
			update="dynamicContent"
			before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
			onSuccess="onPreAppSuccess(data,textStatus)" />
		<g:submitToRemote name="reject" value="Reject" id="reject"
			action="rejectPreConfirm" controller="payment" class="btn_next"
			update="dynamicContent"
			before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
			onSuccess="onPreRejSuccess(data,textStatus)" class="btn_next" />
	</div>
	<div id="dynamicContent" class="flds-block"></div></div>
</g:if>
<g:else>
	<div class="failure">
	<p>
		<g:message code="payment.templates.common.paymentAuthConfirm.transexpiry.message" />
	</p>
	</div>
</g:else>
  
</g:if>
<g:else>
    
    <g:if test="${favPaymentDetailModel?.expiryDaysCount < favPaymentDetailModel?.transactionExpiryPeriod}">                                         
	<div id="dynamicAuthContent">
	<div class="buttons" id="btns_paynow">
		<g:submitToRemote name="approve" value="Approve" id="approve" class="btn_next"
			action="approvePreConfirm" controller="payment"
			update="dynamicContent"
			before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
			onSuccess="onPreAppSuccess(data,textStatus)" />
		<g:submitToRemote name="reject" value="Reject" id="reject"
			action="rejectPreConfirm" controller="payment" class="btn_next"
			update="dynamicContent"
			before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
			onSuccess="onPreRejSuccess(data,textStatus)" class="btn_next" />
	</div>
	<div id="dynamicContent" class="flds-block"></div></div>
</g:if>
<g:else>
	<div class="failure">
	<p>
		<g:message code="payment.templates.common.paymentAuthConfirm.transexpiry.message" />
	</p>
	</div>
</g:else>


</g:else> 

	<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
</div>

<script>
function onPreAppSuccess(data,textStatus){
	
	$("#approve,#reject").attr('disabled','disabled');
	$("#approve").addClass("btn_show");
	$("#dynamicContent").css("display","block");
	$("#dynamicContent").dynamicfieldupdate();
	
}
function onPreRejSuccess(data,textStatus){
	
	$("#approve,#reject").attr('disabled','disabled');
	$("#reject").addClass("btn_show");
	$("#dynamicContent").css("display","block");
	$("#dynamicContent").dynamicfieldupdate();
	
}


</script>
