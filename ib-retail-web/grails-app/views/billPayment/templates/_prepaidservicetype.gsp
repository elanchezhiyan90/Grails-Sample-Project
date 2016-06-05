<g:if test="${billServiceModel?.billerInstruction?.biller?.shortName?.toString().equals("Batelco")}">
	<vayana:tenantLookupSelect class="mdm_txt" name="paymentAmount" type="BATELCO_PREPAID_TOPUP" id="paymentAmount" optionKey="description" optionValue="description" required="required" data-errormessage="${message(code:'billpayment.templates.billpayment.prepaidamount.error.message')}"></vayana:tenantLookupSelect>
</g:if>
<g:elseif test="${billServiceModel?.billerInstruction?.biller?.shortName?.toString().equals("Zain")}">
	<vayana:tenantLookupSelect class="mdm_txt" name="paymentAmount" type="ZAIN_PREPAID_TOPUP" id="paymentAmount" optionKey="description" optionValue="description" required="required" data-errormessage="${message(code:'billpayment.templates.billpayment.prepaidamount.error.message')}"></vayana:tenantLookupSelect>
</g:elseif>
<g:hiddenField name="billerServiceType" id="billerServiceType" value="${billServiceModel?.billerInstruction?.billerService?.code}"/>

