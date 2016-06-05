<%@ page import = "com.vayana.ib.bm.core.api.model.enums.PaymentButtonEnum" %>
<h2>Send Money to ${postProcessModel?.beneficiaryNickName}</h2>
<g:if test="${true.equals(isAWarning)}">
	<g:each in="${warningErrorCodes}" var="errorCode">
		<div class="${errorClass}">
			<g:message code="${errorCode}"/>
		</div>
	</g:each>
</g:if>
<h3>${(PaymentButtonEnum.PAYNOW.toString().equals(postProcessModel?.buttonEvent)) ? 'Pay Now' : (PaymentButtonEnum.LATER.toString().equals(postProcessModel?.buttonEvent)) ? 'Pay Later' : 'Repeat'}</h3>

	<ul class="payment_dtls">
    	 <li><p class="hdr">From</p></li>
        <li>
        	<div class="dtl_wralp">
                <div class="lft_dtl">
                    <vayana:formatFromAccount accountId="${postProcessModel?.fromAccountId}"/>
                </div>
                <%--<div class="rht_dtl">
                    <p>Exchange Rate</p>
                    <p>${postProcessModel?.transferCurrency} 1 = ${postProcessModel?.fromCurrency} ${postProcessModel?.fromExchangeRate}</p>
                </div>
            --%>
            </div>
            <div class="amt_dtl">
			    <p>Debiting Amount</p>                
                <p> <vayana:formatTransactionAmount transactionAmount="${postProcessModel?.debitAmount}" transactionCurrency="${postProcessModel?.fromCurrency}" /> </p>
            </div>
        </li>
        <li><p class="hdr">To</p></li>
        <li>
            <div class="dtl_wralp">
                    <div class="lft_dtl">
                       <vayana:formatFFAccount beneInstructionId="${postProcessModel?.toAccountId}"/>
                    </div>
                    <%--<div class="rht_dtl">
                        <p>Exchange Rate</p>
                        <p>${postProcessModel?.transferCurrency} 1 = ${postProcessModel?.toCurrency} ${postProcessModel?.toExchangeRate}</p>
                    </div>
             --%>
             </div>
             <div class="amt_dtl">
                    <p>Crediting Amount</p>
                    <p><vayana:formatTransactionAmount transactionAmount="${postProcessModel?.creditAmount}" transactionCurrency="${postProcessModel?.toCurrency}" /></p>
             </div>
         </li>
         <li><p class="hdr">Transfer Amount</p></li>
         <li>
        	 <div class="amt_dtl">
                <p>Currency &amp; Amount</p>
<%--                <p><span class="cur">AED</span>&nbsp;<span class="amt">52,000.00</span></p>--%>
					<p> <vayana:formatTransactionAmount transactionAmount="${postProcessModel?.transactionAmount}" transactionCurrency="${postProcessModel?.transferCurrency}" /> </p>
        	</div>
        </li>
        <li><p class="hdr">Remarks</p></li>
        <li>
         <div class="dtl_wralp">
        	 <div class="lft_dtl">
					<p><span class="lft_dtl"></span> </p>
			</div>
        	<div class="rht_dtl">
        		<p><span>${postProcessModel?.remarks}</span></p>
        	</div>
        </div>	
        </li>
        <g:if test="${PaymentButtonEnum.PAYNOW.toString().equals(postProcessModel?.buttonEvent)}">
        <li><p class="hdr">Pay Now</p></li>
        <li>
        <div class="dtl_wralp">
        	 <div class="lft_dtl">
					<p><span class="lft_dtl">Payment Date</span> </p>
			</div>
				<div class="rht_dtl">	
					<p><span ><vayana:formatDate date="${new Date()}" showTime="false" /></span></p>
				
				</div>
			
				</div>
        </li>
        </g:if>
        <g:elseif test="${PaymentButtonEnum.LATER.toString().equals(postProcessModel?.buttonEvent)}">
        <li><p class="hdr">Pay Later</p></li>
        <li>
        	<div class="dtl_wralp">
        	<div class="lft_dtl">
        	<p>
					<span class="lft_dtl">Payment Date</span> 
			</p>
			</div>
			<div class="rht_dtl">	
			<p>
					<span class="rht_dtl"><vayana:formatDate date="${postProcessModel?.startDate}" showTime="false" /></span>
			</p>
			</div>
		</div>
        </li>
        </g:elseif>
        <g:else>
        <li><p class="hdr">Repeat</p></li>
        <li>
        	<div class="dtl_wralp">
        	
				 <div class="lft_dtl">
				<p>
				<span class="lft_dtl">Start Date</span> 
				</p>
				</div>
				<div class="rht_dtl">
				<p>
				<span ><vayana:formatDate date="${postProcessModel?.startDate}" showTime="false" /></span>
				</p>
				</div>
        	
        	 <div class="lft_dtl">
				<p>
				<span class="lft_dtl">Frequency</span> 
				</p>
			</div>
			<div class="rht_dtl">
				<p>
				<span ><g:message code="payment.templates.commom.paymentconfirm.frequency.${postProcessModel?.frequency}"/></span>
				</p>
			</div>
			 <div class="lft_dtl">
				<p>
				<span class="lft_dtl">End Date</span> 
			</p>
			</div>
			<div class="rht_dtl">
				<p>
				<span ><vayana:formatDate date="${postProcessModel?.endDate}" showTime="false" /></span>
				</p>
			</div>
		</div>
		<br/>
        </li>
        </g:else>
        
        
        <g:if test="${!postProcessModel?.chargeCurrency.equals(null)}">
        <li><p class="hdr">Bank Fee</p></li>
        <li>
        	<div class="dtl_wralp">
        	
            	<div class="lft_dtl">
                    <p>Transfer Fee (${postProcessModel?.chargeCode})</p>
                    <p>${postProcessModel?.chargeCurrency}<vayana:formatAmount currency="${postProcessModel?.chargeCurrency}" amount="${postProcessModel?.chargeAmount}"/>= ${postProcessModel?.fromCurrency} <vayana:formatAmount currency="${postProcessModel?.fromCurrency}" amount="${postProcessModel?.exactChargeAmount}"/></p>
                </div>
                <%--<div class="rht_dtl"> 
                	<p>Exchange rate</p>
                    <p>${postProcessModel?.chargeCurrency} ${postProcessModel?.chargeExchangeRate}</p>
                </div>
            --%></div>
        </li>
        </g:if>
        <g:if test="${PaymentButtonEnum.PAYNOW.toString().equals(postProcessModel?.buttonEvent)}">
         <li><p class="hdr">Total Amount</p></li>
         <li>
        	 <div class="amt_dtl">
                <p>Currency &amp; Amount</p>
					<p> <vayana:formatTransactionAmount transactionAmount="${postProcessModel?.totalTransactionAmount}" transactionCurrency="${postProcessModel?.transferCurrency}" /> </p>
        	</div>
        </li>
        </g:if>
    </ul>
    <br />
       
    <g:if test="${postProcessModel?.transactionType.contains('IMPS')&&postProcessModel?.userType}">     
    <div id="dynamicAuthContent">
			<div class="buttons" id="confbtndiv">
				<g:submitToRemote action="fetchIMPSSecurityAdvice" controller="security"
				update="[success:'dynamicAuthContent',failure:'messagesDiv']"
				before="if (checkFormValidity()) {return false;};emptyErrorDiv();emptyConfirmDiv();"
				onSuccess="onAuthSuccess(data,textStatus)"
				name="tranXConfirm"
				value="${g.message(code:"payment.templates.friendsandfamily.transfer.paynow.confirm.button.text") }"
				id="tranXConfirm" />
				<input type="button" value="Cancel" class="btn_next" id="canceltrans"  onclick="postUrl('frmPayment','/ib-retail-web/payment/${postProcessModel?.cancelAction}?beneId=${postProcessModel?.beneId}&beneNickName=${postProcessModel?.beneficiaryNickName}&creditCardNumber=${postProcessModel?.beneficiaryAccountNumber}','canvas');closefolder();" />
	   		</div>
   	  </div>
    </g:if>
    <g:else>
    	<div id="dynamicAuthContent">
			<div class="buttons" id="confbtndiv">
				<g:submitToRemote action="fetchPaymentSecurityAdvice" controller="security"
				update="[success:'dynamicAuthContent',failure:'messagesDiv']"
				before="if (checkFormValidity()) {return false;};emptyErrorDiv();emptyConfirmDiv();"
				onSuccess="onAuthSuccess(data,textStatus)"
				name="tranXConfirm"
				value="${g.message(code:"payment.templates.friendsandfamily.transfer.paynow.confirm.button.text") }"
				id="tranXConfirm" />
				<input type="button" value="Cancel" class="btn_next" id="canceltrans"  onclick="postUrl('frmPayment','/ib-retail-web/payment/${postProcessModel?.cancelAction}?beneId=${postProcessModel?.beneId}&beneNickName=${postProcessModel?.beneficiaryNickName}&creditCardNumber=${postProcessModel?.beneficiaryAccountNumber}','canvas');closefolder();" />
	   		</div>
   	  </div>
  </g:else>
    
    <br />            
	<br />
<%--    <br />				--%>
<script>
$(document).bind("keypress", function (e) {
    if (e.keyCode == 13) {
        $('#tranXConfirm').trigger("click");
        return false;
    }
});
</script>
