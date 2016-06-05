<div class="content">
   <!-- applicatin content section starts here-->
  <div class="content-wrap"> 
    <section class="app-section">
    	<h2>Forgot Password</h2>
        <p>Kindly provide information  below</p>
        <br>
        <%--<div class="mandi-note"><span class="mandi"></span><p>Mandatory fields</p></div>--%>
       <vayana:flowerror />	
        <g:form action="forgotPassword" controller="user" name="verificationForm">
        	<div class="col-450">
            	
					<div class="fields">
						<p>
                        <label for="customerId">${message(code:'user.templates.content.loginid.label') }</label>
						<input type="text" name="customerId" id="customerId" placeholder="(e.g:- XXXXXX)"  data-errormessage="${message(code:'user.templates.content.loginid.error.message') }" autocomplete="off"  autofocus="off"  required="required" />
                        </p>
                       
                    </div>
                   
                    <div class="buttons">
                    	<input type="button" id="cancelTxn" value="Cancel" name="cancelTxn" class="cancelTxn btn_next" onclick="onclickCancel()"/>
                        <g:submitButton name="userVerificationSubmit" value="Continue"/>                       
					</div>
                
            </div><!-- col-280 ends here -->
        </g:form>
        
    </section>
  </div>
  
</div>


<g:javascript>
$(document).ready(function(){
 $("#customerId").bind('keyup', function (e) {
		
		    if (e.which >= 97 && e.which <= 122) {
		        var newKey = e.which - 32;
		        // I have tried setting those
		        e.keyCode = newKey;
		        e.charCode = newKey;
		    }
		
		    $("#customerId").val(($("#customerId").val()).toUpperCase());
		});
	
 });

function onclickCancel(){
	var link = "<g:createLink action='user' controller='index' params='[]'/>"
	postUrl('verificationForm',link,'_self')
 }
 function postUrl(formName, url, targetName){
	var form = $('#'+formName);  
	form.attr('action',url);
	form.attr('method','POST');
	form.attr('target',targetName);
	form.submit();
 }
</g:javascript>
 


