<div class="fields">
		<p>
 				<label for="biller_name">${message(code:'dateline.addreminder.billerinstructionnickname.label') }</label>
				<vayana:billerInstructionSelect name="payeeInstructionId" billerId="${billerResponseModel}" required="required" 
				noSelection="['':'select']" data-errormessage="${g.message(code:"dateline.addreminder.billerinstructionnickname.error.message")}"/>
		</p>						
</div>
<div class="fields">
		<p>
 				<label for="paymentAmount">${message(code:'dateline.addreminder.amount.label') }</label>
				<vayana:tenantOpsCurrencySelect name="currencyId" required="required" class="cur" id="currencyId" data-errormessage="${g.message(code:"dateline.addreminder.currency.error.message")}"/>
				<input type="number" step="any" name="amount"
					id="amount" class="s_amt" min="1" required="required" data-errormessage="${g.message(code:"dateline.addreminder.amount.error.message")}"/>
		</p>						
</div> 
<div class="fields">
		<p>
 			<label for="description">${message(code:'dateline.addreminder.description.label') }</label>
			<textarea rows="1" cols="30" title="Enter Remarks" id="description" name="description" data-errormessage="${g.message(code:"dateline.addreminder.description.error.message")}"></textarea>
		</p>						
</div>
