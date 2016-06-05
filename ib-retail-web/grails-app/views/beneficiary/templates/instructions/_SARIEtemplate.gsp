Overseas Bank Account

   <g:if test ="${beneInstructionCmd?.beneInsId}">
		<section>
		        <h2><g:message code="beneficiary.templates.instructions.sarietemplate.accontdetails.h2.text"/></h2>
		        <form>
		          <div class="bene_detail">
   </g:if>   
			 <g:hiddenField name="paymentTypeUid" value="OBA" />	
			 <input type="hidden" name="tstCode" id="tstCode" value="${beneInsRespone?.getBeneInstructionTemplate()}"/>
			  <div class="fields">    
			   <p>
              <label for="pymt_type"><g:message code="beneficiary.templates.instructions.sarietemplate.paymentmode.label"/></label>
               
           
   <g:if test ="${beneInstructionCmd?.beneInsId}">
                 <g:hiddenField name="beneInsId" value="${beneInstructionCmd?.beneInsId}"/>
                  <g:hiddenField name="beneInsVersion" value="${beneInstructionCmd?.beneInsVersion}"/>
               <input type="text" name="paymentModeUid" id="paymentModeUid" size="20" value="${beneInstructionCmd?.paymentModeUid}" readonly="readonly"	 />
                
                 </g:if>
                 <g:else>
                 <g:select 	 id="paymentModeUid" 
		                     name='paymentModeUid' 
		                     value="${beneInstructionCmd?.paymentModeUid}"	
		                     from='${paymentMode}'
							 optionKey="modeUid" 
							 optionValue="modeDesc"
							         />		
                 </g:else>
		          		                   
              </div>					
            <div class="fields">
              <p>
                <label for="bene_label"><g:message code="beneficiary.templates.instructions.sarietemplate.benenickname.label"/></label>
                <input type="text" name="beneInsShortName" id="beneInsShortName" size="20" value="${beneInstructionCmd?.beneInsShortName}" />
              </p>
            </div>
            <div class="fields">
              <p>
                <label for="bene_label"><g:message code="beneficiary.templates.instructions.sarietemplate.nationality.label"/></label>
                <input type="text" name="bene_nationality" id="bene_nationality" size="20" value="" />
              </p>
            </div>
            <div class="fields">
                                  <p>
                                    <label for="city"> <g:message code="beneficiary.templates.instructions.sarietemplate.bankname.label"/></label>
                                     <g:select   id="bankUid" 
					                             name='bankUid' 
					                             value="${beneInstructionCmd?.bankUid}"	
					                             from='${banks}'
										         optionKey="key" 
										         optionValue="value"										         
										         />		
                                  </p>
                                </div>
            <div class="fields">
              <p>
                <label for="bene_label"><g:message code="beneficiary.templates.instructions.sarietemplate.bic/swiftcode.label=BIC / SWIFT Code"/></label>
                <input type="text" name="swift" id="swift" size="20" value="" />
              </p>
            </div>
            <div class="fields">
              <p>
                <label for="bene_label"><g:message code="beneficiary.templates.instructions.sarietemplate.streetname.label"/></label>
                <input type="text" name="street_name" id="street_name" size="20" value="" />
              </p>
            </div>
            <div class="fields">
              <p>
                <label for="bene_label"><g:message code="beneficiary.templates.instructions.sarietemplate.postalcode.label"/></label>
                <input type="text" name="postal_code" id="postal_code" size="20" value="" />
              </p>
            </div>
             <div class="fields">
              <p>
                <label for="bene_label"><g:message code="beneficiary.templates.instructions.sarietemplate.beneaccounttype.label"/></label>
                 <g:select 	 id="accountTypeUid" 
		                     name='accountTypeUid' 
		                     value="${beneInstructionCmd?.accountTypeUid}"	
		                     from='${accounts}'
							 optionKey="key" 
							 optionValue="value"
							         />		
<%--              	<vayana:select name="accountTypeUid"  id = "accountTypeUid" from = "${accounts}" required="required" data-errormessage="Please select an account type"   /> --%>
              </p>              
								                         
            </div>
            <g:hiddenField name="overrideType" value="acct" />
		<div class="fields">
			<p>
				<label for="bene_label"><g:message code="beneficiary.templates.instructions.sarietemplate.accountcurrency.label"/></label>
	              <vayana:baseSelect name="currencyId" id="currencyId" type="${CommonEntityEnum.CURRENCIES}"
	                   noSelection="${['null':'Select']}"
	                   onchange="${ remoteFunction( 
								 							controller :'beneficiary',
														    action:'beneInstructionLimit', 														  						
														    update:'divBeneInsLimit',								 
														  	params:'\'currencyId=\'+this.value',onSuccess: 'reinitialiseScrollPane();'														
														   						   )}" 		
	              />
    		</p>
		</div>
		<div id="divBeneInsLimit">
		
		</div>
            <div class="fields">
              <p>
                <label for="bene_label"> <g:message code="beneficiary.templates.instructions.sarietemplate.accontnumberoriban.label"/></label>
                <input type="text" name="iban" id="iban" size="20" value="${beneInstructionCmd?.iban}" />
              </p>
            </div>
            <div class="fields">
              <p>
                <label for="bene_label"><g:message code="beneficiary.templates.instructions.sarietemplate.confirmaccountnumberoriban.label"/></label>
                <input type="text" name="Ciban" id="Ciban" size="20" value="${beneInstructionCmd?.iban}" />
              </p>
            </div>

                <g:if test ="${beneInstructionCmd?.beneInsId}">
              	 <div class="buttons center">
             	   <g:actionSubmit  controller = "beneficiary"  action="updateBeneficaryInstructionOnly" id="update" name="update"  value="${g.message(code:'beneficiary.templates.instructions.sarietemplate.buttonupdate.text')}"  />
           	 	 </div>    
              </g:if>
              <g:else>
	               <div class="buttons center">
	                <g:actionSubmit  controller = "beneficiary"  action="insertBeneficaryInstructionOnly" id="save" name="save"  value="${g.message(code:'beneficiary.templates.instructions.sarietemplate.buttonsave.text')}"    />
	               </div>    
              </g:else>
           
       <g:if test ="${beneInstructionCmd?.beneInsId}">        
			                </form>
			        <br />
			        <br />
			        <br />
			        <br />
			 </section>        
        </g:if>      