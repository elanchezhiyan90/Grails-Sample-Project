<div class="f-panel" id="ftpanel">
	<h2>Payment Gateway</h2>
	<g:if test="${datelineRef}">
			<g:hiddenField name="datelineReferenceId" value="${datelineRef}" />
			<g:hiddenField name="paymentDetailId" id="paymentDetailId" value="${postProcessModel?.paymentDetailId}" />
			
	</g:if>
	<div class="mandi-note">
			<span class="mandi"></span>
			<p><g:message code="payment.templates.ownaccount.transfer.mandatory.fields.label" /></p>
		</div>
	<ul class="payment_dtls">
		
		<li><p class="hdr">Initiated By</p></li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
				<p>Maker</p>
				</div>
				<div class="rht_dtl">
					<p>${postProcessModel?.maker}</p>
				</div>
			</div>
			
		</li>
		<li><p class="hdr">From</p></li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<vayana:formatFromAccount
						accountId="${postProcessModel?.fromAccountId}" />
				</div>
				<div class="rht_dtl">
					<%--<p>Exchange Rate</p>
                    <p>${postProcessModel?.transferCurrency} 1 = ${postProcessModel?.fromCurrency} ${postProcessModel?.fromExchangeRate}</p>
                --%>
				</div>
				<%--<div class="amt_dtl">
			    	<p>Debit Amount</p>                
                	<p> <vayana:formatTransactionAmount transactionAmount="${postProcessModel?.debitAmount}" transactionCurrency="${postProcessModel?.fromCurrency}" /> </p>
            	</div>
                --%>
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

		<li><p class="hdr">Merchant Name</p></li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>
						<span class="lft_dtl"></span>
					</p>
				</div>
				<div class="rht_dtl">
					<p>
						<span> ${postProcessModel?.merchantName}
						</span>
					</p>
				</div>
			</div>
		</li>

		<li><p class="hdr">Transfer Amount</p></li>
		<li>
			<div class="amt_dtl">
				<p>Currency &amp; Amount</p>
				<p>
					<vayana:formatTransactionAmount
						transactionAmount="${postProcessModel?.transactionAmount}"
						transactionCurrency="${postProcessModel?.transferCurrency}" />
				</p>
			</div>
		</li>
		
		<li><p class="hdr">Payment Date</p></li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>
						<span class="lft_dtl"></span>
					</p>
				</div>
				<div class="rht_dtl">
					<p>
						<span ><vayana:formatDate
							date="${postProcessModel?.paymentDate}" showTime="false" /></span>
					</p>
				</div>
			</div>
		</li>
		<li><p class="hdr">Third Party Reference</p></li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>
						<span class="lft_dtl"></span>
					</p>
				</div>
				<div class="rht_dtl">
					<p>
						<span> ${postProcessModel?.thirdPartyRefId}
						</span>
					</p>
				</div>
			</div>
		</li>
		<li><p class="hdr">Remarks</p></li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>
						<span class="lft_dtl"></span>
					</p>
				</div>
				<div class="rht_dtl">
					<p>
						<span> ${postProcessModel?.remarks}
						</span>
					</p>
				</div>
			</div>
		</li>
	</ul>
	<g:hiddenField name="toTSTCode" id="toTSTCode" value="${postProcessModel?.toTSTCode}" />
	<br> <br>
<g:if test="${postProcessModel?.isValid}">
	<div id="dynamicAuthContent">
		<div class="buttons" id="btns_paynow">
			<g:submitToRemote name="approve" value="Approve" id="approve"
				class="btn_next" action="approvePGPreConfirm" controller="billPayment"
				update="dynamicContent"
				before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
				onSuccess="onPreAppSuccess(data,textStatus)" />
			<g:submitToRemote name="reject" value="Reject" id="reject"
				action="rejectPGPreConfirm" controller="billPayment" class="btn_next"
				update="dynamicContent"
				before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
				onSuccess="onPreRejSuccess(data,textStatus)" class="btn_next" />
		</div>
		<div id="dynamicContent" class="flds-block"></div>
	</div>
</g:if>
<g:else>
<div class="failure">
	<p>
		<g:message code="payment.templates.common.paymentAuthConfirm.transexpiry.message" />
	</p>
	</div>
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