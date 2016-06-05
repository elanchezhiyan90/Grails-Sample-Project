if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$("#messagesDiv,#popupMessagesDiv,#errorDiv").empty();
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});

		$("form").submit( function () {
		    $('#spinner').fadeIn();
  			return true;
		});
	})(jQuery);
}

function onAjaxFailure(textStatus) {

	$("#messagesDiv,#popupMessagesDiv").empty();
	$("#messagesDiv,#popupMessagesDiv").append(textStatus);
	
}

function postUrl(formName, url, targetName){
	var form = $('#'+formName);  
	form.attr('action',url);
	form.attr('method','POST');
	form.attr('target',targetName);
	form.submit();
}

$(document).ready(function(){
	$("#deverrors").prepend("<h1>Internal Error : (Development)</h1>");
	$("#deverrors").append("<button id='dever-cls' style='width:80%; margin:10px 10%;'>Close</button>");
	$("#dever-cls").focus();
		$("#dever-cls").click(function(){
			$("#deverrors").hide();
		})
});

function onAuthSuccess(data,textStatus)
 { 
   
	 $("#dynamicAuthContent").dynamicfieldupdate();	
		
 }
 
 function onAuthFailure(responseText,displayAsPopup)
 {
 	 var displayDiv
	 if(displayAsPopup=='YES'){
	 	displayDiv='popupMessagesDiv'
	 	$("#messagesDiv").empty();
	 }else{
	 	displayDiv='messagesDiv'
	 }
	 $("#dynamicAuthContent").dynamicfieldupdate();
	 $("#"+displayDiv).empty();
	 $("#"+displayDiv).append(responseText);
 }
function beforeAuth()
{
	
	var plainText = $("#loginId").val()+$("#txnPassword").val()+$("#tenantApplicationId").val()+$("#groupId").val();
	var hash = CryptoJS.SHA512(plainText);
	for (i = 1; i < 1024 ; i++)
	{
	 	hash = CryptoJS.SHA512(hash);
	}
	$("#txnPassword").val(hash);	
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
function emptyErrorDiv()
{
	$("#errorDiv").empty();
}

function onServiceSucess(data,textStatus)
{
    $("#print").show();
	$("#servicepanel").empty();
	$("#servicepanel").append(data);
	$("#servicepanel").dynamicfieldupdate();
	$("#messagesDiv").empty();
	
}

function onServiceFailure(responseText,displayAsPopup)
{ 

  
	var displayDiv
	 if(displayAsPopup=='YES'){
	 	displayDiv='popupMessagesDiv'
	 	$("#messagesDiv").empty();
	 }else{
	 	displayDiv='messagesDiv'
	 
	 }
	 $("#"+displayDiv).empty();
	 $("#"+displayDiv).append(responseText);
	 $("#continue").removeAttr('disabled');	 
}


function onError(textStatus)
{
	$("#errorDiv").empty();
	$("#errorDiv").append(textStatus);
}



/*
The below API encryptData and decryptData are used during form submission
*/
function encryptData(plainText,keySize,iterations,salt,iv,passPhrase)
{
	var aesUtil = new AesUtil(keySize,iterations);
	
    var cipherText = aesUtil.encrypt(salt,iv, passPhrase, plainText);

    /*console.log("cipherText : "+ cipherText);*/
	return cipherText;
}


function decryptData(cipherText,keySize,iterations,salt,iv,passPhrase)
{
	var aesUtil = new AesUtil(keySize,iterations);
    var plaintext = aesUtil.decrypt(salt,iv, passPhrase, cipherText);
    /*console.log("plainText : "+ plaintext);*/
	return plaintext;
}

/*
The below API onPostableLinkSuccess is used during the download option
*/
function onPostableLinkSuccess(){
	$('#spinner').fadeOut();
}


/*
The below API lockForm is used to make the form input fields and button attributes disabled

function lockForm(){
	$("form").find("input, select").attr("readonly", true);
	$("form").find('input[type="submit"]').attr('disabled',true);
	$("form").find('input[type="button"]').attr('disabled',true);
}
*/
/*
The below API unlockForm is used to make the form input fields and button remove attributes disabled

function unlockForm(){	
	$("form").find("input, select").removeAttr("readonly");
	$("form").find('input[type="submit"]').removeAttr('disabled');
	$("form").find('input[type="button"]').removeAttr('disabled');
}
*/
function disableForm(){
	$("form").find("input, select").attr('disabled',true);
	/*$(".data-list").find("a").attr('disabled',true);*/
}

function enableForm(){
	$("form").find("input, select").removeAttr('disabled');
}

function emptyConfirmDiv(){
	$("#confbtndiv").empty();
}

$(function() 
{
   if (typeof history.pushState === "function") 
   {
        history.pushState("", null, null);
        window.onpopstate = function () 
        {
            history.pushState("", null, null);
        };
   }
   else 
   {
        var ignoreHashChange = true;
        window.onhashchange = function () 
        {
            if (!ignoreHashChange) 
            {
                ignoreHashChange = true;
                window.location.hash = Math.random();
            }
            else 
            {
                ignoreHashChange = false;   
            }
        };
    }
});