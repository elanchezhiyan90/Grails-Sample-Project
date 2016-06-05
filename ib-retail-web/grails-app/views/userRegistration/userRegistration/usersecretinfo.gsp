<head>
<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">${message(code:'userregistration.userregistration.usersecretinfo.h1.text') }</a></h1>
  </div>
</header>
 
<g:render template="/userRegistration/templates/secretinfocontent"/> 
<g:render template="/user/templates/footer"/>
</body>
</html>
<g:javascript>
function preCheck(){
$(".failure").remove();
}
</g:javascript>