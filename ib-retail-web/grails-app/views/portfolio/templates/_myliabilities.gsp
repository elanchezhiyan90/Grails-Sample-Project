<%--<g:set var="customerLiabilities" value="${portfolioModel?.customerIdentifiers}" />
<g:set var="baseCurrencyLiabilities" value="${commonModel}"/>
--%><div class="folio_col">   

	<div class="dateline">
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
      		<li class="has-dtl"><a href="#">
      			<div class="d_msg"><p class="type">${message(code:'portfolio.templates.myliabilities.creditcards.text') }</p><%--<p>${message(code:'portfolio.templates.myliabilities.cardswithdemobank.text') }</p>--%></div></a>
      			<div class="amt"><span class="cur">${baseCurrencycode}</span><vayana:formatAmount amount="${creditActTotalAmount }" currency="${baseCurrencycode}"/></div>
	  			<div class="view-dtl">
       				<ul>
       				<g:each var="cust" in="${customerIdentifiers}">
       					<g:each var="creditCard" in="${cust?.creditCardAccounts}">
	   						<li class="has-dtl">
	  			 				
       								<div class="d_msg"><p class="type">${creditCard?.accountNumber}</p><p>${creditCard?.accountShortName }</p></div>
	   								<div class="amt"><span class="cur">${creditCard?.currency.code}</span><vayana:formatAmount amount="${creditCard?.outStandingAmount}" currency="${creditCard?.currency.code}"/></div>
	   						</li>
		   				</g:each>
       				</g:each>
	   				</ul>
	   			</div>
	  		 </li>
             <li class="has-dtl"><a href="#">
      			<div class="d_msg"><p class="type">${message(code:'portfolio.templates.myliabilities.loans.text') }</p><%--<p>${message(code:'portfolio.templates.myliabilities.loanswithdemobank.text') }</p>--%></div></a>
      			<div class="amt"><span class="cur">${baseCurrencycode}</span><vayana:formatAmount amount="${loanActTotalAmount }" currency="${baseCurrencycode}"/></div>
	  			<div class="view-dtl">
     				<ul>
				       <g:each var="cust" in="${customerIdentifiers}">
				         <g:each var="loanAccount" in="${cust?.loanAccounts}">
	   						<li class="has-dtl">
							   
						       <div class="d_msg"><p class="type">${loanAccount?.accountNumber}</p><p>${loanAccount?.accountShortName }</p></div>
							   <div class="amt"><span class="cur">${loanAccount?.currency.code}</span><vayana:formatAmount amount="${loanAccount?.principalBalance}" currency="${loanAccount?.currency.code}"/></div>
	   						</li>
					   	 </g:each>
					   </g:each>
	   
     				</ul>
      			</div>
     		</li>
 		</ul>
	</div>
</div>

