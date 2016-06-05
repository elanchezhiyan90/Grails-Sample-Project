		<div class="start-stick_top"></div>
			<div class="grid_stickyhead_top">
				<table border="0" cellpadding="0" cellspacing="0"
					class="style_grid">
					<thead>
						<tr>
							<th width="20%" align="center">Account Number</th>
							<br />
							<br />
							<th width="20%" align="center">Account Type</th>
							<th width="30%" align="center">Nickname</th>
							<th width="20%" align="center">Sequence</th>
						</tr>
					</thead>
				</table>
			</div>

			<div id="updateNameSeq">
				<table border="0" cellpadding="0" cellspacing="0" class="style_grid" id="nicknamegrid">
					<tbody>
						<g:set var="userAccounts" value="${setnameseqrequest?.userAccounts}" />
						<g:if test="${userAccounts}">
							<g:set var="creditCardAccounts" value="${setnameseqrequest?.creditCardAccounts}" />
							<g:if test="${creditCardAccounts}">
								<g:each var="userAcc" in="${creditCardAccounts}">
									<tr>
										<td width="20%">
											${userAcc?.accountNumber}
											<g:hiddenField name="accountNumber" value="${userAcc?.accountNumber}" />
											<g:hiddenField name="userAccountAttributeId" value="${userAcc?.userAccountAttribute?.id}" />
											<g:hiddenField name="accountId" value="${userAcc?.id}" />
										</td>
										<td width="20%">
											${userAcc?.acctProduct?.productType?.description}
											<g:hiddenField name="accountType" value="${userAcc?.acctProduct?.productType?.code}" />	
										<td width="30%"><p>
												<g:textField name="nickname" id="nickname" value="${userAcc?.userAccountAttribute?.shortName}" required="required" data-errormessage="${g.message(code:"setnamesequence.nickname.error.message")}" />
											</p></td>
										
										<td width="20%">
											<vayana:sequenceNumber name="sequence" id="sequence" seqsize="${creditCardAccounts?.size()}" value="${userAcc?.userAccountAttribute?.valueOrder}" required="required" data-errormessage="${g.message(code:"setnamesequence.sequence.error.message")}"/>
										</td>
										
										<%--<td width="20%"><g:select name="sequence" id="sequence"
												from="${['0','1','2','3','4','5','6']}" keys="${0..6}" value="${userAcc?.userAccountAttribute?.valueOrder}"/></td>
	
									--%></tr>
	
								</g:each>
							</g:if>
						</g:if>
						<g:else>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="20%">&nbsp;</td>
								<td width="20%">No Records Found</td>
								<td width="30%">&nbsp;</td>
								<td width="10%">&nbsp;</td>
								<td width="10%">&nbsp;</td>
							</tr>
						</g:else>


					</tbody>
				</table>
				<div class="buttons" id="button">				
					<vayana:submitToRemote value="${message(code:'userprofile.template.changesecureaccess.submit.button.text')}"
					   action="updatenamesequence" controller="userProfile"
					   id="verifySubmit" name="verifySubmit"						
					   before="getRowCount();if (checkFormValidity()) {return false;}"
					   update="[failure:'messagesDiv',success:'messagesDiv']" onSuccess="onNickNameUpdateSuccess();" 
					   onFailure="onNickNameUpdateFailure();" />
					  <g:hiddenField name="productType" value="${setnameseqrequest?.productType}" />
				</div>
		</div>
		<script>
			function onNickNameUpdateSuccess()
			{
				$("#updateNickSeq").empty();
			}
			
			function onNickNameUpdateFailure()
			{
				$("#pdmsgcont").animate({scrollTop: 0}); 
			}
			
		</script>