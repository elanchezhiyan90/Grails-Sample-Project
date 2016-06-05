<g:hiddenField name="buttonEvent"/>
<div class="col-370">	    
	    <g:form name="addBillerInstruction" id="addBillerInstruction">	
     	    	<div class="fields">
  				<p>
      				<label for="biller" >${message(code:'biller.addbiller.billercategory.label') }</label>
							<g:select id="billerCategoryId" 
			                             name='billerCategoryId' 
			                             from='${BillerCategoryDetailsModel?.billerCategories}'
			                             optionKey="idVersion" 
								         optionValue="description"
								         noSelection ="${['null':'Select Biller Category']}"
								         required="required" data-errormessage="${g.message(code:"biller.templates.addbiller.addbillerinstruction.billercategory.error.message") }"
								         onchange="${ remoteFunction( 
										 							controller :'Biller',
																    action:'getParentBillerCompany', 														  						
																    update:'divParentBillerCompany',								 
																  	params:'\'selectedBillerCategoryId=\'+this.value',onSuccess:'onBillerCategorySuccess(data,textStatus);;', onFailure: 'onBillerCategoryFailure();')}" 		
							/>
  				</p>
				</div>
				
     	    	<div id="divParentBillerCompany" >					
				</div>
						
				<div id="divBillerService" >					
				</div>
				
				<div id="divParentBillerMetaData" >					
				</div>
				
				<div id="divSubBillerMetaData" >					
				</div>
				
				<div id="divPassCode" style="display: none;">
					<div class="fields">
						<p>
      							<label for="passcode">${message(code:'biller.addbiller.passcode.label') }</label>
     							<input type="text" value="" name="passCode" id="passCode" data-errormessage="${g.message(code:"biller.templates.addbiller.addbillerinstruction.passcode.error.message") }"/>                               
  						</p>  						
					</div>
				</div>		
						
				<div id="divBillerInstructionData" style="display: none;">				
					<div class="fields">
						<p>
      							<label for="payeename">${message(code:'biller.addbiller.nickname.label') }</label>
     							<input type="text" value="" name="shortName" id="shortName" required="required" data-errormessage="${g.message(code:"biller.templates.addbiller.addbillerinstruction.nickname.error.message") }"/>                               
  						</p>  						
					</div>
					<br/>
                 
                    <div class="fields" id="divAutoPayOption">
						<p>
      							<g:hiddenField name="autoPayOption" value="N" />
      							<%--<label for="Auto Payment">${message(code:'biller.addbiller.autopayment.label') }</label>
     							<g:radio name="autoPayOption" id="autoPayOptionY" value="Y" onclick="${remoteFunction(controller:'Biller',update:'',action:'getautopayfields',params:'\'autopayType=\'+getAutoPayFlag()',onSuccess:'updateautopaydivdata(data,textStatus);')}" /><label for="autoPayOptionY" >${message(code:'biller.addbiller.autopayment.yes.label') }</label>
     							<g:radio name="autoPayOption" id="autoPayOptionN" value="N" /><label for="autoPayOptionN" >${message(code:'biller.addbiller.autopayment.no.label') }</label>                               
  						--%>
  						</p>  						
                    </div>
                   
                    <div id="autopaydivdata" >
																
					</div>
				
				
					<div id="dynamicAuthContent">	
                    <div id="divSavePayContent">
                     <%--<vayana:serviceValidate name="addBillerInst" buttonEvent="SAVEANDPAY"
						value="${g.message(code:"biller.addbiller.savepay.button.text") }"
						enableButton="btns_now" controller="Biller"
						action="saveAndPayBillerInstruction" secondaryDiv="servicepanel" onSuccess="onServiceSucess(data,textStatus)" />	
					 --%>
					 <g:submitToRemote controller="Biller" action="validateBillerInstruction"
					 name="addBillerInst" value="${g.message(code:"biller.addbiller.save.button.text") }" 
					 before="if(checkFormValidity()){return false;};catchButtonEvent('SAVE')" 
					 update="[success:'servicepanel',failure:'messagesDiv']" onSuccess="onSaveSucess(data,textStatus)"/>
					 
					 <vayana:serviceValidate name="addBillerInst" buttonEvent="PAY"
						value="${g.message(code:"biller.addbiller.pay.button.text") }"
						enableButton="btns_now" controller="Biller"
						action="saveAndPayBillerInstruction" secondaryDiv="servicepanel" />	
					 <input type="button" name=""
								value="${message(code:'biller.addbiller.enterotp.cancel.button.text') }"
								id="cancel" name="cancel" class="btn_next" />
                    </div>
                    
                    <%--
                    <div id="divSubmitContent" style="display: none;">
	                  	<g:submitToRemote controller="Biller" action="validateBillerInstruction"
					 	name="addBillerInst" value="${g.message(code:"biller.addbiller.save.button.text") }" 
					 	before="if(checkFormValidity()){return false;};catchButtonEvent('SAVE')" 
						 update="servicepanel" onSuccess="onSaveSucess(data,textStatus)"/>
						<input type="button" name=""
								value="${message(code:'biller.addbiller.enterotp.cancel.button.text') }"
								id="cancel" name="cancel" class="btn_next" />		
					</div>	
				--%>
				
				</div>               
				
				</div>
					
     	</g:form>
	</div>