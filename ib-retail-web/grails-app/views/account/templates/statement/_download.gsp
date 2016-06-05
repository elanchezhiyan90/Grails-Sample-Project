<!---------- user downloadable formats Starts Here----------->
<div class="grid_foot">
	<ul class="downloads">
		<li><g:message code="account.templates.statement.download.download.label"/></li>
		<li><a href="" class="xls" title="${g.message(code:"account.templates.statement.download.downloadmsexcelformat.tooltip.text") }"></a></li>
		<li><a href="" class="csv" title="${g.message(code:"account.templates.statement.download.downloadcsvformat.tooltip.text") }"></a></li>
		<li><a href="" class="msmoney" title="${g.message(code:"account.templates.statement.download.downloadmsmoneyformat.tooltip.text") }"></a></li>
		<li><a href="" class="pdf" title="${g.message(code:"account.templates.statement.download.downloadpdfformat.tooltip.text") }"></a></li>
	</ul>
	<ul class="email">
		<li><g:message code="account.templates.statement.download.email.label"/></li>
		<li><a href="" class="pdf" title="${g.message(code:"account.templates.statement.download.downloadpdfformat.tooltip.text") }"></a></li>
	</ul>
	<vayana:pager controller="account" action="detailedstatementgotopage" update="mainContent"/>
	</div>
<!---------- user downloadable formats Ends Here----------->
