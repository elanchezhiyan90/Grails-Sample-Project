<g:form id="getBankInfo">
        <fieldset class="ui-helper-reset">
      	<g:hiddenField name="bankType" id="bankType" value="${bankType}"/>
      	<g:hiddenField name="payType" id="payType" value="${payType}"/>
      	<g:if test="${"ALL".equals(bankType)}" > 
                              <div class="fields">	
                                <label>Bank Type</label>
	                           <g:select name="bankTypeSelect" id="bankTypeSelect" from="${['PMCB Bank','Other Bank']}" keys="${['TENANT','DOMESTIC'] }"></g:select>		             
                              </div>
                               </g:if>
 		<table width="100%" border="0" cellpadding="4" cellspacing="4" > 		
                              <tr>                              
                               <td id="id1">
                                <g:textField  name="getbankCode" id="getbankCode" placeholder="${g.message(code:'beneficiary.templates.quickPay.banksearch.bankcode.placeholder.text') }" />
                                </td>
                                <td id="id2">
                                <g:textField  name="getbankName" id="getbankName" placeholder="Bank Name" />
                                </td>
                                <td id="id3">
                                <g:textField  name="getbranchName" id="getbranchName" placeholder="Branch Name" />
                                </td>
                               
                                
                                <td>
                                <g:submitToRemote id="searchBank" value="Search" class="btn_next"  name="searchBank"
											action="searchBankCodeDetails"
											controller="beneficiary"		
											update = "updateSearchDiv" 		
											onSuccess= "showdata()"/>																					
									</td>
                                                        
                              </tr>       
            </table>
            
            
    		<br>
            <vayana:pager action="searchBankCodeDetails" controller="beneficiary" update="updateSearchDiv" paramsModel="\'&bankType=\'+getViewBankType()+\'&getbankCode=\'+getBankCode()+\'&getbankName=\'+getBankName()+\'&getbranchName=\'+getBranchName()+\'&payType=\'+getPayType()"></vayana:pager>
  			<br>
     	   <div id="updateSearchDiv">	
<%--     	   		<g:render template="/beneficiary/templates/instructions/bankSearchList"/>	                     --%>
	        </div>
	        
        </fieldset>
        <br>
        <div class="buttons">
       	 	<input type="button" value="Add" name="add" id="add" >
 			<input type="button" value="Cancel" name="cancelCode" id="cancelCode" class="cancelForm btn_next">
 		</div>
 		<br>
    </g:form>
<script>
$(function(){

$("#bankTypeSelect").change(function(){
	 var test = $("#bankTypeSelect").val();

	 $("#bankType").val(test);
	 if("TENANT" == test){
	 	$("#id1").empty().append("<input type='text' name='getbankName' id='getbankName' placeholder='Branch Code'/>").dynamicfieldupdate();
	 	$("#id2").empty().append("<input type='text'  name='getbranchName'id='getbranchName' placeholder='Branch Name' />").dynamicfieldupdate();
	 	$("#id3").empty();
	 }else{
	 	$("#id1").empty().append("<input type='text'  name='getbankCode' id='getbankCode' placeholder='Bank Code' />").dynamicfieldupdate();
	 	$("#id2").empty().append("<input type='text'  name='getbankName' id='getbankName' placeholder='Bank Name' />").dynamicfieldupdate();
	 	$("#id3").empty().append("<input type='text'  name='getbranchName' id='getbranchName' placeholder='Branch Name' />").dynamicfieldupdate();
	 
	 }
	});

$(".fields").dynamicfieldupdate();
	//$("#bankType").val(getPayeeBankType());
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
	
});
$("#add").click(function(){

if ($(".loadBankValue").is(":checked")) {
	addBankInfo();
	$("#bankdialog").dialog( "close" ); 
	} 
});
$("#cancelCode").click(function(){
	$("#bankdialog").dialog( "close" );  
});
function showdata(){
$("#updateSearchDiv").dynamicfieldupdate();

		 
	pagerSuccess();
}
function getViewBankType(){

	var val = $("#bankType").val();
	return val;
}
function getPayType(){
	var val = $("#payType").val();
	return val;
}
function getBankCode(){
	var val = $("#getbankCode").val();
	return val;
}
function getBankName(){
	var val = $("#getbankName").val();
	return val;
}
function getBranchName(){
	var val = $("#getbranchName").val();
	return val;
}


</script>