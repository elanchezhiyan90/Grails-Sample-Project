
<h2>Deposit Account Opening</h2>
<g:form name="frmOpenDeposit">
	<g:hiddenField name="buttonEvent" />
	<g:hiddenField name="customerBranchId" id="customerBranchId"  value="${customerBranchIdVersion?.split(',')[0]}" />

	<div class="mandi-note">
		<span class="mandi"></span>
		<p>Mandatory fields</p>
	</div>
	<div class="fields">
		<p>
			<label for="from_account">Debit Account</label>
			<vayana:fromAccountSelect id="payerInstruction" 
				name="payerInstruction" type="FF" poptype="CASA" tdOpsIns="YES"
				noSelection="${['Select Payer Account':'Select Payer Account']}"
				onchange=" ${remoteFunction( 
					 						    	controller :'common',
													update:'balance',
											   		action:'fetchAccountBalance', 	
													before:'if(checkFromAccount()){return false;}',													  						
					 								params:'\'accountIdVersion=\'+payerVal()' 
												    ,onSuccess: 'onPayerIdSuccess(data,textStatus);'													   										  		
					 					   			)}"
				required="required"
				data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.youraccount.error.message") }" />
			<br> <span class="selected_des" id="fromAccSelect"><g:message
					code="payment.templates.friendsandfamily.transfer.youraccount.selection.message" />&nbsp;</span>
		</p>

		<div class="updater" id="balance"></div>
	</div>
	<%--<div id="branchTypeButtonSet" class="fields">
		<P>
			<label for="branchForTDOpening">Branch for TD Opening</label> 
			<label for="OB">Other Branch</label> 
			<input type="radio" name="branchType" id="OB" value="OB" required="required"   /> 
			<label for="HB">Home Branch</label> 
			<input type="radio" name="branchType" id="HB" value="HB" required="required"  checked="checked" />

		</p>

	</div>
	--%>
	
	<%--<div class="fields" id="branchFields">
		<p>
			<label for="branch">BranchForTDOpening </label>
			<vayana:customerBranch name="tenantBranch" id="tenantBranch" value="${customerBranchIdVersion?.split(',')[0]}" required="required" readonly="readonly"></vayana:customerBranch>
		</p>
	</div>
	--%><div class="fields" id="branchFields">
		<p>
			<label for="branch">BranchForTDOpening  </label>
		<input type="text"  name="accountBranchDesc" id="accountBranchDesc"
				required="required" readonly="readonly" value="" />
		</p>
	</div>
	
	
	
	<%--
	
	
		
		<div class="fields" id="branchFields">
		<p>
			<label for="branch">Branch </label>
		<input type="text"  name="accountBranchDesc" id="accountBranchDesc"
				required="required" readonly="readonly" value="" />
		</p>
	</div>
--%><%--
	<div class="fields" id="branchFields">
		<p>
			<label for="branch">Branch </label>
		<input type="text"  name="accountBranchDesc" id="accountBranchDesc"
				required="required" readonly="readonly" value="${}" />
		</p>
	</div>
	
	--%><div id="depositTypes" class="fields">
		<p>
			<label for="Deposit Type">Deposit Type</label>
			<%--<vayana:tenantLookupSelect name="depositType" id="depositType"
				optionKey="code" optionValue="description" type="DEPOSIT_TYPE"
				domain="tenant" required="required" />
		--%>
			<vayana:depositTypes name="depositType" id="depositType" required="required" optionKey="idVersion" optionValue="description"></vayana:depositTypes>
		</p>
	</div>
	<div id="depositDetails" class="fields">
	</div>
	<div class="fields">
		<p>
			<label for="amount">Currency &amp; Deposit Amount </label>
			<vayana:tenantBaseCurrencySelect name="tenantBaseCurrencySelect"
				id="currency" name="currency" class="cur" required="Y"
				data-errormessage="Please select value" />

			<input type="number" step="1" name="amount" id="amount" pattern="[0-9]*"
				required="required" class="s_amt" min="" max=""  data-errormessage="Please select  Amount between minAmount to maxAmount, and Amount should be Whole Number" value="" />
				<a href="http://www.pmcbank.com/english/PBInterestRates.aspx"  style="color:#00346b !important;" target="_blank" >Interest Rate</a>
			</p>
	</div>

			<%--<div id="interestRates"	class="dataLabels">
						<p>
                             	<label for="interestRates"> Interest rates from PMC Bank </label>
                             	<g:link url="http://www.pmcbank.com/english/PBInterestRates.aspx" target="_blank" > PMC Bank Interest rates </g:link>
						</p>
					<p>
					  <a href="http://www.pmcbank.com/english/PBInterestRates.aspx" target="_blank" >Link of Interest rates from PMC Bank website</a>
					</p>
					</div>


	--%><div class="fields" id="periodOfDeposit">

		<p>
			<label for="depositPeriod">Period of Deposit</label> <input
				type="number" step="1" name="month" id="month" 
				required="required" class="s_amt" pattern="[0-9]*" min="" max=""
				 value="" data-errormessage="Please select Month between minTenure to max Tenure" onchange=""/><b>Months</b> <%--<input type="text" step="any" name="days"
				id="days" pattern="[0-9]+" required="required" class="s_amt"
				pattern="[0-9]*" min="0" maxlength="4" value="" /><b>Days</b>
		--%></p>
	</div>
	


	<div class="fields">
		<p>
			<label for="type">Maturity Instruction</label>
			<vayana:tenantLookupSelect   optionValue="description" 
				name="maturityInstruction" type="MATURITY_INSTRUCTION" id="maturityInstruction"
				required="required" data-errormessage="Please select value"></vayana:tenantLookupSelect>
		</p>

	</div>
	
	<div id="renewalTerm" class="fields">
		<p>
			<label for="type"> Renewal times</label>
			<%--<vayana:tenantLookupSelect optionValue="description"
				name="renewalTerm" type="RENEWAL_TERM"
				id="renewalTerm" required="required" 
				data-errormessage="Please select value"></vayana:tenantLookupSelect>
					                           --%>
          <g:select name="renewalTerm" id="renewalTerm" from="${['1','2','3']}" keys="${['1','2','3'] }" ></g:select>
		</p>

	</div>
	
	<%--<div class="fields">
		<p>
			<label for="type">Interest Payable Frequency</label>
			<vayana:tenantLookupSelect optionValue="description"
				name="interestPayableFreq" type="INTERET_PAYABLE" id="interestPayableFreq"
				required="required" data-errormessage="Please select value"></vayana:tenantLookupSelect>
		</p>

	</div>

	<div class="fields">
		<p>
			<label for="type"> Interest Payable Mode</label>
			<vayana:tenantLookupSelect optionValue="description"
				name="interestPayableMode" type="INTERET_PAYABLE_MODE"
				id="interestPayableMode" required="required"
				data-errormessage="Please select value"></vayana:tenantLookupSelect>
		</p>

	</div>
	
	--%><%--<div class="fields">
		<p>
			<label for="type">Principal & Interest Credit A/c No.</label>
			<vayana:fromAccountSelect id="creditAccountNumber"
				name="creditAccountNumber" type="FF" poptype="CASA"
				noSelection="${['Select Payer Account':'Select Payer Account']}"
				required="required"
				data-errormessage="${g.message(code:"payment.templates.friendsandfamily.transfer.youraccount.error.message") }"/>
		</p>

	</div>

	--%>
	<div class="fields">
		<p>
			<label for="type">Principal & Interest Credit A/c No.</label>
		<input type="text"  name="creditAccountNumber" id="creditAccountNumber"
				required="required" readonly="readonly" value="" />
		</p>
	</div>
	
	
	
	<div id="nominationFacilitys" class="dataLabels fields">
		<P>
			<label for="nominationFacility">Nomination Facility</label> <label
				for="YES">YES</label> <input type="radio" name="nominationFacility"
				id="YES" value="YES" /> <label for="NO">NO</label> <input
				type="radio" name="nominationFacility" id="NO" value="NO"
				checked="checked" />


		</p>

	</div>

	<div id="nomineeNames" class="fields">

		<p>
			<label for="nomineeName">Nominee Name</label>
			<g:textField name="nomineeName" id="nomineeName" required="required" maxlength="50" pattern="[a-zA-Z0-9 ]+"
				value="" />
		</p>
	</div>

    <div id="nomineeAddresss" class="fields">

		<p>
			<label for="nomineeAddress"> Address of Nominee </label>
			<g:textField name="nomineeAddress" id="nomineeAddress" required="required"  maxlength="50" 
				value="" />
		</p>
	</div>
	   <div id="nomineeAddresss1" class="fields">

		<p>
			<label for="nomineeAddress1"> </label>
			<g:textField name="nomineeAddress1" id="nomineeAddress1" required="required" maxlength="50" 
				value="" />
		</p>
	</div>
	 <div id="nomineeAddresss2" class="fields">

		<p>
			<label for="nomineeAddress2"> </label>
			<g:textField name="nomineeAddress2" id="nomineeAddress2" required="required" maxlength="50" 
				value="" />
		</p>
	</div><%--
	 <div id="Country" class="fields">

		<p>
			<label for="Country">Country</label>
			<g:textField name="country" id="country" required="required" 
				value="" />
		</p>
	</div>
	--%>
	<div id="City" class="fields">

		<p>
			<label for="City">City</label>
			<vayana:select name="city" id="city"
									type="TDCITY" domain="base" findBy="ALL" required="required"
									data-errormessage="Please select value" />
		</p>
	</div>
	<div id="State" class="fields">

		<p>
			<label for="State">State</label>
			<vayana:select name="state" id="state"
									type="STATE" domain="base" findBy="ALL" required="required"
									data-errormessage="Please select value" />
		</p>
	</div>
	
	<div id="Country" class="fields">
		<p>
			<label for="type">Country</label>
			<vayana:select name="country" id="country"
									type="COUNTRIES" domain="base" findBy="ALL" required="required"
									data-errormessage="Please select value" />
		</p>

	</div>


		<div id="Pincode" class="fields">

		<p>
			<label for="Pincode">Pincode</label>
			<g:textField name="pincode" id="pincode" required="required"  pattern="[0-9]+"  maxlength="8" 
				value="" />
		</p>
	</div>
	
	
	
	<div id="nomineeRelationships" class="fields">
		<p>
			<label for="type"> Relationship with Depositor</label>
			<vayana:tenantLookupSelect optionValue="description"
				name="nomineeRelationship" type="RWD"
				id="nomineeRelationship" required="required"
				data-errormessage="Please select value"></vayana:tenantLookupSelect>
		</p>

	</div>
	
	<div id="pancardNumber" class="fields">

		<p>
			<label for="panNumber">PAN Card number</label>
			<g:textField name="panNumber" id="panNumber" maxlength="10" pattern="[a-zA-Z0-9]+"
				value="" />
		</p>
	</div>
	

	<div id="nomineeeDOB" class="fields">
				<p>
					<label for="nomineeDOB">DOB of Nominee </label>
					<input type="date" id="nomineeDOB" 
						data-errormessage="Please select value" name="nomineeDOB"
						title="Please select value" class="" maxlength="10" required="required"
					 max="${new Date().minus(1).toTimestamp()?.format('yyyy-MM-dd')}"
											
						/>
				</p>
			</div>
			
	<div id="nomineeisminor" class="dataLabels fields">
		<P>
			<label for="nomineeminor">Nominee is Minor</label> <label
				for="nomineeminorYES">YES</label> <input type="radio" id="nomineeminorYES" name="nomineeminor"
				 value="YES" /> <label for="nomineeminorNO">NO</label> <input
				type="radio" id="nomineeminorNO" name="nomineeminor"  value="NO"
				checked="checked" />


		</p>

	</div>	
	
	<div id="guardianNamediv" class="fields">

		<p>
			<label for="guardianName"> Name of guardian</label>
			<g:textField name="guardianName" id="guardianName" required="required" maxlength="50"   pattern="[a-zA-Z0-9 ]+"
				value="" />
		</p>
	</div>
	
	<div id="guardianRelationshipdiv" class="fields">
		<p>
			<label for="type"> Relationship with nominee</label>
			<vayana:tenantLookupSelect optionValue="description"
				name="guardianRelationship" type="RELATIONSHIP_WITH_NOMINEE"
				id="guardianRelationship" required="required"
				data-errormessage="Please select value"></vayana:tenantLookupSelect>
		<%--
		<g:select name="guardianRelationship" id="guardianRelationship" from="${['Court Appointed','De Facto Guardian','Father','Mother','Others']}" keys="${['C','D','F','M','O'] }"></g:select>
		--%></p>

	</div>
	
	<br />
	<div class="fields">
		<p>
			<label><input type="checkbox" name="terms" id="terms"
				required="required"
				data-errormessage="You have to agree the terms and conditions to proceed" />
				I agree the <g:remoteLink controller="investment"
					action="termsAndConditions" class="ceebox"
					title="${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.ceebox.text')}">
					${g.message(code:'payment.templates.ownaccount.transfer.termsandconditions.text')}
				</g:remoteLink> </label>
		</p>
	</div>
	<div class="buttons" id="btns_paynow">
		<br>
		<vayana:ftValidate name="payNow" buttonEvent="PAYNOW"
			value="Invest Now" enableButton="btns_now" controller="investment"
			action="validateOpenNewDeposit"
			secondaryAction="openNewDepositConfirm"
			secondaryController="investment" secondaryDiv="f-panel" />
			
			<%--<g:submitToRemote value="Invest Now" id="payNow" name="payNow"
	before="if (checkFormValidity1()) {return false;};unlockForm();catchButtonEvent('PAYNOW')"
	action="validateOpenNewDeposit" controller="investment"
	onSuccess="onValidateSuccess(data,textStatus,'btns_now');
				${remoteFunction(
					action:"openNewDepositConfirm",
					controller:"investment",
					update:"f-panel",
					onSuccess: 'onFTValidateSucess(data,textStatus);',
					onFailure: 'onFTValidateFailure(XMLHttpRequest.responseText);') }"
	onFailure="onError(XMLHttpRequest.responseText);" />
			

		


	--%></div>
	<div class="flds-block" id="dynamicContent"></div>

</g:form>
<g:javascript>
$(function () {
$("#branchTypeButtonSet").buttonset();
$("#nomineeNames").hide();
$("#nomineeName").removeAttr('required');
$("#depositDetails").hide();
$("#renewalTerm").hide();
$("#nomineeAddresss").hide();
$("#nomineeAddress").removeAttr('required');
$("#nomineeRelationships").hide();
$("#nomineeRelationship").removeAttr('required');
$("#pancardNumber").hide();
$("#nomineeeDOB").hide();
$("#nomineeDOB").removeAttr('required');
$("#nomineeisminor").hide();
$("#guardianNamediv").hide();
$("#guardianName").removeAttr('required');
$("#guardianRelationshipdiv").hide();
$("#guardianRelationship").removeAttr('required');
$("#nomineeAddresss1").hide();
$("#nomineeAddress1").removeAttr('required');
$("#nomineeAddresss2").hide();
$("#nomineeAddress2").removeAttr('required');
$("#Country").hide();
$("#country").removeAttr('required');
$("#State").hide();
$("#state").removeAttr('required');
$("#Pincode").hide();
$("#pincode").removeAttr('required');
$("#City").hide();
$("#city").removeAttr('required');


$("#depositType").on("change",function()
			{
				var text = $("#depositType").val();
				<g:remoteFunction controller='investment' action='showDepositTypeDetails' update='depositDetails' params="\'depositType=\'+text" onSuccess='onDepositTypeSuccess(data,textStatus)'/>
				$("#depositDetails").show();
					
				reinitialiseScrollPane();	 
			});	
			
			$("#maturityInstruction").on("change",function()
			{
				var rt = $("#maturityInstruction :selected").text();
				
				//alert("rt"+rt)
				
			  if(rt=="Renew Principal and Interest")
					{
					
					  $("#renewalTerm").show();
					  
					}else if(rt=="Renew Principal Only"){
						
						$("#renewalTerm").show();
					}else{
						$("#renewalTerm").hide();
					}
					
				reinitialiseScrollPane();	 
			});	
			
			if($('#payerInstruction option').size()==1)
		var selVal = $("#payerInstruction option").each(function()
		{
			var thisVar = $(this);					
			$(thisVar).parents("select").trigger("change");	
			var rt = $("#payerInstruction :selected").text();
					         
	           $("#creditAccountNumber").val(rt);	
				
		});
			
			$("#payerInstruction").on("change",function()
			{
				var rt = $("#payerInstruction :selected").text();
					         
	           $("#creditAccountNumber").val(rt);	
		
				reinitialiseScrollPane();	 
			});	

			$("#nominationFacilitys input").on("change",function()
			{
				
					if( $(this).is(":checked")){
						
						var opt=$(this).val();
						if(opt=="YES")
						{
					
							$("#nomineeNames").show();
							$("#nomineeAddresss").show();	
							$("#nomineeRelationships").show();
							$("#pancardNumber").show();	
							$("#nomineeeDOB").show();	
							$("#nomineeeDOB").attr('required','required');
						    $("#nomineeisminor").show();																		    						 
						    $("#nomineeName").attr('required','required');
						    $("#nomineeAddress").attr('required','required');	
						    $("#nomineeRelationship").attr('required','required');								
                            $("#nomineeAddresss1").show();
                            $("#nomineeAddress1").attr('required','required');
                            $("#nomineeAddresss2").show();
                            $("#nomineeAddress2").attr('required','required');
                            $("#Country").show().dynamicfieldupdate();
                            $("#country").attr('required','required');
                            $("#State").show().dynamicfieldupdate();
                            $("#state").attr('required','required');	
                            $("#Pincode").show();
                            $("#pincode").attr('required','required');	
                            $("#City").show().dynamicfieldupdate();
                            $("#city").attr('required','required');
                      	    $("#City").dynamicfieldupdate();				
							reinitialiseScrollPane();	
							

						}else{
							$("#nomineeNames").hide();
							$("#nomineeAddresss").hide();
							$("#nomineeRelationships").hide();	
							$("#pancardNumber").hide();	
							$("#nomineeeDOB").hide();	
							$("#nomineeeDOB").removeAttr('required');
							$("#nomineeisminor").hide();
						    $("#nomineeName").removeAttr('required');
							$("#nomineeAddress").removeAttr('required');
							$("#nomineeRelationship").removeAttr('required');
							$("#nomineeAddresss1").hide();
                            $("#nomineeAddress1").removeAttr('required');
                            $("#nomineeAddresss2").hide();
                            $("#nomineeAddress2").removeAttr('required');
                            $("#Country").hide();
                            $("#country").removeAttr('required');
                            $("#State").hide();
                            $("#state").removeAttr('required');	
                            $("#Pincode").hide();
                            $("#pincode").removeAttr('required');	
                            $("#City").hide();
                            $("#city").removeAttr('required');				
							reinitialiseScrollPane();	 
							
							
							}
					}
					
			});
			
			/*$("#nomineeisminor input").on("change",function()
			{
					//alert("hi");
					if( $(this).is(":checked")){
						
						var opt=$(this).val();
						if(opt=="YES")
						{
						//alert("hi");
							$("#guardianNamediv").show();
							$("#nomineeAddresss").show();																								    						 
						     $("#guardianName").attr('required','required');
							 $("#nomineeAddress").attr('required','required');							
                         
							reinitialiseScrollPane();	
							

						}else{
							$("#guardianName").hide();
							$("#guardianRelationshipdiv").hide();	
							 
							 $("#guardianName").removeAttr('required');
							 $("#guardianRelationship").removeAttr('required');
							reinitialiseScrollPane();	 
							
							
							}
					}
					
			});*/
			
			$('input[type=radio][name="nomineeminor"]').on("change",function()
			{
					
					if( $(this).is(":checked")){
						
						var opt=$(this).val();
						if(opt=="YES")
						{
						
							$("#guardianNamediv").show();
							$("#guardianRelationshipdiv").show();																							    						 
						     $("#guardianName").attr('required','required');
							 $("#guardianRelationship").attr('required','required');							
                         
							reinitialiseScrollPane();	
							

						}else{
							$("#guardianNamediv").hide();
							$("#guardianRelationshipdiv").hide();	
							 
							 $("#guardianName").removeAttr('required');
							 $("#guardianRelationship").removeAttr('required');
							reinitialiseScrollPane();	 
							
							
							}
					}
					
			});
			

			
			$("#branchTypeButtonSet input").on("change",function()
			{
				if( $(this).is(":checked")){
					var opt=$(this).val();
					if(opt=="OB")
					{
						<g:remoteFunction controller='investment' action='showBranch' update='branchFields' onSuccess='onBranchSuccess(data,textStatus)'/>
					}else{	
						var text = $("#customerBranchId").val();
						<g:remoteFunction controller="investment" action="showHomeBranch" update="branchFields" params="\'custBranch=\'+text" onSuccess="onBranchSuccess(data,textStatus)"/>
					}
				}	
			});
	
	 $('.dataLabels').each(function() {
	      var forButtonset = $(this).attr('id');      
	      $("#"+forButtonset).buttonset();    	  
		});
	 $(".fields").dynamicfieldupdate();   
});
function checkFromAccount()
{
	if($("#payerInstruction").val()=='')
		return true;
	else
		return false;
}
function payerVal()                            
{
	   var txt = $("#payerInstruction").val(); 	
	   setCreditAccountNo(txt);			   			 
	   return txt; 
}


function onPayerIdSuccess(data,textStatus)
{									
 
    var corebal =  $(data).first().html();
    $("#balance").empty().html(corebal);
	$("#balance").dynamicfieldupdate();
	var tenantBranchdesc= $("#tenantBranchdesc").val();
	//alert("tenantBranchdesc"+tenantBranchdesc);
	$("#accountBranchDesc").val(tenantBranchdesc);	
	
}

function setCreditAccountNo(txt){
	$("#creditAccountNumber option").each(function() {
		var curVal = $(this).val();	
		if(curVal == txt)
		{			
			$(this).val(curVal).attr("selected","selected") ;		
			var currsel=$(this).val(curVal).text();		
			$(this).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(currsel);			
		}
	});
}
function onBranchSuccess(data,textStatus){
	$("#branchFields").dynamicfieldupdate();
}
function onDepositTypeSuccess(data,textStatus){
	$("#depositDetails").dynamicfieldupdate();
	            var min = getminMonth();
				var max =getmaxMonth();
				var minAmount = getminAmount();
	            var maxAmount =getmaxAmount();
				//alert("minAmount"+minAmount);
				//alert("maxAmount"+maxAmount);
				//$("#periodOfDeposit").html("<p><label for='depositPeriod'>Period of Deposit</label><input type='number' step='any' name='month' id='month' required='required' class='s_amt' pattern='[0-9]*' min='${min}' max='${max}' value='' data-errormessage='Please select between 12 to 120' /><b>Months</b></p>").dynamicfieldupdate();
				$("#month").attr("min",min);
				$("#month").attr("max", max);
				$("#month").dynamicfieldupdate();
				$("#amount").attr("min",minAmount);
				$("#amount").attr("max", maxAmount);
				$("#amount").dynamicfieldupdate();
				
				//alert("s");

}
function checkmonths(){

	var month = getMonth();
	var min = getminMonth();
	var max =getmaxMonth();
	//alert("month"+month);
	//alert("min"+min);
	//alert("max"+max);
	if(parseInt(month) >= parseInt(min) && parseInt(month) <= parseInt(max)){
	//$("#messagesDiv").hide()
	 return true;
	}else{
	
	//$("#messagesDiv").empty().html("<div id='errorDiv'><div class='failure'><ul><li>Entered Month should be in 12 to 120</li></ul></div></div>").dynamicfieldupdate();
	return false;
	}
}

function checkAmount(){

	var amount = getAmount();
	var minAmount = getminAmount();
	var maxAmount =getmaxAmount();
	//alert("amount"+amount);
	//alert("minAmount"+minAmount);
	//alert("minAmount"+minAmount);
	if(amount >= minAmount && amount <=maxAmount){
	
	 return true;
	}else{
	
	
	return false;
	}
}

function getMonth()                            
{
	var txt = $("#month").val(); 					   			 
	return txt; 
}

function getminMonth()                            
{
	var txt = $("#minMonth").val(); 					   			 
	return txt; 
}
function getmaxMonth()                            
{
	var txt = $("#maxMonth").val(); 					   			 
	return txt; 
}

function getminAmount()                            
{
	var txt = $("#minAmount").val(); 					   			 
	return txt; 
}
function getmaxAmount()                            
{
	var txt = $("#maxAmount").val(); 					   			 
	return txt; 
}



 
</g:javascript>