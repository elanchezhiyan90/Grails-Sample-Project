<g:form name="beneficiaryInstructionConfirm" id="beneficiaryInstructionConfirm">
<vayana:popupMessages/> 
<div class="col-fifty">

<ul class="payment_dtls">
    	 <li><p class="hdr">Account details</p></li>
        <li>
        	<div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Beneficiary Nickname</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.benenickname}</p>  
                </div>
            </div>

<g:if test="${postProcessModel?.accounttypeDisplay}">
            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Beneficiary Account Type</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.accounttypeDisplay}</p>
                </div>
            </div>
</g:if>
<g:if test="${postProcessModel?.accountNumber}">
			<div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Account Number</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.accountNumber}</p>
                </div>
            </div>
</g:if>		
<g:if test="${postProcessModel?.transferCurrency}">		

            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Account Currency</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.transferCurrency}</p>
                </div>
            </div>

</g:if>	
<g:if test="${postProcessModel?.iban}">		
	<div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>MMID</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.iban}</p>
                </div>
     </div>
</g:if>
<g:if test="${postProcessModel?.mobileNumber}">		

            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Mobile Number</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.mobileNumber}</p>
                </div>
            </div>

</g:if>	

<g:if test="${postProcessModel?.aadharCardNumber}">		

            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Aadhar Card Number</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.aadharCardNumber}</p>
                </div>
            </div>

</g:if>	
 <g:if test="${postProcessModel?.bankcode}">	 
			<div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Bank code</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.bankcode}</p>
                </div>
            </div>
  </g:if>
  <g:if test="${postProcessModel?.bankname}">	          
            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Bank Name</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.bankname}</p>
                </div>
            </div>
  </g:if>  
  <g:if test="${postProcessModel?.branchname}">	
            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Branch Name</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.branchname}</p>
                </div>
            </div>
	</g:if>
	<g:if test="${postProcessModel?.bankaddress}">				
			  <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Bank Address</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.bankaddress}</p>
                </div>
            </div>
			
	</g:if>
        </li>

    </ul>
</div>
<g:if test="${postProcessModel?.limitCurrency}">	
<div class="col-fifty">

<ul class="payment_dtls">
    	 <li><p class="hdr">Account Limit</p></li>
        <li>
        	<div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Limit Currency</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.limitCurrency}</p>
                </div>
            </div>



            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Transaction Limit</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.maxlimit}</p>
                </div>
            </div>

			<div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Monthly Limit</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.monthlylimit}</p>
                </div>
            </div>
			
		

            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Daily Limit</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.dailylimit}</p>
                </div>
            </div>

			
			<div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>From Date</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.fromdate}</p>
                </div>
            </div>
            
            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>To Date </p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.todate}</p>
                </div>
            </div>
        </li>
    </ul>
</div>
</g:if>
<div class="fields">
<p></p>
</div>

<%--<div class="info">--%>
<%--    	<p><span></span><strong>Terms and Condition</strong></p>--%>
<%--    	<p>Terms and Conditions</p>--%>
<%--    </div>--%>
<%--    --%>
<%--    --%>
<%----%>
<%--<div class="fields">--%>
<%--    <p><label><input type="checkbox" name="terms" id="terms"  required="required" data-errormessage="You have to agree the terms and condition to proceed"/> I agree the above terms and conditions</label></p><br/>--%>
<%----%>
<%--</div>--%>
<%--  --%>

<div id="dynamicAuthContent" class="fields">
<g:if test="${postProcessModel?.beneficiaryInstructionId}">
      <vayana:securitysetting controller="security" action="fetchSecurityAdviceForAService" 
	    successAction="updateBeneficiaryInstruction" successController="beneficiary" targetService="BENE_INS"
	    formName="beneficiaryInstructionConfirm" displayAsPopUp="YES"/>
				
</g:if>
<g:else>
<vayana:securitysetting controller="security" action="fetchSecurityAdviceForAService" 
		successAction="insertBeneficiaryInstruction" successController="beneficiary" 
		targetService="BENE_INS" formName="beneficiaryInstructionConfirm" displayAsPopUp="YES"/>
</g:else>				
 <input type="button" value="Cancel" class="btn_next" id="canceltrans"  onclick="closeSaveDialogue()" />	
</div>
</g:form>
<p>&nbsp;</p>
<p>&nbsp;</p>
<script>

function onAuthSuccess(data,textStatus)
{	
	var securityHolderSize = $(data).filter("#securityHolderSize").val();
	if(securityHolderSize!='undefined' && securityHolderSize =='true')
	{
		
		closeSaveDialogue(data,textStatus);		
	}
}

function closeSaveDialogue(data,textStatus) {
	
	$.fn.ceebox.closebox();
	$("#beneficiaryAccountDetails").html(data);
	$("#beneficiaryAccountDetails").dynamicfieldupdate();
	 
}
</script>