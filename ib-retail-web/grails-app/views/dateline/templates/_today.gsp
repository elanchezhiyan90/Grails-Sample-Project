<g:if test="${todayTaskList}">
	<g:each var="task" in="${todayTaskList}">
		<g:if test="${task.dtype.equals("FT") || task.dtype.equals("CANCEL_SI") || task.dtype.equals("SI") || task.dtype.equals("SI_HEADER")}">       
			<li class="today has-dtl">
    			<div class="dater">
    				<span class="td">Today</span>
        			<span class="dt"><g:formatDate format="dd-MMM-yyyy" date="${task.eventDate}" /></span>
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
  		</g:if>
  		<g:elseif test="${task.dtype.equals("SME")}">
  			<li class="today ft payauth">
          		<div class="dater">
					<span class="td">Today</span>
               		<span class="dt"><g:formatDate format="dd-MMM-yyyy" date="${task.eventDate}" /></span>
				</div>                              
				<g:link action="editSITransaction" controller="dateline" params="[id:"${task.id}"]">
					<div class="d_msg" >
   						<p class="type">${task.taskHeader}<br></p>                        	
						<p>${task.taskDescription}</p>
						<g:if test="${null != task?.createdBy}">
							<p>Initiator <strong><vayana:getDatelineTaskInitiator taskCreatedBy="${task?.createdBy}" /></strong></p>
						</g:if>
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
  			<li class="today ft payauth">
          		<div class="dater">
					<span class="td">Today</span>
               		<span class="dt"><g:formatDate format="dd-MMM-yyyy" date="${task.eventDate}" /></span>
				</div>                              
				<g:link action="editSITransaction" controller="dateline" params="[id:"${task.id}"]">
					<div class="d_msg" >
   						<p class="type">${task.taskHeader}<br></p>                        	
						<p>${task.taskDescription}</p>
						<g:if test="${null != task?.createdBy}">
							<p>Initiator <strong><vayana:getDatelineTaskInitiator taskCreatedBy="${task?.createdBy}" /></strong></p>
						</g:if>
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

		<g:elseif test="${task.dtype.equals("REM_FT") || task.dtype.equals("REM_BP") || task.dtype.equals("CREATE_DRAFT")}">
			       
			<li class="today ft">
          		<div class="dater">
					<span class="td">Today</span>
               		<span class="dt"><g:formatDate format="dd-MMM-yyyy" date="${task.eventDate}" /></span>
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

		<g:elseif test="${task.dtype.equals("REM_BIRTHDAY")}">
				<li class="today ft">                
                	<div class="dater">
					<span class="td">Today</span>
            		<span class="dt"><g:formatDate format="dd-MMM-yyyy" date="${task.eventDate}"/></span>
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
   		<g:elseif test="${task.dtype.equals("SR") || task.dtype.equals("USERGOAL")||task.dtype.equals("INFO")||task.dtype.equals("APPLYLOANREQUEST")||task.dtype.equals("APPLYINVESTREQUEST")}">  
				<li class="today has-dtl">
    			<div class="dater">
    				<span class="td">Today</span>
        			<span class="dt"><g:formatDate format="dd-MMM-yyyy" date="${task.eventDate}"/></span>
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
		<li class="today has-dtl">
    			<div class="dater">
    				<span class="td">Today</span>
        			<span class="dt"><g:formatDate format="dd-MMM-yyyy" date="${task.eventDate}"/></span>
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
				
				<g:if test="${index == 0}">
				<div class="accept_div">
				<p>
						<label for="comments">Comments for Acceptance</label>
						<textarea rows="1" cols="30" title="Enter Comments" id="comments" name="comments" required ></textarea>
					</p>						
				        <input type="button" value="Submit" data-targetaction="${action.targetUrl}" data-taskid="${task.id}"/>
					    <input type="button" value="Cancel" class="btn_next" />
				 </div>
				</g:if>
				<g:elseif test="${index == 1}">
				<div class="reject_div">
				                     	<p>
							<label for="comments" >Comments for Rejection</label>
						<textarea rows="1" cols="30" title="Enter Comments" id="comments" name="comments" required></textarea>
					</p>						
				
				                        	<input type="button" value="Submit" data-targetaction="${action.targetUrl}" data-taskid="${task.id}"/>
				      		<input type="button" value="Cancel" class="btn_next" >
				          </div>
				</g:elseif>
				<g:elseif test="${index == 2}">
				<div class="sendback_div">
				                     	<p>
							<label for="comments" >Comments for Reverting</label>
						<textarea rows="1" cols="30" title="Enter Comments" id="comments" name="comments" required></textarea>
					</p>
				                        	<input type="button" value="Submit" data-targetaction="${action.targetUrl}" data-taskid="${task.id}"/>
				      		<input type="button" value="Cancel" class="btn_next" >
				          </div>
				</g:elseif>
				</g:each>
				</div>
				<div class="view-dtl" id="view-dtl1"></div> 
			</li>
		</g:elseif>
		
		<g:else>
			<li class="today ft">
            	<div class="dater">
					<span class="td">Today</span>
            		<span class="dt"><g:formatDate format="dd-MMM-yyyy" date="${task.eventDate}"/></span>
				</div>
				<a href="#"><div class="d_msg" >
   					<p class="type">${task.taskHeader}<br></p>                        	
					<p>${task.taskDescription}</p>
                </div></a>
                <div class="del"><a href="#" title="${message(code:'dateline.task.remove.icon.title')}" data-queryparam="${task.id}"></a></div>
                <div class="d_msg_rht"></div> 
  			</li>
 		</g:else>
	</g:each>
</g:if>
<g:else>
<li class="today">
 	<div class="dater">
    	<span class="td">Today</span>
        <span class="dt"><g:formatDate format="dd-MMM-yyyy" date="${new Date()}"/></span>
    </div>
    <p align="left">You have no tasks / events for today ! </p>
</li>
</g:else>