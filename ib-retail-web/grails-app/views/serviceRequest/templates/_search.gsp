<g:form>
<g:select name="filter"  from="${genericSRModel?.businessFunction}" value="" valueMessagePrefix="servicerequest.templates.search" ></g:select> 
          
  <vayana:submitToRemote id="filter" update="[failure:'messagesDiv',success:'status']"
					url="[controller:'serviceRequest',action:'serviceRequestFilter']"
					value="Filter"
					class="btn_next" />          
</g:form>

