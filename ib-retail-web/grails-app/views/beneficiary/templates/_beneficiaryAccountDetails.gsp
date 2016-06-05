<g:hiddenField name="securityHolderSize" value="${(params?.securityHolderSize) ? params?.securityHolderSize : 'true'}" />
<g:set var="beneInstructionlist" value="${beneInsRespone?.beneficiaryInstructions}" />
<table cellspacing="0" cellpadding="0" border="0" class="grid">
	<thead>
		<tr>
			<th width="20%"><g:message code="beneficiary.templates.accountdtl.nickname.label" /></th>
			<th width="10%"><g:message code="beneficiary.templates.accountdtl.paymenttype.label" /></th>
			<th width="20%"><g:message code="beneficiary.templates.accountdtl.accountno.label" /></th>
			<%--                            <th width="15%"><g:message code="beneficiary.templates.accountdtl.accounttype.label"/></th>--%>
			<th width="20%"><g:message code="beneficiary.templates.accountdtl.bankname.label" /></th>
			<th width="20%"><g:message code="beneficiary.templates.accountdtl.status.label" /></th>
			<th width="5%">&nbsp;</th>
			<th width="5%">&nbsp;</th>
		</tr>

	</thead>

	<tbody>
		<tr>
			<td width="20%"></td>
			<td width="10%"></td>
			<td width="20%"></td>
			<%--                          <td width="15%"></td>--%>
			<td width="20%"></td>
			<th width="20%"></th>
			<td width="5%"></td>
			<td width="5%"></td>
		</tr>

		<g:each in="${beneInstructionlist}" var="beneInstructions"
			status="index">
			<tr class="has-dtl">
				<td>
					${(beneInstructions?.shortName?.contains('_')) ? beneInstructions?.shortName?.split('_')[0]  : beneInstructions?.shortName}
				</td>
				<g:set var="paymenttype"
					value="${beneInstructions?.transactionSubType?.serviceApplication?.service?.code.trim()}" />
				<td>
					${g.message(code: 'beneficiary.templates.accountdtl'+paymenttype)}
				</td>

				<td>
					${beneInstructions?.accountNumber}
				</td>
				<%--	                           <td>${beneInstructions?.accountType?.description}</td>--%>
				<g:if
					test="${beneInstructions?.getPayeeBankBranch()?.getPayeeBankType().toString().equals("DOMESTIC")}">
					<td>
						${beneInstructions?.getPayeeBankBranch()?.bankName}
					</td>
				</g:if>
				<g:elseif
					test="${beneInstructions?.getPayeeBankBranch()?.getPayeeBankType().toString().equals("FOREIGN")}">
					<td>
						${beneInstructions?.getPayeeBankBranch()?.name1}
					</td>
				</g:elseif>
				<g:elseif
					test="${beneInstructions?.getPayeeBankBranch()?.getPayeeBankType() == ''}">
					<td>
						${g.message(code:'beneficiary.templates.accountdtl.bankcode.withinbank')}
					</td>
				</g:elseif>
				<g:elseif test="!${beneInstructions?.getPayeeBankBranch()}">
					<td>
						${g.message(code:'beneficiary.templates.accountdtl.bankcode.withinbank')}
					</td>
				</g:elseif>
				<!-- Display the Status -->
				<g:if
					test="${beneInstructions?.displayStatus?.equals('DRAFT') || beneInstructions?.displayStatus?.equals('SENT_BACK')}">
					<th>
						${beneInstructions?.displayStatus}
					</th>
					<td><a
						href="${createLink(controller:'beneficiary' ,action:'editBeneficiaryInstruction' , params:[processInstanceId:beneInstructions?.processInstanceId,beneficiaryId:beneInstructions?.beneficiary?.idVersion,recordStatus:beneInstructions?.displayStatus])}"
						class="edit_row ceeboxEdit"
						title="${g.message(code:'beneficiary.templates.personaldtl.editinstruction.tooltip.text')}"></a>
					</td>
				</g:if>
				<g:elseif
					test="${beneInstructions?.displayStatus?.equals('PFA') || beneInstructions?.displayStatus?.equals('REJECTED')}">
					<g:set var="status" value="${beneInstructions?.displayStatus}" />
					<th>
						${g.message(code: 'beneficiary.templates.accountdtl'+status)}
					</th>
					<td><a
						href="${createLink(controller:'beneficiary' ,action:'viewBeneficiaryInstruction' , params:[processInstanceId:beneInstructions?.processInstanceId,beneficiaryId:beneInstructions?.beneficiary?.idVersion,recordStatus:beneInstructions?.displayStatus])}"
						class="edit_row ceeboxEdit"
						title="${g.message(code:'beneficiary.templates.personaldtl.viewinstruction.tooltip.text')}"></a>
					</td>
				</g:elseif>
				<g:elseif
					test="${beneInstructions?.status && beneInstructions?.status?.code?.equals('ACT')}">
					<g:set var="status" value="${beneInstructions?.status?.code}" />
					<th>
						${g.message(code: 'beneficiary.templates.accountdtl'+status)}
					</th>
					<td><a
						href="${createLink(controller:'beneficiary' ,action:'editBeneficiaryInstruction' , params:[beneficiaryInstructionId:beneInstructions?.idVersion,beneficiaryId:beneInstructions?.beneficiary?.idVersion])}"
						class="edit_row ceeboxEdit"
						title="${g.message(code:'beneficiary.templates.personaldtl.editinstruction.tooltip.text')}"></a>
					</td>
				</g:elseif>
				<g:elseif
					test="${beneInstructions?.status && beneInstructions?.status?.code?.equals('INA')}">
					<g:set var="status" value="${beneInstructions?.status?.code}" />
					<th>
						${g.message(code: 'beneficiary.templates.accountdtl'+status)}
					</th>
					<td>&nbsp;</td>
				</g:elseif>
				<g:elseif
					test="${beneInstructions?.status && beneInstructions?.status?.code?.equals('PEND')}">
					<g:set var="status" value="${beneInstructions?.status?.code}" />
					<th>
						${g.message(code: 'beneficiary.templates.accountdtl'+status)}
					</th>
					<td>&nbsp;</td>
				</g:elseif>

				<td><g:if
						test="${beneInstructions?.status?.code?.toString().equals("ACT")}">
						<g:checkBox name="statusFlagE${beneInstructions?.id}"
							id="Enabled${beneInstructions?.id}" checked="true"
							class="inststatus"
							onclick="getConfirm('${beneInstructions?.beneficiary?.idVersion}','${beneInstructions?.idVersion}','INA','${beneInstructions?.transactionSubType?.serviceApplication?.service?.idVersion}');" />
						<label for="Enabled${beneInstructions?.id}">Enabled</label>
					</g:if> <g:elseif
						test="${beneInstructions?.status?.code?.toString().equals("INA")}">
						<g:checkBox name="statusFlagD${beneInstructions?.id}"
							id="Disabled${beneInstructions?.id}" class="inststatus"
							onclick="getConfirm('${beneInstructions?.beneficiary?.idVersion}','${beneInstructions?.idVersion}','ACT','${beneInstructions?.transactionSubType?.serviceApplication?.service?.idVersion}');" />
						<label for="Disabled${beneInstructions?.id}">Disabled</label>
					</g:elseif></td>

			</tr>
		</g:each>
	</tbody>
</table>
<script>
	
	$(".ceeboxEdit").ceebox();
	
	$('.inststatus').each(function(){
				if($(this).is(":checked")){						
						$(this).button({label: "Enabled", text: false,icons: {primary: "ui-icon-check"}})							
				}
				else {
					$(this).button({label: "Disabled",text: false,icons: {primary: "ui-icon-power"}})					
				}
	});	
	function onSearchSuccess(data,textStatus){
	//alert("onSearchSuccess:"+data);
	$(".ceeboxEdit").ceebox();
	$("#beneficiaryAccountDetails").dynamicfieldupdate();	
	
    }
	
	</script>

