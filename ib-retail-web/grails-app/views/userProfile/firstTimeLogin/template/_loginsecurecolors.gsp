 <div class="secureimage">
<div class="carousel module">
     <ul>
		<g:each in="${userSelfRegistrationResponseModel?.colorPaleteBasketDetails}" var="secureColorList">
		<li>
			<label>
				<vayana:img documentDetailId="${secureColorList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" /><input
				type="radio" data-hexcode="${secureColorList?.colorHexValue}" value="${secureColorList?.id}" name="ibUserSecureColorChkId" id="ibUserSecureColorChkId" class="group-"
				data-errormessage="${message(code:'userregistration.templates.loginsecureimages.selectsecureimages.message') }" >
			</label>
		</li>
		</g:each>
	</ul>
     </div>
    </div> 
     
 <g:javascript>
  $('.carousel').carousel({
		itemsPerPage:4,
		itemsPerTransition: 4,
		easing: 'linear',
		noOfRows: 2
	});

</g:javascript>