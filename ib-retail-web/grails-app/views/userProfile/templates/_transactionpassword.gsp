<head>
		<meta name="layout" content="applayout"/>
		<parameter name="themeName" value="${params.themeName}" />
	</head>
<body>

<g:form name="transactionpassword">

<div class="f-panel">


	<%--<div class="mandi-note">
			<span class="mandi"></span>
			<p>${message(code:'userprofile.template.transactionpassword.mandatoryfields.text')}</p>
	</div>--%>
 	<div class="col-370">

			<div class="fields">
				<p>
					<label for="ibUserEncryptedTransactionPassCode">${message(code:'userprofile.template.transactionpassword.existingloginpassword.label')}</label>
					<input type="password" name="ibUserEncryptedTransactionPassCode" id="ibUserEncryptedTransactionPassCode" placeholder="${message(code:'userprofile.template.transactionpassword.enterpassword.placeholder.text')}"  data-errormessage="${message(code:'userprofile.template.changepassword.password1.error.message')}" autocomplete="off"  required="required" />
					<a class="vkey1"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>
				</p>
				</div>				
			<div class="fields">
						<p>
                        <label for="ibNewEncryptedTransactionPassCode">${message(code:'userprofile.template.transactionpassword.newloginpassword.label')}</label>
						<input type="password" name="ibNewEncryptedTransactionPassCode" id="ibNewEncryptedTransactionPassCode" placeholder="${message(code:'userprofile.template.transactionpassword.choosepassword.placeholder.text')}"  data-errormessage="${message(code:'userprofile.template.changepassword.password2.error.message')}" autocomplete="off" onkeydown="warningAlert()"  required="required"  />
						 <a class="vkey1"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>
                        </p>                        
                       
                        <!-- <div class="updater">Password strength indicator</div> -->
                          <div class="fieldnote">
                			<p>${message(code:'userprofile.template.transactionpassword.clickheretoknowabout.text')}
                			<g:remoteLink  controller="userProfile" action="showPasswordPolicy" update="pwdPolicyDialog" onSuccess="openPwdPolicy()">
								<g:message code="userregistration.templates.logininfocontent.passwordpolicy.text"/>
							</g:remoteLink>
                			 </p>
                		</div>  
                    </div>
                    <div class="fields">
						<p>
                        <label for="ibNewConfEncryptedTransactionPassCode">${message(code:'userprofile.template.transactionpassword.confirmpassword.label')}</label>
						<input  placeholder="${message(code:'userprofile.template.transactionpassword.confirmpassword.placeholder.text')}"data-errormessage='{"dependent": "Password did not matched", "typeMismatch": "Please re-type password"}' data-dependent-validation="log_pass" type="password" name="ibNewConfEncryptedTransactionPassCode" id="ibNewConfEncryptedTransactionPassCode"      autocomplete="off"  onkeydown="warningAlert()"  required="required" />
						<a class="vkey1"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>
                        </p>
                    </div>
                    
     </div> 
                    
    <div class="col-370">
		<div class="fields">
			<p>
<%--					<br> <a class="vkey"><img src="/ib-retail-web/themes/pmcb_theme/img/common/vkey.png" width="20" height="20" alt="Virtual Key"></a>--%>
					<g:render template="/userProfile/templates/txnpwdvkeyboard"/>
			</p>
		</div>
	</div>
                    
			<div class="buttons" id="submitNow">				
					<vayana:submitToRemote value="${message(code:'userprofile.template.transactionpassword.submit.button.text')}" id="verifySubmit" name="verifySubmit"						
						before="if (checkFormValidity()) {return false;}"
						action="verifytransactionpasscode" controller="userProfile"
						update="[failure:'messagesDiv']"
						 />

				</div>			
			<div class="success" id="resultsuccess" style="display: none;">
				<span></span>				
			</div>
			
</div>

</g:form>
<div id="pwdPolicyDialog" title="${g.message(code:'userregistration.templates.logininfocontent.passwordpolicy.text')}" style="display:none;height:280px; width:500px; !important;" class="body-scroll">
    
	</div>
<script>

		$(document).ready(function(){
            $( ".middle_img_keypad" ).draggable({cursor: "move"});
            $( ".close_vk,.done").click(function(){$(".middle_img_keypad").fadeOut("1000",function(){$(".middle_img_keypad").hide()}); });
            $( ".vkey1").click(function(){$(".middle_img_keypad").toggle()});
            $( ".keysc").on("mousedown",function(){$(".keysc").addClass('keysclked'); $(this).removeClass('keyshvr');});
            $( ".keysc").on("mouseup",function(){$(".keysc").removeClass('keysclked')});
            $(".shiftc,.capsc").click(function(){    
            $(this).toggleClass("highlight"); });
             $(".vkey1").trigger("click");
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
				$(".smallLayout").show();
				$(".capsLayout").hide();
			//document.getElementById('smallLayout').style.display="inline";
			//document.getElementById('capsLayout').style.display="none";
			shiftopt="false";
		}
	}
	
	function checkFormValidity()
	{
		
		if(!$('#transactionpassword').checkValidity())
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
			$("#resultsuccess").html(response);
			$("#resultsuccess").dynamicfieldupdate();		
		}
	}
	function onVerifyError(responseText)
	{
		$("#errorDiv").empty();
		$("#errorDiv").append(responseText);
		$("#submitNow").show();
	}
	
	$('#ibNewEncryptedTransactionPassCode','#ibNewConfEncryptedTransactionPassCode').keypress(function(event) {  
	        event.preventDefault();
	        return false;
	    
	});
		
	$(".fields").dynamicfieldupdate()
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
		                $(".vkey1").click(); 
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
