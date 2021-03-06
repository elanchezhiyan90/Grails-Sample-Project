<%@ page import = "com.vayana.bm.core.api.constants.LookupCodeConstants" %>

<h2>BulkPayment - Review and Process</h2>
<br />


<g:set var="bulkPaymentHdr" value="${bulkPaymentHeaderModel?.bulkPaymentDetails?.get(0)?.bulkPaymentHeader }"></g:set>
<g:hiddenField name="headerId" id="headerId" value="${bulkPaymentHeaderModel?.id}" />
<g:hiddenField name="editUrl" id="editUrl" value="${editurl}" />

<g:if test="${isTransExpired == true}">
	<div class="failure">
	<p>
		<g:message code="payment.templates.common.paymentAuthConfirm.transexpiry.message" />
	</p>
	</div>
</g:if>
<table border="0" cellpadding="0" cellspacing="0" class="grid">
<tbody>
<tr>
	<td>Total Number of Records Submitted</td>
	<td>${bulkPaymentHdr?.totalPaymentCount}</td>
</tr>
<tr>
	<td>No of Successful Records</td>
	<td>${bulkPaymentHdr?.totalPaymentCount - bulkPaymentHeaderModel?.bulkPaymentDetails?.count{"FAILURE".equals(it?.status?.code)}}</td>
</tr>
<tr>
	<td>No of Failure Records</td>
	<td>${bulkPaymentHeaderModel?.bulkPaymentDetails?.count{"FAILURE".equals(it?.status?.code)} }</td>
</tr>
<tr>
	<td>Total Payment Amount</td>
	<td>${bulkPaymentHdr?.totalPayment }</td>
</tr>
<tr>
	<td>Total Successful Payment Amount</td>
	<td>${totalSuccessAmount}</td>
</tr>
</tbody>
</table>
<br/>
<div id="pagerActive">
<vayana:pager controller="bulkPayment" action="showBulkPaymentDatelineDetails" paramsModel="\'&hdrId=\'+getheaderId()" update="mainContent">
</vayana:pager>

</div>
<div id="mainContent">
	<g:render template="/bulkPayment/templates/smeBulkPayment/bulkPaymentDatelineViewSubDetails"></g:render>

	</div>
	
	
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