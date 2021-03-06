<div class="col-370">
<g:hiddenField name="billerId" value="${postProcessModel?.billerId}" />
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
	<br/><br/>
    
	<div id="dynamicAuthContent">
		<vayana:securitysetting controller="security"
			action="fetchSecurityAdviceForAService" successAction="addWithinBillerConfirm"
			successController="Biller" targetService="BILL_INS" formName="addBillerInstruction" displayAsPopUp="YES"/>
		
		<input type="button" id="cancel" value="cancel" name="cancel" class="cancelForm btn_next"> 	
	</div>
    <br />
	<br />
    <br />

</div>
<script>
$(function(){
var billerId = "${postProcessModel?.billerId}";
$(".cancelForm").on("click",function() {
		$("#servicepanel").empty();
		<g:remoteFunction controller="Biller" action="addInstruction" params="\'billerId=\'+billerId" update="servicepanel"  onSuccess="displayList(data,textStatus);"/>		
	});
});

function displayList(data,textStatus) 
{
	$("#servicepanel").dynamicfieldupdate();
}

function onAuthSuccess(data,textStatus)
{	
	var securityHolderSize = $(data).filter("#securityHolderSize").val();
	if(securityHolderSize!='undefined' && securityHolderSize =='true')
	{
		closeSaveDialogue(data,textStatus);		
	}
}

function closeSaveDialogue(data,textStatus) {
	 $("#billerAccountDetails").html(data);
	 $("#billerAccountDetails").dynamicfieldupdate();	
	 $.fn.ceebox.closebox();
}
</script>
