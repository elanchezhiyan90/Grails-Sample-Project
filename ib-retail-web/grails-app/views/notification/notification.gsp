<!DOCTYPE HTML>
<head>
<meta charset="utf-8">
<title><g:message code="notification.notification.title" /></title>
</head>

<body>
	<div id="notification">
		<section class="pd_list">
			<!--         Alerts starts here       -->
			<%--<h4>
				<g:message code="notification.notification.h4.text" />
			</h4>
			<div id="alerts">
				<ul class="alts">
					<g:if test="${notificationsModel}">
						<g:each in="${notificationsModel}" var="alertNotifyNotification">
							<li><span class="dtl"> <b> ${alertNotifyNotification.alertNotification.customerMessageSubject}
										:
								</b> ${alertNotifyNotification.alertNotification.customerMessageBody}
							</span><span> ${alertNotifyNotification.alertNotification.alertNotificationDate}
							</span><span class="act"><span class="clx"> <g:remoteLink
											class="remove" controller="notification"
											action="notificationstatus"
											params="[alertnonifyreceiptId:alertNotifyNotification?.id,changeOriginFlag:'D']"
											update="alerts">X</g:remoteLink>
								</span></span></li>
						</g:each>
					</g:if>
					<g:else>
					You have no new Notifications.
				</g:else>
				</ul>
			</div>
			--%><!--         Message starts here       -->
			<%--<h4>
				<g:message code="notification.notification.messages.h4.label" />
			</h4>
			<ul class="msgs">
				<g:if test="${messageModel}">
					<g:each in="${messageModel}" var="usermessage">
						<li class="unrd"><g:remoteLink controller="messageCenter"
								action="notificationDetails"
								params="[msgId:usermessage?.message?.id,msgVersion:usermessage?.message?.version,msgActionName:'inbox']"
								onSuccess="onMessageDetailSuccess(${usermessage?.message?.id},${usermessage?.message?.version},'inbox',data,textStatus)">
								<span class="frm"> ${usermessage?.message?.initiator?.userLogin}
								</span>
								<span class="sub"> ${usermessage?.message?.messageSubject}
								</span>
								<span class="dtd"> 
									<vayana:formatDate  name="msgDate" format="yyyy-MM-dd HH:MM" date="${usermessage?.message?.messageDate}" />
								</span>
							</g:remoteLink></li>
					</g:each>
				</g:if>
				<g:else>
					You have no unread messages.
				</g:else>
			</ul>
		--%></section>
	</div>
</body>
<script>
$(document).ready(function(){
	var total = ${totalAlertsCount}; 
	$(".alertsIcon span").html(total);
	
	var msgs = ${totalUnreadMessages};
	$(".messagesIcon span").html(msgs);
});
function onMessageDetailSuccess(id,version,actionname,data,textStatus)
{
	$("#pdmsgcont").html(data).dynamicfieldupdate();
	<g:remoteFunction controller="messageCenter" action="messageDetails" update="mailbox_msgs"  params="\'msgId=\' + id+\'&msgVersion=\'+version+\'&msgActionName=\'+actionname" onSuccess='onDetailsSuccess(data,textStatus)'></g:remoteFunction>
}
function onDetailsSuccess(data,textStatus){

    $(".mailbox_msgs").empty();
	$(".mailbox_msgs").html(data).dynamicfieldupdate();
	
}
</script>
