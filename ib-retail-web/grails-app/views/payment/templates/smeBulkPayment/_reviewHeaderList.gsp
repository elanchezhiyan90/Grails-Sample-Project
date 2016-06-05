<%@ page import = "com.vayana.ib.bm.core.impl.service.util.IBDateUtils" %>	
<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>		
<g:form name="transferReviewForm" controller="payment">   
<g:hiddenField name="toTSTCode" id="toTSTCode" value="${toTSTService}" />
<div class="fields">
<p>&nbsp;</p>
</div>
<h3>File Upload - Review and Process</h3>
<br />

<div id="mainContent">
	<table border="0" cellpadding="0" cellspacing="0" class="grid">
	<thead class="grid_theader">
		<tr>
			<th width="5%">&nbsp;</th>
			<th width="20%">File Name</th>
			<th width="20%">File Type</th>
			<th width="25%">Initiated By</th>
			<th width="10%">Transaction Count</th>
			<th width="25%" class="amt">Debit Account Number</th>
			<th width="5%">&nbsp;</th>
		</tr>
		<tr>
			<th>&nbsp;</th>
			<th>Ref.no</th>
			<th>Status</th>
			<th>Upload Date</th>
			<th>Payment Date</th>
			<th class="amt">Total Value</th>
			<th>&nbsp;</th>
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
			<g:if test="${bulkPaymentHeaderModel}">
				<g:each in="${bulkPaymentHeaderModel}" var="bulkPaymentHdr" status="index">
					<tr>
						<td>
							<g:if test="${LookupCodeConstants.DRAFT.equals(bulkPaymentHdr?.status?.code)}">
								<g:checkBox name="chkBox" id="${bulkPaymentHdr?.id}" value="${bulkPaymentHdr?.id}" checked="false" />
							</g:if>
							<g:else>
								<g:checkBox name="chkBox" id="${bulkPaymentHdr?.id}" value="${bulkPaymentHdr?.id}" checked="false" disabled="disabled" />
							</g:else>
						</td>
							
						<td><span>
							<g:remoteLink action="showBulkFileContent" title="${bulkPaymentHdr?.fileName}" id="${bulkPaymentHdr?.id}" class="ceebox" params="[hdrId:"${bulkPaymentHdr?.id}"]">${bulkPaymentHdr?.fileName}</g:remoteLink>						
						</span>${bulkPaymentHdr?.referenceTag}</td>
						<td><span>${bulkPaymentHdr?.bulkPaymentType}</span>${bulkPaymentHdr?.status?.description}</td>
						<td><span>${bulkPaymentHdr?.ibUserLoginProfile?.userProfile?.firstName}</span>${IBDateUtils.getFormatDate(bulkPaymentHdr?.createdDate)}</td>
						<td><span>${bulkPaymentHdr?.totalPaymentCount}</span><vayana:formatDate date="${bulkPaymentHdr?.paymentDate}" showTime="false" /></td>
						<td class="amt"><span>${bulkPaymentHdr?.bulkPaymentDetails[0]?.payerInstruction?.accountNumber}</span><span class="cur currency">${bulkPaymentHdr?.currency?.code}</span><vayana:formatAmount currency="${bulkPaymentHdr?.currency?.code}" amount="${bulkPaymentHdr?.totalPayment}"></vayana:formatAmount></td>
						<td>
						<g:if test="${LookupCodeConstants.DRAFT.equals(bulkPaymentHdr?.status?.code)}">
						<g:remoteLink class="remove"
								before="if (!deleteRecord('${bulkPaymentHdr?.id}','${bulkPaymentHdr?.referenceTag}')) {return false;}"
								controller="payment" action="discardBulkPaymentTransaction">Delete</g:remoteLink>
						</g:if>
						<g:else>&nbsp;</g:else>
						</td>										
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
			</tr>
			</g:else>		
		</tbody>
	</table>
	</div>
	
 <br />
 <g:if test="${bulkPaymentHeaderModel?.size > 0}">
    <div id="dynamicAuthContent">
		<div class="buttons" id="confbtndiv">		
		<vayana:securitysetting controller="security" value="${g.message(code:"payment.templates.bulk.transfer.proceed.submit.label")}"
			action="fetchSecurityAdviceForAService" successAction="proceedForApproval"
			successController="payment" targetService="${toTSTService}" formName="transferReviewForm" displayAsPopUp="NO"/>			
		<input type="button" value="Cancel" class="btn_next" id="canceltrans"  onclick="postUrl('frmPayment','/ib-retail-web/payment/smeBulkPayment','canvas');closefolder();" />
	</div>
   </div>
   </g:if>
   </g:form>	
   