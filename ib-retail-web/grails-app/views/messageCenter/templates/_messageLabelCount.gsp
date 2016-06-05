<g:if test="${msgcntrResponse?.inboxCount && msgcntrResponse?.inboxCount != 0}">
	<g:set var="inboxCount" value="(${msgcntrResponse?.inboxCount})" />
</g:if>
<g:else>
	<g:set var="inboxCount" value="" />
</g:else>
<g:if test="${msgcntrResponse?.draftsCount && msgcntrResponse?.draftsCount != 0}">
	<g:set var="draftsCount" value="(${msgcntrResponse?.draftsCount})" />
</g:if>
<g:else>
	<g:set var="draftsCount" value="" />
</g:else>
<g:if test="${msgcntrResponse?.sentItemsCount && msgcntrResponse?.sentItemsCount != 0}">
	<g:set var="sentItemsCount" value="(${msgcntrResponse?.sentItemsCount})" />
</g:if>
<g:else>
	<g:set var="sentItemsCount" value="" />
</g:else>
<g:if test="${msgcntrResponse?.trashCount && msgcntrResponse?.trashCount != 0}">
	<g:set var="trashCount" value="(${msgcntrResponse?.trashCount})" />
</g:if>
<g:else>
	<g:set var="trashCount" value="" />
</g:else>
<ul>
<li><g:remoteLink controller="messageCenter" action="inbox" id="inboxsubmit"  update="[success:'pdmsgcont',failure:'messagesDiv']" title="${g.message(code:'home.messagecenter.header.viewinbox.tooltip.text')}">Inbox&nbsp;${inboxCount}</g:remoteLink></li>
<li><g:remoteLink controller="messageCenter" action="drafts" id="draftsubmit" update="[success:'pdmsgcont',failure:'messagesDiv']" title="${g.message(code:'home.messagecenter.header.viewdrafts.tooltip.text')}">Drafts&nbsp;${draftsCount}</g:remoteLink></li>
<li><g:remoteLink controller="messageCenter" action="sentItems" id="sentitemsubmit"  update="[success:'pdmsgcont',failure:'messagesDiv']" title="${g.message(code:'home.messagecenter.header.sentitems.tooltip.text')}">Sent Items&nbsp;${sentItemsCount}</g:remoteLink></li>
<li><g:remoteLink controller="messageCenter" action="trash" id="trash" update="[success:'pdmsgcont',failure:'messagesDiv']" title="${g.message(code:'home.messagecenter.header.trash.tooltip.text')}">Trash&nbsp;${trashCount}</g:remoteLink></li>

</ul>
<script>
	<%--
	function inboxsuccess(data,textStatus) {
		$("#selectlocation").empty();
		$("#selectlocation").prepend("<option value='TRASH' selected='selected'>TRASH</option>").dynamicfieldupdate();
		$("#mover").find("input").val("");
		}

	function trashsuccess(data,textStatus) {
		$("#selectlocation").empty();
		$("#selectlocation").prepend("<option value='INBOX' selected='selected'>INBOX</option>").dynamicfieldupdate();
		$("#mover").find("input").val("");
		}
	function sentItemsSuccess(data,textStatus){
		$("#selectlocation").empty();
		$("#selectlocation").prepend("<option value='INBOX' selected='selected'>INBOX</option>").dynamicfieldupdate();
		$("#mover").find("input").val("");

	}--%>

$(document).ready(function(){
	if('${msgcntrResponse?.inboxCount}'==''){
		$(".messagesIcon span").html('0');
	}
	else
	{
		$(".messagesIcon span").html(${msgcntrResponse?.inboxCount});
	}
	
});
</script>