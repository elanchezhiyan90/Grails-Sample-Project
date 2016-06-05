<%--
	<div class="fields">
		<p>
 				<label for="date">Birth Date</label>
				<input type="date" name="birthDate" id="birthDate" required />				
		</p>						
	</div>						
--%>

<div class="fields">
		<p>
 				<label for="bene_name">${message(code:'dateline.addreminder.beneficiaryname.label') }</label>
				<vayana:beneficiarySelect name="beneficiaryId" Id="beneficiaryId" required="required" data-errormessage="${g.message(code:"dateline.addreminder.beneficiaryname.error.message")}"/>
		</p>						
</div>
<div class="fields">
		<p>
 			<label for="description">${message(code:'dateline.addreminder.description.label') }</label>
			<textarea rows="1" cols="30" title="Enter Remarks" id="description" name="description" required="required" data-errormessage="${g.message(code:"dateline.addreminder.description.error.message")}"></textarea>
		</p>						
</div>