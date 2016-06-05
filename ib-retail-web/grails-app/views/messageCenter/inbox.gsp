<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"> <!--<![endif]-->

<body>
<g:set var="inboxmessages" value="${messageCenterResponse?.messages}" />
<form name="formInboxMessages">
<vayana:messages/>
<section class="pd_list">
<br/>
<header class="pd_hdr">
<div class="pd_btns">
<span><g:checkBox id="selectall" name="selectall" />&nbsp;${g.message(code:'msgcenter.selectAll.label')}</span>



<g:submitToRemote controller="messageCenter" name="Delete" action="deleteMessage" id="deleteSubmit"  class="btn_next" value="Delete"
onSuccess="onDeleteSucess('${actionName}')" onFailure="onDeleteFailure()" />

</div>

<%-- 
<div id="selectlocationdiv"> 
<g:select name="selectlocation" id="selectlocation" from="${['INBOX','TRASH']}" keys="${['INBOX','TRASH'] }"/>
</div>	
--%>	
<g:submitToRemote controller="messageCenter" name="discardDraft" action="discardDraftMessages" id="discardDraft" 
	       onSuccess="discardDraftSuccess(data,textStatus);" value="${g.message(code:'msgcenter.discarddraft.label')}" class="btn_next"/>

<%--      				
<g:submitToRemote controller="messageCenter" name="Move" action="moveMessages" id="move"  class="btn_next" value="Move"
onSuccess="onMoveSucess('${actionName}')" onFailure="onMoveFailure()" />
--%>

<g:submitToRemote controller="messageCenter" name="deleteForever" id="deleteForever" action="deleteForever"   class="btn_next" value="Delete"
onSuccess="onDeleteForverSuccess(data,textStatus)" onFailure="onDeleteForeverFailure()" />
  
  <%-- <div class="pager">
       <input type="number"  step="any" name="pagenum" id="pagenum"  min="1" value="1"/>
        <span class="of">of 1</span>
        <a class="previous">Previous Page</a><a class="next">Next Page</a></div>--%>
   
</header>
 

<div class="mailbox_wrap">
<div class="mailbox_nav">
<g:submitToRemote controller="messageCenter" name="submit" action="compose" id="submit" 
	               onSuccess="onComposeSucess(data,textStatus)" onFailure="onComposeFailure()" value="Compose"/>
<br/><br/>
<div id="messagesCount">
<g:render template="/messageCenter/templates/messageLabelCount"></g:render>
</div>


</div>
<div class="mailbox_msgs">
<br/>
<ul class="msgs">
<g:hiddenField name="msgActionName" id="msgActionName" value="${messageCenterResponse?.actionName}"/>

<g:if test="${inboxmessages}">
<g:each  in="${inboxmessages}" var="inboxmsg" >
<li class="${inboxmsg?.userMessages?.get(0)?.statusType?.toString().equals('U') ? 'unrd' : '' }">
<span class="chk"><input type="checkbox"   name="selectmessage" id="selectmessage" class="selectedmessage" value="${inboxmsg?.id},${inboxmsg?.version}"/></span>
<g:remoteLink controller="messageCenter" action="messageDetails" params="{msgId:${inboxmsg?.id},msgVersion:${inboxmsg?.version},msgActionName:getActionName()}" onSuccess="onMessageDetailsSuccess(data,textStatus)">
	<g:if test="${messageCenterResponse?.actionName == 'inbox'}">
	<span class="frm">${inboxmsg?.initiator?.userLogin}</span>
	</g:if>
	<g:if test="${messageCenterResponse?.actionName == 'drafts'}">
	<span class="frm">Draft</span>
	</g:if>
	<g:if test="${messageCenterResponse?.actionName == 'sentItems'}">
	<span class="frm">${inboxmsg?.initiator?.userLogin}</span>
	</g:if>
	<g:if test="${messageCenterResponse?.actionName == 'trash'}">
	<span class="frm">${inboxmsg?.initiator?.userLogin}</span>
	</g:if>
	<g:if test="${inboxmsg?.subjectId}">
	<span class="sub">${inboxmsg?.subjectId?.messageSubject?.description} </span>
	</g:if>
	<g:else>
    	<span class="sub">${inboxmsg?.messageSubject}</span>
<%--    	 - ${inboxmsg?.messageText}--%>
    </g:else>
	<span class="dtd"><vayana:formatDate  name="msgDate" format="yyyy-MM-dd HH:MM" date="${inboxmsg?.messageDate}" /></span>
	<span class="atchmnt">attachment</span>
</g:remoteLink></li>
</g:each>
</g:if>

<g:else>
<li>
<p align="center">
	<b>${g.message(code:'msgcenter.messages.empty')}</b>
</p>
</li>
</g:else>
</ul>
</div>
</div>
</section>
</form>

<!-- JavaScript at the bottom for fast page loading --> 

</body>
<script>

$(document).ready(function(){
	$("#discardDraft").hide();
	$("#deleteForever").hide();
	$(".body-scroll").dynamicfieldupdate();
	// Invoke API to get the folder label counts
	<g:remoteFunction controller="messageCenter" action="getMessagesByLabel" update="messagesCount"
			onSuccess="updateMsgCount(data,textStatus);" onFailure="updateMsgCountFailure();"/>

if($("#msgActionName").val()=='drafts'){
	$("#discardDraft").show();
	$("#deleteSubmit").hide(); 
	//$("#selectlocationdiv").hide(); 
	//$("#move").hide(); 

}
if($("#msgActionName").val()=='trash'){
	$("#deleteForever").show();
	$("#deleteSubmit").hide();
	
}
		/************ Pagger buttons *************/
	 $( ".previous")
	 	.button({
        text: false,
        icons: { primary: "ui-icon-triangle-1-w"}
      	})
	 	.click(function() {
                
        })
	 .next()
	 .button({
        text: false,
        icons: { primary: "ui-icon-triangle-1-e"}
      	}).click(function(){
			
			}).parent()
                    .buttonset();
});

function onComposeSucess(data,textStatus)
{
	$("#discardDraft").hide();
	$("#deleteForever").hide();
	$(".mailbox_msgs").empty();
	$(".mailbox_msgs").html(data).dynamicfieldupdate();
}

function onComposeFailure()
{
	$(".mailbox_msgs").empty();
}

function updateMsgCount(data,textStatus)
{
	
	$(".messagesCount").html(data).dynamicfieldupdate();	
}

function updateMsgCountFailure()
{
	$(".messagesCount").empty();
}

function onMessageDetailsSuccess(data,textStatus)
{
	<%--$("#pdmsgcont").fadeOut(500,function(){
				$(this).empty();
				$(this).html(data).dynamicfieldupdate(); 
				$(this).updatePolyfill(); inboxaction();
				
	}).fadeIn(500); --%>
	$(".mailbox_msgs").empty();
	$(".mailbox_msgs").html(data).dynamicfieldupdate();
	
}
$(function(){
	$("#selectall").click(function() {
	    if($(this).is(":checked")){
	        $(".selectedmessage").prop("checked",true);
	        }
	    else{
	      
	        $(".selectedmessage").prop("checked",false);

	        }
		});
});

function onDraftSuccess(data,textStatus)
{
	$("#inboxsubmit").trigger("click");
}

function onDraftFailure()
{
	 //$("#chargesdisplay").dynamicfieldupdate();
	 $("#frmComposeMessage").empty();
}

function onSendFailure()
{
	$("#frmComposeMessage").empty();
}

function onDeleteFailure()
{
	$("#inboxsubmit").empty();
}

function onMoveSucess(actionName)
{ 
	if(actionName=='inbox')
	{
		$("#inboxsubmit").trigger("click");
	}
	else if(actionName=='sentItems')
	{
		$("#sentitemsubmit").trigger("click");
	}
	else if(actionName=='trash')
	{
		$("#trash").trigger("click");
	}
}

function onMoveFailure()
{
	$("#inboxsubmit").empty();
}
function onDeleteSucess(actionName){

	if(actionName=='inbox')
	{
		$("#inboxsubmit").trigger("click");
	}
	else if(actionName=='sentItems')
	{
		$("#sentitemsubmit").trigger("click");
	}else if(actionName=='trash')
	{
		$("#trash").trigger("click");
	}
	
}
function discardDraftSuccess(data,textStatus){

	$("#draftsubmit").trigger("click");
}

function onDeleteForverSuccess(data,textStatus){
	$("#trash").trigger("click");	
}

function getActionName()
{
	return $("#msgActionName").val(); 
}

function onSendSuccess(data,textStatus)
{
	
	$("#inboxsubmit").trigger("click");
	$("#messagesDiv").dynamicfieldupdate();
	
}
</script>
</html>