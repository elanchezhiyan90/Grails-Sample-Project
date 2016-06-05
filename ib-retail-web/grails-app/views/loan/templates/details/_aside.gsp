<aside class="related-nav">
	<h2>${message(code:'loan.templates.details.aside.currencyconverter.h2.text')}</h2>
	<div>
    <form>
    <table border="0" cellpadding="0" cellspacing="0">
    	<tr>
        <td colspan="2">
    	<div class="fields">
			<p>
			<label for="amount">${message(code:'loan.templates.details.aside.amount.label')}</label>
			<input type="number"  step="any" name="amount" id="amount" class="s_amt"  min="1" class="t_amt">
 			</p>
		</div>
        </td>
        </tr>
        <tr>
        <td>
     	<div class="fields">
			<p>
      		<label for="from_cur">${message(code:'loan.templates.details.aside.from.label')}</label>
     		<select  name="from_cur" id="from_cur" class="cur">
                <option>USD</option>
                <option>AED</option>
             </select>
            </p>
        </div>
        </td>
        <td>
        <div class="fields">
			<p>
      		<label for="to_cur">${message(code:'loan.templates.details.aside.to.label')}</label>
     		<select  name="to_cur" id="to_cur" class="cur">
                <option>AED</option>
                <option>USD</option>
             </select>
  			</p>
        </div>
        </td>
        </tr>
        </table>
          <div class="buttons" >
        <input type="button" name="" value="${message(code:'loan.templates.details.aside.convert.button.text')}" id="cur_convert" class="btn_next">
        <div class="price"><span >0.1722</span></div>
		</div>
       
       
    </form>
    </div>
    <br> <br>
	<h2> ${message(code:'loan.templates.details.aside.topicsofinterest.h2.text')}</h2>
    <nav class="rht_menu">
    	<ul class="ceebox html">
        	<li><a href="">${message(code:'loan.templates.details.aside.investmentforums.text')}</a></li>
            <li><a href="">${message(code:'loan.templates.details.aside.newsforyourbank.text')}</a></li>
            <li><a href="">${message(code:'loan.templates.details.aside.bankingupdates.text')}</a></li>
            <li><a href="">${message(code:'loan.templates.details.aside.changesintaxrates.text')}</a></li>
         </ul>
    </nav>
	<g:img  dir="/themes/default_theme/img/branding" file="car_loan.jpg" width="200" height="220"/>
</aside>