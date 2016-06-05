<ul class="downloads">
	<li>Download</li>
	<li>
		<vayana:postablelink id="lnkXLS" formName="${formName}" controller="reports" action="download" linkClass="xls" target="_self" urlParams="[ReportFormat:'xls']" linkTitle="Download in Excel format" spinnerRequired="false"></vayana:postablelink>
	</li>
<%--	<li>--%>
<%--		<vayana:postablelink id="lnkCSV" formName="${formName}" controller="reports" action="download" linkClass="csv" target="_blank" urlParams="[ReportFormat:'csv']" linkTitle="Download in Csv format"></vayana:postablelink>--%>
<%--	</li>--%>
<%--	<li>--%>
<%--		<vayana:postablelink id="lnkMSMoney" formName="${formName}" controller="reports" action="download" linkClass="msmoney" target="_blank" urlParams="[ReportFormat:'msmoney']" linkTitle="Download Ms Money format"></vayana:postablelink>--%>
<%--	</li>--%>
	<li>
		<vayana:postablelink id="lnkPDF"  formName="${formName}" controller="reports" action="download" linkClass="pdf" target="_self" urlParams="[ReportFormat:'pdf']" linkTitle="Download in Pdf format" spinnerRequired="false"></vayana:postablelink>
	</li>
</ul>
<%--<ul class="email">--%>
<%--	<li>Email</li>--%>
<%--	<li>--%>
<%--		<vayana:postablelink id="lnkPDFMail" formName="${formName}" controller="reports" action="download" linkClass="pdf" target="_blank" urlParams="[ReportFormat:'pdf']" linkTitle="Download in Pdf format"></vayana:postablelink>--%>
<%--	</li>--%>
<%--</ul>--%>
<g:hiddenField name="ReportName" value="${reportName}" />