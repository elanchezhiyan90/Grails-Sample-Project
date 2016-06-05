    <g:set var="userSelecetedColorPalete" value="${changeSecureAccessModel?.userSelectedColorPalete?.colorPaleteBasketDetail}"/> 
    <div class="secureimage" >
	    <div class="carousel module">
	     	<ul>
				<g:each in="${changeSecureAccessModel?.colorPaleteBasketDetails}" var="secureColorList">
					<li>
						<label>
						<g:if test="${userSelecetedColorPalete?.id.equals(secureColorList?.id)}">
							<vayana:img documentDetailId="${secureColorList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" />
							<span class="inputwrap">
							<input type="radio" data-hexcode="${secureColorList?.colorHexValue}" value="${secureColorList?.id}" name="ibUserSecureColorChkId" id="ibUserSecureColorChkId" class="group-"
							data-errormessage="${message(code:'userregistration.templates.loginsecureimages.selectsecureimages.message') }" checked="checked">
							</span>
						</g:if>
						<g:else>
							<vayana:img documentDetailId="${secureColorList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" />
							<span class="inputwrap">
							<input type="radio" data-hexcode="${secureColorList?.colorHexValue}" value="${secureColorList?.id}" name="ibUserSecureColorChkId" id="ibUserSecureColorChkId" class="group-"
							data-errormessage="${message(code:'userregistration.templates.loginsecureimages.selectsecureimages.message') }">
							</span>
						</g:else>
						</label>
					</li>
				</g:each>
			</ul>
	    </div>
    </div>
