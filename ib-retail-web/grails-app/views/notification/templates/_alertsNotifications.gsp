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
							params="[alertnonifyreceiptId:alertNotifyNotification?.id,changeOriginFlag:'${changeOriginFlag}']"
							update="alerts">X</g:remoteLink>
				</span></span></li>
		</g:each>
	</g:if>
	<g:else>
		You have no new Notifications.
	</g:else>
</ul>
<script>
$(function(){
	var total = ${totalAlertsCount}; 
	$(".alertsIcon span").html(total);
});
</script>