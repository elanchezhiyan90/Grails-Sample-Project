<div class="showsimage secColor" >
    <div class="carousel module">
     <ul>
		<g:each in="${userVerificationResponseModel?.colorPaleteBasketDetails}" var="secureColorList">  
		<li>
			<label>
				<vayana:img documentDetailId="${secureColorList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" />
				<span class="inputwrap">
					<input type="radio"  data-hexcode="${secureColorList?.colorHexValue}" value="${secureColorList?.id}"  name="ibUserSecureColorChkId" id="ibUserSecureColorChkId" class="group-"
					data-errormessage="${message(code:'userregistration.templates.loginsecureimages.selectsecureimages.message') }" >
				</span>
			</label>
		</li>
		</g:each>
	</ul>
	</div>
</div>
