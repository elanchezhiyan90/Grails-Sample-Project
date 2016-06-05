<g:form name="transferReviewForm1" controller="bulkPayment">   
<g:hiddenField name="toTSTCode" id="toTSTCode" value="${toTSTService}" />
<g:hiddenField name="headerId" id="headerId" value="${bulkPaymentHeaderModel?.id}" />



<div id="mainFileContent">

<div id="pagerActive">
<vayana:pager controller="bulkPayment" action="showBulkFileContent" paramsModel="\'&hdrId=\'+getheaderId()" update="mainFileContent">
</vayana:pager>
</div>

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
			<th width="10%">Narration</th>
			<th width="5%">Status</th>
		</tr>		
		</thead>
		<tbody>
			<tr>
				<%--<td></td>
				--%><td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>			
			<g:if test="${bulkPaymentDetailsModel}">
				<g:each in="${bulkPaymentDetailsModel}" var="bulkPaymentdtl" status="index">
					<tr>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-002')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-002')}">${bulkPaymentdtl?.beneficiaryReferenceNumber}</b>
							</g:if>
							<g:elseif test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-012')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-012')}">${bulkPaymentdtl?.beneficiaryReferenceNumber}</b>
							</g:elseif>
							<g:else>${bulkPaymentdtl?.beneficiaryReferenceNumber}</g:else>
						</td>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-001')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-001')}">${bulkPaymentdtl?.beneficiaryName}</b>
							</g:if>
							<g:elseif test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-013')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-013')}">${bulkPaymentdtl?.beneficiaryName}</b>
							</g:elseif>
							<g:else>${bulkPaymentdtl?.beneficiaryName}</g:else>
						</td>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-003')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-003')}">${bulkPaymentdtl?.beneficiaryAccountNumber}</b>
							</g:if>
							<g:elseif test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-014')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-014')}">${bulkPaymentdtl?.beneficiaryAccountNumber}</b>
							</g:elseif>
							<g:else>${bulkPaymentdtl?.beneficiaryAccountNumber}</g:else>
						</td>
						<td>${bulkPaymentdtl?.paymentCurrency?.code}</td>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-009')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-009')}"><vayana:formatAmount currency="${bulkPaymentdtl?.paymentCurrency?.code}" amount="${bulkPaymentdtl?.paymentAmount}"></vayana:formatAmount></b>
							</g:if>
							<g:else><vayana:formatAmount currency="${bulkPaymentdtl?.paymentCurrency?.code}" amount="${bulkPaymentdtl?.paymentAmount}"></vayana:formatAmount></g:else>
						</td>
						<td><vayana:formatDate date="${bulkPaymentdtl?.valueDate}" showTime="false" /></td>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-007')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-007')}">${bulkPaymentdtl?.electronicClearingCode}</b>
							</g:if>
							<g:else>${bulkPaymentdtl?.electronicClearingCode}</g:else>
						</td>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-015')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-015')}">${bulkPaymentdtl?.userNarration}</b>
							</g:if>
							
							<g:else>${bulkPaymentdtl?.userNarration}</g:else>
						</td>	

						<td>
						<g:if test="${'FAILURE'.equals(bulkPaymentdtl?.status?.code) && !(['BLK-ERR-002','BLK-ERR-001','BLK-ERR-003','BLK-ERR-009','BLK-ERR-007'].contains(bulkPaymentdtl?.remarks))}">
							<b style="color:red" title="${bulkPaymentdtl?.remarks}">${bulkPaymentdtl?.status?.description}</b>
						</g:if>
						<g:else>
							${bulkPaymentdtl?.status?.description}
						</g:else>
						</td>
					</tr>
					<%--<g:if test="${bulkPaymentdtl?.remarks && bulkPaymentdtl?.remarks != 'null'} ">
						<tr>
							<td colspan="10">Error - ${bulkPaymentdtl?.remarks}</td>
						</tr>
					</g:if>
					
				--%></g:each>
			</g:if>	
			<g:else>
			<tr>
				<%--<td>&nbsp;</td>
				--%><td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;No Record(s) Found</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			</g:else>		
		</tbody>
		<vayana:pagerModel></vayana:pagerModel>	      
	</table>

	
	<!---------- user downloadable formats Starts Here----------->
	<g:if test="${bulkPaymentDetailsModel}">
			<div class="grid_foot">
				<vayana:download formName="transferReviewForm1"	reportName="bulkPaymentCustReport.rptdesign" />
			</div>
		</g:if>
	</div>
	
</g:form>


<script>
  $(function() {
    $( document ).tooltip({
      track: true
    });
  });

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

	function getheaderId()
	{
		var sts = $("#headerId").val();
		return sts;
	}
	


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
	

</script>

