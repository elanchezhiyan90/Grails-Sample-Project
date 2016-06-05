<div>
	<section>
		<g:form name="goalstatus">
			<vayana:popupMessages></vayana:popupMessages>
			<div id="applicationStatus">
				<g:hiddenField name="version" value="${goals?.version}" />
				<g:hiddenField name="processInstanceId"
					value="${goals?.processInstanceId}" />
				<g:hiddenField name="goalId" value="${goals?.id}" />
				<g:hiddenField name="entityId" value="${goals?.id}" />
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
												currency="${goalEditModel?.goalTargetCurrency?.code}"
												amount="${userGoalRequest?.targetAmount}"></vayana:formatAmount></span>
										<span class="cur">(${goalEditModel?.goalTargetCurrency?.code})
									</span></td>

								</tr>
								<tr>
									<td>Start Date</td>
									<td>
										${userGoalRequest?.startDate?.format("dd-MMM-yyyy")}
									</td>
								</tr>
								<tr>
									<td>Achieved By</td>
									<td>
										${userGoalRequest?.targetDate?.format("dd-MMM-yyyy")}
									</td>
								</tr>
								<tr>
									<td>Frequency</td>
									<td>
										${goalEditModel?.goalFrequency?.code}
									</td>
								</tr>
								<tr>
									<td>Fund From</td>
									<td>
										${goalEditModel?.goalFromAccount?.accountNumber} ( ${goalEditModel?.goalFromAccount?.currency?.code})
									</td>
								</tr>
								<tr>
									<td>Saving Amount</td>
									<td><span class="amt"><vayana:formatAmount
												currency="${goalEditModel?.goalTargetCurrency?.code}"
												amount="${userGoalRequest?.contributionAmount}"></vayana:formatAmount></span>
										<span class="cur">(${goalEditModel?.goalTargetCurrency?.code})
									</span></td>

								</tr>
								
									<tr>
									<td>Remarks</td>


									<td>
										${userGoalRequest?.remarks}
									</td>
								</tr>
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
							action="fetchSecurityAdviceForAService" displayAsPopUp="YES"
							successAction="updateownGoal" successController="goal"
							targetService="GOAL" formName="goalstatus" />

						<input type="button" value="Cancel" class="btn_next"
							id="canceltrans"
							onclick="postUrl('frmLookUpType','/ib-retail-web/goals/addnewgoals','canvas');" />

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

$( ".applyloan" ).tabs({disabled: [1,2,3]},{selected:[0]} );
$(".applyloan").tabs("refresh");



}

<%--		

$("#frmLookUpType").dynamicfieldupdate();
$(".fields").dynamicfieldupdate();

--%></script>


</div>



