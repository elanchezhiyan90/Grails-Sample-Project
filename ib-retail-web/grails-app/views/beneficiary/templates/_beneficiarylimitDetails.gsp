<!--------------Limit details Starts here--------------------->
<g:form name="beneLimits">
<vayana:messages/>
<div id="beneficiaryLimits" class="bene_detail">
         <g:hiddenField name="beneIdVal" value="${params?.beneIdValue}"/>
		 <g:hiddenField name="beneficiaryLimitId" value="${limitDefinitionDetail?.idVersion}"/>	
  <%--<div class="mandi-note">
		<span class="mandi"></span>
		<p>Mandatory fields</p>
  </div>
  
  --%><div class="fields">
				<p>
					 <label for="limitCurrencyId"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.limitcurrency.label"/></label>
					  <vayana:currencySelect name="currencyId" id="currencyId" type="CURRENCIES" findBy="ALL" required="required" 
					  data-errormessage="${g.message(code:"beneficiary.templates.instructions.beneficiaryinstructionlimit.limitcurrency.label.error.message")}" 
					  value="${limitDefinitionDetail?.limitDefinition?.currency?.idVersion}"/>					 
	             </p>	             
   </div>
	
	<div class="fields">
          <p>
            <label for="globalMaxAmountParam"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.transactionlimit.label"/></label>
             <g:field class="s_amt" type="number" name="globalMaxAmountParam" id="globalMaxAmountParam" min="0"  value="${limitDefinitionDetail?.globalMaxAmount}"
           			title="${g.message(code:'beneficiary.templates.instructions.beneficiaryinstructionlimit.transactionlimit.tooltip.text')}"	
					/>
          </p>                                  
     </div>
        
   	 <div class="fields">
          <p>
            <label for="globalMonthlyMaxAmountParam"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.monthlylimit.label"/></label>
            <g:field class="s_amt" type="number" name="globalMonthlyMaxAmountParam" id="globalMonthlyMaxAmountParam" min="0" 
            value="${limitDefinitionDetail?.globalMonthlyMaxAmount}"
           			title="${g.message(code:'beneficiary.templates.instructions.beneficiaryinstructionlimit.monthlylimit.tooltip.text')}"	
					/>
           
          </p>                                  
     </div>
        
		<div class="fields">
          <p>
            <label for="globalDailyMaxAmountParam"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.dailylimit.label"/></label>
            <g:field class="s_amt" type="number" name="globalDailyMaxAmountParam" id="globalDailyMaxAmountParam" min="0" 
            value="${limitDefinitionDetail?.globalDailyMaxAmount}"
           			title="${g.message(code:'beneficiary.templates.instructions.beneficiaryinstructionlimit.dailylimit.tooltip.text')}"	
					/>
          </p>                                  
        </div>
       	
       	<div class="fields">
            <p>
              <label for="effectiveFromDate"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.fromdate.label"/></label>               
               	<vayana:vayanaDate name="effectiveFromDate" id="effectiveFromDate" required=""   
               	value="${limitDefinitionDetail?.effectiveFromDate?: ''}"
               	/>
               	
            </p>
   		</div>
   		
    	<div class="fields">
            <p>
              <label for="effectiveToDate"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.todate.label"/></label>   		         
   		      <vayana:vayanaDate name="effectiveToDate" id="effectiveToDate" required=""
   		      value="${limitDefinitionDetail?.effectiveToDate?: ''}" 
              />
            </p>
    	</div>



 <div class="buttons">		
  <g:if test="${limitDefinitionDetail?.idVersion}">
	    <vayana:submitToRemote controller="beneficiary" action="updateBeneficiaryLimit" name="update" id="update" 
		                       update="[success:'',failure:'messagesDiv']" 
		                       before="if (checkFormValidity()) {return false;}"
		                        onSuccess="" onFailure="" value="Update"  />
  </g:if>
  
  <g:else>
		<vayana:submitToRemote controller="beneficiary" action="insertBeneficiaryLimit" name="save" id="save" 
		                       update="[success:'',failure:'messagesDiv']"  
		                       before="if (checkFormValidity()) {return false;}"
		                       onSuccess="" onFailure="" value="Save"  />
  </g:else>
 </div>
 </div>
</g:form>
<!--------------Limit details Endss here--------------------->

<script>     

$("#beneficiaryLimits").dynamicfieldupdate();
if($("#hidBeneficiaryIdversion").length)
{
	//alert($("#hidBeneficiaryIdversion").val());
	var beneId = $("#hidBeneficiaryIdversion").val();
	$("#beneIdVal").val(beneId);
}

function checkFormValidity(){

	if(!$("#beneLimits").checkValidity()){ 
	      return true;   
	}else{
		   return false;
	}
}

</script>