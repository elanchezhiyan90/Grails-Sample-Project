<div class="fields">
  				<p>
      				<label for="biller" >${message(code:'biller.templates.addbiller.parentbillercompany.billerorcompany.label') }</label>
							<g:select id="parentBillerId" 
			                             name='parentBillerId' 
			                             from='${BillerDetailsModel?.billers}'
			                             optionKey="idVersion" 
								         optionValue="shortName"
								         noSelection ="${['null':'Select Biller / Company']}"
								         required="required" data-errormessage="${g.message(code:"biller.templates.addbiller.addbillerinstruction.billercompany.error.message") }"
								         onchange="${ remoteFunction( 
											 							controller :'Biller',
																	    action:'getBillerServices', 														  						
																	    update:'divBillerService',								 
																	  	params:'\'selectedBillerTypeId=\'+this.value',onSuccess: 'onParentBillerServiceSuccess(data,textStatus);', onFailure: 'onParentBillerServiceFailure();'														
																	   						   )}" 		
								         />
  				</p>
  				<div class="updater" id="imglogoholder" style="float:left;"></div>
  				<%--<div class="updater" id="imgdocholder" style="float:left;"></div>
--%></div>