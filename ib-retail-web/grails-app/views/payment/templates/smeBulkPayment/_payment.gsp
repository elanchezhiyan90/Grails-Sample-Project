<div class="f-panel" id="ftpanel">

<g:hiddenField name="buttonEvent" />
<g:hiddenField name="uploadedFileName" />


	<h2>
		<g:message code="home.templates.body.smebulkpay.title" />				
	</h2>		
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
					 						    	controller :'payment',
													update:'balance',
											   		action:'fromaccountbalanceandexgrate', 	
													before:'if(checkFromAccount()){return false;}',													  						
					 								params:'\'payerId=\'+payerVal()'
												    ,onSuccess: 'onPayerIdSuccess(data,textStatus);'													   										  		
					 					   			)}"
					required="required" data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.youraccount.error.message") }" />
				<br> <span class="selected_des" id="fromAccSelect"><g:message code="payment.templates.friendsandfamily.transfer.youraccount.selection.message" />&nbsp;</span>
			</p>

			<div class="updater" id="balance"></div>
		</div>
		
		
		<div class="fields" id="filetoProcess">
				<p>
					<label for="filetoProcess"><g:message code="payment.templates.bulk.transfer.uploadfile.label" /></label>
					<fileUpload:uploader id="paymentFile" url="paymentFileUpload" multiple="false" params="[]" >	
						<fileUpload:onComplete>
							//alert('Upload Completed'+fileName);
							$("#uploadedFileName").val(fileName);
							//alert('Uploaded File'+fileName);
						</fileUpload:onComplete>											
					</fileUpload:uploader>
				</p>
		</div>		
		
		<div class="fields">
		    <p>
		        <label for="paymentDate">Payment Date</label>      
		        <vayana:vayanaDate id="paymentDate" name="paymentDate" errormessage="Please Enter The Valid Date" required="required" min="${new Date(new Date().getTime() + (1000 * 60 * 60 * 24)).toTimestamp()?.format('yyyy-MM-dd')}" value=""/>    	
		    </p>
		</div>
		
		<div class="fields">
			<p>
				<label for="rmrk"><g:message code="payment.templates.ownaccount.transfer.remarks.label" /></label> <input type="text"
					name="paymentRemarks" id="paymentRemarks" value="" maxlength="25"
					placeholder="${g.message(code:'payment.templates.ownaccount.transfer.remarks.placeholder.text')}"  />
			</p>
		</div>
		
		<div class="buttons" id="btns_paynow">
		<br>
		
			<vayana:ftValidate name="payNow" buttonEvent="BULKPAY"
			value="${g.message(code:'payment.templates.bulk.transfer.submit.label') }"
			enableButton="btns_now" controller="payment"
			action="validateBulkPayment" secondaryAction="bulkpaymentPostProcess"
			secondaryController="payment" secondaryDiv="f-panel" />		
		
		</div>
		<div class="flds-block" id="dynamicContent">		
		</div>
		
	</div>

	
	
		
		
		
