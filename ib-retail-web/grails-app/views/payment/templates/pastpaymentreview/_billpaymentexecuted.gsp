  <vayana:pager controller="payment" action="viewexecutedpaymentpage" update="mainContent"/>
 <!-- Sticky header starts here ----------->
                <div class="start-stick_top"></div>
                   <div class="grid_stickyhead_top">
                   
                    <table border="0" cellpadding="0" cellspacing="0" class="grid_theader" >
                       <thead>
                        <tr>
	                        <th width="5%">&nbsp;</th>	                           
	                        <th width="10%">Date</th>
                            <th width="15%">Nick Name</th>
                            <th width="20%">Debit Account</th>
                            <th width="20%">Service No</th>
                            <th width="20%">Core Reference Number</th>
                            <th width="10%" class="amt">Amount</th>                        
                        </tr>
                        </thead>
                    </table>
                   	</div>
                    <!-- Sticky header ends here ----------->
            <table cellspacing="0" cellpadding="0" border="0" class="grid" id="mainContent">
                
                        <tbody>
                        <tr>
                            <td width="5%"></td>                           
                            <td width="10%"></td>
                            <td width="15%"></td>
                            <td width="20%"></td>
                            <td width="20%"></td>
                            <td width="20%"></td>
                            <td width="10%" class="amt"></td>  
                        </tr>
                        <g:if test="${!pastPaymentReviewModel?.paymentDetails?.isEmpty()}">
                        <g:each in="${pastPaymentReviewModel?.paymentDetails}" var="paymentDetails" >	                        
	                        <tr>
	                            <td> </td>	                                   
	                             <td><vayana:formatDate date="${paymentDetails?.paymentDate}"/></td>                   
	                            <td>${paymentDetails?.payeeInstruction?.shortName}</td>
	                            <td><vayana:formatAccount
										currency="${paymentDetails?.payerInstruction?.currency?.code}"
										accountno="${paymentDetails?.payerInstruction?.accountNumber}" /></td>
								
								<td><vayana:formatAccount
										currency="${paymentDetails?.payeeInstruction?.billerData[0]?.billerMetadata?.dataLabel?.description}"
										accountno="${paymentDetails?.payeeInstruction?.billerData[0]?.dataVarcharValue}" /></td>
								
	                            <td>${paymentDetails?.coreReferenceId}</td>
	                            <td class="amt">
	                            <vayana:formatAmount
										currency="${paymentDetails?.paymentCurrency?.code}"
										amount="${paymentDetails?.paymentAmount}" /> ${paymentDetails?.paymentCurrency?.code}
								</td>	    									                                         
	                        </tr>                         
                      </g:each>   
                      </g:if>
                     <g:else>
                      <tr>
                      	   <td></td>
                      	   <td></td>
                      	   <td></td>
                      	   <td></td>
	                      <td align="center">
	                      No Transaction Found
	                      </td>
                      </tr>
                      </g:else>                                                                                    
                      </tbody> 
                       <vayana:pagerModel/>   
                    </table>
 <g:if test="${!pastPaymentReviewModel?.paymentDetails?.isEmpty()}">
  <script>
  $(function(){
	  $(".previous")
		.button({
	   text: false,
	   icons: { primary: "ui-icon-triangle-1-w"}
	 	})
		.click(function() {
	          $(".pagenum").removeClass("form-ui-invalid")
	   })
	.next()
	.button({
	   text: false,
	   icons: { primary: "ui-icon-triangle-1-e"}
	 	}).click(function(){
	 		 $(".pagenum").removeClass("form-ui-invalid")
			}).parent()
	               .buttonset();
		
	$(".gobtn").button({
		text: false,
	   icons: { primary: "ui-icon-arrowreturnthick-1-e"}
	})
	
	 $(".pagenum").blur(function(){
		 var value=$(this).val();
		 var maxm=$(this).attr("max");
		 if(value>maxm){
		 $(this).addClass("form-ui-invalid")
		 }
	 });
		 
	pagerSuccess();
	 
});
  </script>
</g:if>