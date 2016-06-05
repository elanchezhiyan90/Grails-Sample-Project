<div id="messagesDiv">
	<g:if test="${errorCode}">
		<div class="failure">
			<span></span>
			<g:message code="${errorCode}" args="${args}" />
		</div>
	</g:if>
	<g:else>
		
		
			<div class="success">
		  		<%--<span></span><p>Open Deposit Request Initiated Successfully<br/>Reference No<b>${depositReferenceNoModel}</b></p>
		  		--%><span></span><p>Open Deposit Request Initiated Successfully<br/>TD Account Number:<b>${tdAccountNoModel}</b></p>
		  
			</div>
			<div class="info">
		  		
		  	  <span></span><p>DICGC Cover upto 1 Lakh per Depositor is Available.<br/>
              Premature Penalty will be applicable as per Bank Policy</b></p>
		  </div>

	</g:else>
</div>
<div  id="print">
      
           <input type ="button"  value="Print"  id="print" 
onclick="window.print()" />      
 </div>
<script> 
$(document).ready(function() {
$("#ulaccountsh3",window.parent.document).attr("data-dflag","true");
$("#ulaccounts li",window.parent.document).remove();
$("#ulOwnAccountsPayh3",window.parent.document).attr("data-dflag","true");
$("#ulOwnAccountsPay li",window.parent.document).remove();
});
</script>