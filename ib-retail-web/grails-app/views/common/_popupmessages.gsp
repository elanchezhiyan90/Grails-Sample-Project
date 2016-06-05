<div id="popupMessagesDiv">
	<g:if test="${errorCode}">
		<div class="failure">
			<span></span>
			<g:message code="${errorCode}" args="${args}" />
		</div>
	</g:if>
</div>