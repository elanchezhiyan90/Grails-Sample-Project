<div  class="folio_col">
		   
  <div class="dateline">
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
        <li class="has-dtl"><a href="#">
             <div class="d_msg"><p class="type">${message(code:'portfolio.templates.myassets.bankaccounts.text') }</p><%--<p>${message(code:'portfolio.templates.myassets.accountswithdemobank.text') }</p>--%></div></a>
             <div class="amt"><span class="cur">${baseCurrencycode}</span><vayana:formatAmount amount="${casaActTotalAmount}" currency="${baseCurrencycode}"/></div>
        <div class="view-dtl">
         <ul>
           <g:each var="cust" in="${customerIdentifiers}">
		      <g:each var="casaAccount" in="${cust?.casaAccounts}" >
	   		     <li class="has-dtl">
	   			    <div class="d_msg"><p class="type">${casaAccount?.accountShortName}</p><p>${casaAccount?.accountNumber}</p></div>
	  			    <div class="amt"><span class="cur">${casaAccount?.currency?.code}</span><vayana:formatAmount amount="${casaAccount?.availableBalance}" currency="${casaAccount?.currency?.code}"/></div>
	   		      </li>
	   	       </g:each>
	        </g:each>
	    </ul>
        </div>
  	   </li>
  		<li class="has-dtl">
  			<a href="#">
              <div class="d_msg"><p class="type">Deposit</p><%--<p>Time Deposits</p>--%></div></a>
              	<div class="amt"><span class="cur">${baseCurrencycode}</span><vayana:formatAmount amount="${investmentActTotalAmount }" currency="${baseCurrencycode}"/></div>

     		<div class="view-dtl">
       		<ul>
		       	  <g:each var="cust" in="${customerIdentifiers}">
					<g:each var="investmentAccount" in="${cust?.investmentAccounts}" >
			   		<li class="has-dtl">
			   			
		       				<div class="d_msg"><p class="type">${investmentAccount?.accountShortName}</p><p>${investmentAccount?.accountNumber}</p></div>
			   				<div class="amt"><span class="cur">${investmentAccount?.currency?.code}</span><vayana:formatAmount amount="${investmentAccount?.availableBalance}" currency="${investmentAccount?.currency?.code}"/></div>
			   
			   		</li>
			   		</g:each>
			   	 </g:each>
	   		</ul>
     		</div>
  		</li>	  
	  
    </ul>
   </div>
</div>

