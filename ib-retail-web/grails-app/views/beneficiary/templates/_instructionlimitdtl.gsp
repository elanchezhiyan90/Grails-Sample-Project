                                <g:if test="${beneficiaryLimitTypes}">
	                                  <g:each in="${beneficiaryLimitTypes}"> 
	                              		    <g:hiddenField name="limitTypeId" value="${it.id}"/>
	                                    	<g:hiddenField name="limitTypeVersion" value="${it.version}"/>
	                                  		    <div class="fields">
				                                  <p>
				                                    <label for="ml">${it.description}</label>
				                                   <input type="number"  step="any" name="amount" id="amount"   min="1"  data-errormessage="Please Enter Amount"  />
				                                  </p>                                  
				                                </div>
	                                  </g:each>                            
	                               	<div class="fields">
	                                    <p>
	                                      <label for="from_date"><g:message code="beneficiary.templates.instructionlimitdtl.fromdate.label"/></label>
	                                      <input type="date" name="effectiveFromDate" id="effectiveFromDate"   data-dependent-validation='{"from": "to_date", "prop": "max"}'  required data-errormessage="${g.message(code:'beneficiary.templates.instructionlimitdtl.enterdate.error.message')}"  />
	                                    </p>
	                           		</div>
	                            	<div class="fields">
	                                    <p>
	                                      <label for="to_date"><g:message code="beneficiary.templates.instructionlimitdtl.todate.label"/></label>
	                                      <input type="date" name="effectiveToDate" id="effectiveToDate"  data-dependent-validation='{"from": "from_date", "prop": "min"}'  required data-errormessage="${g.message(code:'beneficiary.templates.instructionlimitdtl.enterdate.error.message')}"  />
	                                    </p>
	                            	</div>
                            	</g:if> 
                            	<g:else>
                            		 <g:each in="${beneficiaryInstruction?.beneInstructionLimits}"> 
                            		 		<g:hiddenField name="limitId" value="${it.id}"/>
	                                    	<g:hiddenField name="limitVersion" value="${it.version}"/>
	                              		    <g:hiddenField name="limitTypeId" value="${it.limitType.id}"/>
	                                    	<g:hiddenField name="limitTypeVersion" value="${it.limitType.version}"/>
	                                  		    <div class="fields">
				                                  <p>
				                                    <label for="ml">${it.limitType.description}</label>
				                                   <input type="number"  step="any" name="amount" id="amount"  value="${ it.amount}"  min="1"  data-errormessage="Please Enter Amount"  />
				                                  </p>                                  
				                                </div>
	                                  </g:each>         
                            		
                            		<div class="fields">
	                                    <p>
	                                      <label for="from_date"><g:message code="beneficiary.templates.instructionlimitdtl.fromdate.label"/></label>
	                                  
	                                      <input type="date" name="effectiveFromDate" id="effectiveFromDate" value="${ (it.effectiveFromDate != null)?it.effectiveFromDate:''}"   data-dependent-validation='{"from": "to_date", "prop": "max"}'  required data-errormessage="${g.message(code:'beneficiary.templates.instructionlimitdtl.enterdate.error.message')}"   />
	                                    </p>
	                           		</div>
	                            	<div class="fields">
	                                    <p>
	                                      <label for="to_date"><g:message code="beneficiary.templates.instructionlimitdtl.todate.label"/></label>
	                                      <input type="date" name="effectiveToDate" id="effectiveToDate" value="${  (it.effectiveToDate != null)?it.effectiveToDate:''}"  data-dependent-validation='{"from": "from_date", "prop": "min"}'  required data-errormessage="${g.message(code:'beneficiary.templates.instructionlimitdtl.enterdate.error.message')}"   />
	                                    </p>
	                            	</div>
                            	</g:else>