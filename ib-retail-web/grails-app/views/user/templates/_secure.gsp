<div class="fields">
	<g:hiddenField name="userLogin"
		value="${userLoginProfileModel?.userLoginProfile?.id}" />
	<g:hiddenField name="allowedIp" value="${allowedIp}" />
	<g:hiddenField name="adminUserId" value="${userLoginProfileModel?.userLoginProfile?.userLogin}"/>
	<g:hiddenField name="isMigratedUser" value="${userLoginProfileModel?.isMigratedUser}" />
	<p>
		<label for="pwd">
			${message(code:'user.templates.secure.password.label') }
		</label> <input type="password" name="pwd" tabindex="2" id="pwd" value=""
			placeholder="${message(code:'user.templates.secure.password.placeholder') }"
			onkeydown="warningAlert()" required
			data-errormessage="${message(code:'user.templates.secure.password.error.message') }"
			autocomplete="off" /> <a class="vkey"><img
			src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20"
			height="20" alt="Virtual Key"
			title="Use Virtual KeyBoard to enter your password"></a>
	</p>
	
	<g:if
	test="${userLoginProfileModel?.userLoginProfile?.loginStatus?.code.equals('ACT')}">
		<div class="fieldnote">
			<p>			
				<g:form name="forgotpasswordForm">
						<vayana:postablelink controller="user" action="forgotPassword" linkClass="cancel" linkTitle="Forgot Password" id="forgotpassword" formName="forgotpasswordForm" target="_self">${message(code:'user.templates.secure.forgetpassword.text')}</vayana:postablelink>
				</g:form>
			</p>
		</div>
	</g:if>
</div>

<g:if
	test="${!userLoginProfileModel?.userLoginProfile?.loginStatus?.code.equals('FAC')}">
	<g:set var="secImg"
		value="${secureImagesModel?.userSecureImages?.iterator()?.next()}" />
	<div id="secure">
		<div class="layer_preview">
			<div class="fields">
				<p>
					<b> ${message(code:'user.templates.securitysealpreview.label.text') }
					</b>
				</p>
			</div>
			<div class="showsimage" style="background: #eee;width:220px;">
				<div>
				<table>
				<tr>
				<td>
					<p align="center">
						<vayana:img documentDetailId="${secImg}" height="80" width="80" isSecured="N" />
					</p>
				</td>
				<td>
				<br/>
					<p align="center">
						<b><i class="sec_text"> <label class="stxt"> ${secureImagesModel?.secureText}
									<input type="checkbox" name="secureText" id="secureText"
									required
									data-errormessage="${message(code:'taglib.secureimages.personalized.error.message')}"
									>
							</label>
						</i></b>
					</p>
					</td>
					</tr>
					</table>
				</div>
			</div>
		</div>

	</div>
	<g:hiddenField name="secureImg" value="${secImg}" />
	<g:hiddenField name="ibUserSecureMessage" value="${secureImagesModel?.secureText}" />
	<%--	<g:hiddenField name="ibUserSecureMessage" value="${secureImagesModel?.secureText}" />--%>
	<%--              <g:hiddenField name="userSecureColor" value="${userSelectedColor?.colorPaleteBasketDetail?.id}" />--%>
	<%--	<vayana:secureImages ulpId="${userLoginProfileModel?.userLoginProfile?.id}"/>--%>
	<%--<vayana:secureColors ulpId="${userLoginProfileModel?.userLoginProfile?.id}" tenAppId="50000" />--%>
</g:if>
<div class="fields" id="captchaId">
	<vayana:captcha />
</div>


<%--<g:if test="${params.attemptsLeft && params.attemptsLeft <= params.captchaCount && params?.showCaptcha.equals('y')}">--%>
<%--<div class="fields" id="captchaId">
	<vayana:captcha />
</div>
--%><%--</g:if>--%>


<br />
<div class="buttons">
	<%--<button type="submit"   id="loginSubmit" tabindex="3">
		${message(code:'user.templates.secure.login.button.text') }
	</button>
	--%>
	<g:submitToRemote id="loginSubmit" name="loginSubmit"
		value="${message(code:'user.templates.secure.login.button.text') }"
		url="[action:'validateLoginCaptcha']" update="[failure:'messagesDiv']"
		before="if (checkLoginFormValidity()) {return false;};"
		onSuccess="captchaValidationSuccess();"
		onFailure="captchaValidationFailure(XMLHttpRequest.responseText);" />
	<input type="button" name="loginCancel" id="loginCancel"
		value="${message(code:'user.templates.secure.cancel.button.text') }"
		class="btn_next" />

</div>

<style>
.alert_popup {
	height: 50px !important;
}

.alert_popup span {
	display: inline-block;
	float: left;
	height: 35px !important;
	margin-right: 4px !important;
	width: 35px !important;
}

.showsimage {
	width: 74%;
}

.showsimage .stxt {
	align: left;
	width: 70%;
}
</style>

<script>
	
	/*Start Script for Virtualkeypad*/
	 
      $(document).ready(function(){

            $( ".middle_img_keypad" ).draggable({cursor: "move"});
            $( ".close_vk,.done").click(function(){$(".middle_img_keypad").fadeOut("1000",function(){$(".middle_img_keypad").hide()}); });
            $( ".vkey").click(function(){$(".middle_img_keypad").toggle() });           
            $( ".keysc").on("mousedown",function(){$(".keysc").addClass('keysclked'); $(this).removeClass('keyshvr');});
            $( ".keysc").on("mouseup",function(){$(".keysc").removeClass('keysclked')});
            $(".shiftc,.capsc").click(function(){$(this).toggleClass("highlight"); });
              $(".vkey").trigger("click");
            /* Script for login Secure Images*/
            $( "input[name=secureImg]" ).change(function() {
	              if($(this).is( ":checked" )){
	                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').siblings().removeClass('active').find('.ticker').detach('.ticker');  
	                }
    		}).change();
    		
    		$( "input[name=secureColorList]" ).change(function() {
	              if($(this).is( ":checked" )){
	                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').siblings().removeClass('active').find('.ticker').detach('.ticker');  
	                }
    		}).change();
    
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
		
		$("#login").focus(function(){
			dis(0);
			});
		$("#pwd").focus(function(){
			dis(1);
			});
			
	});	// ready end
       
   function dis(setVal){	
		num = setVal;
		if(num == 0){	
			$("#login").css({'background':'#FFFF99'});		
		}else{ 
		  $("#login").css({'background':'#FFF'}); 
		}
		if(num == 1){
			$("#pwd").css({'background':'#FFFF99'});
		}else{   
			$("#pwd").css({'background':'#FFF'});
		}					
	}
	
	var shiftopt="false";
	function writePwd(s){		
		if (num==1){
			fld=$("#pwd").val()+s;
			$("#pwd").val(fld);
		}
		
		if(shiftopt=="true"){
			document.getElementById('smallLayout').style.display="inline";
			document.getElementById('capsLayout').style.display="none";
			shiftopt="false";
		}
	}
	
	function clearAll(){
		$("#pwd").val("");
	}	
	
	function backSpacer(){
		if (num==1)
		{
			oldPwd=$("#pwd").val();
			newPwd=oldPwd.substr(0,oldPwd.length-1);
			$("#pwd").val(newPwd);
		}
	}
			
	/*End Script for Virtualkeypad*/
	/*Start Secure Color Script */
	<%--$( "input[name=userSecureColor]" ).change(function() {
              if($(this).is( ":checked" )){
                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').parent().siblings().find('label').removeClass('active').find('.ticker').detach('.ticker');  
                var color=$(this).val();                
                $('.sec_prvw').css("background-color","#"+color);
                }
            }).change();--%>
    /*End Secure Color Script */
			   
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
		                $("#pwd").focus();
		                         
		            },
		            Cancel: function() {
		                $(this).dialog("close"); //close confirmation
		                $("#pwd").focus();
		            }
		        }
		    
		});
	}
	
	 
	
	
	
}
function captchaValidationSuccess(){
	$('#loginForm').submit();
}
function captchaValidationFailure(responseStatus) {
	onclickCancel();
}
function onclickCancel(){
	var link = "<g:createLink action='index' controller='tenant' params='[]'/>"     
	postUrl('loginForm',link,'_self')
}
function postUrl(formName, url, targetName){
	var form = $('#'+formName);  
	form.attr('action',url);
	form.attr('method','POST');
	form.attr('target',targetName);
	form.submit();
}
	</script>