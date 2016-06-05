
<body>
   
<g:form name="changepassword">

 
	
 	<div class="col-370">
			<div class="fields">
				<p>
					<label for="ibUserEncryptedPassCode">${message(code:'userprofile.template.changepassword.existingloginpassword.label')}</label>
					<input type="password" name="ibUserEncryptedPassCode" id="ibUserEncryptedPassCode" maxlength="19" placeholder="${message(code:'userprofile.template.changepassword.enterpassword.placeholder.text')}"  data-errormessage="${message(code:'userprofile.template.changepassword.password1.error.message')}" autocomplete="off"  required="required" />
				<a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>
				</p>
			 </div>
				
			   <div class="fields">
						<p>
                        <label for="ibNewEncryptedPassCode">${message(code:'userprofile.template.changepassword.newloginpassword.label')}</label>
						<input type="password" name="ibNewEncryptedPassCode" id="ibNewEncryptedPassCode" maxlength="19" placeholder="${message(code:'userprofile.template.changepassword.choosepassword.placeholder.text')}"  data-errormessage="${message(code:'userprofile.template.changepassword.password2.error.message')}" autocomplete="off" onkeydown="warningAlert()" required="required"  />
                        <a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>
                        </p>
                        <!-- <div class="updater">Password strength indicator</div> --><%--
	                          <div class="fieldnote">
	                			<p>${message(code:'userprofile.template.changepassword.clickheretoknowabout.text')} <a  href="#" class="ceebox" rel="width:500px; height:280px">${message(code:'userprofile.template.changepassword.passwordpolicy.text')}</a></p>
	                		</div>
               --%>
               
                        <div class="fieldnote">
							<p>
								${message(code:'userprofile.template.changepassword.clickheretoknowabout.text') }
								<%--<a href="${createLink(controller:'userProfile' ,action:'showPasswordPolicy')}" rel="width:500px; height:280px"
									class="ceebox linker" title="${g.message(code:'userprofile.template.changepassword.clickheretoknowabout.text')}">
									${message(code:'userregistration.templates.logininfocontent.passwordpolicy.text') }
									</a>
									
									--%><g:remoteLink  controller="userProfile" action="showPasswordPolicy" update="pwdPolicyDialog" onSuccess="openPwdPolicy()">
					<g:message code="userregistration.templates.logininfocontent.passwordpolicy.text"/>
					</g:remoteLink>
							</p>
						</div>   
               
               </div>
				
			   <div class="fields">
						<p>
                        <label for="ibNewConfEncryptedPassCode">${message(code:'userprofile.template.changepassword.confirmpassword.label')}</label>
						<input  placeholder="${message(code:'userprofile.template.changepassword.confirmpassword.placeholder.text')}"data-errormessage='{"dependent": "Password did not matched", "typeMismatch": "Please re-type password"}' data-dependent-validation="log_pass" type="password" name="ibNewConfEncryptedPassCode" id="ibNewConfEncryptedPassCode"  maxlength="19" autocomplete="off" onkeydown="warningAlert()" required="required" />
                       <a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>
                        </p>
               </div>
	</div>
		
	
		<div id="dynamicAuthContent" class="fields">
				<vayana:securitysetting controller="security" 
				        formName="changepassword"
						action="fetchSecurityAdviceForAService" successAction="verifyloginpasscode"
						successController="userProfile" targetService="CHNGPWD"/>   
						
	</div>	
			<div class="success" id="resultsuccess" style="display: none;">
				<span></span>				
			</div>
			

<g:render template="/userProfile/templates/vkeyboard"/>	
</g:form>

<div id="pwdPolicyDialog" title="${g.message(code:'userregistration.templates.logininfocontent.passwordpolicy.text')}" style="display:none;height:280px; width:500px; !important;" class="body-scroll">
    
	</div>
<script>
 
		$(document).ready(function(){
            $( ".middle_img_keypad" ).draggable({cursor: "move"});
            $( ".close_vk,.done").click(function(){$(".middle_img_keypad").fadeOut("1000",function(){$(".middle_img_keypad").hide()}); });
            $( ".vkey").click(function(){$(".middle_img_keypad").toggle()});
            $( ".keysc").on("mousedown",function(){$(".keysc").addClass('keysclked'); $(this).removeClass('keyshvr');});
            $( ".keysc").on("mouseup",function(){$(".keysc").removeClass('keysclked')});
            $(".shiftc,.capsc").click(function(){$(this).toggleClass("highlight"); });
            $(".vkey").trigger("click");
            <%--
            $( ".keysc").on("mouseenter",function(){
              $(this).addClass('keyshvr');
            try{window.clearTimeout(timeout);}catch(e){}
                timeout = window.setTimeout(blink, 1000); //delay
            });
            $( ".keysc").on("mouseout",function(){
               $(this).removeClass('keyshvr');
              });
              
			function blink(){
			$('.keyshvr').delay( 800 ).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100);
			
			}
			--%>
		});
	
		$(document).ready(function(){
		
         
			$(".caps").click(function(){
				 $(this).toggleClass("highlight");
			});
			
			$("#ibUserEncryptedPassCode").focus(function(){
				dis(0);
			});
			$("#ibNewEncryptedPassCode").focus(function(){
				dis(1);
			});
			$("#ibNewConfEncryptedPassCode").focus(function(){
				dis(2);
			});
				
		});	// ready end
	       
	   function dis(setVal)
		{	
	
			num = setVal;
			if(num == 0){	
				$("#ibUserEncryptedPassCode").css({'background':'#FFFF99'});		
			}else{ 
			  $("#ibUserEncryptedPassCode").css({'background':'#FFF'}); 
			}
			if(num == 1){
				$("#ibNewEncryptedPassCode").css({'background':'#FFFF99'});
			}else{   
				$("#ibNewEncryptedPassCode").css({'background':'#FFF'});
			}
			if(num == 2){
				$("#ibNewConfEncryptedPassCode").css({'background':'#FFFF99'});
			}else{   
				$("#ibNewConfEncryptedPassCode").css({'background':'#FFF'});
			}					
		}
	
		function clearAll()
		{
			if (num==2){
				$("#ibNewConfEncryptedPassCode").val("");
			}else if (num==1){	
				$("#ibNewEncryptedPassCode").val("");
			}else if (num==0){	
				$("#ibUserEncryptedPassCode").val("");
			}	
		}
	    
	    function backSpacer()
		{
			if (num==2)
			{
				oldPwd=$("#ibNewConfEncryptedPassCode").val();
				newPwd=oldPwd.substr(0,oldPwd.length-1);
				$("#ibNewConfEncryptedPassCode").val(newPwd);
			}
			else if (num==1)
			{
				oldPwd=$("#ibNewEncryptedPassCode").val();
				newPwd=oldPwd.substr(0,oldPwd.length-1);
				$("#ibNewEncryptedPassCode").val(newPwd);
			}
			else if (num==0)
			{
				oldlogin=$("#ibUserEncryptedPassCode").val();
				newlogin=oldlogin.substr(0,oldlogin.length-1);
				$("#ibUserEncryptedPassCode").val(newlogin);
			}
		}
	
		var shiftopt="false";
		function writePwd(s){			
			if (num==2){
				fld=$("#ibNewConfEncryptedPassCode").val()+s;
				$("#ibNewConfEncryptedPassCode").val(fld);
			}else if (num==1){
				fld=$("#ibNewEncryptedPassCode").val()+s;
				$("#ibNewEncryptedPassCode").val(fld);
			}else if (num==0){
				fld=$("#ibUserEncryptedPassCode").val()+s;
				$("#ibUserEncryptedPassCode").val(fld);					
			}
			
			if(shiftopt=="true"){
				document.getElementById('smallLayout').style.display="inline";
				document.getElementById('capsLayout').style.display="none";
				shiftopt="false";
			}
		}
		
		function checkFormValidity(formName)
		{
			if(!$('form#'+formName).checkValidity())
			{
				return true;
			}else
			{
				return false;
			}
		
		}
		
	
	
	$('#ibNewEncryptedPassCode','#ibNewConfEncryptedPassCode').keypress(function(event) {  
	        event.preventDefault();
	        return false;    
	});

		
	$(".fields").dynamicfieldupdate();
	
	counter=1;
	function warningAlert(){	
		if(counter==1){	
			var x = "Bank recommends using virtual key-board and you must confirm taking full resposibility of not using it";
			var str = '<span style='+ '"' + 'background: url(' + '/ib-retail-web/themes/pmcb_theme/img/common/black-icon.png' + ') no-repeat scroll -796px -40px transparent;display: block;height: 30px;vertical-align: middle;width: 29px;' + '"' + '></span> ';
	
			x=str+'   ' + x;
			//alert(str); 
		
		    $('<div class="alert_popup">' + x + '</div>').dialog({
		        resizable: false,
		        height:200,
		        title:"Warning message",
		        position:['middle',200],
		        draggable: false,
		        modal:true,
		        buttons: {
		            "Confirm": function() {		
		             counter++;    				            	
		                $(this).dialog("close");
		                $(".vkey").click(); 
		                $("#ibUserEncryptedPassCode").focus();
		                         
		            },
		            Cancel: function() {
		                $(this).dialog("close"); //close confirmation
		                $("#ibUserEncryptedPassCode").focus();
		            }
		        }		    
			});
		}	
	}		
	function openPwdPolicy()
	{
		$( "#pwdPolicyDialog" ).dialog( "open" );
	}
       
        var pwdPolicyDialog = $( "#pwdPolicyDialog" ).dialog({
            autoOpen: false,
            width:500,
            modal: true,
            resizable: false,
			draggable: false,
            buttons: {
                
                Close: function() {
                    $( this ).dialog( "close" );
                }
            },
            close: function() {
            	$( this ).dialog( "close" );
            }
        });
</script>
</body>
