<g:set var="userSelecetedColorPalete" value="${userSelectedColor?.colorPaleteBasketDetail}"/> 
<label for="userSecureColor">Select a seal color</label>
<div class="showsimage">
    <fieldset>
		<g:each in="${basketColors}" var="secureColorList">
			<label>
				<g:if test="${userSelecetedColorPalete?.id.equals(secureColorList?.id) && devEnvFlag }">
					<vayana:img documentDetailId="${secureColorList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" />
					<span class="inputwrap">
						<input type="radio" data-hexcode="${secureColorList?.colorHexValue}" value="${secureColorList?.id}" name="userSecureColor" id="userSecureColor" class="group-"
						data-errormessage="${message(code:'userregistration.templates.loginsecureimages.selectsecureimages.message') }" checked="checked">
					</span>
				</g:if>
				<g:elseif test="${userSelecetedColorPalete?.id.equals(secureColorList?.id) && preLoginSubmit }">
					<vayana:img documentDetailId="${secureColorList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" />
					<span class="inputwrap">
						<input type="radio" data-hexcode="${secureColorList?.colorHexValue}" value="${secureColorList?.id}" name="userSecureColor" id="userSecureColor" class="group-"
						data-errormessage="${message(code:'userregistration.templates.loginsecureimages.selectsecureimages.message') }" checked="checked">
					</span>
				</g:elseif>
				<g:else>
					<vayana:img documentDetailId="${secureColorList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" />
					<span class="inputwrap">
						<input type="radio" data-hexcode="${secureColorList?.colorHexValue}" value="${secureColorList?.id}" name="userSecureColor" id="userSecureColor" class="group-"
						data-errormessage="${message(code:'userregistration.templates.loginsecureimages.selectsecureimages.message') }">
					</span>
				</g:else>
			</label>
		</g:each>
	</fieldset>
</div>      