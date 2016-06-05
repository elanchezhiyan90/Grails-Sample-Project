<head>
	<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">${message(code:'userregistration.userregistration.userverification.h1.text') }</a></h1>
  </div>
</header>
 <g:render template="/userRegistration/templates/verificationcontent"/> 
 <g:render template="/user/templates/footer"/>
 
</body>
</html>
<g:javascript>
function preCheck()
{

	$(".failure").remove();
	var pinVal = $("#existUsrPwd").val();
	var cipher = encrypt(pinVal);
	$("#existUsrPwd").val(cipher);
	var cNum = $("#card1").val()+$("#card2").val()+$("#card3").val()+$("#card4").val();
	$("#cardNumber").val(cNum);
}

//Numeric Virtual keypad starts
/*	$(document).ready(function(){
            $( ".middle_img_keypad" ).draggable({cursor: "move"});
            $( ".close_vk,.done").click(function(){$(".middle_img_keypad").fadeOut("1000",function(){$(".middle_img_keypad").hide()}); });
            $( ".vkey").click(function(){$(".middle_img_keypad").toggle()});
            $( ".keysc").on("mousedown",function(){$(".keysc").addClass('keysclked'); $(this).removeClass('keyshvr');});
            $( ".keysc").on("mouseup",function(){$(".keysc").removeClass('keysclked')});
                       
           
            $("#card1").focus(function(){
			dis(0);
			});
			$("#card2").focus(function(){
			dis(1);
			});
			$("#card3").focus(function(){
			dis(2);
			});
			$("#card4").focus(function(){
			dis(3);
			});
			$("#pinNumber").focus(function(){
			dis(4);
			});
			
	});
	
	
	function dis(setVal){	
		num = setVal;
		if(num == 0){	
			$("#card1").css({'background':'#FFFF99'});		
		}else{ 
		  $("#card1").css({'background':'#FFF'}); 
		}
		 
		 if(num == 1){	
			$("#card2").css({'background':'#FFFF99'});		
		}else{ 
		  $("#card2").css({'background':'#FFF'}); 
		}
		
		if(num == 2){	
			$("#card3").css({'background':'#FFFF99'});		
		}else{ 
		  $("#card3").css({'background':'#FFF'}); 
		}
		
		if(num == 3){	
			$("#card4").css({'background':'#FFFF99'});		
		}else{ 
		  $("#card4").css({'background':'#FFF'}); 
		}
		
		if(num == 4){	
			$("#pinNumber").css({'background':'#FFFF99'});		
		}else{ 
		  $("#pinNumber").css({'background':'#FFF'}); 
		}	
							
	}
	 
	
	function backSpacer()
	{
		if (num==4)
		{
			oldPwd=$("#pinNumber").val();
			newPwd=oldPwd.substr(0,oldPwd.length-1);
			$("#pinNumber").val(newPwd);
		}else if (num==0){
			oldPwd=$("#card1").val();
			newPwd=oldPwd.substr(0,oldPwd.length-1);
			$("#card1").val(newPwd);
		}	
		else if (num==1){
			oldPwd=$("#card2").val();
			newPwd=oldPwd.substr(0,oldPwd.length-1);
			$("#card2").val(newPwd);
		}	
		else if (num==2){
			oldPwd=$("#card3").val();
			newPwd=oldPwd.substr(0,oldPwd.length-1);
			$("#card3").val(newPwd);
		}	
		else if (num==3){
			oldPwd=$("#card4").val();
			newPwd=oldPwd.substr(0,oldPwd.length-1);
			$("#card4").val(newPwd);
		}	
	}

	function writePwd(s){		
		if (num==4){
			fld=$("#pinNumber").val()+s;
			$("#pinNumber").val(fld);
		}else if (num==0){
			if ($("#card1").val().length > 3) {
       			$("#card2").removeAttr('disabled').focus();  
       		}
       		else{
			fld=$("#card1").val()+s;
			$("#card1").val(fld);					
			}
		}
		else if (num==1){
			if ($("#card2").val().length > 3) {
       			$("#card3").removeAttr('disabled').focus(); 
       		} 
       		else{
			fld=$("#card2").val()+s;
			$("#card2").val(fld);	
			}				
		}
		else if (num==2){
			if ($("#card3").val().length > 3) {
       			$("#card4").removeAttr('disabled').focus(); 
       		}
       		else{ 
			fld=$("#card3").val()+s;
			$("#card3").val(fld);	
			}				
		}
		else if (num==3){
			if($("#card4").val().length >3){
			}else{
			fld=$("#card4").val()+s;
			$("#card4").val(fld);
			}					
		}
	} */
</g:javascript>
<g:javascript>
/*Start Script for Virtualkeypad*/
$(document).ready(function(){
   $( ".middle_img_keypad" ).draggable({cursor: "move"});
   $( ".close_vk,.done").click(function(){$(".middle_img_keypad").fadeOut("1000",function(){$(".middle_img_keypad").hide()}); });
   $( ".vkey").click(function(){$(".middle_img_keypad").toggle() });           
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
		
	$("#existUsrPwd").focus(function(){
		dis(0);
	});
});	// ready end
       
function dis(setVal){	
  num = setVal;
  if(num == 0){	
  	$("#existUsrPwd").css({'background':'#FFFF99'});		
  }else{ 
	$("#existUsrPwd").css({'background':'#FFF'}); 
  }
}
var shiftopt="false";
function writePwd(s){	
 if (num==0){
	fld=$("#existUsrPwd").val()+s;
	$("#existUsrPwd").val(fld);
 }
 if(shiftopt=="true"){
	document.getElementById('smallLayout').style.display="inline";
	document.getElementById('capsLayout').style.display="none";
	shiftopt="false";
 }
}
function clearAll(){
	$("#existUsrPwd").val("");
}	
function backSpacer(){
	if (num==1)
	{
		oldPwd=$("#existUsrPwd").val();
		newPwd=oldPwd.substr(0,oldPwd.length-1);
		$("#existUsrPwd").val(newPwd);
	}
}
/*End Script for Virtualkeypad*/ 
 
</g:javascript>