<!--Charge Account Starts Here-->

<g:hiddenField name="beneficiaryId" value="${beneficiary?.idVersion}" />


<div id="beneficiaryAccounts">
	<h3>
		${message(code:'beneficiary.templates.accountdtl.addaccount.h3.text')}
		<a href="#" id="showBene" class="add"
			title="${g.message(code:'beneficiary.templates.personaldtl.addinstruction.tooltip.text')}">+</a>
	</h3>


	<%-- <vayana:wfsearchFilter controller="beneficiary" action="listBeneficiaryInstructions" update="beneficiaryAccountDetails" onSuccess="onSearchSuccess(data,textStatus)" />--%>
	<br />

	<div id="beneficiaryAccountDetails">
		<g:if test="${beneInsRespone?.beneficiaryInstructions?.size()>0}">
			<g:render template="templates/beneficiaryAccountDetails"></g:render>
		</g:if>
		<g:else>
			<h1>
				<g:message code="beneficary.accounts.empty.label" />
			</h1>
		</g:else>
	</div>


</div>

<script>
$(function(){
	
	$("#beneficiaryAccounts").dynamicfieldupdate();	
	$(".ceeboxbene").ceebox();
	$(".ceeboxEdit").ceebox();
	
	
	$('#showBene').click(function(event){
	 event.preventDefault();	            	
     var url = '${createLink(controller: 'beneficiary', action: 'addBeneficiaryInstruction')}?beneficiaryId='+$('#hidBeneficiaryIdversion').val();
     var title = $(this).attr('title');
     $.fn.ceebox.overlay();
	 $.fn.ceebox.popup("<a href='"+url+"' title='"+title+"'></a>",""); 
     
   	});
	
	/* For enable disable styles */
	
	$('.inststatus').each(function(){
				if($(this).is(":checked")){						
						$(this).button({label: "Enabled", text: false,icons: {primary: "ui-icon-check"}})							
				}
				else {
					$(this).button({label: "Disabled",text: false,icons: {primary: "ui-icon-power"}})					
				}
	});	
	
	/* For enable disable styles */
	
	var header = Array();
	var headerVal = Array();
	$("table.grid_theader tr th").each(function(i, v){
	        header[i] = $(this).text();
	        headerVal[i] = $(this).data("column-message");       
	})
	var ob = $("select#searchRequest");
	for (var i = 0; i < header.length; i++) {
	     var val = headerVal[i];
	     var text = header[i];
	     ob.append("<option value="+ val +">"+ text +"</option>");
	}
});

<%--function onSearchSuccess(data,textStatus)--%>
<%--{--%>
<%--	//alert("onSearchSuccess:"+data);--%>
<%--	$(".ceeboxEdit").ceebox();--%>
<%--	$("#beneficiaryAccountDetails").dynamicfieldupdate();	--%>
<%--}--%>
</script>

<!--Charge Account Ends Here-->