
<section class="body-scroll">
	<g:set var="loanAccount" value="${loanDetailModel?.loanDetail}" />
	<g:set var="acntCurr" value="${loanAccount?.currency?.code}"/>
	<h2>
		${message(code:'loan.templates.details.content.detailsfor.h2.text')}
		${loanDetailModel?.accountNumber}
	</h2>
	<g:form>
		<table border="0" cellpadding="0" cellspacing="0" class="dtl_view">
			<tr>
            	<td>${message(code:'loan.loandetails.accountnumber.label')}</td>
                <td>${loanAccount?.accountNumber}</td>
            </tr>
            <tr>
            	<td>${message(code:'loan.loandetails.accountname.label')}</td>
                <td>${loanAccount?.shortName}</td>
            </tr>
            <tr>
   				<td>${message(code:'investment.templates.details.deposit.nickname.label')}</td>
   				<td>    				
   				<div>
		        <g:hiddenField name="accountShortName" id="accountShortName" value="${loanAccount?.accountShortName}"/>
		        <g:hiddenField name="accountNumber" value="${loanAccount?.accountNumber}"/>
				<span id="nick" data-nick="nick-${loanAccount?.accountNumber}">${loanAccount?.accountShortName}</span> 
				
				<a href="javascript:void(0)" class="edit_row">${message(code:'investment.templates.details.deposit.edit.text')}</a>
				
				<g:submitToRemote url="[action:'updateaccountnickname']" update="[failure:'messagesDiv']" value='${message(code:'investment.templates.details.deposit.save.text')}' id='save_edit' name='save_edit' class="hidden" before="if (checkNickNameValidity()) {return false;}if (checkNickNameAlpha()) {return false;} updateAccountNickName();" onSuccess="nicknamesuccess();" />
				<input type='button' value='${message(code:'investment.templates.details.deposit.button.cancel.text')}' id='cancel_edit'
					class='btn_next hidden'>
					
				</div>
   				</td>			
   			</tr>
            
            <tr>
            	<td>${message(code:'loan.loandetails.accounttype.label')}</td>
                <td>${loanAccount?.accountType?.description}</td>
            </tr>
            <tr>
            	<td>${message(code:'loan.loandetails.currency.label')}</td>
                <td>${loanAccount?.currency?.code}</td>
            </tr>   			
			<tr>
				<td>${message(code:'loan.loandetails.sanctionamount.label')}</td>
				<td class="amt">
				<vayana:formatAmount
										currency="${loanAccount?.currency?.code}"
										amount="${loanAccount?.sanctionedAmount}" /></td>
			</tr>
			<tr>
				<td>${message(code:'loan.loandetails.interestrate.label')}</td>
				<td class="amt">${loanAccount?.interestRate}</td>
			</tr>
			<tr>
				<td>${message(code:'loan.loandetails.installmentstartdate.label')}</td>
				<td><vayana:formatDate date="${loanAccount?.installmentStartDt}"/></td>
			</tr>
			
			<tr>
				<td>${message(code:'loan.loandetails.totalamountdisbursed.label')}</td>
				<td class="amt">
				<vayana:formatAmount
										currency="${loanAccount?.currency?.code}"
										amount="${loanAccount?.disbursedAmount}" />
				</td>
			</tr>
			<tr>
				<td>${message(code:'loan.loandetails.installmentamount.label')}</td>
				<td class="amt">
				<vayana:formatAmount
										currency="${loanAccount?.currency?.code}"
										amount="${loanAccount?.nextInstallmentAmount}" />
				
				</td>
			</tr>
			<tr>
				<td>${message(code:'loan.loandetails.totaloutstanding.label')}</td>
				<td class="amt">
				<vayana:formatAmount
										currency="${loanAccount?.currency?.code}"
										amount="${loanAccount?.totalOutStandingAmount}" /> Dr.
				</td>
			</tr>


				




			<%--<tr>
				<td>
					${message(code:'loan.loandetails.lastinstallmentdate')}
				</td>
				<td>
				<vayana:formatDateLabel name="lastInstallmentDate" id="lastInstallmentDate" value="${loanAccount?.lastInstallmentDate}"  />
					
				</td>
			</tr>

			<tr>
				<td>
					${message(code:'loan.loandetails.pastdueamount')}
				</td>
			<td class="amt">
					${loanAccount?.pastDueAmount}
				</td>
			</tr>

			
		--%>
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