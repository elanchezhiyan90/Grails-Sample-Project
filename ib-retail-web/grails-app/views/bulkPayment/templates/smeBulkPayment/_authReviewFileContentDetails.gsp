<table border="0" cellpadding="0" cellspacing="0" class="grid">
	<thead class="grid_theader">
		<tr>
			<%--  <th width="2%"><g:checkBox name="checkAll" id="checkAll" value="${datelineRef}" checked="false" /></th> --%>
			<%--<th width="5%">S.No</th>
			--%><th width="8%">Employee No</th>
			<th width="20%">Beneficiary Name</th>
			<th width="15%">Account Number</th>
			<th width="5%">Currency</th>
			<th width="10%">Amount</th>
			<th width="10%">Value Date</th>
			<th width="5%">IFSC Code</th>
			<th width="10%">Bank Name</th>
			<th width="5%">Authorized By</th>
			<th width="10%">Bank Narration</th>
			<th width="5%">Status</th>
		</tr>		
		</thead>
		<tbody>
			<tr>
				<%--<td></td>--%>
				<%--<td></td>--%>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>			
			<g:if test="${bulkpaymentDetails}">
				<g:each in="${bulkpaymentDetails}" var="bulkPaymentdtl" status="index">
					<tr>
						<%--<td>
						<g:if test="${LookupCodeConstants.PENDING_AUTH.equals(bulkPaymentdtl?.status?.code)}">
								<g:checkBox name="chkForProcess" id="${bulkPaymentdtl?.id}" value="${bulkPaymentdtl?.id}" checked="false" />
							</g:if>
							<g:else>
								  Dont diplay Check Box 
								 <g:checkBox name="chkForProcess" id="${bulkPaymentdtl?.id}" value="${bulkPaymentdtl?.id}" checked="false" disabled="disabled" />
						</g:else>
						</td>--%>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-002')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-002')}">${bulkPaymentdtl?.beneficiaryReferenceNumber}</b>
							</g:if>
							<g:elseif test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-012')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-012')}">${bulkPaymentdtl?.beneficiaryReferenceNumber}</b>
							</g:elseif>
							<g:else>${bulkPaymentdtl?.beneficiaryReferenceNumber}</g:else>
						</td>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-001')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-001')}">${bulkPaymentdtl?.beneficiaryName}</b>
							</g:if>
							<g:elseif test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-013')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-013')}">${bulkPaymentdtl?.beneficiaryName}</b>
							</g:elseif>
							<g:else>${bulkPaymentdtl?.beneficiaryName}</g:else>
						</td>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-003')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-003')}">${bulkPaymentdtl?.beneficiaryAccountNumber}</b>
							</g:if>
							<g:elseif test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-014')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-014')}">${bulkPaymentdtl?.beneficiaryAccountNumber}</b>
							</g:elseif>
							<g:else>${bulkPaymentdtl?.beneficiaryAccountNumber}</g:else>
						</td>
						<td>${bulkPaymentdtl?.paymentCurrency?.code}</td>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-009')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-009')}"><vayana:formatAmount currency="${bulkPaymentdtl?.paymentCurrency?.code}" amount="${bulkPaymentdtl?.paymentAmount}"></vayana:formatAmount></b>
							</g:if>
							<g:else><vayana:formatAmount currency="${bulkPaymentdtl?.paymentCurrency?.code}" amount="${bulkPaymentdtl?.paymentAmount}"></vayana:formatAmount></g:else>
						</td>
						<td><vayana:formatDate date="${bulkPaymentdtl?.valueDate}" showTime="false" /></td>
						<td>
							<g:if test="${bulkPaymentdtl?.remarks?.contains('BLK-ERR-007')}">
								<b style="color:red" title="${g.message(code:'BLK-ERR-007')}">${bulkPaymentdtl?.electronicClearingCode}</b>
							</g:if>
							<g:else>${bulkPaymentdtl?.electronicClearingCode}</g:else>
						</td>
						<td>${bulkPaymentdtl?.bankName}</td>
						<td>${bulkPaymentdtl?.finalAuthUser?.userLogin}</td>
						<td>${bulkPaymentdtl?.bankNarration}</td>	
						<td>
						<g:if test="${'FAILURE'.equals(bulkPaymentdtl?.status?.code) && !(['BLK-ERR-002','BLK-ERR-001','BLK-ERR-003','BLK-ERR-009','BLK-ERR-007'].contains(bulkPaymentdtl?.remarks))}">
							<b style="color:red" title="${bulkPaymentdtl?.remarks}">${bulkPaymentdtl?.status?.description}</b>
						</g:if>
						<g:else>
							${bulkPaymentdtl?.status?.description}
						</g:else>
						</td>
					</tr>				
				</g:each>
			</g:if>	
			<g:else>
			<tr>
				<%--<td>&nbsp;</td>
				<%--<td>&nbsp;</td>
				--%>
				<td>&nbsp;</td>
				<td>&nbsp;No Record(s) Found</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			</g:else>		
		</tbody>
		<vayana:pagerModel></vayana:pagerModel>	  
	</table>
	

   