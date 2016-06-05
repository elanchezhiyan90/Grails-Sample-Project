<g:if test="${!favPaymentDetailModel?.pastPaymentDetail?.isEmpty()}">
		<ul id="ulpastpayment">
			<g:each var="pastPaymentDetail"
				in="${favPaymentDetailModel?.pastPaymentDetail}">
				<li><span class="dte"><vayana:formatDate
							date="${pastPaymentDetail?.paymentDate}" /></span> 
							<span class="amt">
								<span class="cur">${pastPaymentDetail?.paymentCurrency?.code}</span>
								<vayana:formatAmount
								amount="${pastPaymentDetail?.paymentAmount}"
								currency="${pastPaymentDetail?.paymentCurrency?.code}" />
							</span> 
							
							<span class="fav"> <g:if
							test="${pastPaymentDetail?.favoriteFlag?.equals("Y") }">
							<input type="checkbox" checked="checked" name="fav_tran"
								onclick="setFavourite(${pastPaymentDetail?.id},${payeeInsOrBeneId},${pastPaymentDetail?.payerInstruction?.id});${remoteFunction(controller:"${secondaryController}",update:'f-panel',action:"${secondaryAction}",params:'\'paymentId=\'+getFavourite()+\'&beneId=\'+getPayeeInsBeneId()+\'&payeeId=\'+getPayeeId()+\'&favouriteId=\'+getFavouriteId()' ,onSuccess: 'onFavSuccess(data,textStatus);') } "
								id="checkbox${pastPaymentDetail?.id}" value="radio"
								data-frmacc="${pastPaymentDetail?.payerInstruction?.id}"
								data-toacc="${pastPaymentDetail?.payeeInstruction?.id}"
								data-toamt="${pastPaymentDetail?.paymentAmount}"
								data-currency="${pastPaymentDetail?.paymentCurrency?.id}" 
								data-remarks="${pastPaymentDetail?.remarks}"
								data-amounttype="${pastPaymentDetail?.creditCardAmountType?.id}"/>		
						</g:if> <g:else>
							<input type="checkbox"
								onclick="setFavourite(${pastPaymentDetail?.id},${payeeInsOrBeneId},${pastPaymentDetail?.payerInstruction?.id});${remoteFunction(controller:"${secondaryController}",update:'f-panel',action:"${secondaryAction}",params:'\'paymentId=\'+getFavourite()+\'&beneId=\'+getPayeeInsBeneId()+\'&payeeId=\'+getPayeeId()+\'&favouriteId=\'+getFavouriteId()' ,onSuccess: 'onFavSuccess(data,textStatus);') } "
								name="fav_tran" id="checkbox${pastPaymentDetail?.id}" value="radio"
								data-frmacc="${pastPaymentDetail?.payerInstruction?.id}"
								data-toacc="${pastPaymentDetail?.payeeInstruction?.id}"
								data-toamt="${pastPaymentDetail?.paymentAmount}"
								data-currency="${pastPaymentDetail?.paymentCurrency?.id}" 
								data-remarks="${pastPaymentDetail?.remarks}"
								data-amounttype="${pastPaymentDetail?.creditCardAmountType?.id}"/>		
						</g:else>
				</span></li>
			</g:each>
		</ul>
	</g:if>
	<g:else>
		<br>
		<span><g:message code="payment.templates.friendsandfamily.transferfavourite.nopastpayments.label" /></span>
		<br>
	</g:else>