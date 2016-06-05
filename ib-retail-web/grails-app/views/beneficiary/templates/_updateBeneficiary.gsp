<section>
           
        <g:form name="beneficairyStatusForm" params="[beneficiaryTypeId:params.beneficiaryTypeId]" >      
       	<h2>${beneficiary?.shortName}
       	<g:hiddenField name="beneficiaryId" id="beneficiaryId" value="${beneficiary?.idVersion}"/>
       	<g:hiddenField name="securityValidation" value="${params.securityValidation}" />
       	<g:hiddenField name="eventName" value="${params.eventName}" />
        <g:if test ="${beneficiary?.id}">                             	        
				<g:if test="${beneficiary.getStatus().code.toString().equals("ACT")}">
					<%--<vayana:submitToRemote controller="beneficiary" name="Disable" id="disable" action="disableBeneficiary" value="${message(code:'beneficary.disable.button')}" onSuccess="onStatusUpdateSuccess(data,textStatus)" class="btn_next"></vayana:submitToRemote>
					--%>
					<%--<a rel="width:400px;height:200;" href="${createLink(controller:'beneficiary' ,action:'confirmBeneficiaryStatusUpdate' , params:[beneficiaryId:beneficiary?.idVersion,statusCode:beneficiary?.status?.code])}" class="ceeboxDisable"><g:message code="beneficary.disable.button"/></a>
				--%></g:if>
				<g:if test="${beneficiary.getStatus().code.toString().equals("INA")}">
					<a rel="width:400px;height:200;" href="${createLink(controller:'beneficiary' ,action:'confirmBeneficiaryStatusUpdate' , params:[beneficiaryId:beneficiary?.idVersion,statusCode:beneficiary?.status?.code])}" class="ceeboxDisable"><g:message code="beneficary.enable.button"/></a>					
				</g:if>				
		</g:if>      
        </h2>
        <vayana:messages/>
       	<div id="dialog-confirm" title="${g.message(code:'beneficiary.updatebeneficiary.beneficiary.tooltip.text')}" style="display: none;">
 			 <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span><g:message code="beneficiary.updatebeneficiary.areyousure.label"/></p>
		</div>
		
       </g:form>      
       
          <g:form name="beneficairyForm" params="[beneficiaryTypeId:params.beneficiaryTypeId]" >             
           <div id="tabs">
                <ul>
                    <li><a href="${createLink(controller:'beneficiary' ,action:'beneficiaryDetails',params:[beneficiaryId:beneficiary?.idVersion])}"><g:message code="beneficiary.addbeneficiary.benedetails.label"/></a></li>
                    <g:if test="${grailsApplication.config.beneficiary.limit.display == true}" >
                	<li><a href="${createLink(controller:'beneficiary' ,action:'beneficiaryLimits',params:[beneIdValue:beneficiary?.idVersion])}"><g:message code="beneficiary.addbeneficiary.benelimits.label"/></a></li>
                	</g:if>
                	<li><a href="${createLink(controller:'beneficiary' ,action:'beneficiaryAccountsEdit',params:[beneficiaryId:beneficiary?.idVersion])}"><g:message code="beneficiary.addbeneficiary.beneaccountdetails.label"/></a></li>
                </ul>
          </div>
          </g:form>
        <br />
        <br />
        <br />
        <br />
 </section>
<g:javascript>
$(document).ready(function(){

$(".ceeboxDisable").ceebox();

if(!Modernizr.touch){
		$("#cee_ajax").find("select" ).combobox();
		$("#cee_ajax").find("form").updatePolyfill();//update polyfill on after ajax load.
}

	
$(".grid td a").click(function(event){
	event.preventDefault();
 });
 
$("#tabs").tabs({ 
		show: function(event, ui) { reinitialiseScrollPane(); }
	});	
 
$( "#tabs" ).tabs({enabled: [1,2]},{selected:[0]} ); 

$( "#tabs" ).tabs({
         beforeLoad: function( event, ui ) {
             ui.ajaxSettings.type = 'POST';
            
        }
    });


 /************** Account summary grid -Show and hide details ***************/
	$(".grid tr.has-dtl").click(function(event){
		//alert(event.target.nodeName);
		if(event.target.nodeName !=="A"){
		$(this).next("tr.view-dtl").fadeToggle(500,function(){reinitialiseScrollPane();});
		$(this).toggleClass('hlt');
		reinitialiseScrollPane();
		}
	});
/****************** sticky grid header *********************/
	 $(window).scroll(sticky_relocate_top);
	 //sticky_relocate_top();




/****************** DYNAMIC email box addition*******************/   
  	var boxcounter = 1;
    $("#addEmail").click(function () {
 	 	if(boxcounter>5){
            //alert("Only five(5) email id's allowed");
            return false;
		}   
 		var newTextBoxDiv = $(document.createElement('p'));
 		newTextBoxDiv.html('<input type="text" name="bene_email_'+ boxcounter +'" id="bene_email_'+ boxcounter +'" value="" style="clear:both;margin-left:220px; margin-bottom:5px;" /><a href="#" id="remButton" class="remove">-</a>');
 		var box=$(this).parents(".fields");
 		newTextBoxDiv.appendTo(box);
		boxcounter++;
		reinitialiseScrollPane();
 	    return false;
    });
/**************** Dynamic Telephone box adding *************************/
	var telcounter = 1; 
    $("#addTel").click(function () {
 		if(telcounter>5){
            //alert("Only five(5) Telephone numbers allowed");
            return false;
		}   
 		var newTextBoxDivTel = $(document.createElement('p'));
 		newTextBoxDivTel.html('<input type="text" name="bene_tel_'+ telcounter +'" id="bene_tel_'+ telcounter +'" value="" style="clear:both;margin-left:220px; margin-bottom:5px;"/><a href="#" id="remButtonTel" class="remove">-</a>');
  		var tel=$(this).parents(".fields");
		newTextBoxDivTel.appendTo(tel);
		telcounter++;
		reinitialiseScrollPane();
     	return false;
		
  	});	 
	
	$('#remButton').live('click', function(event) {
		event.preventDefault() 
		$(this).parents('p').remove();
		boxcounter--;
		reinitialiseScrollPane();
		});
	$('#remButtonTel').live('click', function(event) {
		event.preventDefault() 
		$(this).parents('p').remove();
		telcounter--;
		reinitialiseScrollPane();
		});
	 
  
     $("#closeWithinBank").click(function () {
        $("#panel3").remove();
		return false;
		});
	 
     $("#closeWithinBank1").click(function () {
        $("#panel4").remove();
		return false;
		});

     $("#closeExternalBank").click(function () {
        $("#panel5").remove();
		return false;
		});
	 
     $("#closeOverseasBank").click(function () {
        $("#panel6").remove();
		return false;
		});

     $("#closeCreditCard").click(function () {
		$("#panel7").remove();
		return false;
		});	 	
				if(!Modernizr.touch){
		$("#cee_ajax").find("select" ).combobox();
		$("#cee_ajax").find("form").updatePolyfill();//update polyfill on after ajax load.
}

$('.inststatus').each(function(){
				if($(this).is(":checked")){
						$(this).button({text: false,icons: {primary: "ui-icon-check"}})			
				}
				else {
					$(this).button({text: false,icons: {primary: "ui-icon-power"}})
				}
	}); 	 
 
  });
  
  function updateIcon(data,textStatus){
		var eid;	
		$('.inststatus').each(function(){
				if($(this).is(":checked")){						
						$(this).button({label: "Enabled", text: false,icons: {primary: "ui-icon-check"}})							
				}
				else {
					$(this).button({label: "Disabled",text: false,icons: {primary: "ui-icon-power"}})					
				}
	});
}

    
  function getInstructionTemplate(){
  	return $("#transactionSubTypeId option:selected").text();	
  }
  
  function getBeneId(){		
		// alert($("#beneficiaryId").val());
		 return $("#beneficiaryId").val();
	}
	
	
	function setBeneInstructionStatus(id,status){		
		$("#beneInstrctionId").val(id);
		$("#beneInstrctionStatus").val(status);
	}
	
	function getBeneInstructionId(){
		return $("#beneInstrctionId").val();
	}
	
	function getBeneInstructionStatus(){
		$("#beneInstrctionStatus").val();
	}
	
	function onStatusUpdateSuccess(t1,t2){
		$("#ulFriendsAndFamilyPay li",window.parent.document).remove();
		$("#ulFriendsAndFamilyPayh3",window.parent.document).trigger("click");
		$("#ulFriendsAndFamilyPayPlusLink",window.parent.document).trigger("click");
	}		
  
  function getConfirm(beneId,beneInstructionIdVersion,status,paymentmode){
    $("#dialog-confirm" ).dialog({
      resizable: false,
      height:140,
      modal: true,
      buttons: {
        Cancel: function() {
          $( this ).dialog( "close" );
          return false;
        },
        "Ok": function() {
          <g:remoteFunction controller="beneficiary" action="updateBeneInstructionStatus" params="\'beneInstructionId=\'+beneInstructionIdVersion+\'&status=\'+status+\'&beneficiaryId=\'+beneId+\'&paymentmode=\'+paymentmode" update="beneficiaryAccountDetails" onSuccess="updateIcon(data,textStatus)"/>
          $( this ).dialog( "close" );
          return true;
        }        
      }
    });
    return false;
  }
  function emptyErrorDiv()
{
$("#errorDiv").empty();
}
  
  
  	function checkFormValidity()
	 {
		if(!$("#beneficairyForm").checkValidity())
	 	{
		 	return true;
	 	}else
	 	{
		 	return false;
	 	}
	 }
  	
	function onPaymentSuccess(data,textStatus)
	{	
		$(".info").addClass("success").removeClass("info").text("This benificiary is activated successfully").prepend("<span></span>");
		$.fn.ceebox.closebox();
		$("#ulFriendsAndFamilyPay",window.parent.document).empty();
		//$("#ulFriendsAndFamilyPayh3",window.parent.document).trigger("click");
		setTimeout(function(){	
		$("#benedtl-"+${beneficiary?.id},window.parent.document).delay(1500).trigger("click")
		},1500);
		
	}
  function onPaymentFailure(data,textStatus)
	{	
		$(".info").addClass("error").removeClass("info").text("Your request is not processed. Kindly try after some time").prepend("<span></span>");
		$.fn.ceebox.closebox();	
	}
	
	function catchButtonEvent(buttonName)
	{	
		$("#buttonEvent").val(buttonName);
	}
	
</g:javascript>