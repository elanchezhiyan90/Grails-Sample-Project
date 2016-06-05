<g:hiddenField name="securityHolderSize" value="${params.securityHolderSize}" />
<div id="updateAccountTableDiv">

	<table border="0" cellpadding="0px" cellspacing="0px" class="grid">
		<g:each var="billerInstruction" in="${BillerDetailsModel?.billerInstructions}">
			<tr></tr>			
			<tr>
				<td width="20%"><span>${billerInstruction.shortName}</span>	</td>
				
				<g:each var="billerData" in="${billerInstruction?.billerData}">
					<td width="20%">
						<span>${billerData?.getBillerDataValue()}</span>
					</td>
				</g:each>				
					
				<td width="10%">				
					<g:if test="${billerInstruction?.status?.code?.toString().equals("ACT")}">
					<g:checkBox name="statusFlagE${billerInstruction?.id}" id="Enabled${billerInstruction?.id}" checked="true" class="inststatus"
							onclick="getConfirm('${billerInstruction?.biller?.id}','${billerInstruction?.billerService?.id}','${billerInstruction?.id}','INACT');" />
					<label for="Enabled${billerInstruction?.id}">Enabled</label>	
					<a href="${createLink(controller:'biller' , 
							action:'getBillerInstructiondetails' , params:[billerInstructionId:billerInstruction?.id])}"
						class="edit_row" title="${message(code:'biller.templates.details.billerinstructionstable.edit.tooltip.text') } ">${message(code:'biller.templates.details.billerinstructionstable.edit.text') }</a>
					
				  	</g:if> 
				  	<g:elseif test="${billerInstruction?.status?.code?.toString().equals("INA")}">
					<g:checkBox name="statusFlagD${billerInstruction?.id}" id="Disabled${billerInstruction?.id}" class="inststatus"
						onclick="getConfirmAct('${billerInstruction?.biller?.id}','${billerInstruction?.billerService?.id}','${billerInstruction?.id}','ACT');" />
					<label for="Disabled${billerInstruction?.id}">Disabled</label>
				 	</g:elseif>
					
				</td>				
			</tr>
		</g:each>
	</table>
	
	<div id="dialog-confirm" title="${message(code:'biller.templates.details.billerinstructionstable.billerinstruction.title') }" style="display: none;">
 		 <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>${message(code:'biller.templates.details.billerinstructionstable.disable.text') }</p>
	</div>
	
	<div id="dialog-confirm-act" title="${message(code:'biller.templates.details.billerinstructionstable.billerinstruction.title') }" style="display: none;">
 		 <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span> ${message(code:'biller.templates.details.billerinstructionstable.enable.text') }</p>
	</div>
	
</div>
<script>

$(function(){
$(".edit_row").ceebox();
$('.inststatus').each(function(){
			
				if($(this).is(":checked")){
						$(this).button({text: false,icons: {primary: "ui-icon-check"}})			
				}
				else {
					$(this).button({text: false,icons: {primary: "ui-icon-power"}})
				}
	});
});

</script>