<g:if test="${AutoPayModel.equals("Y")}">
<div id="autopaydata" style="border:solid 1px #DDDDDD; display: inline-block;padding:5px 5px;">

<div class="fields">
			<p>
				<label for="from_account" >${message(code:'biller.templates.addbiller.autopayfields.accounttodebit.label') }</label>
				<vayana:fromAccountSelect id="accountId" name="accountId" type="OA"	poptype="CASACC" data-placeholder="${message(code:'biller.templates.addbiller.autopayfields.fromaccountselect.placeholder') }"	 									 
			  	noSelection ="${['Select Account':'Select Account']}"
			  	data-errormessage="${message(code:'biller.templates.addbiller.autopayfields.fromaccountselect.error.message') }"
			   			required="required" />
				<br><span class="selected_des">${message(code:'biller.templates.addbiller.autopayfields.accounttodebit.selection.message') }&nbsp;</span>
			</p>
</div>	

<div class="fields" id="divAutoPay">
	<p>
 		<label for="autopay">${message(code:'biller.templates.addbiller.autopayfields.amounttodebit.label') }</label>
 		<g:radio name="autoPay" id="autopayF" value="F" required="required" /><label for="autopayF" >${message(code:'biller.templates.addbiller.autopayfields.amounttodebit.fullamount.label') }</label>
		<g:radio name="autoPay" id="autopayM" value="M" required="required" /><label for="autopayM" >${message(code:'biller.templates.addbiller.autopayfields.amounttodebit.minimumamount.label') }</label>					     								
	</p>  						
</div>

<div class="fields" id="currency">
	<p>
		<label for="amount">${message(code:'biller.templates.addbiller.addbillerinstruction.currency&maxamount.label')}</label>
			<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
			class="cur" required="required"
			data-errormessage="${g.message(code:"payment.templates.ownaccount.transfer.currencyamount.error.message") }" />
			
			<input type="number" step="any" name="maximumAmount"
			id="maximumAmount" class="s_amt" min="1" required="required"
			data-errormessage="${message(code:'billpayment.templates.billpayment.amount.error.message')}" />
	</p>
	<div class="updater">
		<span><span class="cur"></span></span>
	</div>

</div>
		
<div class="fields">
              <p>
                <label for="from_date">${message(code:'biller.templates.addbiller.autopayfields.fromdate.label') }</label>
                <input type="date" name="effectiveFromDateparam" id="effectiveFromDateparam"  class="effectiveFromDate" min="${new Date().toTimestamp()}"   data-errormessage="${message(code:'biller.templates.addbiller.autopayfields.fromdate.error.message') }" required="required" />
              </p>
     		</div>
      		<div class="fields">
              <p>
                <label for="to_date">${message(code:'biller.templates.addbiller.autopayfields.todate.label') }</label>
                <input type="date" name="effectiveToDateparam" id="effectiveToDateparam"  class="effectiveToDate" data-dependent-validation='{"from": "effectiveFromDateparam", "prop": "min"}'   data-errormessage="${message(code:'biller.templates.addbiller.autopayfields.todate.error.message') }" required="required" />
              </p>
</div>
</div>
</g:if>


