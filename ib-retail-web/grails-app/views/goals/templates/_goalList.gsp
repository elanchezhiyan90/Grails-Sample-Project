
<style>
progress {
	height: 20px;
	width: 40%;
}

#goals {
	
}

#goals td a {
	display: block;
}

#goals td label span {
	margin-left: 10%;
	color: #e75e0b;
	display: inline;
}

a.linker {
	background: none repeat scroll 0 0 #EEEEEE;
	border: 1px solid #ccc !important;
	border-radius: 12px;
	font-size: 0.9em;
	clear: right;
	color: #666666 !important;
	display: inline-block;
	margin-right: 5px;
	padding: 1px 6px;
	text-decoration: none;
	display: inline-block !important;
	margin-top: 10px;
}

.grid td span {
	clear: both;
	color: #333333;
	display: inline-block;
}
</style>

		<g:set var="Goals" value="${goalModel}" />
		<table class="grid" width="95%" id="goals">
			<tr>
				<td width="70%"></td>
				<td width="8%"></td>
				<td width="5%"></td>
				

			</tr>
			<g:each in="${Goals}" var="goal" status="index">
				<tr>
					<td><g:if
							test="${goal?.contributionAmount==goal?.targetAmount}">

							<%--<a
								href="${createLink(controller:'goal' , 
							action:'goalDetail' , params:[goalId:goal?.id])}"
								class="ceebox" title=""> --%><label> ${goal?.code}<span><span
										class="currency"> ${goal?.targetCurrency?.code}
									</span> <vayana:formatAmount currency="${goal?.targetCurrency?.code}"
											amount="${goal?.contributionAmount}"></vayana:formatAmount></span>
							</label> <progress value="${goal?.contributionAmount}"
									max="${ goal?.targetAmount}"> </progress>&nbsp;<span
								class="currency"> ${goal?.targetCurrency?.code}
							</span> <vayana:formatAmount currency="${goal?.targetCurrency?.code}"
									amount="${goal?.targetAmount}"></vayana:formatAmount>
							<%--</a>
							--%><td></td>
						</g:if> <g:else>
						<%--<a href="${createLink(controller:'goal' , 
							action:'goalRedeem' , params:[goalId:goal?.id,])}" title="Redeem"
								class="ceebox linker" rel="width:500px; height:220px">Redeem</a>
							--%><%--<a
								href="${createLink(controller:'goal' , 
							action:'goalDetail' , params:[goalId:goal?.id,targetAmount:goal?.contributionAmount])}"
								class="ceebox" title=""> --%><label> ${goal?.code}<span><span
										class="currency"> ${goal?.targetCurrency?.code}
									</span> <%--<vayana:formatAmount currency="${goal?.targetCurrency?.code}"
											amount="${goal?.contributionAmount}"></vayana:formatAmount></span>--%>
								<vayana:formatAmount currency="${goal?.targetCurrency?.code}"
											amount="${goal?.totalPaidAmt}"></vayana:formatAmount></span>
							</label> <progress value="${goal?.totalPaidAmt}"
									max="${ goal?.targetAmount}"> </progress>&nbsp;<span
								class="currency"> ${goal?.targetCurrency?.code}
							</span> <vayana:formatAmount currency="${goal?.targetCurrency?.code}"
									amount="${goal?.targetAmount}"></vayana:formatAmount>
							<%--</a>
						--%></g:else></td>
					<td>
				     <g:if
							test="${goal?.contributionAmount==goal?.targetAmount}">
					<a href="${createLink(controller:'goal' , 
							action:'goalRedeem' , params:[goalId:goal?.id])}" title="Redeem"
								class="ceebox linker" rel="width:500px; height:220px">Redeem</a>
					</g:if>
					</td>
					<td>
					<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'NEW_GOAL_REQUEST',userActionLabel:'MODIFY')}" >
					<a
						href="${createLink(controller:'goal' , 
							action:'goalEditAction' , params:[goalId:goal?.id])}"
						class="edit_row ceebox"
						title="${message(code:'biller.templates.details.billerinstructionstable.edit.tooltip.text') } ">
							${message(code:'biller.templates.details.billerinstructionstable.edit.text') }
					</a>
					</vayana:fap><a></a></td>
					<%--<td>
					
	             <vayana:fap function="${vayana.generateFap(businessFunctionLabel:'NEW_GOAL_REQUEST',userActionLabel:'DELETE')}" >
					<g:remoteLink class="remove" update="${goal?.id}"
							before="if (!deleteRecord('${goal?.id}','${goal?.code}')){return false;} "
							params="[goalId:goal?.id]">-</g:remoteLink>
											</vayana:fap></td>
				--%></tr>
			</g:each>

		</table>



	<g:javascript >



function getRecordStatus()
	{
		var sts = $("#recordStatus").val();
		return sts;
	}
	
	function deleteRecord(id){
	
	var x = "Are you sure you want to take this action";
		
	    $('<div>' + x + '</div>').dialog({
	        resizable: false,
	        height:140,
	        title:"Confirm Delete?",
	        position:['middle',200],
	        draggable: false,
	        modal:true,
	        buttons: {
	            "Yes": function() {						            	
	                $(this).dialog("close");
	             
	                <vayana:deleteFunction controller="goal" action="deleteGoal" params="\'goalId=\'+id" />                  
        
	            },
	            Cancel: function() {
	                $(this).dialog("close"); //close confirmation
	            }
	        }
	    
	});
	}
</g:javascript>
