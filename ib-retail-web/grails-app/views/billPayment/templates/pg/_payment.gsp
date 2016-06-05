<g:hiddenField name="buttonEvent" id="buttonEvent" value="PAYNOW"/>
<g:hiddenField name="thirdPartyReferenceId" id="thirdPartyReferenceId" value="${pgRequestMap?.PRN}"/>
<g:hiddenField name="toAccountId" id="toAccountId" value="${PayeeInstModel}"/>
<g:hiddenField name="currencyId" id="currencyId" value="${baseCurrency?.idVersion}"/>
<g:hiddenField name="billCurrencyId" id="billCurrencyId" value="${baseCurrency?.idVersion}"/>
<g:hiddenField name="paymentAmount" id="paymentAmount" value="${pgRequestMap?.AMT}"/>
<g:hiddenField name="returnUrl" id="returnUrl" value="${pgRequestMap?.RU}"/>
<g:hiddenField name="PID" id="PID" value="${pgRequestMap?.PID}"/>
<h2 style="text-align:center;">Payment Gateway</h2>

<div style="width:50%;margin:0 auto;">
<div class="mandi-note">
			<span class="mandi"></span>
			<p><g:message code="payment.templates.ownaccount.transfer.mandatory.fields.label" /></p>
		</div>
	<ul class="payment_dtls">
		<li><p class="hdr"><g:message code="payment.templates.friendsandfamily.transfer.fromaccount.label" /></p></li>
		 <li>
		 	
			    	 <div class="fields">
						<p>
							<%--<label for="from_account"><g:message code="payment.templates.friendsandfamily.transfer.fromaccount.label" /></label>
							--%><vayana:fromAccountSelect id="fromAccountId" name="fromAccountId"
								type="FF" poptype="CASA" pgIdentifier="YES"
								noSelection="${['Select Payer Account':'Select Payer Account']}"
								onchange=" ${remoteFunction( 
								 						    	controller :'billPayment',
																update:'balance',
														   		action:'fromaccountbalanceandexgrate', 	
																before:'if(checkFromAccount()){return false;}',													  						
								 								params:'\'payerId=\'+payerVal()+\'&payeeId=\'+billerInstructionVal()' 
															    ,onSuccess: 'onPayerIdSuccess(data,textStatus);'													   										  		
								 					   			)}"
								required="required" data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.youraccount.error.message") }" />
							<br> 
							<span class="selected_des" id="fromAccSelect"><g:message code="payment.templates.friendsandfamily.transfer.youraccount.selection.message" />&nbsp;</span>
						</p>
							<div class="updater" id="balance"></div>
					</div>
		 </li>
       
       
		 <li><p class="hdr">Merchant Name</p></li>
         <li>
        	 <div class="dtl_wralp">
               <div class="lft_dtl">
						<p><span class="lft_dtl"></span> </p>
				</div>						
				<div class="rht_dtl">
	        		<p><span>${pgRequestMap?.ITC}</span></p>
	        	</div>								
        	</div>
        </li>  
        <g:hiddenField name="merchantName" value="${pgRequestMap?.ITC}"/>
             
        
        <li><p class="hdr">Transaction Amount</p></li>
         <li>
        	 <div class="amt_dtl">
                <p>Currency &amp; Amount</p>
				<p>
					<span class="cur">${pgRequestMap?.CRN}</span> <span class="amt">${pgRequestMap?.AMT}</span>
				</p>				
        	</div>
        </li>
        
        <li><p class="hdr">Transaction Date</p></li>
         <li>
        	 <div class="dtl_wralp">
               <div class="lft_dtl">
						<p><span class="lft_dtl"></span> </p>
				</div>						
				<div class="rht_dtl">
	        		<p><span><vayana:formatDate
							date="${new Date()}" showTime="false" /></span></p>
	        	</div>								
        	</div>
        </li>
         <li><p class="hdr">Third Party Reference</p></li>
         <li>
        	 <div class="dtl_wralp">
               <div class="lft_dtl">
						<p><span class="lft_dtl"></span> </p>
				</div>						
				<div class="rht_dtl">
	        		<p><span>${pgRequestMap?.PRN}</span></p>
	        	</div>								
        	</div>
        </li>
        
        <li><p class="hdr">Remarks</p></li>
        <li>        	
	        <div class="dtl_wralp">
				<div class="fields">	        
						<p>
								<%--<label for="rmrk">${message(code:'billpayment.templates.billpayment.remarks.label')}</label> --%><input type="text"
								name="paymentRemarks" id="paymentRemarks" value="${favPaymentModel?.paymentDetail?.remarks}"
								placeholder="${message(code:'billpayment.templates.billpayment.remarks.placeholder.text')}" />
						</p>
				</div>
	        	
	        </div>	
        </li>
        
        <%--<li><p class="hdr">Reference No</p></li>
        <li>        	
	        <div class="dtl_wralp">
	        	 <div class="lft_dtl">
					<p><span></span></p>
				</div>
	        	<div class="rht_dtl">
	        			<p><span>${pgRequestMap?.PRN}</span> </p>
						<g:hiddenField name="thirdPartyReferenceId" value="${pgRequestMap?.PRN}"/>
	        	</div>
	        </div>	
        </li>
    --%>
    
    
    <li>
	   <div class="buttons" id="btns_paynow">
					<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"
					value="Make Payment"
					enableButton="btns_now" controller="billPayment"
					action="validatefundtransfer" secondaryAction="paymentPostProcess"
					secondaryController="billPayment" secondaryDiv="app-section" />		
			
		<input type="button" value="Cancel" class="btn_next" id="canceltrans"  onclick="postUrl('frmPgPayment','/ib-retail-web/billPayment/cancelPGTransaction','_self');" />		
		</div>	
	</li>	
	</ul>
	
	</div>	
		
