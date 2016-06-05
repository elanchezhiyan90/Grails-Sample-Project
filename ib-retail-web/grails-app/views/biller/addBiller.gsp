<html>
<head>
<meta name="layout" content="applayout"/>
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
<%@page import="com.vayana.bm.core.api.model.enums.FindByEnum"%>
<%@page import="com.vayana.bm.core.api.model.enums.CommonEntityEnum"%>
   
<section class="body-scroll">
	    <h2>${message(code:'biller.addbiller.h2.text') }</h2>	    
	    <vayana:messages/>
	    <g:form name="frmBiller" id="frmBiller">	
		<div class="servicepanel" id="servicepanel">
			<g:render template="/biller/templates/addbiller/addBillerInstruction" />  	
		</div>
		</g:form>
     <br/>
     <br/>
     <br/>
</section>
 <g:javascript>      
      
      $(document).ready(function () {
      
      $("#divAutoPayOption" ).buttonset();
  
		
	$('input:radio[name="autoPayOption"]').change(function(){         	
        if ($(this).is(':checked') && $(this).val() == 'N' ) {
           $("#autopaydivdata").empty();  
           $("#divSubmitContent").hide(); 
           $("#divSavePayContent").show();                 
        }else{
        	$("#divSavePayContent").hide(); 
        	$("#divSubmitContent").show(); 
        }        
    });	
      });
	      
     
	function onBillerCategorySuccess(data,textStatus){									
	 	$("#divParentBillerCompany").dynamicfieldupdate();	
	 	$("#divParentBillerMetaData").empty();
	 	$("#divSubBillerMetaData").empty();
	 	$("#divBillerInstructionData").hide();
	}
	function onBillerCategoryFailure(){
			$("#divParentBillerCompany").empty();	
			$("#divBillerInstructionData").hide();
			$("#divSubBillerMetaData").empty();
	}
	
	function onParentBillerServiceSuccess(data,textStatus){									
	 	$("#divBillerService").dynamicfieldupdate();	
	 	$("#divParentBillerMetaData").empty();
	 	$("#divSubBillerMetaData").empty();
	 	$("#divBillerInstructionData").hide();
 	 	$("#divPassCode").hide();	 						 	
	}
	function onParentBillerServiceFailure(){
			$("#divBillerService").empty();	
			$("#divBillerInstructionData").hide();
			$("#divSubBillerMetaData").empty();
	}
		
	function onParentBillerMetaDataSuccess(data,textStatus){									
	 	var isSubbiller_present = $("#billerId").find("option").length;
	 	if (isSubbiller_present == 0){
	 		$("#divBillerInstructionData").show();
	 	}				 	
	 	$("#divParentBillerMetaData").dynamicfieldupdate(); 
	 	var billerlogo=$("#divParentBillerMetaData").find("#billerlogo").detach();
	 	
 	 	/*var billerdoc=$("#divParentBillerMetaData").find("#billerdocmentimage").detach();*/
 	 	$("#imglogoholder").empty();
 	 	$("#imglogoholder").append(billerlogo);
 	 	/*$("#imgdocholder").empty();
 	 	$("#imgdocholder").append(billerdoc);*/	
 	 	
 	 /*	var value = $('#billerServiceId :selected').text();	 
 	 	if (value == 'Prepaid'){
 	 	$("#divAutoPayOption").hide();
 	 	}else{
 	 	$("#divAutoPayOption").show();
 	 	} 	*/	
 	 	
 	 	var value = $('#parentBillerId :selected').text();	
 	 	var servicevalue = $('#billerServiceId :selected').text();
 	 	
 	 	if (value == 'Zain' && servicevalue == 'Postpaid'){
 	 	$("#divPassCode").dynamicfieldupdate();
 	 	$("#divPassCode").show();
 	 	}else{
 	 	$("#divPassCode").hide();
 	 	}			 	
	}
	function onParentBillerMetaDataFailure(){
			$("#divParentBillerMetaData").empty();			
			$("#divSubBillerMetaData").empty();		
			$("#divBillerInstructionData").hide();
	}
	
	function onSubBillerMetaDataSuccess(){
				$("#divBillerInstructionData").show();				 	
			 	$("#divSubBillerMetaData").dynamicfieldupdate();	
		 		var billerlogo1=$("#divSubBillerMetaData").find("#billerlogo").detach();			 
		 		$("#subbillerimglogoholder").empty();
		 		$("#subbillerimglogoholder").append(billerlogo1);		
	}
	
	function onSubBillerMetaDataFailure(){
			$("#divParentBillerMetaData").empty();			
			$("#divSubBillerMetaData").empty();		
			$("#divBillerInstructionData").hide();
	}
	
	function showImage(obj){
		alert(obj.value);
	}
		
	function showCount(){				
		var intSize=$("#parentBillerId").find("option").length-1;
		alert(intSize);
		if (intSize == '1'){
			alert('only one');
		}
	}
	
	function getParentBillerId()
	{			
		return $("#parentBillerId").val();			 
	}
	
	function getAutoPayFlag(){
		var selectedVal = "";
		var selected = $("input[type='radio'][name='autoPayOption']:checked");
		if (selected.length > 0)
		    return selected.val();
	}
	
	function updateautopaydivdata(data,textStatus)
	{			
		$("#autopaydivdata").html(data);
		$( "#divAutoPay" ).buttonset();
		$("#autopaydivdata").dynamicfieldupdate();
		selectshow();
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
	function catchButtonEvent(buttonName)
	{	
		$("#buttonEvent").val(buttonName);
	}
	
	function onServiceSucess(data,textStatus){
		var link = "<g:createLink action='saveAndPaySuccess' controller='Biller' params='[]'/>"
		postUrl('frmBiller',link,'canvas')
	}
	function postUrl(formName, url, targetName){
		var form = $('#'+formName); 
		form.attr('action',url);
		form.attr('method','POST');
		form.attr('target',targetName);
		form.submit();
	}
	
	function onSaveSucess(data,textStatus){
	
	}
</g:javascript>
</body>
</html>
