  <div class="success">
  <span></span><p><g:message code="billpayment.templates.billpaymentcorerefnumber.success.message" /><br /> <g:message code="billpayment.templates.billpaymentcorerefnumber.referencenumber.text" /><b>${transferResponseModel?.coreReferenceNumber}</b></p>
  </div>
   <script>
  	$(document).ready(function() {
  		$("#ulaccountsh3",window.parent.document).attr("data-dflag","true");
  		$("#ulaccounts li",window.parent.document).remove();
  		$("#ulOwnAccountsPayh3",window.parent.document).attr("data-dflag","true");
  		$("#ulOwnAccountsPay li",window.parent.document).remove();
  		$("#gotoApplication").show();
  		callFunction('${transferResponseModel?.coreReferenceNumber}','000','${transferRequestModel?.thirdPartyReferenceId}');
  		//postUrl('frmPgPayment','/ib-retail-web/billPayment/pgCallBackOnSuccess?paymentRes=${transferResponseModel}&coreRef=${transferResponseModel?.coreReferenceNumber}','_self');    		
  	}); 

  	function callFunction(coreReference,status,billdeskReference){
  		//alert('callFunction'+coreReference);  		
  		<g:remoteFunction controller="billPay"
			action="paymentIntimation"
			params="\'coreRef=\'+coreReference+\'&status=\'+status+\'&billDeskRef=\'+billdeskReference" />
  	}
  	
  </script>	
  	
  			
  	 	
   