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
                      	<vayana:pagerModel/>                                                                                         
                      </tbody> 
                   