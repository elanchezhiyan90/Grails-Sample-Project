  <%@ page import="com.vayana.ib.bm.core.api.model.enums.PayeeTypeEnum"%>
  <vayana:pager controller="payment" action="viewsihistorypage" update="mainContent"/>
  <br/>
  <br/>
  <g:form id="siviewdetailform" name="siviewdetailform">
 <!-- Sticky header starts here ----------->
                <div class="start-stick_top"></div>
                   <div class="grid_stickyhead_top">
                   
                    <table border="0" cellpadding="0" cellspacing="0" class="grid_theader" >
                       <thead>
                        <tr>
	                        <th width="3%">&nbsp;</th>	                           
                            <th width="20%">Nick Name</th><%--<g:message code="payment.templates.schedulepaymentreview.sidetails.accountnickname.label" /></th>--%>
                            <th width="20%"><g:message code="payment.templates.schedulepaymentreview.sidetails.accountnumber.label" /></th>
                            <th width="20%">Credit Account</th> 
                            <th width="15%" class="amt"><g:message code="payment.templates.schedulepaymentreview.sidetails.amount.label" /> (INR)</th>
                            <th width="15%"><g:message code="payment.templates.schedulepaymentreview.sidetails.scheduleddate.label" /></th>
                            <%--<th width="20%">IB Reference Number</th> --%>
                        <th width="7%"><g:message code="payment.templates.schedulepaymentreview.sidetails.status.label" /></th></tr>
                        </thead>
                    </table>
                   	</div>
                    <!-- Sticky header ends here ----------->
            <table cellspacing="0" cellpadding="0" border="0" class="grid" id="mainContent">
                
                        <tbody>
                        <tr>
                            <td width="3%"></td>                           
                            <td width="20%"></td>
                            <td width="20%"></td>
                            <td width="20%"></td>                        
                            <td width="15%" class="amt"></td>
                            <td width="15%"></td>   
                            <td width="7%"></td>  
                       </tr>
                        <g:if test="${!siViewAndUpdateModel?.paymentScheduleDetails?.isEmpty()}">
                        <g:each in="${siViewAndUpdateModel?.paymentScheduleDetails}" var="paymentScheduleDetails" >	                        
	                        <tr>
	                            <td><g:radio name="paySchId" id="" value="${paymentScheduleDetails?.id}" class="btn_next" required="required"/> </td>	                                
	                                              
	                            <td>${paymentScheduleDetails?.payeeInstruction?.shortName}</td>
	                            
	                            <td><vayana:formatAccount
										currency="${paymentScheduleDetails?.payerInstruction?.currency?.code}"
										accountno="${paymentScheduleDetails?.payerInstruction?.accountNumber}" /></td>
								<td>
									${(PayeeTypeEnum?.BENE.equals(paymentScheduleDetails?.payeeInstruction?.payeeType)) ? vayana.formatFFAccountNumber(beneInsIdVer:paymentScheduleDetails?.payeeInstruction?.idVersion,displayCurrency:'NO') 
										: vayana.formatBPAccountNumber(billInsIdVer:paymentScheduleDetails?.payeeInstruction?.idVersion) }</td>
								<%--<vayana:formatAccount
										currency="${paymentScheduleDetails?.payeeInstruction?.currency?.code}"
										accountno="${paymentScheduleDetails?.payeeInstruction?.accountNumber}" /></td>--%>
								 <td class="amt">
	                            <vayana:formatAmount
										currency="${paymentScheduleDetails?.paymentCurrency?.code}"
										amount="${paymentScheduleDetails?.paymentAmount}" />
<%--										 ${paymentScheduleDetails?.paymentCurrency?.code}--%>
								</td>
								<td><vayana:formatDate date="${paymentScheduleDetails?.paymentDate}"/></td>  
								<%--<td>${paymentScheduleDetails?.referenceTag}</td>
	                        --%>
	                        <td>${paymentScheduleDetails?.status?.description}</td>
	                        </tr>                         
                      </g:each>   
                      </g:if>
                     <g:else>
                      <tr>
                      	   <td></td>
                      	   <td></td>
                      	   <td></td>
                      	   <td align="center"> No Transaction Found</td>
	                      <td ></td>
                      </tr>
                      </g:else>                                                                                    
                      </tbody> 
                       <vayana:pagerModel/>   
                    </table>  
   <br /> 
 <g:if test="${!siViewAndUpdateModel?.paymentScheduleDetails?.isEmpty()}">
<div class="buttons" id="confirmDiv">
						  <g:submitToRemote value="Stop Series" id="seriesButton" before="if(checkFormValidity()) {return false;}"  url="[controller:'payment',action:'stopSIPaymentSeries']" update="siresult"  onSuccess="onSkipSuccess(data,textStatus);"/>
						  <g:submitToRemote value="Skip" class="btn_next" id="skipButton" before="if(checkFormValidity()) {return false;}"  update="siresult" url="[controller:'payment',action:'skipSIPayment']" onSuccess="onSkipSuccess(data,textStatus);"/>                         
</div>
</g:if>
</g:form>
<div id="siresult"></div>
 <g:if test="${!siViewAndUpdateModel?.paymentScheduleDetails?.isEmpty()}">
  <script>
  $(function(){
	  $(".previous")
		.button({
	   text: false,
	   icons: { primary: "ui-icon-triangle-1-w"}
	 	})
		.click(function() {
	          $(".pagenum").removeClass("form-ui-invalid")
	   })
	.next()
	.button({
	   text: false,
	   icons: { primary: "ui-icon-triangle-1-e"}
	 	}).click(function(){
	 		 $(".pagenum").removeClass("form-ui-invalid")
			}).parent()
	               .buttonset();
		
	$(".gobtn").button({
		text: false,
	   icons: { primary: "ui-icon-arrowreturnthick-1-e"}
	})
	
	 $(".pagenum").blur(function(){
		 var value=$(this).val();
		 var maxm=$(this).attr("max");
		 if(value>maxm){
		 $(this).addClass("form-ui-invalid")
		 }
	 });
		 
	pagerSuccess();
	 
});
function checkFormValidity(){

	if(!$("#siviewdetailform").checkValidity()){ 
	      return true;   
	}else{
		   return false;
	}
}
  </script>
</g:if>