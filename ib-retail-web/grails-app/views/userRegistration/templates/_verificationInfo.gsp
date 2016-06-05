<vayana:flowerror />
			<g:form action="userRegistration" controller="userRegistration"
				name="registrationForm" autocomplete="off" >
				<div class="col-450">

					<div class="fields">
						<p>
							<label for="customerId"> ${message(code:'userregistration.templates.verificationcontent.customerid.label') }
							</label> <input type="text" name="customerId" id="customerId"
								placeholder="${message(code:'userregistration.templates.verificationcontent.customerid.placeholder.text') }"
								pattern="[0-9]*"
								data-errormessage="${message(code:'userregistration.templates.verificationcontent.customerid.error.message') }"
								autocomplete="off" autofocus="off" required="required"
								value="${fcustomerId}" readonly="true" />
						</p>

					</div>
					<div class="fields"> 
					<label for="cardNumber"> ${message(code:'userregistration.templates.verificationcontent.existinguserloginid.label') }</label>
					<p>
					<input type="text" 
								name="existLoginId" id="existLoginId"  pattern="[a-zA-Z0-9]+" value="${fcustomerId}" readonly="true"
								placeholder="${message(code:'user.templates.content.loginid.placeholder') }" required="required"
								data-errormessage="${message(code:'user.templates.content.loginid.error.message') }" autocomplete="off"
								/>
        			<%--<input class="card_split vs_txt" id="card1"  type="text" pattern="[0-9]+" maxlength="4" />
        			<input class="card_split vs_txt" id="card2"  type="text" pattern="[0-9]+" maxlength="4"  disabled="disabled" />
        			<input class="card_split vs_txt" id="card3"  type="text" pattern="[0-9]+" maxlength="4"  disabled="disabled" />
        			<input class="card_split vs_txt" id="card4"  type="text" pattern="[0-9]+" maxlength="4"  disabled="disabled" />
        			<a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>
        			--%></p>
<%--        			<g:hiddenField id="cardNumber" name="cardNumber" value=""/>     --%>
   					</div>
<%--					<div class="fields">--%>
<%--						<p>--%>
<%--							<label for="cardNumber"> ${message(code:'userregistration.templates.verificationcontent.cardnumber.label') }--%>
<%--							</label> <input type="text" class="cc_txt" name="cardNumber" id="cardNumber"--%>
<%--								placeholder="${message(code:'userregistration.templates.verificationcontent.cardnumber.placeholder.text') }"--%>
<%--								pattern="[0-9]*.{16}"--%>
<%--								data-errormessage="${message(code:'userregistration.templates.verificationcontent.cardnumber.error.message') }"--%>
<%--								autocomplete="off" required="required" value="${fcardNumber}" />--%>
<%--								<a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>--%>
<%--						</p>--%>
<%--					</div>--%>
					<div class="fields">
						<p>
							<label for="pinBlock"> ${message(code:'userregistration.templates.verificationcontent.existingusrpwd.label') }
							</label> <input type="password" name="existUsrPwd" id="existUsrPwd"
								placeholder="${message(code:'userregistration.templates.verificationcontent.pinnumber.placeholder.text') }"
								data-errormessage="${message(code:'userregistration.templates.verificationcontent.pinnumber.error.message') }"
								autocomplete="off" required="required"  /><%--value="${pinNumber}"--%>
								<a class="vkey"><img
								src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png"
								width="20" height="20" alt="Virtual Key"
								title="Use Virtual KeyBoard to enter your password"></a>
<%--								<a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>--%>
						</p>
					</div>
					<%--<div class="fields">
						<p>
							<label for="issuedDate"> ${message(code:'userregistration.templates.verificationcontent.issuedate.label') }
							</label> <input type="date" name="cardIssuedDate" id="issuedDate"
								data-errormessage="${message(code:'userregistration.templates.verificationcontent.issuedate.placeholder.text') }"
								autocomplete="off" required="required"
								value="${fcardIssuedDate}" />
						</p>

					</div>
					<div class="fields">
						<p>
							<label for="validUpto"> ${message(code:'userregistration.templates.verificationcontent.expirydate.label') }
							</label> <input type="date" name="cardValidUpto" id="validUpto"
								data-errormessage="${message(code:'userregistration.templates.verificationcontent.expirydate.placeholder.text') }"
								autocomplete="off" required="required" value="${fcardValidUpto}">
						</p>

					</div>
					<div class="fields">
						<p>
							<label for="nameOnCard"> ${message(code:'userregistration.templates.verificationcontent.nameoncard.label') }
							</label> <input type="text" name="nameOnCard" id="nameOnCard"
								placeholder="${message(code:'userregistration.templates.verificationcontent.nameoncard.placeholder.text') }"
								data-errormessage="${message(code:'userregistration.templates.verificationcontent.nameoncard.error.message') }"
								autocomplete="off" required="required" value="${fnameOnCard}" />
						</p>
					</div>	--%>			

<%--					<g:if test="${params?.showCaptcha.equals('y')}">--%>
						<div class="fields">
							<vayana:captcha />
						</div>
<%--					</g:if>--%>
					
					<div class="buttons">
						<input type="button" id="cancelTxn" value="Cancel" name="cancelTxn" class="cancelTxn btn_next" onclick="onclickCancel()"/>
						<g:submitButton name="userVerificationSubmit" 
							value="${message(code:'userregistration.templates.verificationcontent.continue.button.text') }" 
							onclick="preCheck()"/>
					</div>
<%--					<g:render template="/user/templates/numvkeyboard"/> --%>
						<g:render template="/user/templates/vkeyboard" />
				</div>				
			</g:form>
			
<script>

function onclickCancel(){
	var link = "<g:createLink action='tenant' controller='index' params='[]'/>"
	postUrl('registrationForm',link,'_self')
}
function postUrl(formName, url, targetName){
	var form = $('#'+formName);  
	form.attr('action',url);
	form.attr('method','POST');
	form.attr('target',targetName);
	form.submit();
}
</script>
