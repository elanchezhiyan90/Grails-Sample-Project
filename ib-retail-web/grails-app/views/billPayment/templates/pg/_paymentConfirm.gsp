<h2 style="text-align:center;">Payment Gateway</h2>
<div style="width:50%;margin:0 auto;">
<div class="mandi-note">
			<span class="mandi"></span>
			<p><g:message code="payment.templates.ownaccount.transfer.mandatory.fields.label" /></p>
		</div>
	<ul class="payment_dtls">
    	 <li><p class="hdr">From</p></li>
        <li>
        	<div class="dtl_wralp">
                <div class="lft_dtl">
                    <vayana:formatFromAccount accountId="${postProcessModel?.fromAccountId}"/>
                </div>
                <div class="rht_dtl">
                    <%--<p>Exchange Rate</p>
                    <p>${postProcessModel?.transferCurrency} 1 = ${postProcessModel?.fromCurrency} ${postProcessModel?.fromExchangeRate}</p>
                --%></div>
                <%--<div class="amt_dtl">
			    	<p>Debit Amount</p>                
                	<p> <vayana:formatTransactionAmount transactionAmount="${postProcessModel?.debitAmount}" transactionCurrency="${postProcessModel?.fromCurrency}" /> </p>
            	</div>
                --%>
           </div>
	           <div class="amt_dtl">
				    <p>Debiting Amount</p>                
	                <p> <vayana:formatTransactionAmount transactionAmount="${postProcessModel?.debitAmount}" transactionCurrency="${postProcessModel?.fromCurrency}" /> </p>
	            </div>
        </li>
               
        <li><p class="hdr">Merchant Name</p></li>
        <li>        	
	        <div class="dtl_wralp">
	        	 <div class="lft_dtl">
						<p><span class="lft_dtl"></span> </p>
				</div>
	        	<div class="rht_dtl">
	        		<p><span>${postProcessModel?.merchantName}</span></p>
	        	</div>
	        </div>	
        </li>
        
         <li><p class="hdr">Transfer Amount</p></li>
         <li>
        	 <div class="amt_dtl">
                <p>Currency &amp; Amount</p>
					<p> <vayana:formatTransactionAmount transactionAmount="${postProcessModel?.transactionAmount}" transactionCurrency="${postProcessModel?.transferCurrency}" /> </p>
        	</div>
        </li>
        
        <li>
        <p class="hdr">Transaction Date</p>
        </li>
        <li>
        	 <div class="dtl_wralp">
	        	 <div class="lft_dtl">
						<p><span class="lft_dtl"></span> </p>
				</div>
	        	<div class="rht_dtl">
	        		<p><span><vayana:formatDate
							date="${new Date()}" showTime="false" /></span></p>
	        	</div>
	        </div>	
        </li>
        
        <li>
        <p class="hdr">Third Party Reference</p>
        </li>
        <li>
        	 <div class="dtl_wralp">
	        	 <div class="lft_dtl">
						<p><span class="lft_dtl"></span> </p>
				</div>
	        	<div class="rht_dtl">
	        		<p><span>${postProcessModel?.thirdPartyRefId}</span></p>
	        	</div>
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
        
       <%--<g:if test="${!postProcessModel?.chargeCurrency.equals(null)}">
	        <li><p class="hdr">Bank Fee</p></li>
	        <li>
	        	<div class="dtl_wralp">
	        	
	            	<div class="lft_dtl">
	                    <p>Transfer Fee</p>
	                    <p>${postProcessModel?.chargeCurrency}<vayana:formatAmount currency="${postProcessModel?.chargeCurrency}" amount="${postProcessModel?.chargeAmount}"/>= ${postProcessModel?.fromCurrency} <vayana:formatAmount currency="${postProcessModel?.fromCurrency}" amount="${postProcessModel?.exactChargeAmount}"/></p>
	                </div>
	                <div class="rht_dtl"> 
	                	<p>Exchange rate</p>
	                    <p>${postProcessModel?.chargeCurrency} ${postProcessModel?.chargeExchangeRate}</p>
	                </div>             
	            </div>
	        </li>
         </g:if>
    --%>
    
  <li>
    <div id="dynamicAuthContent">
		<div class="buttons" id="confbtndiv">
		<g:submitToRemote action="fetchBillPaymentSecurityAdvice" controller="security"
			update="[success:'dynamicAuthContent',failure:'messagesDiv']"
			before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
			onSuccess="onAuthSuccess(data,textStatus)"
			name="tranXConfirm"
			value="${g.message(code:"payment.templates.friendsandfamily.transfer.paynow.confirm.button.text") }"
			id="tranXConfirm" />
		<input type="button" value="Cancel" class="btn_next" id="canceltrans"  onclick="postUrl('frmPgPayment','/ib-retail-web/billPayment/cancelPGTransaction','_self');" />	   
	 </div>
   </div>
   </li>	
</ul>
</div>