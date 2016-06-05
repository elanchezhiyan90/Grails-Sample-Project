<%@page import="com.vayana.ib.bm.core.api.model.user.IBUserReminder"%>
<section>                
        <form>
       		 <!-- Sticky header starts here ----------->
                <div class="start-stick_top"></div>
                   <div class="grid_stickyhead_top">
                  <table border="0" cellpadding="0" cellspacing="0" class="grid_theader">
                    <thead>
                      <tr>
                        <th width="15%">Date</th>
                        <th width="20%">Description</th>
                        <th width="25%">Beneficiary/Biller Name</th>
                        <th width="15%">Amount</th>                      
                        <th width="15%">Remove</th>
                      </tr>
                    </thead>
                 </table>
       	  </div>
          <!-- Sticky header ends here ----------->  
          <!-- Add Transaction Type -->
 	<table width="100%" border="0" class="grid" id="">
    <tbody>
      <g:if test="${reminderResponseModel}">
      <g:each var="reminder" in="${reminderResponseModel}">  
      <tr>
        <td width="15%"><g:formatDate format="dd-MMM-yyyy" date="${reminder?.reminderDateTime}"/></td>
        <td width="20%">${reminder?.description}</td>
        <td width="25%">        
       <g:if test="${reminder instanceof IBUserReminder}">
        ${reminder?.payeeInstruction?.shortName}
        </g:if>
        <g:else>
        -
        </g:else>
        </td>
        <td width="15%">
        <g:if test="${reminder?.currency}">
        <div class="amt">${reminder?.currency?.code}<vayana:formatAmount amount="${reminder.amount}" currency="${reminder?.currency?.code}" /></div>
        </g:if>
        <g:else>
        -
        </g:else>
        </td>
        <td width="15%"><%--
        <a class="ceebox" rel="width:400px;height:100;" title="Remove Reminder" href="${createLink(controller: 'reminder', action: 'removereminder')}?reminderId=${reminder?.id}">Remove</a>--%>
        <a href="#" class="remove" id="removereminder${reminder?.id}" onclick="removeReminder('${reminder?.id}');">-</a></td>
       </tr>
      </g:each>
      </g:if>
      <g:else>
       <tr>
     <td>
      
      </td>
      </tr>
    
     <tr>
     <td align="center">
      <b>No Reminders</b>
      </td>
      </tr>
      </g:else>
     </tbody>
  </table>
  </form>	
<br />
<%--<g:if test="${reminderResponseModel}">
<div class="buttons">
	<input type="button" id="save" value="Save" name="save" onClick="$.fn.ceebox.closebox();" >
	<input type="button" id="close" value="Close" name="close" onClick="$.fn.ceebox.closebox();"  class="btn_next">
</div>
</g:if>
--%></section>
