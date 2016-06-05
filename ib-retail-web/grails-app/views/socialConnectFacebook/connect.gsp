<html>
<head>
    <title>Facebook Connect</title>
    <meta name='layout' content='facebookLayout'/>
</head>

<body>
	
	<h3>Connect to Facebook</h3>
	
	<g:form method="POST" controller="socialConnect" action="connect" params="[providerId:'facebook']">
     <input type="hidden" name="scope" value="user_hometown,user_interests,user_likes,user_location,email,offline_access,publish_stream,user_birthday" />
     <button><g:img dir="images/social/facebook" file="connect_light_medium_short.gif"/></button>
    </g:form>

</body>
</html>
