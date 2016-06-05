<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
</head>
<body>
	<div class="body-scroll">
		<section class="col-480">
			<h2>
				<g:message code="beneficiary.addbeneficiary.h2.text" />
			</h2>
			<vayana:messages />
			
			<g:if test="${beneMaxExceeded =='true'}">
			<h2>
			<g:message code="beneficiary.addbeneficiary.limitexceed.text" />
			</h2>
			</g:if>
			<g:else>      
			<g:form name="beneficairyForm">
				<div id="dialog-confirm" title="${g.message(code:'beneficiary.updatebeneficiary.beneficiary.tooltip.text')}" style="display: none;">
 			 <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span><g:message code="beneficiary.updatebeneficiary.areyousure.label"/></p>
		</div>
				<g:hiddenField name="hidBeneficiaryIdversion" value="" />
				<div id="tabs">
					<ul>
						<li><a
							href="${createLink(controller:'beneficiary' ,action:'beneficiaryDetails')}"><g:message
									code="beneficiary.addbeneficiary.benedetails.label" /></a></li>
						<g:if
							test="${grailsApplication.config.beneficiary.limit.display == true}">
							<li><a
								href="${createLink(controller:'beneficiary' ,action:'beneficiaryLimits')}"><g:message
										code="beneficiary.addbeneficiary.benelimits.label" /></a></li>
						</g:if>
						<li><a
							href="${createLink(controller:'beneficiary' ,action:'beneficiaryAccounts')}"><g:message
									code="beneficiary.addbeneficiary.beneaccountdetails.label" /></a></li>
					</ul>
				</div>
			</g:form>
		</g:else>
			<br /> <br /> <br /> <br />
		</section>

		<!-- Timeline & form panel Ends Here -->
		<aside class="related-nav">
			<g:set var="friendsFamily"
				value="${friendsFamilyModel?.beneficiaries}" />
			<g:if test="${friendsFamily?.size() > 0}">
				<br />
				<br />
				<br />
				<h2>Disabled Beneficiaries</h2>
				<br />
				<nav class="rht_menu">
					<ul>
						<g:each in="${friendsFamily}">
							<ul>
								<li><a
									href="${createLink(controller: 'beneficiary', action: 'getBeneficiaryDetails')}?beneficiaryId=${it?.idVersion}">
										${it?.shortName}
								</a></li>
							</ul>
						</g:each>
					</ul>
				</nav>
			</g:if>
		</aside>
		<!-- End of Right column -->

	</div>

<g:javascript>
$(document).ready(function(){

// Function for after popup loading via Ajax
$(document).ajaxComplete(function() {
		$("#cee_ajax").dynamicfieldupdate();
});

	
	
$(".grid td a").click(function(event){
	event.preventDefault();
 });

$( "#tabs" ).tabs({disabled: [1]},{selected:0} );

$( "#tabs" ).tabs({
         beforeLoad: function( event, ui ) {
             ui.ajaxSettings.type = 'POST';
            
        }
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
	// $(window).scroll(sticky_relocate_top);
	 //sticky_relocate_top();

	
	
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
 	 	 
 	  
  function getInstructionTemplate(){
  	return $("#transactionSubTypeId option:selected").text();	
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
          <g:remoteFunction controller="beneficiary" 
          action="updateBeneInstructionStatus" 
          params="\'beneInstructionId=\'+beneInstructionIdVersion+\'&status=\'+status+\'&beneficiaryId=\'+beneId+\'&paymentmode=\'+paymentmode" 
          update="beneficiaryAccountDetails" onSuccess="updateIcon(data,textStatus)"/>
          $( this ).dialog( "close" );
          return true;
        }        
      }
    });
    return false;
  } 

  function catchButtonEvent(buttonName)
	{	
		$("#buttonEvent").val(buttonName);
	}	 
  
</g:javascript>

</body>