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
<title>${message(code:'layouts.loginlayout.title')}</title>
<!-- Mobile viewport optimized -->
<meta name="viewport" content="width=device-width">
<!-- Style sheet -->
<g:set var="themeName" value="${pageProperty(name:'page.themeName')}" />
<link rel="stylesheet" type="text/css"  href="${resource(dir: 'themes/' + 'pmcb' + '_theme/css/jquery-ui', file: 'jquery-ui-1.9.1.custom.css')}" />
<link rel="stylesheet" type="text/css"  class="cssfx" href="${resource(dir: 'themes/' + 'pmcb' + '_theme/css', file: 'app.css')}" />
<link rel="stylesheet" href="${resource(dir: 'css', file: 'common.css')}" type="text/css">
		
<r:require modules="appLayoutHead" />
<g:layoutHead />
<r:layoutResources />
<g:javascript src="libs/modernizr-2.6.3.min.js"/>
<%--<script type="text/javascript">window.history.forward();function noBack(){window.history.forward();}</script>--%>
</head>
<%--this is blocking the drag select	onselectstart="return false"--%>
<body oncontextmenu="return false"  onkeydown="if ((arguments[0] || window.event).ctrlKey) return false">
		<vayana:errors/>
		<g:layoutBody />
		<div id="spinner" style="display:none; position:fixed; top:50%; left:50%; z-index:999999; background:#fff;margin-top:-50px; margin-left:-50px">
			<g:img dir="themes/pmcb_theme/img/common" file="loading1.gif" width="30" height="30"/>
		</div>
		<r:require modules="commonBody" />
		<r:layoutResources />		
</body>
</html>