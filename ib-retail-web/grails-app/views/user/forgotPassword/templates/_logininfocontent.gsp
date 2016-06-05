<div class="content">
   <!-- applicatin content section starts here-->
   	
  <div class="content-wrap"> 
    <section class="app-section">
    	<h2>Welcome to Online Internet Banking - Forgot Password</h2>
        <p>Kindly update your login credentials</p>
        <br>
        <%--<div class="mandi-note"><span class="mandi"></span><p>Mandatory fields</p></div>
       --%><vayana:flowerror />
        <g:form action="forgotPassword" controller="user" name="forgotPasswordForm">   
        <g:hiddenField id="ulpId" name="ulpId" value="${userVerificationResponseModel?.getUserLoginProfile()?.getId()}"/>      	
        	<div class="col-550"><%--            		
            		    <div class="fields">
						<p>
                        	<label for="log_id">Login ID</label>
							<input type="text" name="log_id" id="log_id" placeholder="Choose your UserId" value="${userVerificationResponseModel?.userLoginName}" disabled data-errormessage="Please enter Login ID" autocomplete="off"  autofocus />
                        </p>     
                       </div>
					           --%>
					<div class="fields">
						<p>
                        <label for="ibNewEncryptedPassCode"> New Login Password</label>
						<input type="password" name="ibNewEncryptedPassCode" id="ibNewEncryptedPassCode" placeholder="Choose your Password"   data-errormessage="Please enter Password" autocomplete="off"  required="required" />
                        </p>                        
                        <p><br>							
						<a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>
						</p>
						
                        <!-- <div class="updater">Password strength indicator</div> -->
                        <div class="fieldnote">
                			<p>${message(code:'userprofile.template.transactionpassword.clickheretoknowabout.text')}
                			<g:remoteLink  controller="user" action="showPasswordPolicy" update="pwdPolicyDialog" onSuccess="openPwdPolicy()">
								<g:message code="userregistration.templates.logininfocontent.passwordpolicy.text"/>
							</g:remoteLink>
                			 </p>
                		</div> 
                		
                		
                    </div>
                    <div class="fields">
						<p>
                        <label for="ibNewEncryptedConfPassCode"> Confirm Login Password</label>
						<input  placeholder="Confirm Your Password"    data-errormessage='{"dependent": "Password did not matched", "typeMismatch": "Please re-type password"}' data-dependent-validation="ibNewEncryptedPassCode" type="password" name="ibNewEncryptedConfPassCode" id="ibNewEncryptedConfPassCode"   autocomplete="off" required="required" />
                        </p>
                    </div>
                    
                    <div class="buttons">
                    	<input type="button" id="cancelTxn" value="Cancel" name="cancelTxn" class="cancelTxn btn_next" onclick="onclickCancel()"/>
                        <g:submitButton name="userlogininfosubmit" value="Change"/>
                   
                 
					</div>
            </div><!-- col-280 ends here -->
            <g:render template="/user/templates/vkeyboard"/> 
        </g:form>
        <div id="pwdPolicyDialog"
				title="${g.message(code:'userregistration.templates.logininfocontent.passwordpolicy.text')}"
				style="display: none; height: 280px; width: 500px;"
				class="body-scroll"></div>
    </section>
  </div>
  
</div>

<g:javascript>





</g:javascript>
