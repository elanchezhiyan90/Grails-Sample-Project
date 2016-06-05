<!---------- user downloadable formats Starts Here----------->
<div class="grid_foot">
	<ul class="downloads">
		<li>${message(code:'loan.templates.statement.download.download.label')}</li>
		<li><a href="" class="xls" title="Download Ms Excel format"></a></li>
		<li><a href="" class="csv" title="Download CSV format"></a></li>
		<li><a href="" class="msmoney" title="Download Ms Money format"></a></li>
		<li><a href="" class="pdf" title="Download PDF format"></a></li>
	</ul>
	<ul class="email">
		<li>${message(code:'loan.templates.statement.download.email.label')}</li>
		<li><a href="" class="pdf" title="Download PDF format"></a></li>
	</ul>
	<vayana:pager controller="loan" action="detailedstatementgotopage" update="mainContent"/>
	</div>
<!---------- user downloadable formats Ends Here----------->
