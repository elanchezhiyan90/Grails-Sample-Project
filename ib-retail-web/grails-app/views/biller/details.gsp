<head>
<meta name="layout" content="applayout"/>
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
<div class="body-scroll">
<section>
	<g:hiddenField name="hbillerInstructionId" id="hbillerInstructionId" />
	<g:hiddenField name="hstatus" id="hstatus" />
	<g:hiddenField name="hbillerId" id="hbillerId" />
	<g:hiddenField name="hbillerstatus" id="hbillerstatus" />
	<h2>${message(code:'biller.templates.details.billerinstructions.h2.text') } ${BillerDetailsModel?.biller?.description}	
	<vayana:fap function="${vayana.generateFap(businessFunctionLabel:'BILLER_INSTRUCTION',userActionLabel:'ADD')}"> 	 
	<a href="${createLink(controller:'biller' , 
						action:'addInstruction' , params:[billerId:BillerDetailsModel?.biller?.id])}"
					class="add ceebox" title="${message(code:'biller.templates.details.billerinstructions.addinstruction.tooltip.text') }">${message(code:'biller.templates.details.billerinstructions.add.text') }</a>
	</vayana:fap>
	</h2>
	<vayana:messages/><br/>
    <g:render template="/biller/templates/details/billerInstructions" />
</section>        
</div>
</body>
<g:javascript>
$(document).ready(function(){

$(".ceebox").ceebox();	

if(!Modernizr.touch){
		$("#cee_ajax").find("select" ).combobox();
		$("#cee_ajax").find("form").updatePolyfill();//update polyfill on after ajax load.
	}

//$('div[class^="divStatus_"]').buttonset();
	
	
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

function setValues(Id,value){
	$("#hbillerInstructionId").val(Id);
	$("#hstatus").val(value);
}
function getInstructionId(){		
	return $("#hbillerInstructionId").val();
}
function getInstructionStatus(){		
	return $("#hstatus").val();
}
function setBillerValues(Id,value){
	$("#hbillerId").val(Id);
	$("#hbillerstatus").val(value);
}
function getBillerId(){		
	return $("#hbillerId").val();
}
function getBillerStatus(){		
	return $("#hbillerstatus").val();
}

function getConfirm(billerId,billerServiceId,billerInstructionId,status){
    $("#dialog-confirm" ).dialog({
      resizable: false,
      height:140,
      modal: true,
      buttons: {
      "Ok": function() {         
          <g:remoteFunction controller="Biller" action="updateBillerInstructionStatus" params="\'billerId=\'+billerId+\'&billerServiceId=\'+billerServiceId+\'&status=\'+status+\'&billerInstructionId=\'+billerInstructionId" update="billerAccountDetails" onSuccess="updateIcon(data,textStatus)"/>
          $( this ).dialog( "close" );
          return true;
        },
        Cancel: function() {
          $( this ).dialog( "close" );
          return false;
        }                
      }
    });
    return false;
  }
  
  function getConfirmAct(billerId,billerServiceId,billerInstructionId,status){
    $("#dialog-confirm-act" ).dialog({
      resizable: false,
      height:140,
      modal: true,
      buttons: {
      "Ok": function() {         
          <g:remoteFunction controller="Biller" action="updateBillerInstructionStatus" params="\'billerId=\'+billerId+\'&billerServiceId=\'+billerServiceId+\'&status=\'+status+\'&billerInstructionId=\'+billerInstructionId" update="billerAccountDetails" onSuccess="updateIcon(data,textStatus)"/>
          $( this ).dialog( "close" );
          return true;
        },
        Cancel: function() {
          $( this ).dialog( "close" );
          return false;
        }                
      }
    });
    return false;
  }
  
function checkFormValidity()
{
	if(!$('form').checkValidity())
	{
		return true;
	}else
	{
		return false;
	}
}	
function catchButtonEvent(buttonName)
{	
	$("#buttonEvent").val(buttonName);
}
</g:javascript>	