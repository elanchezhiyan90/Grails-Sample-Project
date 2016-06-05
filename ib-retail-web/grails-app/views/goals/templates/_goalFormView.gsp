<!-- saved from url=(0022)http://internet.e-mail -->

<div class="body-scroll">
<section>

<g:form name="goalstatus">
<div id="applicationStatus">

<ul class="payment_dtls">
    	 <%--<li><p class="hdr">Goal Confirmation</p></li>
    
        --%><li>
        	<div class="dtl_wralp">

            <table class="dtl_view">
           <tr>
             <td>Goal Name</td>


            <td>${goalModelconfirm?.code}</td>
            </tr>

            <tr>
            <td>Target Amount </td>
           <td><span class="cur">(${goalModelconfirm?.targetCurrency?.code})</span><span class=""><vayana:formatAmount currency="${goalModelconfirm?.targetCurrency?.code}" amount="${goalModelconfirm?.targetAmount}"></vayana:formatAmount></span></td>
           
            </tr>
            
            <tr>
            <td>Achieved By </td>
            <td>${goalModelconfirm?.targetDate?.format("dd-MMM-yyyy")}</td>
            </tr>

             <tr>
            <td>  Contribute </td>
            <td>${goalModelconfirm?.frequency?.code}</td>
            </tr>

            <tr>
            <td>Fund  From </td>
            <td>${goalModelconfirm?.payerInstruction?.accountNumber}  ( ${goalModelconfirm?.payerInstruction?.currency?.code})</td>
     
            </tr>

             <tr>
            <td> Saving Amount </td>
            <td><span class="cur">(${goalModelconfirm?.targetCurrency?.code})</span><span class=""><vayana:formatAmount currency="${goalModelconfirm?.targetCurrency?.code}" amount="${goalModelconfirm?.contributionAmount}"></vayana:formatAmount></span></td>
      
            </tr>
          
             <tr>
            <td> Share With </td>
         
            <td>${goalModelconfirm?.userGoalDetails?.collect{it.userLoginProfile.userLogin}?.join(",")}</td>
            </tr>
 </table></div></li>
 

 
    </g:form>
</section>


    </div>



