<g:form name="updatesmsalerts">
<h2> Alerts SMS Notification </h2>
<vayana:messages/>
	<!-- Sticky header starts here ----------->
	<div class="start-stick_top"></div>
	<div class="grid_stickyhead_top">
		<table border="0" cellpadding="0" cellspacing="0" class="style_grid">
			<thead>
				<tr>
					<th width="10%" align="center">Event Subscription</th>
					<br/>
					<br/>
					<th width="20%" align="center" >Account Number</th>
					<th width="20%" align="center">notes/Description</th>
					<th width="20%" align="center">No Of Days Before Event</th>
					<th width="15%" align="center">UpperLimit</th>
					<th width="15%" align="center">LowerLimit</th>
				</tr>
			</thead>
		</table>
	</div>
<%--	<g:hiddenField name="checkedAlerts" id="checkedAlerts" value=""/>--%>
	<g:hiddenField name="mobileNumber" id="mobileNumber" value="${smsAlertModel?.mobileNumber}"/>
	<!-- Sticky header Ends here ----------->
	<div id="mainContent">
		<table border="0" cellpadding="0" cellspacing="0" class="style_grid" id="displayAlerts">
			<tbody>
				<g:if test="${smsAlertModel?.smsAlerts}">

					<g:each in="${smsAlertModel?.smsAlerts}" var="getSMSAlerts" status="index">  
						<tr>
							<td width="10%">
							<span>
								<g:checkBox name="alertselect" id="alertselect"   checked="${getSMSAlerts?.isRegistered.equals("R")}" onClick="checkBoxAction(this,'${index}')"/>
							</span> 
							</td>
							<td width="20%">
							<span>${getSMSAlerts?.accountNumber}</span> 
							<g:hiddenField name="accountNumber" id="accountNumber" value="${getSMSAlerts?.accountNumber}"/>
							</td>
							<td width="20%">
							<span>${getSMSAlerts?.alertDesc}</span> 
							<g:hiddenField name="alertDesc"  id="alertDesc" value="${getSMSAlerts?.alertDesc}"/>   
							</td>
							<td>
							<g:hiddenField name="alertID"  id="alertID" value="${getSMSAlerts?.alertID}" />
							</td>
							<td>
							<g:hiddenField name="isRegistered"  id="isRegistered_${index}" value="${getSMSAlerts?.isRegistered}" />
							</td>
							<td width="20%">
							<span><g:textField  name="numberOfDays" id="numberOfDays" value="${getSMSAlerts?.numberOfDays}" pattern="[0-9]*" /></span> 
							</td>
							<td width="15%">
							<span><g:textField  name="upperLimit" value="${getSMSAlerts?.upperLimit}" pattern="[0-9]*" /></span> 
							</td>
							<td width="15%">
							<span><g:textField  name="lowerLimit" value="${getSMSAlerts?.lowerLimit}" pattern="[0-9]*" /></span> 
							</td>
									
						</tr>
						
					</g:each>		
							
				</g:if>
				<g:else>
					<tr>
						<td width="10%">&nbsp;</td>
						<td width="20%">&nbsp;</td>
						<td width="20%">No Records Found</td>
						<td width="30%">&nbsp;</td>
						<td width="10%">&nbsp;</td>
						<td width="10%">&nbsp;</td>
					</tr>
				</g:else>
		<g:hiddenField name="rowIndexCount" value="0" />		
				
			</tbody>
		</table>
		<div class="buttons">				
						<vayana:submitToRemote value="${message(code:'userprofile.template.changesecureaccess.submit.button.text')}"
						   action="updatesmsalerts" controller="userProfile"
						   id="verifySubmit" name="verifySubmit"						
						  update="[failure:'messagesDiv']"
						   before="if (checkFormValidity()) {return false;}"
							onSuccess="updateFormData(data,textStatus)" />
	
			</div>		
		
	</div>
</g:form>

<script>
 $(document).ready(function () {
       $(".updatesmsalerts").dynamicfieldupdate();
       getRowCount();
	});
	
	function getRowCount()
	{
		var vRowIndexCnt = $("#displayAlerts tr").length;
		$("#rowIndexCount").val(vRowIndexCnt);
	}
function checkBoxAction(it,param) {
	if($(it).is(':checked')) {        
		$("#isRegistered_"+param).val('R')
		} else {
		$("#isRegistered_"+param).val('U')
		}
}
</script>


