 <div  class="folio_col">
  <div class="dateline" style="display:block;">
     <ul>
       <li class="today">
           <a href="#">
           			<div class="d_msg">
           			<p class="type">${message(code:'portfolio.templates.myassets.myassets.text') }</p>
                 	<p>${message(code:'portfolio.templates.myassets.assetsdetails.text') }</p>
               		</div>
            </a>
            <div class="amt"><span class="cur">${baseCurrencycode} </span>
            		<vayana:formatAmount amount="${(casaActTotalAmount + investmentActTotalAmount)}" currency="${baseCurrencycode}"/><span class="cur">[${assetPercent}%]</span>
            </div>
              
        </li>
    </ul>
   </div>
   <div id="pieChartAssetsChartDivId" style="width:480px; height:420px" > </div>
</div>





