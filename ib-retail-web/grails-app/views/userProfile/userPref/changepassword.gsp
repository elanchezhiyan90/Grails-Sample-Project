<html>
<head>
<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
	<header class="header">
		<div class="header-wrap">
			<h1>
				<a href="#"> ${message(code:'userregistration.userregistration.userlogininfo.h1.text') }
				</a>
			</h1>
		</div>
	</header>
	<div class="content">
		<!-- applicatin content section starts here-->
		<div class="content-wrap">
			<section class="app-section">
				<div id="chgPassword">
					<g:form name="changepassword">
						<h2>
							${message(code:'userprofile.template.changepassword.h2.text')}
						</h2>
						<vayana:messages />
						<div class="col-370">
							<div class="fields">
								<p>
									<label for="ibUserEncryptedPassCode"> ${message(code:'userprofile.template.changepassword.existingloginpassword.label')}
									</label> <input type="password" name="ibUserEncryptedPassCode"
										id="ibUserEncryptedPassCode"
										placeholder="${message(code:'userprofile.template.changepassword.enterpassword.placeholder.text')}"
										data-errormessage="${message(code:'userprofile.template.changepassword.password1.error.message')}"
										autocomplete="off" onkeydown="warningAlert()"
										required="required" />
								</p>
							</div>
	
							<div class="fields">
								<p>
									<label for="ibNewEncryptedPassCode"> ${message(code:'userprofile.template.changepassword.newloginpassword.label')}
									</label> <input type="password" name="ibNewEncryptedPassCode"
										id="ibNewEncryptedPassCode"
										placeholder="${message(code:'userprofile.template.changepassword.choosepassword.placeholder.text')}"
										data-errormessage="${message(code:'userprofile.template.changepassword.password2.error.message')}"
										autocomplete="off" onkeydown="warningAlert()"
										required="required" /> <a class="vkey"><img
										src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png"
										width="20" height="20" alt="Virtual Key"></a>
								</p>
								<!-- <div class="updater">Password strength indicator</div> -->
								<div class="fieldnote">
									<p>
										${message(code:'userprofile.template.changepassword.clickheretoknowabout.text')}
										<g:remoteLink controller="userProfile"
											action="showPasswordPolicy" update="pwdPolicyDialog"
											onSuccess="openPwdPolicy()">
											<g:message
												code="userregistration.templates.logininfocontent.passwordpolicy.text" />
										</g:remoteLink>
									</p>
	
								</div>
							</div>
	
							<div class="fields">
								<p>
									<label for="ibNewConfEncryptedPassCode"> ${message(code:'userprofile.template.changepassword.confirmpassword.label')}
									</label> <input
										placeholder="${message(code:'userprofile.template.changepassword.confirmpassword.placeholder.text')}"
										data-errormessage='{"dependent": "Password did not matched", "typeMismatch": "Please re-type password"}'
										data-dependent-validation="ibNewEncryptedPassCode" type="password"
										name="ibNewConfEncryptedPassCode"
										id="ibNewConfEncryptedPassCode" onkeydown="warningAlert()"
										autocomplete="off" required="required" /> <a class="vkey"><img
										src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png"
										width="20" height="20" alt="Virtual Key"></a>
								</p>
							</div>
						</div>
	
						<%--<div class="col-370">
					<div class="fields">
						<p>
							<a class="vkey"><img
								src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png"
								width="20" height="20" alt="Virtual Key"></a>
							<g:render template="/user/templates/vkeyboard" />
						</p>
	
	
					</div>
	
				</div>
				--%>
						<%--<div id="dynamicAuthContent">
					<div class="buttons" id="submitNow">
						<vayana:securitysetting controller="security"
							formName="changepassword" action="fetchSecurityAdviceForAService"
							successAction="verifyforceloginpasscode"
							successController="userProfile" targetService="CHNGPWD"
							onSuccess="onVerifySuccess(data,textStatus);"
							onFailure="onVerifyError(XMLHttpRequest.responseText);" />
	
					</div>
				</div>
				<div class="success" id="resultsuccess" style="display: none;">
					<span></span>
				</div>
	
				<br /> <br /> <br />
			--%>
						<div class="buttons" id="submitNow">
							<br />
							<g:submitToRemote controller="userProfile" id="chgConfirm"
								name="chgConfirm" action="verifyforceloginpasscode"
								update="f-panel"
								before="if (checkFormValidity('changepassword')) {return false;};emptyErrorDiv();"
								after="disableForm()" value="Confirm"
								onSuccess="onVerifySuccess(data,textStatus);"
								onFailure="onVerifyError(XMLHttpRequest.responseText);enableForm();" />
	
						</div>
						<br />
						<br />
						<br />
						<br />
						<g:render template="/user/templates/vkeyboard" />
					</g:form>
				</div>
			</section>
		</div>
	</div>
	<div id="pwdPolicyDialog"
		title="${g.message(code:'userregistration.templates.logininfocontent.passwordpolicy.text')}"
		style="display: none; height: 280px; width: 500px;"
		class="body-scroll"></div>
	<g:render template="/user/templates/footer" />
	<g:javascript>

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
		function onVerifySuccess(data,textStatus)
		{
			if(textStatus=='success')
			{
				var response =  $(data).first().html();	
				$("#messagesDiv").empty();	
<%--				$("#resultsuccess").show();--%>
				$("#chgPassword").empty();
				$("#chgPassword").html(response);
				$("#chgPassword").dynamicfieldupdate();		
			}
		}
		function onVerifyError(responseText)
		{	
			$("#ibUserEncryptedPassCode").val("");
			$("#ibNewEncryptedPassCode").val("");
			$("#ibNewConfEncryptedPassCode").val("");
			$("#messagesDiv").empty();
			$("#messagesDiv").append(responseText).dynamicfieldupdate();
<%--			$("#submitNow").show();--%>
		}   
		
		counter=1;
			function warningAlert(){	
		if(counter==1){	
			var x = "Bank recommends using virtual key-board and you must confirm taking full resposibility of not using it";
			var str = '<span style='+ '"' + 'background: url(' + '/ib-retail-web/themes/pmcb_theme/img/common/black-icon.png' + ') no-repeat scroll -796px -40px transparent;display: block;height: 30px;vertical-align: middle;width: 29px;' + '"' + '></span> ';
	
			x=str+'   ' + x;
			//alert(str); 
		
		    $('<div class="alert_popup">' + x + '</div>').dialog({
		        resizable: false,
		        height:240,
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
</g:javascript>
</body>
</html>