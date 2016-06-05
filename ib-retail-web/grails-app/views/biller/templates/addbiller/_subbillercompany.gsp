<g:if test="${BillerDetailsModel?.billers}">
<div class="fields">
	  				<p>
	      				<label for="biller" >${message(code:'biller.templates.addbiller.subbillercompany.billerregion.label') }</label>
								<g:select id="billerId" 
				                             name='billerId' 
				                             from='${BillerDetailsModel?.billers}'
				                             optionKey="idVersion" 
									         optionValue="shortName"
									         noSelection ="${['null':'Select Biller Region']}"
									         onchange="${ remoteFunction( 
												 							controller :'Biller',
																		    action:'getSubBillerMetaData', 														  						
																		    update:'divSubBillerMetaData',								 
																		  	params:'\'selectedBillerTypeId=\'+this.value+\'&parentBillerId=\'+getParentBillerId()',onSuccess: 'onSubBillerMetaDataSuccess(data,textStatus);', onFailure: 'onSubBillerMetaDataFailure();'														
																		   						   )}" 		
									         />
	  				</p>
	  				<div class="updater" id="subbillerimglogoholder" style="float:left;"></div>
	  				<%--<div class="updater" id="imgdocholder1" style="float:left;"></div>
	--%></div>
</g:if>

<%--<g:if test="${BillerDetailsModel?.biller}">
<g:set var="img" value="${BillerDetailsModel?.biller.getDocument().getDocumentDetails().iterator().next().getId()}"/>
<span id="billerlogo"><vayana:img documentDetailId="${img}" height="36" width="36" /></span>
<g:set var="imgdoc" value="${BillerDetailsModel?.biller.getImageDocument().getDocumentDetails().iterator().next().getId()}"/>
</g:if>

--%>