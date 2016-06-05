<%@ page import="com.vayana.ib.bm.core.api.model.enums.PayeeTypeEnum"%>
<vayana:pager controller="payment" action="viewskippedsipage"
	update="mainContent" />
<g:form name="skipForm" id="skipForm">
<!-- Sticky header starts here ----------->
<div class="start-stick_top"></div>
<div class="grid_stickyhead_top">
	<table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
		<thead>
			<tr>
				<th width="20%">Nick Name</th>
				<th width="20%">Account Number</th>
				<th width="20%">Credit Account</th>
				<th width="15%" class="amt">Amount</th>
				<th width="15%">Scheduled Date</th>
				<%--<th width="20%">IB Reference Number</th> --%>
				<th width="10%">Status</th>
			</tr>
		</thead>
	</table>
</div>
<!-- Sticky header ends here ----------->
<table cellspacing="0" cellpadding="0" border="0" class="grid" id="mainContent">
	<tbody>
		<tr>
			<td width="20%"></td>
			<td width="20%"></td>
			<td width="20%"></td>
			<td width="15%" class="amt"></td>
			<th width="15%"></th>
			<td width="10%"></td>
		</tr>
		<g:if test="${!siViewAndUpdateModel?.paymentScheduleDetails?.isEmpty()}">
			<g:each in="${siViewAndUpdateModel?.paymentScheduleDetails}" var="paymentScheduleDetails">
				<tr>
					<td>
						${paymentScheduleDetails?.payeeInstruction?.shortName}
					</td>
					<td><vayana:formatAccount
							currency="${paymentScheduleDetails?.payerInstruction?.currency?.code}"
							accountno="${paymentScheduleDetails?.payerInstruction?.accountNumber}" /></td>
					<td>
						${(PayeeTypeEnum?.BENE.equals(paymentScheduleDetails?.payeeInstruction?.payeeType)) ? vayana.formatFFAccountNumber(beneInsIdVer:paymentScheduleDetails?.payeeInstruction?.idVersion,displayCurrency:'NO') 
										: vayana.formatBPAccountNumber(billInsIdVer:paymentScheduleDetails?.payeeInstruction?.idVersion) }
					</td>

					<%--<vayana:formatAccount
										currency="${paymentScheduleDetails?.payeeInstruction?.currency?.code}"
										accountno="${paymentScheduleDetails?.payeeInstruction?.accountNumber}" /></td>
								--%>
					<td class="amt"><vayana:formatAmount
							currency="${paymentScheduleDetails?.paymentCurrency?.code}"
							amount="${paymentScheduleDetails?.paymentAmount}" /> <%--							 ${paymentScheduleDetails?.paymentCurrency?.code}--%>
					</td>
					<td><vayana:formatDate
							date="${paymentScheduleDetails?.paymentDate}" /></td>
					<%--<td>${paymentScheduleDetails?.referenceTag}</td>	    
	                        --%>
					<td>
						${paymentScheduleDetails?.status?.description}
					</td>
				</tr>
			</g:each>
		</g:if>
		<g:else>
			<tr>
				<td width="20%"></td>
				<td width="20%"></td>
				<td width="20%" align="center">No Record Found</td>
				<td width="20%"></td>
				<th width="20%"></th>
			</tr>
		</g:else>
	</tbody>
	<vayana:pagerModel />
</table>
</g:form>
<g:if test="${!siViewAndUpdateModel?.paymentScheduleDetails?.isEmpty()}">
	<script>
  $(function(){
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
});
 </script>
</g:if>