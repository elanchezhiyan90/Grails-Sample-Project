<!doctype html>
<html>
	<head>
		<meta name="layout" content="applayout"/>
		<parameter name="themeName" value="${params.themeName}" />
	</head>
<body>
<div class="body-scroll">
 <section>
 <vayana:messages/>       
	  <g:form useToken="true" name="loanStmt" id="loanStmt">  
	      <g:render template="templates/statement/search"/>
	      <g:hiddenField name="sortOrder" value=""></g:hiddenField>
	      <g:render template="templates/statement/pagingsort"/>
      </g:form>
      <g:render template="templates/statement/content" />
<%--     <g:if test="${LoanStatementModel?.statementHeader?.statementDetails}">		--%>
<%--     	<g:render template="templates/statement/download" />--%>
<%--	    <g:render template="templates/statement/summary" />--%>
<%--	</g:if>--%>
        
    </section>
</div>

<g:javascript>
	$(document).ready(function(){
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
        <g:remoteFunction controller="loan" action="detailedstatementgotopage" update="mainContent" before='setSortOrder("asc")' params="\'sortOrder=\' + getSortOrder()+\'&sortBy=\'+getSortBy()+\'&gotoPage=\'+getPageNumber()"></g:remoteFunction>
        })
	 .next()
	 .button({
        text: false,
        icons: { primary: "ui-icon-triangle-1-s"}
      	}).click(function(){
 		<g:remoteFunction controller="loan" action="detailedstatementgotopage" update="mainContent" before='setSortOrder("desc")' params="\'sortOrder=\' + getSortOrder()+\'&sortBy=\'+getSortBy()+\'&gotoPage=\'+getPageNumber()"></g:remoteFunction>
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
		$("#mainContent").dynamicfieldupdate();
		pagerSuccess();
		var totalPages=$("#totalPages").val();
		if(totalPages!=""){
			$(".grid_head").show();    
		}
		reinitialiseScrollPane();
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
</g:javascript> 
</body>
</html>