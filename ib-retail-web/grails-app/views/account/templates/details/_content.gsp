 <section class="body-scroll">
    <g:set var="acnt" value="${actDtlModel?.accountDetail}"/>
    
<%--    <g:set var="cacheaccount" value="${cachedActModel?.customerIdentifiers.casaAccounts}"/>--%>
<%--    <g:each in="${cachedActModel?.customerIdentifiers.casaAccounts}">--%>
<%--    print ${it.accountNumber } --%>
<%--    </g:each>--%>
    
    <g:set var="acntCurr" value="${acnt?.currency?.code}"/>
	<h2><g:message code="account.templates.details.content.h2.text"/> <vayana:accountNumber value="${acnt?.accountShortName}"/></h2>
<%--	<vayana:errors/>--%>
<g:form name="nickForm">
	<vayana:messages/>
	
	<table border="0" cellpadding="0" cellspacing="0" class="dtl_view">
		<tr>
			<td><g:message code="account.templates.details.content.accountholdername.label"/></td>
			<td>${acnt?.accountName}</td>
			
		</tr>
		<tr>
			<td><g:message code="account.templates.details.content.nickname.label"/></td>
			<td><div>
			        <g:hiddenField name="accountShortName" id="accountShortName" value="${acnt?.accountShortName}"/>
			        <g:hiddenField name="accountNumber" value="${acnt?.accountNumber}"/>
					<span id="nick" data-nick="nick-${acnt?.accountNumber}">${acnt?.accountShortName}</span> 
					<a href="javascript:void(0)" class="edit_row">edit</a>
					<g:submitToRemote controller="account" url="[action:'updateaccountnickname']" value="${g.message(code:"account.templates.details.content.save.text") }" id='save_edit' name='save_edit' class="hidden" before="if (checkNickNameValidity()) {return false;}if (checkNickNameAlpha()) {return false;} updateAccountNickName();" onSuccess="nicknamesuccess();" onFailure="onAjaxFailure(textStatus);"/>
					<input type='button' value="${g.message(code:'account.templates.details.content.cancel.text') }" id='cancel_edit'
						class='btn_next hidden'>
				</div></td>
		</tr>
		
		<tr>
			<td><g:message code="account.templates.details.content.accounttype.label"/></td>
			<td>${acnt?.accountType?.description}</td>
		</tr>
		<tr>
			<td><g:message code="account.templates.details.content.currency.label"/></td>
			<td>${acnt?.currency?.code}</td>
		</tr>
		<%--<tr>
			<td><g:message code="account.templates.details.content.currentbalance.label"/></td>
			<td class="amt"><vayana:formatAmount amount="${acnt?.fundsInClearing}" currency="${acntCurr}"/></td>
		</tr>
		--%><tr>
			<td><g:message code="account.templates.details.content.clearbalance.label"/></td>
			<td class="amt"><vayana:formatAmount amount="${acnt?.fundsInClearing}" currency="${acntCurr}"/>
			${acnt?.clrBalTag}
			</td>
		</tr>
		<tr>
			<td><g:message code="account.templates.details.content.availablebalance.label"/></td>
			<td class="amt"><vayana:formatAmount amount="${acnt?.availableBalance}" currency="${acntCurr}"/></td>
		</tr>
		<%--<tr>
			<td><g:message code="account.templates.details.content.ibannumber.label"/></td>
			<td>${acnt?.IBAN}</td>
			
		</tr>
	--%></table> 
	<br />
	<table border="0" cellpadding="0" cellspacing="0" class="dtl_view">
		<%--<tr>
			<td><g:message code="account.templates.details.content.amountonhold.label"/></td>
			<td class="amt"><vayana:formatAmount amount="${acnt?.reservedBalance}" currency="${acntCurr}"/></td>
		</tr>
		--%>
		<tr>
			<td><g:message code="account.templates.details.content.lienamount.label"/></td>
			<td class="amt"><vayana:formatAmount amount="${acnt?.lienAmount}" currency="${acntCurr}"/></td>
		</tr>
		<tr>
			<td><g:message code="account.templates.details.content.unclearedfunds.label"/></td>
			<td class="amt"><vayana:formatAmount amount="${acnt?.unclearBalance}" currency="${acntCurr}"/>
			${acnt?.unClrBalTag}
			</td>
		</tr>
		<tr>
			<td><g:message code="account.templates.details.content.overdraftlimit.label"/></td>
			<td class="amt"><vayana:formatAmount amount="${acnt?.overdraftLimit}" currency="${acntCurr}"/></td>
		</tr>
		<tr>
			<td><g:message code="account.templates.details.content.minimumbalance.label"/></td>
			<td class="amt"><vayana:formatAmount amount="${acnt?.minimumBalance}" currency="${acntCurr}"/></td>
		</tr>
		<tr>
			<td><g:message code="account.templates.details.content.linkedfd.label"/></td>
			<td><a href="#">${acnt?.linkedFixedDeposits}</a></td>
		</tr>
		<%--<tr>
			<td><g:message code="account.templates.details.content.combinedavailablebalance.label"/></td>
			<td class="amt"><vayana:formatAmount amount="${acnt?.combinedAvailableBalance}" currency="${acntCurr}"/></td>
		</tr>
	--%></table>
	<br />
	<table border="0" cellpadding="0" cellspacing="0" class="dtl_view">
		<tr>
			<td><g:message code="account.templates.details.content.accountstatus.label"/></td>
			<td><g:message code="account.templates.details.content.active.label"/></td>
		</tr>
		<%--<tr>
			<td><g:message code="account.templates.details.content.operationalinstruction.label"/></td>
			<td>${acnt?.operationalInstruction}</td>
		</tr>
		--%><%--<tr>
			<td><g:message code="account.templates.details.content.memodetails.label"/></td>
			<td>${acnt?.memoDetails}</td>
		</tr>
		<tr>
			<td><g:message code="account.templates.details.content.nomineename.label"/></td>
			<td>${acnt?.nomineeName}</td>
		</tr>--%>
		<tr>
			<td><g:message code="account.templates.details.content.accountopendate.label"/></td>
			<%--<td>${acnt?.accountOpenedDate?.format("dd-MMM-yyyy")}</td>
			--%><%--<vayana:formatDate date="${acnt?.accountOpenedDate}" /> 
		--%>
		<td><vayana:formatDate date="${acnt?.accountOpenedDate}" /> </td>
		</tr>
		<tr>
			<td><g:message code="account.templates.details.content.productname.label"/></td>
			<td>${acnt?.acctProduct?.description}</td>
		</tr>
		
		<tr>
			<td><g:message code="account.templates.details.content.branchname.label"/></td>
			<td>${acnt?.branch?.description}</td>
		</tr>
		<%--<tr>
			<td><g:message code="account.templates.details.content.rmname.label"/></td>
			<td>${acnt?.relationShipManagerName}</td>
		</tr>	
		--%>
		<%--<tr>
			<td><g:message code="account.templates.details.content.accountofficername.label"/></td>
			<td>${acnt?.accountOfficerName}</td>
		</tr>	
	--%></table>
	</g:form>
	<br /> <br />
</section>
<div id="dialog-message" title="Nick Name" style="display: none;">
	<p><g:message code="account.templates.details.nickname.maxlen.alert"/></p>
</div>
<div id="dialog-message-alp" title="Nick Name" style="display: none;">
	<p><g:message code="account.templates.details.nickname.alphanum.alert"/></p>
</div>

<script>
function checkNickNameValidity(){
	var nick=$("#nick").text();
	if(nick == null){ 
		  showError();
	      return true;   
	}else if(nick == ''){
		  showError();
	      return true;
	}else if(nick.length >= 25){
		  showError();
	      return true;
	}else{
		  return false;
	}	
}

function checkNickNameAlpha(){
	var nick	=	$("#nick").text();
	var reg = /^[A-Za-z0-9\d\s]+$/;		
	if (reg.test(nick)) {
       return false;
    }    
	showAlpError();
	return true;
}



function showError(){
	$( "#dialog-message" ).dialog({
			resizable: false,
			height:140,
			title:"Nick Name",
			position:['middle',200],
			draggable: false,				 
		    modal: true,
		    buttons: {
			  Ok: function() {
				   $( this ).dialog( "close" );
			  }
		    }
	});			
}

function showAlpError(){
	$( "#dialog-message-alp" ).dialog({
			resizable: false,
			height:140,
			title:"Nick Name",
			position:['middle',200],
			draggable: false,				 
		    modal: true,
		    buttons: {
			  Ok: function() {
				   $( this ).dialog( "close" );
			  }
		    }
	});			
}

</script>