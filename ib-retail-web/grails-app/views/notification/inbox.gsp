<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"> <!--<![endif]-->

<head>
<meta charset="utf-8">
<title><g:message code="notification.inbox.title" /></title>
</head>

<body>
<form>
<section class="pd_list">
<h4><g:message code="notification.inbox.h4.text" /></h4> 

<header class="pd_hdr">
	<div class="pd_btns">
    <span><input type="checkbox" id="selectall" name="selectall"/> <g:message code="notification.inbox.selectall.label" /></span>
        <input type="button" id="msgmar" name="msgmar" value="${g.message(code:"notification.inbox.markasread.button.text") }" class="btn_next"/>
    <input type="button" id="msgdelete" name="msgdelete" value="${g.message(code:"notification.inbox.delete.button.text") }" class="btn_next"/>
     <input type="button" id="compose" name="compose" value="${g.message(code:"notification.inbox.compose.button.text") }"/>
    </div>
    <div class="pager">
       <input type="number"  step="any" name="pagenum" id="pagenum"  min="1" value="${g.message(code:"notification.inbox.page.label",args:['1']) }"/>
        <span class="of"><g:message code="notification.inbox.pagination.label" args="${['75'] }"/></span>
         <span class="handler dis"><g:message code="notification.inbox.previous.label" /></span>
        <span class="handler"><g:message code="notification.inbox.next.label" /></span>
    </div>
</header>

<ul class="msgs">
<li class="unrd"><span class="chk"><input type="checkbox" name="" id=""  value=""/></span><g:remoteLink controller= "notification"  action ="message"><span class="frm">Customer care</span><span class="sub">Sample subject template goes here...</span><span class="dtl"> Sample message template goes here Sample message template goes here ...</span><span class="dtd">Sep8&nbsp;10:23 am</span><span class="atchmnt">attachment</span></g:remoteLink></li>
<li class="unrd"><span class="chk"><input type="checkbox" name="" id=""  value=""/></span><a href="apps/notification/message.html"><span class="frm">Customer care</span><span class="sub">Sample subject template goes here...</span><span class="dtl">Sample message template goes here Sample message template goes here ...</span><span class="dtd">Sep8&nbsp;10:23 am</span></a></li>
<li ><span class="chk"><input type="checkbox" name="" id=""  value=""/></span><a href="apps/notification/message.html"><span class="frm">Customer care</span><span class="sub">Sample subject template goes here...</span><span class="dtl">Sample message template goes here Sample message template goes here ...</span><span class="dtd">Sep8&nbsp;10:23 am</span><span class="atchmnt">attachment</span></a></li>
<li ><span class="chk"><input type="checkbox" name="" id=""  value=""/></span><a href="apps/notification/message.html"><span class="frm">Customer care</span><span class="sub">Sample subject template goes here...</span><span class="dtl">Sample message template goes here Sample message template goes here ...</span><span class="dtd">Sep8&nbsp;10:23 am</span><span class="atchmnt">attachment</span></a></li>
<li ><span class="chk"><input type="checkbox" name="" id=""  value=""/></span><a href="apps/notification/message.html"><span class="frm">Customer care</span><span class="sub">Sample subject template goes here...</span><span class="dtl">Sample message template goes here Sample message template goes here ...</span><span class="dtd">Sep8&nbsp;10:23 am</span></a></li>
<li class="unrd"><span class="chk"><input type="checkbox" name="" id=""  value=""/></span><a href="apps/notification/message.html"><span class="frm">Customer care</span><span class="sub">Sample subject template goes here...</span><span class="dtl">Sample message template goes here Sample message template goes here ...</span><span class="dtd">Sep8&nbsp;10:23 am</span></a></li>
<li ><span class="chk"><input type="checkbox" name="" id=""  value=""/></span><a href="apps/notification/message.html"><span class="frm">Customer care</span><span class="sub">Sample subject template goes here...</span><span class="dtl">Sample message template goes here Sample message template goes here ...</span><span class="dtd">Sep8&nbsp;10:23 am</span></a></li>
<li ><span class="chk"><input type="checkbox" name="" id=""  value=""/></span><a href="apps/notification/message.html"><span class="frm">Customer care</span><span class="sub">Sample subject template goes here...</span><span class="dtl">Sample message template goes here Sample message template goes here ...</span><span class="dtd">Sep8&nbsp;10:23 am</span></a></li>
<li ><span class="chk"><input type="checkbox" name="" id=""  value=""/></span><a href="apps/notification/message.html"><span class="frm">Customer care</span><span class="sub">Sample subject template goes here...</span><span class="dtl">Sample message template goes here Sample message template goes here ...</span><span class="dtd">Sep8&nbsp;10:23 am</span></a></li>
</ul>
</section>
</form>
</body>
</html>
