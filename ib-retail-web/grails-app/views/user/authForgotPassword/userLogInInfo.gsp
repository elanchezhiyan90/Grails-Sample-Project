<head>
	<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">Logo</a></h1>
  </div>
</header>
<g:render template="/user/authForgotPassword/templates/loginInfoContent"/> 
<g:render template="/user/templates/footer"/>
<g:javascript>
$(document).ready(function(){
	$(".ceebox").ceebox();
	
});
function checkFormValidity()
{
	if(!$('form').checkValidity())
	{
		return true;
	}
	else
	{
		return false;
	}
}



		
</g:javascript>
</body>
</html>