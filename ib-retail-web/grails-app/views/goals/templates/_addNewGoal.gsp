<g:form name="frmLookUpType">
<vayana:popupMessages></vayana:popupMessages>
	<div id="divlookupType">
		<div class="col-370">
			<!--Col Starts Here-->
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.goalname.label')}</label>
					<input type="text" placeholder="" id="goalName" name="goalName"
						required="required" maxlength="20"
						data-errormessage="Please select value"
						title="Please Enter the Value"/>
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.targetamount.label')}</label>
					<vayana:tenantBaseCurrencySelect name="tenantBaseCurrencySelect"
						id="targetCurrency" name="targetCurrency" class="cur" 
						required="Y" data-errormessage="Please select value" />
					<input type="text" class="s_amt" id="targetAmount" pattern ="^[.0-9]*$"
						required="required" data-errormessage="Please enter numeric values" onchange="fetchAutoPopulateAmount()"
						name="targetAmount" title="Please Enter the Value" value="" maxlength="16" 
						required="required" data-errormessage="Please select value" >
				</p>
			</div>
			
			<div class="fields">
				<p>
					<label for="srequst">${message(code:'goals.template.startdate.label')}</label>
					<input type="date" id="startDate" required="required" onchange="fetchAutoPopulateAmount()"
						data-errormessage="Please select value" name="startDate"
						title="Please select value" class="effectiveFromDate" maxlength="10"
						min="${new Date().toTimestamp()}  " 
											
						/>
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.achievedby.label')}</label>
					<input type="date" id="targetDate" required="required" onchange="fetchAutoPopulateAmount()"
						data-errormessage="Achieved by date cannot be less than the start date" name="targetDate"
						title="Please select value" class="effectiveFromDate" data-dependent-validation='{"from":"startDate", "prop": "min"}'
						min="${new Date().plus(30).toTimestamp()} " maxlength="10"
						 />
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.contribute.label')}</label>
					<vayana:tenantLookupSelect optionValue="description"
						name="frequency" type="SI_FREQUENCY_TYPE" id="frequency" 
						onchange="fetchAutoPopulateAmount()" 
						required="required" data-errormessage="Please select value" ></vayana:tenantLookupSelect>
				</p>
			</div><%-- update:'contributionAmountDisplay',		
			--%><div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.fundfrom.label')}</label>
					<vayana:fromAccountSelect id="payerInstruction"
						name="payerInstruction" type="FF" poptype="CASA"
						noSelection="${['Select Payer Account':'Select Payer Account']}"
						onchange="preferredCurrency(this.text)" />
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="srequst"> ${message(code:'goals.template.savingsamout.label')}</label>
					<vayana:tenantBaseCurrencySelect id="savingCurrency"
						name="savingCurrency" class="cur" required="required"
						data-errormessage="Please select value" />
					<input type="text"  class="s_amt"
						id="contributionAmount" value="" readonly="readonly"
						data-errormessage="Please select value" name="contributionAmount"
						title="Please Enter the Value">
				   
				
				
				</p>
			</div>
			<div class="fields">
				<p>
					<label for="srequst">${message(code:'goals.template.remarks.label')}</label>
					<input type="text" placeholder="" id="remarks" name="remarks"
						
						data-errormessage="Please select value"
						title="Please Enter the Value"/>
				</p>
			</div>
			<br /> 
			<div class="buttons">
			<vayana:submitToRemote action="addNewGoalConfirm" controller="goal"
					value="Add" before="if (!isFormValid()){return false;}"
					update="[failure:'messagesDiv',success:'divlookupType']"
					onSuccess="updateFormData1(data,textStatus)" />

				<input type="button" value="Cancel" name="cancelTxn"
					onClick="$.fn.ceebox.closebox();" class="btn_next">
				

			</div>
		</div>
		<!--Col Ends Here-->


	</div>


</g:form>
<style>
.ui-autocomplete-loading {
background: white url('images/spinner.gif') right center no-repeat;
}
</style>
<script>
function preferredCurrency(param){
var test=$("#payerInstruction :selected").text();
var text1 = test.split("|")[1];
var currency = text1;
$("#savingCurrency option").each(function() {
		var curText = $(this).text();
		var curVal = $(this).val();	
		curVal=curVal.split(',');
		if(currency == curText)
		{			
			$(this).val(curVal).attr("selected","selected") ;		
			var currsel=$(this).val(curVal).text();		
			$(this).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(currsel);			
		}
	});
}



$(".fields").dynamicfieldupdate();
$( "#datepicker" ).datepicker();
function isFormValid(){

	if($('#frmLookUpType').checkValidity()){ 
	      return true;   
	      alert("true");
	}else{
		   return false;
		   //alert("false");
	}
} 
function updateFormData1(data,textStatus){

$("#divlookupType").dynamicfieldupdate();

}

function ontransactionTypeSuccess(data,textStatus){


var corebal =  $(data).filter('#populatedAmount').val();
$("#contributionAmount").val(corebal);
//$("#divlookupType").dynamicfieldupdate();
}
function fetchAutoPopulateAmount(){
	<g:remoteFunction controller="goal" action="getAutoPopulateAmount"  before="if (!checkValues()){return false;}"
			onSuccess = "onDeliveryMediaSuccess(data,textStatus)" 
			params="{'targetAmount':getTargetAmount(),'startDate':getStartDate(),'targetDate':getEndDate(),'frequency':getFrequency()}"
			onSuccess="ontransactionTypeSuccess(data,textStatus);"   />	
}
function checkValues(){
	var targetAmount = getTargetAmount();
	var startDate = getStartDate();
	var targetDate = getEndDate();
	var frequency = getFrequency();
	
var startDate = new Date($('#startDate').val());
var targetDate = new Date($('#targetDate').val());
	
	if(targetAmount == "" || startDate =="" || targetDate == "" || frequency==""){
	

	 return false;
	}
		
	
	return true;
	
}

function checkDates(){
	
	var startDate = getStartDate();
	var targetDate = getEndDate();
	
	if(targetAmount == "" || startDate =="" ||  targetDate > startDate){
	

	 return false;
	}
		
	
	return true;
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

</script>
