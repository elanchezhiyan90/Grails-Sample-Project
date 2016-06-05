<html>
	<head>
		<meta name="layout" content="gateway"/>		
		<parameter name="themeName" value="${params.themeName}" />
		</head>
<body>
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">Logo</a></h1>
  </div> 
</header>

<div class="content">
<section class="app-section">
		<vayana:messages/>
		<g:form name="frmbillpayment">			
			<%--${paymentResponseModel?.dump()}
						
			--%><h2 style="text-align:center;">Bill Payment</h2>
			
	<ul class="payment_dtls" style="margin:5% 10%;">
    	 <li><p class="hdr">From Account</p></li>
        <li>
        	<div class="dtl_wralp">
                <div class="amt_dtl">
                 <vayana:formatFromAccount accountId="${PayerInsModel}"/>                  
                  <g:hiddenField name="fromAccountId" value="${PayerInsModel}"/>     
                  <g:hiddenField name="toAccountId" value="${PayeeInstModel}"/>             	
                </div>
             
           </div>
	           <div class="amt_dtl">
				    <%--<p>Debiting Amount</p>                
	                <p>INR ${paymentResponseModel?.amount} </p>
	                --%><g:hiddenField name="paymentAmount" value="${paymentResponseModel?.amount}"/>	
	            </div>
        </li><%--
        <li><p class="hdr">To</p></li>
        <li>
            <div class="dtl_wralp">
                    <div class="lft_dtl">
                      ${paymentResponseModel?.narration}
                       <g:hiddenField name="toAccountId" value="${PayeeInstModel}"/> 
                    </div>                    
             </div>		             
        </li>
         --%>
         <li><p class="hdr">Biller</p></li>
        <li>        	
	        <div class="dtl_wralp">
	        	 <div class="lft_dtl">
						<p><span></span></p>
				</div>
	        	<div class="rht_dtl">
	        		<p></p>	        		
	        		<p><span>${paymentResponseModel?.merchantId}</span> </p>					
	        	</div>
	        </div>	
        </li>
         
         <li><p class="hdr">Transaction Amount</p></li>
         <li>
        	 <div class="amt_dtl">
                <p>Currency &amp; Amount</p>
					<p><span class="cur">INR</span><span class="amt"> ${paymentResponseModel?.amount}</span></p>
					<g:hiddenField name="currencyId" value="${baseCurrency?.idVersion}"/>
        	</div>
        </li>
        
         <li><p class="hdr">Remarks</p></li>
        <li>        	
	        <div class="dtl_wralp">
	        	 <div class="lft_dtl">
						<p><span></span></p>
				</div>
	        	<div class="rht_dtl">
	        		<p></p>	        		
	        		<p><span>${paymentResponseModel?.narration}</span> </p>
					<g:hiddenField name="paymentRemarks" value="${paymentResponseModel?.narration}"/>
	        	</div>
	        </div>	
        </li>
        
        <g:hiddenField name="thirdPartyReferenceId" value="${paymentResponseModel?.traceNumber}"/>
        <%--<li><p class="hdr">BillDesk Transaction Reference No</p></li>
        <li>        	
	        <div class="dtl_wralp">
	        	 <div class="lft_dtl">
					<p><span></span></p>
				</div>
	        	<div class="rht_dtl">
	        			<p><span>${paymentResponseModel?.traceNumber}</span> </p>
						<g:hiddenField name="thirdPartyReferenceId" value="${paymentResponseModel?.traceNumber}"/>
	        	</div>
	        </div>	
        </li>
    
    
    --%><li>
   <div id="dynamicAuthContent">
	<div class="buttons" id="exebtndiv">
		<g:submitToRemote action="executeBillDeskPayment" value="Make Payment" controller="billPayment" id="executeBillDeskPayment" name="executeBillDeskPayment" update="[success:'dynamicAuthContent',failure:'messagesDiv']"  onSuccess="onExecuteSuccess(data,textStatus);" ></g:submitToRemote>		
	</div>
	</div>
	</li>
	
	
	
	<li id="gotoApplication" style="display:none">
		 <div class="dtl_wralp">
	        	 <div class="lft_dtl">
	        	 <p></p>
					<p><span><g:link controller="billPayment" action="ibLogin" class="lnk" target="_self">Internet Banking</g:link></span></p>
				</div>
	        	<div class="rht_dtl">
	        	<p></p>
	        		<p><span><g:link controller="billPayment" action="billDesk" class="lnk" target="_self">Do another Bill Pay</g:link></span> </p>						
	        	</div>
	        </div>	
	</li>
	
	</ul>		
		</g:form>
		</section>		
</div><!-- End of content -->
<footer class="footwrap">
	<div class="foot_right">
		<p>
			<g:message code="home.templates.footer.copyright.label" />
		</p>
	</div>
</footer>
<g:javascript>

function onExecuteSuccess(data,textStatus){
	$("#dynamicAuthContent").dynamicfieldupdate();	
}

function callFunction(coreReference){
  		alert('callFunction1');
  		<g:remoteFunction controller="billPayment"
			action="paymentIntimation"
			params="\'coreRef=\'+coreReference+\'&status=\'+coreReference+\'&billDeskRef=\'+coreReference"
		 />
  	}

</g:javascript>
</body>
</html>
