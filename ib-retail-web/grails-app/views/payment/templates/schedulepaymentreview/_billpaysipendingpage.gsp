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
                        <g:each in="${siViewAndUpdateModel?.paymentScheduleDetails}" var="paymentScheduleDetails" >	                        
	                       <tr>
	                            <td><input type="radio" name="paySchId" id="" value="${paymentScheduleDetails?.id}" class="btn_next"/> </td>	                                
	                             <td><vayana:formatDate date="${paymentScheduleDetails?.paymentDate}"/></td>                   
	                            <td>${paymentScheduleDetails?.payeeInstruction?.shortName}</td>
	                            <td><vayana:formatAccount
										currency="${paymentScheduleDetails?.payerInstruction?.currency?.code}"
										accountno="${paymentScheduleDetails?.payerInstruction?.accountNumber}" /></td>
								<td><vayana:formatAccount
										currency="${paymentScheduleDetails?.payeeInstruction?.billerData[0]?.billerMetadata?.dataLabel?.description}"
										accountno="${paymentScheduleDetails?.payeeInstruction?.billerData[0]?.dataVarcharValue}" /></td>
								<%--
								<td><vayana:formatAccount
										currency="${paymentScheduleDetails?.payeeInstruction?.currency?.code}"
										accountno="${paymentScheduleDetails?.payeeInstruction?.accountNumber}" /></td>
										 --%>
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
                      	<vayana:pagerModel/>                                                                                         
                      </tbody> 
                   