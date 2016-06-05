<g:form name="Creditcardmain">
	<g:set var="statementDetails" value="${credditCardStatementModel?.statementHeader?.statementDetails}"/>
	<div id="curr_stmt">
		<div id="curr_month_stmt">
			<g:if test="${credditCardStatementModel?.statementHeader}">
				<g:render
					template="/creditcard/templates/statement/currentstatementsummary" />
			</g:if>
			<br />

			<g:form>
				<g:hiddenField name="sortOrder" value=""></g:hiddenField>
				<g:render template="/creditcard/templates/statement/pagingsort" />
			</g:form>
			<!-- Sticky header starts here ----------->
			<div class="start-stick_top"></div>
			<div class="grid_stickyhead_top">
				<table border="0" cellpadding="0" cellspacing="0"
					class="grid_theader">
					<thead>
						<tr>
							<th width="15%" data-column-message="transactionDate"><g:message code="creditcard.statement.details.postingdate" /></th>
							<th width="35%" data-column-message="transactionDescription"><g:message code="creditcard.statement.details.transactionDescription" /></th>
							<th width="15%" data-column-message="purchasedate"><g:message code="creditcard.statement.details.purchasedate" /></th>
							<th width="15%" data-column-message="transactionamount" class="amt"><g:message code="creditcard.statement.details.transactionamount" /></th>
							<th width="15%" data-column-message="billedamount"><g:message code="creditcard.statement.details.billedamount" /></th>
						</tr>
					</thead>
				</table>
			</div>
			<!-- Sticky header Ens here ----------->
			<div id="mainContent">
				<table border="0" cellpadding="0" cellspacing="0" class="grid">
					<tbody>
						<g:if test="${statementDetails!=null && statementDetails.size() > 0}">
							<g:each var="ccstmtdetail" in="${statementDetails}">
									<tr>
										<td width="15%"><span><vayana:formatDate date="${ccstmtdetail?.valueDate}" /><span></td>
										<td width="35%"><span>${ccstmtdetail?.transactionDescription}</td>
										<td width="15%"><span><vayana:formatDate date="${ccstmtdetail?.transactionDate}" /><span></td>
										<g:if test="${ccstmtdetail?.transactionFlag== 'D'}">
											<td class="amt dr" width="25%"><vayana:formatAmount
													currency="${ccstmtdetail?.transactionCurrencyId?.code}"
													amount="${ccstmtdetail?.transactionAmount}" /> <span
												class="cur">Dr.</span><span>${ccstmtdetail?.transactionCurrencyId?.code}</span>
											</td>
										</g:if>
										<g:else>
											<td class="amt" width="15%">
												<vayana:formatAmount	currency="${ccstmtdetail?.transactionCurrencyId?.code}" amount="${ccstmtdetail?.transactionAmount}" /> 
												<span class="cur">Cr.</span><span>${ccstmtdetail?.transactionCurrencyId?.code}</span>
											</td>
										</g:else>
										<td class="amt" width="15%">
												<vayana:formatAmount	currency="${ccstmtdetail?.billedCurrency?.code}" amount="${ccstmtdetail?.billedAmount}" /> 
												<span>${ccstmtdetail?.billedCurrency?.code}</span>
											</td>
										
									</tr>
							</g:each>
						</g:if>
						<g:else>
							<tr>
								<td></td>
								<td align="center">No Records Found</td>
								<td></td>
							</tr>
						</g:else>
					</tbody>
					<vayana:pagerModel />
				</table>
				<g:if
					test="${statementDetails!=null && statementDetails.size() > 0}">
					<br />
					<vayana:download formName="Creditcardmain"
						reportName="creditcardreport.rptdesign" />
				</g:if>
			</div>
		</div>
	</div>
</g:form>

<script>
$("#curr_stmt").dynamicfieldupdate();
$(".moreoptcurrent").hide();
$(document).ready(function(){
/********* Ceebox for grid catergory ***************/
		$(".cat a").attr('rel',"width:400px; height:380px");
		$(".ceebox").ceebox();
/*******************Sort By Values*******************/
			var header = Array();
			var headerVal = Array();
			$("table.grid_theader tr th").each(function(i, v){
			var headerValue = $(this).data("column-message");
			if(headerValue != "")
			{
	        header[i] = $(this).text();
	        headerVal[i] = headerValue;//$(this).data("column-message");    
	        }   
			})
			var ob = $("select#sortBy");
			for (var i = 0; i < header.length; i++) {
	    	 var val = headerVal[i];
	     	var text = header[i];
		     if(val != null){
	     	ob.append("<option value="+ val +">"+ text +"</option>");}
		 	}
	/************ sorting buttons *************/
	 $( ".ascending")
	 	.button({
        text: false,
        icons: { primary: "ui-icon-triangle-1-n"}
      	})
	 	.click(function() {
        <g:remoteFunction controller="creditCard" action="statementfilter" update="mainContent" before='setSortOrder("asc")' params="\'sortOrder=\' + getSortOrder()+\'&sortBy=\'+getSortBy()+\'&gotoPage=\'+getPageNumber()"></g:remoteFunction>
        })
	 .next()
	 .button({
        text: false,
        icons: { primary: "ui-icon-triangle-1-s"}
      	}).click(function(){
 		<g:remoteFunction controller="creditCard" action="statementfilter" update="mainContent" before='setSortOrder("desc")' params="\'sortOrder=\' + getSortOrder()+\'&sortBy=\'+getSortBy()+\'&gotoPage=\'+getPageNumber()"></g:remoteFunction>
			}).parent()
                    .buttonset();
	/************ more options on filter section ***********/
	$(".more").click(function(){
		$("#togglebtn").detach().appendTo(".moreopt");
		$(".moreopt").slideToggle(function(){
			if($(this).is(':hidden')){
				$("#togglebtn").detach().appendTo(".grid_filter");
				}
				$('.body-scroll').jScrollPane();
		});
		$(this).text($(this).text() == 'More...' ? 'Less...' : 'More...');
	});	
});	

		
	
	function onDetailStmtSuccess(data,textStatus){
		$("#curr_month_stmt").dynamicfieldupdate();
		pagerSuccess();
		var totalPages=$("#totalPages").val();
		if(totalPages!=""){
			$(".grid_head").show();    
		}
	}  
	
	function getPageNumber(){
	var pageNum = $(".pagenum ").val()-1;
	return pageNum;
	}
	
	function getSortBy(){
	var sortBy=$("#sortBy").val();
	return sortBy;
	}
	
	function setSortOrder(order){
	$("#sortOrder").val(order)
	}

	function getSortOrder(){
	var order	=	$("#sortOrder").val()
	return order;
	}
</script>

