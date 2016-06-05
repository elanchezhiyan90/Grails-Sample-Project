
<%@page import="com.vayana.bm.core.api.model.enums.DataTypeEnum"%>
<g:if test="${genericSRModel!=null}">
<g:hiddenField value="${genericSRModel?.customerName}" id="customerName" name="customerName"/>
<div id="innerMetaData" style="border:solid 1px #DDDDDD; display: inline-block;padding:5px 5px;width:50%;margin-top: 10px;">
<g:each in="${genericSRModel?.serviceRequestMetaDatas}" var="metaDataList">
					 <div class="fields">
					 <p>
					 
					 
						<g:if test="${DataTypeEnum.D.equals(metaDataList?.dataType)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<input type="date" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.dataLabel}" min="${new Date(new Date().getTime() + (1000 * 60 * 60 * 24)).toTimestamp()?.format('yyyy-MM-dd')}" required="${metaDataList?.nullable}"  />  						
  						</g:if>
  						
  						
  						<g:if test="${DataTypeEnum.V.equals(metaDataList?.dataType)  && !["ID_NUMBER","PERSON_NAME"].contains(metaDataList?.dataLabel)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textField name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" value="" data-text="${metaDataList?.dataLabelDescription}"  />  						 
  						</g:if>
  						
  						
  						
  						<g:if test="${DataTypeEnum.V.equals(metaDataList?.dataType)  && ("ID_NUMBER").equals(metaDataList?.dataLabel)}">
							<div id="id_numberDiv">
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textField id="id_number" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" value="" data-text="${metaDataList?.dataLabelDescription}" maxlength="25" pattern="[A-Za-z0-9/-]+"  />
      						</div>  						 
  						</g:if>
  						
  						<g:if test="${DataTypeEnum.V.equals(metaDataList?.dataType)  && ("PERSON_NAME").equals(metaDataList?.dataLabel)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textField name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" value="" data-text="${metaDataList?.dataLabelDescription}" maxlength="25" pattern="[A-Za-z ]+"  />  						 
  						</g:if>
  						
  						
  						<g:if test="${DataTypeEnum.L.equals(metaDataList?.dataType)}">
						<div id="${metaDataList?.id+"-"+metaDataList?.version}" class="dynamicDataLabels">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
							<vayana:radioGroup name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" type="${metaDataList?.tenantLookupType?.code}" domain="tenant"/>
						</div>
  						</g:if>
  						
  						
  						<%--<g:if test="${DataTypeEnum.L.equals(metaDataList?.dataType) && ("SELF_COL").equals(metaDataList?.dataLabel)}">
						<div id="${metaDataList?.id+"-"+metaDataList?.version}" class="dynamicDataLabels">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
							<vayana:radioGroupWithOnClick name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" type="${metaDataList?.tenantLookupType?.code}" domain="tenant" required="${metaDataList?.nullable}" onClickRequired="YES"/>
						</div>
  						</g:if>--%>
  						
  						
  						
  						<g:if test="${(DataTypeEnum.T.equals(metaDataList?.dataType)&&("ID_TYPE").equals(metaDataList?.dataLabel))}">
  							<div id="id_typeDiv">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>							
							<vayana:iblookupSelect name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="id_type" optionKey="code" messagePrefix="servicerequest.common"  type="${metaDataList?.tagLibParameter}" domain = "base" required="${metaDataList?.nullable}" />
							</div>
						</g:if>
						
						
						<g:if test="${(DataTypeEnum.T.equals(metaDataList?.dataType)&&("BRN_NAME").equals(metaDataList?.dataLabel))}">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>							
							<vayana:select name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" optvalue="description" type="${metaDataList?.tagLibParameter}" findBy="ALL" domain="ib" required="${metaDataList?.nullable}" optionKey="description" />
						</g:if>
						
						
						<g:if test="${DataTypeEnum.N.equals(metaDataList?.dataType)&& !(metaDataList?.dataLabelDescription.equals("Amount"))}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textField  name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" />  						 
  					</g:if> 
  					</p>								
</div>	
</g:each>	
</div>	
</g:if>
<script>      
     $(function () {    
     	$("#innerMetaData,.fields").dynamicfieldupdate();
       
        $('.dynamicDataLabels').each(function() {
     	 var forButtonsets = $(this).attr('id');     
      	$("#"+forButtonsets).buttonset(); 
	});	 
	
	$('input').each(function(){
					var formFieldId=$(this).attr('id');
					var nullable = $("#"+formFieldId).data('nullable');	
					if(nullable=='N')
					{	
						$("#"+formFieldId).attr("required",true);
						 $("#innerMetaData").dynamicfieldupdate();
					}
	});	
});
$(document).ready(function() {

$("#innerMetaData").dynamicfieldupdate();
    $('input:radio').click(function() {
       var formFieldId=$(this).attr('id');      
      $('input:text').each(function(){
      if(formFieldId=='YES')
      {
      	  var formField=$(this).attr('id');
	      var textLabel=$("#"+formField).data('text')
	      if(textLabel=='Person Name'){
	       	$("#"+formField).attr("value",$("#customerName").val());
	       }
      }else if(formFieldId=='NO'){
      		var formField=$(this).attr('id');
      		$("#"+formField).attr("value",'');
      }   
	      });
    });
});


</script>