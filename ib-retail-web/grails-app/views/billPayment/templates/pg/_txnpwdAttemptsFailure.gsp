<g:if test="${errorCode}">
	<div class="failure">
	<p>
	<g:message code="${errorCode}" args="${args}" />
	</p>
	</div>
</g:if>
   <script>
  	$(document).ready(function() {
	  		setTimeout(function(){
	  		postUrl('frmPgPayment','/ib-retail-web/billPayment/cancelPGTransaction','_self');
	  		},2000);
  	});  	
  </script>