<div  class="folio_col">
	<div class="dateline" style="display:block;" >
  		<ul>
	       <li class="today">
      			<a href="#">
	      			<div class="d_msg">
	      				<p class="type">${message(code:'portfolio.templates.myliabilities.myliabilities.text') }</p>
	      				<p>${message(code:'portfolio.templates.myliabilities.liabilitiesdetails.text') }</p>
	      			</div>
	      		</a>
			      <div class="amt"><span class="cur">${baseCurrencycode}</span>
			      	<vayana:formatAmount amount="${(creditActTotalAmount+loanActTotalAmount) }" currency="${baseCurrencycode}"/><span class="cur">[${liabilitiesPercent}%]</span>
			      </div>
      		</li>
      	</ul>
      </div>
      <div id="pieChartLiabilitiesChartDivId" style="width:480px;height:420px"></div>
</div>
