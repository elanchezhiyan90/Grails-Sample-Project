<head>
<meta name="layout" content="main" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>

	<%--<fieldset id="connexion">
	    <legend>Connect</legend>
	    <label for="user">User: </label><input id="user" type="text">
	    <button id="connect">Connect</button>
	</fieldset>
	<div id="messages">
	</div>
	--%>

	<g:render template="templates/header" />
	<g:render template="templates/body" />
	<g:render template="templates/footer" />
	<g:javascript>
	
		if(window.opener) {
			window.opener.location.reload(false);
			window.close();
	} 
	</g:javascript>
	<g:javascript>
			
            function receive() {
                ajax = $.ajax({
                    url: '../atmosphere/alert',
                    dataType: 'html',
                    success: function(text) {
                        $('#messageCount').text(text);
                        if(ajax) {
                            receive();
                        }
                    },
                    error: function() {
                        ajax = null;
                        $('#chat').hide();
                        $('#connexion').show();
                        $('#messages').empty();
                    }
                });
            }

            $('#connect').click(function() {
                $.post('../atmosphere/alert', {
                    user: $('#user').val()
                }, function() {
                    receive();
                });
            });

            $('#send').click(function() {
                var msg = $('#message').val();
                if (ajax && msg.length > 0) {
                    $.post('chat', {
                        message: $('#message').val()
                    }, function() {
                        $('#message').val('');
                    });
                }
            });

            $('#disconnect').click(function() {
                if (ajax) {
                    $.post('chat', {
                        cmd: 'disconnect'
                    }, function() {
                        ajax = null;
                        $('#chat').hide();
                        $('#connexion').show();
                        $('#messages').empty();
                    });
                }
            });
            
            
             	 /*$(".accor-nav h3 a").live("click",function(event){
		            if($(event.target).parent("h3").next("ul").children().size()!==0){
		           
		           		event.preventDefault();
		            	// alert("got child");
		            	//return false;
		            	$(this).removeAttr("onclick");
		              }
		              else{alert("no child")}
		            });*/
		            
		            $(".connectButton").click(function(event){
						event.preventDefault();
						window.open("", "connectWindow", "width=600,height=400");
						var cTP = $(event.currentTarget).parent();
						cTP[0].setAttribute("target", "connectWindow");
						cTP[0].submit();
					});
	            
        //});
        
      function childPresent(d,id)
      {
      	    var retVal = true;
        	var dirtyFlag  = $(id).attr("data-dflag");
        	if(dirtyFlag == "true")
        	{
        		retVal = false;
        	}
        	else if($(d).find("li").size() != 0)
        	{
        	 	retVal = true;
        	}
        	return retVal;	
      }
      
  function onMenuSuccess(menu,data){
       	var sessionvalidity = $(data).filter("#sessionvalidity").val();
       	if(sessionvalidity!= 'undefined' && sessionvalidity == 'false')	{
       		var link = "<g:createLink action='invalidsession' controller='user'/>"
			postUrl('frmMainMenu',link,'canvas');
       	} else 	{
       		if($(menu).next("ul").hasClass("hold")) {
	        	//alert("hashold")
	        	$(menu).next("ul").find(".jspPane").append(data);
	        	menufunch();
	        	$(menu).menuscroll();
	        	$(menu).find(".mloading").hide();
        	} else {
	        	$(menu).next("ul").append(data);
	           	menufunch();
	           	$(menu).menuscroll();
	           	$(menu).find(".mloading").hide();
	           	//alert("success")
           }
         	// Set the Dirty Flag back to FALSE
         	$(menu).attr("data-dflag","false");
       	}
    }
        
        
        function onMenuFailure(menu){
        	$(menu).find(".mloading").hide();
        	
		 // Set the Dirty Flag back to FALSE
         $(menu).attr("data-dflag","true");
         
        }
        
        function onMenuBefore(menu){
        	if($(menu).find("#h3title").find(".mloading").size()!==0){
        	$(menu).find(".mloading").show();
        	}else{$(menu).find("#h3title").append('<span class="mloading"></span>');}
        	
        }
        
        
        
	</g:javascript>
</body>
</html>