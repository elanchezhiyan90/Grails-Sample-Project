<%@ page import="com.vayana.ib.bm.core.api.model.enums.PayeeTypeEnum"%>
<%--<g:form name="pendingTransactionForm" id="pendingTransactionForm">--%>
 <vayana:pager controller="payment" action="pendingTransactionsPage" update="mainContent" onSuccess="onPendingPageSuccess(data,textValue);"/>
 <br>
<!-- Sticky header starts here ----------->
<div class="start-stick_top"></div>
<div class="grid_stickyhead_top" id="templateHeader">
	<table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
		<thead>
			<tr>
				<th width="20%"><g:message
						code="payment.templates.pendingTransactions.pendingTransationsList.referenceNumber.th.text" /></th>
				<th width="15%">Beneficiary A/C</th>
				<th width="15%">From A/C</th>
				<th width="10%">Payment Date</th>
				<th width="5%">Currency</th>
				<th width="10%">Amount</th>
				<th width="10%">Status</th>
				<th width="5%">&nbsp;</th>
				<th width="5%">&nbsp;</th>
			</tr>
		</thead>
	</table>
</div>
<!-- Sticky header ends here ----------->
<div id="mainContent">
	<table border="0" cellpadding="0" cellspacing="0" class="grid">
		<tbody>
			<tr>
				<td width="20%"></td>
				<td width="15%"></td>
				<td width="15%"></td>
				<td width="10%"></td>
				<td width="5%"></td>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="5%"></td>
				<td width="5%"></td>
			</tr>
			<g:if test="${pendingPaymentDetailModel}">
				<g:each in="${pendingPaymentDetailModel}" var="paymentDtl"
					status="index">
					<tr class="has-dtl" id="has-dtl_${index}">
						<td>
							${paymentDtl?.referenceTag}
						</td>
						<td>
						${paymentDtl?.payeeAccountNumber}
<%--							${(PayeeTypeEnum?.BENE.equals(paymentDtl?.payeeInstruction?.payeeType)) ? vayana.formatFFAccountNumber(beneInsIdVer:paymentDtl?.payeeInstruction?.idVersion) --%>
<%--							: vayana.formatBPAccountNumber(billInsIdVer:paymentDtl?.payeeInstruction?.idVersion) }--%>
						</td>
						<td>
							${paymentDtl?.payerInstruction?.accountNumber}
						</td>
						<td><vayana:formatDate date="${paymentDtl?.paymentDate}"
								showTime="false" /></td>
						<td>
							${paymentDtl?.paymentCurrency?.code}
						</td>
						<td><vayana:formatAmount
								currency="${paymentDtl?.paymentCurrency?.code}"
								amount="${paymentDtl?.paymentAmount}"></vayana:formatAmount></td>
						<td>
							${paymentDtl?.status?.code}
						</td>
						<td><g:remoteLink class="edit_row" controller="payment"
								action="viewPendingTransaction"
								params="[paymentDetailId:paymentDtl?.id]"
								update="editDataDiv_${index}"
								onSuccess="resizeEditContainer('${index}');">Edit</g:remoteLink>

						</td>
						<td><g:remoteLink class="remove"
								before="if (!deleteRecord('${paymentDtl?.id}')) {return false;}"
								controller="payment" action="discardPendingTransaction">Delete</g:remoteLink>
						</td>
					</tr>
					<tr class="view-dtl" id="view-dtl_${index}">
						<td colspan="10">
							<div id="editDataDiv_${index}"></div>
						</td>
					</tr>
				</g:each>
			</g:if>
			<g:else>
				<tr>
					<td width="20%"></td>
					<td width="15%"></td>
					<td width="15%">No Record(s) Found</td>
					<td width="10%"></td>
					<td width="5%"></td>
					<td width="15%"></td>
					<td width="10%"></td>
					<td width="5%"></td>
					<td width="5%"></td>
				</tr>
			</g:else>
		</tbody>
		<vayana:pagerModel/>
	</table>
</div>
<%--</g:form>--%>
<script>

$(function(){
	
<%--		$("#pendingTransactionForm").dynamicfieldupdate();--%>
		$(".previous")
			.button({
		   text: false,
		   icons: { primary: "ui-icon-triangle-1-w"}
		 	})
			.click(function() {
		          $(".pagenum").removeClass("form-ui-invalid")
		   })
		.next()
		.button({
		   text: false,
		   icons: { primary: "ui-icon-triangle-1-e"}
		 	}).click(function(){
		 		 $(".pagenum").removeClass("form-ui-invalid")
				}).parent()
		               .buttonset();
			
		$(".gobtn").button({
			text: false,
		   icons: { primary: "ui-icon-arrowreturnthick-1-e"}
		})
		
		 $(".pagenum").blur(function(){
			 var value=$(this).val();
			 var maxm=$(this).attr("max");
			 if(value>maxm){
			 $(this).addClass("form-ui-invalid")
			 }
		 });
			 
		pagerSuccess();

		/************** Details grid -Show and hide details ***************/
		$(".grid tr.has-dtl a.edit_row ").click(function(event){
			$("table.grid tr.has-dtl").next("tr").hide();
			$(this).parents("tr.has-dtl").next("tr.view-dtl").fadeToggle(500,function(){$(this).dynamicfieldupdate();});
			$(this).parents("tr.has-dtl").toggleClass('hlt');
		});
});

function getRecordStatus()
{
	var sts = $("#recordStatus").val();
	return sts;
}
function resizeEditContainer(index){
 $("#editDataDiv_"+index).dynamicfieldupdate();
}
function onDiscardSuccess(data,textStatus){
	$("#messagesDiv").dynamicfieldupdate();
}
function onPendingPageSuccess(data,textValue){
	$("#mainContent").dynamicfieldupdate();
}
</script>