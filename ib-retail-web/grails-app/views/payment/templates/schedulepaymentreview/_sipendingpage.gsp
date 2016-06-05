                   <%@ page import="com.vayana.ib.bm.core.api.model.enums.PayeeTypeEnum"%>
                      <tbody>
                        <tr>
                            <td width="3%"></td>                           
                            <td width="20%"></td>
                            <td width="20%"></td>
                            <td width="20%"></td>                        
                            <td width="15%" class="amt"></td>
                            <td width="15%"></td>   
                            <td width="7%"></td>  
                       </tr>
                        <g:each in="${siViewAndUpdateModel?.paymentScheduleDetails}" var="paymentScheduleDetails" >	                        
	                       <tr>
	                            <td><input type="radio" name="paySchId" id="" value="${paymentScheduleDetails?.id}" class="btn_next"/> </td>	                                
	                                              
	                            <td>${paymentScheduleDetails?.payeeInstruction?.shortName}</td>
	                            <td><vayana:formatAccount
										currency="${paymentScheduleDetails?.payerInstruction?.currency?.code}"
										accountno="${paymentScheduleDetails?.payerInstruction?.accountNumber}" /></td>
								<td>
								${(PayeeTypeEnum?.BENE.equals(paymentScheduleDetails?.payeeInstruction?.payeeType)) ? vayana.formatFFAccountNumber(beneInsIdVer:paymentScheduleDetails?.payeeInstruction?.idVersion,displayCurrency:'NO') 
										: vayana.formatBPAccountNumber(billInsIdVer:paymentScheduleDetails?.payeeInstruction?.idVersion) }</td>
								
							<%--<vayana:formatAccount
										currency="${paymentScheduleDetails?.payeeInstruction?.currency?.code}"
										accountno="${paymentScheduleDetails?.payeeInstruction?.accountNumber}" /></td>
										 <td>${paymentScheduleDetails?.referenceTag}</td>	    
								--%><td class="amt">
	                            <vayana:formatAmount
										currency="${paymentScheduleDetails?.paymentCurrency?.code}"
										amount="${paymentScheduleDetails?.paymentAmount}" /> 
<%--										${paymentScheduleDetails?.paymentCurrency?.code}--%>
								</td>	
								<td><vayana:formatDate date="${paymentScheduleDetails?.paymentDate}"/></td>      
								<td>${paymentScheduleDetails?.status?.description}</td>                                       
	                        </tr> 
	                                             
                      </g:each>
                      	<vayana:pagerModel/>                                                                                         
                      </tbody> 
                   