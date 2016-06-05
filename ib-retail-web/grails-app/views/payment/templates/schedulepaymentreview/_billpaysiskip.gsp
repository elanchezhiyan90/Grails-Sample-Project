  <vayana:pager controller="payment" action="viewskippedsipage" update="mainContent"/>
 <!-- Sticky header starts here ----------->
                <div class="start-stick_top"></div>
                   <div class="grid_stickyhead_top">
                   
                    <table border="0" cellpadding="0" cellspacing="0" class="grid_theader" >
                       <thead>
                        <tr>
	                        <th width="5%">&nbsp;</th>	                           
	                        <th width="10%">${message(code:'biller.templates.schedulepaymentreview.billpaysipending.date.label') }</th>
                            <th width="15%">${message(code:'biller.templates.schedulepaymentreview.billpaysipending.nickname.label') }</th>
                            <th width="20%">${message(code:'biller.templates.schedulepaymentreview.billpaysipending.debitaccount.label') }</th>
                            <th width="20%">${message(code:'biller.templates.schedulepaymentreview.billpaysipending.serviceno.label') }</th>
                            <th width="20%">${message(code:'biller.templates.schedulepaymentreview.billpaysipending.ibreferenceno.label') }</th>
                            <th width="10%" class="amt">${message(code:'biller.templates.schedulepaymentreview.billpaysipending.amount.label') }</th>                        
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
                       <g:if test="${!siViewAndUpdateModel?.paymentScheduleDetails?.isEmpty()}"> 
                       <g:each in="${siViewAndUpdateModel?.paymentScheduleDetails}" var="paymentScheduleDetails" >
	                  		<tr>
	                            <td></td>	                                
	                             <td><vayana:formatDate date="${paymentScheduleDetails?.paymentDate}"/></td>                   
	                            <td>${paymentScheduleDetails?.payeeInstruction?.shortName}</td>
	                            <td><vayana:formatAccount
										currency="${paymentScheduleDetails?.payerInstruction?.currency?.code}"
										accountno="${paymentScheduleDetails?.payerInstruction?.accountNumber}" /></td>																
								<td><vayana:formatAccount
										currency="${paymentScheduleDetails?.payeeInstruction?.billerData[0]?.billerMetadata?.dataLabel?.description}"
										accountno="${paymentScheduleDetails?.payeeInstruction?.billerData[0]?.dataVarcharValue}" /></td>
																		
								 <td>${paymentScheduleDetails?.referenceTag}</td>
								 <td class="amt">
									 <g:if test="${paymentScheduleDetails?.paymentAmount <= 0}">
									 	${message(code:'biller.templates.schedulepaymentreview.billpaysipending.billpending.label') }
									 </g:if>
									 <g:else>
			                            <vayana:formatAmount
												currency="${paymentScheduleDetails?.paymentCurrency?.code}"
												amount="${paymentScheduleDetails?.paymentAmount}" /> ${paymentScheduleDetails?.paymentCurrency?.code}
									 </g:else>
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
	                      ${message(code:'biller.templates.schedulepaymentreview.billpaysipending.notransactionfound.label')}
	                      </td>
                      </tr>
                      </g:else>                                                                                      
                      </tbody> 
                       <vayana:pagerModel/>   
                    </table>                                         
 <g:if test="${!siViewAndUpdateModel?.paymentScheduleDetails?.isEmpty()}">                   
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