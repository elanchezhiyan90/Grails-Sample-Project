<html>
<head>
    <title>Facebook Profile</title>
    <meta name='layout' content='facebookLayout'/>
</head>

<body>

	<h3>Your Facebook Profile</h3>
	<p>Hello, ${profile.firstName}</p>
	<dl>
		<dt>Facebook ID:</dt>
		<dd>${profile.id}</dd>
		<dt>Name:</dt>
		<dd>${profile.name}</dd>
		<dt>Email:</dt>
		<dd>${profile.email}</dd>
		
		<img class="Photo" src="${createLink(controller:'springSocialFacebook', action:'profilePhoto')}" />
	</dl>
	
	<g:form method="DELETE" mapping="springSocialConnect" params="[providerId:'facebook']">
	    <button class="FBshare">Disconnect from Facebook</button>
	</g:form>


</body>
</html>
