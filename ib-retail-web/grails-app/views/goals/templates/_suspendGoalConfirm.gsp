<div class="body-scroll">
	<section>
		<vayana:popupMessages></vayana:popupMessages>
		<g:form name="goalstatus">
			<div id="applicationStatus">
				<g:hiddenField name="goalsuspendId" value="${params?.goalId}" />
				<ul class="payment_dtls">
					<li><p class="hdr">Goal Confirmation</p></li>

					<li>
						<div class="dtl_wralp">

							<table class="dtl_view">
								<tr>
									<td>Goal Name</td>


									<td>
										${userGoalRequest?.goalName}
									</td>
								</tr>

								<tr>
									<td>Target Amount</td>
									<td><span class="amt"><vayana:formatAmount
												currency="${goalModelconfirm?.goalTargetCurrency?.code}"
												amount="${userGoalRequest?.targetAmount}"></vayana:formatAmount></span>
										<span class="cur">(${goalModelconfirm?.goalTargetCurrency?.code})
									</span></td>

								</tr>




								<tr>
									<td>Achieved By</td>
									<td>
										${userGoalRequest?.targetDate?.format("dd-MMM-yyyy")}
									</td>
								</tr>

								<tr>
									<td>Contribute</td>
									<td>
										${goalModelconfirm?.goalFrequency?.code}
									</td>
								</tr>

								<tr>
									<td>Fund From</td>
									<td>
										${goalModelconfirm?.goalFromAccount?.accountNumber} ( ${goalModelconfirm?.goalFromAccount?.currency?.code})
									</td>

								</tr>

								<tr>
									<td>Saving Amount</td>
									<td><span class="amt"><vayana:formatAmount
												currency="${goalModelconfirm?.goalSavingCurrency?.code}"
												amount="${userGoalRequest?.contributionAmount}"></vayana:formatAmount></span>
										<span class="cur">(${goalModelconfirm?.goalSavingCurrency?.code})
									</span></td>

								</tr>
								<%--
      
             <tr>
            <td> Share With </td>
         
            <td>${userGoalRequest?.shareWith}</td>
            </tr>
         --%>
							</table>
						</div>
					</li>


					<div class="info">
						<p>
							<span></span><strong>Terms and Condition</strong>
						</p>
						<p>Terms and condition will come here.Terms and condition will
							come here.Terms and condition will come here.Terms and condition
							will come here</p>
					</div>
					<br />
					<p>
						<label><input type="checkbox" name="terms" id="terms"
							required="required"
							data-errormessage="You have to agree the terms and condition to proceed" />
							I agree the above terms and conditions</label>
					</p>
					<div id="dynamicAuthContent">
						<vayana:securitysetting controller="security"
							action="fetchSecurityAdviceForAService"
							successAction="supendGoal" successController="goal"
							targetService="GOAL" formName="goalstatus" />

						<input type="button" value="Cancel" class="btn_next"
							id="canceltrans" onclick="cancelfun()" />




						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
					</div>
		</g:form>
	</section>
	<script>
 

function cancelfun(){




}

<%--		

$("#frmLookUpType").dynamicfieldupdate();
$(".fields").dynamicfieldupdate();

--%></script>


</div>



