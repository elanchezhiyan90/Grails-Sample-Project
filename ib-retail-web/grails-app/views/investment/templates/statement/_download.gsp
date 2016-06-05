<!---------- user downloadable formats Starts Here----------->
<div class="grid_foot">
	<ul class="downloads">
		<li>${message(code:'investment.templates.statement.download.download.label')}</li>
		<li><a href="" class="xls" title="${message(code:'investment.templates.statement.download.tooltip.msexcelformat')}"></a></li>
		<li><a href="" class="csv" title="${message(code:'investment.templates.statement.download.tooltip.csvformat')}"></a></li>
		<li><a href="" class="msmoney" title="${message(code:'investment.templates.statement.download.tooltip.msmoneyformat')}"></a></li>
		<li><a href="" class="pdf" title="${message(code:'investment.templates.statement.download.tooltip.PDFformat')}"></a></li>
	</ul>
	<ul class="email">
		<li>${message(code:'investment.templates.statement.download.email.label')}</li>
		<li><a href="" class="pdf" title="${message(code:'investment.templates.statement.download.tooltip.PDFformat')}"></a></li>
	</ul>
	<vayana:pager controller="investment" action="detailedstatementgotopage" update="mainContent"/>
	</div>

<!---------- user downloadable formats Ends Here----------->





