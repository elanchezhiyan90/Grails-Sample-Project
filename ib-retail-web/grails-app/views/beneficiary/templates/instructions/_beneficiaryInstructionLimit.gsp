<g:hiddenField name="beneInstructionLimitId" value="${beneficiaryInstruction?.beneficiaryLimit?.idVersion}" />
<div class="fields">
<h4><g:message	code="beneficiary.templates.instructions.accountLimits.label" /></h4>
<br />
</div>

<div class="fields">
				<p>
					 <label for="limitCurrencyId"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.limitcurrency.label"/></label>
					  <vayana:currencySelect name="limitCurrencyId" id="limitCurrencyId" type="CURRENCIES" findBy="ALL"
					  required="required" data-errormessage="${g.message(code:"beneficiary.templates.instructions.beneficiaryinstructionlimit.limitcurrency.label.error.message")}"   
					  value="${beneficiaryInstruction?.beneficiaryLimit?.limitDefinition?.currency?.idVersion}"/>					 
	             </p>	             
			</div>
	
	<div class="fields">
          <p>
            <label for="globalMaxAmountParam"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.transactionlimit.label"/></label>
           <g:field class="s_amt" type="number" name="globalMaxAmountParam" id="globalMaxAmountParam" min="0" value="${beneficiaryInstruction?.beneficiaryLimit?.globalMaxAmount}"
           			title="${g.message(code:'beneficiary.templates.instructions.beneficiaryinstructionlimit.transactionlimit.tooltip.text')}"	
					/>
          </p>                                  
        </div>
        
   	  <div class="fields">
          <p>
            <label for="globalMonthlyMaxAmountParam"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.monthlylimit.label"/></label>
            <g:field class="s_amt" type="number" name="globalMonthlyMaxAmountParam" id="globalMonthlyMaxAmountParam" min="0" 
            value="${beneficiaryInstruction?.beneficiaryLimit?.globalMonthlyMaxAmount}"
           			title="${g.message(code:'beneficiary.templates.instructions.beneficiaryinstructionlimit.monthlylimit.tooltip.text')}"	
					/>
           
          </p>                                  
        </div>
        
		<div class="fields">
          <p>
            <label for="globalDailyMaxAmountParam"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.dailylimit.label"/></label>
            <g:field class="s_amt" type="number" name="globalDailyMaxAmountParam" id="globalDailyMaxAmountParam" min="0" 
            value="${beneficiaryInstruction?.beneficiaryLimit?.globalDailyMaxAmount}"
           			title="${g.message(code:'beneficiary.templates.instructions.beneficiaryinstructionlimit.dailylimit.tooltip.text')}"	
					/>
          </p>                                  
        </div>
       	
       	<div class="fields">
            <p>
              <label for="effectiveFromDate"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.fromdate.label"/></label>               
               	<vayana:vayanaDate name="effectiveFromDate" id="effectiveFromDate" required=""   
               	value="${beneficiaryInstruction?.beneficiaryLimit?.effectiveFromDate ? beneficiaryInstruction?.beneficiaryLimit?.effectiveFromDate : ''}"
               	/>
               	
            </p>
   		</div>
   		
    	<div class="fields">
            <p>
              <label for="effectiveToDate"><g:message code="beneficiary.templates.instructions.beneficiaryinstructionlimit.todate.label"/></label>   		         
   		      <vayana:vayanaDate name="effectiveToDate" id="effectiveToDate" required=""
   		      value="${beneficiaryInstruction?.beneficiaryLimit?.effectiveToDate ? beneficiaryInstruction?.beneficiaryLimit?.effectiveToDate : ''}" 
              />
            </p>
    	</div>