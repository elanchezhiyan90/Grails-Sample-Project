/* Author:I Mohammed Subhan
	Date:18 july 2012
*/
 /**************** before page loads******************/

 /***************** After page get loaded ************/
 $(document).ready(function()  {
	 
	menufunch();// Initializing menu functions
	pulldown();// enabling pulldown function 
	/*******************************Top navigation Drop Down menu****************************/
	$('.dd-nav a,.userphoto a').click(function(event){
		event.preventDefault()	 
		if($('.dd-menu').is(':hidden')){
		$('.dd-menu').slideDown("100");
		}else{$('.dd-menu').slideUp("100");}
        });
	$('.dd-menu').mouseup(function() {
        return false
        });
	$('.dd-menu').mouseleave(function(){
			$(this).delay(800).slideUp("100");  
		});	
	$(document).mouseup(function() {
           $('.dd-menu').slideUp("100");  
    	}); 
	
	/****************left menu accordion ( jquery UI- customised)******************/
	
	$(".accor-nav").accordion({ header: 'h3', autoHeight: false,
		change: function(event, ui){ 
		ui.newHeader.find(".add").show().css({'display':'inline-block'});
		ui.oldHeader.find(".add").hide();
		if(ui.oldHeader.next("ul").find("li").hasClass("active")){
			ui.oldHeader.addClass('openhlt');
			}else{ui.oldHeader.removeClass('openhlt');}
		if(ui.newHeader.next("ul").find("li").hasClass("active")){
			ui.newHeader.removeClass('openhlt');
			}else{ui.newHeader.removeClass('openhlt');}
		}
	});
	$(".add").hide();
	$(".add").click(function(event){
		event.stopPropagation();
	});
	$(".ui-state-active").find(".add").show().css({'display':'inline-block'});
	
	/********************* Tab function ****************/
		$(".app_tabs ul li").click(function(){
			$(this).addClass('active');
			$(this).siblings("li").removeClass('active') 
		});
		$(".nav-section").show();//hiding the left slide nav intially  and show it after dom load to avoid flickering
		$('.ui-accordion-header').click(function(){
			$(this).menuscroll();//applying scroller inside the menu on click
			$(this).find(".add").show().css({'display':'inline-block'});
		});
		$('.ui-accordion-header').menuscroll();
		$(document).click(function(event) {
		if ( $(event.target).closest(".ui_chat,.float-menu #chat ").get(0) == null ) { 
			$(".c_cont").hide("fast"); 
			}
			});
		$(".ui_chat h3").bind("click",function(){
			$(".c_cont").toggle("fast");
			$(".ui-req ul").hide("fast");
			$(".c_cont input").focus();
			});
		$(".c_cont input").keypress(function(e) {
 	 		if (e.keyCode == '13') {
				var chat=$(".c_cont input").val();
				$(".conversation").append("<div class='user'><img src='themes/default_theme/img/branding/user_pic.jpg' width='36' height='36' /><div class='txt'><p>"+chat+"</p></div></div>");
				$(".c_cont input").val('');
				}
			});
		
 });//end of document onload 
$.fn.menuscroll=function(){
	
 $(this).each(function(){
		var $search=$('<div class="msearch"><input type="text" class="searchInput" placeholder="Type to search"></div>');
		var det=$(this).next('ul').find('div').hasClass('hold');
			if($(this).next('ul').find('li').length>=5 && det==false ){// li 's has to be more than or eq to 5 and ul should not already have a div
			  //	alert("The list is morethan or =to 5 and scroll is not applied");
              if($(this).next('ul').find('div.msearch').length==0){
                      $search.prependTo($(this).next('ul'));
              } 
				var calht=$(this).next('ul').find('li').outerHeight()*5+4+$search.outerHeight() ;
				$(this).next('ul').addClass("hold");
				$(this).next('ul.hold').css({'height':calht});
				}
            //newly added
            $that=$(this).next('ul');
            // condition to check menu style is paymnet module
               if($that.find("li .lnk span[class^='nick-']").length){
                $that.find('.msearch .searchInput').focus().bind("keyup",function() {
          		searchWord = $(this).val();

                  if (searchWord.length >= 1) {
                   // alert(".nme present")
          		     $that.find('li').hide();
                     $that.find("li .lnk span[class^='nick-'] span").css({'font-weight':'normal','color':'#666'});
            		 $that.find("li.active .lnk span[class^='nick-'] span").css({'font-weight':'normal','color':'#333'});
                     $that.find("li .lnk span[class^='nick-']").each(function(i, data) {
          				text = $(this).text();
          				if (text.match(RegExp(searchWord, 'i'))) {
                           newHTML = text.replace(text.match(RegExp(searchWord,'i')), '<span style="font-weight:bold;color:#000;">'+text.match(RegExp(searchWord,'i'))+'</span>');
          				   $that.find("li .lnk span[class^='nick-']:eq("+i+")").html(newHTML).parents("li").show();
          				}
          			});
          		 } else {
          			   $that.find('li').show();
          				$that.find("li .lnk span[class^='nick-'] span").css({'font-weight':'normal','color':'#666'});
          			   $that.find("li.active .lnk span[class^='nick-'] span").css({'font-weight':'normal','color':'#333'});
                  }
                });

            }
            if($that.find('li .lnk .nme').length){
                $that.find('.msearch .searchInput').focus().bind("keyup",function() {
          		searchWord = $(this).val();

                  if (searchWord.length >= 1) {
                   // alert(".nme present")
          		     $that.find('li').hide();
                     $that.find('li .lnk span.nme span').css({'font-weight':'normal','color':'#666'});
            		 $that.find('li.active .lnk span.nme span').css({'font-weight':'normal','color':'#333'});
                     $that.find('li .lnk span.nme').each(function(i, data) {
          				nmetext = $(this).text();
          				if (nmetext.match(RegExp(searchWord, 'i'))) {
                           newHTML = nmetext.replace(nmetext.match(RegExp(searchWord,'i')), '<span style="font-weight:bold;color:#000;">'+nmetext.match(RegExp(searchWord,'i'))+'</span>');
          				   $that.find('li .lnk span.nme:eq('+i+')').html(newHTML).parents("li").show();
          				}
          			});
          		 } else {
          			   $that.find('li').show();
          				$that.find('li .lnk span.nme span').css({'font-weight':'normal','color':'#666'});
          			   $that.find('li.active .lnk span.nme span').css({'font-weight':'normal','color':'#333'});
                  }
                });

            }

            if($that.find('li .lnk .nme').length==0 && $that.find("li .lnk span[class^='nick-']").length==0){
               $that.find('.msearch .searchInput').focus().bind("keyup",function() {
          		searchWord = $(this).val();
                  	if (searchWord.length >= 1) {
                  	 //  alert(".nme Not present")
          		     $that.find('li').hide();
                     $that.find('li .lnk span').css({'font-weight':'normal','color':'#666'});
            		 $that.find('li.active .lnk span').css({'font-weight':'normal','color':'#333'});
                     $that.find('li .lnk ').each(function(i, data) {
          				text = $(this).text();
          				if (text.match(RegExp(searchWord, 'i'))) {
                            newHTML = text.replace(text.match(RegExp(searchWord,'i')), '<span style="font-weight:bold;color:#000;">'+text.match(RegExp(searchWord,'i'))+'</span>');
          				   $that.find('li .lnk:eq('+i+')').html(newHTML).parents("li").show();
          				}
          			});
          		 } else {
          			   $that.find('li').show();
          				$that.find('li .lnk  span').css({'font-weight':'normal','color':'#666'});
          			   $that.find('li.active .lnk span').css({'font-weight':'normal','color':'#333'});

          		  }
            });

            }




          	$('#search').keypress(function(e){
          		if ( e.which == 13 ){
          			e.preventDefault();
          		 	$(this).val('');
                      $that.find('li').show();
          		  //	$('.ui-accordion-header').menuscroll();
          		}
          	});







            //end
            $(this).next('ul.hold').jScrollPane();





 });
	$('.jspContainer').on("mouseenter",function(){
		$('.jspTrack').stop(true,true).fadeIn("medium");
	}).on("mouseleave",function(){
		$('.jspTrack').stop(true,true).fadeOut("medium");	
	});
	$(".jspDrag").on("mouseenter",function(){
		$(this).stop(true,true).css({"opacity":"0.7"}).parents(".jspVerticalBar").animate({width:"10px"},"fast").stop(true,true).css({"background":"rgba(0, 0, 0, 0.1)","box-shadow":"0 0 1px #999 inset"});
		
	}).on("mouseleave",function(){
		$(this).stop(true,true).css({"opacity":"0.5"}).parents(".jspVerticalBar").animate({width:"7px"},"fast").stop(true,true).css({"background":"transparent","box-shadow":"none"})});
					
};
 
var menufunch =function(){
		
	// To Highlight the selected list(menu)
		$(".accor-nav ul li").click(function(){
				$(this).addClass('active');
				$(this).siblings("li").removeClass('active').find("a").removeClass('TransformChecked');
				$(this).parents("ul").siblings().find("li").removeClass('active').find("a").removeClass('TransformChecked');
				$(this).siblings("li").find(".hstry span").addClass("hide").removeClass("show");
				$(this).parents("ul").siblings().find(".hstry span").addClass("hide").removeClass("show");
				$(this).siblings("li").find(".hstry,.linkadd").hide();
				$(this).parents("ul").siblings().find(".hstry,.linkadd").hide();
				$(this).parents("ul").siblings("h3").removeClass('openhlt');
				$("html, body").animate({ scrollTop: 0 }, "fast");
		});
		$(".add,.date-line").click(function(){
			$(".accor-nav ul li").removeClass('active').find("a").removeClass('TransformChecked');
			$(".accor-nav ul li").find(".hstry").hide();
			$(".accor-nav h3").removeClass('openhlt');
			$("html, body").animate({ scrollTop: 0 }, "fast");
		});
		$(".lnk").click(function(){
				$(this).parent("li").find("a").removeClass('TransformChecked');
				$(this).parents("li").find(".hstry,.linkadd").fadeIn("fast");
				$(this).parents("li").find(".hstry span").addClass("hide").removeClass("show");
		});
		
		$(".hstry,.linkadd").hide();//hiding history button on page load
		$("a.hstry span").click(function(event){
			event.preventDefault();
				if($(window).width() < 1024){
					if($(this).hasClass("hide")&& $("#canvas").contents().find(".t-panel").is(':hidden')){
							$("#canvas").contents().find(".related-nav").hide("medium");
							$(this).addClass("show").removeClass("hide");
							$("#canvas").contents().find(".t-f-panel").animate({width:'730px'},"medium",function(){
								$("#canvas").contents().find(".t-panel").show("medium")
							});
					}
					else if($(this).hasClass("show")&& $("#canvas").contents().find(".t-panel").is(':visible')) {
						$(this).addClass("hide").removeClass("show");
						$("#canvas").contents().find(".t-panel").hide("medium",function(){
							$("#canvas").contents().find(".t-f-panel").animate({width:'414px'},"medium");
							$("#canvas").contents().find(".related-nav").show("medium");	
							});
					}
				}
				else if($(window).width() > 1024){
					if($(this).hasClass("hide")&& $("#canvas").contents().find(".t-panel").is(':hidden')){
							$(this).addClass("show").removeClass("hide");
							$("#canvas").contents().find(".t-f-panel").animate({width:'730px'},"medium",function(){
								$("#canvas").contents().find(".t-panel").show("medium");
								$("#canvas").contents().find(".related-nav").show("medium");
							});
					}
					else if($(this).hasClass("show")&& $("#canvas").contents().find(".t-panel").is(':visible')) {
						$(this).addClass("hide").removeClass("show");
						$("#canvas").contents().find(".t-panel").hide("medium",function(){
							$("#canvas").contents().find(".t-f-panel").animate({width:'414px'},"medium");
							$("#canvas").contents().find(".related-nav").show("medium");
							});
					}
				}
		});
	
		$("input[type=radio]").TransRadio();//Initializing customized Radio button for menu 
	
	
	};
	

/*************************** Cusotmozied Radio Buttons for menu ***************************/	
$.fn.TransRadio = function(){
		return this.each(function(){
			if($(this).hasClass('TransformHidden')) {return;}

			var $input = $(this);
			var inputSelf = this;
			var aLink = $('<a href="'+ this.value +'" class="TransformRadio" rel="'+ this.name +'" title="'+ this.title+'" target="canvas"><span></span></a>');
			$input.addClass('TransformHidden').wrap('<span class="TransformRadioWrapper"></span>').parent().prepend(aLink);
			
			$input.change(function(){
				inputSelf.checked && aLink.addClass('TransformChecked').parents("li").find(".hstry span").addClass("hide").removeClass("show") && aLink.parents("li").find(".hstry").hide() || aLink.removeClass('TransformChecked');
				return true;
			});
			// Click Handler
			aLink.click(function(event){
				event.stopPropagation();
				if($input.attr('disabled')){return false;}
				$input.trigger('click').trigger('change');
				// uncheck all others of same name input radio elements
				$('input[name="'+$input.attr('name')+'"]',inputSelf.form).not($input).each(function(){
					$(this).attr('type')=='radio' && $(this).trigger('change');
				});
	
				//return false;					
			});
			// set the default state
			inputSelf.checked && aLink.addClass('TransformChecked');
		});
};

/************ pull down menu ***********************/
	var pulldown=function(){
		
		$("#pdcontainer").show();
		var openHeight = $("#pdcontainer").outerHeight();
		var openIHeight = $(window).height()-20;
		$("#pdcontainer").css({'height':'0px','width':'100%'});
		var closeHeight = $("#pdcontainer").outerHeight();
		var tippingPoint = openIHeight/2;
		$("#pdmsgbody").hide();
		var purl=$("#pdmsgcont").find("a.hidden").attr("href");
		$("#pdmsgcont").empty().load(purl,function(){inboxaction();alertboxaction();});// load mesage profile page intially on load
		$("#pdcontainer").resizable(
			{
				handles: {
					"s":"#pdpoint"   
				},
				maxHeight: openIHeight,
				minHeight:0,
				start: startDrag,
				stop:endDrag
			}
		);
		function startDrag(){
			var templayer=$("<div class='templayer' style='width:"+$("body").width()+"px; height:"+$("body").height()+"px;'></div>");
			if($("div").hasClass("templayer")){return true}else{ $("body").prepend(templayer);}
			$("#pdmsgbody").fadeIn("slow");
			$("#pdmsgcont").css({'height':$(window).height()-200});
			}
		function endDrag(){
			
			if ($("#pdcontainer").height() > tippingPoint){
				$("#pdcontainer").css('width','100%');
				$("#pdcontainer").animate({ height:openIHeight }, 500);
				
				}
			else{
				$("#pdcontainer").css('width','100%');
				$("#pdcontainer").animate({ height:0 }, 500, function(){
				$("#pdmsgbody").fadeOut("fast");
				$(".templayer").remove();
				$("#pdmsgcont").empty().load(purl,function(){inboxaction();alertboxaction();});
				});
			}
		}
		
		$(".alerter a,.inbox a").click(function(event){
			$("#pdcontainer").animate({ height:openIHeight }, 500);
			startDrag();
			
		});
		
		$(".clx-pd, .date-line a").click(function(){
			$("#pdcontainer").css('width','100%');
			$("#pdcontainer").animate({ height:0 }, 500, function(){
			$("#pdmsgbody").fadeOut("fast");
			$(".templayer").remove();
			$("#pdmsgcont").empty().load(purl,function(){inboxaction();alertboxaction();});
			});
		
		});
		
		// profile btn and log history action
		$(".userInfo").click(function(){
        	var openIHeight = $(window).height()-20;
        	$("#pdcontainer").animate({ height:openIHeight }, 500);
			startDrag();
			$("#pdmsgcont").fadeOut(500).fadeIn(500);
        });
		
		
	};//end of pulldown function
	
	/************** inbox actions *****************/
	var inboxaction=function(){
			$(".msgs li a").click(function(event){
				//event.preventDefault();
				//var msgsurl=$(this).attr("href");
				//$("#pdmsgcont").fadeOut(500,function(){$(this).empty().load(msgsurl)}).fadeIn(500);
				/*$("#pdmsgcont").fadeOut(500,function(){
					$(this).empty().load(msgsurl);
					$(this).show('slide', {direction: 'right'},800).fadeIn(500);
				});*/
				//$("#pdmsgcont").hide('slide', {direction: 'left'},function(){$(this).empty().load(msgsurl);},800).show('slide', {direction: 'right'},500);
				//$("#pdmsgcont").hide('slide', {direction: 'left'},function(){$(this).empty();},800).show('slide', {direction: 'right'},500);
			});
	};//end of inbox action
	
	/************** alertbox actions *****************/
	var alertboxaction=function(){
		$(".alts .clx").click(function(event){
			event.preventDefault();
			var rem=$(this).parents("li");
			rem.fadeOut(500, function(){
				rem.remove();});
			});
		
	};
	// JQuery Idle Time Out
		
		$("#dialog").dialog({
			autoOpen: false,
			modal: true,
			width: 400,
			height: 200,
			closeOnEscape: false,
			draggable: false,
			resizable: false,
			buttons: {
				'Yes, Keep Working': function(){
					$(this).dialog('close');
				},
				'No, Logoff': function(){
					// fire whatever the configured onTimeout callback is.
					// using .call(this) keeps the default behavior of "this" being the warning
					// element (the dialog in this case) inside the callback.
					$.idleTimeout.options.onTimeout.call(this);
				}
			}
		});

		// cache a reference to the countdown element so we don't have to query the DOM for it on each ping.
		var $countdown = $("#dialog-countdown");

		// start the idle timer plugin
		$.idleTimeout('#dialog', 'div.ui-dialog-buttonpane button:first', {
			idleAfter: 240,
			pollingInterval: 60,
			keepAliveURL: 'keepalive',
			serverResponseEquals: 'OK',
			warningLength: 60,
			onTimeout: function(){
			  window.location = "ib-retail-web/j_spring_security_logout";
				
			},
			onIdle: function(){
				$(this).dialog("open");
			},
			onCountdown: function(counter){
				$countdown.html(counter); // update the counter
			}
		});	
		

