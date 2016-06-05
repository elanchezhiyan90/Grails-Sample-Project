 <h3><a href="#"><g:message code="home.templates.servicerequest.creditcards.h3.text" /></a></h3>
          <ul class="bene-mnu">
          <g:if test="${actsumModel?.customerIdentifiers[0]?.creditCardAccounts?.size() >=1}">       
         
          	<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'CREDIT_CARD_ACTIVATION_DETAIL',userActionLabel:'VIEW')}" >    
          
            <li> 
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'CCACT']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'CCACT']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.activecreditcard.tooltip.text')}"><g:message code="home.templates.servicerequest.creditcards.activecreditcard.label" /></vayana:postablelink>           
           </li>  
           </vayana:fap>
            <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'BLOCK_CREDITCARD_DETAIL',userActionLabel:'VIEW')}" >   
           <li> 
             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'BLKCC']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.viewdetails.tooltip.text')}"></vayana:postableradio>
             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'BLKCC']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.blockcreditcard.tooltip.text')}"><g:message code="home.templates.servicerequest.creditcards.blockcreditcard.label" /></vayana:postablelink>           
           </li>
           </vayana:fap>
           </g:if>
           <g:else> 
    				<li class="norecord">
    
						<span>${message(code:'common.template.accounts.norecordsfound.label')}</span>
	
					</li>
			</g:else>
           </ul>
<%--           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'CREDITCARD_PIN_ISSUE_REQUEST_DETAIL',userActionLabel:'VIEW')}" >   --%>
<%--           <li> --%>
<%--             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'CCPINREQ']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.viewdetails.tooltip.text')}"></vayana:postableradio>--%>
<%--             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'CCPINREQ']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.creditcardpin.tooltip.text')}"><g:message code="home.templates.servicerequest.creditcards.creditcardpin.label" /></vayana:postablelink>           --%>
<%--           </li>--%>
<%--           </vayana:fap>--%>
<%--             <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'ADD_CREDITCARD_REQUEST_DETAIL',userActionLabel:'VIEW')}" >   --%>
<%--           <li>  --%>
<%--             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'ADCCREQ']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.viewdetails.tooltip.text')}"></vayana:postableradio>--%>
<%--             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'ADCCREQ']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.addcreditcard.tooltip.text')}"><g:message code="home.templates.servicerequest.creditcards.addcreditcard.label" /></vayana:postablelink>           --%>
<%--           </li>--%>
<%--           </vayana:fap>--%>
           
<%--           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'CREDITCARD_LIMIT_MANAGEMENT_DETAIL',userActionLabel:'VIEW')}" >   --%>
<%--           <li> --%>
<%--             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'CCLMTMNG']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.viewdetails.tooltip.text')}"></vayana:postableradio>--%>
<%--             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'CCLMTMNG']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.creditcardlimit.tooltip.text')}"><g:message code="home.templates.servicerequest.creditcards.creditcardlimit.label" /></vayana:postablelink>           --%>
<%--           </li>   --%>
<%--           </vayana:fap>--%>
<%--           <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'TRAVEL_INTIMATION_REQUEST_DETAIL',userActionLabel:'VIEW')}" >   --%>
<%--             <li> --%>
<%--             <vayana:postableradio controller="serviceRequest" action="serviceRequestStatus" urlParams="[tenantServiceCode:'TIR']"  target="canvas" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.viewdetails.tooltip.text')}"></vayana:postableradio>--%>
<%--             <vayana:postablelink controller="serviceRequest" action="serviceRequestMetaData" urlParams="[tenantServiceCode:'TIR']" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.servicerequest.creditcards.travelintimation.tooltip.text')}"><g:message code="home.templates.servicerequest.creditcards.travelintimation.label" /></vayana:postablelink>           --%>
<%--           </li>--%>
<%--           </vayana:fap>--%>
          