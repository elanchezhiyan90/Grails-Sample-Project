   <script>
  	$(document).ready(function() {
  		postUrl('frmPgPayment','/ib-retail-web/billPayment/pgCallBackOnSuccess?coreRef=${transferResponseModel?.coreReferenceNumber?.trim()}&paymentStatus=${transferResponseModel?.paymentHeader?.paymentDetails[0]?.status?.code}','_self');
  	});  	
  </script>