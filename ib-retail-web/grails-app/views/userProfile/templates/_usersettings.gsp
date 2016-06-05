<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
 
 <section>                
        <g:form name="frmLookUpType" action="usersettingsdetail" controller="userProfile">
        <div class="f-panel">
       <%--<div class="mandi-note">
			<span class="mandi"></span>
			<p>${message(code:'userprofile.template.changesecureaccess.mandatoryfields.text')}</p>
		</div>
        --%><div class="fields">
                                <p>
                                  <label for="srequst">Language</label>
                                  <vayana:tenantApplicationLocaleSelect name="locale" required="required" defaultLocaleFlag="true"  data-errormessage="Please select value" value="${userPreferenceResponseModel?.userPreference?.locale?.idVersion}"></vayana:tenantApplicationLocaleSelect>
<%--                                  <vayana:select name="locale" id="locale" type="CITY" domain="base" findBy="ALL" required="required" data-errormessage="Please select value"/>--%>
                                </p>
       </div>
       <div class="fields">
                                <p>
                                  <label for="srequst">Preferred Currency</label>
                                <vayana:tenantOpsCurrencySelect name="tenantApplicationCurrency" required="required" data-errormessage="Please select value" value="${userPreferenceResponseModel?.userPreference?.tenantApplicationcurrency?.currency?.idVersion}"></vayana:tenantOpsCurrencySelect>
<%--                                  <vayana:currencySelect name="preferredCurrency" id="lookupTypeId" type="CURRENCIES" domain="base" findBy="ALL" required="required" data-errormessage="Please select value"/>--%>
                                </p>
       </div>
       <div class="fields">
                                <p>
                                  <label for="srequst">Profile Theme</label>
                                  <vayana:lookupSelect name="profileTheme" type="PROFILE_THEME" id="profileTheme"  required="required"  data-errormessage="Please select value" value="${userPreferenceResponseModel?.userPreference?.profileTheme?.idVersion}"></vayana:lookupSelect>
<%--                                  <vayana:select name="profileTheme" id="lookupTypeId" type="LOOKUPTYPE" domain="base" findBy="" required="required" data-errormessage="Please select value"/>--%>
                                </p>
       </div>
       <%--<div class="fields">
                                <p>
                                  <label for="srequst">Authorization Type</label>
                                  <vayana:select name="authorizationType" id="lookupTypeId" type="LOOKUPTYPE" domain="base" findBy="ALL" required="required" data-errormessage="Please select value"/>
                                </p>
       </div>
       --%>
      <!--  <div class="fields">
						<p>
							<label for="amount">Facebook Id</label>
							<input type="text" placeholder="" class="fb" id="primaryFbLogin" name="primaryFbLogin" title="Enter Facebook ID" value="${userPreferenceResponseModel?.contact?.primaryFaceBookLogin}" >							
 						</p>

                     </div> 
                     
	<div class="fields">
		<p>
		<label for="srequst">Google Plus</label>
		<input type="text" placeholder="" class="gp"  id="primaryGpLogin" name="primaryGpLogin" title="Enter Google Plus ID" value="${userPreferenceResponseModel?.contact?.primaryGooglePlusLogin}">							
			</p>

     </div>     -->
       
       <div class="buttons">
		<g:submitButton name="Save" value="Save Changes"  before="if (!isFormValid()){return false;}"	 update="[failure:'messagesDiv']"
		onSuccess="updateFormData(data,textStatus)" />	
		
		</div>
		
						
		<div id="divlookupType">
		</div>  
		
		
	</div>	
    </g:form>
    </section>
<script>
function isFormValid(){

	if($('#frmLookUpType').checkValidity()){ 
	      return true;   
	}else{
		   return false;
	}
} 



function updateFormData(data,textStatus){
	
<%--	$("#messagesDiv").append(data);--%>
}

		
$(".fields").dynamicfieldupdate();
<%--$("#frmLookUpType").dynamicfieldupdate();--%>
<%--$(".fields").dynamicfieldupdate();--%>

</script>
 
</body>
