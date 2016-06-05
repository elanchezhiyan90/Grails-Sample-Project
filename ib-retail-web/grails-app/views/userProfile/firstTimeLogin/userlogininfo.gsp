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
<g:render template="/userProfile/firstTimeLogin/template/logininfocontent"/>

<g:render template="/user/templates/footer"/>
<g:javascript>
var checkedImg="${fibUserSecureImgChkId?.toList()}" ;
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

//Virtualkeypad starts

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
			}
			else if (num==0)
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
	
	//Virtualkeypad ends		
	
	
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

$(document).ready(function(){

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
</g:javascript>
</body>
</html>