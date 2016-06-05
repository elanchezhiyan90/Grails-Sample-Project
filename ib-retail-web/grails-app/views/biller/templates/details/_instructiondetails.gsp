<vayana:popupMessages/><br/>
<g:form name="editBillerInstruction">	
<div class="servicepanel" id="servicepanel">
<div class="addBillercls">
<g:hiddenField name="hautoPayValue" />
<g:hiddenField name="haccountNumber" />
<g:hiddenField name="hfromDate" />
<g:hiddenField name="htoDate" />
<g:hiddenField name="hautopayFlag" />

<g:if test="${InstructionDetailsModel?.billerInstruction?.id}">
<g:hiddenField name="billerInstructionId" value="${InstructionDetailsModel?.billerInstruction?.id}" />
<g:hiddenField name="billerInstructionVersion" value="${InstructionDetailsModel?.billerInstruction?.version}" />
<g:hiddenField name="billerId" value="${InstructionDetailsModel?.billerInstruction?.getBiller().getId()}" />
<g:hiddenField name="billerVersion" value="${InstructionDetailsModel?.billerInstruction?.getBiller().getVersion()}" />
<g:hiddenField name="billerServiceId" value="${InstructionDetailsModel?.billerInstruction?.getBillerService().getId()}" />
<%--<g:hiddenField name="shortName" value="${InstructionDetailsModel?.billerInstruction?.shortName}" />--%>
</g:if>

		<g:if test="${InstructionDetailsModel?.billerInstruction.getAutoPayFlag()}">
		<g:set var="autoPayValue" value="${InstructionDetailsModel?.billerInstruction.getAutoPayFlag().toString()}" />
		</g:if>
		<g:if test="${InstructionDetailsModel?.billerInstruction.getAccount()}">
		<g:set var="accountNumber" value="${InstructionDetailsModel?.billerInstruction.getAccount().accountNumber.toString()}" />
		<g:set var="accountId" value="${InstructionDetailsModel?.billerInstruction.getAccount().id.toString()}" />
		<g:set var="accountIdVersion" value="${InstructionDetailsModel?.billerInstruction.getAccount().idVersion.toString()}" />
		</g:if>
		<g:if test="${InstructionDetailsModel?.billerInstruction.getEffectiveFromDate()}">
		<g:set var="fromDate" value="${InstructionDetailsModel?.billerInstruction.getEffectiveFromDate().toString()}" />
		</g:if>
		<g:if test="${InstructionDetailsModel?.billerInstruction.getEffectiveToDate()}">
		<g:set var="toDate" value="${InstructionDetailsModel?.billerInstruction.getEffectiveToDate().toString()}" />
		</g:if>
		<g:if test="${InstructionDetailsModel?.billerInstruction.getBiller().getId()}">
		<g:set var="billerid" value="${InstructionDetailsModel?.billerInstruction.getBiller().getId().toString()}" />
		</g:if>
		<g:if test="${InstructionDetailsModel?.billerInstruction.getMaximumAmount()}">
		<g:set var="maxAmount" value="${InstructionDetailsModel?.billerInstruction.getMaximumAmount().toString()}" />
		</g:if>
		<g:if test="${InstructionDetailsModel?.billerInstruction.getCurrency()}">
		<g:set var="currencyId" value="${InstructionDetailsModel?.billerInstruction.getCurrency().id.toString()}" />
		</g:if>
		
						<g:each var="billerData" in="${InstructionDetailsModel?.billerInstruction?.billerData}">
						<g:set var="isNullable" value="${billerData?.billerMetadata?.nullable.toString()}" />
						<g:set var="dataType" value="${billerData?.billerMetadata?.dataType.toString()}" />	
						<g:set var="isreadonly" value="${billerData?.billerMetadata?.primaryFlag.toString()}" />
						<g:hiddenField name="${billerData?.billerMetadata?.dataLabel?.code}" value="${billerData?.getBillerDataValue()}" />
						
						<div class="fields">
						<p>
							<label for="shortName" >${message(code:'biller.addbiller.nickname.label') }</label>	
							<input type="text" name="shortName" id="shortName" required="required" value="${InstructionDetailsModel?.billerInstruction?.shortName}" data-errormessage="${g.message(code:"biller.templates.addbiller.addbillerinstruction.nickname.error.message") }"/>						
						</p>
						</div>	
						<%--<div class="fields">
						<p>
							<label for="${billerData?.billerMetadata?.dataLabel?.description}" >${billerData?.billerMetadata?.dataLabel?.description}</label>								
								
								<g:if test="${dataType.equals("L")}">
									<g:if test="${isreadonly.equals("N") }">
										<g:if test="${isNullable.equals("N")}">
										<g:select id="${billerData?.billerMetadata?.dataLabel?.code}" 
										                             name='${billerData?.billerMetadata?.dataLabel?.code}' 
										                             from='${billerData?.billerMetadata?.ibLookupType}'
										                             optionKey="id" 
															         optionValue="shortName"
															         noSelection ="${['null':'Select']}"
															         required="required"							         	
															         />	
										</g:if>
										<g:if test="${isNullable.equals("Y")}">
										<g:select id="${billerData?.billerMetadata?.dataLabel?.code}.toLowerCase()" 
										                             name='${billerData?.billerMetadata?.dataLabel?.code}' 
										                             from='${billerData?.billerMetadata?.ibLookupType}'
										                             optionKey="id" 
															         optionValue="shortName"
															         noSelection ="${['null':'Select']}"				         	
															         />	
										</g:if>								  
									</g:if>	
									</g:if>	
								<g:if test="${dataType.equals("V")}">
									<g:if test="${isreadonly.equals("N") }">
										<g:if test="${isNullable.equals("N")}">
										<input type="text"  name="${billerData?.billerMetadata?.dataLabel?.code}" id="${billerData?.billerMetadata?.dataLabel?.code}"  required="required" value="${billerData?.getBillerDataValue()}" />
										</g:if>
										<g:if test="${isNullable.equals("Y")}">
										<input type="text"  name="${billerData?.billerMetadata?.dataLabel?.code}" id="${billerData?.billerMetadata?.dataLabel?.code}" value="${billerData?.getBillerDataValue()}"/>
										</g:if>
									</g:if>	
									<g:if test="${isreadonly.equals("Y") }">
									<input type="text"  name="${billerData?.billerMetadata?.dataLabel?.code}" id="${billerData?.billerMetadata?.dataLabel?.code}" readonly="readonly" value="${billerData?.getBillerDataValue()}"/>
									</g:if>								
								</g:if>
								
								<g:if test="${dataType.equals("N")}">
									<g:if test="${isreadonly.equals("N") }">
										<g:if test="${isNullable.equals("N")}">
										<input type="text"  name="${billerData?.billerMetadata?.dataLabel?.code}" id="${billerData?.billerMetadata?.dataLabel?.code}"  required="required" value="${billerData?.getBillerDataValue()}" />
										</g:if>
										<g:if test="${isNullable.equals("Y")}">
										<input type="text" name="${billerData?.billerMetadata?.dataLabel?.code}" id="${billerData?.billerMetadata?.dataLabel?.code}" value="${billerData?.getBillerDataValue()}" />
										</g:if>
									</g:if>	
								</g:if>
								
								<g:if test="${dataType.equals("D")}">
									<g:if test="${isreadonly.equals("N") }">
										<g:if test="${isNullable.equals("N")}">
										<input type="date" name="${billerData?.billerMetadata?.dataLabel?.code}" id="${billerData?.billerMetadata?.dataLabel?.code}" data-errormessage="${message(code:'biller.templates.details.instructiondetails.date.error.message') }" value="${billerData?.getBillerDataValue()}" />
										</g:if>
										<g:if test="${isNullable.equals("Y")}">
										<input type="date" name="${billerData?.billerMetadata?.dataLabel?.code}" id="${billerData?.billerMetadata?.dataLabel?.code}" data-errormessage="${message(code:'biller.templates.details.instructiondetails.date.error.message') }"  required="required" value="${billerData?.getBillerDataValue()}" />
										</g:if>
									</g:if>
								</g:if>
					</p>
					</div>		
					--%>
					</g:each>
				
				<div class="fields" id="divAutoPayOption">
					<g:hiddenField name="autoPayOption" value="N" />
						<%--<p>
      							<label for="Auto Payment">${message(code:'biller.templates.details.instructiondetails.autopayment.label') }</label>
     							<g:radio name="autoPayOption" id="autoPayOptionY" value="Y" required="required" onclick="${remoteFunction(controller:'Biller',update:'',action:'getautopayfields',params:'\'autopayType=\'+getAutoPayFlag()',onSuccess:'updateautopaydivdata(data,textStatus);')}" /><label for="autoPayOptionY" >${message(code:'biller.templates.details.instructiondetails.autopayment.yes.label') }</label>
     							<g:radio name="autoPayOption" id="autoPayOptionN" value="N" required="required" /><label for="autoPayOptionN" >${message(code:'biller.templates.details.instructiondetails.autopayment.no.label') }</label>                               
  						</p>  	--%>					
                </div>
                
              <%--  <div id="divBillerInstructionAutopayYes" style="display: none;">				
					<div class="fields">
						<p>
      							<label for="Auto Payment">${message(code:'biller.templates.details.instructiondetails.autopaymentyes.label') }</label>
  						</p>  						
					</div>
				</div>	
                				
				<div id="autopaydivdata" >
					<div id="autopaydata" style="border:solid 1px #DDDDDD; display: inline-block;padding:5px 5px;">

						<div class="fields">
									<p>
										<label for="from_account" >${message(code:'biller.templates.addbiller.autopayfields.accounttodebit.label') }</label>
										${InstructionDetailsModel?.billerInstruction?.getAccount()?.accountNumber}
										<input type="hidden" value="" name="accountId" id="accountId" />
									</p>
						</div>	
						
						<div class="fields" id="divAutoPay">
							<p>
						 		<label for="autopay">${message(code:'biller.templates.addbiller.autopayfields.amounttodebit.label') }</label>
						 		<g:radio name="autoPay" id="autopayF" value="F" required="required" /><label for="autopayF" >${message(code:'biller.templates.addbiller.autopayfields.amounttodebit.fullamount.label') }</label>
								<g:radio name="autoPay" id="autopayM" value="M" required="required" /><label for="autopayM" >${message(code:'biller.templates.addbiller.autopayfields.amounttodebit.minimumamount.label') }</label>					     								
							</p>  						
						</div>
						
						<div class="fields" id="currency">
							<p>
								<label for="amount">${message(code:'biller.templates.addbiller.addbillerinstruction.currency&maxamount.label')}</label>
									<vayana:tenantOpsCurrencySelect name="currencyId" id="currencyId"
									class="cur" required="required"
									data-errormessage="${g.message(code:"payment.templates.ownaccount.transfer.currencyamount.error.message") }" />
									
									<input type="number" step="any" name="maximumAmount"
									id="maximumAmount" class="s_amt" min="1" required="required"
									data-errormessage="${message(code:'billpayment.templates.billpayment.amount.error.message')}" />
							</p>							
						</div>

						<div class="fields">
						              <p>
						                <label for="from_date">${message(code:'biller.templates.addbiller.autopayfields.fromdate.label') }</label> 
					                    <g:formatDate format="MM/dd/yyyy" date="${InstructionDetailsModel?.billerInstruction?.getEffectiveFromDate()}"/>
						                <input type="hidden" value="" name="effectiveFromDateparam" id="effectiveFromDateparam" />						               
						              </p>
						     		</div>
						      		<div class="fields">
						              <p>
						                <label for="to_date">${message(code:'biller.templates.addbiller.autopayfields.todate.label') }</label>
						                <input type="date" name="effectiveToDateparam" id="effectiveToDateparam"  class="effectiveToDate" data-dependent-validation='{"from": "effectiveFromDateparam", "prop": "min"}'   data-errormessage="${message(code:'biller.templates.addbiller.autopayfields.todate.error.message') }" required="required" />
						              </p>
						</div>
					</div>										
				</div>
				
				 --%>
				 <div id="dynamicAuthContent">
					 <vayana:serviceValidate name="addBillerInst"
						value="${g.message(code:"biller.addbiller.submit.button.text") }"
						enableButton="btns_now" controller="Biller"
						action="validateeditBillerInstruction" secondaryDiv="servicepanel" displayAsPopUp="YES"/>	
						<input type="button" id="cancel" value="Cancel" name="cancel" class="cancelForm btn_next"> 
									
				</div>						
	</div>
	</div>				
	</g:form>				
				
<script>

$(document).ready(function(){
	 
	 	$("#divAutoPayOption" ).buttonset();
		$("#cee_ajax").dynamicfieldupdate();//update polyfill on after ajax load.	

		$("#hautoPayValue").val='${autoPayValue}';
		$("#haccountNumber").val='${accountNumber}';
		$("#hfromDate").val='${fromDate}';
		$("#htoDate").val='${toDate}';
	
		$(function() {
		    var $radios = $('input:radio[name=autoPayOption]');
		    var $autopayradios = $('input:radio[name=autoPay]');
		    var autoPayval="${autoPayValue}";
			//alert(autoPayval);

			if(autoPayval == 'N'){
				 $radios.filter('[value=N]').attr('checked', true);
				 $("#autopaydivdata").empty();
				 $("#hautopayFlag").val('I');
			}else{			
				$radios.filter('[value=Y]').attr('checked', true);
				$("#divAutoPayOption").hide();
				$("#hautopayFlag").val('U');
				$("#divBillerInstructionAutopayYes").show();
		        $("#autopaydivdata").show();
		        $("#divAutoPay" ).buttonset();
			    $autopayradios.filter('[value="${autoPayValue}"]').attr('checked', true);	
			    $("#effectiveFromDateparam").val('${fromDate}');
			    $("#effectiveToDateparam").val('${toDate}');
			    $("#maximumAmount").val('${maxAmount}'); 
   				$("#accountId").val('${accountIdVersion}'); 
			   			    
			    var currency = ('${currencyId}');  
			   	var curselVal = $("#currencyId option").each(function()
			    {
			    			var passVal = $(this).val()		
			    			var thisVar = $(this);		
			    			setCurrency(passVal,currency,thisVar)

			    });		        
			}
					 		    
		   //alert(${accountNumber});
		   
		    });


		$('input:radio[name="autoPayOption"]').change(function(){         	
	        if ($(this).is(':checked') && $(this).val() == 'N' ) {
	           $("#autopaydivdata").empty();	                    
	        }	        
	    });
			

		//form validations
		$("#updateSubmit").click(function(){	
		      
		      if($('form').checkValidity()){        
		      $("#otp_div").show();      
		      }
		      reinitialiseScrollPane();
			  });
			  
		      $("#otp_cancel").click(function(){
		        $("#otp_div").hide();           
		      });
		      
			$("#updateConfirm").click(function(){	
				//$(".success").show();
				$("#otp_div").hide();
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

function otpResponse(data,textStatus)
{
	//$("#otp_div").hide();
	$("#resultsuccess").show();				    
}

function setFromAccount(passVal,fromacc,thisVar){
	passVal=passVal.split(',');			
	if(fromacc == passVal[0])
	{	
		$(thisVar).val(passVal).attr("selected","selected") ;		
		var sel=$(thisVar).val(passVal).text();			
		$(thisVar).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(sel);
		selectshow();
		//alert('setFromAccount');
		//$(thisVar).parents("select").trigger("change");		
		//alert('setFromAccount1.1');	
	}	
}

function setCurrency(passVal,currency,thisVar){
	passVal=passVal.split(',');			
	if(currency == passVal[0])
	{	
		$(thisVar).val(passVal).attr("selected","selected") ;		
		var sel=$(thisVar).val(passVal).text();			
		$(thisVar).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(sel);
		selectshow();
		//alert('setFromAccount');
		//$(thisVar).parents("select").trigger("change");		
		//alert('setFromAccount1.1');	
	}	
}


</script>				