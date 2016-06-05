<div id="userLoginAutoComp">
		<p>
			<g:if test="${"YES".equals(isRequired)}">
				<g:textField name="${name}" id="${name}" class="userLoginAuto"
					required="required" placeholder="Enter User Login"
					data-errormessage="Please Choose User Login"></g:textField>
			</g:if>
			<g:else>
				<g:textField name="${name}" id="${name}" class="userLoginAuto"
					placeholder="Enter User Login"></g:textField>
			</g:else>
		</p>
		<g:hiddenField name="${paramsHolderName}" id="${paramsHolderName}"
			class="paramsHolderName" value=""></g:hiddenField>
</div>
<script>
$(function(){
	$("#userLoginAutoComp").dynamicfieldupdate();
});
$(".userLoginAuto").autocomplete({
	source: function( request, response ) {
	$.ajax({
	    url: "<%=request.getContextPath()%>/common/userIdAutoCompleter",
	    data:{term: request.term},
	    
	    success: function(data){
	     response(data); 
	    },
	    error: function(){
	    }
	   });
	},
	change: function(event,ui){
   	  $(this).val((ui.item ? ui.item.value : ""));
   	  $(".paramsHolderName").val((ui.item ? ui.item.idVersion : ""));
   	},
	minLength: 2,
	});
</script>