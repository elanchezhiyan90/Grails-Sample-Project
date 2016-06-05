
<div class="fields">
		<p>
 				<label for="biller_name">${message(code:'dateline.addreminder.billername.label') }</label>
				<vayana:billerSelect name="biller" id="biller_name" required="required" data-errormessage="${g.message(code:"dateline.addreminder.billername.error.message")}"
				noSelection="['':'select']"
				onchange="${ remoteFunction( 
											 							controller :'reminder',
																	    action:'getBillerInstructions', 														  						
																	    update:'divPayeeInstruction',								 
																	  	params:'\'selectedBillerId=\'+this.value',onSuccess:'onPayeeInstructionSuccess(data,textStatus);', onFailure: 'onPayeeInstructionFailure();'														
																	   						   )}"
				/>
		</p>						
</div>
