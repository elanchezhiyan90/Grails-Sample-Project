<head>
<title>${message(code:'userprofile.template.loginhistory.title')}</title>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body class="body-scroll">
	<div class="pd_list">
		<h4>${message(code:'userprofile.template.loginhistory.h4.text')}</h4>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="style_grid">
				<thead>
					<tr>
						<th width="20%">Access Type</th>
						<th width="20%">Browser Details</th>
<%--						<th width="20%">Location</th>--%>
						<th width="20%">IP Address</th>
						<th width="20%">Start Time</th>
						<th width="20%">End Time</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${userLoginHistoryModel}" var="loginHistory">
					<tr>
						<td width="20%">${loginHistory?.channel?.code}</td>
						<td width="20%">${loginHistory?.userAgent}</td>
<%--						<td width="20%">${loginHistory?.internetProtocolRange?.country?.description}</td>--%>
						<td width="20%">${loginHistory?.internetProtocolAddress}</td>
						<td width="20%"><vayana:formatDate date='${loginHistory?.startTime}' showTime="true"/></td>
						<td width="20%"><vayana:formatDate date='${loginHistory?.endTime}' showTime="true"/></td>
					</tr>
				</g:each>
				</tbody>
			</table>
	</div>
</body>
