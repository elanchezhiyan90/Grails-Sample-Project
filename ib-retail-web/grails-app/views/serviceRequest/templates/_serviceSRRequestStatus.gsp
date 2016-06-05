
<!-- Sticky header starts here ----------->
<div class="start-stick_top"></div>
<div class="grid_stickyhead_top">
	<table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
		<thead>
			<tr>
				<th width="20%">Ref. Number</th>
				<th width="20%">Request Type</th>
				<th width="20%">Initiated Date</th>
				<th width="20%">Request Status</th>
				<th width="10%"></th>
				<th width="10%"></th>

			</tr>

		</thead>
	</table>
</div>
<!-- Sticky header ends here ----------->
<table cellspacing="0" cellpadding="0" border="0" class="grid">

	<tbody>
		<tr>
			<td width="20%"></td>
			<td width="20%"></td>
			<td width="20%"></td>
			<td width="20%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
		</tr>
		<g:if test="${genericSRModel?.serviceRequestInstructions}">
			<g:each in="${genericSRModel?.serviceRequestInstructions}"
				var="sRInstructions" status="index">

				<tr class="has-dtl" id="has-dtl-${index}">
					<td width="20%">
						${sRInstructions?.referenceTag}
					</td>
					<td width="20%">
						${sRInstructions?.tenantService?.serviceApplication?.service?.description}
					</td>
					<td width="20%">
						<vayana:formatDate date="${sRInstructions?.serviceRequestDatetime}" showTime="true" />
					</td>
					<!-- Display the Status -->
					<g:if test="${sRInstructions?.displayStatus?.equals('PFA') || sRInstructions?.displayStatus?.equals('REJECTED')}">
						<g:set var="status" value="${sRInstructions?.displayStatus}" />
						<th width="20%"> ${g.message(code: 'servicerequest.templates.status'+status)} </th>
						<g:if test="${sRInstructions?.displayStatus?.equals('PFA')}">
							<td width="5%"><g:link controller="serviceRequest"
									action="cancelServicerequests"
									params="[processInstanceId:sRInstructions?.processInstanceId]"
									update="status" onSuccess="resizeEditContainer();"
									title="RequestStatus">Cancel</g:link></td>
						</g:if>
						<td width="5%"><g:link controller="serviceRequest"
								action="viewserviceRequestDetails"
								params="[processInstanceId:sRInstructions?.processInstanceId,recordStatus:sRInstructions?.displayStatus]"
								title="Request Status" class="ceebox">View</g:link></td>
					</g:if>
					<g:elseif
						test="${sRInstructions?.status && sRInstructions?.status?.code?.equals('ACT')}">
						<g:set var="status" value="${sRInstructions?.status?.code}" />
						<th width="15%">
							${g.message(code: 'servicerequest.templates.status'+status)}
						</th>
						<td width="5%"><g:link controller="serviceRequest"
								action="serviceRequestDetails"
								params="[serviceRequestInstructionId:sRInstructions?.id,recordStatus:sRInstructions?.status?.code]"
								title="Request Status" class="ceebox">View</g:link></td>
					</g:elseif>
				</tr>
			</g:each>
		</g:if>


		<g:else>
			<tr>
				<td width="20%">&nbsp;</td>
				<td width="20%">&nbsp;</td>
				<td width="20%">&nbsp;</td>
				<td width="20%">No Record Found</td>
				<td width="10%">&nbsp;</td>
				<td width="10%">&nbsp;</td>
			</tr>
		</g:else>

	</tbody>
</table>
<br />
<script>
		/********* Ceebox for grid catergory ***************/
		$(".cat a").attr('rel',"width:400px; height:380px");
		$(".ceebox").ceebox();
		
	 function resizeEditContainer()    
						{
							$("#status").dynamicfieldupdate();
						}
	   
	</script>
