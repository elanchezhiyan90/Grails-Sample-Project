<div class="fields">
		<p>
 				<label for="bene_name">${message(code:'dateline.addreminder.beneficiaryname.label') }</label>
				<vayana:beneficiarySelect name="beneficiary" Id="beneficiary_type" required="required" data-errormessage="${g.message(code:"dateline.addreminder.beneficiaryname.error.message")}"
				noSelection="['':'select']"
				onchange="${ remoteFunction( 
											 							controller :'reminder',
																	    action:'getBeneficiaryInstructions', 														  						
																	    update:'divPayeeInstruction',								 
																	  	params:'\'selectedBeneId=\'+this.value',onSuccess:'onPayeeInstructionSuccess(data,textStatus);'														
																	   						   )}"
				/>
		</p>						
</div>