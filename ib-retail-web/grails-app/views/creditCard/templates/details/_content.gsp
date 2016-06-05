
<section class="col-480">
<g:set var="creditCardAccount" value="${creditCardDetailModel.creditCardAccount}" />
<div class="body-scroll">
     <h2>Details for  ${creditCardAccount?.maskedCCNumber} </h2><br/> 
      
      <g:form id="ccDetails" name="ccDetails">
       
     <h3>Card Details</h3>
		<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
			<tr>
	       		<td>Card Number</td>
	           	<td>${creditCardAccount?.maskedCCNumber}</td>
	        </tr>
			<tr>
	        	<td>Card Holder Name</td>
	            <td>${creditCardAccount?.nameOnCard}</td>
	       </tr>
	       <tr>
           		<td>Card Type</td>
               	<td>${creditCardAccount?.cardType}</td>
           </tr>
           <tr>
           		<td>Card Currency</td>
               	<td>${creditCardAccount?.currency?.code}</td>
           </tr>       
           <tr>
          		<td>Card Limit</td>
              	<td class="amt"><vayana:formatAmount amount="${creditCardAccount?.totalCreditLimit}" currency="${creditCardAccount?.currency?.code}" /></td>
          </tr>
           <tr>
           		<td>Available Total Limit</td>
               	<td class="amt"><vayana:formatAmount amount="${creditCardAccount?.availableCreditLimit}" currency="${creditCardAccount?.currency?.code}" />
               	<g:if test="${creditCardAccount?.availableCreditLimit < 0}">
               		<vayana:postablelink controller="payment"
						action="ccTransferExcessCredit" id="excesstransfer" target="canvas" linkTitle="CreditCard Balance Transfer">Excess Limit</vayana:postablelink>
				</g:if>
               	</td>
           </tr>
           <tr>
           		<td>Available Cash Limit</td>
               	<td class="amt"><vayana:formatAmount amount="${creditCardAccount?.availableCashLimit}" currency="${creditCardAccount?.currency?.code}" /></td>
           </tr>
           <tr>
           		<td>Outstanding Balance</td>
               	<td class="amt"><vayana:formatAmount amount="${creditCardAccount?.outStandingAmount}" currency="${creditCardAccount?.currency?.code}" /></td>
           </tr>
           <tr>
           		<td>Amount on Hold</td>
               	<td class="amt"><vayana:formatAmount amount="${creditCardAccount?.amountOnHold}" currency="${creditCardAccount?.currency?.code}" /></td>
           </tr>
           <tr>
           		<td>Minimum Amount Due</td>
               	<td class="amt"><vayana:formatAmount amount="${creditCardAccount?.minimumAmountDue}" currency="${creditCardAccount?.currency?.code}" /></td>
           </tr>
            <tr>
            	<td>Last Paid Amount</td>
                <td class="amt"><vayana:formatAmount amount="${creditCardAccount?.lastPaymentAmountReceived}" currency="${creditCardAccount?.currency?.code}" /></td>
            </tr>
            <tr>
            	<td>Last Payment Date</td>
                <td><vayana:formatDateLabel name="paymentReceiveDate" id="paymentReceiveDate" value="${creditCardAccount?.lastPaymentReceivedDate}"  /></td>
            </tr>
            <tr>
            	<td>Due Date</td>
                <td><vayana:formatDateLabel name="paymentDueDate" id="paymentDueDate" value="${creditCardAccount?.paymentDueDate}"  /></td>
            </tr>
                                    
                                    
       		<%--
	       		<tr>
					<td>Nick Name</td>
					<td><div>
					        <g:hiddenField name="accountShortName" id="accountShortName" value="${creditCardAccount?.accountShortName}"/>
					        <g:hiddenField name="accountNumber" value="${creditCardAccount?.accountNumber}"/>
							<span id="nick" data-nick="nick-${creditCardAccount?.maskedCCNumber}">${creditCardAccount?.accountShortName}</span> 
							<a href="javascript:void(0)" class="edit_row">edit</a>
							<g:submitToRemote url="[action:'updatecreditcardnickname']" before="updateAccountNickName();" value='Save' id='save_edit' name='save_edit' class="hidden" onSuccess="nicknamesuccess();" onFailure="onAjaxFailure(textStatus);"/>
							<input type='button' value='Cancel' id='cancel_edit'
								class='btn_next hidden'>
						</div></td>
				</tr>                                	
              --%>
                                   
               </table>
               </g:form>
               <br/>
               <br/>	
               </div>																		
</section >
<g:javascript>

$("#excesstransfer").click(function(){
	var link = "<g:createLink action='ccTransferExcessCredit' controller='payment' params='[accountId: creditCardAccount?.id]' 
	/>"
	postUrl('ccDetails',link,'canvas')	
});



function postUrl(formName, url, targetName)
{
	var form = $('#'+formName);  
	form.attr('action',url);
	form.attr('method','POST');
	form.attr('target',targetName);
	form.submit();
}
</g:javascript>