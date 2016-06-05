<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="format-detection" content="telephone=no" />
<%--<title>:: ${params.tenantShortDescription} ${message(code:'layouts.defaultbank.title')}</title>--%>
<title>${message(code:'layouts.defaultbank.title')}</title>
<!-- Mobile viewport optimized -->
<%--The below <meta> tag is commented inorder to avoid the width problem in web browser --%>
<%--<meta name="viewport" content="width=device-width">--%>

<link rel="shortcut icon" href="${resource(dir: 'themes/' + 'pmcb' + '_theme/img/branding', file: 'favicon.ico')}" type="image/x-icon">
<!-- Style sheet -->
<link rel="stylesheet" type="text/css"  href="${resource(dir: 'themes/' + 'pmcb' + '_theme/css/jquery-ui', file: 'jquery-ui-1.9.1.custom.css')}" />
<link rel="stylesheet" type="text/css" class="cssfx" href="${resource(dir: 'themes/' + 'pmcb' + '_theme/css', file: 'style.css')}" />
<r:require modules="mainLayoutHead" />
<g:layoutHead />
<r:layoutResources />
<g:javascript src="libs/modernizr-2.6.3.min.js"/>
<noscript>
    <H1>${message(code:'layouts.loginlayout.h1.enablejavascript')}</H1>
</noscript>
<%--<script type="text/javascript">window.history.forward();function noBack(){window.history.forward();}</script>--%>
</head>
<%--this is blocking the drag select	onselectstart="return false"--%>
	<body class="nonapp" oncontextmenu="return false"  onkeydown="if ((arguments[0] || window.event).ctrlKey) return false">
	<!-- Prompt IE 6 users to install Chrome Frame. Remove this if you support IE 6. chromium.org/developers/how-tos/chrome-frame-getting-started --> 
	<!--[if lt IE 7]><p class=chromeframe>Your browser is <em>ancient!</em> <a href="http://browsehappy.com/">Upgrade to a different browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to experience this site.</p><![endif]-->
			<g:layoutBody />
			<div id="spinner" style="display:none; position:fixed; top:50%; left:50%; z-index:999999; background:#fff;margin-top:-50px; margin-left:-50px">
				<g:img dir="themes/${'pmcb'}_theme/img/common" file="loading.gif" width="30" height="30"/>
			</div>
			<r:require modules="commonBody" />
			<r:layoutResources />			
	</body>
</html>