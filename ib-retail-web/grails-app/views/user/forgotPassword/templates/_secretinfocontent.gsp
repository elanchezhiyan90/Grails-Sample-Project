<div class="content">
	<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			<h2>
				${message(code:'forgetpassword.templates.secretinfocontent.h2.text') }
			</h2>
			<p>
				${message(code:'userregistration.templates.secretinfocontent.information.label') }
			</p>
			<br>
			<%--<div class="mandi-note">
				<span class="mandi"></span>
				<p>
					${message(code:'userregistration.templates.secretinfocontent.mandatoryfields.text') }
				</p>
			</div>
			<h3>
				${message(code:'userregistration.templates.secretinfocontent.h3.text') }
			</h3>--%>
			<vayana:flowerror />
			<g:form action="forgotPassword" controller="user" name="forgotPasswordForm">

				<div class="col-550">
					<%--<vayana:secretQuestions ulpId="${userVerificationResponseModel?.userLoginProfile?.id}"/>
					<br>
						<vayana:secureImages ulpId="${userVerificationResponseModel?.userLoginProfile?.id}"/>  
					<g:hiddenField name="ibUserLoginProfileId" id="ibUserLoginProfileId" value="${userVerificationResponseModel?.userLoginProfile?.id}"/>
					

					<g:render template="/user/forgotPassword/templates/loginsecurecolors"/>		
											
				--%>
				<div class="fields">
						<p>
							<label for="customerId"> ${message(code:'userregistration.templates.verificationcontent.customerid.label') }
							</label> <input type="text" name="customerId" id="customerId"
								placeholder="${message(code:'userregistration.templates.verificationcontent.customerid.placeholder.text') }"
								pattern="[0-9]*"
								data-errormessage="${message(code:'userregistration.templates.verificationcontent.customerid.error.message') }"
								autocomplete="off"  required="required"
								value="${fcustomerId}" readonly="readonly" />
						</p>

					</div>
					
					<div class="fields"> 
					<label for="cardNumber"> ${message(code:'userregistration.templates.verificationcontent.cardnumber.label') }</label>
					<p>
					<input class="card_split vs_txt" id="card1" name="card1"  type="text" pattern="[0-9]+"   maxlength="4"   onkeydown="warningAlert()" />
        			<input class="card_split vs_txt" id="card2" name="card2" type="text" pattern="[0-9]+"    maxlength="4"   autocomplete="off" disabled="disabled"   />
        			<input class="card_split vs_txt" id="card3" name="card3" type="text" pattern="[0-9]+"    maxlength="4"   autocomplete="off"disabled="disabled" />
        			<input class="card_split vs_txt" id="card4" name="card4" type="text" pattern="[0-9]+"    maxlength="4"   autocomplete="off" disabled="disabled"   /> 
        			<a class="vkey1"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20"  autocomplete="off"alt="Virtual Key"></a>
        			</p>
        			<g:hiddenField id="cardNumber" name="cardNumber" value=""/> 
        			</div>
					<div class="fields">
						<p>
							<label for="pinBlock"> ${message(code:'userregistration.templates.verificationcontent.pinnumber.label') }
							</label> <input class="pinNumber" type="password" name="pinNumber" id="pinNumber" onkeydown="warningAlertPin()"
								placeholder="${message(code:'userregistration.templates.verificationcontent.pinnumber.placeholder.text') }"
								data-errormessage="${message(code:'userregistration.templates.verificationcontent.pinnumber.error.message') }"
								autocomplete="off" required="required" autofocus="off"  maxlength="4"/><%--value="${pinNumber}"--%>
								<a class="vkey" id="vkeypin"><img
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
				</div>
				<div class="buttons">
							<input type="button" id="cancelTxn" value="Cancel" name="cancelTxn" class="cancelTxn btn_next" onclick="onclickCancel()"/>
							<g:submitButton name="usersealinfosubmit" onclick="checkFormInputs()" 
								value="${message(code:'userregistration.templates.logininfocontent.continue.button.text') }" />
						</div>
			</g:form>
			<g:render template="/user/templates/numvkeyboard"/><%-- 
			<g:render template="/user/templates/vkeyboard" />
		--%></section>  
	</div>

</div>

<g:javascript>


function onclickCancel(){
	var link = "<g:createLink action='user' controller='index' params='[]'/>"
	postUrl('forgotPasswordForm',link,'_self')
 }
 function postUrl(formName, url, targetName){
	var form = $('#'+formName);  
	form.attr('action',url);
	form.attr('method','POST');
	form.attr('target',targetName);
	form.submit();
 }
 
  	counter=1;
	function warningAlertPin(){	
		if(counter==1){	
			var x = "Bank recommends using virtual key-board and you must confirm taking full resposibility of not using it";
			var str = '<span style='+ '"' + 'background: url(' + '/ib-retail-web/themes/pmcb_theme/img/common/black-icon.png' + ') no-repeat scroll -796px -40px transparent;display: block;height: 30px;vertical-align: middle;width: 29px;' + '"' + '></span> ';
	
			x=str+'   ' + x;
			//alert(str); 
		
		    $('<div class="alert_popup">' + x + '</div>').dialog({
		        resizable: false,
		        title:"Warning message",
		        position:['middle',200],
		        draggable: false,
		        modal:true,
		        buttons: {
		            "Confirm": function() {		
		             counter++;    				            	
		                $(this).dialog("close");
		                  $("#pinNumber").focus();
		              		                <!-- $("#ibUserEncryptedPassCode").focus(); -->
		                         
		            },
		            Cancel: function() {
		          
		                  $("#pinNumber").focus();
		                $(this).dialog("close"); //close confirmation
		                 $(".vkey").click(); 
		              <!--  $("#ibUserEncryptedPassCode").focus(); -->
		            }
		        }		    
			});
		}	
	}
</g:javascript>