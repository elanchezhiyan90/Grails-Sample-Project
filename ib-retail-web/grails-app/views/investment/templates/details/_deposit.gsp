<section class="body-scroll">
    <g:set var="investmentAccount" value="${investmentDetailModel?.depositAccount}"/>
    <g:set var="acntCurr" value="${investmentAccount?.currency?.code}"/>
    <h2>${message(code:'investment.templates.details.deposit.h2.detailsfor')} <vayana:accountNumber value="${investmentAccount?.accountShortName}"/></h2>
	<br />
	<g:form>
	<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
			<tr>
                	<td>${message(code:'investment.templates.details.deposit.depositnumber.label')}</td>
                    <td><vayana:accountNumber value="${investmentAccount?.accountNumber}"/> </td>
         	</tr>
         	<tr>
                	<td>${message(code:'investment.templates.details.deposit.name.label')}</td>
                    <td><vayana:accountNumber value="${investmentAccount?.accountName}"/> </td>
         	</tr>
         	<tr>
   				<td>${message(code:'investment.templates.details.deposit.nickname.label')}</td>
   				<td>    				
   				<div>
		        <g:hiddenField name="accountShortName" id="accountShortName" value="${investmentAccount?.accountShortName}"/>
		        <g:hiddenField name="accountNumber" value="${investmentAccount?.accountNumber}"/>
				<span id="nick" data-nick="nick-${investmentAccount?.accountNumber}">${investmentAccount?.accountShortName}</span> 
				
				<a href="javascript:void(0)" class="edit_row">${message(code:'investment.templates.details.deposit.edit.text')}</a>
				
				<g:submitToRemote url="[action:'updateaccountnickname']" update="[failure:'messagesDiv']" value='${message(code:'investment.templates.details.deposit.save.text')}' id='save_edit' name='save_edit' class="hidden" before="if (checkNickNameValidity()) {return false;}if (checkNickNameAlpha()) {return false;} updateAccountNickName();" onSuccess="nicknamesuccess();" />
				<input type='button' value='${message(code:'investment.templates.details.deposit.button.cancel.text')}' id='cancel_edit'
					class='btn_next hidden'>
					
				</div>
   				</td>			
   			</tr>
			
			<tr>
                	<td>${message(code:'investment.templates.details.deposit.deposittype.label')}</td>
                    <td>${investmentAccount?.accountType?.description}</td>
         	</tr>
			<tr>
                	<td>${message(code:'investment.templates.details.deposit.currency.label')} </td>
                    <td>${acntCurr}</td>
         	</tr>
			
			
		</table>
		<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">	
			
         	<tr>
                	<td>${message(code:'investment.templates.details.deposit.tenure.label')}</td>
                    <td>${investmentAccount?.tenure} Months</td>
         	</tr>
         	
         	<tr>
                	<td>${message(code:'investment.templates.details.deposit.depositedate.label')}</td>
                    <td><vayana:formatDate date="${investmentAccount?.depositDate}" /> </td>
         	</tr>
         	<%--<tr>
                	<td>${message(code:'investment.templates.details.deposit.princibalbalance.label')}</td>
                    <td class="amt"><vayana:formatAmount amount="${investmentAccount?.principalBalance}" currency="${acntCurr}" /></td> 
         	</tr>
         	<tr>
                	<td>${message(code:'investment.templates.details.deposit.unclearedamount.label')}</td>
                    <td class="amt"></td> 
         	</tr>
         	<tr>
                	<td>${message(code:'investment.templates.details.deposit.bookbalance.label')}</td>
                    <td class="amt"></td> 
         	</tr>
         	--%><tr>
                	<td>${message(code:'investment.templates.details.deposit.maturitydate.label')}</td>
                    <td><vayana:formatDate date="${investmentAccount?.maturityDate}" /> </td>
         	</tr>
         	</table>
         	
         	
         	<%--<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
         	
         	
         	
         	<tr>
					<td>HeldAmount</td>
                    <td class="amt"><vayana:formatAmount amount="${investmentAccount?.heldAmount}" currency="${acntCurr}" /></td>
         	</tr>
         	
         	        	
         	</table>
         	--%><table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
         	<tr>
                	<td>${message(code:'investment.templates.details.deposit.principalamount.label')}</td>
                    <td class="amt"><vayana:formatAmount amount="${investmentAccount?.principalBalance}" currency="${acntCurr}" /></td> 
         	</tr>
         	<tr>
                	<td>${message(code:'investment.templates.details.deposit.maturityamount.label')}</td>
                    <td class="amt"><vayana:formatAmount amount="${investmentAccount?.maturityAmount}" currency="${acntCurr}" /></td> 
         	</tr>
         	<tr>
                	<td>${message(code:'investment.templates.details.deposit.interest.label') }</td>
                    <td class="amt">${investmentAccount?.interestRate}%</td> 
         	</tr>
         	<tr>
                	<td>${message(code:'investment.templates.details.deposit.interestamount.label')}</td>
                    <td class="amt"><vayana:formatAmount amount="${investmentAccount?.interestAmount}" currency="${acntCurr}" /></td> 
         	</tr>
         	
        </table>
        <table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
        <tr>
                	<td>${message(code:'investment.templates.details.deposit.branch.label')}</td>
                    <td>${investmentAccount?.branch?.description}</td>
         	</tr>
        </table>
			     	
		
	</g:form>	
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