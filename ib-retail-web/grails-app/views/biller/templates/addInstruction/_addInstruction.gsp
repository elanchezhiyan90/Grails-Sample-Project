<g:hiddenField name="buttonEvent"/>
<vayana:popupMessages/><br/>
<g:form name="addBillerInstruction">

<div class="servicepanel" id="servicepanel">
<div class="addBillercls">
	<g:hiddenField name="billerId" value="${BillerDetailsModel?.billerServices[0].biller?.getIdVersion()}" />
	<g:hiddenField name="billerCode" value="${BillerDetailsModel?.billerServices[0].biller?.referenceNumber}" />	
	<g:render template="/biller/templates/addbiller/billerServices" />   				
				
	<div id="divParentBillerMetaData" >	</div>	
	<div id="divPassCode" style="display: none;">
		<div class="fields">
			<p>
   							<label for="passcode">${message(code:'biller.addbiller.passcode.label') }</label>
  							<input type="text" value="" name="passCode" id="passCode" data-errormessage="${g.message(code:"biller.templates.addbiller.addbillerinstruction.passcode.error.message") }"/>                               
					</p>  						
		</div>
	</div>
	<div id="divBillerInstructionData">				
		<div class="fields">
			<p>
				<label for="payeename">${message(code:'biller.templates.details.addinstruction.nickname.label') }</label>
				<input type="text" value="" name="shortName" id="shortName" required="required" data-errormessage="${g.message(code:"biller.templates.addbiller.addbillerinstruction.nickname.error.message") }"/>                               
			</p>  						
		</div>
		                
        <div class="fields" id="divAutoPayOption">
        <g:hiddenField name="autoPayOption" value="N" />
		<%--	<p>
   				<label for="Auto Payment">${message(code:'biller.templates.details.addinstruction.autopayment.label') }</label>
  				<g:radio name="autoPayOption" id="autoPayOptionY" value="Y"  onclick="${remoteFunction(controller:'Biller',update:'',action:'getautopayfields',params:'\'autopayType=\'+getAutoPayFlag()',onSuccess:'updateautopaydivdata(data,textStatus);')}" /><label for="autoPayOptionY" >${message(code:'biller.templates.details.addinstruction.autopayment.yes.label') }</label>
  				<g:radio name="autoPayOption" id="autoPayOptionN" value="N" /><label for="autoPayOptionN" >${message(code:'biller.templates.details.addinstruction.autopayment.no.label') }</label>                               
			</p>  		 --%>				
        </div>                 
        <div id="autopaydivdata" > </div>                
       
        <div id="dynamicAuthContent">
        	<vayana:serviceValidate name="addBillerInst" buttonEvent="SAVE"
					value="${g.message(code:"biller.addbiller.submit.button.text") }"
					enableButton="btns_now" controller="Biller"
					action="validateWithinBillerInstruction" secondaryDiv="servicepanel" displayAsPopUp="YES"/>	
				
			<input type="button" id="cancel" value="Cancel" name="cancel" class="cancelForm btn_next"> 		
		</div>							
	</div>
</div>	
</div>  

</g:form> 
 <script>      
      
$(function () {
  $(".addBillercls").dynamicfieldupdate();
     $("#billerlogo").hide();  
     $( "#divAutoPayOption" ).buttonset();
      
      $("#addSubmit").click(function(){      
	      if($('form').checkValidity()){        
	      		$("#otp_div").show();      
	      }
	      reinitialiseScrollPane();
	  });
		
	$('input:radio[name="autoPayOption"]').change(function(){         	
        if ($(this).is(':checked') && $(this).val() == 'N' ) {
           $("#autopaydivdata").empty(); 
           $("#divAutoPay").hide();           
        }
        else
        {   	        	
        	$("#divAutoPay").show();
        }
    });	
    
    $(".cancelForm").on("click",function() {
		 $.fn.ceebox.closebox();
	});
});
			
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
}  

function onParentBillerMetaDataSuccess(data,textStatus){				
	 	$("#divParentBillerMetaData").dynamicfieldupdate(); 
	 	var value = $('#billerServiceId :selected').text();	 		
 	 	if (value == 'PREPAID'){
 	 	$("#divAutoPayOption").hide();
 	 	}else{
 	 	$("#divAutoPayOption").show();
 	 	} 
 	 var biller = $("#billerCode").val();	
 	 if (biller == '1' && value == 'Postpaid'){
	 	$("#divPassCode").show();
	 	}else{
	 	$("#divPassCode").hide();
	 }
}		
 </script>