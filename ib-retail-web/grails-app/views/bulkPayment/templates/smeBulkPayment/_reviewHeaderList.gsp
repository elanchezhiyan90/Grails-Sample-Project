<%@ page import="com.vayana.ib.bm.core.impl.service.util.IBDateUtils"%>
<%@ page import="com.vayana.bm.core.api.constants.LookupCodeConstants"%>

<style type="text/css">
.chkBoxMandat {
	display: none;
}
</style>

<g:hiddenField name="tenantSerCode" id="tenantSerCode" value="${toTSTService}" />


<div class="fields">
	<p>&nbsp;</p>
</div>

<g:form name="transferReviewForm">


	<h3>File Upload - Review and Process</h3>
	<br />
	<g:hiddenField name="toTSTCode" id="toTSTCode" value="${toTSTService}" />

	<div class="chkBoxMandat" id="checkBoxMandat">
			<div class="failure">
			<span></span>
			Please select a CheckBox
		</div>
		
	</div>
	<div id="mainContent">
	<div id="pagerActives">
		<vayana:pager controller="bulkPayment" action="smeBulkPayment" paramsModel="\'&tenantServiceCode=\'+getTenantServiceCode()"  update="pendingTransactionList">
		</vayana:pager>
	</div>
	
	
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
					<g:each in="${bulkPaymentHeaderModel}" var="bulkPaymentHdr"
						status="index">
						<tr>
							<td><g:if
									test="${LookupCodeConstants.DRAFT.equals(bulkPaymentHdr?.status?.code)}">
									<g:checkBox name="chkBox" id="${bulkPaymentHdr?.id}"
										value="${bulkPaymentHdr?.id}" checked="false" />
								</g:if> 
																
								<g:else>
									<%-- DONT DISPLAY ANY CHECK BOX --%>
									<%--<g:checkBox name="chkBox" id="${bulkPaymentHdr?.id}" value="${bulkPaymentHdr?.id}" checked="false" disabled="disabled" />
							--%>
								</g:else></td>

							<td><span> <g:remoteLink action="showBulkFileContent"
										title="${bulkPaymentHdr?.fileName}" id="${bulkPaymentHdr?.id}"
										class="ceebox" params="[hdrId:"${bulkPaymentHdr?.id}"]">
										${bulkPaymentHdr?.fileName}
									</g:remoteLink>
							</span>
								${bulkPaymentHdr?.referenceTag}</td>
							<td><span>
									${bulkPaymentHdr?.bulkPaymentType}
							</span>
								${bulkPaymentHdr?.status?.description}</td>
							<td><span>
									${bulkPaymentHdr?.ibUserLoginProfile?.userProfile?.firstName}
							</span>
								${IBDateUtils.getFormatDate(bulkPaymentHdr?.createdDate)}</td>
							<td><span>
									${bulkPaymentHdr?.totalPaymentCount}
							</span>
							<vayana:formatDate date="${bulkPaymentHdr?.paymentDate}"
									showTime="false" /></td>
							<td class="amt"><span>
									${bulkPaymentHdr?.bulkPaymentDetails[0]?.payerInstruction?.accountNumber}
							</span><span class="cur currency">
									${bulkPaymentHdr?.currency?.code}
							</span>
							<vayana:formatAmount currency="${bulkPaymentHdr?.currency?.code}"
									amount="${bulkPaymentHdr?.totalPayment}"></vayana:formatAmount></td>
							<td><g:if
									test="${LookupCodeConstants.DRAFT.equals(bulkPaymentHdr?.status?.code)}">
									<g:remoteLink class="remove"
										before="if (!deleteRecord('${bulkPaymentHdr?.id}','${bulkPaymentHdr?.referenceTag}','${toTSTService}')) {return false;}"
										controller="bulkPayment"
										action="discardBulkPaymentTransaction">Delete</g:remoteLink>
								</g:if> 
								
								<g:if test="${LookupCodeConstants.FAILURE.equals(bulkPaymentHdr?.status?.code) || LookupCodeConstants.SUCCESS.equals(bulkPaymentHdr?.status?.code)|| LookupCodeConstants.REJECTED.equals(bulkPaymentHdr?.status?.code) || LookupCodeConstants.PARTIALLY_SUCCESS.equals(bulkPaymentHdr?.status?.code)}">									
								<g:remoteLink class="trash"
										before="if (!deleteStatusRecord('${bulkPaymentHdr?.id}','${bulkPaymentHdr?.referenceTag}','${toTSTService}')) {return false;}"
										controller="bulkPayment"
										action="deleteBulkPaymentTransaction">Trash</g:remoteLink>
								
								</g:if>
								
								
								<g:else>&nbsp;</g:else></td>
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
			<vayana:pagerModel></vayana:pagerModel>	 
		</table>
			<div id="dynamicAuthContent" class="buttons">

		<g:if test="${bulkPaymentHeaderModel?.size() > 0}">
			<vayana:securitysettingBulkPay controller="security"
				value="${g.message(code:"payment.templates.bulk.transfer.process.submit.label")}"
				action="fetchSecurityAdviceForAService"
				successAction="proceedForApproval" successController="bulkPayment"
				targetService="${toTSTService}" formName="transferReviewForm"
				displayAsPopUp="NO" />
			<%--<input type="button" value="Cancel" class="btn_next" id="canceltrans"
				onclick="postUrl('frmPayment','/ib-retail-web/bulkPayment/smeBulkPayment','canvas');closefolder();" />
		--%></g:if>

	</div>
    	

	
</div>

</g:form>

<script>
	function checkMandatory() {
		var fields = $("input[name='chkBox']").serializeArray();
		if (fields.length == 0) {
			document.getElementById('checkBoxMandat').style.display = 'inline';
			return false;
		} else {
			$("#checkBoxMandat").empty();
			return true;
		}
	}
	
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

			/************** Details grid -Show and hide details ***************/
			$(".grid tr.has-dtl a.edit_row ").click(function(event){
				$("table.grid tr.has-dtl").next("tr").hide();
				$(this).parents("tr.has-dtl").next("tr.view-dtl").fadeToggle(500,function(){$(this).dynamicfieldupdate();});
				$(this).parents("tr.has-dtl").toggleClass('hlt');
			});
	});
	
	function pagerSuccess(){
		var isLastPage = $("#isLastPage").val();
		var isFirstPage = $("#isFirstPage").val();
		
		
		if (isFirstPage == 'true'){
			$( ".previous" ).button("option", "disabled", true);
		}else{
			$( ".previous" ).button("option", "disabled", false);
		}
		
		if (isLastPage == 'true'){
			$( ".next" ).button("option", "disabled", true);
		}else{
			$( ".next" ).button("option", "disabled", false);
		}
		
		$(".pager").show();
		$(".nofpg").text($("#totalPages").val());
		$(".crntpg").text(parseInt($('#currentPage').val())+1);
		$(".pagenum").attr("value",parseInt($('#currentPage').val())+1);
		$(".pagenum").attr("max",$("#totalPages").val());
		reinitialiseScrollPane();
		
	}
	function getTenantServiceCode()
	{
		var sts = $("#tenantSerCode").val();
		return sts;
	}
</script>