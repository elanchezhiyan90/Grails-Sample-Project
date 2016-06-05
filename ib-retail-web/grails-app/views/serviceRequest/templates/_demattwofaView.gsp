
<html>
	<head>
		<meta name="layout" content="payment" />
		<parameter name="themeName" value="${params.themeName}" />		
		  <g:hiddenField name="dematURL" value="${dematModel}"/>
	</head>
	<body >
	 <g:form name="dematForm">
		<div class="body-scroll">
			<!-- Timeline & form panel Starts Here -->
			<section>
				<vayana:messages />				
								
			</section>
		</div>
		</g:form>
		<!-- End of content -->
<script>
$(document).ready(function(){ 
var dematURL = $('#dematURL').val();
 //alert("dematURL"+dematURL);
   window.parent.location=dematURL;
<g:remoteFunction controller="demat" action="invokeAppLogout" />
<%--postUrl('dematForm',dematURL,'_self');--%>
	

});
</script>
</body>
</html>
