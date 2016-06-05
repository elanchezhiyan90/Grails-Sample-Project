<div id="account-dtl">
	
	<!-- Sticky header starts here ----------->
	<div class="start-stick_top" id="accounts" name="accounts"></div>
	<div class="grid_stickyhead_top">
		<table border="0" cellpadding="0px" cellspacing="0px"
			class="grid_theader">
			<tr>
				<th width="20%">${message(code:'biller.templates.details.billerinstructions.nickname.label') }</th>
				<g:each var="billerData"
					in="${BillerDetailsModel?.billerInstructions?.get(0).billerData}">
					<th width="20%">
						${billerData?.billerMetadata?.dataLabel?.description}
					</th>
				</g:each>
				<th width="10%">${message(code:'biller.templates.details.billerinstructions.status.label') }</th>
					
			</tr>
		</table>
	</div>
	<div id="billerAccountDetails">
		<g:render template="templates/details/billerInstructionsTable" />
	</div>
</div>


