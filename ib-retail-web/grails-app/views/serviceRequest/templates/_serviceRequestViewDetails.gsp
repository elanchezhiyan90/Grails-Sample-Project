<div class="col-370">
	<ul class="payment_dtls">
	<g:if test="${genericSRModel?.serviceRequestInstruction?.tenantService != null }">
		<li>
			<div class="dtl_wralp">
				
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>
							Request Type
						</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${g.message(code: 'servicerequest.templates.search.'+genericSRModel?.serviceRequestInstruction?.tenantService?.serviceApplication?.service?.code)}
						</p>
					</div>
				
			</div>
		</li>
		</g:if>
		<g:each in="${genericSRModel?.serviceRequestDatas}" var="dataList">
			<li>
				<div class="dtl_wralp">
					<g:if test="${(dataList?.dataVarcharValue!=null)}">
						<div class="lft_dtl">
							<p>&nbsp;</p>
							<p>
								${dataList?.serviceRequestMetaData?.dataLabelDescription}
							</p>
						</div>
						<div class="rht_dtl">
							<p>&nbsp;</p>
							<p>
								${dataList?.dataVarcharValue}
							</p>
						</div>
					</g:if>

					<g:if test="${(dataList?.dataNumberValue!=null)}">
						<div class="lft_dtl">
							<p>&nbsp;</p>
							<p>
								${dataList?.serviceRequestMetaData?.dataLabelDescription}
							</p>
						</div>
						<div class="rht_dtl">
							<p>&nbsp;</p>
							<p>
								${dataList?.dataNumberValue}
							</p>
						</div>
					</g:if>

					<g:if test="${(dataList?.dataDateValue!=null)}">
						<div class="lft_dtl">
							<p>&nbsp;</p>
							<p>
								${dataList?.serviceRequestMetaData?.dataLabelDescription}
							</p>
						</div>
						<div class="rht_dtl">
							<p>&nbsp;</p>
							<p>
								<vayana:formatDate date="${dataList?.dataDateValue}" />
							</p>
						</div>
					</g:if>
				</div>
			</li>
		</g:each>
		<g:if test="${genericSRModel?.serviceRequestInstruction?.referenceTag != null && !('').equals(genericSRModel?.serviceRequestInstruction?.referenceTag)}">
		<li>
			<div class="dtl_wralp">
				
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>
							Reference Number
						</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${genericSRModel?.serviceRequestInstruction?.referenceTag}
						</p>
					</div>
				
			</div>
		</li>
		</g:if>
		<%--<g:if test="${(params?.recordStatus != null)}">
		<li>
			<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>
							Status
						</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${g.message(code: 'servicerequest.templates.status'+params?.recordStatus)}
						</p>
					</div>
				
			</div>
		</li>
		</g:if>
		
		--%><li>
			<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>
							${g.message(code: 'servicerequest.templates.comments')}
						</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							<vayana:getRejectionReason entityId="${genericSRModel?.serviceRequestInstruction?.id}" />
						</p>
					</div>
				
			</div>
		</li>
		
		
		
	</ul>
</div>