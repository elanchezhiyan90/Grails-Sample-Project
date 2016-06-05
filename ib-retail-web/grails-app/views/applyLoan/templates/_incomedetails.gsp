<style>
input.s_amt,input[type="text"].s_amt,input[type="number"].s_amt{width:108px !important; text-align:right;padding-right:20px !important;}
</style>
<g:set var="applyLoanRequest" value="${applyLoanRequest}" />
  <div id="incomeDetails"> 
 <g:form name="frmLookUpTypeone">
            
    
        	<table width="100%" border="0"  cellpadding="10px" cellspacing="9" align="center" >

				<tr>
					<td>
						<div>

							<p>
								<label for="srequst"> ${message(code:'applyforloan.template.typeofemployment.label')}
								</label>

								<vayana:tenantLookupSelect optionValue="description"
									name="typeofemployment" type="EMPTYPE" id="typeofemployment" required="required"
									data-errormessage="Please select value"></vayana:tenantLookupSelect>
							</p>
						</div>
					</td>

					<td>
						<div>
							<p>
								<label for="amount"> ${message(code:'applyforloan.template.companyname.label')}
								</label> <input type="text" placeholder="" class="" required="required"
									data-errormessage="Please select value" id="companyname"
									name="companyname" title="Please select value" value="">
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div>

							<p>
								<label for="srequst"> ${message(code:'applyforloan.template.joiningdate.label')}
								</label>

								<%--<vayana:lastNmonthlist nMonth="45"
									name="typeofemployment"  id="typeofemployment"></vayana:lastNmonthlist>
							
							--%>
							<input type="text" placeholder="" class="" id="datepicker" required="required"
									data-errormessage="Please select value"
									name="joiningdate" title="Please select value" value="">
							</p>
						</div>
					</td>

					<td>
						<div>
							<p>
								<label for="amount"> ${message(code:'applyforloan.template.grossmonthlyincome.label')}
								</label>
								<vayana:tenantOpsCurrencySelect name="tenantApplicationCurrency" id="grossmonthlyincomecurrency" name="grossmonthlyincomecurrency"
									class="cur" required="required"
									data-errormessage="Please select value" />
								<input type="number" placeholder="" class="s_amt" id="grossmonthlyincome"
									required="required"
									data-errormessage="Please select value" name="grossmonthlyincome" title="Please select value" value="">
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div>

							<p>
								<label for="amount"> ${message(code:'applyforloan.template.netmonthlyincome.label')}
								</label>
								<vayana:tenantOpsCurrencySelect name="tenantApplicationCurrency" id="netmonthlyincomecurrency" name="netmonthlyincomecurrency"
									class="cur" required="required"
									data-errormessage="Please select value" />
								<input type="number" placeholder="" class="s_amt" id="netmonthlyincome"
								 required="required"
									data-errormessage="Please select value"	name="netmonthlyincome" title="Please select value" value="">
							</p>
						</div>
					</td>

					<td>
						<div>
							<p>
								<label for="amount"> ${message(code:'applyforloan.template.retirementage.label')}
								</label> <input type="text" placeholder="" class="" id="retirementage"
									required="required"
									data-errormessage="Please select value" name="retirementage" title="Please select value" value="">
							</p>
						</div>
					</td>
				</tr>
<tr>
					<td>
						<div>

							<p>
								<label for="amount"> ${message(code:'applyforloan.template.emicurrent.label')}
								</label>
								<vayana:tenantOpsCurrencySelect name="tenantApplicationCurrency"  id="currentemicurrency"
								name="currentemicurrency"	class="cur" required="required"
									data-errormessage="Please select value" />
								<input type="number" placeholder="" class="s_amt" id="currentemi"
									name="currentemi" required="required"
									data-errormessage="Please select value" title="Please select value" value="">
							</p>
							
						</div>
					</td>
					</tr>
			

</table>

				<div class="buttons" align="right">
		<g:submitToRemote action="saveincomedetails" controller="applyLoan" 
		 value="Next" 
		  before="if (!isFormValid()){return false;}"
		 update="[failure:'messagesDiv']"
		onSuccess="updateFormData2(data,textStatus)" />	
		
		</div>
		<div id="divlookupType">
		</div>  
		
     </g:form>	
		

    </div>
   
<script>

function isFormValid(){

	if($('#frmLookUpTypeone').checkValidity()){ 
	      return true;   
	      //alert("true");
	}else{
		   return false;
		   //alert("false");
	}
} 

function updateFormData2(data,textStatus){
//alert("data"+data)
$("#spinner").hide();

$( ".applyloan" ).tabs({disabled: [3]},{selected:2} );
$( ".loaneligibility" ).show();
$("#loaneligibility").dynamicfieldupdate();
}


</script>
 
