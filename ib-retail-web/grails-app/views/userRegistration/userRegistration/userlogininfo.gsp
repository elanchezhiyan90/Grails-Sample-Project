<head>
<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
	<header class="header">
		<div class="header-wrap">
			<h1>
				<a href="#">${message(code:'userregistration.userregistration.userlogininfo.h1.text') }</a>
			</h1>
		</div>
	</header>
	<g:render template="/userRegistration/templates/logininfocontent" />
	<g:render template="/user/templates/footer" />
<g:javascript>
function openPwdPolicy(){
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

var checkedImg="${fibUserSecureImgChkId?.toList()}" ;
function getIBUserLoginName()
{
var userName = $("#ibUserLoginName").val(); 
return userName; 
}
function onValidateUserName(data,textStatus)
{

}
function checkUserNameNull()
{
var userName = $("#ibUserLoginName").val(); 
	if(userName=='')
	{
		return true
	}
	else{
		return false
	}
}

var selVal = $("#ibUserSecureImageId1 option").each(function(){	
	var passVal = $(this).val()	;
	var index=$(this).index()
	var selected="${fibUserSecureImageId1}"
		if(index==0 && selected=='')
		{			
			$(this).val(passVal).attr("selected","selected") 
			$(this).parents("select").trigger("change");
		}else{
			if(selected==passVal)
			{
				$(this).val(passVal).attr("selected","selected") 
				$(this).parents("select").trigger("change");
			}
		
		}

	});

function getIBUserSecureImageId()
{
var ibUserSecureImage = $("#ibUserSecureImageId1").val(); 
return ibUserSecureImage; 
}
function onSecureImageSuccess(data,textStatus)
{

}
function preCheck(){
$(".failure").remove();
}

//Virtual keypad starts
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
 
 	$("#ibUserLoginName").bind('keyup', function (e) {
		
		    if (e.which >= 97 && e.which <= 122) {
		        var newKey = e.which - 32;
		        // I have tried setting those
		        e.keyCode = newKey;
		        e.charCode = newKey;
		    }
		
		    $("#ibUserLoginName").val(($("#ibUserLoginName").val()).toUpperCase());   
		});
	

         
		$(".caps").click(function(){
			 $(this).toggleClass("highlight");
		});
		
		$("#ibUserEncryptedPassCode").focus(function(){
			dis(0);
		});
		$("#ibUserEncryptedConfPassCode").focus(function(){
			dis(1);
		});
		$("#ibUserEncryptedTransPassCode").focus(function(){
			dis(2);
		});
		$("#ibUserEncryptedTransConfPassCode").focus(function(){
			dis(3);
		});
			
	});	// ready end
       
   function dis(setVal){	
		num = setVal;
		if(num == 0){	
			$("#ibUserEncryptedPassCode").css({'background':'#FFFF99'});		
		}else{ 
		  $("#ibUserEncryptedPassCode").css({'background':'#FFF'}); 
		}
		if(num == 1){
			$("#ibUserEncryptedConfPassCode").css({'background':'#FFFF99'});
		}else{   
			$("#ibUserEncryptedConfPassCode").css({'background':'#FFF'});
		}
		if(num == 2){
			$("#ibUserEncryptedTransPassCode").css({'background':'#FFFF99'});
		}else{   
			$("#ibUserEncryptedTransPassCode").css({'background':'#FFF'});
		}
		if(num == 3){
			$("#ibUserEncryptedTransConfPassCode").css({'background':'#FFFF99'});
		}else{   
			$("#ibUserEncryptedTransConfPassCode").css({'background':'#FFF'});
		}					
	}
	
		function clearAll()
		{
			if (num==1){
				$("#ibUserEncryptedConfPassCode").val("");
			}else if (num==0){	
				$("#ibUserEncryptedPassCode").val("");
			}else if (num==2){	
				$("#ibUserEncryptedTransPassCode").val("");
			}else if (num==3){	
				$("#ibUserEncryptedTransConfPassCode").val("");
			}	
		}
	    
	    function backSpacer()
		{
			if (num==1)
			{
				oldPwd=$("#ibUserEncryptedConfPassCode").val();
				newPwd=oldPwd.substr(0,oldPwd.length-1);
				$("#ibUserEncryptedConfPassCode").val(newPwd);
			}else if (num==0)
			{
				oldPwd=$("#ibUserEncryptedPassCode").val();
				newPwd=oldPwd.substr(0,oldPwd.length-1);
				$("#ibUserEncryptedPassCode").val(newPwd);
			}else if (num==2)
			{
				oldPwd=$("#ibUserEncryptedTransPassCode").val();
				newPwd=oldPwd.substr(0,oldPwd.length-1);
				$("#ibUserEncryptedTransPassCode").val(newPwd);
			}else if (num==3)
			{
				oldPwd=$("#ibUserEncryptedTransConfPassCode").val();
				newPwd=oldPwd.substr(0,oldPwd.length-1);
				$("#ibUserEncryptedTransConfPassCode").val(newPwd);
			}
			
		}
	
	var shiftopt="false";
	function writePwd(s){		
		if (num==1){
			fld=$("#ibUserEncryptedConfPassCode").val()+s;
			$("#ibUserEncryptedConfPassCode").val(fld);
		}else if (num==0){
			fld=$("#ibUserEncryptedPassCode").val()+s;
			$("#ibUserEncryptedPassCode").val(fld);					
		}else if (num==2){
			fld=$("#ibUserEncryptedTransPassCode").val()+s;
			$("#ibUserEncryptedTransPassCode").val(fld);					
		}else if (num==3){
			fld=$("#ibUserEncryptedTransConfPassCode").val()+s;
			$("#ibUserEncryptedTransConfPassCode").val(fld);					
		}
		
		if(shiftopt=="true"){
			document.getElementById('smallLayout').style.display="inline";
			document.getElementById('capsLayout').style.display="none";
			shiftopt="false";
		}
	}
	
	//Virtual keypad ends
</g:javascript>
</body>
</html>