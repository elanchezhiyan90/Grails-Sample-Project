 
     <fieldset>
		<g:each in="${ibSecureImagesModel}" var="secureImageList">
			<label>
				<vayana:img documentDetailId="${secureImageList?.document?.documentDetails?.iterator().next().getId()}" height="80" width="80"/>
				<input type="radio" value="${secureImageList?.document?.getId()}" name="ibUserSecureImgChkId" id="ibUserSecureImgChkId" class="group-"
				data-errormessage="${message(code:'userregistration.templates.loginsecureimages.selectsecureimages.message') }" >

			</label>
		</g:each>

      </fieldset>
      
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
      
      
      </script>
 
                    
