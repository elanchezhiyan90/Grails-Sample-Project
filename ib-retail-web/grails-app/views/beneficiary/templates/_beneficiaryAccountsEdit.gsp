<!--Charge Account Starts Here-->
<g:hiddenField name="beneficiaryId" value="${params?.beneficiaryId}" />
<div id="beneficiaryAccounts">
	<h3>
		${message(code:'beneficiary.templates.accountdtl.addaccount.h3.text')}
		<%-- <g:remoteLink id="showBene" class="add ceebox" controller="beneficiary" action="addBeneficiaryInstruction" update="loadBeneficiaryAccountForm" class="add" onSuccess="resizeContainer()">+</g:remoteLink>--%>
		<vayana:fap
			function="${vayana.generateFap(businessFunctionLabel:'BENEFICIARY_INSTRUCTION',userActionLabel:'ADD')}">
			<a
				href="${createLink(controller:'beneficiary' ,action:'addBeneficiaryInstruction' , params:[beneficiaryId:params?.beneficiaryId])}"
				id="showBene" class="add ceeboxbene"
				title="${g.message(code:'beneficiary.templates.personaldtl.addinstruction.tooltip.text')}">+</a>
		</vayana:fap>
	</h3>

	<%--<vayana:wfsearchFilter controller="beneficiary" action="listBeneficiaryInstructions" update="beneficiaryAccountDetails" onSuccess="onSearchSuccess(data,textStatus)" />--%>
	<br />
	<%--<div id="beneficiaryAccountDetails">
<g:render template="templates/beneficiaryAccountDetails"></g:render>
</div>

--%>
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



	<script>

	$(".ceebox").ceebox();
	//$(".ceeboxEdit").ceebox();
	$(".ceeboxbene").ceebox();
	
	$("#beneficiaryAccounts").dynamicfieldupdate();

	
  		//alert("inside update icons");
	$('.inststatus').each(function(){
				if($(this).is(":checked")){						
						$(this).button({label: "Enabled", text: false,icons: {primary: "ui-icon-check"}})							
				}
				else {
					$(this).button({label: "Disabled",text: false,icons: {primary: "ui-icon-power"}})					
				}
	});
		
	
	
$(function(){
	
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
	
	

	<%--function onSearchSuccess(data,textStatus)--%>
	<%--{--%>
	<%--	--%>
	<%--	$(".ceeboxbene").ceebox();--%>
	<%--		--%>
	<%--}--%>
	
	
});
	
</script>