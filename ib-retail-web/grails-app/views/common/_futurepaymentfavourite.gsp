<g:if test="${!favPaymentDetailModel?.paymentScheduleDetail?.isEmpty()}">
		<ul id="ulpastpayment">
			<g:each var="paymentScheduleDetail"
				in="${favPaymentDetailModel?.paymentScheduleDetail}">
				<li><span class="dte"><vayana:formatDate date="${paymentScheduleDetail?.paymentDate}" /></span> 
				<g:if test="${paymentScheduleDetail?.paymentAmount <= 0}">
						 	<span class="amt">${message(code:'biller.templates.schedulepaymentreview.billpaysipending.billpending.label') }</span>
				</g:if>
				<g:else>
					<span class="amt"><vayana:formatAmount
							amount="${paymentScheduleDetail?.paymentAmount}"
							currency="${paymentScheduleDetail?.paymentCurrency?.code}" /></span> 
							
					<span class="cur">
						${paymentScheduleDetail?.paymentCurrency?.code}
				</span> 
				
				<span class="fav"> <g:if
							test="${paymentScheduleDetail?.favoriteFlag?.equals("Y") }">
							<input type="checkbox" checked="checked" name="fav_tran"
								onclick="setFavourite(${paymentScheduleDetail?.id},${payeeInsOrBeneId},${paymentScheduleDetail?.payerInstruction?.id});${remoteFunction(controller:"${secondaryController}",update:'f-panel',action:"${secondaryAction}",params:'\'paymentId=\'+getFavourite()+\'&beneId=\'+getPayeeInsBeneId()+\'&payeeId=\'+getPayeeId()+\'&favouriteId=\'+getFavouriteId()' ,onSuccess: 'onFavSuccess(data,textStatus);') } "
								id="checkbox${paymentScheduleDetail?.id}" value="radio"
								data-frmacc="${paymentScheduleDetail?.payerInstruction?.id}"
								data-toacc="${paymentScheduleDetail?.payeeInstruction?.id}"
								data-toamt="${paymentScheduleDetail?.paymentAmount}"
								data-currency="${paymentScheduleDetail?.paymentCurrency?.code}" 
								data-remarks="${paymentScheduleDetail?.remarks}"/>
						</g:if> <g:else>
							<input type="checkbox"								
								onclick="setFavourite(${paymentScheduleDetail?.id},${payeeInsOrBeneId},${paymentScheduleDetail?.payerInstruction?.id});${remoteFunction(controller:"${secondaryController}",update:'f-panel',action:"${secondaryAction}",params:'\'paymentId=\'+getFavourite()+\'&beneId=\'+getPayeeInsBeneId()+\'&payeeId=\'+getPayeeId()+\'&favouriteId=\'+getFavouriteId()' ,onSuccess: 'onFavSuccess(data,textStatus);') } "
								name="fav_tran" id="checkbox${paymentScheduleDetail?.id}"
								value="radio"
								data-frmacc="${paymentScheduleDetail?.payerInstruction?.id}"
								data-toacc="${paymentScheduleDetail?.payeeInstruction?.id}"
								data-toamt="${paymentScheduleDetail?.paymentAmount}"
								data-currency="${paymentScheduleDetail?.paymentCurrency?.code}" 
								data-remarks="${paymentScheduleDetail?.remarks}"/>
						</g:else>
				</span>
				</g:else>
				</li>
			</g:each>
		</ul>
	</g:if>
	<g:else>
		<br>
		<span><g:message code="payment.templates.friendsandfamily.transferfavourite.noscheduledpayments.label" /></span>
		<br>
	</g:else>