<div class="content">
   <!-- applicatin content section starts here-->
  <div class="content-wrap"> 
    <section class="app-section">
    	<h2>Forgot Password</h2>
        <p>Kindly enter the activation code to proceed</p>
        <br>
<%--        <div class="mandi-note"><span class="mandi"></span><p>Mandatory fields</p></div>--%>
       <vayana:flowerror />	
        <g:form action="authForgotPassword" controller="user" name="authForgotPasswordForm">
        	<div class="col-450">
            	
					<div class="fields">
						<p>						
                        <label for="activeCode">Activation Code</label>
						<input type="text" name="activeCode" id="activeCode" placeholder="(e.g:- 736353436)"   pattern="[0-9]*" data-errormessage="Please enter Numeric format" autocomplete="off"  autofocus="off"  required="required" />
                        </p>
                    </div>
                    <div class="buttons">
                        <a href="../../index.html" class="cancel">Cancel</a>
                        <g:submitButton name="userActivationSubmit" value="Continue"/>                       
					</div>
                
            </div><!-- col-280 ends here -->
        </g:form>
        
    </section>
  </div>
  
</div>