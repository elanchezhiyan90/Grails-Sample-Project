<g:if test="${errorCode}">
	<div class="failure">
	<p>
	<g:message code="${errorCode}" args="${args}" />
	</p>
	</div>
</g:if>
