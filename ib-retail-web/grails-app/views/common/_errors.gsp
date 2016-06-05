<div id="errorDiv">
<g:hasErrors bean="${errors}">
		<div class="error">
		  <ul>
			   <g:eachError var="err" bean="${errors}">
			       <li><g:message error="${err}" /></li>
			   </g:eachError>
		  </ul>
	    </div>
	</g:hasErrors>
	
	<g:if test="${flash.warning}">
		<div class="warning">${flash.warning}</div>
	</g:if>
	
	<g:if test="${flash.fatal}">
		<div id="deverrors" style="border-radius:15px; position:absolute; top:20%; left:0; width:80%; margin:0px 10%; padding:10px; border:solid 10px red; z-index:999999; background:#fff; box-shadow:0px 15px 57px 9px #666;">
			<div class="error">${flash.fatal}</div>
		</div>
	</g:if>
	
	<g:if test="${flash.error}">
		 <div class="error">${flash.error}</div>
	</g:if>
	
	<g:if test="${flash.success}">
		<div class="success">${flash.success}</div>
	</g:if>
	
	<g:if test="${flash.information}">
		<div class="info">${flash.information}</div>
	</g:if>
		
</div>