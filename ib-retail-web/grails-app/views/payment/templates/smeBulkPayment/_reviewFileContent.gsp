<g:form name="transferReviewForm" controller="payment">   
<g:hiddenField name="toTSTCode" id="toTSTCode" value="${toTSTService}" />
<div id="mainContent">
	<table border="0" cellpadding="0" cellspacing="0" class="grid">
	<thead class="grid_theader">
		<tr>
			<%--<th width="5%">S.No</th>
			--%><th width="10%">Employee No</th>
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
			</tr>			
			<g:if test="${bulkPaymentHeaderModel?.bulkPaymentDetails}">
				<g:each in="${bulkPaymentHeaderModel?.bulkPaymentDetails}" var="bulkPaymentdtl" status="index">
					<tr><%--
						<td>${index+1}</td>
						--%><td>${bulkPaymentdtl?.beneficiaryReferenceNumber}</td>
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
</g:form>
