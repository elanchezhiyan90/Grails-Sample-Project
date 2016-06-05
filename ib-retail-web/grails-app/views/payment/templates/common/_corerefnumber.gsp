  <div class="success">
  <%--<span></span>
  <p>
  	<g:message code="payment.templates.friendsandfamily.corerefnumber.success.message" />
  <br />
   <g:message code="payment.templates.friendsandfamily.corerefnumber.referencenumber.label" />
   	<b>${transferResponseModel?.coreReferenceNumber }</b>
   </p>
   
   
   --%><p><span></span><strong><g:message code="payment.templates.friendsandfamily.corerefnumber.success.message" /></strong></p>
    	<p><g:message code="payment.templates.friendsandfamily.corerefnumber.referencenumber.label" /> <b>${transferResponseModel?.coreReferenceNumber }</b> </p>
    	<g:hiddenField name="transferType" value="${transferType}" />
    	<g:hiddenField name="transactionType" value="${transactionType}" />
    	<g:hiddenField name="paymentTypeFilter" value="${paymentTypeFilter}" />
  </div>
  <%--<br>
	<br>
	 <div  id="print">
       
   		<input type ="button"  value="Print"  id="print"  onclick="window.print()" />	   
   	 </div>
  --%><script>
  	$(document).ready(function() {
  		var tranType = $("#transferType").val();
  		var transType = $("#transactionType").val();
  		var paymentType = $("#paymentTypeFilter").val();
  		if(tranType!='' && tranType == "OWNACCTRNS" && transType!='' &&  transType=="PAYNOW")
  		{
  			$("#ulaccountsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulaccounts li",window.parent.document).remove();
	  		$("#ulOwnAccountsPayh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulOwnAccountsPay li",window.parent.document).remove();
  			$("#ulOwnAccountsPayh3",window.parent.document).trigger("click");
  		}
  		if(tranType!='' && tranType == "NEFT" && transType!='' &&  transType=="PAYNOW")
  		{
  			$("#ulaccountsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulaccounts li",window.parent.document).remove();
	  		$("#ulOwnAccountsPayh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulOwnAccountsPay li",window.parent.document).remove();
	  		
  			$("#ulFriendsAndFamilyPayh3",window.parent.document).attr("data-dflag","true");
 			$("#ulFriendsAndFamilyPay li",window.parent.document).remove();
 			$("#ulFriendsAndFamilyPayh3",window.parent.document).trigger("click")
  		}
  		
  		if(tranType!='' && tranType == "RTGS" && transType!='' &&  transType=="PAYNOW")
  		{
  			$("#ulaccountsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulaccounts li",window.parent.document).remove();
	  		$("#ulOwnAccountsPayh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulOwnAccountsPay li",window.parent.document).remove();
	  		
  			$("#ulFriendsAndFamilyPayh3",window.parent.document).attr("data-dflag","true");
 			$("#ulFriendsAndFamilyPay li",window.parent.document).remove();
 			$("#ulFriendsAndFamilyPayh3",window.parent.document).trigger("click")
  		}
  		
  		if(tranType!='' && tranType == "TPTTRANS" && transType!='' &&  transType=="PAYNOW")
  		{
  			$("#ulaccountsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulaccounts li",window.parent.document).remove();
	  		$("#ulOwnAccountsPayh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulOwnAccountsPay li",window.parent.document).remove();
	  		
  			$("#ulFriendsAndFamilyPayh3",window.parent.document).attr("data-dflag","true");
 			$("#ulFriendsAndFamilyPay li",window.parent.document).remove();
 			$("#ulFriendsAndFamilyPayh3",window.parent.document).trigger("click")
  		}
  		
  		
  		if(tranType!='' && tranType == "OWNACCTRNSTOINVSTPAY" && transType!='' &&  transType=="PAYNOW")
  		{
  			$("#ulInvestmentsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulInvestments li",window.parent.document).remove();
	  		$("#ulInvestmentsPayh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulInvestmentsPay li",window.parent.document).remove();
  			$("#ulInvestmentsPayh3",window.parent.document).trigger("click");
  		}
  		if(tranType!='' && tranType == "OWNACCTRNSTOINTCC" && transType!='' &&  transType=="PAYNOW")
  		{
  			$("#ulaccountsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulaccounts li",window.parent.document).remove();
	  		$("#ulOwnAccountsPayh3",window.parent.document).attr("data-dflag","true");
  			
  			$("#ulCreditCardsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulCreditCards li",window.parent.document).remove();
  			$("#ulCreditCardsPayh3",window.parent.document).attr("data-dflag","true");
  			$("#ulCreditCardsPay li",window.parent.document).remove();
  			if(paymentType!='' && paymentType == "OWNCCPAYMNT"){
  				$("#ulCreditCardsPayh3",window.parent.document).trigger("click");
  			}
  			
  		}
  		if(tranType!='' && tranType == "INVSTPAYTOINTCC" && transType!='' &&  transType=="PAYNOW")
  		{
  			$("#ulInvestmentsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulInvestments li",window.parent.document).remove();
	  		$("#ulInvestmentsPayh3",window.parent.document).attr("data-dflag","true");
	  		
  			$("#ulCreditCardsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulCreditCards li",window.parent.document).remove();
  			$("#ulCreditCardsPayh3",window.parent.document).attr("data-dflag","true");
  			$("#ulCreditCardsPay li",window.parent.document).remove();
  			$("#ulCreditCardsPayh3",window.parent.document).trigger("click");
  		}
  		if(tranType!='' && tranType == "INTCCTOOWNACCTRNS" && transType!='' &&  transType=="PAYNOW")
  		{
  			$("#ulCreditCardsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulCreditCards li",window.parent.document).remove();
	  		$("#ulCreditCardsPayh3",window.parent.document).attr("data-dflag","true");
	  		
  			$("#ulaccountsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulaccounts li",window.parent.document).remove();
  			$("#ulOwnAccountsPayh3",window.parent.document).attr("data-dflag","true");
  			$("#ulOwnAccountsPay li",window.parent.document).remove();
  			$("#ulOwnAccountsPayh3",window.parent.document).trigger("click");
  		}
  	});
  	
  </script>