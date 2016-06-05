<div class="grid_filter">
	<g:form name="searchfilterform" id="searchfilterform" >
     <div class="fields">
              <p>
                <label for="recordStatus">Select Status</label>                  
                    <vayana:lookupSelect name="recordStatus" id="recordStatus" value="ACTIVE" optionKey="code" domain="base" type="WF_ACTIVITY_STATUS" onChange="showSearchFields(this);"/>
             </p>
      </div>      
     <span id="searchDiv">
	      <div class="fields">
	             <p>
	              <label for="searchRequest">Search By</label>
	              <select name="searchRequest" id="searchRequest"  >
	              </select>
	             </p>  
	       </div>
	       
	      <div class="fields">
	             <div id="updateSearch">
<%--	             <p>--%>
<%--	                  <label for="search">Search </label>--%>
<%--	                  <input type="search" name="search" id="search"/>--%>
<%--	              </p>--%>
	            </div>
	      </div>
      </span>
      <div class="fields">
              <p>  
                    <vayana:submitToRemote
                    			name="filter" 
                    			id="filter" 
                    			value="Filter"
                    			before="if (checkFilterValidity()) {return false;}"
                    			controller="${controller}"
                    			action="${action}"
                    			update="${update}"
                    			onSuccess="${onSuccess}"                 			
                                ></vayana:submitToRemote>
              </p> 
      </div>
<%--      <div class="fields">--%>
<%--      		<p>--%>
<%--      			<input type="button" name="clearFilter" id="clearFilter" value="Clear Filter" class="btn_next"/>--%>
<%--      		</p>--%>
<%--      </div>--%>
   </g:form>
</div>
<script>
$(function () 
		{	
			$("#searchRequest").change(function(){
					var searchReq =  $("#searchRequest").val();
					if(searchReq != "" )
						{
							$("#updateSearch").html("<p><label for='search'>Search </label><input type='search' name='search' id='search' required='required' data-errormessage='Please enter the search key'/></p>").dynamicfieldupdate();
						}
					else{
<%--							$("#updateSearch").html("<p><label for='search'>Search </label><input type='search' name='search' id='search'/></p>").dynamicfieldupdate();--%>
								$("#updateSearch").empty();
						}
				});
		});
function checkFilterValidity()
{	
	if(!$("#searchfilterform").checkValidity())
	{
	 	return true;
	}else
	{
	 	return false;
	}
}

function showSearchFields(obj){
	var selectedRecordstatus	=	obj.value; //$("#searchStatus option:selected").text();
	//alert(selectedRecordstatus);	
	if(selectedRecordstatus == 'ACTIVE'){
		$("#searchDiv").show();
	}else{
		$("#searchDiv").hide();
	}
}
</script>