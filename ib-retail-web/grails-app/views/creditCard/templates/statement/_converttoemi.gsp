<head>
	<meta name="layout" content="applayout"/>
	<parameter name="themeName" value="${params.themeName}" />
</head>
<section>

	<g:form  action="" name="frmConvertToEmi">

			<div class="fields">
				<p>
					<label for="from_account">Account Number</label>
						<vayana:fromAccountSelect  name="from_account" class="fromacc" id="fromacc"  type="OA" poptype="CC" data-errormessage="Please select an account" required="required" />
					<br> <span class="selected_des" id="fromAccSelect">You Selected:4283-XXXX-XXXX-3252</span>	
				</p>
			</div>
			<div class="fields">
						<p>
     							<label for="payeeName">Transaction Description</label>
     							<input type="text" value="Wordsworth Book Store" disabled name="payeeName" id="payeeName"  />                               
  						</p>  						
			</div>
				
				<div class="fields" id="currency">
					<p>
						<label for="amount">Transaction Amount</label>
                           	<vayana:vayanaSelect name="cur" id="cur" class="cur forex" type="code" 
                           	from="${transferCurrency}" 
                           	noSelection="${['Select':'Select']}" required="required"
                           	data-errormessage="Please select Currency" />  
							
						<input type="number" step="any" name="chequeAmount"
							id="chequeAmount" class="s_amt" min="1"
							data-errormessage="Please Enter Amount" value="179.80" />
					</p>

				</div>
                
				<div class="fields" id="currency">
					<p>
						<label for="amount">EMI Booking Amount</label>
                           	<vayana:vayanaSelect name="cur" id="cur" class="cur forex"  type="code"
                           		from="${transferCurrency}" required="required"
                           	 data-errormessage="Please select Currency" />
                            			
						<input type="number" step="any" name="chequeAmount"
							id="chequeAmount" class="s_amt" min="1" 
							data-errormessage="Please Enter Amount" />
					</p>
				</div>                

				<div class="fields">
					<p>
						<label for="amount">EMI Tenure</label>
                           	<select name="cur" id="cur" class="forex" data-errormessage="Please select Currency" >
                            	<option value="" selected>Select</option>
								<option value="2" >6 months</option>
								<option value="2" >12 months</option>
								<option value="2" >24 months</option>
								<option value="2" >36 months</option>
      							</select>		
					</p>
				</div>  
                
				<div class="fields">
					<p>
                    
					<label for="acknowledge"><input type="checkbox" id="acknowledge"/><span> I Agree to the bank's Terms and Conditions for the EMI Conversion offer!</span></label>
    				</p>
                </div>                  
                
					<div class="buttons" id="btns_paynow">
						<input type="submit" name="" value="Apply" id="paynow" />
						<input type="button" name="" value="Cancel"  id="later" class="btn_next" />
					</div>
                  
                     
				
					         
                      <!------------ schedular div starts here --------- -->
  </g:form>
</section>
<script>
$(document).ready(function () {
	if(!Modernizr.touch){
		$( "select" ).combobox({msg:true});
		$("form").updatePolyfill();//update polyfill on after ajax load.
	}
});
</script>
