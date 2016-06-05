<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"> <!--<![endif]-->
<html>
	<head>
		<meta name="layout" content="applayout"/>
		<parameter name="themeName" value="${params.themeName}" />
		<title>Welcome to Grails</title>
	</head>
	<body>
	<div class="body-scroll">
     <section class="col-480">
     <g:set var="accountModel" value = "${actdtlModel.responseBody.casaAccount}"/>
     <h2> KHCB Accounts Details for  ${accountModel.accountNumber} </h2>
      
	<table border="0" cellpadding="0" cellspacing="0"  class="dtl_view">
                                	<tr>
                                    	<td> Nick Name</td>
                                        <td>${accountModel.nickName}</td>
                                    </tr>
                                    <tr>
                                    	<td>Currency</td>
                                        <td>${accountModel.currency}</td>
                                    </tr>
                                    <tr>
                                    	<td>Account Type</td>
                                         <td>${accountModel.accountTypeDescription}</td>
                                    </tr>
                                    <tr>
                                    	<td>Account Status</td>
                                        <td>${accountModel.statusDescription}</td>
                                    </tr>
                                    <tr>
                                    	<td>Nominee Name</td>
                                        <td>Mrs.x</td>
                                    </tr>
                             
                                	<tr>
                                    	<td> Account Open Date</td>
                                        <td>${accountModel.accountOpenDate}</td>
                                    </tr>
                                    <tr>
                                    	<td>Branch</td>
                                    	<td>${accountModel.branch}</td>
                                    </tr>
                                    <tr>
                                    	<td>RM Name</td>
                                       <td>${accountModel.relationShipManager}</td>
                                    </tr>
                                    <tr>
                                    	<td>Funds in Clearing</td>
                                         <td>${accountModel.unclearedFunds}</td>
                                    </tr>
                                    <tr>
                                    	<td>Available Balance</td>
                                        <td>${accountModel.availableBalance}</td>
                                    </tr>
                                </table>
</section >
<aside class="related-nav">
	<h2>Currency Converter</h2>
	<div>
    <form>
    <table border="0" cellpadding="0" cellspacing="0">
    	<tr>
        <td colspan="2">
    	<div class="fields">
			<p>
			<label for="amount">Amount</label>
			<input type="text" name="amount" id="amount" value="1" class="t_amt">
 			</p>
		</div>
        </td>
        </tr>
        <tr>
        <td>
     	<div class="fields">
			<p>
      		<label for="from_cur">From</label>
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
      		<label for="to_cur">To</label>
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
        <input type="button" name="" value="Convert" id="cur_convert" class="btn_next">
        <div class="price"><span >0.1722</span></div>
		</div>
       
       
    </form>
    </div>
    <br> <br>
	<h2> Topics of Interest</h2>
    <nav class="rht_menu">
    	<ul class="ceebox html">
        	<li><a href="">Investment Forums</a></li>
            <li><a href="">News for your bank</a></li>
            <li><a href="">Banking updates</a></li>
            <li><a href="">Changes in tax rates</a></li>
         </ul>
    </nav>
	<g:img dir="themes/default_theme/img/branding" file="car_loan.jpg" width="200" height="220"/>
</aside>
</div>
<g:javascript>
$(document).ready(function () {
		$( "select" ).combobox();
});
</g:javascript>
</body>
</html>
	