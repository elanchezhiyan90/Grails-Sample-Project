
<section class="col-480">
<g:set var="prepaidCardAccount" value="${prepaidCardDetailModel.prepaidCardAccount}" />
<div class="body-scroll">
     <h2>Details for  ${prepaidCardAccount?.accountNumber} </h2>
      <h3>Last Payment Details</h3>
      <g:form>
     	<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
    			<tr>
                	<td>Payment Received</td>
                    <td class="amt"><vayana:formatAmount amount="${prepaidCardAccount?.lastPaymentAmountReceived}" currency="${prepaidCardAccount?.currency?.code}" /></td>
                </tr>
                <tr>
                	<td>Payment Due Date</td>
                    <td><vayana:formatDateLabel name="paymentDueDate" id="paymentDueDate" value="${prepaidCardAccount?.paymentDueDate}"  /></td>
                </tr>
                <tr>
                	<td>Payment Received Date</td>
                    <td><vayana:formatDateLabel name="paymentReceiveDate" id="paymentReceiveDate" value="${prepaidCardAccount?.lastPaymentReceivedDate}"  /></td>
                </tr>
        </table> 
        <br/>
      <h3>Reward Details</h3>
     	<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
    			<tr>
                	<td>Total Reward Points</td>
                    <td>${prepaidCardAccount?.rewardPointsEarned}</td>
                </tr>
                <tr>
                	<td>Reward Points this month</td>
                    <td>${prepaidCardAccount?.rewardPointsEarnedCurrentMonth}</td>
                </tr>
                <tr>
                	<td>Reward Points Expiring</td>
                    <td>${prepaidCardAccount?.rewardPointsExpiring}</td>
                </tr>
                <tr>
                	<td>Reward Points Redeemed</td>
                    <td>${prepaidCardAccount?.rewardPointsRedeemed}</td>
                </tr>
        </table>
        <br/>    
       <h3>Cash Back Earned Details</h3>
     	<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
    			<tr>
                	<td>Cash Back earned this month</td>
                    <td class="amt">${prepaidCardAccount?.cashBackEarnedCurrentMonth}</td>
                </tr>
                <tr>
                	<td>Cash Back for the current Year</td>
                    <td class="amt">${prepaidCardAccount?.cashBackEarnedCurrentYear}</td>
                </tr>
        </table>
        <br/>               
     <h3>Card Details</h3>
		<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
    								<tr>
                                    	<td>Account Holder Name</td>
                                        <td>${prepaidCardAccount?.nameOnCard}</td>
                                    </tr>
                                    <tr>
			<td>Nick Name</td>
			<td><div>
					<g:hiddenField name="nameBeforeEdit" id="nameBeforeEdit" value=""/>
			        <g:hiddenField name="accountShortName" id="accountShortName" value="${prepaidCardAccount?.accountShortName}"/>
			        <g:hiddenField name="accountNumber" value="${prepaidCardAccount?.accountNumber}"/>
					<span id="nick" data-nick="nick-${prepaidCardAccount?.accountNumber}">${prepaidCardAccount?.accountShortName}</span> 
					<a href="javascript:void(0)" class="edit_row" id="edit">edit</a>
					<g:submitToRemote url="[action:'updateprepaidcardnickname']" update="[failure:'messagesDiv']" before="updateAccountNickName();" value='Save' id='save_edit' name='save_edit' class="hidden" onSuccess="nicknamesuccess();"/>
					<input type='button' value='Cancel' id='cancel_edit'
						class='btn_next hidden'>
				</div></td>
		</tr>
                                	<tr>
                                    	<td>Card Product Name</td>
                                        <td>${prepaidCardAccount?.cardType}</td>
                                    </tr>
                                    <tr>
                                    	<td>Card Issued Date</td>
                                        <td><vayana:formatDateLabel name="validFromDate" id="validFromDate" value="${prepaidCardAccount?.validFromDate}"  /></td>
                                    </tr>
                                    <tr>
                                    	<td>Billing Cycle Date</td>
                                        <td>${prepaidCardAccount?.billingCycleDay} of Month</td>
                                    </tr>
                                    <tr>
                                    	<td>Currency</td>
                                        <td>${prepaidCardAccount?.currency?.code}</td>
                                    </tr>
                                    <tr>
                                    	<td>Total Prepaid Limit</td>
                                        <td class="amt"><vayana:formatAmount amount="${prepaidCardAccount?.totalPrepaidLimit}" currency="${prepaidCardAccount?.currency?.code}" /></td>
                                    </tr>
                                     <tr>
                                    	<td>Total Cash Limit</td>
                                        <td class="amt"><vayana:formatAmount amount="${prepaidCardAccount?.totalCashLimit}" currency="${prepaidCardAccount?.currency?.code}" /></td>
                                    </tr>
                                    <tr>
                                    	<td>Total Outstanding</td>
                                        <td class="amt"><vayana:formatAmount amount="${prepaidCardAccount?.outStandingAmount}" currency="${prepaidCardAccount?.currency?.code}" /></td>
                                    </tr>
                                    <tr>
                                    	<td>Unbilled Outstanding</td>
                                        <td class="amt"><vayana:formatAmount amount="${prepaidCardAccount?.unbilledAmount}" currency="${prepaidCardAccount?.currency?.code}" /></td>
                                    </tr>
                                    <tr>
                                    	<td>Available Prepaid Limit</td>
                                        <td class="amt"><vayana:formatAmount amount="${prepaidCardAccount?.availablePrepaidLimit}" currency="${prepaidCardAccount?.currency?.code}" /></td>
                                    </tr>
                                    <tr>
                                    	<td>Available Cash Limit</td>
                                        <td class="amt"><vayana:formatAmount amount="${prepaidCardAccount?.availableCashLimit}" currency="${prepaidCardAccount?.currency?.code}" /></td>
                                    </tr>
                                     <tr>
                                    	<td>Total Amount Due</td>
                                        <td class="amt"><vayana:formatAmount amount="${prepaidCardAccount?.totalAmountDue}" currency="${prepaidCardAccount?.currency?.code}" /></td>
                                    </tr>
                                     <tr>
                                    	<td>Minimum Amount Due</td>
                                        <td class="amt"><vayana:formatAmount amount="${prepaidCardAccount?.minimumAmountDue}" currency="${prepaidCardAccount?.currency?.code}" /></td>
                                    </tr>
                                </table>
                                </g:form>
                                <br/>
                                <br/>	
                                </div>																		
</section >
