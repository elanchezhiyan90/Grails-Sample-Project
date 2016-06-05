<div class="col-450">
		<ul class="payment_dtls">
		<li><p class="hdr">Request Confirmation</p></li>
		
		<g:if test="${datelineRef}">
			<g:hiddenField name="datelineReferenceId" value="${datelineRef}" />
	</g:if>
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
	                   
	                    <p> <vayana:formatDate date="${dataList?.dataDateValue}" /></p>                  
	                </div>
	          </g:if>
	       </div>               
	</li>
	</g:each>
	<li>
		<div class="dtl_wralp">
			<div class="lft_dtl">
			<p>&nbsp;</p>
			<p >Initiator</p>
			</div>
			<div class="rht_dtl">
				<p>&nbsp;</p>
				<p >${ResponseModel?.serviceRequestInstruction?.createdBy?.userLogin}</p>
			</div>
		</div>
		
	</li>
	 </ul>
</div>	 	
	  <br/>
	  <br/>  
	  <g:hiddenField name="srvCode" id="srvCode"	value="${ResponseModel?.tenantServiceCode}" />
		<div class="buttons" id="btns_paynow">
				<g:submitToRemote name="approve" value="Approve" id="approve" class="btn_next"
						action="approvePreConfirm" controller="serviceRequest"
						update="dynamicContent"
						before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
						onSuccess="onPreAppSuccess(data,textStatus)" />
				
				<g:submitToRemote name="reject" value="Reject" id="reject"
						action="rejectPreConfirm" controller="serviceRequest" class="btn_next"
						update="dynamicContent"
						before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
						onSuccess="onPreRejSuccess(data,textStatus)" class="btn_next" />
					</div>
					<div id="dynamicContent" class="flds-block"></div>
				    <br />
					<br />
				    <br />
<script>				  
		
	function onPreAppSuccess(data,textStatus){
	$("#approve,#reject").attr('disabled','disabled');
	$("#approve").addClass("btn_show");
	$("#dynamicContent").css("display","block");
	$("#dynamicContent").dynamicfieldupdate();
	$("#tranXConfirm").on("click",function(){
		$("#reject").hide();
	
	});
	
	$("#cancelRemarks").on("click",function(){
	$("#reject").show();
	
	});
	
}
function onPreRejSuccess(data,textStatus){
	
	$("#approve,#reject").attr('disabled','disabled');
	$("#reject").addClass("btn_show");
	$("#dynamicContent").css("display","block");
	$("#dynamicContent").dynamicfieldupdate();
	$("#tranXConfirm").on("click",function(){
		$("#approve").hide();
	
	});
	
	$("#cancelRemarks").on("click",function(){
	$("#approve").show();
	
	});
	
	
}

function checkFormValidity()
{
	if(!$('form').checkValidity())
	{
		return true;
	}else
	{
		return false;
	}

}

	
</script>