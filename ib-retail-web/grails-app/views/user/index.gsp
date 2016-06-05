<html>
<head>
	<meta name="layout" content="preloginlayout" />
</head>
<body>
	<g:render template="/user/templates/header"/>
<%--<browser:choice>
			<browser:isSafari versionLower="${grailsApplication.config.browserdetection.safari.version}">
			<div class="warning">
				<span></span><b><g:message code="browser.version.error.msg.safari" /> </b>
				<p><g:message code="browser.version.error.msg.safari.unsupported" /></p>
				<p><g:message code="browser.version.error.msg.safari.compatibility" /></p>
				<p><g:message code="browser.version.error.msg.safari.newerversion" /> <a href="http://filehippo.com/download_safari" target="_blank"><g:message code="browser.version.error.msg.safari.upgradenow" /></a></p>
			</div></br>
					<table class="browser" align="center">
						<tr>
                  			     <th title="Safari" class="bsSafari" style="width:18%;"></th>					
    	               </tr>
							<tr>
								    <td><a href="#"><b><g:message code="browser.version.error.msg.safari.supported.version"/></b> </a></td>
							</tr>
						</table>
						</br></br></br>
			</browser:isSafari>
			
			<browser:isFirefox versionLower="${grailsApplication.config.browserdetection.firefox.version}"><br><br><br>
			  <div class="warning">
				<span></span><b><g:message code="browser.version.error.msg.firefox" /></b>
				<p><g:message code="browser.version.error.msg.firefox.unsupported" /></p>
				<p><g:message code="browser.version.error.msg.firefox.compatibility" /></p>
				<p><g:message code="browser.version.error.msg.firefox.newerversion" /> <a href="https://www.mozilla.org/en-US/firefox/new/" target="_blank"><g:message code="browser.version.error.msg.firefox.upgradenow" /></a></p>
		 		</div> </br>
						<table class="browser" align="center">
						<tr>
                  			 <th title="Firefox" class="bsFirefox" style="width:18%;"></th>						
    	               </tr>
							<tr>
								    <td><a href="#"><b><g:message code="browser.version.error.msg.firefox.supported.version"/></b></a></td>
							</tr>
						</table>
						</br></br></br>
			</browser:isFirefox>			
			
			<browser:isChrome versionLower="${grailsApplication.config.browserdetection.chrome.version}">
			<div class="warning">
				<span></span><b><g:message code="browser.version.error.msg.chrome" /></b>
				<p><g:message code="browser.version.error.msg.chrome.unsupported" /></p>
				<p><g:message code="browser.version.error.msg.chrome.compatibility" /></p>
				<p><g:message code="browser.version.error.msg.chrome.newerversion" /> <a href="https://support.google.com/chrome/answer/95346?hl=en" target="_blank"> <g:message code="browser.version.error.msg.chrome.upgradenow" /></a></p>
			    </div> </br>
						<table class="browser" align="center">
						<tr>
   								 <th title="Chrome" class="bsChrome" style="width:17%;"></th>    	              
   						 </tr>
							<tr>
								  <td><a href="#"><b><g:message code="browser.version.error.msg.chrome.supported.version"/></b></a></td>
							</tr>
						</table>
						</br></br></br>
						
			</browser:isChrome>
			<browser:isOpera versionLower="${grailsApplication.config.browserdetection.opera.version}">
			<div class="warning">
				<span></span><b><g:message code="browser.version.error.msg.opera" /></b>
				<p><g:message code="browser.version.error.msg.opera.unsupported" /></p>
				<p><g:message code="browser.version.error.msg.opera.compatibility" /></p>
				<p><g:message code="browser.version.error.msg.opera.newerversion" /> <a href="http://www.opera.com/computer/windows" target="_blank"><g:message code="browser.version.error.msg.opera.upgradenow" /></a>
			</div> </br>
						<table class="browser" align="center">
						<tr>
   						    <th title="Opera" class="bsOpera" style="width:17%;"></th> 	              
   						 </tr>
							<tr>
								  <td><a href="#"><b><g:message code="browser.version.error.msg.opera.supported.version"/></b></a></td>
							</tr>
						</table>
						</br></br></br>
						
			</browser:isOpera>
			
			<browser:isMsie versionLower="${grailsApplication.config.browserdetection.ie.version}">				
				<div class="warning">
					<span></span><b><g:message code="browser.version.error.msg.ie" /></b>	
					<p><g:message code="browser.version.error.msg.ie.unsupported" /></p>
					<p><g:message code="browser.version.error.msg.ie.compatibility" /></p>
					<p><g:message code="browser.version.error.msg.ie.newerversion" /> <a href="http://windows.microsoft.com/en-IN/internet-explorer/download-ie" target="_blank"><g:message code="browser.version.error.msg.ie.upgradenow" /></a>
				</div>
				
				 </br>
						<table class="browser" align="center">
						<tr>
   								 <th title="Internet Explorer" class="bsIE" style="width:15%;"></th>    	              
   						 </tr>
							<tr>
								  <td><a href="#"><b><g:message code="browser.version.error.msg.ie.supported.version"/></b></a></td>
							</tr>
						</table>
						</br></br></br>
			</browser:isMsie>
				
			<browser:otherwise>
					<g:render template="/user/templates/content"/>
			</browser:otherwise>
</browser:choice>
--%>
<g:render template="/user/templates/content"/>
<g:render template="/user/templates/footer"/>
<g:set var="keySize" value="${grailsApplication.config.security.aes.keySize}" />
<g:set var="iterations" value="${grailsApplication.config.security.aes.iterations}" />
<g:set var="salt" value="${grailsApplication.config.security.aes.salt}" />
<g:set var="iv" value="${grailsApplication.config.security.aes.iv}" />
<g:set var="passPhrase" value="${grailsApplication.config.security.aes.passPhrase}" />

<g:javascript>
	$(document).ready(function(){
	

		//bodyLoad();
		$("#forgetUserName").hide();

		$("#login").bind('keyup', function (e) {
		    if (e.which >= 97 && e.which <= 122) {
		        var newKey = e.which - 32;
		        // I have tried setting those
		        e.keyCode = newKey;
		        e.charCode = newKey;
		    }
		
		    $("#login").val(($("#login").val()).toUpperCase());
		});
	
		
		
		$("#login").focus(function(){
			dis(0);
		});
		$("#pwd").focus(function(){
			dis(1);
		});
								
				
		$('#loginForm').submit(function() {
			<%--checkFormValidity();
			var isExistingUser = $("#isExistingUser").val();
			if(isExistingUser != 'Y'){
				var username, password, tenantApplicationId, groupId, salt;
				username = $("#login").val();
				password =  $("#pwd").val();
				tenantApplicationId = ${params.tenantApplicationId};
				groupId =  ${params.groupId};
				
				salt = "${salt}";
				if (password.length > 0) {
					var plainText = username+password+tenantApplicationId+groupId;
					var hash = CryptoJS.SHA512(plainText);
					for (i = 1; i < 1024 ; i++){
		    			hash = CryptoJS.SHA512(hash);
					}
					
					 $("#pwd").val(hash);
				}
			}else{
				var password =  $("#pwd").val();
				if (password.length > 0) {
					var cipher = encrypt(password);
					$("#pwd").val(cipher);
				}
			}--%>
			$("#loginCancel").prop('disabled',true);
		});
		
		$("#loginCancel").live("click",function(){
		onclickCancel();
<%--			$("#messagesDiv").empty();--%>
<%--			$("#captchaId").empty();--%>
<%--			$("#forgetUserName").empty();--%>
<%--			$("#loginDiv").empty();--%>
<%--			$("#preLogin").show();--%>
<%--			$("#preLoginSubmit").prop('disabled',false);--%>
<%--			$("#login").removeAttr("readonly").val('').focus();--%>
<%--			$(".middle_img_keypad").fadeOut("1000",function(){$(".middle_img_keypad").hide()});--%>
		});
		$("#login").focus();
		
		$('#login').keydown(function (e){
	  			if(e.keyCode == 13){
	      			$('#preLoginSubmit').trigger("click");
	      			return false;
	  		    }
		});
	});	// ready end	
	
	function loadSuccess(data,textStatus){
		var sessionvalidity = $(data).filter("#sessionvalidity").val();
       	if(sessionvalidity!= 'undefined' && sessionvalidity == 'false')	{
       		window.location.reload();
<%--       		var link = "<g:createLink action='invalidsession' controller='user'/>"--%>
<%--			postUrl('form',link,'_self');    --%>
       	} else 	{
       		$("#loginDiv").html(data);
       		$("#loginDiv").dynamicfieldupdate();
			$("#preLogin").hide();
			$("#messagesDiv").empty();
			$("#login").attr('readonly', 'readonly');
			$("#pwd").focus();
			$("#forgetUserName").empty(); 
		}  
	}
	
	function loadFailure(textStatus){
	    $("#loginCancel").prop('disabled',false);
	    $("#login").removeAttr('readonly');
	    $("#login").focus();
	    $("#forgetUserName").show();
	    $("#preLoginSubmit,#loginSubmit").prop('disabled',false);
	}
	
	function dis(setVal)
	{	
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
		
	function checkFormValidity()
	{		
		if(!$("#loginForm").checkValidity())
		{
		return true;
		}else
		{
		$("#login").attr('readonly', 'readonly');
		$("#preLoginSubmit,#loginSubmit").prop( "disabled", true );
		$("#loginCancel").prop('disabled',true);		
		return false;
		}
	}
	
	function checkLoginFormValidity()
	{		
		if(!$("#loginForm").checkValidity())
		{
		return true;
		}else
		{
		$("#login").attr('readonly', 'readonly');
		$("#preLoginSubmit,#loginSubmit").prop( "disabled", true );
		$("#loginCancel").prop('disabled',true);
		var isExistingUser = $("#isMigratedUser").val();
		if(isExistingUser != 'Y'){
			doEncode();
		}else{
			var password =  $("#pwd").val();
			if (password.length > 0) {
				var cipher = encryptData(password,'${keySize}',${iterations},'${salt}','${iv}','${passPhrase}');
				$("#pwd").val(cipher);
			}
		}
		return false;
		}
	}
	
	function doEncode(){
			var username, password, tenantApplicationId, groupId, salt;
			username = $("#login").val();
			password =  $("#pwd").val();
			tenantApplicationId = ${params.tenantApplicationId};
			groupId =  ${params.groupId};			
			salt = "${salt}";
			if (password.length > 0) {
				var plainText = username+password+tenantApplicationId+groupId;
				var hash = CryptoJS.SHA512(plainText);
				for (i = 1; i < 1024 ; i++){
	    			hash = CryptoJS.SHA512(hash);
				}
				 $("#pwd").val(hash);
			}	
	}
</g:javascript>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
