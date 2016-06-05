<ul class="bene-mnu">
<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'SALARY_PAYMENTS',userActionLabel:'ADD')}" > 
<li>	
	<vayana:postablelink id="salaryPayment" controller="bulkPayment" action="smeBulkPayment" urlParams="[tenantServiceCode:'SALARY_PAYMENT']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.body.smebulkpay.salarypay.title')}"><g:message code="home.templates.body.smebulkpay.salarypay.title" /></vayana:postablelink>
</li>
</vayana:fap>
<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'VENDOR_PAYMENTS',userActionLabel:'ADD')}" > 
<li>	
	<vayana:postablelink  id="vendorPayment" controller="bulkPayment" action="smeBulkPayment" urlParams="[tenantServiceCode:'VENDOR_PAYMENT']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.body.smebulkpay.vendorpay.title')}"><g:message code="home.templates.body.smebulkpay.vendorpay.title" /></vayana:postablelink>
</li>
</vayana:fap>
</ul>

 
 
 
