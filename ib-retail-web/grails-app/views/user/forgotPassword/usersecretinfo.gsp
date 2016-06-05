<head>
<meta name="layout" content="loginlayout" />
</head>
<body class="nonapp">
<header class="header">
  <div class="header-wrap">
    <h1><a href="#">${message(code:'userregistration.userregistration.usersecretinfo.h1.text') }</a></h1>
  </div>
</header>
 
<g:render template="/user/forgotPassword/templates/secretinfocontent"/> 
<g:render template="/common/security/templates/securityUtils" />

<g:render template="/user/templates/footer"/>

<g:javascript>
$(document).ready(function () {
            $(".vkey1").trigger("click");
            $('.card_split').on("keyup", function (e) { 
                if ($(this).val().length > 3) {
                $(this).next('.card_split').removeAttr('disabled');  
                    $(this).next('.card_split').focus();
                }
            });
               
        });
        $( ".vkey1").on("click",function(e){
        
        	$("#card1").focus(); 
        	
        
        });
//Numeric Virtual keypad starts
	$(document).ready(function(){
            $( ".middle_img_keypad" ).draggable({cursor: "move"});
            $( ".close_vk,.done").click(function(){$(".middle_img_keypad").fadeOut("1000",function(){$(".middle_img_keypad").hide()}); });
            $( ".vkey1").click(function(){$(".middle_img_keypad").toggle()});
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
	} 




function checkFormInputs()
{

   if (checkFormValidity("forgotPasswordForm")) {
				return false;		 
		}
		else{
		$(".failure").remove();
	if($("#pinNumber").val()!=''){    
	var pinVal = $("#pinNumber").val();
	var cipher = encrypt(pinVal);
	$("#pinNumber").val(cipher);
	}
	var cNum = $("#card1").val()+$("#card2").val()+$("#card3").val()+$("#card4").val();
	$("#cardNumber").val(cNum);
		}
   
	
}
     
   
 $(document).ready(function () {
      
            $('.pinNumber').on("keyup", function (e) { 
                if ($(this).val().length > 3) {
                $(this).next('.pinNumber').removeAttr('disabled');  
                    $(this).next('.pinNumber').focus();
                }
            });
               
        });
        $( "#vkeypin").on("click",function(e){
        
        	$("#pinNumber").focus(); 
        	
        
        });      
        
        
$('.carousel').carousel({
	itemsPerPage:4,
	itemsPerTransition: 4,
	easing: 'linear',
	noOfRows: 2
});
/*
 * jQuery Carousel Plugin v1.0
 * http://richardscarrott.co.uk/posts/view/jquery-carousel-plugin
 *
 * Copyright (c) 2010 Richard Scarrott
 *
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 * Requires jQuery v1.4+
 *
 */

// prototypal inheritance
if (typeof Object.create !== 'function') {
	Object.create = function (o) {
		function F() {}
		F.prototype = o;
		return new F();
	};
}

(function($) {
	// ie alias
	var headache = $.browser.msie && $.browser.version.substr(0,1)<9;

	// carousel
	var Carousel = {
		settings: {
			itemsPerPage: 1,
			itemsPerTransition: 1,
			noOfRows: 1,
			pagination: true,
			nextPrevLinks: true,
			speed: 'normal',
			easing: 'swing'
		},
		init: function(el, options) {
			if (!el.length) {return false;}
			this.options = $.extend({}, this.settings, options);
			this.itemIndex = 0;	
			this.container = el;
			this.runner = this.container.find('ul');
			this.items = this.runner.children('li');
			this.noOfItems = this.items.length;
			this.setRunnerWidth();
			if (this.noOfItems <= this.options.itemsPerPage) {return false;} // bail if there are too few items to paginate
			this.insertMask();
			this.noOfPages = Math.ceil((this.noOfItems - this.options.itemsPerPage) / this.options.itemsPerTransition) + 1;
			if (this.options.pagination) {this.insertPagination();}
			if (this.options.nextPrevLinks) {this.insertNextPrevLinks();}
			this.updateBtnStyles();
		},
		insertMask: function() {
			this.runner.wrap('<div class="mask" />');
			this.mask = this.container.find('div.mask');

			// set mask height so items can be of varying height
			var maskHeight = this.runner.outerHeight(true);
			this.mask = this.container.find('div.mask');
			this.mask.height(maskHeight);
		},
		setRunnerWidth: function() {
			this.noOfItems = Math.round(this.noOfItems / this.options.noOfRows);
			var width =  this.items.outerWidth(true) * this.noOfItems;
			this.runner.width(width);
		},
		insertPagination: function() {
			var i, links = [];
			this.paginationLinks = $('<ol class="pagination-links" />');
			for (i = 0; i < this.noOfPages; i++) {
				links[i] = '<li><a href="#item-' + i + '">' + (i + 1) + '</a></li>';
			}
			this.paginationLinks
				.append(links.join(''))
				.appendTo(this.container)
				.find('a')
					.bind('click.carousel', $.proxy(this, 'paginationHandler'));
		},
		paginationHandler: function(e) {
			this.itemIndex = e.target.hash.substr(1).split('-')[1] * this.options.itemsPerTransition;
			this.animate();
			return false;
		},
		insertNextPrevLinks: function() {
			this.prevLink = $('<a href="#" class="prev">Prev</a>')
								.bind('click.carousel', $.proxy(this, 'prevItem'))
								.appendTo(this.container);
			this.nextLink = $('<a href="#" class="next">Next</a>')
								.bind('click.carousel', $.proxy(this, 'nextItem'))
								.appendTo(this.container);
		},
		nextItem: function() {
			this.itemIndex = this.itemIndex + this.options.itemsPerTransition;
			this.animate();
			return false;
		},
		prevItem: function() {
			this.itemIndex = this.itemIndex - this.options.itemsPerTransition;
			this.animate();
			return false;
		},
		updateBtnStyles: function() {
			if (this.options.pagination) {
				this.paginationLinks
					.children('li')
						.removeClass('current')
						.eq(Math.ceil(this.itemIndex / this.options.itemsPerTransition))
							.addClass('current');
			}

			if (this.options.nextPrevLinks) {
				this.nextLink
					.add(this.prevLink)
						.removeClass('disabled');
				if (this.itemIndex === (this.noOfItems - this.options.itemsPerPage)) {
					this.nextLink.addClass('disabled');
				} 
				else if (this.itemIndex === 0) {
					this.prevLink.addClass('disabled');
				}
			}
		},
		animate: function() {
			var nextItem, pos;
			// check whether there are enough items to animate to
			if (this.itemIndex > (this.noOfItems - this.options.itemsPerPage)) {
				this.itemIndex = this.noOfItems - this.options.itemsPerPage; // go to last panel - items per transition
			}
			if (this.itemIndex < 0) {
				this.itemIndex = 0; // go to first
			}
			nextItem = this.items.eq(this.itemIndex);
			pos = nextItem.position();
			
			if (headache) {
				this.runner
					.stop()
					.animate({left: -pos.left}, this.options.speed, this.options.easing);
			}
			else {
				this.mask
					.stop()
					.animate({scrollLeft: pos.left}, this.options.speed, this.options.easing);
			}
			this.updateBtnStyles();
		}
	};

	// bridge
	$.fn.carousel = function(options) {
		return this.each(function() {
			var obj = Object.create(Carousel);
			obj.init($(this), options);
			$.data(this, 'carousel', obj);
		});
	};
})(jQuery);

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

 $('.carousel').carousel({
				itemsPerPage:5,
				itemsPerTransition: 5,
				easing: 'linear',
				noOfRows: 2
			});

$(document).ready(function(){

$( "#ibUserSecureMessage" ).keyup(function(){
              var text=$(this).val();
              $('.sec_prvw div p i').text(text);
})
$( "input[name=ibUserSecureColorChkId]" ).change(function() {
              if($(this).is( ":checked" )){
                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').parent().siblings().find('label').removeClass('active').find('.ticker').detach('.ticker');  
                var color=$(this).val();                
                $('.sec_prvw').css("background-color","#"+color);
                }
            }).change();
			var num;
			
			
				
				
		});	// ready end	
		

		
	 /* Script for login Secure Images*/
            $( "input[name=secureImg]" ).change(function() {
	              if($(this).is( ":checked" )){
	                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').siblings().removeClass('active').find('.ticker').detach('.ticker');  
	                }
    		}).change();  
    counter=1;
	function warningAlert(){	
		if(counter==1){	
			var x = "Bank recommends using virtual key-board and you must confirm taking full resposibility of not using it";
			var str = '<span style='+ '"' + 'background: url(' + '/ib-retail-web/themes/pmcb_theme/img/common/black-icon.png' + ') no-repeat scroll -796px -40px transparent;display: block;height: 30px;vertical-align: middle;width: 29px;' + '"' + '></span> ';
	
			x=str+'   ' + x;
			//alert(str); 
		
		    $('<div class="alert_popup">' + x + '</div>').dialog({
		        resizable: false,
		        title:"Warning message",
		        position:['middle',200],
		        draggable: false,
		        modal:true,
		        buttons: {
		            "Confirm": function() {		
		             counter++;    				            	
		                $(this).dialog("close");
		               $("#card1").focus();
		                <!-- $("#ibUserEncryptedPassCode").focus(); -->
		                         
		            },
		            Cancel: function() {
		                  $("#card1").focus();
		                $(this).dialog("close"); //close confirmation
		                 $(".vkey1").click(); 
		              <!--  $("#ibUserEncryptedPassCode").focus(); -->
		            }
		        }		    
			});
			$('.ui-dialog :button').blur();
			setTimeout(function() {
      			$('.ui-dialog :button:first-child').focus();
			}, 500);
		}	
	}	
</g:javascript>
</body>
</html>