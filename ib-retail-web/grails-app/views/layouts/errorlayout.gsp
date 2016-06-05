<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Error"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<g:layoutHead/>
        <r:layoutResources />
        <%--<script type="text/javascript">window.history.forward();function noBack(){window.history.forward();}</script>--%>
	</head>
	<%--this is blocking the drag select	onselectstart="return false"--%>
	<body oncontextmenu="return false"  onkeydown="if ((arguments[0] || window.event).ctrlKey) return false">
		<g:layoutBody/>
		<g:javascript src="libs/jquery-1.8.2.min.js" />
		<g:javascript library="application"/>
		<r:layoutResources />
	</body>
</html>