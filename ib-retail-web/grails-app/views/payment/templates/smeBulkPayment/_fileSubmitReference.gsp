  <div class="success">
 		<g:if test="${fileUpladReference}">
	 		<p><span></span><strong><g:message code="payment.templates.bulk.transfer.fileuploaded.label" /></strong></p>
	    	<p><g:message code="payment.templates.bulk.transfer.fileuploaded.referencenumber.label" /> <b>${fileUpladReference}</b> </p>
    	</g:if>
    	<g:else>
    		<p><span></span><strong><g:message code="payment.templates.bulk.fileuploaded.ack.msg" /></strong></p>
    	</g:else>
  </div>
  