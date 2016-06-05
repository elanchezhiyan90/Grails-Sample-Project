
<head>
	<ckeditor:resources />
</head>

<!-- Pulldown bar at top of page -->
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<div id="pdcontainer">
      <div id="pdmsgbody">
           <div id="pdmsgcont"><g:remoteLink controller="notification" action="notification" class="hidden"/></div>
           <div class="clx-pd"><span><g:message code="home.templates.header.close.label" /></span></div>
       </div>
       <div id="pdpoint" class="ui-resizable-handle ui-resizable-s" title="${g.message(code:'home.templates.header.dragme.tooltip.text')}">&equiv;&equiv;</div>
</div>
<!-- End pulldown bar  -->
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">${params.tenantShortDescription}</a></h1>
    <%--
     <nav class="app_tabs">
        <ul>
        	<li><a href="#"><span><h2><g:message code="default.home.label"/></h2></span></a></li>
        </ul>
    </nav>
    
    --%>
    
    <nav class="userinfo">
    <g:form id="frmNotification" name="frmNotification">
      <ul>
       <g:set var="userLoginProfile" value="${userProfileModel?.ibUserLoginProfile}"/>
       <g:set var="userProfile" value="${userProfileModel?.ibUserProfile}"/>
       <g:set var="customerName" value ="${userProfile?.getFirstName()}"/>
        <li class="dd-nav"> <a href="#"><span class="arw"></span>${customerName}</a></li>
		<li class="date-line"><vayana:postablelink id="datelinehome" controller="dateline" formName="frmNotification" target="canvas" linkTitle="${g.message(code:'home.templates.header.dateline.tooltip.text')}"><span>&nbsp;</span></vayana:postablelink></li>
<%--        <li class="alerter"><g:remoteLink controller="notification" action="alerts" onSuccess="onAlertsLoad(data,textStatus);" class="alertsIcon" title="${g.message(code:'home.templates.header.alerts.tooltip.text')}" ><span>0</span></g:remoteLink></li>--%>
<%--        <li class="inbox"><g:remoteLink controller="messageCenter" action="inbox" formName="frmNotification" onSuccess="onMsgCenterLoad(data,textStatus)" class="messagesIcon" title="${g.message(code:'home.templates.header.viewinbox.tooltip.text')}"><span>0</span></g:remoteLink></li>--%>
<%--		<li class="inbox"><a href="#"><span>0</span></a></li>--%>
       <li class="tools alerter">
        <g:remoteLink  update="pdmsgcont" controller="UserProfile" action="userpreferences" formName="frmNotification" title="${g.message(code:'home.templates.header.userpreferences.tooltip.text')}"/>
        </li>
        <li class="userphoto">
        	<a href="#">
        	 <g:if test="${userProfileModel?.faceBookId}">
        	 	<img src="http://graph.facebook.com/${userProfileModel?.faceBookId}/picture?width=96&height=96" alt="${customerName}" width="36" height="36">
        	 </g:if>
        	 <g:else>
        	 	<g:img dir="themes/pmcb_theme/img/branding" file="user_pic.jpg" width="36" height="36" title="${customerName}"/>
        	 </g:else>	
        	</a>
        </li>        
      </ul>
      </g:form>
      	<!-- drop down menu starts here -->
      	  <form  name="signoutform" id="signoutform" autocomplete='off' action="/ib-retail-web/j_spring_security_logout" method="post">
      	      <div class="dd-menu">
	            <div class="dd-info">
		             <g:if test="${userProfileModel?.faceBookId}">
        	 		    <img src="http://graph.facebook.com/${userProfileModel?.faceBookId}/picture?width=96&height=96" alt="${customerName}" height="96" width="96">
        		 	 </g:if>
        		 	 <g:else>
        	 			 <g:img dir="themes/pmcb_theme/img/branding" file="user_pic.jpg" width="66" height="66" title="${customerName}"/>
        	 		 </g:else>	
		             <div>
		                <p><g:message code="home.templates.header.lastsuccessfullogin.label" /><span><vayana:formatDate date='${userLoginProfile?.lastSuccessLogin}' showTime="true"/></span></p>
		                <p><g:message code="home.templates.header.lastunsuccessfullogin.label" /><span><vayana:formatDate date='${userLoginProfile?.lastFailureLogin}' showTime="true"/></span></p>
		                <g:submitToRemote url="[controller:'userProfile', action:'loginhistory']" value="${g.message(code:'home.templates.header.viewloginhistory.button.text')}" update="pdmsgcont" class="btn_next userInfo"/>
		             </div>
	            </div>
	            <div class="dd-btn">
                  <g:submitToRemote url="[controller:'userProfile', action:'profile']" value="${g.message(code:'home.templates.header.profile.button.text')}" update="pdmsgcont"  class="btn_next userInfo"/>
<%--                <g:submitButton id="btnsignout" name="btnsignout" value="${g.message(code:'home.templates.header.logout.button.text')}" />--%>
                  <input type="button" class="btn_next" id="btnsignout" name="btnsignout" value="${g.message(code:'home.templates.header.logout.button.text')}" />
	           </div>    
	        </div>	        
        </form>
       
      	<!-- drop down menu ENDS here -->
    </nav>
  </div>
</header>
<g:javascript>
$(function(){
	$("#btnsignout").on("click",function(){
		logoutAction();
	})

});

function onSecureSuccess(){

var basketId = $("#ibUserImageCategories option").each(function()
	{
	var imageBasketId = $(this).val();	
		if($("#userSelectedBasket").val()==imageBasketId)
		 {
		 	$(this).val(imageBasketId).attr("selected","selected") ;			
			$(this).parent("select").trigger("change");
		 }
		
		
	});
}
function getSecureCategoryId()
{
return $("#ibUserImageCategories").val();
}
function onSecureImageSuccess(data,textStatus)
{
$("#secureAccess").dynamicfieldupdate();
}
function checkFormValidity()
{
	if(!$('#changesecureaccess').checkValidity())
	{
	return true;
	}else
	{
	$("#submitNow").hide();
	return false;
	}

}
function onUpdateSuccess(data,textStatus)
{
	if(textStatus=='success')
	{
		var response =  $(data).first().html();	
		$("#errorDiv").empty();	
		$("#resultsuccess").show();
		$("#resultsuccess").html(response);
		$("#resultsuccess").dynamicfieldupdate();		
	}
}
function onUpdateError(responseText)
{
	$("#errorDiv").empty();
	$("#errorDiv").append(responseText);
	$("#submitNow").show();
}

function onMsgCenterLoad(data,textStatus)
{
	$("#pdmsgcont").fadeOut(500,function(){
				$(this).empty();
				$(this).html(data).dynamicfieldupdate(); 
				$(this).updatePolyfill(); inboxaction();
				
	}).fadeIn(500);
	
}

function onAlertsLoad(data,textStatus)
{
	$("#pdmsgcont").fadeOut(500,function(){
				$(this).empty();
				$(this).html(data).dynamicfieldupdate(); 
				$(this).updatePolyfill(); 
				
	}).fadeIn(500);
	
}
function logoutAction(){
		var x = "Are you sure you want to Logout of the current session";
			
		    $('<div>' + x + '</div>').dialog({
		        resizable: false,
		        height:140,
		        title:"Confirm Logout?",
		        position:['middle',200],
		        draggable: false,
		        modal:true,
		        buttons: {
		            "Ok": function() {
		                $("#signoutform").submit();
		                $(this).dialog("close");
		            },
		            Cancel: function() {
		                $(this).dialog("close"); //close confirmation
		            }
		        }
		    
		});
}
</g:javascript>