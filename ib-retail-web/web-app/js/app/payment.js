function getPaymentFavouriteId(){
	return $("#paymentFavouriteId").val()
}
function getPaymentFavBeneId(){
	var beneId = $("#paymentFavBeneId").val()
	$("#payeeInsBeneId").val(beneId);
	return $("#paymentFavBeneId").val()
}
function removeFavouriteStar(){
	$("#favpayment").empty();
}
function onDiscardFavSuccess(data,textStatus){
	//var beneId = $("#payeeInsBeneId").val();
	//$("#bene-"+beneId,window.parent.document).trigger("click");
	
	$("#paymentRemarks").val('');
	$("#paymentAmount").val('');
}
function getDiscardFavFlag(){
	$("#favouriteId").val("N");
	return "N";
}
function setFavourite(param1,param2,param3)
{	
	$("#paymentId").val(param1);
	$("#payeeInsBeneId").val(param2);
	$("#payeeId").val(param3);	
	setfavFlag(param1);
}
function getFavourite()
{
	return $("#paymentId").val()
}
function getPayeeId()
{	
	return $("#payeeInsBeneId").val()
}
function getPayeeInsBeneId()
{
	return $("#payeeInsBeneId").val()
}
function getBeneId()
{
	return $("#payeeInsBeneId").val();
}
function onFavSuccess(data,textStatus)
{		
	$("#favpayment").empty();		
}
function setfavFlag(param1)
{
if($("#checkbox"+param1).is(":checked"))
	{
		$("#favouriteId").val("N");
	}
	else
	{
		var fromacc = $("#checkbox"+param1).data('frmacc');
		var toacc = $("#checkbox"+param1).data('toacc');		
		var currency = $("#checkbox"+param1).data('currency');	
		var toamt = $("#checkbox"+param1).data('toamt')
		var payremarks=	$("#checkbox"+param1).data('remarks');
		var amtType = $("#checkbox"+param1).data('amounttype');
		
		$("#paymentRemarks").val(payremarks);
		$("#paymentAmount").val(toamt);
		$("#favouriteId").val("Y");
			var selVal = $("#fromAccountId option").each(function()
			{
				var passVal = $(this).val()	;	
				var thisVar = $(this);		
				setAccount(passVal,fromacc,thisVar)
		
			});
			
//		Currency Value		
		var currVal = $("#currencyId option").each(function()
			{
				var curVal = $(this).val();
				var thisVar = $(this);	
				setCurrency(curVal,currency,thisVar)
				
			});
			
		var selVal = $("#toAccountId option").each(function()
			{
			    var passVal = $(this).val()	;	
				var thisVar = $(this);		
				setAccount(passVal,toacc,thisVar)		
			
			});
		
		// Amount Type CC Payments	
		var amtTypeVal = $("#amount_type option").each(function()
		{
			var passVal = $(this).val();
			var thisVar = $(this);	
			setAmountType(passVal,amtType,thisVar)
			
		});
	
	}	
}

 function setAmountType(passVal,amtType,thisVar)
{
		//passVal=passVal.split(',');
		//alert(amtType+'-----'+passVal);
		if(amtType == passVal)
		{							
			$(thisVar).attr("selected","selected").siblings('option').removeAttr('selected');
			var sel=$(thisVar).val(passVal).text();
			$(thisVar).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(sel);
			$(thisVar).parents("select").trigger("change");			
		}
}
		
function setAccount(passVal,fromacc,thisVar)
{
		passVal=passVal.split(',');
		if(fromacc == passVal[0])
		{	
			$(thisVar).val(passVal).attr("selected","selected");		
			var sel=$(thisVar).val(passVal).text();
			$(thisVar).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(sel);
			$(thisVar).parents("select").trigger("change");
		
		}
}
function setCurrency(curVal,currency,thisVar)
{
		curVal=curVal.split(',');
		if(currency == curVal[0])
		{		
			$(thisVar).val(curVal).attr("selected","selected").siblings('option').removeAttr('selected');		 
			var currsel=$(thisVar).val(curVal).text();		
			$(thisVar).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(currsel);
			//$(thisVar).parents("select").trigger("change");
		}


}
function getFavouriteId()
{
	return $("#favouriteId").val();
}
function onError(textStatus)
{
	$("#errorDiv").empty();  
	$("#errorDiv").append(textStatus);
	$("#later_flds,#repeat_flds, #otp_paynow_div,#btns_now").hide();
	$("#prePayLater,#preRepeat,#payNow").removeAttr('disabled');
}

function onValidateSuccess(data,textStatus,enableDiv)
{
//	$("#"+enableDiv).show();
}	
function emptyErrorDiv()
{
	$("#errorDiv").empty();
}
function emptyConfirmDiv()
{
	$("#confbtndiv").empty();
}
$("#cnfrm_paynow").click(function()
{
		$(this).parents("#btns_now").hide();
		$("#otp_paynow_div").show();		
});	
function checkFormValidity()
{
	if(!$('form').checkValidity())
	{
		return true;
	}else
	{
		return false;
	}

}
function onSkipSuccess(data,textStatus)
{
	$("#confirmDiv").hide();
	$(".success").show();
}
function onPaymentSuccess(data,textStatus)
{	
	if(textStatus=='success')
	{
		var refno =  $(data).first().html();
		$("#result").show();
		$("#resultsuccess").show();
		$("#resultsuccess").html(refno);
		$("#resultsuccess").dynamicfieldupdate();		
	}
	$("#print").show();
	
}	
function onPaymentConfirm(data,textStatus)
{	
	if($("#twoFactorType").val()=='NONE')
	{
		var refno =  $(data).first().html();
		$("#result").show();
		$("#resultsuccess").show();
		$("#resultsuccess").html(refno);
		$("#resultsuccess").dynamicfieldupdate();		
	}		
}

function fpanel(){
	/************ form element manipulation *******************/
	$(".flds-block").hide();
	
	/*********** Pay Now Script *************/
	$("#payNow").click(function(){
		if (checkFormValidity()) {
			return false;
		}
		$("#prePayLater,#preRepeat,#payNow").attr('disabled','disabled');
	});
	/*********** Pay Now Script Ends Here *************/
	/************* Pay later script **************/
	$("#prePayLater").click(function(){
		if (checkFormValidity())
		{
			return false;
		}
			$(this).removeClass("btn_next").addClass("btn_show");
			$("#payNow").addClass("btn_next");
			$("#preRepeat").removeClass("btn_show").addClass("btn_next");
			$("#preRepeat,#payNow").attr('disabled','disabled');
			$(".flds-block").fadeIn();
	
					$("#cnfrm_later").click(function(){
							if($('form').checkValidity()){							
								
							}
						});

			});
		
	/************** Pay later script ends here ***********/	
	
	/************* Repeat script **************/
	$("#preRepeat").click(function(){
		if (checkFormValidity())
		{
			return false;
		}
			$(this).removeClass("btn_next").addClass("btn_show");
			$("#payNow").addClass("btn_next");
			$("#prePayLater").removeClass("btn_show").addClass("btn_next");
			$("#prePayLater,#payNow").attr('disabled','disabled');
			$(".flds-block").fadeIn();
	
					$("#cnfrm_later").click(function(){
							if($('form').checkValidity()){
								
								
							}
						});

			});
		
	/************** Repeat script ends here ***********/
		
}

$(document).ready(function ()
{
	$(".ceebox").ceebox();
	$('form').encypform();
		fpanel();
		$(".t-panel input[type=checkbox],.f-panel .fpanelStar").starcheckbox();	
		// Detect touch enabled browser and load touch supported js
		Modernizr.load({
	  	test: Modernizr.touch,
	  	 yep: ['../../js/app/jquery.jswipe.js'],
	  	callback: function () {
	    			
	  		$(".t-f-panel").swipe({
				 swipeLeft: function() {$(".t-panel").hide("medium",function(){
											$(".t-f-panel").animate({width:'414px'},"medium");
											$(".related-nav").show("medium");
											});
											parent.$(parent.document).find("a.hstry span").addClass("hide").removeClass("show");
										},
				 swipeRight: function() {$(".t-f-panel").animate({width:'730px'},"medium",function(){
											$(".t-panel").show("medium");
											});
											$(".related-nav").hide("medium");
											parent.$(parent.document).find("a.hstry span").addClass("show").removeClass("hide");
										}
				});
			
	  	}
	});

});	
function payerVal()                            
{
	   var txt = $("#fromAccountId").val(); 					   			 
	   return txt; 
}
function preferredFTCurrency(){
var test=$("#fromAccountId :selected").text();
var text1 = test.split("|")[1];
var currency = text1;
$("#currencyId option").each(function() {
		var curText = $(this).text();
		var curVal = $(this).val();	
		curVal=curVal.split(',');
		if(currency == curText)
		{			
			$(this).val(curVal).attr("selected","selected") ;		
			var currsel=$(this).val(curVal).text();		
			$(this).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(currsel);			
		}
	});
}               

function onPayerIdSuccess(data,textStatus)
{									
    var corebal =  $(data).first().html();
    var exchangerate = $(data).last().html(); 
    var updatedCur = $("#updatedCurrency").html();
    $("#updatedCurrency").empty();
    $("#currencyId").empty();  
    $("#balance").empty().html(corebal);
    $("#exchange").empty().html(exchangerate);
    $("#currencyId").html(updatedCur);
	$("#balance").dynamicfieldupdate();
	$("#exchange").dynamicfieldupdate();
	$("#currencyId").dynamicfieldupdate();
	$("#currencyId").next(".ui-combobox").find("input").val("");
	
	var length = $('#currencyId > option').length;
	if(length>2){	
	$("#currencyId option[value='']").remove();
	}
	preferredFTCurrency();
	//var favouriteCurrency = $("#favouriteAccountCurrency").val();
	//if(favouriteCurrency != null && favouriteCurrency != "")
	//{
		$("#currencyId option").each(function()	{
			var curVal = $(this).val();		
			var thisVar = $(this);			
			var currencyVal=$("#favouriteAccountCurrency").val();			
			if(length<=2)
			{
				curVal=curVal.split(',');
				$(thisVar).val(curVal).attr("selected","selected") ;		
				var currsel=$(thisVar).val(curVal).text();	
				$(thisVar).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(currsel);
				$(thisVar).parents("select").trigger("change");
			}else{
				setCurrency(curVal,currencyVal,thisVar)
			}
		});
	//}
}

function onPayeeIdSuccess(data,textStatus)
{
	var impsTransType = $("#impsTransType").val();
	//var exchangerate =  $(data).last().html();
	var updatedCur = $("#updatedCurrency").html();
	//alert("impsTransType"+impsTransType);
	$("#updatedCurrency").empty();       
	$("#currencyId").empty();
	$("#currencyId").html(updatedCur);  
	//$("#exchange").html(exchangerate);  
	//$("#exchange").dynamicfieldupdate();
	$("#currencyId").dynamicfieldupdate();
	$("#currencyId").next(".ui-combobox").find("input").val("");
	var length = $('#currencyId > option').length;
	if(length>2){	
	$("#currencyId option[value='']").remove();
	}
	if(impsTransType=='IMPSP2A'||impsTransType=='IMPSP2P'||impsTransType=='IMPSP2M'||impsTransType=='IMPSP2U'){
	$("#prePayLater").hide();
	$("#preRepeat").hide();
	$("#mpinId").show();
	$('#mpin').prop('required',true);
	}else{
	$("#prePayLater").show();
	$("#preRepeat").show(); 
	$("#mpinId").hide();    
	$('#mpin').prop('required',false);
	}
	
	$("#currencyId option").each(function()	{
			var curVal = $(this).val();		
			var thisVar = $(this);			
			var currencyVal=$("#favouriteAccountCurrency").val();			
			if(length<=2)
			{
				curVal=curVal.split(',');
				$(thisVar).val(curVal).attr("selected","selected") ;		
				var currsel=$(thisVar).val(curVal).text();	
				$(thisVar).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(currsel);
				$(thisVar).parents("select").trigger("change");
			}else{
				setCurrency(curVal,currencyVal,thisVar)
			}
		});
}
//To set the bene instruction id for fetching exchange Rate on page load
function payeeVal()
{
	var payeeId="";	
	if($("#beneInstructionId").val()!=="")
	{
		payeeId=$("#beneInstructionId").val();
	}
	else
	{
		payeeId= $("#toAccountId").val(); 
		payeeId=payeeId.split(',')		
		payeeId=payeeId[0];
	}		
	return payeeId;
}

function onPaymentFailure(responseText)
{
$("#messagesDiv").empty();
$("#messagesDiv").append(responseText);
$("#print").show();
}
function onFTValidateSucess(data,textStatus)
{	
	$("#ftpanel").empty();
	$("#ftpanel").append(data);
	$("#ftpanel").dynamicfieldupdate();
	$("#messagesDiv").empty();
	$(".t-panel").hide("medium");
	parent.$(parent.document).find("a.hstry span").addClass("hide").removeClass("show");
}
function onFTValidateFailure(responseText)
{
	$("#messagesDiv").empty();
	$("#messagesDiv").append(responseText);
	$("#prePayLater,#preRepeat,#payNow").removeAttr('disabled');
}

function checkFromAccount()
{
	if($("#fromAccountId").val()=='')
		return true;
	else
		return false;
}

function checkToAccount()
{	
	var toCurrency=$( "#toAccountId option[selected]" ).data('curncy');	
	if($("#toAccountId").val()=='')
		return true
//	else
//	{
//		var currVal = $("#currencyId option").each(function()
//				{
//					var curVal = $(this).val();
//					var thisVar = $(this);					
//					setCurrency(curVal,toCurrency,thisVar)
//				});
//		return false;
//	}
		
}

function catchButtonEvent(buttonName)
{	
	$("#buttonEvent").val(buttonName);
}

function onPreTransSuccess(data,textStatus)
{
	$("#dynamicContent").dynamicfieldupdate();
}

function onPreTransFailure(responseText)
{
	
}
 function onAuthSuccess(data,textStatus) 
 {     
	 $("#dynamicAuthContent").dynamicfieldupdate();	
		
 }
 function onAuthFailure(responseText)
 {
	 $("#dynamicAuthContent").dynamicfieldupdate();
	 $("#messagesDiv").empty();
	 $("#messagesDiv").append(responseText);
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
