<div class="f-panel" id="ftpanel">

<g:hiddenField name="buttonEvent" />
<g:hiddenField name="uploadedFileName" />

<g:set var="tenantServiceCode" value="${params.tenantServiceCode}" />
<g:hiddenField name="tenantServiceCodeVal" value="${params.tenantServiceCode}" />
	<g:if test="${ tenantServiceCode!=null && tenantServiceCode == 'SALARY_PAYMENT'}">
		<h2>
			<g:message code="home.templates.body.smebulkpay.salarypay.title" />				
		</h2>
	</g:if>
	<g:else>
		<h2>
			<g:message code="home.templates.body.smebulkpay.vendorpay.title" />				
		</h2>
	</g:else>		
		<%--<div class="fields" id="bulkPayType">
			<p>
				<label for="bulkPayType">${g.message(code:'payment.templates.bulk.transfer.type.label')}</label>
				<select name="bulkPayType" id="bulkPayType" required>
				<option selected="selected">Salary Payments</option>
				<option>Vendor Payments</option><g:form name="transferForm" controller="payment">   
				</select>
			</p>
		</div>		
		--%>
		
		<div class="fields">
			<p>
				<label for="from_account"><g:message code="payment.templates.friendsandfamily.transfer.fromaccount.label" /></label>
				<vayana:fromAccountSelect id="fromAccountId" name="fromAccountId"
					type="FF" poptype="CASA"
					noSelection="${['Select Payer Account':'Select Payer Account']}"
					onchange=" ${remoteFunction( 
					 						    	controller :'bulkPayment',
													update:'exchangeRateAndLimit',
											   		action:'exchangeRateAndLimit', 	
													before:'if(checkFromAccount()){return false;}',													  						
					 								params:'\'payerId=\'+payerVal()+\'&tenantServiceCode=\'+getTenantServiceCode()'
												    ,onSuccess: 'onPayerIdSuccess(data,textStatus);'													   										  		
					 					   			)}"
					required="required" data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.youraccount.error.message") }" />
				<br> <span class="selected_des" id="fromAccSelect"><g:message code="payment.templates.friendsandfamily.transfer.youraccount.selection.message" />&nbsp;</span>
			</p>

			<div class="updater" id="exchangeRateAndLimit" name="exchangeRateAndLimit"></div>
		</div>
		
		
		<div class="fields" id="filetoProcess">
				<p>
					<label for="filetoProcess"><g:message code="payment.templates.bulk.transfer.uploadfile.label" /></label>
					<fileUpload:csvuploader id="paymentFile" url="paymentFileUpload" multiple="false" params="[]" >	
						<fileUpload:onComplete>
							//alert('Upload Completed'+fileName);
							$("#uploadedFileName").val(fileName);
							//alert('Uploaded File'+fileName);
						</fileUpload:onComplete>											
					</fileUpload:csvuploader>
				</p>
		</div>		
		
		<div class="fields">
		    <p>
		        <label for="paymentDate">Payment Date</label>      
		        <vayana:vayanaDate id="paymentDate" name="paymentDate" errormessage="Please Enter The Valid Date" required="required" min="${new Date(new Date().getTime()).toTimestamp()?.format('yyyy-MM-dd')}" value="${new Date().clearTime().toTimestamp()}"/>    	
		    </p>
		</div>
		
		<div class="fields">
			<p>
				<label for="rmrk"><g:message code="payment.templates.ownaccount.transfer.remarks.label" /></label> <input type="text"
					name="paymentRemarks" id="paymentRemarks" value="" maxlength="25"
					placeholder="${g.message(code:'payment.templates.ownaccount.transfer.remarks.placeholder.text')}"  />
			</p>
		</div>
		
		<div class="fields">
			<p>
				<label><input type="checkbox" name="terms" id="terms"							
							data-errormessage="You have to agree the terms and conditions to proceed" />
							I agree the <g:remoteLink controller="bulkPayment" action="termsAndConditions"
											class="ceebox" title="${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.ceebox.text')}">
											${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.text')}
										</g:remoteLink>
							
				</label>
			</p>
		</div>
		<g:if test="${tenantServiceCode == 'SALARY_PAYMENT'}">
			<div class="buttons" id="btns_paynow">
				<br>
					<vayana:ftValidate name="payNow" buttonEvent="BULKPAY"
					value="${g.message(code:'payment.templates.bulk.transfer.submit.label') }"
					enableButton="btns_now" controller="bulkPayment"
					action="validateSalaryPayment" secondaryAction="bulkpaymentPostProcess"
					secondaryController="bulkPayment" secondaryDiv="f-panel" />		
			</div>
		</g:if>
		<g:else>
			<div class="buttons" id="btns_paynow">
				<br>
					<vayana:ftValidate name="payNow" buttonEvent="BULKPAY"
					value="${g.message(code:'payment.templates.bulk.transfer.submit.label') }"
					enableButton="btns_now" controller="bulkPayment"
					action="validateVendorPayment" secondaryAction="bulkpaymentPostProcess"
					secondaryController="bulkPayment" secondaryDiv="f-panel" />		
			</div>
		</g:else>
		
		<div class="flds-block" id="dynamicContent">		
		</div>
		
	</div>

	
	
		
		
		
