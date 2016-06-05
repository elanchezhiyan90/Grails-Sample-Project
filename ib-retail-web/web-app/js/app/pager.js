$(document).ready(function(){
	/************ Pagger buttons *************/
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
			 
	 
});


	function getPageNumber(event)                            
	{
		var elmn=$(event.target);
		//var pageNo=elmn.parent("button").prev(".pagenum").val();
		var pageNo = elmn.parents("td").find(".pagenum").val();
		return parseInt(pageNo) - 1; 
		
	}
	
	function pageCheck(event)                            
	{
		var elmn=$(event.target)
		var pageNoStr = elmn.parents("td").find(".pagenum").val();
		//var pageNoStr = elmn.parent("button").prev(".pagenum").val();
		var pageNo = parseInt(pageNoStr) - 1;
		var totalPages = parseInt($("#totalPages").val());
		if (pageNo > totalPages){
			return true;
		}else{
			return false;
		}
	}
	
	
	
	function getCurrentPage(option)                            
	{
		   var currPage = $('#currentPage').val();
		   if(option == 'next')  {
			   currPage = parseInt(currPage) + 1
		   }else {
			   currPage = parseInt(currPage) - 1
		   }
		   return parseInt(currPage); 
	}

	function getSortBy()                            
	{
		var sortBy = $("#sortBy").val();		
		return sortBy;
	}
		
	function getSortOrder()
	{
		var sortOrder=$("#sortOrder").val();
		return sortOrder;
	}

	function pagerSuccess(){
		var isLastPage = $("#isLastPage").val();
		var isFirstPage = $("#isFirstPage").val();
		//alert(isLastPage)
		//alert("isFirstPage : " + isFirstPage + " isLastPage : " + isLastPage);	
		
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
