<g:set var="beneinstructions" value="${resp?.beneficiaryInstruction}"/>
<table border="0" cellpadding="0" cellspacing="0" class="dtl_view">
<tbody>
	<tr>
			<td>Payment Type</td>
			<td>
				 ${beneinstructions?.transactionSubType?.serviceApplication?.service?.description}        
			</td>
		</tr>
		<tr>
			<td>Payment Mode</td>
			<td>
				${beneinstructions?.transactionSubType?.serviceApplication?.service?.code}
			</td>
		</tr>
		<tr>
			<td>Beneficiary Nickname</td>
			<td>
				 ${beneinstructions?.shortName}
			</td>
		</tr>
	<g:if test="${beneinstructions?.accountType}">	
		<tr>
			<td>Beneficiary Account Type</td>
			<td>
				${beneinstructions?.accountType?.description}
			</td>
		</tr>
	</g:if>
	<g:if test="${beneinstructions?.accountNumber}">
		<tr>
			<td>Account Number</td>
			<td>
				 ${beneinstructions?.accountNumber}
			</td>
		</tr>
		<tr>
			<td>Confirmation Account/IBAN Number</td>
			<td>
				 ${beneinstructions?.accountNumber}
			</td>
		</tr>
		</g:if>
	<g:if test="${beneinstructions?.currency}">	
		<tr>
			<td>Account Currency</td>
			<td>
				 ${beneinstructions?.currency?.code}   
			</td>
		</tr>
	</g:if>
	<g:if test="${beneinstructions?.iban}">		
	<tr>
                    <td>MMID</td>        
              <td>
				  ${beneinstructions?.iban}   
			</td>
		</tr>
	</g:if>
	<g:if test="${beneinstructions?.mobileNumber}">		
	<tr>
               <td> Mobile Number</td>
               <td>${beneinstructions?.mobileNumber}</td>
     </tr>

	</g:if>	

	<g:if test="${beneinstructions?.aadharCardNumber}">		
	<tr>
                 <td>Aadhar Card Number</td>
                  <td>${beneinstructions?.aadharCardNumber}</td>
	</tr>
	</g:if>	
		
		<g:set var="bankType" value="${beneinstructions?.payeeBankBranch?.payeeBankType?.toString()}" />
		
		<g:if test="${bankType == 'DOMESTIC'}">
			<g:set var="bankDetails" value="${(com.vayana.ib.bm.core.api.model.payment.DomesticBank)beneinstructions?.payeeBankBranch}" />
			<tr>
			<td>Bank Code</td>
			<td>
				 ${bankDetails?.electronicClearingCode}
			</td>
			</tr>
			<tr>
			<td>Bank Name</td>
			<td>
				 ${bankDetails?.bankName}
			</td>
			</tr>
			<tr>
			<td>Branch Name</td>
			<td>
				 ${bankDetails?.branchName}
			</td>
			</tr>
			<tr>
			<td>Bank Address</td>
			<td>
				 ${bankDetails?.address1}
			</td>
		</tr>
		</g:if>
		<g:elseif test="${bankType == 'FOREIGN'}">
			<g:set var="bankDetails" value="${(com.vayana.ib.bm.core.api.model.payment.ForeignBank)beneinstructions?.payeeBankBranch}" />
		<tr>
		<td>Bank Code</td>
			<td>
				 ${bankDetails?.bankCode}
			</td>
			</tr>
			<tr>
			<td>Bank Name</td>
			<td>
				 ${bankDetails?.name1}
			</td>
			</tr>
			<tr>
			<td>Branch Name</td>
			<td>
				 ${bankDetails?.branch1}
			</td>
			</tr>
			<tr>
			<td>Bank Address</td>
			<td>
				 ${bankDetails?.address1}
			</td>
			</tr>
		</g:elseif>
<%--		<tr>--%>
<%--			<td>Limit Code</td>--%>
<%--			<td>--%>
<%--				 ${beneinstructions?.beneficiaryLimit?.limitDefinition?.code}--%>
<%--			</td>--%>
<%--		</tr>--%>
<%--		<tr>--%>
<%--			<td>Limit Description</td>--%>
<%--			<td>--%>
<%--				 ${beneinstructions?.beneficiaryLimit?.limitDefinition?.description}--%>
<%--			</td>--%>
<%--		</tr>--%>
		<tr>
			<td>Limit Currency</td>
			<td>
				 ${beneinstructions?.beneficiaryLimit?.limitDefinition?.currency?.code}
			</td>
		</tr>
		
		
		<tr>
			<td>Transaction Limit </td>
			<td>
				 ${beneinstructions?.beneficiaryLimit?.globalMaxAmount}
			</td>
		</tr>
		<tr>
			<td>Montly Limit</td>
			<td>
				 ${beneinstructions?.beneficiaryLimit?.globalMonthlyMaxAmount}
			</td>
		</tr>
		<tr>
			<td>Daily Limit</td>
			<td>
				 ${beneinstructions?.beneficiaryLimit?.globalDailyMaxAmount}
			</td>
		</tr>
		<tr>
			<td>From Date</td>
			<td>
				 ${beneinstructions?.beneficiaryLimit?.effectiveFromDate}
			</td>
		</tr>
		<tr>
			<td>To Date</td>
			<td>
				 ${beneinstructions?.beneficiaryLimit?.effectiveToDate}
			</td>
		</tr>
		
	

	</tbody>
	
</table>