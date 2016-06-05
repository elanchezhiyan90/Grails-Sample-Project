<g:set var="userSelecetedImages" value="${secureImagesModel?.userSelectedImages}"/> 
		<ul class="preference">
			<g:each in="${secureImagesModel?.secureImageBasketDetails}" var="secureImageList">
				<li>
					<label>		
					<g:if test="${userSelecetedImages.contains(secureImageList?.id)}">
							<vayana:img documentDetailId="${secureImageList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" isSecured="Y" />
							<span class="inputwrap">
							<input type="radio" value="${secureImageList?.document?.id}" name="ibUserSecureImages" id="ibUserSecureImages" class="group-"
							data-errormessage="${message(code:'userprofile.template.secureimages.image1.error.message')}" checked="checked"
							data-secureImgDoc="${secureImageList?.document?.documentDetails?.iterator().next().getId()}"/>
							</span>
						</g:if>	
						<g:else>
							<vayana:img documentDetailId="${secureImageList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" isSecured="Y" />
							<span class="inputwrap">
							<input type="radio" value="${secureImageList?.document?.id}" name="ibUserSecureImages" id="ibUserSecureImages" class="group-"
							data-errormessage="${message(code:'userprofile.template.secureimages.image2.error.message')}"
							data-secureImgDoc="${secureImageList?.document?.documentDetails?.iterator().next().getId()}"/>
							</span>
						</g:else>
					</label>
				</li>
			</g:each>
		</ul>
     
    <script>   
		$( "input[name=ibUserSecureImages]" ).change(function() {      
              if($(this).is( ":checked" )){
                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').parent().siblings().find('label').removeClass('active').find('.ticker').detach('.ticker');
                var url=$(this).data('secureimgdoc')          
                $('.sec_prvw div img').attr('src',"${request.getContextPath()}/user/image/"+url);
                $('.sec_prvw div img').attr('height',"100");
                $('.sec_prvw div img').attr('width',"100");
                }
            }).change();  
    </script>
 
                    
