<html>
<head>
    <title>Facebook Friends</title>
    <meta name='layout' content='facebookLayout'/>
</head>

<body>

	<h3>Your Facebook Friends</h3>
<div class="facebook-cont"><!--Facebook Cont Starts Here-->
<ul>
<g:each in="${friends}" var="friend">
<li>
<label>
<vayana:postableradio action="friendDetail"
					controller="socialConnectFacebook"
					target="canvas" urlParams="[friendId:friend?.id]"
					linkTitle="${g.message(code:'home.templates.sendmoney.friendsandfamily.viewdetails.tooltip.text')}" id="profileId"  name="profileId" class="facebook-radio"
					formName="beneficairyForm">
				</vayana:postableradio>
<%--<g:radio class="facebook-radio" name="profileId" value="${friend.id}" id="profileId" onClick="postValue(${friend.id})"/>--%>
<span class="photo"><img src="http://graph.facebook.com/${friend.id}/picture" align="middle"/></span>
<span class="name">${friend.name} ${friend.birthday}</span>
</label>
</li>
</g:each>
</ul>
</div>	
<script>
$("#profileId").on("click",function(){
	if($("#profileId:checked"))
		{
		$(this).parents("li").addClass("current").siblings("li").removeClass("current");
		$.fn.ceebox.closebox();	
		}
});
</script>
</body>
</html>
