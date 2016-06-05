<h3 id="${update}h3" data-dflag="${dirtyFlag}" onclick="${remoteFunction(controller:controller , action:action, params:'\'dirtyFlag=\'+getDirtyFlag('+update+'h3)',
   before:'if (childPresent('+update+','+update+'h3)) {return false;};onMenuBefore('+update+'h3);if(clickBefore()){return false;};' ,after:'clickAfter();', onSuccess:'onMenuSuccess(' + update+'h3,data);clickSuccess();', onFailure:'onMenuFailure('+ update+ 'h3);clickFailure();')}">
	<a href="#" id="h3title">${title}</a>
	<g:if test="${displayPlusSign}">
		<vayana:postablelink id="${update}PlusLink" action="${plusSignAction}" controller="${plusSignController}"
			urlParams="${plusSignUrlParams}" target="canvas" formName="frmMainMenu" linkClass="add" linkTitle="${message(code:'taglib.menuitem.tooltip.text')}">
					+				
	   </vayana:postablelink>
	</g:if> 
</h3>
<g:if test="${ulClass}">
	<ul class="${ulClass}" id="${update}">
</g:if>
<g:else>
	<ul id="${update}">
</g:else>
	<%--
		Ajax Content loaded here
	--%>
</ul>
<script>
var click=0;

function clickBefore(){
	if(click == 0){
		console.log("Click Before success:::"+click)
		return false;
	}else{
		console.log("Click Before failed:::"+click)
		return true;
	}
}
function clickAfter(){
	click = click+1;
	console.log("Click After:::"+click)
}
function clickSuccess(){
	click=0;
	console.log("Click Success:::"+click)
}
function clickFailure(){
	click=0;
	console.log("Click Failure:::"+click)
}
	function getDirtyFlag(id)
	{
		return $(id).attr("data-dflag");
	}
</script>
<%--
<g:remoteLink controller="${controller}" action="${action}" update="${update}"  before="if (childPresent(${update})) {return false;};onMenuBefore(${update}h3)" onSuccess="onMenuSuccess(data,textStatus)" onFailure="onMenuFailure()">${title}</g:remoteLink>
--%>