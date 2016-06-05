<g:set var="applyLoanRequest" value="${applyLoanRequest}" />
<div id="loaneligibility">             
        <g:form name="frmLookUpType">
<table width="100%" class="grid">
                <tr>
                <td width="50%"></td>
                <td width="20%"></td>
                                  </tr>
                <tr>

                <td>
                <label>Amount</label>
                <div id="amount"></div>
                </td>
                <td>
                  <label>&nbsp;</label>
                <input type="text" name="amount" id="amount_val" style="border:0; color:#f6931f; font-weight:bold;" onchange='showpay()'></td>
                 </tr>


                     <tr>

                <td>
                <label>Interest %</label>
                <div id="interest"></div>
                </td>
                <td>
                  <label>&nbsp;</label>
                <input type="text"  name ="interestrate" id="interest_val" style="border:0; color:#f6931f; font-weight:bold;" onchange='showpay()'></td>
                 </tr>


                 <tr>

                <td>
                <label>Time</label>
                <div id="time"></div>
                </td>
                <td>
                  <label>&nbsp;</label>
                <input type="text"  name="time" id="time_val" style="border:0; color:#f6931f; font-weight:bold;" onchange='showpay()'></td>
                 </tr>
                 
                 <tr>

                <td>
                <label>EMI Amount</label>
                </td>
                <td>
                  <label>&nbsp;</label>
                <input type="text"  name="emiamount"  id="emiamount" value="" style="border:0; color:#f6931f; font-weight:bold;"></td>
                 </tr>

             



                </table>
				<div class="buttons" align="right">
		<g:submitToRemote action="saveloneeligibility" controller="applyLoan" 
		 value="Apply Now" 
		  before="if (!isFormValid()){return false;}"
		 update="[failure:'messagesDiv',success:'applicationStatus']"
		onSuccess="updateFormData(data,textStatus)" />
		</div>
		<div id="divlookupType">
		</div>  
		
	
		
    </g:form>
    </div>   
    
    <script >
    
    function updateFormData(data,textStatus){
    //alert("data"+data)  
      
		$( ".applyloan" ).tabs({disabled: [0,1,2]},{selected:3} );
		
		}
     function showpay() {

    
        
     if (($("#amount_val").val() == null || $("#amount_val").val() == 0) ||
         ($("#time_val").val()== null || $("#time_val").val() == 0)
    ||
         ($("#interest_val").val()== null || $("#interest_val").val() == 0))
     { $("#emiamount").val("NaN");
     }
     else
     {
     
    	var princ = $("#amount_val").val();
        var term  = $("#time_val").val();
        var intr   = $("#interest_val").val() / 1200;
        
        $("#emiamount").val(princ * intr / (1 - (Math.pow(1/(1 + intr), term))));
     }

    // payment = principle * monthly interest/(1 - (1/(1+MonthlyInterest)*Months))

    }

    </script>
