<g:each var="task" in="${pastTaskList}">	
	<g:if test="${task.dtype.equals("FT") || task.dtype.equals("CANCEL_SI") || task.dtype.equals("SI")}">     
		<li class="has-dtl">
			<div class="dater">
				<span class="dd"><g:formatDate format="dd" date="${task.eventDate}" /></span> 
				<span class="mm"><g:formatDate format="MMM" date="${task.eventDate}" /></span> 
				<span class="yy"><g:formatDate format="yyyy" date="${task.eventDate}" /></span>
			</div> 
			<a href="#" data-params="${task.targetUrlParam}" data-queryparam="${task.id}" id="${task.id}">
				<div class="d_msg">
					<p class="type">${task.taskHeader}<br></p>
					<p>${task.taskDescription}</p>
				</div>
			</a>
			<div class="del"><a href="#" title="${message(code:'dateline.task.remove.icon.title')}" data-queryparam="${task.id}"></a></div>
			<div class="amt">
				<span class="cur">${task?.currency?.code}</span>
				<vayana:formatAmount amount="${task.amount}" currency="${task?.currency?.code}" />
			</div>
			<div class="d_msg_rht">				
			</div>
			<div class="view-dtl" id="view-dtl1"></div>
		</li>
	</g:if>
	
	<g:elseif test="${task.dtype.equals("REM_FT") || task.dtype.equals("REM_BP") || task.dtype.equals("SME")}">       
			  <li class="ft">
                	<div class="dater">
                    	<span class="dd"><g:formatDate format="dd" date="${task.eventDate}"/></span>
                    	<span class="mm"><g:formatDate format="MMM" date="${task.eventDate}"/></span>
                    	<span class="yy"><g:formatDate format="yyyy" date="${task.eventDate}"/></span>
                    </div>             
                    <g:link action="editSITransaction" controller="dateline" params="[id:"${task.id}"]">
                    	<div class="d_msg" >
                        	<p class="type">${task.taskHeader}<br></p>                        	
                        	<p>${task.taskDescription}</p>
                        </div>
                     </g:link>
                     <div class="del"><a href="#" title="${message(code:'dateline.task.remove.icon.title')}" data-queryparam="${task.id}"></a></div>
	                <g:if test="${task?.currency}">
	                	<div class="amt"><span class="cur">${task?.currency?.code}</span><vayana:formatAmount amount="${task.amount}" currency="${task?.currency?.code}" /></div>	                               
					</g:if>	
					<div class="d_msg_rht"></div>
					<div class="view-dtl" id="view-dtl1"></div>
				</li>         
    </g:elseif>
    
    <g:elseif test="${task.dtype.equals("BULK_PAY")}">       
			  <li class="ft">
                	<div class="dater">
                    	<span class="dd"><g:formatDate format="dd" date="${task.eventDate}"/></span>
                    	<span class="mm"><g:formatDate format="MMM" date="${task.eventDate}"/></span>
                    	<span class="yy"><g:formatDate format="yyyy" date="${task.eventDate}"/></span>
                    </div>             
                    <g:link action="editSITransaction" controller="dateline" params="[id:"${task.id}"]">
                    	<div class="d_msg" >
                        	<p class="type">${task.taskHeader}<br></p>                        	
                        	<p>${task.taskDescription}</p>
                        </div>
                     </g:link>
                     <div class="del"><a href="#" title="${message(code:'dateline.task.remove.icon.title')}" data-queryparam="${task.id}"></a></div>
	                <g:if test="${task?.currency}">
	                	<div class="amt"><span class="cur">${task?.currency?.code}</span><vayana:formatAmount amount="${task.amount}" currency="${task?.currency?.code}" /></div>	                               
					</g:if>	
					<div class="d_msg_rht"></div>
					<div class="view-dtl" id="view-dtl1"></div>
				</li>         
    </g:elseif>
	
	
	<g:elseif test="${task.dtype.equals("SR") || task.dtype.equals("USERGOAL")||task.dtype.equals("APPLYLOANREQUEST")||task.dtype.equals("APPLYINVESTREQUEST")}">
				<li class="has-dtl">
    			<div class="dater">
    				<span class="dd"><g:formatDate format="dd" date="${task.eventDate}"/></span>
                    <span class="mm"><g:formatDate format="MMM" date="${task.eventDate}"/></span>
                    <span class="yy"><g:formatDate format="yyyy" date="${task.eventDate}"/></span>
				</div>
				<a href="#" data-params="${task.targetUrlParam}" data-queryparam="${task.id}" id="${task.id}" >                    
					<div class="d_msg" >
   						<p class="type">${task.taskHeader}<br></p>                        	
						<p>${task.taskDescription}</p>
      				</div>                       
  				</a>	
  				<div class="del"><a href="#" title="${message(code:'dateline.task.remove.icon.title')}" data-queryparam="${task.id}"></a></div>				                                 
				<div class="d_msg_rht"></div>						
				<div class="view-dtl" id="view-dtl1"></div> 
			</li>
		</g:elseif>
	<g:elseif test="${task.dtype.equals("GOLSREREQ")}">
		<li class="has-dtl">
    			<div class="dater">
    				<span class="dd"><g:formatDate format="dd" date="${task.eventDate}"/></span>
                    <span class="mm"><g:formatDate format="MMM" date="${task.eventDate}"/></span>
                    <span class="yy"><g:formatDate format="yyyy" date="${task.eventDate}"/></span>
				</div>
				<a href="#" data-params="${task.targetUrlParam}" data-queryparam="${task.id}" id="${task.id}" >                    
					<div class="d_msg" >
   						<p class="type">${task.taskHeader}<br></p>                        	
						<p>${task.taskDescription}</p>
      				</div>                       
  				</a>	
  				<div class="del"><a href="#" title="${message(code:'dateline.task.remove.icon.title')}" data-queryparam="${task.id}"></a></div>				                                 
				<div class="d_msg_rht">
				<g:each var="action" in="${task.datelineEventSource.eventActions}" status="index">							
								<g:if test="${index == 0}">
							    		<input type="button" id="${action.code}" value="${action.description}" class="tsk_accept">
						    	</g:if>
						    	<g:elseif test="${index == 1}">
							    		<input type="button" id="${action.code}" value="${action.description}" class="btn_next tsk_reject">						    		
						    	</g:elseif>
						    	<g:elseif test="${index == 2}">
							    		<input type="button" id="${action.code}" value="${action.description}" class="btn_next tsk_sendback">						    		
						    	</g:elseif>	
				</g:each>
				</div>						
				<div class="view-dtl" id="view-dtl1"></div> 
			</li>
		</g:elseif>
</g:each>