<!doctype html>
<html>
<head>
	<meta name="layout" content="applayout" />
	<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
<div class="body-scroll">
<h2> Request Status</h2>  
<section>
<form>
  <div id="filter">

   <g:render template="templates/search"></g:render> 
</div> 
<br/>
<div id ="status">
<g:render template="templates/serviceSRRequestStatus"></g:render>

</div>
   
    </form>
	
</section>
</div>
</body>
   <g:javascript>
		/********* Ceebox for grid catergory ***************/
		$(".cat a").attr('rel',"width:400px; height:380px");
		$(".ceebox").ceebox();
		
	   
	</g:javascript>   
</html>