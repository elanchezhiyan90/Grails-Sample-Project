package com.vayana.ib.retail.web.service.common

import com.vayana.bm.core.api.service.IWorkflowService
import com.vayana.bm.core.api.service.UserService
import com.vayana.ib.bm.core.api.service.AccountService
import com.vayana.ib.bm.core.api.service.ApplyLoanService
import com.vayana.ib.bm.core.api.service.BeneficiaryService
import com.vayana.ib.bm.core.api.service.BillPaymentService
import com.vayana.ib.bm.core.api.service.BillerService
import com.vayana.ib.bm.core.api.service.BulkPaymentService
import com.vayana.ib.bm.core.api.service.CreditCardService
import com.vayana.ib.bm.core.api.service.IBCommonService
import com.vayana.ib.bm.core.api.service.IBUserService
import com.vayana.ib.bm.core.api.service.InvestmentService
import com.vayana.ib.bm.core.api.service.LoanService
import com.vayana.ib.bm.core.api.service.MessageCenterService
import com.vayana.ib.bm.core.api.service.NotificationService
import com.vayana.ib.bm.core.api.service.PaymentService
import com.vayana.ib.bm.core.api.service.PortfolioService
import com.vayana.ib.bm.core.api.service.PrepaidCardService
import com.vayana.ib.bm.core.api.service.ReminderService
import com.vayana.ib.bm.core.api.service.ServiceRequestService
import com.vayana.ib.bm.core.api.service.TwoFactorService
import com.vayana.ib.bm.core.api.service.GoalService
//import com.vayana.ib.retail.web.service.ApplyCreditCardService

class BmClient {
	UserService userService;
	BeneficiaryService beneficiaryService;
	AccountService accountService;
	PaymentService paymentService;
	CreditCardService creditCardService;
	LoanService loanService; 
	InvestmentService investmentService;
	ServiceRequestService serviceRequestService; 
	BillerService billerService;
	IWorkflowService workflowService
	IBCommonService iBCommonService;
	IBUserService iBUserService;
	BillPaymentService billPaymentService;
	TwoFactorService twoFactorService;
	PortfolioService portfolioService;
	ReminderService reminderService;
	MessageCenterService messageCenterService;
	PrepaidCardService prepaidCardService;
	//ApplyCreditCardService applyCreditCardService
	ApplyLoanService applyLoanService;
	NotificationService notificationService;
	GoalService goalService;
	BulkPaymentService bulkPaymentService;
}