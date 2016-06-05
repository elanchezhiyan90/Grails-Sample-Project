
<table border="0" cellspacing="0" cellpadding="0">
	<tbody>
		<g:each in="${resp?.serviceRequestDatas}" var="dataList">
			<tr>
				<g:if test="${(dataList?.dataVarcharValue!=null)}">
					<td>
						${dataList?.serviceRequestMetaData?.dataLabelDescription}
					</td>
					<td>
						${dataList?.dataVarcharValue}
					</td>
				</g:if>

				<g:if test="${(dataList?.dataNumberValue!=null)}">
					<td>
						${dataList?.serviceRequestMetaData?.dataLabelDescription}
					</td>
					<td>
						${dataList?.dataNumberValue}
					</td>
				</g:if>

				<g:if test="${(dataList?.dataDateValue!=null)}">

					<td>
						${dataList?.serviceRequestMetaData?.dataLabelDescription}
					</td>

					<td><vayana:formatDate date="${dataList?.dataDateValue}" /></td>

				</g:if>
			</tr>
		</g:each>
		<tr>
			<td>Reference No</td>
			<td>
				${resp?.serviceRequestInstruction?.referenceTag}
			</td>
		</tr>

		<g:if test="${resp?.serviceRequestInstruction?.createdBy != null}">
			<tr>
				<td>Created By</td>
				<td>
					${resp?.serviceRequestInstruction?.createdBy?.userLogin}
				</td>
			</tr>
		</g:if>
		<g:if test="${resp?.serviceRequestInstruction?.authBy != null}">
			<tr>
				<td>Auth By</td>
				<td>
					${resp?.serviceRequestInstruction?.authBy?.userLogin}
				</td>
			</tr>
		</g:if>
<%--		<g:if--%>
<%--			test="${!(['CHQBREQ','STATREQ'].contains(resp?.serviceRequestInstruction?.tenantService?.serviceApplication?.service?.code)) }">--%>
			<tr>
				<td>Status</td>
				<td>
					${resp?.serviceRequestInstruction?.status?.description}
				</td>
			</tr>
<%--		</g:if>--%>

		<g:if
			test="${resp?.serviceRequestInstruction?.status?.code.equals("REJ")}">
			<tr>
				<td>Reason For Failure</td>
				<td><vayana:getRejectionReason
						entityId="${resp?.serviceRequestInstruction?.id}" /></td>
			</tr>
		</g:if>
	</tbody>
</table>

