  
  <div class="success">
 		<g:if test="${fileUpladReference}">
	 		<p><span></span><strong><g:message code="payment.templates.bulk.transfer.fileuploaded.label" /></strong></p>
	    	<p><g:message code="payment.templates.bulk.transfer.fileuploaded.referencenumber.label" /> <b>${fileUpladReference}</b> </p>
    	</g:if>
    	<g:else>
    		<p><span></span><strong><g:message code="payment.templates.bulk.fileuploaded.ack.msg" /></strong></p>
    	</g:else>
    	<g:if test="${bulkPayWithAuthorization == true && bulkPaymentHeaderModel?.bulkPaymentHeadersWithAuthorization != null && !bulkPaymentHeaderModel?.bulkPaymentHeadersWithAuthorization?.isEmpty()}">
    		<p><strong>${bulkPaymentHeaderModel?.bulkPaymentHeadersWithAuthorization?.collect{it?.fileName}?.join(',') } Records Have been sent for Approval</strong></p>
  		</g:if>
  		<g:if test="${bulkPayWithNoAuthorization == true && bulkPaymentHeaderModel?.bulkPaymentHeadersWithNoAuthorization != null && !bulkPaymentHeaderModel?.bulkPaymentHeadersWithNoAuthorization?.isEmpty()}">
    		<p><strong>(${bulkPaymentHeaderModel?.bulkPaymentHeadersWithNoAuthorization?.collect{it?.fileName}?.join(',') }) Records Submitted for Dual User Approval</strong></p>
  		</g:if>
  		<g:if test="${bulkPaySMEFailures == true && bulkPaymentHeaderModel?.bulkPaymentHeaderSMEFailures != null && !bulkPaymentHeaderModel?.bulkPaymentHeaderSMEFailures?.isEmpty()}">
    		<p><strong>(${bulkPaymentHeaderModel?.bulkPaymentHeaderSMEFailures?.collect{it?.fileName}?.join(',')}) Records Failed Due to SME Matrix Validation</strong></p>
  		</g:if>
  		
  </div>
  