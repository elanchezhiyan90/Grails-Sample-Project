 <h3><a href="#"><g:message code="home.templates.servicerequest.accounts.h3.text"/></a></h3>
          <ul class="bene-mnu">
          
          <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'CHEQUEBOOK_REQUEST',userActionLabel:'ADD')}" > 
          <li> 
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'CHQBREQ']" target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'CHQBREQ']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.chequebookrequest.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.chequebookrequest.label" /></vayana:postablelink>           
           </li>
           </vayana:fap> 
           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'CHEQUE_STATUS_DETAIL',userActionLabel:'VIEW')}" > 
           <li> 
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'CHQSTS']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'CHQSTS']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.chequestatus.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.chequestatus.label" /></vayana:postablelink>           
           </li>
           </vayana:fap><%--
           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'MANAGE_CHEQUE_DETAIL',userActionLabel:'VIEW')}" > 
           <li> 
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'MNGCHQ']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'MNGCHQ']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.manegercheques.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.manegercheques.label" /></vayana:postablelink>           
           </li>
           </vayana:fap>--%>
           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'STATEMENT_REQUEST_DETAIL',userActionLabel:'VIEW')}" >  
             <li> 
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'STATREQ']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'STATREQ']" target="canvas"   linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.statementrequest.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.statementrequest.label" /></vayana:postablelink>           
           </li>
           </vayana:fap>
           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'STOP_CHEQUE_REQUEST_DETAIL',userActionLabel:'VIEW')}" >  
            <li> 
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'STPCHQ']" target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'STPCHQ']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.stopcheque.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.stopcheque.label" /></vayana:postablelink>           
           </li>
           </vayana:fap>
           <%-- <li> 
             <vayana:postableradio controller="serviceRequest" action="prepaidcard"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="prepaidcard" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.prepaidcard.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.prepaidcard.label" /></vayana:postablelink>           
           </li>--%>
<%--           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'ADDRESS_CHANGE_REQUEST_DETAIL',userActionLabel:'VIEW')}" > --%>
<%--            <li> --%>
<%--             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'ACR']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>--%>
<%--             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'ACR']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.addresschange.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.addresschange.label" /></vayana:postablelink>           --%>
<%--           </li>--%>
<%--           </vayana:fap>
           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'DEBIT_CARD_REQUEST_DETAIL',userActionLabel:'VIEW')}" >              
           <li>     
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'DCREQ']" target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'DCREQ']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.debitcardrequest.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.debitcardrequest.label" /></vayana:postablelink>           
           </li>
           </vayana:fap>
           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'DEBITCARD_PIN_REQUEST_DETAIL',userActionLabel:'VIEW')}" >
            <li>
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'DCPINREQ']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'DCPINREQ']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.debitcardpinrequest.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.debitcardpinrequest.label" /></vayana:postablelink>           
           </li>
           </vayana:fap>
           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'DEBITCARD_ACTIVATION_DETAIL',userActionLabel:'VIEW')}" >
            <li> 
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'DCACT']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'DCACT']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.debitcardactivation.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.debitcardactivation.label" /></vayana:postablelink>           
           </li>
           </vayana:fap>
           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'BLOCK_DEBIT_CARD_DETAIL',userActionLabel:'VIEW')}" >
            <li> 
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'BLKDC']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'BLKDC']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.blockdebitcard.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.blockdebitcard.label" /></vayana:postablelink>           
           </li>
           </vayana:fap> --%>
<%--            <li> --%>
<%--             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'ADDCREQ']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>--%>
<%--             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'ADDCREQ']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.addondebitcard.tooltip.text')}"><g:message code="home.templates.servicerequest.accounts.addondebitcard.label" /></vayana:postablelink>           --%>
<%--           </li>--%>
<%--           <li> --%>
<%--             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'OTRDTL']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.accounts.viewdetails.tooltip.text')}"></vayana:postableradio>--%>
<%--             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'OTR']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.transaction.offlinetransaction.tooltip.text')}"><g:message code="home.templates.servicerequest.transaction.offlinetransaction.label" /></vayana:postablelink>           --%>
<%--           </li>   --%>
 
          </ul>