<div class="col-370">
<g:form name="addBillerInstructionConfirm">
	<ul class="payment_dtls">
    	 <li><p class="hdr">${message(code:'biller.addbiller.billerconfirmation.label') }</p></li>
        <li>
        	<div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${message(code:'biller.addbiller.billercategory.label') }</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.billerCategoryDes}</p>
                </div>
            </div>



            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${message(code:'biller.addbiller.billercompany.label') }</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.billerName}</p>
                </div>
            </div>

			<div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${message(code:'biller.addbiller.billerservice.label') }</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.billerServiceDes}</p>
                </div>
            </div>
			
			<g:each in="${postProcessMetaModel}" var="dataList"> 
            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${message(code: 'biller.addbiller.billernumber.label'+dataList?.key)}</p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${dataList?.value}</p>
                </div>
            </div>
			</g:each>

            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${message(code:'biller.addbiller.nickname.label') } </p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.billerNickName}</p>
                </div>
            </div>

			<g:if test="${postProcessModel?.autoPayFlag.equals("Y")}">
			<div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${message(code:'biller.templates.addbiller.autopayfields.accounttodebit.label') } </p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.debitAcc}</p>
                </div>
            </div>
            
            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Amount to Debit </p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <g:if test="${postProcessModel?.autoPay.equals("F")}">
                    <p>${message(code:'biller.templates.addbiller.autopayfields.amounttodebit.fullamount.label') }</p>
                    </g:if><g:else>
                    <p>${message(code:'biller.templates.addbiller.autopayfields.amounttodebit.minimumamount.label') }</p>
                    </g:else>
                </div>
            </div>
            
            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>Currency &amp; MaximumAmount </p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.transferCurrency} ${postProcessModel?.maximumAmount}</p>
                </div>
            </div>
            
            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${message(code:'biller.templates.addbiller.autopayfields.fromdate.label') } </p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.fromDate}</p>
                </div>
            </div>
            
            <div class="dtl_wralp">
                <div class="lft_dtl">
                    <p>&nbsp;</p>
                    <p>${message(code:'biller.templates.addbiller.autopayfields.todate.label') } </p>
                </div>
                <div class="rht_dtl">
                    <p>&nbsp;</p>
                    <p>${postProcessModel?.toDate}</p>
                </div>
            </div>
			
			</g:if>
           

        </li>

    </ul>
	<br/><br/><%--
    <div class="info">
    	<p><span></span><strong>Terms and Condition</strong></p>
    	<p>Terms and condition will come here</p>
    </div>
    --%>
    <%--<p><label><input type="checkbox" name="terms" id="terms"  required="required" data-errormessage="You have to agree the terms and condition to proceed"/> I agree the above terms and conditions</label></p><br/>
	--%>
	<div id="dynamicAuthContent">
					<vayana:securitysetting controller="security"
						action="fetchSecurityAdviceForAService" successAction="addBillerConfirm"
						successController="Biller" targetService="BILL_INS" formName="addBillerInstructionConfirm"/>
					
					<input type="button" value="Cancel" class="btn_next" id="canceltrans"  onclick="postUrl('frmBiller','/ib-retail-web/biller/${postProcessModel?.cancelAction}','canvas');" />	
				</div>
    <br />
	<br />
    <br />
</g:form>
</div>