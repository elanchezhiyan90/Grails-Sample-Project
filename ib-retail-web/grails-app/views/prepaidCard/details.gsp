<head>
<meta name="layout" content="applayout"/>
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<vayana:messages/>
     <g:render template="/prepaidCard/templates/details/content" />

<g:javascript>
		var oldnick=$("#nick").text();
		$(document).ready(
				function() {
				
					$(".edit_row").click(
							function(event) {
								event.preventDefault();
								$(this).parent("div").find("span").attr(
										'contenteditable', 'true').focus();
								$(this).parent("div").append("");
								$(this).hide();
								$(this).parent("div").find("input")
										.removeClass("hidden");
								var shortName = $("#accountShortName").val();
								$("#nameBeforeEdit").val(shortName);
							});
					$("#cancel_edit").click(
							function() {
								//alert("clicked");
								$(this).parent("div").find("input")
										.addClass("hidden");
								$(this).parent("div").find("span")
										.removeAttr('contenteditable',
												'true');
								var shortName = $("#nameBeforeEdit").val();
								$("#nick").text(shortName);
								$(".edit_row").show();
							});
							
<%--					$("#cancel_edit").live("click",function(){--%>
<%--						$("#nick").text(oldnick);--%>
<%--					});--%>
				});
				
				function updateAccountNickName() {
					var nick=$("#nick").text();
					oldnick=nick;
					$("#accountShortName").val(nick);
				}
				
				function nicknamesuccess(){
					var cls="." + $("#nick").attr("data-nick");	
					var nick=$("#nick").text();
					parent.$(cls).text(nick);
				 	$("#save_edit").parent("div").find("input")
										.addClass("hidden");
								$("#save_edit").parent("div").find("span")
										.removeAttr('contenteditable',
												'true');
								$(".edit_row").show();
				}
	</g:javascript>
</body>
</html>
