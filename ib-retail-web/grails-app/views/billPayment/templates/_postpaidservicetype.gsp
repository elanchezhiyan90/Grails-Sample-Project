<input type="number" step="any" name="paymentAmount" maxlength="16"
id="paymentAmount" class="s_amt" min="1"
data-errormessage="${message(code:'billpayment.templates.billpayment.amount.error.message')}" value="" />

<g:submitToRemote action="billInquiry" controller="billPayment" 
	name="submit" id="submit" 
	value="Get Outstanding"
	update="updateBillInquiry"
	onSuccess="onBillInquirySuccess(data,textStatus)" 
	onFailure="onBillInquiryFailure(XMLHttpRequest.responseText)"				
	class="btn_next" />
<g:hiddenField name="billerServiceType" id="billerServiceType" value="${billServiceModel?.billerInstruction?.billerService?.code}"/>				
		