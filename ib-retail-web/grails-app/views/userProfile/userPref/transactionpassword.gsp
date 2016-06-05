<html>
<head>
	<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
<header class="header">
	<div class="header-wrap">
		<h1><a href="#"> ${message(code:'userregistration.userregistration.userlogininfo.h1.text') }</a></h1>
	</div>
</header>
<div class="content">
		<!-- applicatin content section starts here-->
	<div class="content-wrap">
		<section class="app-section">
			 <div id="chgTransPassword">
				 <g:form name="transactionpassword" controller="home" action="homepage">
						<%--<div class="mandi-note">
								<span class="mandi"></span>
								<p>${message(code:'userprofile.template.changepassword.mandatoryfields.text')}</p>
							</div>
						--%>
						<h2>
							${message(code:'userprofile.template.transactionpwd.h2.text')}
						</h2>
					 <vayana:messages />
						<div class="col-370">
							<div class="fields">
								<p>
									<label for="ibUserEncryptedTransactionPassCode"> ${message(code:'userprofile.template.transactionpassword.existingloginpassword.label')}</label> 
									<input type="password" name="ibUserEncryptedTransactionPassCode" id="ibUserEncryptedTransactionPassCode" placeholder="${message(code:'userprofile.template.transactionpassword.enterpassword.placeholder.text')}"
										data-errormessage="${message(code:'userprofile.template.transaction.password1.error.message')}" autocomplete="off" required="required" />
								</p>
							</div>
							<div class="fields">
								<p>
									<label for="ibNewEncryptedTransactionPassCode"> ${message(code:'userprofile.template.transactionpassword.newloginpassword.label')}</label> 
									<input type="password" name="ibNewEncryptedTransactionPassCode" id="ibNewEncryptedTransactionPassCode" placeholder="${message(code:'userprofile.template.transactionpassword.choosepassword.placeholder.text')}"
										data-errormessage="${message(code:'userprofile.template.transaction.password2.error.message')}" autocomplete="off" required="required" /> 
										
										<a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>
								</p>
								<!-- <div class="updater">Password strength indicator</div> -->
								<div class="fieldnote">
									<p>${message(code:'userprofile.template.transactionpassword.clickheretoknowabout.text')}
										<g:remoteLink controller="userProfile" action="showPasswordPolicy" update="pwdPolicyDialog" onSuccess="openPwdPolicy()">
											<g:message code="userregistration.templates.logininfocontent.passwordpolicy.text" />
										</g:remoteLink>
									</p>
								</div>
							</div>
							<div class="fields">
								<p>
									<label for="ibNewConfEncryptedTransactionPassCode"> ${message(code:'userprofile.template.transactionpassword.confirmpassword.label')}</label> 
									<input placeholder="${message(code:'userprofile.template.transactionpassword.confirmpassword.placeholder.text')}"  type="password" name="ibNewConfEncryptedTransactionPassCode" id="ibNewConfEncryptedTransactionPassCode"
										data-dependent-validation="ibNewEncryptedTransactionPassCode" data-errormessage='{"dependent": "Password did not matched", "typeMismatch": "Please re-type password"}'  autocomplete="off" required="required" />
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
						</div>--%>
						<div class="buttons" id="submitNow">
							<br>
							<g:submitToRemote value="${message(code:'userprofile.template.transactionpassword.submit.button.text')}" id="verifySubmit" name="verifySubmit"
								before="if (checkFormValidity('transactionpassword')) {return false;}" action="verifytransactionpasscode" controller="userProfile" update="[failure:'messagesDiv',success:'resultsuccess']"
								onSuccess="onVerifySuccess(data,textStatus);" onFailure="onVerifyError(XMLHttpRequest.responseText);" />
						</div>
						<div class="success" id="resultsuccess" style="display: none;">
							<span></span>
						</div>
						<div class="buttons" id="continueToLogin" style="display: none;">
							<g:submitButton name="continue" value="${message(code:'userregistration.templates.logininfocontent.continue.button.text')}" />
						</div>
						<br />
						<br />
						<br />
						<g:render template="/user/templates/vkeyboard" />
				</g:form>
			</div>
		</section>
	</div>
</div>
<div id="pwdPolicyDialog" title="${g.message(code:'userregistration.templates.logininfocontent.passwordpolicy.text')}" style="display: none; height: 280px; width: 500px;"
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
			
			$("#ibUserEncryptedTransactionPassCode").focus(function(){
				dis(0);
			});
			$("#ibNewEncryptedTransactionPassCode").focus(function(){
				dis(1);
			});
			$("#ibNewConfEncryptedTransactionPassCode").focus(function(){
				dis(2);
			});
				
		});	// ready end
	       
	   function dis(setVal)
	   {	
			num = setVal;
			if(num == 0){	
				$("#ibUserEncryptedTransactionPassCode").css({'background':'#FFFF99'});		
			}else{ 
			  $("#ibUserEncryptedTransactionPassCode").css({'background':'#FFF'}); 
			}
			if(num == 1){
				$("#ibNewEncryptedTransactionPassCode").css({'background':'#FFFF99'});
			}else{   
				$("#ibNewEncryptedTransactionPassCode").css({'background':'#FFF'});
			}
			if(num == 2){
				$("#ibNewConfEncryptedTransactionPassCode").css({'background':'#FFFF99'});
			}else{   
				$("#ibNewConfEncryptedTransactionPassCode").css({'background':'#FFF'});
			}					
	   }
	 
	function clearAll()
	{
		if (num==2){
			$("#ibNewConfEncryptedTransactionPassCode").val("");
		}else if (num==1){	
			$("#ibNewEncryptedTransactionPassCode").val("");
		}else if (num==0){	
			$("#ibUserEncryptedTransactionPassCode").val("");
		}	
	}
    
    function backSpacer()
	{
		if (num==2)
		{
			oldPwd=$("#ibNewConfEncryptedTransactionPassCode").val();
			newPwd=oldPwd.substr(0,oldPwd.length-1);
			$("#ibNewConfEncryptedTransactionPassCode").val(newPwd);
		}
		else if (num==1)
		{
			oldPwd=$("#ibNewEncryptedTransactionPassCode").val();
			newPwd=oldPwd.substr(0,oldPwd.length-1);
			$("#ibNewEncryptedTransactionPassCode").val(newPwd);
		}
		else if (num==0)
		{
			oldlogin=$("#ibUserEncryptedTransactionPassCode").val();
			newlogin=oldlogin.substr(0,oldlogin.length-1);
			$("#ibUserEncryptedTransactionPassCode").val(newlogin);
		}
	}
	
	var shiftopt="false";
	function writePwd(s){		
	
		if (num==2){
			fld=$("#ibNewConfEncryptedTransactionPassCode").val()+s;
			$("#ibNewConfEncryptedTransactionPassCode").val(fld);
		}else if (num==1){
			fld=$("#ibNewEncryptedTransactionPassCode").val()+s;
			$("#ibNewEncryptedTransactionPassCode").val(fld);
		}else if (num==0){
			fld=$("#ibUserEncryptedTransactionPassCode").val()+s;
			$("#ibUserEncryptedTransactionPassCode").val(fld);					
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
			$("#errorDiv").empty();	
			$("#resultsuccess").show();
			$("#submitNow").css("visibility","hidden");
			$("#continueToLogin").show();
		
		}
	}
	function onVerifyError(responseText)
	{
		$("#errorDiv").empty();
		$("#errorDiv").append(responseText);
		$("#submitNow").show();
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
</g:javascript>
</body>
</html>