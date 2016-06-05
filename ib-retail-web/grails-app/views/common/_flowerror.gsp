
<g:hasErrors>
	<div class="failure">
		<g:eachError var="err" bean="${errors}">
			<li><g:message error="${err}" /></li>
		</g:eachError>
	</div>
</g:hasErrors>

<g:if test="${errorModel?.errorCode}">
	<div class="failure">
		<g:message code="${errorModel?.errorCode}" args="${errorModel?.args}" />
	</div>
</g:if>