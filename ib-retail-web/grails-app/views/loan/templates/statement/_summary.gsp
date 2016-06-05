
                <h3>${message(code:'loan.templates.statement.summary.statementsummary.h3.text')}</h3>
                <table border="0" cellpadding="0" cellspacing="0"  class="grid" width="100%" style="border:solid 1px #EEE;">
    			<tr>
                	<td width="25%">${message(code:'loan.templates.statement.summary.accountnumber.label')}</td>
                    <td width="25%">${LoanStatementModel?.statementHeader?.loanAccount?.accountNumber}</td>
                    <td width="25%">${message(code:'loan.templates.statement.summary.loantype.label')}</td>
                    <td width="25%">${LoanStatementModel?.statementHeader?.loanAccount?.acctProduct?.description}</td>
    			</tr>
                <tr>
                	<td>${message(code:'loan.templates.statement.summary.amount.label')}</td>
                    <td class="amt"><vayana:formatAmount currency="${LoanStatementModel?.statementHeader?.loanAccount?.currency?.code}" amount="${LoanStatementModel?.statementHeader?.sanctionedAmount}"/></td>
                    <td>${message(code:'loan.templates.statement.summary.installmentamount.label')}</td>
                    <td>-</td>
                    <td width="1%">&nbsp;</td>
                </tr>
                <tr>
                	<td>${message(code:'loan.templates.statement.summary.rate.label')}</td>
                    <td>${LoanStatementModel?.statementHeader?.interestApplied}</td>
                    <td>${message(code:'loan.templates.statement.summary.outstandingamount.label')}</td>
                    <td>-</td>
                    <td>&nbsp;</td>                    
                </tr>
                <tr>
                	<td>${message(code:'loan.templates.statement.summary.startdate.label')}</td>
                    <td>-</td>
                    <td>${message(code:'loan.templates.statement.summary.tenure.label')}</td>
                    <td>${LoanStatementModel?.statementHeader?.tenure} months</td>
                    <td>&nbsp;</td>                    
                </tr>                                                     
        </table> 
