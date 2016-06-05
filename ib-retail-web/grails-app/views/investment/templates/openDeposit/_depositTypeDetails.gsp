	<g:hiddenField name="minMonth" id="minMonth" value="${depositDetail?.minimumPeriodMonths}" />
	<g:hiddenField name="maxMonth" id="maxMonth" value="${depositDetail?.maximumPeriodMonths}" />
	<g:hiddenField name="minAmount" id="minAmount" value="${depositDetail?.minumumDepositAmount}" />
	<g:hiddenField name="maxAmount" id="maxAmount" value="${depositDetail?.maximumDepositAmount}" />
	

<p>
<table>
	<%--<tr>
		<td>Min. Tenure:<b>${depositDetail?.minimumPeriodMonths} Months ${depositDetail?.minimumPeriodDays} Days</b></td>
		<td>Max. Tenure:<b>${depositDetail?.maximumPeriodMonths} Months ${depositDetail?.maximumPeriodDays} Days</b></td>
	</tr>
	--%>
	<tr>
		<td>Min. Tenure:<b>${depositDetail?.minimumPeriodMonths} Months </b></td>
		<td>Max. Tenure:<b>${depositDetail?.maximumPeriodMonths} Months </b></td>
	</tr>
	
	<tr>
		<td>Min. Amt:<b>INR ${depositDetail?.minumumDepositAmount}</b></td>
		<td>Max. Amt:<b>INR ${depositDetail?.maximumDepositAmount}</b></td>
	</tr>
</table>
</p>