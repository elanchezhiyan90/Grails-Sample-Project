<div class="content">
	<div class="content-wrap">
		<section class="app-section">
			<g:form name="forceChangeLoginPasswordWarning" controller="userProfile">
				<b> Dear Customer </b><br /> <br /> 
				<p>
					Your net banking login password would expire in ${noOfDays} days. Do you want to change it now?
				</p>

				<br />

				<div class="buttons">
					<g:actionSubmit value="No Thanks" action="dontChangeLoginPassword" />
					<g:actionSubmit value="Ok" action="forceChangeLoginPassword" />
				</div>

			</g:form>
		</section>
	</div>
</div>