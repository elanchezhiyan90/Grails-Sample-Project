<head>
<meta name="layout" content="applayout" />
<parameter name="themeName" value="${params.themeName}" />
<style>
.carousel ul.preference
{
width:500px !important;
}
</style>
</head>
<body>
	<g:form name="changesecureaccess">
		<g:hiddenField value="${changeSecureAccessModel?.userSelectedImageBasketId}" name="userSelectedBasket" />
		<h2>
			${message(code:'userprofile.template.changesecureaccess.h2.text')}
		</h2>
		<%--<div class="mandi-note">
			<span class="mandi"></span>
			<p>${message(code:'userprofile.template.changesecureaccess.mandatoryfields.text')}</p>
		</div>--%>
		<div class="col-370">
			<div class="fields">
				<p>
					<label for="ibUserImageCategories">${message(code:'userprofile.template.changesecureaccess.selectcategory.label')}</label>
					<g:select name="ibUserImageCategories" id="ibUserImageCategories"
						from="${changeSecureAccessModel?.secureImageBaskets}"
						optionKey="id" optionValue="code"
						onchange=" ${remoteFunction( 
					 					controller :'userProfile',
										action:'secureimages', 														  						
					 					params:'\'secureCategoryId=\'+getSecureCategoryId()' ,onSuccess: 'onSecureImageSuccess(data,textStatus);'											  		
					 					)}"
						required="required"
						data-errormessage="${message(code:'userprofile.template.changesecureaccess.category.error.message') }" />
				</p>
			</div>
			<div class="secureimage">
				<div class="carousel module" id="secureImageDiv"></div>
			</div>
			<g:if test="${grailsApplication.config.secure.color.required == true}">
				<label for="ibUserSecureColorChkId">Select a seal color</label>
				<g:render template="/userProfile/templates/loginsecurecolors" />
			</g:if>
			<div class="fields">
				<p>
					<label for="ibSecretAnswer">${message(code:'userprofile.template.changesecureaccess.secretanswer.label')}</label> 
					<input type="text" step="any" name="ibSecretAnswer"
						id="ibSecretAnswer" maxlength="10" required="required"
						data-errormessage="${message(code:'userprofile.template.changesecureaccess.secretanswer.error.message') }"
						value="${changeSecureAccessModel?.userSecretText}" />
				</p>
			</div>


			<div class="buttons">
				<vayana:submitToRemote
					value="${message(code:'userprofile.template.changesecureaccess.submit.button.text')}"
					action="verifysecureaccess" controller="userProfile"
					id="verifySubmit" name="verifySubmit"
					before="if (checkFormValidity()) {return false;}"
					update="[failure:'messagesDiv']"
					onSuccess="updateFormData(data,textStatus)" />
			</div>
				<br>
				<br>
		</div>
		<g:if test="${grailsApplication.config.secure.color.required == true}">
			<div class="col-370">
				<div class="layer_preview">
					<div class="fields">
						<p>
							<b>Security Seal Preview</b>
						</p>
					</div>
					<%--                    	<div class="sec_prvw" style="background:#f1f1f1;">--%>
					<div>
						<p align="center">
							<img />
						</p>
						<br />
						<p align="center">
							<b><i class="sec_text">Your Short Message</i></b>
						</p>
					</div>
					<%--                    	</div>--%>
				</div>
			</div>
		</g:if>



	</g:form>
</body>

<script>

$('.carousel').carousel({
	itemsPerPage:4,
	itemsPerTransition: 4,
	easing: 'linear',
	noOfRows: 2
});

function onLoad()
{
var sec_text=$("#ibSecretAnswer").val();
$(".sec_text").text(sec_text);
var categories = $("#ibUserImageCategories option").each(function(){
	var catgoryVal=$(this).val();
	if(catgoryVal=='${changeSecureAccessModel?.userSelectedImageBasketId}')
	{
		   $(this).val(catgoryVal).attr("selected","selected") ;		
			var sel=$(this).val(catgoryVal).text();
			$(this).parents("select").next(".ui-combobox").find(".ui-combobox-input").val(sel);
			$(this).parents("select").trigger("change");
	}	
			});
}
onLoad();
function updateFormData(data,textStatus){
	//alert("data:"+ data);
<%--	$("#messagesDiv").append(data);--%>
}

$("#changesecureaccess").dynamicfieldupdate();

// prototypal inheritance
if (typeof Object.create !== 'function') {
	Object.create = function (o) {
		function F() {}
		F.prototype = o;
		return new F();
	};
}

$('.carousel').carousel({
				itemsPerPage:5,
				itemsPerTransition: 5,
				easing: 'linear',
				noOfRows: 2
			});

$(document).ready(function(){

	$( "#ibSecretAnswer" ).keyup(function(){
	              var text=$(this).val();
	              $('.sec_prvw div p i').text(text);
	})
	$( "input[name=ibUserSecureColorChkId]" ).change(function() {
	              if($(this).is( ":checked" )){
	                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').parent().siblings().find('label').removeClass('active').find('.ticker').detach('.ticker');  
	                var color=$(this).data('hexcode')
	                $('.sec_prvw').css("background-color","#"+color);
	                }
    }).change();
});
function checkFormValidity()
		{
			if(!$("#changesecureaccess").checkValidity())
		 	{
			 	return true;
		 	}else
		 	{
			 	return false;
		 	}
	 	}

</script>
