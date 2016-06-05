<div id="mainContent">
<!-- Sticky header starts here ----------->
<div class="start-stick_top"></div>
<div class="grid_stickyhead_top" id="templateHeader">
	<table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
		
	</table>
</div>
<!-- Sticky header ends here ----------->
<table border="0" cellpadding="0" cellspacing="0" class="grid">

<thead>
			<tr>
				<th width="20%">Reference No</th>
				<th width="15%">Nick Name</th>
				<th width="15%">From A/C</th>
				<th width="10%">Start Date</th>
				<th width="10%">End Date</th>
				<th width="5%">Frequency</th>
				<th width="10%">Currency</th>
				<th width="5%">Amount</th>
				<th width="5%">Status</th>
				<th width="5%">&nbsp;</th>
				<th width="5%">&nbsp;</th>
			</tr>
		</thead>
	<tbody>
		<tr>
			<td width="20%"></td>
			<td width="15%"></td>
			<td width="15%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="5%"></td>
			<td width="10%"></td>
			<td width="5%"></td>
			<td width="5%"></td>
			<td width="5%"></td>
			<td width="5%"></td>
		</tr>
		<g:if test="${paymentScheduleHeaders}">
			<g:each in="${paymentScheduleHeaders}" var="standingIns" status="index">
				<tr class="has-dtl" id="has-dtl_${index}">
					<td>
						${standingIns?.referenceTag}  
					</td>
					<td>
					${standingIns?.paymentScheduleDetail?.iterator()?.next()?.payeeInstruction?.shortName}
					<%--${standingIns?.paymentScheduleDetail?.iterator()?.next()?.payeeInstruction?.billerData[0]?.dataVarcharValue}
							${standingIns?.paymentScheduleDetail?.iterator()?.next()?.payeeInstruction?.billerData[0]?.billerMetadata?.dataLabel?.description}
					--%></td>
					<td>
						${standingIns?.paymentScheduleDetail?.iterator()?.next()?.payerInstruction?.accountNumber}
					</td>
					<td>
					<vayana:formatDate date="${standingIns?.frequencyStartDate}" format="dd-MM-yyyy"/>
						
					</td>
					<td>
						<vayana:formatDate date="${standingIns?.frequencyEndDate}" format="dd-MM-yyyy"/>
<%--						${standingIns?.frequencyEndDate}--%>
					</td>
					<td>
						${standingIns?.frequency?.code}
					</td>
					<td align="center">
						${standingIns?.paymentScheduleDetail?.iterator()?.next()?.paymentCurrency?.code}<%--${standingIns?.paymentScheduleDetail?.iterator()?.next()?.paymentAmount}--%>
					</td>
					<td align="center">
						${standingIns?.paymentScheduleDetail?.iterator()?.next()?.paymentAmount}
					</td>
					<td>
						${standingIns?.paymentScheduleDetail?.iterator()?.next()?.status?.code}
					</td>
						<td>
<%--						<g:remoteLink class="edit_row" controller="payment"--%>
<%--								action="editSI" update="editDataDiv_${index}" params:[beneficiaryInstructionId:beneInstructions?.idVersion,beneficiaryId:beneInstructions?.beneficiary?.idVersion])--%>
<%--								onSuccess="onSIEditSuccess('${index}')">Edit</g:remoteLink>--%>
<%--								<g:set var="tstCode${index}" value="${(standingIns?.paymentScheduleDetail?.iterator()?.next()?.payeeInstruction?.account)?standingIns?.paymentScheduleDetail?.iterator()?.next()?.payeeInstruction?.account?.id : standingIns?.paymentScheduleDetail?.iterator()?.next()?.payeeInstruction?.beneficiary?.id}"/>--%>
								<a
						href="${createLink(controller:'billPayment' ,action:'editSI',params:[spdId:standingIns?.paymentScheduleDetail?.iterator()?.next()?.id,beneId:(standingIns?.paymentScheduleDetail?.iterator()?.next()?.payeeInstruction?.account) ? standingIns?.paymentScheduleDetail?.iterator()?.next()?.payeeInstruction?.account?.id : standingIns?.paymentScheduleDetail?.iterator()?.next()?.payeeInstruction?.biller?.id])}"
						class="edit_row" title="Edit"></a>

						</td>
						<td><g:remoteLink class="remove" controller="customerTemplate"
								before="if (!deleteRecord('${standingIns?.paymentScheduleDetail?.iterator()?.next()?.id}','${standingIns?.referenceTag}')) {return false;}"
								action="deleteIBFapBasket"
								>Delete</g:remoteLink></td>
					
				</tr>
				<tr class="view-dtl" id="view-dtl_${index}">
					<td colspan="10">
						<div id="editDataDiv_${index}"></div>
					</td>
				</tr>
			</g:each>
		</g:if>
		<g:else>
			<tr>
				<td width="30%">&nbsp;</td>
				<td width="30%">No Record Found</td>
				<td width="20%">&nbsp;</td>
				<td width="20%">&nbsp;</td>
				<td width="20%">&nbsp;</td>
			</tr>
		</g:else>
	</tbody>
</table>
</div>
<script>
function deleteRecord(id,code){
		
		var x = "Are you sure you want to take this action";
			
		    $('<div>' + x + '</div>').dialog({
		        resizable: false,
		        height:140,
		        title:"Confirm Delete?",
		        position:['middle',200],
		        draggable: false,
		        modal:true,
		        buttons: {
		            "Yes": function() {						            	
		                $(this).dialog("close");		       
		                <vayana:deleteFunction controller="billPayment" action="suspendStandingInstruction" params="\'paymentScheduleDetailId=\'+id+\'&code=\'+code" update="mainContent" onSuccess="onDeleteSuccess()"  />						                
		            },
		            Cancel: function() {
		                $(this).dialog("close"); //close confirmation
		            }
		        }
		    
		});
}
function onDeleteSuccess(){
	$("#mainContent").dynamicfieldupdate();
}
function getRecordStatus()
{
	var sts = $("#recordStatus").val();
	return sts;
}	
</script>