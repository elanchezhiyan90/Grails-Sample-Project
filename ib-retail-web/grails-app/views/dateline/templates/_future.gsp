<g:each var="task" in="${futureTaskList}">          
	
	
	<g:if test="${task.dtype.equals("REM_FT") || task.dtype.equals("REM_BP") || task.dtype.equals("SME")}">       
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
					
					<div class="d_msg_rht"></div>
					</g:if>	
					<div class="view-dtl" id="view-dtl1"></div>
				</li>         
    </g:if>
    
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
					
					<div class="d_msg_rht"></div>
					</g:if>	
					<div class="view-dtl" id="view-dtl1"></div>
				</li>         
    </g:elseif>
    
    <g:elseif test="${task.dtype.equals("REM_BIRTHDAY")}">
	<li class="ft">                
                	<div class="dater">
                    	<span class="dd"><g:formatDate format="dd" date="${task.eventDate}"/></span>
                    	<span class="mm"><g:formatDate format="MMM" date="${task.eventDate}"/></span>
                    	<span class="yy"><g:formatDate format="yyyy" date="${task.eventDate}"/></span>
                    </div>                   
                  	<a href="#"><div class="d_msg" >
                        	<p class="type">${task.taskHeader}<br></p>                        	
                        	<p>${task.taskDescription}</p>
                   	</div></a>                  
                	<div class="del"><a href="#" title="${message(code:'dateline.task.remove.icon.title')}" data-queryparam="${task.id}"></a></div>
	                <%--<g:each var="action" in="${task?.datelineEventSource.eventActions}">
		            <g:if test="${action.code.equals('SA')}">
		            <div class="alarm">
		           		 <g:remoteLink action="${action.targetUrl}" id="${task.id}" onSuccess="notifyStatus(data,textStatus)" class="ceebox" rel="width:300px; height:280px" >
						 </g:remoteLink>
		            </div>
		            </g:if>		            
		            		            
		            <g:elseif test="${action.code.equals('REMIT')}">
		             <div class="lnks">
		              <g:link action="${action.targetUrl}" controller="dateline" params="[id:"${task.id}"]">
                    	  ${action.description}	
                     </g:link>
		            </div>
		            </g:elseif>		            
		            		            
		            <g:else>
		            <div class="lnks">
		                	<g:remoteLink action="${action.targetUrl}" id="${task.id}" onSuccess="notifyStatus(data,textStatus)" class="ceebox">
										    ${action.description}	
							</g:remoteLink>
	                </div>
	                </g:else>
	                </g:each>					
                --%></li>
   </g:elseif>
   <g:elseif test="${task.dtype.equals("SI")||task.dtype.equals("APPLYLOANREQUEST")||task.dtype.equals("APPLYINVESTREQUEST")}">
	<li class="ft has-dtl">
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
					<div class="amt"><span class="cur">${task?.currency?.code}</span><vayana:formatAmount amount="${task?.amount}" currency="${task?.currency?.code}" /></div>	                                 
					<div class="d_msg_rht"></div>						
					<div class="view-dtl" id="view-dtl1"></div> 
	</li>
	</g:elseif> 
   
    <g:else>    
    <li class="ft">
                	<div class="dater">
                    	<span class="dd"><g:formatDate format="dd" date="${task.eventDate}"/></span>
                    	<span class="mm"><g:formatDate format="MMM" date="${task.eventDate}"/></span>
                    	<span class="yy"><g:formatDate format="yyyy" date="${task.eventDate}"/></span>
                    </div>
                    <a href="#"><div class="d_msg" >
                        	<p class="type">${task.taskHeader}<br></p>                        	
                        	<p>${task.taskDescription}</p>
                    </div></a>
                    <div class="del"><a href="#" title="${message(code:'dateline.task.remove.icon.title')}" data-queryparam="${task.id}"></a></div>                   
					<div class="d_msg_rht">
					</div>
     </li>
    </g:else>    
</g:each>