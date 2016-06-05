  <div class="success">
  <span></span><p><g:message code="payment.templates.creditcard.corerefnumber.success.message" /><br /><g:message code="payment.templates.creditcard.corerefnumber.referencenumber.label" /><b>${transferResponseModel?.coreReferenceNumber }</b></p>
  </div>
  <script>
  	$(document).ready(function() {
  		alert("Into CC Paymnet");
  		$("#ulaccountsh3",window.parent.document).attr("data-dflag","true");
  		$("#ulaccounts li",window.parent.document).remove();
  		$("#ulOwnAccountsPayh3",window.parent.document).attr("data-dflag","true");
  		$("#ulOwnAccountsPay li",window.parent.document).remove();
  	});
  	
  </script>