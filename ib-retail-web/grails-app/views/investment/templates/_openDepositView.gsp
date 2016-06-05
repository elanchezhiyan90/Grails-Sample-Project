<%@page import="com.vayana.bm.core.api.model.enums.YesNoEnum"%>
<table border="0" cellspacing="0" cellpadding="0">
	<tbody>				
	
		<tr>
			
				<td>
                    Debit From
                </td>
                <td>
                   ${resp?.depositServiceRequest?.payerInstruction?.accountNumber}
                </td>
         
		</tr>
		<tr>
					 <td>Currency</td>
               
                   
                    <td>${resp?.depositServiceRequest?.currency?.code}</td>
       </tr>
	
		
		
		<tr>
					 <td>Amount</td>
               
                    
                    <td>${resp?.depositServiceRequest?.amount}</td>
      </tr>
	
	
	
		
<%--		<tr>--%>
<%--					 <td>Tenure</td>--%>
<%--               --%>
<%--                   --%>
<%--                    <td>${resp?.depositServiceRequest?.depositTenure?.tenure}</td>--%>
<%--        </tr>--%>
<%--	--%>
	
	
		<tr>
					 <td>Month</td>
                   
                    <td>${resp?.depositServiceRequest?.months}</td>
        </tr>
        
		<tr>
					 <td>Days</td>
                   
                    <td>${resp?.depositServiceRequest?.days}</td>
        </tr>
		
		<tr>
					 <td>Deposit Type</td>
                   
                    <td>${resp?.depositServiceRequest?.depositType?.description}</td>
        </tr>
	
		 <g:if test="${resp?.depositServiceRequest?.depositType?.code.equals("OTH")}">
         
           <tr>
					 <td>Others</td>
                   
                    <td>${resp?.depositServiceRequest?.remarks}</td>
           </tr>
	  
         </g:if>
		
		<tr>
					 <td>Interest Payable Mode</td>
                   
                    <td>${resp?.depositServiceRequest?.interestPayoutId?.description}</td>
        </tr>
	
		  <tr>
					 <td>Interest Payable</td>
                   
                    <td>${resp?.depositServiceRequest?.maturityInstructionId?.description}</td>
        </tr>
  		 <tr>
					 <td> Nomination Facility</td>
                    <g:if test="${resp?.depositServiceRequest?.nomineeRequiredType.equals(YesNoEnum.Y)}">
                     <td>YES</td>
                    </g:if>
                    <g:if test="${resp?.depositServiceRequest?.nomineeRequiredType.equals(YesNoEnum.N)}">
                     <td>NO</td>
                    </g:if>
                   
        </tr>
        <g:if test="${resp?.depositServiceRequest?.nomineeRequiredType.equals(YesNoEnum.Y)}">
  			<tr>
					 <td> Nominee Name</td>
                  
                     <td>${resp?.depositServiceRequest?.nomineeeName}</td>
                   
        	</tr>
        </g:if>
	
		
		<tr>
					 <td>Branch</td>
               
                   
                    <td>${resp?.depositServiceRequest?.tenantBranch?.description}</td>
        </tr>
	
	
	
		
<%--		<tr>--%>
<%--					 <td>Investment Type</td>--%>
<%--               --%>
<%--                   --%>
<%--                    <td><g:message code="investment.templates.investconfirm.maturitytpe.${resp?.depositServiceRequest?.maturityId?.description}"/></td>--%>
<%--        </tr>--%>
	
	
		
       <g:if test="${(resp?.depositServiceRequest?.depositStartDate!=null)}"> 
			<tr>	
				<td>Start Date</td>
			
					<td><vayana:formatDate date="${resp?.depositServiceRequest?.depositStartDate}" showTime="false" /></td>
			</tr>
		</g:if>
		<g:if test="${(resp?.depositServiceRequest?.frequency?.description!=null)}"> 	
			<tr>
				<td>Frequency</td>
		
				<td>${resp?.depositServiceRequest?.frequency?.description}</td>
				
			</tr>
		</g:if>
			
		<g:if test="${(resp?.depositServiceRequest?.tenureId?.code!=null)}"> 	
			<tr>
				<td>noOfTimes</td>
		
				<td>${resp?.depositServiceRequest?.tenureId?.code}</td>
				
			</tr>
		</g:if>
				
		
		<tr>
			<td>
		    	Reference No
			</td>
			<td>
		   		 ${resp?.depositServiceRequest?.ibReferenceNo}
			</td>
		</tr>
	
	</tbody>
</table>

         








			
     
				
			

