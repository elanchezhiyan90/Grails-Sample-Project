 
 <g:if test="${ibUserProfileModel?.ibUserLoginNameExist}">
 <div id="userNameExist" style="color:red">${message(code:'userregistration.templates.usernamevalidator.nameexist.message') }</div>
 </g:if>