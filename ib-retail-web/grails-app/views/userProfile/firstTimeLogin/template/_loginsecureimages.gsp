 
     <div class="carousel module">
     <ul>
		<g:each in="${ibSecureImagesModel}" var="secureImageList" status="index">
		<li>
			<label>
				<g:if test="${index == 0}">
					<vayana:img isSecured="Y" documentDetailId="${secureImageList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" /><input
					type="radio" value="${secureImageList?.document?.getId()}" name="ibUserSecureImgChkId" id="ibUserSecureImgChkId" class="group-required"
					data-errormessage="${message(code:'userregistration.templates.loginsecureimages.selectsecureimages.message') }" 
					data-secureImgDoc="${secureImageList?.document?.documentDetails?.iterator().next().getId()}" checked>
				</g:if>
				<g:else>
					<vayana:img isSecured="Y" documentDetailId="${secureImageList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80" /><input
					type="radio" value="${secureImageList?.document?.getId()}" name="ibUserSecureImgChkId" id="ibUserSecureImgChkId" class="group-required"
					data-errormessage="${message(code:'userregistration.templates.loginsecureimages.selectsecureimages.message') }" 
					data-secureImgDoc="${secureImageList?.document?.documentDetails?.iterator().next().getId()}">
				</g:else>
			</label>
		</li>
		</g:each>
	</ul>
     </div>      
      <script>
    var toMakeSelect=$('input[name="ibUserSecureImgChkId"]:not(:checked)').each(function() 	{
      		var imageArray = [];
      		var imgSplit=checkedImg.split(",");
      		for (i = 0; i < imgSplit.length; i++) {      		
      		imageArray.push(imgSplit[i].replace('[', '').replace(']','').trim() )
			}
      		var found = $.inArray($(this).val(), imageArray) > -1;
      		if(found)
      		{
      				$(this).val($(this).val()).attr("checked","checked") 
      		}
      });
      
      $( "input[name=ibUserSecureImgChkId]" ).change(function() {
              if($(this).is( ":checked" )){
                $(this).after("<span class='ticker'></span>").closest('label').addClass('active').parent().siblings().find('label').removeClass('active').find('.ticker').detach('.ticker');
                var url=$(this).data('secureimgdoc')                
                $('.sec_prvw div img').attr('src',"${request.getContextPath()}/user/image/"+url);
                $('.sec_prvw div img').attr('height',"100");
                $('.sec_prvw div img').attr('width',"100");
                }
            }).change();  
      
      </script>
 
                    
