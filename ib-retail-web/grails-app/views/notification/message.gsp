<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"> <!--<![endif]-->

<head>
<meta charset="utf-8">
<title><g:message code="notification.message.title" /></title>
</head>

<body>
<form>
<div class="pd_list">
<h4><g:message code="notification.message.h4.text" /></h4> 

<header class="pd_hdr">
	<div class="pd_btns">
     <input type="button" id="bti" name="bti" value="${g.message(code:"notification.message.backtoinbox.button.text") }" class="btn_next"/>
     <input type="button" id="msgdelete" name="msgdelete" value="${g.message(code:"notification.message.delete.button.text") }" class="btn_next"/>
     <input type="button" id="compose" name="compose" value="${g.message(code:"notification.message.compose.button.text") }" class="btn_next"/>
    </div>
</header>

<section class="pd_msgread">
	<header class="hdr_group">
        <h5>Sample subject template goes here..</h5>
        <div class="hdr"><g:message code="notification.message.from.label" /> 
            <span class="frm">Customer care</span>
            <div><span class="dtd">Sep 8 2012, 10:23 am</span><span class="act"><input type="button" value="${g.message(code:"notification.message.reply.button.text") }" id="msgreply" name="msgreply"/></span></div> 
        </div>
    </header>
    <article>
    	<p>Dear customer,</p>
        <p> Sample message template goes here Sample message template goes here ...</p>
        <br/>
        <br/>
        <br/>
        <p>Regards,</p>
        <p>Relationship Manager</p>
    </article>
    <div class="msg_atchmnt">
    	<span class="atchmnt">attachment</span><span class="fle">Something.pdf</span><a href="#"><g:message code="notification.message.download.text" /></a>
    </div>
</section>
</form>
</body>
</html>
