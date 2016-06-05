<head>
	<meta name="layout" content="applayout" />
	<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<div class="pd_list">
		<h4>${message(code:'user.templates.preferences.h4.text') }</h4>
	    <g:form  method="POST" controller="socialConnect" action="connect" params="[providerId:'facebook']" target="connectWindow">
     		    <input type="hidden" name="scope" value="user_hometown,user_interests,user_likes,user_location,email,offline_access,publish_stream,user_birthday,user_likes,friends_birthday,user_photos" />
     		    <button class="connectButton btn_next"><g:img dir="images/social/facebook" file="connect_light_medium_short.gif"/></button>
   		</g:form>
 		<g:render template="/socialconnectfacebook/facebookMenu"/>
	</div>
</body>
</html>
