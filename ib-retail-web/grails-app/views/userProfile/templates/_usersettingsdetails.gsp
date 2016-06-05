<html>
<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<div>
		<section>
				<g:set var="lookupType"
					value="${lookupTypeResponseModel.lookupType}" />
				<div class="fields" id="lookuptypedesc">
					<p>
						<label for="instructionCode">Instruction Code</label>
						<g:textField name="instructionCode" id="instructionCode"
							readonly="readonly" value="${lookupType.code}" />
					</p>
					<p>
						<label for="instructiondesc">Instruction Description</label>
						<g:textField name="instructiondesc" id="instructiondesc"
							readonly="readonly" value="${lookupType.description}" />
					</p>
					
					<g:remoteLink controller="systemparams" action="lookupvalueForm"  update="lookupvalueForm"  params="[lookupTypeId:lookupType?.id]" class="add" onSuccess="resizeContainer()" >+</g:remoteLink>
                 
            <div id="lookupvalueForm">
			                        	
			</div>

				</div>
				<!-- Sticky header starts here ----------->
				<div class="start-stick_top"></div>
				<div class="grid_stickyhead_top">
					<table border="0" cellpadding="0" cellspacing="0"
						class="grid_theader">
						<thead>
							<tr>
								<th width="30%">Instruction Code</th>
								<th width="30%">Instruction Description</th>
								<%--<th width="30%">Allow Transfers</th>
                            --%>
								<th width="10%">&nbsp;</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- Sticky header ends here ----------->

				<table border="0" class="grid">
					<g:each var="lookupvalue" in="${lookupType.lookUpValue}">
						<tr class="has-dtl" id="row-${lookupvalue?.id}">
							<td>
								${lookupvalue.code}
							</td>
							<td>
								${lookupvalue.description}
							</td>
							<td width="10%"><g:remoteLink class="edit_row"
									controller="systemparams" action="editlookupValue"
									update="${lookupvalue?.id}"
									params="[lookupValueId:lookupvalue?.id]">Edit</g:remoteLink>
							</td>
							<td width="10%"><g:remoteLink class="remove" before="if (!deleteRow()) {return false;}"
									controller="systemparams" action="deletelookupvalue"
									update="${lookupvalue?.id}"
									params="[lookupValueId:lookupvalue?.id]"
									onSuccess="loadSuccess(${lookupvalue?.id})">Delete</g:remoteLink></td>
						</tr>
						<tr class="view-dtl" id="row-dtl-${lookupvalue?.id}">
							<td colspan="4">

								<div class="updateSuccess" id="${lookupvalue?.id}">

								</div>
							</td>
						</tr>
					</g:each>
				</table>

			<script>
			$(document)
						.ready(
								function() {
									$(".grid tr.has-dtl a.edit_row ")
											.click(
													function(event) {
														$(this)
																.parents(
																		"tr.has-dtl")
																.next(
																		"tr.view-dtl")
																.fadeToggle(
																		500,
																		function() {
																			$(
																					this)
																					.dynamicfieldupdate()
																		});
														$(this).parents(
																"tr.has-dtl")
																.toggleClass(
																		'hlt');
													});
								});

				function loadSuccess(id) {
					$("#row-"+id).remove();
					$("#row-dtl-"+id).remove();
				}


				function deleteRow() {
					var answer = confirm("Are you sure delete the data?");
					if (answer) {
						return true;
					} else {
						return false;
					}
				}


				function resizeContainer()
				{
				$("#lookupvalueForm").dynamicfieldupdate();
				}
			</script>
		</section>
	</div>
</body>
</html>

