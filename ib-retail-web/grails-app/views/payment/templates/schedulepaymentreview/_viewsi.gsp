
 
  
  
  <g:form name="siReview">
  <g:hiddenField name="beneId" value="${params.beneId}"/> 
 <section>
   
<div id="siinfo">
	<ul>
<%--	<li><a href="#siInfoContainer">Pending<span>5</span></a></li>--%>
	<g:if test="${"SI".equals(params.viewType)}">
		<li><g:link  action="viewsihistory" controller="payment" params="[beneId:"${params.beneId}",beneInsId:"${params.beneInsId}",viewValue:"${params.viewValue}"]">Pending</g:link></li>
		<li><g:link  action="viewskippedsi" controller="payment"  >Skipped</g:link></li>
	</g:if>
	<g:else>
		<li><g:link  action="viewexecutedpayment" controller="payment"  params="[beneId:"${params.beneId}",beneInsId:"${params.beneInsId}",viewValue:"${params.viewValue}"]">Executed</g:link></li>
		<li><g:link  action="viewrejectedpayment" controller="payment"  >Rejected</g:link></li>
	</g:else>	
	</ul>
	
</div><!-- TABS SECTION ENDS HERE -->
  </section>  
</g:form>
 <script>
  $(function(){
	 $( "#siinfo" ).tabs({
		 beforeActivate: function( event, ui ) {
			 ui.oldPanel.empty();
		 },		  
		   show: function(event, ui) {reinitialiseScrollPane();},
		   fx: { height: 'toggle', opacity: 'toggle'}
		});
});

</script>