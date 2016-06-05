<div class="content">
   <!-- applicatin content section starts here-->
  <div class="content-wrap"> 
    <section class="app-section">
    	<h2>Welcome to Online Internet Banking - Forgot Password</h2>
        <p>Kindly update your login credentials</p>
        <br>
<%--        <div class="mandi-note"><span class="mandi"></span><p>Mandatory fields</p></div>--%>
       <vayana:flowerror />
        <g:form action="authForgotPassword" controller="user">        	
        	<div class="col-550">            		
            		    <div class="fields">
						<p>
                        	<label for="log_id">Login ID</label>
							<input type="text" name="log_id" id="log_id" placeholder="Choose your UserId" value="${fIbUserLoginProfile?.userLogin}" disabled data-errormessage="Please enter Login ID" autocomplete="off"  autofocus />
                        </p>     
                    </div>
					<div class="fields">
						<p>
                        <label for="ibNewEncryptedPassCode">Login Password</label>
						<input type="password" name="ibNewEncryptedPassCode" id="ibNewEncryptedPassCode" placeholder="Choose your Password"  data-errormessage="Please enter Password" autocomplete="off"  required="required"  />
                        </p>
                        <p><br>
							<label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="keyer">
								${message(code:'user.templates.secure.enablevirtualkeypad.label') } </label>
						</p>
                        <!-- <div class="updater">Password strength indicator</div> -->
                          <div class="fieldnote">
                			<p>Click here to know about <a  href="#" class="ceebox" rel="width:500px; height:280px">Password policy</a></p>
                		</div>  
                    </div>
                    <div class="fields">
						<p>
                        <label for="ibNewEncryptedConfPassCode">Confirm Password</label>
						<input  placeholder="Confirm Your Password"    data-errormessage='{"dependent": "Password did not matched", "typeMismatch": "Please re-type password"}' data-dependent-validation="log_pass" type="password" name="ibNewEncryptedConfPassCode" id="ibNewEncryptedConfPassCode"      autocomplete="off" required="required" />
                        </p>
                    </div>
                    
                    <div class="buttons">
                        <g:submitButton name= "" class ="btn_next" value="Cancel"/> 
<%--                        <vayana:twoFAButton action="verifyloginpasscodeconfirm" buttonid="cnfrm_paynow"  controller="user" value="Confirm" twoFAModule="otp_paynow_div" name="verifyloginpasscodeconfirm"/> --%>
						<g:submitButton name="userlogininfosubmit" value="Change"/>    
					</div>
            </div><!-- col-280 ends here -->
        </g:form>
        
    </section>
  </div>
  
</div>