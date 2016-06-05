<div id="divAutoPay">
<p>
	<label for="autopay">${message(code:'payment.templates.loan.loanpayment.closureinstructions.label') }</label>
	<g:radio name="closureIns" id="closureInsT" value="RT" required="required" /><label for="closureInsT" >${message(code:'payment.templates.loan.loanpayment.retaintenure.label') }</label>
	<g:radio name="closureIns" id="closureInsE" value="RE" required="required" /><label for="closureInsE" >${message(code:'payment.templates.loan.loanpayment.retainemi.label') }</label>					     								
</p>
</div>
<script>
$(function(){
	$("#divAutoPay" ).buttonset();	
});
</script>