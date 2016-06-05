<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<div class="body-scroll">
		<section>
			<h2>
				<g:message code="payment.pendingTransactions.h2.text"/>
			</h2>
			<vayana:messages />
			<br />
			<div id="pendingTransactionList">
				<g:render template="/payment/templates/pendingTransactions/pendingTransactionsList"></g:render>
			</div>

		</section>
	</div>
</body>
<g:javascript>
function deleteRecord(id){
		
		var x = "Are you sure you want to take this action";
			
		    $('<div>' + x + '</div>').dialog({
		        resizable: false,
		        height:140,
		        title:"Confirm Delete?",
		        position:['middle',200],
		        draggable: false,
		        modal:true,
		        buttons: {
		            "Yes": function() {						            	
		                $(this).dialog("close");		       
		                <vayana:deleteFunction controller="payment" action="discardPendingTransaction" params="\'pendingTransactionId=\'+id+\'&gotoPage=\'+getPageNumber()" update="pendingTransactionList" onSuccess="onDiscardSuccess(data,textStatus)" />					                
		            },
		            Cancel: function() {
		                $(this).dialog("close"); //close confirmation
		            }
		        }
		    
		});
}
function onDiscardSuccess(data,textStatus){
	$("#pendingTransactionList").dynamicfieldupdate();
}
function getPageNumber(){
	var pageNum = $(".pagenum ").val()-1;
	return pageNum;
}
</g:javascript>
