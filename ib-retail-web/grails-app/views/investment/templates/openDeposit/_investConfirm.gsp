<%@ page import="com.vayana.ib.bm.core.api.model.enums.PaymentButtonEnum"%>
<%@page import="com.vayana.bm.core.api.model.enums.YesNoEnum"%>
 <div class="print_header">
 <img src="/ib-retail-web/themes/pmcb_theme/img/branding/logo.png" alt="" width="175" height="59" />   
 </div>

		
<h2>
	${(PaymentButtonEnum.PAYNOW.toString().equals(buttonTypeModel)) ? 'Invest Now' : (PaymentButtonEnum.LATER.toString().equals(buttonTypeModel)) ? 'Invest Later' : 'Recurring'}
</h2>
<p>
</p>

<g:form name="depositOpenConfirm">
	<ul class="payment_dtls confirm">
		<li><p class="hdr">Deposit Account Opening Confirmation</p></li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Customer Name</p>
				</div>
				<div class="rht_dtl">
					<p>
					
						${depositServiceResponseModel?.ibUserLoginProfile?.userProfile?.firstName}
					</p>
				</div>
			</div>
		</li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Mode of Operation</p>
						
			
				</div>
				<div class="rht_dtl">
					<p>
						Self
						
					</p>
				</div>
			</div>
		</li>
		
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Debit From</p>
				</div>
				<div class="rht_dtl">
					<p>
						${depositServiceResponseModel?.payerInstruction?.accountNumber}
					
					</p>
				</div>
			</div>
		</li><%--
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>&nbsp;</p>
					<p>Branch Type</p>
				</div>
				<div class="rht_dtl">
					<p>&nbsp;</p>
					<p>
						${depositServiceResponseModel?.branchType}
					</p>
				</div>
			</div>
		</li>
		--%><li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Branch</p>
				</div>
				<div class="rht_dtl">
					<p>
						${depositServiceResponseModel?.tenantBranch?.description}
					</p>
				</div>
			</div>
		</li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Deposit Type</p>
				</div>
				<div class="rht_dtl">
					<p>
						${depositServiceResponseModel?.depositType?.description}
					</p>
				</div>
			</div>
		</li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Currency</p>
				</div>
				<div class="rht_dtl">
					<p>
						${depositServiceResponseModel?.currency?.code}
					</p>
				</div>
			</div>
		</li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p> Amount</p>
				</div>
				<div class="rht_dtl">
					<p>
						${depositServiceResponseModel?.amount}
					</p>
				</div>
			</div>
		</li>
		
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Interest Amount</p>
				</div>
				<div class="rht_dtl">
					<p>
						${depositServiceResponsenewModel?.interestAmt}
					</p>
				</div>
			</div>
		</li>
		
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Maturity Amount</p>
				</div>
				<div class="rht_dtl">
					<p>
						${depositServiceResponsenewModel?.maturityAmt}
					</p>
				</div>
			</div>
		</li>
		
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Month</p>
				</div>
				<div class="rht_dtl">
					<p>
						${depositServiceResponseModel?.months}
					</p>
				</div>
			</div>
		</li>

		<%--<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>&nbsp;</p>
					<p>Days</p>
				</div>
				<div class="rht_dtl">
					<p>&nbsp;</p>
					<p>
						${depositServiceResponseModel?.days}
					</p>
				</div>
			</div>
		</li>
		--%><%--        <li>--%>
		<%--    	<div class="dtl_wralp">--%>
		<%--    	 		<div class="lft_dtl">--%>
		<%--                    <p>&nbsp;</p>--%>
		<%--                    <p>Tenure</p>--%>
		<%--                </div>--%>
		<%--                <div class="rht_dtl">--%>
		<%--                    <p>&nbsp;</p>--%>
		<%--                    <p>${depositServiceResponseModel?.depositTenure?.tenure}</p>--%>
		<%--                </div>--%>
		<%--          </div>--%>
		<%--          </li>--%>
		<%--          --%>

		<%--<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>&nbsp;</p>
					<p>Investment Type</p>
				</div>
				<div class="rht_dtl">
					<p>&nbsp;</p>

					<p>
						${depositServiceResponseModel?.maturityId?.description}
					</p>
				</div>
			</div>
		</li>


		--%>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Maturity Instruction</p>
				</div>
				<div class="rht_dtl">
					<p>
						${depositServiceResponseModel?.maturityInstruction?.description}
					</p>
				</div>
			</div>
		</li>
		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					
					<p>Principal & Interest Credit A/c No.</p>
				</div>
				<div class="rht_dtl">
					
					<p>
						${depositServiceResponseModel?.settlementAccount1?.accountNumber}
					</p>
				</div>
			</div>
		</li>

		<li>
			<div class="dtl_wralp">
				<div class="lft_dtl">
					<p>Nomination Facility</p>
				</div>
				<div class="rht_dtl">
					<g:if
						test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
						<p>Yes</p>
					</g:if>
					<g:if
						test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.N)}">
						<p>No</p>
					</g:if>

				</div>
			</div>
		</li>
		<%--<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>Nominee Name</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.nomineeeName}
						</p>
					</div>
				</div>
			</li>
		</g:if>
		<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>Address of Nominee</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.nomineeContactId?.streetAddress1}
						</p>
					</div>
				</div>
			</li>
		</g:if>
		<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>Address of Nominee</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.nomineeContactId?.streetAddress2}
						</p>
					</div>
				</div>
			</li>
		</g:if>
		<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>Address of Nominee</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.nomineeContactId?.streetAddress3}
						</p>
					</div>
				</div>
			</li>
		</g:if>
		<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>City</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.nomineeContactId?.city?.description}
						</p>
					</div>
				</div>
			</li>
		</g:if>
			<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>State</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.nomineeContactId?.state?.description}
						</p>
					</div>
				</div>
			</li>
		</g:if>
		<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>Country</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.nomineeContactId?.country?.description}
						</p>
					</div>
				</div>
			</li>
		</g:if>
		<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>Pincode</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.nomineeContactId?.pincode}
						</p>
					</div>
				</div>
			</li>
		</g:if>
	   <g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>Relationship with Depositor</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.nomineeRelationship?.description}
						</p>
					</div>
				</div>
			</li>
		</g:if>
		
		<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			
			<g:if test="${depositServiceResponseModel?.panNumber}">
			<li>			
			<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>PAN Card number</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
				
							${depositServiceResponseModel?.panNumber}
							</p>
				</div>
				</div>
			</li>		
			</g:if>		
			
				
		</g:if>
		<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<g:if test="${depositServiceResponseModel?.nomineeDOB}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>DOB of Nominee </p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.nomineeDOB?.format("dd-MMM-yyyy")}
						</p>
					</div>
				</div>
			</li>
		</g:if>
		</g:if>
		
		<g:if
			test="${depositServiceResponseModel?.nomineeRequiredType.equals(YesNoEnum.Y)}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>Nominee is Minor </p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<g:if
						test="${depositServiceResponseModel?.nomineeminor.equals(YesNoEnum.Y)}">
						<p>Yes</p>
					</g:if>
					<g:if
						test="${depositServiceResponseModel?.nomineeminor.equals(YesNoEnum.N)}">
						<p>No</p>
					</g:if>
					</div>
				</div>
			</li>
		</g:if>
		
		 <g:if
			test="${depositServiceResponseModel?.nomineeminor.equals(YesNoEnum.Y)}">
			<g:if test="${depositServiceResponseModel?.guardianName}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>Name of guardian</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.guardianName}
						</p>
					</div>
				</div>
			</li>
		</g:if>
		</g:if>
		
		<g:if
			test="${depositServiceResponseModel?.nomineeminor.equals(YesNoEnum.Y)}">
			<g:if test="${depositServiceResponseModel?.interestPayableFreq?.description}">
			<li>
				<div class="dtl_wralp">
					<div class="lft_dtl">
						<p>&nbsp;</p>
						<p>Relationship with nominee</p>
					</div>
					<div class="rht_dtl">
						<p>&nbsp;</p>
						<p>
							${depositServiceResponseModel?.interestPayableFreq?.description}
						</p>
					</div>
				</div>
			</li>
		</g:if>
		</g:if>
		--%></ul>
		
	<br />


	<div id="dynamicAuthContent">
		<vayana:securitysetting controller="security"
			action="fetchSecurityAdviceForAService"
			successAction="insertOpenNewDeposit" successController="investment"
			targetService="INVSTADD" formName="depositOpenConfirm" />
			<input type="button" value="Cancel" class="btn_next" id="canceltrans"  onclick="postUrl('depositOpenConfirm','/ib-retail-web/investment/addDepositAccount','canvas');closefolder();" />
			
	</div>
	

</g:form>

<script>
$(document).bind("keypress", function (e) {
    if (e.keyCode == 13) {
        $('#tranXConfirm').trigger("click");
        return false;
    }
});

  
 function displayList(data,textStatus)
{
	$("#ftpanel").dynamicfieldupdate();
	$(".fields").dynamicfieldupdate();
	fpanel();	
}   
</script>