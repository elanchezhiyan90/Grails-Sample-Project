<div class="fields">
  				<p>
      				<label for="biller" >Biller Service</label>
							<g:select id="billerServiceId" 
			                             name='billerServiceId' 
			                             from='${BillerDetailsModel?.billerServices}'
			                             optionKey="idVersion" 
								         optionValue="code"
								         noSelection ="${['null':'Select Biller Service']}"
								         required="required" data-errormessage="${g.message(code:"biller.templates.addbiller.addbillerinstruction.billerservice.error.message") }"
								         onchange="${ remoteFunction( 
											 							controller :'Biller',
																	    action:'getBillerServiceMetaData', 														  						
																	    update:'divParentBillerMetaData',								 
																	  	params:'\'selectedBillerServiceId=\'+this.value',onSuccess: 'onParentBillerMetaDataSuccess(data,textStatus);', onFailure: 'onParentBillerMetaDataFailure();'														
																	   						   )}" 		
								         />
  				</p>
  				<div class="updater" id="imglogoholder" style="float:left;"></div>
</div>