<%@page import="com.vayana.ib.bm.core.api.model.enums.ElementTypeEnum"%>
<%@page import="com.vayana.bm.core.api.model.enums.DataTypeEnum"%>
<g:hiddenField name="tenantServiceCode" id="tenantServiceCode" value="${genericSRModel?.tenantServiceCode}"></g:hiddenField>
<g:hiddenField name="buttonEvent"/>
<g:hiddenField value="${genericSRModel?.customerName}" id="customerName" name="customerName"/>
<g:each in="${genericSRModel?.serviceRequestMetaDatas}" var="metaDataList">
<div class="fields" id="formMainContent">  
					
					<g:if test="${'CHQSTS'.equals(genericSRModel?.tenantServiceCode) && DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("ACC_NO"))}">	
						<p>
							<label for="fromAccount">${message(code:'servicerequest.chequebook.accountnumber.label') }</label>
								<vayana:fromAccountSelect id="${metaDataList?.id+"-"+metaDataList?.version}"
									name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" opsIns="NO"
									poptype="${metaDataList?.tagLibParameter}" required="required" optionKey="accountNumber"
									data-errormessage="${message(code:'servicerequest.chequebook.selectaccount.error.message') }" />
<%--															<vayana:tagLibParser tagLibId="asdsad" tagLibParameter="" tagLibName="${metaDataList?.tagLibName}"/>			--%>
						</p>	
					</g:if>
					<g:if test="${!('CHQSTS'.equals(genericSRModel?.tenantServiceCode)) && DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("ACC_NO"))}">	
						<p>
							<label for="fromAccount">${message(code:'servicerequest.chequebook.accountnumber.label') }</label>
								<vayana:fromAccountSelect id="${metaDataList?.id+"-"+metaDataList?.version}"
									name="${metaDataList?.dataOrder+"-"+metaDataList?.id}"
									poptype="${metaDataList?.tagLibParameter}" required="required" optionKey="accountNumber"
									data-errormessage="${message(code:'servicerequest.chequebook.selectaccount.error.message') }" />
<%--															<vayana:tagLibParser tagLibId="asdsad" tagLibParameter="" tagLibName="${metaDataList?.tagLibName}"/>			--%>
						</p>	
					</g:if>	
					<g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("CARD_NO"))}">	
						<p>
							<label for="fromAccount">${message(code:'servicerequest.chequebook.cardnumber.label') }</label>
								<%--<vayana:fromAccountSelect id="${metaDataList?.id+"-"+metaDataList?.version}"
									name="${metaDataList?.dataOrder+"-"+metaDataList?.id}"
									poptype="${metaDataList?.tagLibParameter}" required="required" optionKey="accountNumber"
									data-errormessage="${message(code:'servicerequest.chequebook.selectaccount.error.message') }" />
															<vayana:tagLibParser tagLibId="asdsad" tagLibParameter="" tagLibName="${metaDataList?.tagLibName}"/>			--%>
															
															<vayana:creditcards id= "${metaDataList?.id+"-"+metaDataList?.version}" 
									name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" tenantServiceCode="${genericSRModel?.tenantServiceCode}"
									 required="required" optionKey="accountNumber" 
									data-errormessage="${message(code:'servicerequest.chequebook.selectaccount.error.message') }" />
															<vayana:tagLibParser tagLibId="asdsad" tagLibParameter="" tagLibName="${metaDataList?.tagLibName}"/>
						</p>	
					</g:if>	
					<g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("DEPOSIT_ACC_NO"))}">	
						<p>
							<label for="fromAccount">${message(code:'servicerequest.foreclosure.accountnumber.label') }</label>
								<vayana:fromAccountSelect id="${metaDataList?.id+"-"+metaDataList?.version}"
									name="${metaDataList?.dataOrder+"-"+metaDataList?.id}"
									poptype="${metaDataList?.tagLibParameter}" required="required" optionKey="accountNumber"
									data-errormessage="${message(code:'servicerequest.chequebook.selectaccount.error.message') }" />
<%--															<vayana:tagLibParser tagLibId="asdsad" tagLibParameter="" tagLibName="${metaDataList?.tagLibName}"/>			--%>
						</p>	
					</g:if>	
					
					<g:if test="${(DataTypeEnum.L.equals(metaDataList?.dataType) && (ElementTypeEnum.RD.equals(metaDataList?.elementTypeEnum)) && ("YESNO").equals(metaDataList?.tenantLookupType?.code) && (!["CHEQUE_RANGE","SELF_COL"].contains(metaDataList?.dataLabel)) )}">
						<div id="branchpickup">
							<div id="${metaDataList?.id+"-"+metaDataList?.version}" class="dataLabels">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>							
							<vayana:radioBranchPickUp name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" type="${metaDataList?.tenantLookupType?.code}" domain="tenant" />
							<g:hiddenField name="branchMetaDataId" value="${metaDataList?.id}"/>
							</div>
						</div>	
				  </g:if>


					<g:if test="${(DataTypeEnum.L.equals(metaDataList?.dataType) && (ElementTypeEnum.RD.equals(metaDataList?.elementTypeEnum)) && ("YESNO").equals(metaDataList?.tenantLookupType?.code) && (metaDataList?.dataLabel.equals("CHEQUE_RANGE")))}">
						<div id="${metaDataList?.id+"-"+metaDataList?.version}" class="dataLabels">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>							
							<vayana:radioChequeRange name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" type="${metaDataList?.tenantLookupType?.code}" domain="tenant" required="${metaDataList?.nullable}"/>
						</div>
						<g:hiddenField name="chequeRangeFlag" id="chequeRangeFlag" value=""/>
					</g:if>

					<g:if test="${DataTypeEnum.N.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("CHEQUE_NO"))}">
	  					<div id="ChequeNoDiv">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
							<g:textField id="ChequeNoDivTxt" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" maxlength="6" pattern="[0-9]+" data-errormessage="Please enter numeric values" />  						 
						</div>
					</g:if>
  					<g:if test="${DataTypeEnum.N.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("FROM_CHEQUE_NO"))}">
	  					<div id="ChequeRangeDiv1">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
							<g:textField id="ChequeRangeDiv1Txt" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" maxlength="10" pattern="[0-9]+" data-errormessage="Please enter numeric values"/>
	  					</div>
  					</g:if>
	  					
  					<g:if test="${DataTypeEnum.N.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("TO_CHEQUE_NO"))}">
						<div id="ChequeRangeDiv2">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
							<g:textField id="ChequeRangeDiv2Txt" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" maxlength="10" pattern="[0-9]+" data-errormessage="Please enter numeric values" />
	      				</div>  						 
  					</g:if>

				 	<g:if test="${(DataTypeEnum.L.equals(metaDataList?.dataType) && (ElementTypeEnum.RD.equals(metaDataList?.elementTypeEnum)) &&(!("YESNO").equals(metaDataList?.tenantLookupType?.code)) &&(metaDataList?.tenantLookupType!=null) && !metaDataList?.dataLabel.equals("TRN_TYPE"))}">
						<div id="${metaDataList?.id+"-"+metaDataList?.version}" class="dataLabels">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
							<vayana:radioGroup name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" type="${metaDataList?.tenantLookupType?.code}"  domain="tenant" />
						</div>
					</g:if>



				 	<g:if test="${(DataTypeEnum.L.equals(metaDataList?.dataType) && (ElementTypeEnum.RD.equals(metaDataList?.elementTypeEnum)) &&(!("YESNO").equals(metaDataList?.tenantLookupType?.code)) &&(metaDataList?.tenantLookupType!=null) && metaDataList?.dataLabel.equals("TRN_TYPE") )}">
						<div id="${metaDataList?.id+"-"+metaDataList?.version}" class="dataLabels">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
							<vayana:radioManagerCheque name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" type="${metaDataList?.tenantLookupType?.code}"  domain="tenant" required="required" />
						</div>
					</g:if>


					<g:if test="${DataTypeEnum.D.equals(metaDataList?.dataType) && !['FROM_DATE','TO_DATE'].contains(metaDataList?.dataLabel)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<input type="date" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.dataLabel}"  required="${metaDataList?.nullable}"/>  						
  					</g:if>
  					
  					<g:if test="${DataTypeEnum.D.equals(metaDataList?.dataType) && 'FROM_DATE'.equals(metaDataList?.dataLabel)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<input type="date" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="fromDate" onchange="enableToDate(this.value)" required="${metaDataList?.nullable}"  min="${new Date().minus(365).toTimestamp()?.format('yyyy-MM-dd')}" max="${new Date().toTimestamp()?.format('yyyy-MM-dd')}" maxlength="10"/>  						
  					</g:if>
  					
  					<g:if test="${DataTypeEnum.D.equals(metaDataList?.dataType) && 'TO_DATE'.equals(metaDataList?.dataLabel)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<input type="date" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="toDate" disabled="disabled" required="${metaDataList?.nullable}" data-dependent-validation='{"from": "fromDate", "prop": "min"}' max="${new Date().toTimestamp()?.format('yyyy-MM-dd')}"  maxlength="10"/>  						
  					</g:if>
  					
  					<g:if test="${DataTypeEnum.N.equals(metaDataList?.dataType)&& !['NO_OF_LEAVES','AMOUNT','FROM_CHEQUE_NO','TO_CHEQUE_NO','CHEQUE_NO'].contains(metaDataList?.dataLabel)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textField  name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" pattern="[0-9]+" data-errormessage="Please enter numeric values" />  						 
  					</g:if> 
  					
  					<g:if test="${DataTypeEnum.N.equals(metaDataList?.dataType)&&(metaDataList?.dataLabelDescription.equals("Amount"))}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:field type="number" class="s_amt" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" pattern="[0-9]+" min="0"/>  						 
  					</g:if> 
  					
  					<g:if test="${DataTypeEnum.N.equals(metaDataList?.dataType)&&(metaDataList?.dataLabel.equals("NO_OF_LEAVES"))}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:field type="number" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}"  min="1" pattern="[0-9]+"/>  						 
  					</g:if>
  					
  					<g:if test="${DataTypeEnum.V.equals(metaDataList?.dataType) && !["ID_NUMBER","PERSON_NAME"].contains(metaDataList?.dataLabel)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textField name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" maxlength="20"/>  						 
  					</g:if>
  					
  					<g:if test="${DataTypeEnum.L.equals(metaDataList?.dataType) && (ElementTypeEnum.TA.equals(metaDataList?.elementTypeEnum))}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textArea name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" />  						 
  					</g:if>
  					
  					<g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("CURRENCY"))}">
							<p>
								<label for="currencyId">${message(code:'servicerequest.managerscheque.currency.label') }</label>	
								<vayana:tenantOpsCurrencySelect name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}"
									required="${metaDataList?.nullable}" class="cur"   optionKey="code"
									data-errormessage="${message(code:'servicerequest.managerscheque.currency.error.message') }" />
							</p>
					</g:if>
  					<g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("MANAGER_CHEQUE_CURRENCY"))}">
							<p>
								<label for="currencyId">${message(code:'servicerequest.managerscheque.currency.label') }</label>	
								<vayana:tenantBaseCcySelect name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}"
									required="${metaDataList?.nullable}" class="cur"   optionKey="code"
									data-errormessage="${message(code:'servicerequest.managerscheque.currency.error.message') }" />
							</p>
					</g:if>

					   
					<g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("BRANCH"))}">		
						<p>
							<label for="payableBranchId">${message(code:'servicerequest.managerscheque.payablebranch.label') }</label>	
							<vayana:select name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}"  
							optvalue="description" type="BRANCH" findBy="ALL" domain="ib" optionKey="description" required="${metaDataList?.nullable}" data-errormessage="${message(code:'servicerequest.managerscheque.payablebranch.error.message') }" ></vayana:select>						
						</p>	
					</g:if>	
				    <g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType)&&(metaDataList?.tenantLookupType!=null)}">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>							
							<vayana:tenantLookupSelect name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" optionKey="code"  messagePrefix="servicerequest.common" type="${metaDataList?.tenantLookupType?.code}" domain = "tenant" required="${metaDataList?.nullable}" optionValue="description" />
				    </g:if>

					<g:if test="${(DataTypeEnum.L.equals(metaDataList?.dataType)&& ElementTypeEnum.CO.equals(metaDataList?.elementTypeEnum))}">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>							
							<vayana:iblookupSelect name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" optionKey="code"  messagePrefix="servicerequest.common"  type="${metaDataList?.tagLibParameter}" domain = "base" required="${metaDataList?.nullable}" />
					</g:if>
					
					<g:if test="${(DataTypeEnum.L.equals(metaDataList?.dataType) && (ElementTypeEnum.RD.equals(metaDataList?.elementTypeEnum)) &&(metaDataList?.tenantLookupType==null))}">
						<div id="${metaDataList?.id+"-"+metaDataList?.version}" class="dataLabels">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
							<vayana:radioGroup name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" type="${metaDataList?.tagLibParameter}"  domain="base" required="${metaDataList?.nullable}"/>
						</div>
					</g:if> 
					<g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("COUNTRY"))}">		
						<p>
							<label for="countryId">${message(code:'servicerequest.managerscheque.country.label') }</label>	
							<vayana:tenantOpsCountrySelect  name="${metaDataList?.id+'-'+metaDataList?.version}" id="${metaDataList?.id+'-'+metaDataList?.version}"
								required="${metaDataList?.nullable}"  optionKey="code" data-errormessage="${message(code:'servicerequest.managerscheque.country.error.message') }" />
						</p>	
					</g:if>	
					
					<g:if test="${DataTypeEnum.T.equals(metaDataList?.dataType) && (metaDataList?.dataLabel.equals("BRANCH_CODE"))}">		
						<p>
						<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
						<vayana:select name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" type="BRANCH" findBy="ALL" domain="ib"  required="Y" optionKey="description" data-errormessage="${message(code:'servicerequest.managerscheque.country.error.message') }" ></vayana:select>
						</p>	
					</g:if>	
					
					<p>
					 
					 
						<%--<g:if test="${DataTypeEnum.D.equals(metaDataList?.dataType)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<input type="date" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.dataLabel}" min="${new Date(new Date().getTime() + (1000 * 60 * 60 * 24)).toTimestamp()?.format('yyyy-MM-dd')}" required="${metaDataList?.nullable}"  />  						
  						</g:if>
  						
  						
  						<g:if test="${DataTypeEnum.V.equals(metaDataList?.dataType)  && !["ID_NUMBER","PERSON_NAME"].contains(metaDataList?.dataLabel)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textField name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" value="" data-text="${metaDataList?.dataLabelDescription}"  />  						 
  						</g:if>--%>
  						
  						
  						
  						<g:if test="${DataTypeEnum.V.equals(metaDataList?.dataType)  && ("ID_NUMBER").equals(metaDataList?.dataLabel)}">
							<div id="id_numberDiv">
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textField id="id_number" name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" value="" data-text="${metaDataList?.dataLabelDescription}" maxlength="25" pattern="[A-Za-z0-9/-]+"  />
      						</div>  						 
  						</g:if>
  						
  						<g:if test="${DataTypeEnum.V.equals(metaDataList?.dataType)  && ("PERSON_NAME").equals(metaDataList?.dataLabel)}">
						
      							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>
      							<g:textField name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" data-nullable="${metaDataList?.nullable}" value="" data-text="${metaDataList?.dataLabelDescription}" maxlength="25" pattern="[A-Za-z ]+"  />  						 
  						</g:if>
  						
  						
  						<g:if test="${DataTypeEnum.L.equals(metaDataList?.dataType) && metaDataList?.dataLabel.equals("SELF_COL")}">
						<div id="${metaDataList?.id+"-"+metaDataList?.version}" class="dataLabels">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label><%--
							id="${metaDataList?.id+"-"+metaDataList?.version}"
							--%><vayana:radioGroup name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="SELF_COL" type="${metaDataList?.tenantLookupType?.code}" domain="tenant"/>
						</div>
  						</g:if>
  										
  						
  						
  						<g:if test="${(DataTypeEnum.T.equals(metaDataList?.dataType)&&("ID_TYPE").equals(metaDataList?.dataLabel))}">
  							<div id="id_typeDiv">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>							
							<vayana:iblookupSelect name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="id_type" optionKey="code" messagePrefix="servicerequest.common"  type="${metaDataList?.tagLibParameter}" domain = "base" required="${metaDataList?.nullable}" />
							</div>
						</g:if>
						
						
						<g:if test="${(DataTypeEnum.T.equals(metaDataList?.dataType)&&("BRN_NAME").equals(metaDataList?.dataLabel))}">
							<label for="${metaDataList?.id+"-"+metaDataList?.version}">${metaDataList?.dataLabelDescription}</label>							
							<vayana:select name="${metaDataList?.dataOrder+"-"+metaDataList?.id}" id="${metaDataList?.id+"-"+metaDataList?.version}" optvalue="description" type="${metaDataList?.tagLibParameter}" findBy="ALL" domain="ib" required="${metaDataList?.nullable}" optionKey="description" />
						</g:if>
						
  					</p>	
					
					
				</div>
				
</g:each>

<div id="dynamicBranchContent">
</div>

<div class="fields">
			<p>
				<label><input type="checkbox" name="terms" id="terms"
							required="required"
							data-errormessage="You have to agree the terms and conditions to proceed" />
							I agree the <g:remoteLink controller="serviceRequest" action="termsAndConditions"
											update="termsAndConditionsDialog"
											onSuccess="openTermsAndConditionsDialog()">
							${g.message(code:'home.templates.footer.term&conditions.tooltip.text')}
						</g:remoteLink>
							
				</label>
			</p>
		</div>



<br /><br /><br />



<vayana:serviceValidate name="continue" id="continue" value="Continue" buttonEvent="Continue"  controller="serviceRequest"  action="serviceRequestConfirm" secondaryDiv="servicepanel" formName="serviceRequestForm" />
<style>
.input-picker .ws-button-row button.ws-empty {
    background-color: #ed1c24;
    background-image: none;
    border: 1px solid #c61016;
    color: #fff;
    display: none;
}
</style>


	
<div id="termsAndConditionsDialog" title="${g.message(code:'userregistration.templates.secretinfocontent.termsconditions.text')}" style="display:none;" class="body-scroll">  </div>
<script>
function pickUpSuccess(data,textStatus)
{
	 $("#dynamicBranchContent").dynamicfieldupdate();
	 $(".fields").dynamicfieldupdate();
	 $("#continue").removeAttr('disabled');
 
}

function pickFailure(status)
{
	

}

function pickUpFailure(status)
{
	$("#continue").removeAttr('disabled');

}
  
function getBranchMetaData()
{
	return $("#branchMetaDataId").val();    
}


function showChequeNoDiv()
{
	
	$("#ChequeRangeDiv1").hide();
	$("#ChequeRangeDiv2").hide();
	$("#ChequeRangeDiv1Txt").attr("data-nullable","Y")
	$("#ChequeRangeDiv2Txt").attr("data-nullable","Y")
	$("#ChequeNoDiv").show();
	$("#ChequeRangeDiv1Txt").val("0");
	$("#ChequeRangeDiv2Txt").val("0");
	$("#chequeRangeFlag").val("NO");
	
}

function showChequeRangeDiv()
{
	$("#ChequeRangeDiv1").show();
	$("#ChequeRangeDiv2").show();
	$("#ChequeRangeDiv1Txt").val("");
	$("#ChequeRangeDiv2Txt").val("");
	$("#ChequeRangeDiv1Txt").attr("data-nullable","N")
	$("#ChequeRangeDiv2Txt").attr("data-nullable","N")
	$("#ChequeRangeDiv1Txt").dynamicfieldupdate();
	$("#ChequeRangeDiv2Txt").dynamicfieldupdate();  
	$("#ChequeNoDiv").hide();
	$("#ChequeNoDivTxt").val("0");
	$("#chequeRangeFlag").val("YES");

}
function enableToDate(text){
		var value = text
		if(value != null && value != ""){
			 $("#toDate").removeAttr('disabled');  
		}else{
			$("#toDate").val('');
			$("#toDate").attr('disabled','true');
		}
     

}




/*** Terms And Conditions Scripts Starts here ***/
function openTermsAndConditionsDialog() {
	$("#termsAndConditionsDialog").dialog("open");
}


function checkFormValidity(formName) {
	if (!$('form#' + formName).checkValidity()) {
		return true;
	} else {
		return false;
	}

}

/*** Terms And Conditions Scripts Ends here ***/

</script>



