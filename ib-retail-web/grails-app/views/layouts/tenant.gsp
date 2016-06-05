<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Retail Banking"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
		<g:javascript library="jquery"/>
		<g:layoutHead/>
        <r:layoutResources />
        <%--<script type="text/javascript">window.history.forward();function noBack(){window.history.forward();}</script>--%>
	</head>
<%--this is blocking the drag select	onselectstart="return false"--%>
	<body oncontextmenu="return false"   onkeydown="if ((arguments[0] || window.event).ctrlKey) return false">
		<div id="grailsLogo" role="banner">
			<a href="#"><img src="${resource(dir: 'themes/pmcb_theme/img/branding', file: 'logo.png')}" alt="Solution Net"/></a>
		</div>
		<g:layoutBody/>
		<div class="footer" role="contentinfo"></div>
		<div id="spinner" style="display:none; position:fixed; top:50%; left:50%; z-index:999999; background:#fff;margin-top:-50px; margin-left:-50px">
		    <g:img dir="themes/pmcb_theme/img/common" file="loader.gif"/>
		</div>
		<g:javascript library="application"/>
		<r:layoutResources />
	</body>
</html>