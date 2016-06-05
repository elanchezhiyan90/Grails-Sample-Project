<vayana:popupMessages/>  
<br/>  
<div class="col-370">
<g:form name="serviceRequestConfirm">
<ul class="payment_dtls">
<li><p class="hdr">Request Confirmation</p></li>
<g:each in="${ResponseModel?.serviceRequestDatas}" var="dataList">  
     <li>
       <div class="dtl_wralp">
          <g:if test="${(dataList?.dataVarcharValue!=null)}"> 
				<div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${dataList?.serviceRequestMetaData?.dataLabelDescription}</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${dataList?.dataVarcharValue}</p>
                </div>
          </g:if>
       
          <g:if test="${(dataList?.dataNumberValue!=null)}"> 
				<div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${dataList?.serviceRequestMetaData?.dataLabelDescription}</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${dataList?.dataNumberValue}</p>
                </div>
          </g:if>
       
          <g:if test="${(dataList?.dataDateValue!=null)}"> 
				<div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${dataList?.serviceRequestMetaData?.dataLabelDescription}</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${dataList?.dataDateValue}</p>
                </div>
          </g:if>
       </div>               
</g:each>
 </li>
 </ul>	

   
    
	

    <div class="info">
    	<p><span></span><strong>Terms and Condition</strong></p>
    	<p>Terms and condition </p>
    </div>
    <br />
    <p><label><input type="checkbox" name="terms" id="terms"  required="required" data-errormessage="You have to agree the terms and condition to proceed"/> I agree the above terms and conditions</label></p>
	<div id="dynamicAuthContent">
					<vayana:securitysetting controller="security"
						action="fetchSecurityAdviceForAService" successAction="insertServicerequest"
						successController="serviceRequest" targetService="${ResponseModel?.tenantServiceCode}" formName="serviceRequestConfirm" displayAsPopUp="YES"/>
					<input type="button" id="cancelTxn" value="${message(code:'servicerequest.chequebook.cancel.button.text') }" name="cancelTxn" class="btn_next" >
<%--					<input type="button" value="${message(code:'servicerequest.chequebook.cancel.button.text') }" class="btn_next" id="canceltrans"  onclick="postUrl('chequeBookConfirm','/ib-retail-web/serviceRequest/chequebook','canvas');" />--%>
    </div>
    <br />
	<br />
    <br />
</g:form>

</div>
<script>
$("#cancelTxn").click(function()
{			
	<g:remoteFunction controller="serviceRequest" action="cancelTransactionToEmi" update="servicepanel" params="[tenantServiceCode:ResponseModel?.tenantServiceCode]" onSuccess="displayList(data,textStatus);"/>
});  
  
 function displayList(data,textStatus)
{
	$("#servicepanel").dynamicfieldupdate();
	
}    
</script>