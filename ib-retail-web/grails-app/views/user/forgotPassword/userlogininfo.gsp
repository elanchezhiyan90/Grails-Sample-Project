<head>
	<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">Logo</a></h1>
  </div>
</header>
<g:render template="/user/forgotPassword/templates/logininfocontent"/> 
<g:render template="/user/templates/footer"/>
<g:javascript>
$(document).ready(function(){
	$(".ceebox").ceebox();
	
});
function openPwdPolicy(){
	$("#pwdPolicyDialog" ).dialog( "open" );
}
var pwdPolicyDialog = $("#pwdPolicyDialog").dialog({
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

function onclickCancel(){

	var link = "<g:createLink action='user' controller='index' params='[]'/>"
	postUrl('forgotPasswordForm',link,'_self')
 }

function checkFormValidity()
{
	if(!$('form').checkValidity())
	{
		return true;
	}
	else
	{
		return false;
	}
}

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
			
			$("#ibNewEncryptedPassCode").focus(function(){
				dis(0);
			});
			$("#ibNewEncryptedConfPassCode").focus(function(){
				dis(1);
			});
			
				
		});	// ready end
	       
	   function dis(setVal)
		{	
			num = setVal;
			if(num == 0){	
				$("#ibNewEncryptedPassCode").css({'background':'#FFFF99'});		
			}else{ 
			  $("#ibNewEncryptedPassCode").css({'background':'#FFF'}); 
			}
			if(num == 1){
				$("#ibNewEncryptedConfPassCode").css({'background':'#FFFF99'});
			}else{   
				$("#ibNewEncryptedConfPassCode").css({'background':'#FFF'});
			}
								
		}
		
		function clearAll()
		{
			if (num==1){
				$("#ibNewEncryptedConfPassCode").val("");
			}else if (num==0){	
				$("#ibNewEncryptedPassCode").val("");
			}	
		}
	    
	    function backSpacer()
		{
			if (num==1)
			{
				oldPwd=$("#ibNewEncryptedConfPassCode").val();
				newPwd=oldPwd.substr(0,oldPwd.length-1);
				$("#ibNewEncryptedConfPassCode").val(newPwd);
			}
			else if (num==0)
			{
				oldPwd=$("#ibNewEncryptedPassCode").val();
				newPwd=oldPwd.substr(0,oldPwd.length-1);
				$("#ibNewEncryptedPassCode").val(newPwd);
			}
			
		}
		
		var shiftopt="false";
		function writePwd(s){			
			if (num==1){
				fld=$("#ibNewEncryptedConfPassCode").val()+s;
				$("#ibNewEncryptedConfPassCode").val(fld);
			}else if (num==0){
				fld=$("#ibNewEncryptedPassCode").val()+s;
				$("#ibNewEncryptedPassCode").val(fld);
			}
			
			if(shiftopt=="true"){
				document.getElementById('smallLayout').style.display="inline";
				document.getElementById('capsLayout').style.display="none";
				shiftopt="false";
			}
		}


</g:javascript>
</body>
</html>