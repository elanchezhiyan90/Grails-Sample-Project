<head>
<style>
.dateline {
    clear: both;
    display: inline-block;
    width: 100%;
}

</style>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<div class="body-scroll">

<section>
<form name="frmDateline" id="frmDateline" method="post">
  
  
	 <h2><span class="date_line"></span>${message(code:'dateline.dateline.subheader.text')} <a href="#" id="addreminder" class="add " title="Add Reminder">+</a></h2>
<div class="grid_filter">
                   	<!--  <option value="BP">${message(code:'dateline.dateline.sort.billpayments.message')}</option> 
                   		<option value="REM_BP">${message(code:'dateline.dateline.sort.billpaymentreminders.message')}</option>
                   	-->
                                <div class="fields">
                                <p>
                                <label for="sort">${message(code:'dateline.dateline.sort.label')}</label>
                                <select name="sortBy" id="sortBy">
                                	<option value="" >${message(code:'dateline.dateline.sort.select.message')}</option>                                   
                                    <option value="FT">${message(code:'dateline.dateline.sort.fundtransfers.message')}</option>
                                    <option value="SR">${message(code:'dateline.dateline.sort.servicerequest.message')}</option>
                                    <option value="SI">${message(code:'dateline.dateline.sort.standinginstruction.message')}</option>
                                    <option value="REM_FT">${message(code:'dateline.dateline.sort.paymentreminders.message')}</option>  
                                    <option value="REM_BIRTHDAY">${message(code:'dateline.dateline.sort.bdayreminders.message')}</option>                                                                      
                                    <option value="REM_GEN">${message(code:'dateline.dateline.sort.generalreminders.message')}</option>
                                    <option value="BULK_PAY">${message(code:'dateline.dateline.sort.generalreminders.message')}</option>
                         		</select>
                                </p>
                                </div>
                            	
                                <div class="fields">
                                <p>
                                    <label for="search">${message(code:'dateline.dateline.search.label')}</label>
                                    <input type="text"  name="searchText"  id="searchText" />                                   
                                   
                                    <g:submitToRemote 
											name="searchBtn"
											url="[controller:'dateline',action:'getDatelineTaskByFilter']"
											id="searchBtn"
											value="${message(code:'dateline.dateline.button.search.text')}"
											before="if (checkFormValidity()) {return false;}"
											onSuccess="refreshDatelineContent(data,textStatus)"
											onFailure="refreshFailure(XMLHttpRequest.responseText)"
											class="btn_next"></g:submitToRemote>
                                 </p>
                                </div>
                        
     <div class="dtl_swap_div"><label>${message(code:'dateline.dateline.switchview.label')}</label>
     	<ul>
     		<li><a href="#" class="crnt" id="stream-view"  title="${message(code:'dateline.dateline.streamview.tooltip.text')}"><span></span></a></li>
     		<li><a href="#" id="calendar-view" title="${message(code:'dateline.dateline.calendarview.tooltip.text')}"><span></span></a></li>
     	</ul>
     </div>
    </div>        
 
 
 <!-- Dateline streem starts here--------------->
     
   <div class="dateline" id="datelineContent">           
            
             <g:render template="templates/datelineContent" />
            
     </div>
            
   <!------------dateline streem ends here --------------->
    <div class="calendar" style="display:none;"></div>
 
	<div id="dialog-confirm" title="${message(code:'dateline.task.details.title')}" style="display: none;">
 		 <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>${message(code:'dateline.task.details.areyousure.text')}</p>
	</div>
    
</form>
</section><!------------col-480 ends here --------------->
</div>
<r:require modules="fullcalendar"/>
<g:javascript>

$(document).ready(function () {
	//$(window).scroll(sticky_relocate_top);  /* initiating sticky top functionality on document ready */
	$(".ceebox").ceebox();
	
	$(".dateline").datelineDetails();
	$(".dateline").datelinelist();
		
    $('#addreminder').click(function(e){
    	e.preventDefault();            	
      	var url="${createLink(controller: 'dateline', action: 'addreminder')}";
      	var title=$(this).attr("title");
     	$.fn.ceebox.overlay();
		$.fn.ceebox.popup("<a href='"+url+"' title='"+title+"'></a>",""); 
      
    });      		
   
    $('#removereminder').click(function(){            	
      $(this).attr('href','${createLink(controller: 'reminder', action: 'removereminder')}');
    });   	

	$("#stream-view").click(function(event){
			event.preventDefault();
			$(this).addClass('crnt');
			$(this).parents("li").siblings().find('a').removeClass('crnt');	
			if($(".dateline").is(":hidden")	){
				$(".calendar").hide();
				$(".dateline").show();
				reinitialiseScrollPane();
				}
		});
		
		$("#calendar-view").click(function(event){
			event.preventDefault();
			$(this).addClass('crnt');
			$(this).parents("li").siblings().find('a').removeClass('crnt');	
			if($(".calendar").is(":hidden")	){
				$(".dateline").hide();
				$(".calendar").show();
				$('.calendar').fullCalendar('render');
					reinitialiseScrollPane();
				}
		});


	/************************** calendar function *************/
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		$('.calendar').fullCalendar({
			theme: true,
			month:m,
			today:d,
			header: {
				left: 'title',
				right: 'prev,next today'
			},
			editable: false,			
				
			events: "<%=request.getContextPath()%>/dateline/datelineTaskAsJson",
			
			 eventClick: function(calEvent) {
				//alert('Event: ' + calEvent.title+' & Event ID:'+calEvent.id);
				$(window).load(calEvent.url);
				
			},
			 dayClick: function(date, allDay, jsEvent, view) {

				if (allDay) {
				//	//alert('Clicked on the entire day: ' + date);
					var allEvents=$('.calendar').fullCalendar('clientEvents');
					var eventcount=0;
					for (var i=0; i < allEvents.length;i++){
						if(	!allEvents[i].end){ allEvents[i].end=allEvents[i].start;}
						if(date >= allEvents[i].start &&  date <=allEvents[i].end ){
						 	eventcount++;
						}
					}
					if(eventcount>0){
					//load your ajax
					$("#stream-view").trigger('click');
					}
					//else{alert("there are no events")}
				}
				
			}
		});

});


/******************* request list functions *****************************/	
	$.fn.datelinelist=function(){		
		$(".dateline  ul li").each(function(){
		$(this).find(".d_msg_rht > input.tsk_reject").bind("click",function(){//on Reject button click
			$(this).parents().find(".reject_div,.sendback_div,.accept_div").hide();// hide all reject/accept div if already opend except current
			$(this).parent().find(".reject_div").show().find("textarea").focus();// put focus on textarea(reject reason)
				}).parent().find(".reject_div input.btn_next").bind("click",function(){// on cancle button click(canceling of reject container)
					$(this).parent().hide();//hide reject div
					}).prev("input[type='button']").bind("click",function(){//on clicking submit button with rejected value
						if($(this).parent().find("textarea").checkValidity()){
							var target_action 	= "<%=request.getContextPath()%>/dateline/" + $(this).attr("data-targetaction");
							var data_taskId		= $(this).attr("data-taskid");
							var data_usercmts	= $(this).parent().find("textarea").val();
							var that			= $(this);
							$.ajax({
													type : "POST",
													url : target_action,
													data:{'id':data_taskId,'userComments':data_usercmts},
													success : function(data) {
																if($(that).parent().parent().parent('li').is("li:last-child")){//if current list is last then shift focus to previous list
																	$(that).parent().parent().parent('li').prev().find("> a").focus();
																	}
																else{$(that).parent().parent().parent('li').find("> a").focus();}
																$(that).parent().parent().parent("li").addClass("red").find(".d_msg_rht").empty().append(data);	
													},
													error : function() {
														alert('an error occurred!');
													}
								});
							}
						});
		$(this).find(".d_msg_rht > input.tsk_sendback").bind("click",function(){//on sendback button click
			$(this).parents().find(".sendback_div,.reject_div,.accept_div").hide();// hide all reject/accept div if already opend except current
			$(this).parent().find(".sendback_div").show().find("textarea").focus();// put focus on textarea(reject reason)
				}).parent().find(".sendback_div input.btn_next").bind("click",function(){// on cancle button click(canceling of reject container)
					$(this).parent().hide();//hide reject div
					}).prev("input[type='button']").bind("click",function(){//on clicking submit button with rejected value
							if($(this).parent().find("textarea").checkValidity()){
							var target_action 	= "<%=request.getContextPath()%>/dateline/" + $(this).attr("data-targetaction");
							var data_taskId		= $(this).attr("data-taskid");
							var data_usercmts	= $(this).parent().find("textarea").val();
							var that			= $(this);
							$.ajax({
													type : "POST",
													url : target_action,
													data:{'id':data_taskId,'userComments':data_usercmts},
													success : function(data) {
																if($(that).parent().parent().parent('li').is("li:last-child")){//if current list is last then shift focus to previous list
																	$(that).parent().parent().parent('li').prev().find("> a").focus();
																	}
																else{$(that).parent().parent().parent('li').find("> a").focus();}
																$(that).parent().parent().parent("li").addClass("red").find(".d_msg_rht").empty().append(data);	
													},
													error : function() {
														alert('an error occurred!');
													}
								});
							}
						});
		$(this).find(".d_msg_rht > input.tsk_accept").not(".btn_next").click(function(){// on clicking Accept button 
			$(this).parents().find(".accept_div,.sendback_div,.reject_div").hide();// hide all reject/accept div if already opend except current
			$(this).parent().find(".accept_div").show().find("textarea").focus();//put focus on textarea(reject reason)
				}).parent().find(".accept_div input.btn_next").click(function(){//on cancel button click
					$(this).parent().hide();//hide accept div
					}).prev("input").not(".btn_next").click(function(){// on confirm button click
						
						if($(this).parent().find("textarea").checkValidity()){
							var target_action 	= "<%=request.getContextPath()%>/dateline/" + $(this).attr("data-targetaction");
							var data_taskId		= $(this).attr("data-taskid");
							var data_usercmts	= $(this).parent().find("textarea").val();
							var that			= $(this);
							$.ajax({
													type : "POST",
													url : target_action,
													data:{'id':data_taskId,'userComments':data_usercmts},
													success : function(data) {
																if($(that).parent().parent().parent('li').is("li:last-child")){//if current list is last then shift focus to previous list
																	$(that).parent().parent().parent('li').prev().find("> a").focus();
																	}
																else{$(that).parent().parent().parent('li').find("> a").focus();}
																$(that).parent().parent().parent("li").addClass("green").find(".d_msg_rht").empty().append(data);	
													},
													error : function() {
														alert('an error occurred!');
													}
								});
							}
						});
	});	
	
	
/********************** traversal between dateline list using keyboar ***************/
	
	var chosen = "";
$(document).bind('keydown','down up',function(e){ // 38-up, 40-down
    if (e.keyCode == 40) {
		
        if(chosen === "") {
            chosen = 0;
			 
        } else if((chosen+1) < $('.dateline ul li').length) {
            chosen++; 
        }
        //$('.dateline ul li').removeClass('selected');
		
        $('.dateline ul li:eq('+chosen+')').find(">a").focus();
		$('.dateline ul li:eq('+chosen+')').bind('keydown','a',function (evt){
				//$(this).find(">a").blur();
				$(this).siblings("li").find(".reject_div,.accept_div").hide();
				$(this).find(".accept_div").show().find("> input[type='button']").not(".btn_next").focus();
				
				return false; 
			 });
		$('.dateline ul li:eq('+chosen+')').bind('keydown', 'r',function (evt){
				//$(this).find(">a").blur();
				$(this).siblings("li").find(".reject_div,.accept_div").hide();
				$(this).find(".reject_div").show().find("input").not("input[type='button']").focus()
					.bind('keydown', 'down up',function (evt){evt.stopPropagation()});
				return false; 
			 }); 
        return false;
    }
    if (e.keyCode == 38) { 
	
        if(chosen === "") {
            chosen = 0;
			
        } else if(chosen > 0) {
            chosen--;            
        }
        //$('.dateline ul li').removeClass('selected');
		
        $('.dateline ul li:eq('+chosen+')').find(">a").focus();
		$('.dateline ul li:eq('+chosen+')').keydown('a',function (evt){
				$(this).find(">a").blur();
				$(this).siblings("li").find(".reject_div,.accept_div").hide();
				$(this).find(".accept_div").show().find("> input[type='button']").not(".btn_next").focus();
			 return false; 
			 });
		$('.dateline ul li:eq('+chosen+')').keydown( 'r',function (evt){
				$(this).find(">a").blur();
				$(this).siblings("li").find(".reject_div,.accept_div").hide();
				$(this).find(".reject_div").show().find("input").not("input[type='button']").focus()
					.bind('keydown', 'down up',function (evt){evt.stopPropagation()});
			 return false; 
			 }); 
       return false;
    }
});

};

/******************* show /Hide list detail ************************/	
	$.fn.datelineDetails=function(){
	$(".dateline li.has-dtl>a").click(function(event){
		//event.preventDefault();
		if ($(this).parent("li.has-dtl").find(".view-dtl").is(':visible')){
				$(this).parent("li.has-dtl").find(".view-dtl").slideUp(function(){reinitialiseScrollPane()});
				 //reinitialiseScrollPane();
				 $(this).parent("li.has-dtl").removeClass('hlt');
				
		}
		if ($(this).parents().find(".view-dtl").is(':visible')){
				$(this).parents().find(".view-dtl").slideUp(function(){reinitialiseScrollPane()});
				$(this).parents().find("li.has-dtl").removeClass('hlt');
				
		}
		if ($(this).parent("li.has-dtl").find(".view-dtl").is(':hidden')){
				var href = $(this);
				var event_type  = $(this).attr("event-type");
				var data_params = $(this).attr("data-params");				
				var query_param = "&taskValue="+$(this).attr("data-queryparam");	
				data_params		= data_params+query_param	 
				var params 		= $.parseParams(data_params.split('?')[1] || '');			
				url_action 		= "<%=request.getContextPath()%>/dateline/showTaskDetails";				
				//alert(event_type)			
				$.ajax({
						type : "POST",						
						url : url_action,
						data : params.join('&'),
						success : function(data) {
							$(href).parent("li.has-dtl").find(".view-dtl").empty().append(data);
							$(href).parent("li.has-dtl").find(".view-dtl").slideDown(function(){reinitialiseScrollPane()});
							$(href).parent("li.has-dtl").addClass('hlt');
							
						},
						error : function() {
							alert('an error occurred!');
						}
				});				
		}
		
		//reinitialiseScrollPane();
	});
	
	$(".dateline ul li .del>a").click(function(event){
		var that			= $(this);	
		var data_param_id 	= $(this).attr("data-queryparam");
		//alert(data_param_id);	
		$("#dialog-confirm" ).dialog({
					  resizable: false,
					  height:140,
					  modal: true,
					  buttons: {
						Cancel: function() {
						  $( this ).dialog( "close" );
						  return false;
						},
						"Ok": function() {									
								$.ajax({
								type 	: "POST",
								url 	: "<%=request.getContextPath()%>/dateline/removeTaskFromDateline",
								data 	: {'removeTaskId':data_param_id},
								success : function(data) {	
										//alert('success');
										$(that).closest('li').remove();
								},
								error : function() {
									alert('an error occurred!');
								}
						});
						  $( this ).dialog( "close" );
						  return true;
						}        
					  }
		});		
	});

	
	$('#searchText').live("keypress", function(e) {
	var searchTxt = $("#searchText").val()
	var filter    = $("#sortBy").val()
            if (e.keyCode == 13) {
                //alert("Enter pressed");
                $.ajax({
					type 	: "POST",
					url 	: "<%=request.getContextPath()%>/dateline/getDatelineTaskByFilter",
					data 	: {'searchText':searchTxt,'sortBy':filter},
					success : function(data) {	
							//alert('success');
							$("#datelineContent").html(data); 	
							$("#datelineContent").dynamicfieldupdate();	
							$(".dateline").datelineDetails();
							$(".dateline").datelinelist();
					},
					error : function() {
						alert('an error occurred!');
					}
				});	
                
            }
    });   
	
	
};

(function($) {
var re = /([^&=]+)=?([^&]*)/g;
var decodeRE = /\+/g;  // Regex for replacing addition symbol with a space
var decode = function (str) {return decodeURIComponent( str.replace(decodeRE, " ") );};
$.parseParams = function(query) {
	var e;
    var params = new Array();
    while ( e = re.exec(query) ) { 
    	var paramObject = new Object();
        var k = decode( e[1] ), v = decode( e[2] );
        paramObject[k] = v;
        var str = $.param(paramObject);
        params.push(str);
    }
    return params;
};
})(jQuery);

function notifyStatus(data,textStatus){
	//alert(data);
}

function removeReminder(obj){
	//alert(obj);
	$('#removereminder'+obj).attr('href','${createLink(controller: 'reminder', action: 'removereminder')}?reminderId='+obj);
	$.fn.ceebox.closebox();
	$("#datelinehome",window.parent.document).trigger("click");
}

function emptyErrorDiv()
{
	$("#errorDiv").empty();
}
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

function onPaymentSuccess(data,textStatus)
	{			
		$("#datelinehome",window.parent.document).trigger("click");		
		$.fn.ceebox.closebox();
	}
  function onPaymentFailure(data,textStatus)
	{			
		$.fn.ceebox.closebox();	
	}	
	
function refreshDatelineContent(data,textStatus){	
	$("#datelineContent").html(data); 	
	$("#datelineContent").dynamicfieldupdate();	
	$(".dateline").datelineDetails();
	$(".dateline").datelinelist();	
}


</g:javascript>

