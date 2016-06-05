<%@page import="com.vayana.bm.core.api.model.enums.YesNoEnum"%>
<g:set var="goals" value="${goalEditModel}" />
<g:hiddenField name="totalPaidAmount" id="totalPaidAmount" value="${goals?.totalPaidAmt}" />
<g:hiddenField name="fdAcctNum" id="fdAcctNum" value="${goals?.toAccountNumber}" />
<vayana:popupMessages></vayana:popupMessages>
<g:form name="frmLookUpType">
	<div id="divlookupType">
		<g:hiddenField name="version" value="${goals?.version}" />
		<g:hiddenField name="processInstanceId"
			value="${goals?.processInstanceId}" />
		<g:hiddenField name="goalId" id="goalId"  value="${goals?.id}" />
		<g:hiddenField name="oldTargetAmount" id="oldTargetAmount"  value="${goals?.targetAmount}" />
			
	
		
		
		<g:hiddenField name="entityId" value="${goals?.id}" />
		<g:set var="targetDatevers" value="${goals?.targetDate}" />
		<div class="col-370">
			<!--Col Starts Here-->
			<div class="fields">
				<g:if test="${goals?.userGoalDetails}">
					<p>
						<label for="srequst"> ${message(code:'goals.template.goalname.label')}</label>
						<input type="text" placeholder="" id="goalName" name="goalName"
							class="" required="required"
							data-errormessage="Please select value"
							title="Please Enter the Value" value="${goals?.code}" readonly>
					</p>
			</div>
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.targetamount.label')}</label>
					<vayana:tenantBaseCurrencySelect name="tenantBaseCurrencySelect"
						id="targetCurrency" name="targetCurrency" class="cur"
						required="required" data-errormessage="Please select value"
						value="${goals?.targetCurrency}" />
					<input type="number" placeholder="" class="s_amt"  id="targetAmount"
						required="required" data-errormessage="Please Select greater than TargetAmount"
						name="targetAmount" title="Please Enter the Value" 
						value="${goals?.targetAmount}" readonly>
				</p>
			</div>
			
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.startdate.label')}</label>
					<vayana:vayanaDate id="startDate" required="required"
						data-errormessage="Please select value" name="startDate"
						value="${goals?.startDate}" />
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.achievedby.label')}</label>
					<vayana:vayanaDate id="targetDate" required="required"
						data-errormessage="Please select value" name="targetDate"
						value="${goals?.targetDate}" />
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.contribute.label')}</label>
					<vayana:tenantLookupSelect optionValue="description"
						name="frequency" type="SI_FREQUENCY_TYPE" id="frequency"
						required="required" data-errormessage="Please select value"
						value="${goals?.frequency?.idVersion}" />
				</p>
			</div>
			${goals?.frequency}
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.fundfrom.label')}</label>
					<vayana:fromAccountSelect id="payerInstruction"
						name="payerInstruction" type="FF" poptype="CASA"
						noSelection="${['Select Payer Account':'Select Payer Account']}"
						required="required" data-errormessage=" Please select value" />
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.savingsamout.label')}</label>

					<vayana:tenantBaseCurrencySelect name="tenantBaseCurrencySelect"
						id="targetCurrency" name="targetCurrency" class="cur"
						required="required" data-errormessage="Please select value"
						value="${goals?.targetCurrency}" />
					<input type="number" placeholder="" class="s_amt"
						id="contributionAmount" required="required"
						data-errormessage="Please select value" name="contributionAmount"
						title="Please Enter the Value"
						value="${goals?.contributionAmount}">
				</p>
			</div>
			<br /> <br />
			</g:if>
			<g:else>
				<p>
					<label for="srequst"> ${message(code:'goals.template.goalname.label')}</label>
					<input type="text" placeholder="" id="goalName" name="goalName"
						class="" required="required"
						data-errormessage="Please select value"
						title="Please Enter the Value" value="${goals?.code}"  >
				</p>
		</div>


		<div class="fields">
			<p>
				<label for="srequst"> ${message(code:'goals.template.targetamount.label')}</label>
				<vayana:tenantBaseCurrencySelect name="tenantBaseCurrencySelect" readonly="true"
					id="targetCurrency" name="targetCurrency" class="cur"
					required="required" 
					value="${goals?.targetCurrency}"  />
				<input type="text" placeholder="" class="s_amt" id="targetAmount" min="${goals?.targetAmount}"  onchange="fetchEditAutoPopulateAmount()"
					required="required" data-errormessage="Please enter numeric values and amount should be greater than targetamount" pattern ="^[.0-9]*$" maxlength="16" 
					name="targetAmount" title="Please Enter the Value"
					value="${goals?.targetAmount}"  >
			</p>
		</div>
		<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.startdate.label')}</label>
					<input type="date" id="startDate" required="required" onchange="fetchEditAutoPopulateAmount()"
						data-errormessage="Please select value" name="startDate"
						value="${goals?.startDate?.format("yyyy-MM-dd")}" readonly="readonly"  disabled="disabled" />
						
						<%--<input type="text" placeholder="" id="startDate" name="startDate"
							class="" required="required"
							data-errormessage="Please select value"
							title="Please Enter the Value" value="${goals?.startDate.format("dd-MM-yyyy")}" readonly>
				--%></p>
			</div>

		<div class="fields">
			<p>
				<label for="srequst"> ${message(code:'goals.template.achievedby.label')}</label>
				<input type="date"  id="targetDate" required="required" onchange="fetchEditAutoPopulateAmount()"
					data-errormessage="Achieved by date cannot be less than the start date" name="targetDate" data-dependent-validation='{"from":"startDate", "prop": "min"}'
					value="${goals?.targetDate?.format("yyyy-MM-dd")}" class="effectiveFromDate"
					min="${goals?.targetDate}"  maxlength="10" />
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="srequst"> ${message(code:'goals.template.contribute.label')}</label>
				<vayana:tenantLookupSelect optionValue="description" onchange="fetchEditAutoPopulateAmount()"
					name="frequency" type="SI_FREQUENCY_TYPE" id="frequency"
					required="required" data-errormessage="Please select value"
					value="${goals?.frequency?.idVersion}" />
			</p>
		</div>
	

		<div class="fields">
			<p>
				<label for="srequst"> ${message(code:'goals.template.fundfrom.label')}</label>
				<vayana:fromAccountSelect id="payerInstruction"
					name="payerInstruction" type="FF" poptype="CASA"
					noSelection="${['Select Payer Account':'Select Payer Account']}"
					required="required" data-errormessage=" Please select value"  />
			</p>
		</div>


		<div class="fields">
			<p>
				<label for="srequst"> ${message(code:'goals.template.savingsamout.label')}</label>

				<vayana:tenantBaseCurrencySelect id="savingCurrency"
					name="savingCurrency" class="cur" required="required"
					data-errormessage="Please select value"
					value="${goals?.targetCurrency}" />
				<input type="text" placeholder="" class="s_amt"
					id="contributionAmount" required="required" 
					data-errormessage="Please select value" name="contributionAmount"
					title="Please Enter the Value" value="${goals?.contributionAmount}">
			</p>
		</div>
		
		
		<div class="fields">
				
					<p>
						<label for="srequst"> ${message(code:'goals.template.remarks.label')}</label>
						<input type="text" placeholder="" id="remarks" name="remarks"
							class="" 
							data-errormessage="Please select value"
							title="Please Enter the Value" value="${goals?.remarks}" >
					</p>
			</div>
		<br /> <br />

		</g:else>
		<div class="buttons">

			<input type="button" value="Cancel" name="cancelTxn"
				onClick="$.fn.ceebox.closebox();" class="btn_next">
				<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'NEW_GOAL_REQUEST',userActionLabel:'MODIFY')}" >
			<g:if test="${isToSupend.equals(YesNoEnum.Y)}">
				<vayana:submitToRemote action="suspendConfirmGoal" controller="goal"
					value="Supend" before="if (!isFormValid()){return false;}"
					update="[failure:'popupMessagesDiv',success:'divlookupType']"
					onSuccess="updateFormData2(data,textStatus)" />
			</g:if>
			<g:else>
				<%--<vayana:submitToRemote action="resumeConfirmGoal" controller="goal"
					value="Resume" before="if (!isFormValid()){return false;}"
					update="[failure:'popupMessagesDiv',success:'divlookupType']"
					onSuccess="updateFormData2(data,textStatus)" />
			--%></g:else>
          
			<vayana:submitToRemote action="editconfirmGoal" controller="goal"
				value="Update" before="if (!isFormValid()){return false;}"
				update="[failure:'popupMessagesDiv',success:'divlookupType']"
				onSuccess="updateFormData1(data,textStatus)" />
				</vayana:fap>

		</div>
	</div>
	</div>
	<!--Col Ends Here-->

</g:form>
<script>
$(".fields").dynamicfieldupdate();


var selVal = $("#payerInstruction option").each(function()
			{
			
				var passVal = $(this).val()	;	
				var thisVar = $(this);	
				passVal=passVal.split(',');			
			
				if(${goals?.payerInstruction?.id} == passVal[0])
				{	
				
					$(thisVar).val(passVal).attr("selected","selected") ;		
					var sel=$(thisVar).val(passVal).text();
				
					$(thisVar).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(sel);
					$(thisVar).parents("select").trigger("change");
				
				}
			});
			
			
function isFormValid(){

	if($('#frmLookUpType').checkValidity()){ 
	     $("#startDate").removeAttr('disabled');
	      return true;   
	   
	}else{
		   return false;
		
	}
} 
 $( "#datepicker" ).datepicker();
 
function updateFormData1(data,textStatus){
$("#divlookupType").dynamicfieldupdate();
}
function updateFormData2(data,textStatus){
$("#divlookupType").dynamicfieldupdate();
}

function ontransactionTypeSuccess(data,textStatus){


var corebal =  $(data).filter('#editPopulatedAmount').val();
$("#contributionAmount").val(corebal);

}

function fetchEditAutoPopulateAmount(){

	<g:remoteFunction controller="goal" action="getEditAutoPopulateAmount" 
			 before="if (!checkValues()){return false;}"
			params="{'targetAmount':getTargetAmount(),'startDate':getStartDate(),'targetDate':getEndDate(),'frequency':getFrequency(),'goalId':getGoalId(),'totalPaidAmount':getTotalPaidAmt(),'fdAcctNum':getFDActNumber()}"
			onSuccess="ontransactionTypeSuccess(data,textStatus);"  onFailure ="ontransactionTypeFailure();" />	
}
function checkValues(){

	var targetAmount = getTargetAmount();
	var startDate = getStartDate();
	var targetDate = getEndDate();
	var frequency = getFrequency();
	var oldTargetAmount =  $("#oldTargetAmount").val();
	if(targetAmount == "" || startDate =="" || targetDate == "" || frequency=="" || oldTargetAmount > targetAmount){

	 return false;
	}
	return true;
}
function getOldTargetAmount(){
	var txt = $("#oldTargetAmount").val();
	return oldTargetAmount;
}


function getTargetAmount()                            
{
	var txt = $("#targetAmount").val(); 					   			 
	return txt; 
}

function getStartDate()                            
{
	var txt = $("#startDate").val(); 					   			 
	return txt; 
}

function getEndDate()                            
{
	var txt = $("#targetDate").val(); 					   			 
	return txt; 

}

function getFrequency()                            
{
	var txt = $("#frequency").val(); 					   			 
	return txt; 
}
function getGoalId()                            
{
	var txt = $("#goalId").val(); 					   			 
	return txt; 
}
function getTotalPaidAmt()                            
{
	var txt = $("#totalPaidAmount").val(); 					   			 
	return txt; 
}
function getFDActNumber()                            
{
	var txt = $("#fdAcctNum").val(); 					   			 
	return txt; 
}

</script>
