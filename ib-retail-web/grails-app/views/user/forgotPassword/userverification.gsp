<head>
	<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">Logo</a></h1>
  </div>
</header>
 <g:render template="/user/forgotPassword/templates/verificationcontent"/> 
 <g:render template="/user/templates/footer"/>
 

</body>
<script>
 $(document).ready(function(){
  $("#customerId").bind('keyup', function (e) {
		
		    if (e.which >= 97 && e.which <= 122) {
		        var newKey = e.which - 32;
		        // I have tried setting those
		        e.keyCode = newKey;
		        e.charCode = newKey;
		    }
		
		    $("#customerId").val(($("#customerId").val()).toUpperCase());
		});	
 });
	 		
</script>
<%--</html>--%>