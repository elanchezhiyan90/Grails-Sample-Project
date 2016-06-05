<!-- saved from url=(0022)http://internet.e-mail -->

<div class="body-scroll">
<section>
<g:form name="loanStatus">
<div id="applicationStatus">

<ul class="payment_dtls">
    	 <li><p class="hdr">Property Details</p></li>
    	 
        <li>
        	<div class="dtl_wralp">

            <table class="dtl_view">
           <tr>
             <td>Purpose of loan</td>
            <td>${loanDetailModel?.loanpurpose?.description}</td>
            </tr>

            <tr>
            <td>Property Location </td>
            <td>${loanDetailModel?.propertycity?.description}</td>
           
            </tr>
            
            <tr>
            <td> Property Details </td>
            <td>${loanDetailModel?.propertydetail?.description}</td>
            </tr>

             <tr>
            <td>  Name of builder & project (optional)  </td>
            <td>${loanDetailModel?.buildername}</td>
            </tr>

            <tr>
            <td>Cost of home/flat  </td>
            <td><span class="cur">${loanDetailModel?.costcurrency?.code}</span>&nbsp;<span class="amt">${loanDetailModel?.homecost}</span></td>
            </tr>

             <tr>
            <td> Where do you live currently?  </td>
            <td>${loanDetailModel?.currentlocation?.description}</td>
            </tr>
  </table></div></li>
    <li><p class="hdr">Income Details</p></li>
        <li>
        <table class="dtl_view">
        <tr>
        <td>Type of Employment</td>
        <td>${loanDetailModel?.employmenttype?.description}</td>
        </tr>

          <tr>
        <td>Company Name</td>
        <td>${loanDetailModel?.companyname}</td>
        </tr>


          <tr>
        <td>Business Incorporation / Joining Date</td>
        <td>${loanDetailModel?.joiningdate}</td>
        </tr>


          <tr>
        <td>Gross Monthly Income</td>
        <td><span class="cur">${loanDetailModel?.grosscurrency?.code}</span>&nbsp;<span class="amt">${loanDetailModel?.grossmonthlyincome}</span></td>
        </tr>


          <tr>
        <td>Net Monthly Income</td>
        <td><span class="cur">${loanDetailModel?.netcurrency?.code}</span>&nbsp;<span class="amt">${loanDetailModel?.netmonthlyincome}</span></td>
        </tr>

          <tr>
        <td> Retirement Age </td>
        <td>${loanDetailModel?.retirementage}</td>
        </tr>

          <tr>
        <td> Current EMIs being paid </td>
        <td><span class="cur">${loanDetailModel?.emicurrency?.code}</span>&nbsp;<span class="amt">${loanDetailModel?.emiamount}</span></td>
        </tr>

        </table>    
                <li><p class="hdr">Loan Eligibility</p></li>
         <li>
         <table class="dtl_view">
         <tr>
         <td>Amount</td>
         <td><span class="amt">${loanDetailModel?.loanamount}</span></td>
         </tr>
          <tr>
         <td>Interest %</td>
         <td>${loanDetailModel?.interestpercentage}</td>
         </tr>
          <tr>
         <td>Time (years)</td>
         <td>${loanDetailModel?.durationperiod}</td>
         </tr>
          <tr>
         <td>EMI Amount</td>
         <td>${loanDetailModel?.emiamount}</td>
         </tr>
         </table>
        </li>

  
    

    </g:form>
</section>

    </div>



