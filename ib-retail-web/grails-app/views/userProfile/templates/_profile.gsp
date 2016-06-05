<head>
<title>${message(code:'userprofile.template.profile.title')}</title>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<div class="pd_list">
		<h4>${message(code:'userprofile.template.profile.h4.text')}</h4>
	</div>
	<div class="pd_list">
		<h5>${userProfileResponseModel?.ibUserProfile?.firstName} - ${userProfileResponseModel?.ibUserProfile?.getPrimaryUserCif()?.customerIdentifier?.cifNumber}</h5>
	</div>
	
	<div class="col-550">
	<table border="0" cellpadding="0" cellspacing="0" class="profile_view">
	<g:set var="userLoginprofile" value="${userProfileResponseModel.ibUserLoginProfile}" />
	<g:set var="userProfile" value="${userProfileResponseModel?.ibUserProfile}" />	
	
<%--	<tr>--%>
<%--				<td rowspan="10">--%>
<%--                	<div class="photobg">--%>
<%--                	<img src="../themes/default_theme/img/branding/user_pic.jpg" height="96" width="96"/>--%>
<%--                    </div>--%>
<%--                </td>--%>
<%--                <td class="col-200"></td>--%>
<%--                <td></td>--%>
<%--                <td class="col-200"><g:message code="userprofile.template.profile.customerid.label"/></td>--%>
<%--                <td>${userLoginprofile?.userProfile?.getPrimaryUserCif()?.customerIdentifier?.cifNumber}</td>--%>
<%--                <td rowspan="9">--%>
<%--                	<div class="photobg">--%>
<%--                	<img src="../themes/default_theme/img/branding/user_pic.jpg" height="96" width="96"/>--%>
<%--                    </div>--%>
<%--                </td>--%>
<%--                <td class="col-200"><g:message code="userprofile.template.profile.rmname.label"/></td>--%>
<%--                <td>${userLoginprofile?.reportingManager?.userProfile?.firstName}</td>--%>
<%--	</tr>--%>
		<tr>
               
                <td><g:message code="userprofile.template.profile.username.label"/></td>
                <td>${userLoginprofile.getUserLogin()}</td>
               
                
	   </tr>
	   
	   <g:if test="${userProfile?.dateOfBirth}">
	   <tr>
                <td><g:message code="userprofile.template.profile.dateofbirth.label"/></td>
                <td>${userProfile?.dateOfBirth}</td>
               
              
	   </tr>
	   </g:if>
	    <tr>
                <td><g:message code="userprofile.template.profile.address1.label"/></td>
                <td>${userLoginprofile?.userContactDetail?.contact?.streetAddress1}</td>
                            
	   </tr>
	   <tr>
	            <td><g:message code="userprofile.template.profile.address2.label"/></td>
                <td>${userLoginprofile?.userContactDetail?.contact?.streetAddress2}</td>
       </tr> 
       
       <tr>
                 <td><g:message code="userprofile.template.profile.address3.label"/></td>
                <td>${userLoginprofile?.userContactDetail?.contact?.streetAddress3}</td>   
       </tr>
       <tr>
               <td><g:message code="userprofile.template.profile.mobilenumber.label"/></td>
               <td>${userLoginprofile?.userContactDetail?.contact?.primaryMobileNumber}</td>       
       </tr> 
       
       <tr>
                <td><g:message code="userprofile.template.profile.officenumber.label"/></td>
                <td>${userLoginprofile?.userContactDetail?.contact?.secondaryMobileNumber}</td>
       </tr>   
       
        <tr>
                <td><g:message code="userprofile.template.profile.residentnumber.label"/></td>
                <td>${userLoginprofile?.userContactDetail?.contact?.secondaryMobileNumber}</td>
       </tr>   
        <tr>
                <td><g:message code="userprofile.template.profile.faxnumber.label"/></td>
                <td>${userLoginprofile?.userContactDetail?.contact?.secondaryFaxNumber}</td>
       </tr>   
       <tr>
                <td><g:message code="userprofile.template.profile.emailid.label"/></td>
                <td>${userLoginprofile?.userContactDetail?.contact?.primaryEmailAddress}</td>
       </tr>     
     <g:if test="${userProfile?.nationality}">
       <tr>
                <td><g:message code="userprofile.template.profile.nationality.label"/></td>
                <td>${userProfile?.nationality?.description}</td>
       </tr>  
      </g:if>
       <g:if test="${userProfile?.gender}">
        <tr>
                <td><g:message code="userprofile.template.profile.gender.label"/></td>
                <td>${userProfile?.gender?.description}</td>
       </tr>  
       </g:if>
        <g:if test="${userProfile?.maritalStatus}">
       <tr>
                <td><g:message code="userprofile.template.profile.maritalstatus.label"/></td>
                <td>${userProfile?.maritalStatus?.description}</td>
       </tr>   
       </g:if>
          
              
	</table>
	</div>
</body>


</script>