<h2>
${genericSRModel?.serviceRequestMetaDatas?.tenantService?.serviceApplication?.service?.description.get(0)}
</h2>
<%@page import="com.vayana.ib.bm.core.api.model.enums.ElementTypeEnum"%>
<%@page import="com.vayana.bm.core.api.model.enums.DataTypeEnum"%>

<vayana:popupMessages/> 
<div id="servicepanel">
<g:form name="transfertoemiRequestForm">
<g:hiddenField name="tenantServiceCode" id="tenantServiceCode" value="${genericSRModel?.tenantServiceCode}"></g:hiddenField>
<g:each in="${genericSRModel?.serviceRequestMetaDatas}" var="metaDataList">
<g:hiddenField name="buttonEvent"/>
<div class="fields" id="formMainContent">
					<g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("CARD_NO"))}">	
						<p>
							<label for="fromAccount">${message(code:'servicerequest.chequebook.accountnumber.label') }</label>
								<vayana:fromAccountSelect id="${metaDataList?.id+"-"+metaDataList?.version}"
									name="${metaDataList?.id+"-"+metaDataList?.version}"
									poptype="${metaDataList?.tagLibParameter}" required="required" optionKey="accountNumber"
									data-errormessage="${message(code:'servicerequest.chequebook.selectaccount.error.message') }" />
<%--															<vayana:tagLibParser tagLibId="asdsad" tagLibParameter="" tagLibName="${metaDataList?.tagLibName}"/>			--%>
						</p>	
					</g:if>	
					
					<g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("TRANS_CURRENCY") || (metaDataList?.dataLabel.equals("EMI_CURRENCY") ))}">		
						<p>
							<label for="currencyId">${message(code:'servicerequest.managerscheque.currency.label') }</label>	
							<vayana:tenantOpsCurrencySelect name="${metaDataList?.id+"-"+metaDataList?.version}" id="${metaDataList?.id+"-"+metaDataList?.version}"
								required="${metaDataList?.nullable}" class="cur"   optionKey="code"
								data-errormessage="${message(code:'servicerequest.managerscheque.currency.error.message') }" />							
						</p>	
					</g:if>	
					
					<g:if test="${(DataTypeEnum.L.equals(metaDataList?.dataType) && (ElementTypeEnum.RD.equals(metaDataList?.elementTypeEnum)) && ("YESNO").equals(metaDataList?.tenantLookupType?.code))}">
						<div id="${metaDataList?.id+"-"+metaDataList?.version}" class="dataLabels">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>							
							<vayana:radioBranchPickUp name="${metaDataList?.id+"-"+metaDataList?.version}" id="${metaDataList?.id+"-"+metaDataList?.version}" type="${metaDataList?.tenantLookupType?.id}" domain="tenant" required="${metaDataList?.nullable}"/>
							<g:hiddenField name="branchMetaDataId" value="${metaDataList?.id}"/>
						</div>
					</g:if>
					<g:if test="${(DataTypeEnum.L.equals(metaDataList?.dataType) && (ElementTypeEnum.RD.equals(metaDataList?.elementTypeEnum)) &&(!("YESNO").equals(metaDataList?.tenantLookupType?.code)))}">
						<div id="${metaDataList?.id+"-"+metaDataList?.version}" class="dataLabels">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
							<vayana:radioGroup name="${metaDataList?.id+"-"+metaDataList?.version}" id="${metaDataList?.id+"-"+metaDataList?.version}" type="${metaDataList?.tenantLookupType?.id}"  domain="tenant" required="${metaDataList?.nullable}"/>
						</div>
					</g:if>
					<g:if test="${DataTypeEnum.D.equals(metaDataList?.dataType)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<input type="date" name="${metaDataList?.id+"-"+metaDataList?.version}" id="${metaDataList?.dataLabel}" min="${new Date().clearTime().toTimestamp()}" required="${metaDataList?.nullable}"/>  						
  					</g:if>
  					<g:if test="${DataTypeEnum.V.equals(metaDataList?.dataType)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textField name="${metaDataList?.id+"-"+metaDataList?.version}" data-nullable="${metaDataList?.nullable}" />  						 
  					</g:if>
  					<g:if test="${DataTypeEnum.N.equals(metaDataList?.dataType)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:field type="number" name="${metaDataList?.id+"-"+metaDataList?.version}" data-nullable="${metaDataList?.nullable}" />  						 
  					</g:if>  
  					
  					<g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType)&&(metaDataList?.tenantLookupType!=null)}">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>							
							<vayana:tenantLookupSelect name="${metaDataList?.id+"-"+metaDataList?.version}" id="${metaDataList?.id+"-"+metaDataList?.version}" optionKey="description" type="${metaDataList?.tenantLookupType?.code}" domain = "tenant" required="${metaDataList?.nullable}" />
					</g:if>
						
				</div>
				
</g:each>
<div id="dynamicBranchContent">
</div>
<br>
<vayana:serviceValidate name="Continue" value="Continue" buttonEvent="Continue"  controller="serviceRequest"  action="transferToEmiConfirm" secondaryDiv="servicepanel" formName="transfertoemiRequestForm" />
<%--<div id="dynamicAuthContent">--%>
<%--					<vayana:securitysetting controller="security"--%>
<%--						action="fetchSecurityAdviceForAService" successAction="transactiontoEmirequest"--%>
<%--						successController="serviceRequest" targetService="CNVTRNEMI" formName="transfertoemiRequestForm"/>--%>
<%--					<input type="button" name=""--%>
<%--						value="${message(code:'servicerequest.chequebook.cancel.button.text') }"--%>
<%--						id="cancel" name="cancel" class="btn_next" />--%>
<%--</div>--%>
</g:form>
<script>      
     $(function(){
      $("#transfertoemiRequestForm").dynamicfieldupdate();
       
    $('.dataLabels').each(function() {
      var forButtonset = $(this).attr('id');      
      $("#"+forButtonset).buttonset();    	  
	});
	
	$('input').each(function(){
	var formFieldId=$(this).attr('id');
	var nullable = $("#"+formFieldId).data('nullable');	
		if(nullable=='N')
		{	
			$("#"+formFieldId).attr("required",true);
			 $("#formMainContent").dynamicfieldupdate();
		}
	});
  });
    
    function pickUpSuccess(data,textStatus)
    {
    	 $("#dynamicBranchContent").dynamicfieldupdate();
    }
    
    function pickFailure(status)
    {
    	
    
    }

    function getBranchMetaData()
    {
		return $("#branchMetaDataId").val();    
    }
   	
 </script>
</div>

