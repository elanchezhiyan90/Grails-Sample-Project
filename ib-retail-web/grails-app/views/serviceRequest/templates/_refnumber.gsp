<div id="messagesDiv">
	<g:if test="${errorCode}">
		<div class="failure">
			<span></span>
			<g:message code="${errorCode}" args="${args}" />
		</div>
	</g:if>
	<g:else>
		<g:if test="${ResponseModel1?.tenantServiceCode.equals('CHQSTS')}">
			<g:render template="templates/chequestatussuccess" />
		</g:if>
		<g:elseif
			test="${ResponseModel1?.tenantServiceCode.equals('CHQBREQ')}">
			<g:if
				test="${'NO'.equals(ResponseModel1?.metaDataRequest.get('BRN_PICKUP'))}">
				
				<div class="success">
					<span></span>
				
						<g:if test="${ResponseModel1?.isAuthMatrixConfigured==true}">
						<p>

						${message(code:'servicerequest.templates.refnumber.chquebookrequest.success.no.message1') }<br />
						${message(code:'servicerequest.templates.refnumber.referencenumber.text') }<b>
							${ResponseModel1?.referenceNo}
						</b>
						</g:if>
						<g:else>
						<p>

						${message(code:'servicerequest.templates.refnumber.chquebookrequest.success.no.message') }<br />
						${message(code:'servicerequest.templates.refnumber.referencenumber.text') }<b>
							${ResponseModel1?.referenceNo}
						</b>
					</p>
						
						
						</g:else>					
						</div>
			</g:if>
			<g:else>
				<div class="success">
					<span></span>
					
							<g:if test="${ResponseModel1?.isAuthMatrixConfigured==true}">
						<p>

						${message(code:'servicerequest.templates.refnumber.chquebookrequest.success.no.message1') }<br />
						${message(code:'servicerequest.templates.refnumber.referencenumber.text') }<b>
							${ResponseModel1?.referenceNo}
						</b>
						</g:if>
						<g:else>
						<p>

						${message(code:'servicerequest.templates.refnumber.chquebookrequest.success.yes.message') }<br />
						${message(code:'servicerequest.templates.refnumber.referencenumber.text') }<b>
							${ResponseModel1?.referenceNo}
						</b>
					</p>
						
						
						</g:else>	
				</div>
			</g:else>
		</g:elseif>
		<g:elseif test="${'STATREQ'.equals(ResponseModel1?.tenantServiceCode) && 'PRINT'.equals(ResponseModel1?.metaDataRequest.get('DELIVERY_MODE'))}">
				<div class="success">
					<span></span>
					<p>
						${message(code:'servicerequest.templates.refnumber.statementrequest.print.success.message') }<br />
						<br />
						${message(code:'servicerequest.templates.refnumber.referencenumber.text') }<b>
							${ResponseModel1?.referenceNo}
						</b>
					</p>
				</div>
		</g:elseif>
		<g:else>
			<div class="success">
				<span></span>
				
						<g:if test="${ResponseModel1?.isAuthMatrixConfigured==true}">
						<p>

						${message(code:'servicerequest.templates.refnumber.success.message1') }<br />
						${message(code:'servicerequest.templates.refnumber.referencenumber.text') }<b>
							${ResponseModel1?.referenceNo}
						</b>
						</g:if>
						<g:else>
						<p>
					${message(code:'servicerequest.templates.refnumber.success.message') }<br />
					${message(code:'servicerequest.templates.refnumber.referencenumber.text') }<b>
						${ResponseModel1?.referenceNo}
					</b>
				</p>
					</p>
						
						
						</g:else>	
			</div>
		</g:else>
	</g:else>
</div>
<script>

</script>
