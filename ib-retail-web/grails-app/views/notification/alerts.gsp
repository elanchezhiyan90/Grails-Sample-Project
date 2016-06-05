<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->

<head>
<meta charset="utf-8">
<title><g:message code="notification.alerts.title" /></title>
</head>

<body>
	<section class="pd_list">
		<h4>
			<g:message code="notification.alerts.h4.text" />
		</h4>
		<div id="alerts">
			<ul class="alts">

				<g:if test="${notificationsModel}">
					<g:each in="${notificationsModel}" var="alertNotifyNotification">
						<li><span class="dtl"> <b>
									${alertNotifyNotification.alertNotification.customerMessageSubject}
									:
							</b> ${alertNotifyNotification.alertNotification.customerMessageBody}
						</span><span>${alertNotifyNotification.alertNotification.alertNotificationDate}</span><span class="act"><span class="clx"> <g:remoteLink
										class="remove" controller="notification"
										action="notificationstatus"
										params="[alertnonifyreceiptId:alertNotifyNotification?.id,changeOriginFlag:'A']"
										update="alerts">X</g:remoteLink>
							</span></span></li>
					</g:each>
				</g:if>
				<g:else>
					You have no new Notifications.
				</g:else>
			</ul>
		</div>
	</section>
</body>
<script>
<%--$(document).ready(function(){--%>
<%--	var total = ${notificationsModel.size()}; --%>
<%--	$(".alertsIcon span").html(total);--%>
<%--});--%>
</script>
</html>
