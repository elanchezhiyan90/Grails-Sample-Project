
<div id="updateAccountTableDiv">
	<table border="0" cellpadding="0px" cellspacing="0px" class="grid">

		<g:each in="${beneficiary?.beneficiaryInstruction}"
			var="beneInstructions">

			<tr>

				<td width="20%"><span> ${beneInstructions.shortName}
				</span></td>
				<td width="20%"><span> ${beneInstructions.transactionSubType?.service?.code}
				</span> ${beneInstructions.accountType.description}</td>
				<td width="25%"><span> ${beneInstructions.accountNumber}
				</span> ${beneInstructions.currency.code}</td>
				<td width="25%"><span> <g:if
							test="${beneInstructions.getPayeeBankBranch()?.getPayeeBankType().toString().equals("DOMESTIC")}">
							${beneInstructions.getPayeeBankBranch()?.bankName}
						</g:if> <g:if
							test="${beneInstructions.getPayeeBankBranch()?.getPayeeBankType().toString().equals("FOREIGN")}">
							${beneInstructions.getPayeeBankBranch()?.name1}
						</g:if>
				</span></td>
				<td width="5%"><a
					href="${createLink(controller:'beneficiary' , 
						action:'beneficiaryInstruction' , params:[beneficiaryInstructionId:beneInstructions?.idVersion,instructionTemplate:beneInstructions.transactionSubType?.service?.code])}"
					class="edit_row ceebox" title="Edit Instruction">edit</a></td>
				<%-- <td width="5%"><g:if
						test="${beneInstructions?.getStatus().code.toString().equals("ACT")}">
						<g:checkBox name="statusFlagE${beneInstructions?.id}"
							id="Enabled${beneInstructions?.id}" checked="true"
							class="inststatus"
							onclick="getConfirm();setBeneInstructionStatus('${beneInstructions?.idVersion}','0');${remoteFunction(controller:'beneficiary',update:'',action:'updateBeneInstructionStatus',params:'\'beneInstructionId=\'+getBeneInstructionId()+\'&status=\'+getBeneInstructionStatus()',onSuccess:'updateIcon(data,textStatus);')}" />
						<label for="Enabled${beneInstructions?.id}">Enabled</label>
					</g:if> <g:else>
						<g:checkBox name="statusFlagD${beneInstructions?.id}"
							id="Disabled${beneInstructions?.id}" class="inststatus"
							onclick="getConfirm();setBeneInstructionStatus('${beneInstructions?.idVersion}','1');${remoteFunction(controller:'beneficiary',update:'',action:'updateBeneInstructionStatus',params:'\'beneInstructionId=\'+getBeneInstructionId()+\'&status=\'+getBeneInstructionStatus()',onSuccess:'updateIcon(data,textStatus);')}" />
						<label for="Disabled${beneInstructions?.id}">Disabled</label>
					</g:else></td>--%>



			</tr>
		</g:each>
	</table>

</div>