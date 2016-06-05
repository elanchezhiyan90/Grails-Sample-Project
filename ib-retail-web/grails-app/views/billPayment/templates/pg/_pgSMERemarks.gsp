<div class="success">
	<span></span>
	<p>
		<b> Payment Gateway Record sent for authorization. </b>
	</p>
</div>
<form  name="signoutform" id="signoutform" autocomplete='off' action="/ib-retail-web/j_spring_security_logout" method="post">
</form>
<script>
  	$(document).ready(function() {
  	
  	setTimeout(function(){
  		$("#signoutform").submit();
		}, 2000);
  		
  	});  	
</script>