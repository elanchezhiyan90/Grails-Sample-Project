<%--<p>--%>
<%--Task with Id ${taskId} Authorized.--%>
<%--</p>--%>

<div class="success">
				<span></span>
				<p>
					<b>
						Payment Gateway record has been approved successfully.
					</b>
				</p>
			</div>
			
<script>
  	$(document).ready(function() { 		
  			$("#ulaccountsh3",window.parent.document).attr("data-dflag","true");
	  		$("#ulaccounts li",window.parent.document).remove();
  			$("#ulaccountsh3",window.parent.document).trigger("click");
  			
  			callFunction('${PGDATA?.AMT}','${PGDATA?.PID}','${PGDATA?.PRN}','${PGDATA?.ITC}','${PGDATA?.BID}','${PGDATA?.STATFLG}','${PGDATA?.RU}');
  
  	});
  	
  	
  	function callFunction(AMT,PID,PRN,ITC,BID,STATFLG,RU){
  		//alert(AMT +" # "+PID+" # "+PRN+" # "+ITC+" # "+BID+" # "+STATFLG+" # "+RU);  		
  		<g:remoteFunction controller="pg"
			action="pgApprovalIntimation"
			params="\'AMT=\'+AMT+\'&PID=\'+PID+\'&PRN=\'+PRN+\'&ITC=\'+ITC+\'&BID=\'+BID+\'&STATFLG=\'+STATFLG+\'&RU=\'+RU" />
  	}
  </script>