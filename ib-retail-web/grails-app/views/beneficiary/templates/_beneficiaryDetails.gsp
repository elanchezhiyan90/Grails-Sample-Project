
<div id="beneficiaryDetails" class="">
	<%--<div class="mandi-note">
		<span class="mandi"></span>
		<p>Mandatory fields</p>
	</div>
	--%><!--------------Benefeciary details Starts here--------------------->
	<g:set
		value="${beneficiary?.beneficiarysocilaNetwork?.socialNetworkLogin}"
		var="fbprofile" />
	<g:hiddenField name="beneTypeCode" id="beneTypeCode" value="FF" />

	<div class="col-370">
		<g:if test="${beneficiary?.id}">
			<g:hiddenField name="beneficiaryId" id="beneficiaryId"
				value="${beneficiary?.idVersion}" />
			<g:hiddenField name="benestatus" id="benestatus"
				value="${beneficiary?.status}" />
			<g:hiddenField name="beneInstrctionId" id="beneInstrctionId" value="" />
			<g:hiddenField name="beneInstrctionStatus" id="beneInstrctionStatus"
				value="" />
			<g:if test="${beneficiary?.beneficiarysocilaNetwork}">
				<g:each in="${beneficiary?.beneficiarysocilaNetwork}">
					<g:if test="${it.socialNetwork.code=='FB'}">
						<g:set var="fblogin" value="${it.socialNetworkLogin}" />
					</g:if>
					<g:if test="${it.socialNetwork.code=='TW'}">
						<g:set var="twlogin" value="${it.socialNetworkLogin}" />
					</g:if>
					<g:if test="${it.socialNetwork.code=='GP'}">
						<g:set var="googlepluslogin" value="${it.socialNetworkLogin}" />
					</g:if>
				</g:each>
			</g:if>
		</g:if>
		<div class="fields">
			<p>
				<label for="bene_name"><g:message
						code="beneficiary.templates.personaldtl.name.label" /></label>
				<input type="text" name="shortName" id="shortName"
					value="${beneficiary?.shortName}" required="required"
					title="Please enter Name"  pattern="[a-zA-Z0-9 ]+" maxlength="25"
					data-errormessage="${g.message(code:"beneficiary.templates.personaldtl.enterbenename.error.message")}" />
				<%--<vayana:postablelink controller="socialConnectFacebook"
				action="friends" linkClass="ceebox"
				linkTitle="Add Friends and Family" id="shortNameLink"
				formName="beneficairyForm">
				<g:img dir="/images/social/facebook/" file="facebook.png" />
			</vayana:postablelink>
		--%>
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="primaryEmailAddress"><g:message
						code="beneficiary.templates.personaldtl.primaryEmailAddress.label" /></label>
				<input type="email" name="primaryEmailAddress"
					id="primaryEmailAddress" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
					value="${beneficiary?.contact?.primaryEmailAddress}"
					title="${g.message(code:'beneficiary.templates.personaldtl.primaryEmailAddress.label.tooltip.text')}"
					data-errormessage="${g.message(code:'beneficiary.templates.personaldtl.primaryEmailAddress.error.message')}" />
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="secondaryEmailAddress"><g:message
						code="beneficiary.templates.personaldtl.secondaryEmailAddress.label" /></label>
				<input type="email" name="secondaryEmailAddress"
					id="secondaryEmailAddress" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
					value="${beneficiary?.contact?.secondaryEmailAddress}"
					title="${g.message(code:'beneficiary.templates.personaldtl.secondaryEmailAddress.label.tooltip.text')}" />
			</p>
		</div>

		<%--<div class="fields">
			<p>
				<label for="facebookId"><g:message
						code="beneficiary.templates.personaldtl.socialnetworkingname.label" /></label>
				<g:if
					test="${(fbprofile!=null)&&(fblogin==null)&& (fbprofile.size()>0)}">
					<g:textField class="fb" name="facebookId" id="facebookId"
						value="${fbprofile?.get(0)}" title="Enter Facebook ID"
						placeholder="Facebook ID" />
				</g:if>
				<g:else>
					<g:textField class="fb" name="facebookId" id="facebookId"
						value="${fblogin}" title="Enter Facebook ID"
						placeholder="Facebook ID" />
				</g:else>
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="twitterId">&nbsp;</label>
				<g:textField class="tw" name="twitterId" id="twitterId"
					value="${twlogin}" title="Enter Twitter ID"
					placeholder="Twitter ID" />
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="googleplusId">&nbsp;</label>
				<g:textField class="gp" name="googleplusId" id="googleplusId"
					value="${googlepluslogin}" title="Enter Google Plus ID"
					placeholder="Google Plus Id" />
			</p>
		</div>


		--%><div class="fields">
			<p>
				<label for="primaryPhoneNumber"><g:message
						code="beneficiary.templates.personaldtl.primaryPhoneNumber.label" /></label>
				<input type="text" name="primaryPhoneNumber" id="primaryPhoneNumber"
					value="${beneficiary?.contact?.primaryPhoneNumber}"
					title="+99(99)9999-9999" placeholder="+99(99)9999-9999"
					pattern="[0-9]{1,10}"
					data-errormessage="${g.message(code:"beneficiary.templates.personaldtl.primaryPhoneNumber.error.message")}" />
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="secondaryPhoneNumber"><g:message
						code="beneficiary.templates.personaldtl.secondaryPhoneNumber.label" /></label>
				<input type="text" name="secondaryPhoneNumber" id="secondaryPhoneNumber"
					value="${beneficiary?.contact?.secondaryPhoneNumber}"
					pattern="[0-9]{1,10}" title="+99(99)9999-9999"
					placeholder="+99(99)9999-9999" />
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="primaryMobileNumber"> <g:message
						code="beneficiary.templates.personaldtl.primaryMobileNumber.label" /></label>
				<input type="text" name="primaryMobileNumber" id="primaryMobileNumber"
					value="${beneficiary?.contact?.primaryMobileNumber}"
					pattern="[0-9]{1,10}" title="+99(99)9999-9999"
					placeholder="+99(99)9999-9999"
					data-errormessage="${g.message(code:'beneficiary.templates.personaldtl.primaryMobileNumber.error.message')}" />
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="secondaryMobileNumber"> <g:message
						code="beneficiary.templates.personaldtl.secondaryMobileNumber.label" /></label>
				<input type="text" name="secondaryMobileNumber" id="secondaryMobileNumber"
					value="${beneficiary?.contact?.secondaryMobileNumber}"
					pattern="[0-9]{1,10}" title="+99(99)9999-9999"
					placeholder="+99(99)9999-9999" />
			</p>
		</div>

	</div>

	<div class="col-280">
		<div class="fields">
			<p>
				<label for="streetAddress1"><g:message
						code="beneficiary.templates.personaldtl.address1.label" /></label>
				<input type="text" name="streetAddress1" id="streetAddress1" pattern="[a-zA-Z0-9 ]+"
					value="${beneficiary?.contact?.streetAddress1}"
					data-errormessage="${g.message(code:'beneficiary.templates.personaldtl.address1.error.message')}" />
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="streetAddress2"><g:message
						code="beneficiary.templates.personaldtl.address2.label" /></label>
				<input type="text" name="streetAddress2" id="streetAddress2" pattern="[a-zA-Z0-9 ]+"
					value="${beneficiary?.contact?.streetAddress2}" />
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="streetAddress3"><g:message
						code="beneficiary.templates.personaldtl.address3.label" /></label>
				<input type="text" name="streetAddress3" id="streetAddress3" pattern="[a-zA-Z0-9 ]+"
					value="${beneficiary?.contact?.streetAddress3}" />
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="streetAddress4"><g:message
						code="beneficiary.templates.personaldtl.address4.label" /></label>
				<input type="text" name="streetAddress4" id="streetAddress4" pattern="[a-zA-Z0-9 ]+"
					value="${beneficiary?.contact?.streetAddress4}" />
			</p>
		</div>

		<div class="fields">
			<p>
				<label for="countryId"><g:message
						code="beneficiary.templates.personaldtl.country.label" /></label>
				<vayana:tenantOpsCountrySelect name="countryId" id="countryId" data-errormessage="${g.message(code:"beneficiary.templates.personaldtl.country.error.message")}" ></vayana:tenantOpsCountrySelect>
				<%--<vayana:select name="countryId" id="countryId"
					value="${beneficiary?.contact?.country?.idVersion}" findBy="ALL"
					type="COUNTRIES"
					errormessage="${g.message(code:"beneficiary.templates.personaldtl.country.error.message")}" />
			--%></p>
		</div>
		<%--<div class="fields">
			<p>
				<label for="stateId"><g:message
						code="beneficiary.templates.personaldtl.state.label" /></label>
				<vayana:select name="stateId" id="stateId"
					value="${beneficiary?.contact?.state?.idVersion}" findBy="ALL"
					type="STATE" />
			</p>
		</div>
		--%><div class="fields">
			<p>
				<label for="cityId"><g:message
						code="beneficiary.templates.personaldtl.city.label" /></label>
				<vayana:select name="cityId" id="cityId"
					value="${beneficiary?.contact?.city?.idVersion}" findBy="ALL"
					type="CITY" />
			</p>
		</div>
		<div class="fields">
			<p>
				<label for="pincode"><g:message
						code="beneficiary.templates.personaldtl.pincode.label" /></label>
				<g:textField name="pincode" id="pincode" pattern="[0-9]+"
					value="${beneficiary?.contact?.pincode}"
					data-errormessage="${g.message(code:"beneficiary.templates.personaldtl.pincode.error.message")}" />
			</p>
		</div>
	</div>
	<div class="buttons">
		<g:if
			test="${beneficiary?.id && beneficiary.getStatus().code.toString().equals("ACT")}">
			<vayana:submitToRemote controller="beneficiary"
				action="updateBeneficiary" name="submit" id="submit"
				value="${message(code:'beneficiary.templates.limitdtl.buttonsave.text')}"
				before="if (checkFormValidity()) {return false;}"
				update="[success:'messageDiv',failure:'messagesDiv']"
				onSuccess="beneficiaryAccountsUpdate(data,textStatus)" />
		</g:if>
		<g:elseif test="${beneficiary?.id == null}">
			<vayana:submitToRemote controller="beneficiary"
				action="insertBeneficiary" name="submit" id="submit"
				value="${message(code:'beneficiary.templates.limitdtl.buttonsave.text')}"
				before="if (checkFormValidity()) {return false;}"
				update="[success:'messageDiv',failure:'messagesDiv']"
				onSuccess="beneficiaryAccounts(data,textStatus)" />
		</g:elseif>

	</div>
</div>


<!-- bene details ends here -->
<script>
$(document).ready(function(){
 
 $("#beneficiaryDetails").dynamicfieldupdate();

 });
function beneficiaryAccountsUpdate(data,textStatus)
{
	$( "#tabs" ).tabs({enabled: [0]},{selected:1} ); 
    
 	$("#ulFriendsAndFamilyPayh3",window.parent.document).attr("data-dflag","true");
 	$("#ulFriendsAndFamilyPay li",window.parent.document).remove();
	$("#ulFriendsAndFamilyPayh3",window.parent.document).trigger("click");
  	$("#beneficiaryAccounts").dynamicfieldupdate();
}
function beneficiaryAccounts(data,textStatus)
{
	$( "#tabs" ).tabs({disabled: [0]},{selected:1} ); 
	  var beneId = $(data).filter("#beneficiaryId").val();
	  //alert(beneId);
	  $("#hidBeneficiaryIdversion").val(beneId);
	  $("#beneficiaryAccounts").dynamicfieldupdate();
	  $("#ulFriendsAndFamilyPayh3",window.parent.document).attr("data-dflag","true");
	  $("#ulFriendsAndFamilyPay li",window.parent.document).remove();
	  $("#ulFriendsAndFamilyPayh3",window.parent.document).trigger("click");
}

</script>