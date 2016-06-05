<g:set var="customerIdentifiers" value="${portfolioModel?.customerIdentifiers}"/>
<g:set var="creditActTotalAmount" value="${tempCalcModel?.totalCreditCardAccountBal}"/>
<g:set var="casaActTotalAmount" value="${tempCalcModel?.totalCasaAccountBal}" />
<g:set var="loanActTotalAmount" value="${tempCalcModel?.totalLoanAccountBal}"/>
<g:set var="liabilitiesPercent" value="${tempCalcModel?.liabilitiesPercent}" />
<g:set var="investmentActTotalAmount" value="${tempCalcModel?.totalInvestmentAccountBal}" />
<g:set var="assetPercent" value="${tempCalcModel?.assetPercent}" />
<g:set var="casaPercent" value="${tempCalcModel?.casaPercent}" />
<g:set var="depositPercent" value="${tempCalcModel?.depositPercent}" />
<g:set var="creditCardPercent" value="${tempCalcModel?.creditCardPercent}" />
<g:set var="loanPercent" value="${tempCalcModel?.loanPercent}" />
<g:set var="baseCurrencycode" value="${baseCurrencyModel?.code}"/>
<g:set var="totalAssets" value="${casaActTotalAmount + investmentActTotalAmount}"/>
<g:set var="totalLiabilities" value="${creditActTotalAmount+loanActTotalAmount}"/>
<g:hiddenField id="currentCurCode" name="currentCurCode" value="${baseCurrencycode}"/>
	
<div class="stream" id="streamId">
			 	<p>
			 		<g:render template="templates/myassets" ></g:render>
			 		<g:render template="templates/myliabilities"></g:render>
			 	</p>
		</div>
<div class="graph" id="graphId" style="display:none;" >

				<p>		
						<g:render template="templates/assetsgraph" ></g:render>
						<g:render template="templates/liabilitiesgraph" ></g:render>
			 	</p>
			 	
<div id="totalNetWorth">
	<p>
		<g:render template="templates/totalNetWorth" ></g:render>
	</p>
</div>
</div>
<script >

function graphDraw(){
	var optionsAssets=null;
	var optionsLiabilities=null;
	var data={"TotalAssets":[{"AssetName":"Bank Accounts","AssetValue":'${casaActTotalAmount}',"AssetValuePercentage":'${casaPercent}',"AssetCurrency":'${baseCurrencycode}'},{"AssetName":"Deposits","AssetValue":'${investmentActTotalAmount}',"AssetValuePercentage":'${depositPercent}',"AssetCurrency":'${baseCurrencycode}'}],"TotalAssetsValue":'${casaActTotalAmount+investmentActTotalAmount}',"TotalLiabilities":[{"LiabilityName":"Credit Cards","LiabilityValue":'${creditActTotalAmount}',"LiabilityValuePercentage":'${creditCardPercent}',"LiabilityCurrency":'${baseCurrencycode}'},{"LiabilityName":"Loans","LiabilityValue":'${loanActTotalAmount}',"LiabilityValuePercentage":'${loanPercent}',"LiabilityCurrency":'${baseCurrencycode}'}],"TotalLiabilitiesValue":'${loanActTotalAmount+creditActTotalAmount}',"TotalNetWorth":"-56162.417499999996"}
    var pieChartAssetsData = [];	
	$.each(data.TotalAssets, function (entryindex, entry) {
				pieChartAssetsData.push([entry['AssetName']+" - "+entry['AssetCurrency']+" "+entry['AssetValue'], parseFloat(entry['AssetValuePercentage'])]);
				});
				
	var pieChartLiabilitiesData = [];	
	$.each(data.TotalLiabilities, function (entryindex, entry) {				
				pieChartLiabilitiesData.push([entry['LiabilityName']+" - "+entry['LiabilityCurrency']+" "+entry['LiabilityValue'], parseFloat(entry['LiabilityValuePercentage'])]);
			});
			
 	 optionsAssets = { 
  	   title:'My Assets',
  	 seriesColors: [ "#00A9DA","#419B0F"],
  	  	   grid: {
         drawBorder: false,
         drawGridlines: false,
         background: '#ffffff',
         shadow:false
       },
       seriesDefaults:{
       renderer: jQuery.jqplot.PieRenderer, 
     	rendererOptions: {
     					
						  showDataLabels: true,
						  dataLabels: 'percent',
						 dataLabelFormatString:'%#.2f%%',
						  fill: true,
						//  diameter: 200,
						  lineWidth: 5,
						  startAngle: 270
						}
      				  }, 
       legend: { show: true,
            	 rendererOptions: {
                					numberRows: 2
            					  },
            	 location: 's' 
               }
    	};
 
 $.jqplot ('pieChartAssetsChartDivId', [pieChartAssetsData],optionsAssets); 
 
 optionsLiabilities ={
					  title: 'My Liabilities',
					  seriesColors: [ "#00A9DA","#419B0F" ],
					  grid: {
					         drawBorder: false,
					         drawGridlines: false,
					         background: '#ffffff',
					         shadow:false
					       },
					  seriesDefaults: {
						renderer: jQuery.jqplot.PieRenderer,
						rendererOptions: {
						  showDataLabels: true,
						  dataLabels: 'percent',
						  dataLabelFormatString:'%#.2f%%',
						  fill: true,
						//  diameter: 200,
						  lineWidth: 5,
						  //sliceMargin: 4,
						  startAngle: 270
						}
					  },
					  legend: { show: true,
            					rendererOptions: {
                									numberRows: 2
            									 },
            					location: 's'
            				  }
				  };
	$.jqplot('pieChartLiabilitiesChartDivId', [pieChartLiabilitiesData], optionsLiabilities);
				
		
}
</script>
