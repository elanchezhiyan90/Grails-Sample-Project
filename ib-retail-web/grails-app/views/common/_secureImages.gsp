<label>${message(code:'taglib.secureimages.secureimagepersonalized.label')}</label>
<div class="showsimage">
		<fieldset>
		<g:each var="secureImg" in="${secureImagesModel?.secureImages}">
			<label>
			<g:if test="${secureImagesModel?.userSecureImages?.contains(secureImg) && devEnvFlag}">	
				<vayana:img documentDetailId="${secureImg}" height="80" width="80"/>
				<span class="inputwrap">
					<input type='radio' value='${secureImg}' name='secureImg' id='secureImg${secureImg}' checked='checked' 
					class='group-required' data-errormessage='Please select your secure image' />
				</span>
			</g:if>
			<g:elseif test="${secureImagesModel?.userSecureImages?.contains(secureImg) && preLoginSubmit}">
				<vayana:img documentDetailId="${secureImg}" height="80" width="80"/>
				<span class="inputwrap">
					<input type='radio' value='${secureImg}' name='secureImg' id='secureImg${secureImg}' 
					class='group-required' data-errormessage='Please select your secure image' />
				</span>
			</g:elseif>
			<g:else>
				<vayana:img documentDetailId="${secureImg}" height="80" width="80"/>
				<span class="inputwrap">
					<input type='radio' value='${secureImg}' name='secureImg' id='secureImg${secureImg}' 
					class='group-required' data-errormessage='Please select your secure image' />
				</span>
			</g:else>
			</label>
		</g:each>   
	</fieldset>
	<g:hiddenField name="ibUserSecureMessage" id="ibUserSecureMessage" value="${secureImagesModel?.secureText}"/>
	<label class="stxt">
		${secureImagesModel?.secureText}
		<input type="checkbox" name="secureText" id="secureText" required data-errormessage="${message(code:'taglib.secureimages.personalized.error.message')}" checked="checked">
	</label>
</div>