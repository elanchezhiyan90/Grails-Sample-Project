<head>
	<meta name="layout" content="loginlayout" />
		<r:require module="fileuploader" />
</head>
<body class="nonapp">
<header class="header">

  <div class="header-wrap">
    <h1><a href="#">${message(code:'userregistration.userregistration.userlogininfo.h1.text') }</a></h1>
  </div>
</header>
<g:render template="/userRegistration/templates/sealinfocontent"/> 
<g:render template="/user/templates/footer"/>


<g:javascript>






// prototypal inheritance
if (typeof Object.create !== 'function') {
	Object.create = function (o) {
		function F() {}
		F.prototype = o;
		return new F();
	};
}



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
	$("#secureImageDiv").empty().append(data);
	$("#secureImageDiv").carousel({
		itemsPerPage:4,
		itemsPerTransition: 4,
		easing: 'linear',
		noOfRows: 2
	});
}

function preCheck(){
$(".failure").remove();
}



$(document).ready(function(){


	
$('#userDefSecureImageContent').hide();
$( "#ibUserSecureMessage" ).keyup(function(){
              var text=$(this).val();
              $('.sec_prvw div p i').text(text);
})
$( "input[name=ibUserSecureColorChkId]" ).change(function() {
              if($(this).is( ":checked" )){
                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').parent().siblings().find('label').removeClass('active').find('.ticker').detach('.ticker');  
                var color=$(this).data('hexcode')
                $('.sec_prvw').css("background-color","#"+color);
                }
            }).change();
	});	
	
function onSecureImageClick(text){
	if(text=="PRE"){
		$('#userDefSecureImageContent').hide();
		$('#preDefSecureImageContent').show();
		$('#secureImageDiv').show();
	}else{
		$('#preDefSecureImageContent').hide();
		$('#userDefSecureImageContent').show();
		$('#secureImageDiv').hide();
	}
}	
function preSetParams(){
	if($('input[name="imageType"]:checked').val()=='PSZL'){
		$("#selfImageName").val($("#au-selfImage").find(".qq-upload-file").text())
	}
}	



</g:javascript>


</body>
</html>