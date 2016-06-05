<g:set var="applyLoanRequest" value="${applyLoanRequest}" />


	<div id=propertyDetails>
		<g:form name="frmLookUpType">
			<table width="100%" border="0" cellpadding="10px" cellspacing="9"
				align="center">

				<tr>
					<td>
						<div>

							<p>
								<label for="srequst"> ${message(code:'applyforloan.template.purposeofloan.label')}
								</label>

								<vayana:tenantLookupSelect optionValue="description"
									name="purposeofloan" type="LOAN_PURPOSE" id="purposeofloan"
									required="required" data-errormessage="Please select value"></vayana:tenantLookupSelect>
								<%--<g:hiddenField name="purposeofloancode" id="purposeofloancode" value="${applyLoanRequest?.purposeofloan}"/>
									
							--%>
							</p>
						</div>
					</td>

					<td>
						<div>
							<p>
								<label for="srequst"> ${message(code:'applyforloan.template.propertylocation.label')}
								</label>

								<vayana:select name="propertylocation" id="propertylocation"
									required="required" data-errormessage="Please select value"
									type="CITY" domain="base" findBy="ALL" />
							</p>
						</div>
					</td>
				</tr>

				<tr>
					<td>
						<div>
							<p>
								<label for="srequst"> ${message(code:'applyforloan.template.propertydetails.label')}
								</label>

								<vayana:tenantLookupSelect optionValue="description"
									name="propertydetails" type="PROPERTY_DTL" id="propertydetails"
									required="required" data-errormessage="Please select value"></vayana:tenantLookupSelect>
							</p>
						</div>
					</td>


					<td>
						<div>
							<p>
								<label for="amount"> ${message(code:'applyforloan.template.nameofthebuilder.label')}
								</label> <input type="text" placeholder="" class=""
									id="nameofthebuilder" name="nameofthebuilder"
									required="required" data-errormessage="Please select value"
									title="Please Enter the Value"
									value="${applyLoanRequest?.nameofthebuilder}">
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div>
							<p>
								<label for="amount"> ${message(code:'applyforloan.template.costofhome.label')}
								</label>
								<vayana:tenantOpsCurrencySelect name="tenantApplicationCurrency"
									id="costofhomecurrency" name="costofhomecurrency" class="cur"
									required="required" data-errormessage="Please select value" />
								<input type="number" placeholder="" class="s_amt" id="costofhome"
									required="required" data-errormessage="Please select value"
									name="costofhome" title="Please Enter the Value"
									value="${applyLoanRequest?.costofhome}">
							</p>
						</div>
					</td>

					<td>
						<div>
							<p>
								<label for="srequst"> ${message(code:'applyforloan.template.livecountry.label')}
								</label>
								<%--  <vayana:tenantOpsCurrencySelect name="tenantApplicationCurrency" required="required" data-errormessage="Please select value"/>
                                 <vayana:currencySelect name="preferredCurrency" id="lookupTypeId" type="CURRENCIES" domain="base" findBy="ALL" required="required" data-errormessage="Please select value"/>--%>
								<vayana:select name="livingcountry" id="livingcountry"
									type="COUNTRIES" domain="base" findBy="ALL" required="required"
									data-errormessage="Please select value" />
							</p>
						</div>
					</td>

				</tr>

			</table>
			<div class="buttons" align="right">
				<g:submitToRemote action="savepropertydetails"
					controller="applyLoan" value="Next"					
					update="[failure:'messagesDiv']"
					onSuccess="updateFormData1(data,textStatus)"
					onFailure="updateFormData1Failure(XMLHttpRequest.responseText)" />
										
			</div>
			<div id="divlookupType"></div>

		</g:form>
	</div>


<script>
 

function updateFormData1(data,textStatus){
$("#spinner").hide();

$( ".applyloan" ).tabs({disabled: [2,3]},{selected:[1]} );
$(".applyloan").tabs("refresh");
$( ".incomeDetails" ).show();
$("#incomeDetails").dynamicfieldupdate();






}

function updateFormData1Failure(responseText) {
		$("#messagesDiv").empty();
		$("#messagesDiv").append(responseText);
}				

<%--$("#frmLookUpType").dynamicfieldupdate();--%>
<%--$(".fields").dynamicfieldupdate();--%>

</script>

