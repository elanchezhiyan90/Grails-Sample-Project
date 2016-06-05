<%@page import="akka.dispatch.OnFailure"%>
<g:form name="frmtwoFA">
<g:if test="${twofactortype.equals("OTP")}">

	<div class="fields">
				<p>
					<label for="start_dte">${message(code:'taglib.twofamodel.enterotp.label')}</label>
					<g:textField name="otpValue" id="otpValue" required="required" data-errormessage="${message(code:'taglib.twofamodel.pleaseenterotp.error.message')}" type="number" />
					 <vayana:submitToRemote controller="twoFactor" name="otpSubmit"
					 				   id="otpSubmit"					 				 
					 				    action="otpverification"
					 				    value="Ok" update="[failure:'messagesDiv']"
					 				    before="if (checkFormValidity()) {return false;};emptyErrorDiv();"
					 				    onSuccess="${remoteFunction( 
					 						    	controller :"${secondaryController}",													
											   		action:"${secondaryAction}", 														  						
					 								,onSuccess: 'onPaymentSuccess(data,textStatus);'
											 		,onFailure: 'onPaymentFailure(XMLHttpRequest.responseText);'											  		
					 					   			)}"
					 				    ></vayana:submitToRemote>
					 <input type="button" name="otp_cancel" value="${message(code:'taglib.twofamodel.cancel.button.text')}" id="otp_cancel" class="btn_next cee_close" />
				</p>
			</div>	
		
</g:if>
<%--Below field for OTP verfication request--%>
<g:hiddenField name="otpTransactionId" value="${otpgenmodel.transactionId}"/>
</g:form>