<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"> <!--<![endif]-->

<body>
<g:set var="messages" value="${messageCenterResponse?.messages}" />
<form>
<div class="pd_list">

<header class="pd_hdr">
	<div class="pd_btns_right">
 		 <br/>
 		 <g:if test="${messageCenterResponse?.actionName?.equals('inbox')}">	    
         <g:submitToRemote class="btn_next" controller="messageCenter" name="reply" id="reply" action="reply" update="showReply" value="Reply" onSuccess="onReplySuccess(data,textStatus)">
         <g:hiddenField name="messageId" value="${messageCenterResponse?.message?.idVersion}"/>
         </g:submitToRemote>
         </g:if>
         <%-- <g:submitToRemote class="btn_next" controller="messageCenter" name="forward" action="forward" update=""
         onSuccess="onForwardSuccess(data,textStatus)" onFailure="onForwardFailure()" value="${g.message(code:'msgcenter.button.forward')}"
         before="if (checkFormValidity()) {return false;}"/>--%>
    </div>
</header>

<section class="pd_msgread">
<div id="showReply"> <!--Reply Text Editor Panel-->
</div>
<ul>
<g:each  in="${messages}" var="msgdetail" >
<g:if test="${msgdetail?.messageLabel=='DRAFT'}">
	<li>
		<g:set var="draftmsg" value="${msgdetail?.messageText}" />
		<g:render template="/messageCenter/templates/editDraft" model="draftmsg:${draftmsg}"></g:render>
	</li>
</g:if>
<g:else>
	<li>
	<header class="hdr_group">
        <g:if test="${msgdetail?.subjectId?.messageSubject?.code == 'OTHERS'}">
        	<h5>${msgdetail?.subjectId?.messageSubject?.description} - ${msgdetail?.messageSubject}</h5>
        </g:if>
        <g:elseif test="${msgdetail?.subjectId}">
			<h5>${msgdetail?.subjectId?.messageSubject?.description}
        </g:elseif>
        <g:else>
        	<h5>${msgdetail?.messageSubject}</h5>
        </g:else>
        
          <div class="hdr">from:<span class="frm">${msgdetail?.initiator?.userLogin}</span>
            <div><span class="dtd"><vayana:formatDate date='${msgdetail?.messageDate}' showTime="true"/></span></div>
             
        </div>
    </header>
    <article>
    <div id="msgTxt-${msgdetail?.id}">
    	${msgdetail?.messageText}
    </div>
    </article>
</li><br/>
</g:else>
<script>
var val = $("#msgTxt-"+${msgdetail?.id}).text();
var text = $.parseHTML(val);
$("#msgTxt-"+${msgdetail?.id}).empty().append(text);
</script>
</g:each>
</ul>
</section>
</div>
</form>
</body>

<script>

$(document).ready(function(){
	// Invoke API to get the folder label counts
	<g:remoteFunction controller="messageCenter" action="getMessagesByLabel" update="messagesCount"
			onSuccess="updateMsgCount(data,textStatus);" onFailure="updateMsgCountFailure();"/>
});

function onReplySuccess(data,textStatus)
{
	
	$("#showReply").empty();
	$("#showReply").html(data).dynamicfieldupdate();
}


function checkFormValidity()
{
	if(!$('form').checkValidity())
	{
	return true;
	}else
	{
	return false;
	}

}
</script>

</html>