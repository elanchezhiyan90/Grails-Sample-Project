<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>
<h2>BulkPayment - Review and Process</h2>
<br />
<g:hiddenField name="toTSTCode" id="toTSTCode" value="${toTSTCode}" />
<g:if test="${datelineRef}">
			<g:hiddenField name="datelineReferenceId" value="${datelineRef}" />
</g:if>
<div id="mainContent">
	<table border="0" cellpadding="0" cellspacing="0" class="grid">
	<thead class="grid_theader">
		<tr>
			<th width="2%"><g:checkBox name="checkAll" id="checkAll" value="${datelineRef}" checked="false" /></th>
			<th width="5%">S.No</th>
			<th width="8%">Employee No</th>
			<th width="20%">Beneficiary Name</th>
			<th width="15%">Account Number</th>
			<th width="5%">Currency</th>
			<th width="10%">Amount</th>
			<th width="10%">Value Date</th>
			<th width="5%">IFSC Code</th>
			<th width="10%">Bank Name</th>
			<th width="10%">Narration</th>
			<th width="5%">Status</th>
		</tr>		
		</thead>
		<tbody>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>			
			<g:if test="${bulkPaymentHeaderModel?.bulkPaymentDetails}">
				<g:each in="${bulkPaymentHeaderModel?.bulkPaymentDetails}" var="bulkPaymentdtl" status="index">
					<tr>
						<td>
						<g:if test="${LookupCodeConstants.PENDING_AUTH.equals(bulkPaymentdtl?.status?.code)}">
								<g:checkBox name="chkForProcess" id="${bulkPaymentdtl?.id}" value="${bulkPaymentdtl?.id}" checked="false" />
							</g:if>
							<g:else>
								<g:checkBox name="chkForProcess" id="${bulkPaymentdtl?.id}" value="${bulkPaymentdtl?.id}" checked="false" disabled="disabled" />
						</g:else>
						</td>
						<td>${index+1}</td>
						<td>${bulkPaymentdtl?.beneficiaryReferenceNumber}</td>
						<td>${bulkPaymentdtl?.beneficiaryName}</td>
						<td>${bulkPaymentdtl?.beneficiaryAccountNumber}</td>
						<td>${bulkPaymentdtl?.paymentCurrency?.code}</td>
						<td><vayana:formatAmount currency="${bulkPaymentdtl?.paymentCurrency?.code}" amount="${bulkPaymentdtl?.paymentAmount}"></vayana:formatAmount></td>
						<td><vayana:formatDate date="${bulkPaymentdtl?.valueDate}" showTime="false" /></td>
						<td>${bulkPaymentdtl?.electronicClearingCode}</td>
						<td>${bulkPaymentdtl?.bankName}</td>
						<td>${bulkPaymentdtl?.bankNarration}</td>	
						<td>${bulkPaymentdtl?.status?.description}</td>
					</tr>				
				</g:each>
			</g:if>	
			<g:else>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;No Record(s) Found</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			</g:else>		
		</tbody>
	</table>
	</div>
	
	<br />
	<br />
	
	<g:if test="${bulkPaymentHeaderModel?.bulkPaymentDetails}">	
	 <div class="buttons" id="btns_paynow">
		<g:submitToRemote name="approve" value="Approve" id="approve"
			action="approveBulkPaymentPreConfirm" controller="payment"
			update="dynamicContent"
			before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
			onSuccess="onPreAppSuccess(data,textStatus)" />
		<g:submitToRemote name="reject" value="Reject" id="reject"
			action="rejectBulkPaymentPreConfirm" controller="payment"
			update="dynamicContent"
			before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
			onSuccess="onPreAppSuccess(data,textStatus)" class="btn_next" />
	</div>		
		
   <div id="dynamicContent">
   
   </div>
   
   </g:if>
	<script>
function onPreAppSuccess(data,textStatus){
	$("#approve,#reject").attr('disabled','disabled');
	$("#dynamicContent").dynamicfieldupdate();	
}

$(document).ready(function (){
	$("#checkAll").click(function () {
	    if ($("#checkAll").is(':checked')) {
	        $("input[type=checkbox]").each(function () {
	            $(this).attr("checked", true);
	        });
	
	    } else {
	        $("input[type=checkbox]").each(function () {
	            $(this).attr("checked", false);
	        });
	    }
	});
});


</script>