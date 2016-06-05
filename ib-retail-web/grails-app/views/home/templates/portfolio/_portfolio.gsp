<h3><a href="#"><g:message code="home.templates.portfolio.portfolio.h3.text" /></a></h3>
          <ul class="bene-mnu">
            <vayana:fap function="${vayana.generateFap(subModuleLabel:'PORTFOLIO_SUB_MODULE',businessFunctionLabel:'PORTFOLIO_SUMMARY')}" >
          
            <li> 
            <vayana:postableradio controller="portfolio" action="portfoliomaster"
					target="canvas"
					linkTitle="${g.message(code:'home.templates.portfolio.portfolio.viewdetails.tooltip.text')}">
				</vayana:postableradio>
             <vayana:postablelink controller="portfolio" action="portfoliomaster" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.portfolio.portfolio.myportfolio.tooltip.text')}"><g:message code="home.templates.portfolio.portfolio.myportfolio.label" /></vayana:postablelink>           
           </li>
           </vayana:fap><%--
           <vayana:fap function="${vayana.generateFap(subModuleLabel:'PORTFOLIO_SUB_MODULE',businessFunctionLabel:'NEW_GOAL_REQUEST')}" >
   
            <li> 
            
            <vayana:postableradio controller="goal" action="goalMaster"
					target="canvas"
					linkTitle="${g.message(code:'home.templates.goals.goals.viewdetails.tooltip.text')}">
				</vayana:postableradio>
             <vayana:postablelink controller="goal" action="goalMaster" target="canvas"  linkClass="lnk" linkTitle="${g.message(code:'home.templates.goals.goals.viewdetails.tooltip.text')}"><g:message code="home.templates.goals.goals.label" /></vayana:postablelink>      
          
           </li>
              </vayana:fap>     
           --%></ul>