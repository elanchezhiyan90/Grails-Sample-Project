  <div class="success">
	  <span></span>
	  <p>
	  	<g:if test="${"Y".equals(transferRequestModel.safetyNetExist)}">
	  		<g:message code="payment.templates.safetynet.success.message" /><br />
	  	 </g:if>
	  	 <g:elseif test="${transferRequestModel.isJointAuthRequired}" >
	  	 	<g:message code="payment.templates.pushedforjointauth.success.message" /><br />
	  	 </g:elseif>
	  	<g:message code="payment.templates.friendsandfamily.corerefnumber.referencenumber.label" />
	  	<b>${transferRequestModel?.referenceTag}</b>
	  </p>  
  </div>