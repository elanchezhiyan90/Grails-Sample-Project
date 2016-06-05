package com.vayana.ib.retail.web.service

import java.math.BigDecimal;

import org.springframework.ui.ModelMap

import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.constants.LookupCodeConstants;
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailsRequest
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailsResponse
import com.vayana.ib.bm.core.api.beans.goals.UserGoalRequest
import com.vayana.ib.bm.core.api.beans.goals.UserGoalResponse
import com.vayana.ib.bm.core.api.model.enums.SchedulePaymentEnum;
import com.vayana.ib.bm.core.impl.service.util.BaseCommonUtil
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService


class GoalService extends GenericService{
	
	BmClient bmClient;
	BaseCommonUtil baseCommonUtil;
	AccountService accounService;
	

	def goalMaster(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		UserGoalResponse userGoalResponse = bmClient.goalService.getGoalList(userGoalRequest);     
		userGoalResponse?.userOwnGoal?.each{goal->
			params.accountNumber = goal?.toAccountNumber
			print "hi"+params.accountNumber
			String accountNumber =goal?.toAccountNumber
		CasaAccountDetailsRequest casaAccountDetailsRequest = getBean(CasaAccountDetailsRequest.class, requestHeader,params);
		casaAccountDetailsRequest.customerId = requestHeader?.invoker?.primaryCIF
		casaAccountDetailsRequest.accountNumber = accountNumber;
		CasaAccountDetailsResponse casaAccountDetailsResponse = bmClient.accountService.getCasaAccountBalanceInfo(casaAccountDetailsRequest);
			goal.totalPaidAmt = casaAccountDetailsResponse?.accountDetail?.availableBalance
			print "hi"+goal.totalPaidAmt   
			print "Acc"+goal.toAccountNumber
		}
		model <<[goalModel:userGoalResponse.getUserOwnGoal()];
		
		
	}
	
	
	/*def addNewGoal(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		setSessionAttribute("GOALREQUEST", userGoalRequest);
		model << [userGoalRequest:userGoalRequest]		
	}*/
	
	def goalRedeem(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		setSessionAttribute("GOALREQUEST", userGoalRequest);
		userGoalRequest.setGoalId(params.goalId?.toLong())
		model << [goalRedeemModel:params.goalId]
	}
	
	
	
	
	def addNewGoalConfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		setSessionAttribute("GOALREQUEST", userGoalRequest);  
		UserGoalResponse userGoalResponse = bmClient.goalService.prepareConfirmPage(userGoalRequest);
		model << [goalModelconfirm:userGoalResponse,userGoalRequest:userGoalRequest]
	
	}
	
	def saveGoal(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = (UserGoalRequest)getSessionAttribute("GOALREQUEST");    
		userGoalRequest.setPersistEntity("true".toBoolean());
		userGoalRequest.schedulePaymentEnum=params.frequency;
		userGoalRequest.setReferenceTag(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString());
		userGoalRequest.setTenure("292001")
		userGoalRequest.setPageFlag("A")
		userGoalRequest.setAccountType("FD")
		UserGoalResponse userGoalResponse = bmClient.goalService.insertGoal(userGoalRequest);		
		model <<[goalModel:userGoalResponse,userGoalRequest:userGoalRequest];
		}
	
	
	
	def goalEditAction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		userGoalRequest.setGoalId(params.goalId?.toLong())
		UserGoalResponse userGoalResponse = bmClient.goalService.getGoalEditList(userGoalRequest);
		String accountNumber = userGoalResponse?.usergoal?.toAccountNumber
		CasaAccountDetailsRequest casaAccountDetailsRequest = getBean(CasaAccountDetailsRequest.class, requestHeader,params);
		casaAccountDetailsRequest.customerId = requestHeader?.invoker?.primaryCIF
		casaAccountDetailsRequest.accountNumber = accountNumber;
		CasaAccountDetailsResponse casaAccountDetailsResponse = bmClient.accountService.getCasaAccountBalanceInfo(casaAccountDetailsRequest);
			userGoalResponse?.usergoal.totalPaidAmt = casaAccountDetailsResponse?.accountDetail?.availableBalance
		
		model <<[goalEditModel:userGoalResponse.getUsergoal(),isToSupend:userGoalResponse?.isToSuspendOrResume];

		}
	
	def updateownGoal(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = (UserGoalRequest)getSessionAttribute("GOALREQUEST");
		userGoalRequest.setPersistEntity("true".toBoolean());
		//userGoalRequest.setReferenceTag(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString());
		UserGoalResponse userGoalResponse = bmClient.goalService.updateGoal(userGoalRequest);
		//model <<[goalEditModel:userGoalResponse,userGoalRequest:userGoalRequest];
		model <<[goalEditModel:userGoalResponse.usergoal,userGoalRequest:userGoalRequest];
			}
	
	
	
	
	def getAutoPopulateAmount(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);  
		setSessionAttribute("GOALREQUEST", userGoalRequest);
		userGoalRequest.setTargetAmount(params?.targetAmount?.toBigDecimal())
		//userGoalRequest.setStartDate(params?.startDate)
		//userGoalRequest.setTargetDate(params?.targetDate)		
		UserGoalResponse userGoalResponse = null;  
		
		if(!checkBlank(params.targetAmount) && !checkBlank(params.startDate) && !checkBlank(params.targetDate))
		{
		 userGoalResponse = bmClient.goalService.getAutoPopulateAmount(userGoalRequest);
		}
		model << [goalAutoModel:userGoalResponse?.getPopulateAmount()]
	}
	
	def getEditAutoPopulateAmount(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		userGoalRequest.setGoalId(params.goalId?.toLong())
		userGoalRequest.setToAccountNumber(params?.fdAcctNum)
		userGoalRequest.setTotalPaidAmt(params?.totalPaidAmount?.toBigDecimal())
		userGoalRequest.setTargetAmount(params?.targetAmount?.toBigDecimal())
		UserGoalResponse userGoalResponse = null;
		
		userGoalResponse = bmClient.goalService.getEditAutoPopulateAmount(userGoalRequest);
		setSessionAttribute("GOALREQUEST", userGoalRequest);
		model << [goalEditAutoPopulateModel:userGoalResponse?.getEditPopulateAmount()]
	
	}
	
	
	def checkBlank(String value)
	{
		if(value != null && !value.equalsIgnoreCase("") && !value.equalsIgnoreCase("null"))
		{
			return false;
		}
		else
		{
			return true;
		}
		
	}
	
	

	def editconfirmGoal(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		setSessionAttribute("GOALREQUEST", userGoalRequest);
		UserGoalResponse userGoalResponse = bmClient.goalService.prepareConfirmPage(userGoalRequest);
		model << [goalEditModel:userGoalResponse,userGoalRequest:userGoalRequest]
	}

	def goalDetail(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		userGoalRequest.setGoalId(params.goalId?.toLong())
		UserGoalResponse userGoalResponse = bmClient.goalService.getGoalSIList(userGoalRequest);
//		def successPaymentTolal = 0;
//		userGoalResponse?.getPaymentScheduleDetails()?.each{val->
//			if(LookupCodeConstants.SUCCESS.equals(val?.status?.code)) {
//				successPaymentTolal +=val.paymentAmount;
//			}
//		}
			
		model <<[goalSIModel:userGoalResponse.getPaymentScheduleDetails(),goalHeader:userGoalResponse.getUsergoal()];
	}
	
	
	def goalRedeemAction(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		//UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		//setSessionAttribute("GOALREQUEST", userGoalRequest);
		UserGoalRequest userGoalRequest = (UserGoalRequest)getSessionAttribute("GOALREQUEST");
		userGoalRequest.goalId=userGoalRequest.getGoalId().toLong()
		userGoalRequest.setReferenceTag(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString());
		UserGoalResponse userGoalResponse = bmClient.goalService.getGoalEditList(userGoalRequest);
		String accountNumber = userGoalResponse?.usergoal?.toAccountNumber
		CasaAccountDetailsRequest casaAccountDetailsRequest = getBean(CasaAccountDetailsRequest.class, requestHeader,params);
		casaAccountDetailsRequest.customerId = requestHeader?.invoker?.primaryCIF
		casaAccountDetailsRequest.accountNumber = accountNumber;
		CasaAccountDetailsResponse casaAccountDetailsResponse = bmClient.accountService.getCasaAccountBalanceInfo(casaAccountDetailsRequest);
		userGoalResponse?.usergoal.totalPaidAmt = casaAccountDetailsResponse?.accountDetail?.availableBalance
		userGoalRequest.setPayerInstruction(userGoalResponse?.usergoal?.payerInstruction?.accountNumber)
		userGoalRequest.setToAccountNumber(accountNumber)
		userGoalRequest.setContributionAmount(casaAccountDetailsResponse?.accountDetail?.availableBalance)
		UserGoalResponse goalresponse = bmClient.goalService.getRedeemGoal(userGoalRequest);
		model << [goalRedeemModel:userGoalResponse,userGoalRequest:userGoalRequest]		
		
	}
	
	
	
	def deleteGoal(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException
	{
	    UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);    
		String goalId =  params.goalId;
		userGoalRequest.setGoalId(params.goalId?.toLong())
		UserGoalResponse userGoalResponse = bmClient.goalService.deleteGoal(userGoalRequest);
		setMessage(DEFAULT_DELETED_MESSAGE,["Goal",params.goalId+" successfully"], model)
		model <<[goalEditModel:userGoalResponse.getUsergoal()];
	}
	
	def showUserGoalDetails(Map params,GenericRequestHeader requestHeader,ModelMap model)throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params); 
		userGoalRequest.setGoalId(params.processInstanceId?.toLong())
		UserGoalResponse userGoalResponse = bmClient.goalService.getGoalEditList(userGoalRequest);
		model <<[goalModelconfirm:userGoalResponse?.getUsergoal()];
	}

	def updateSharedUserGoalStatus(Map params,GenericRequestHeader requestHeader,ModelMap model)throws Exception{
		UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		userGoalRequest.setGoalId(params.id?.toLong())
		UserGoalResponse userGoalResponse = bmClient.goalService.updateUserGoalDetailStatus(userGoalRequest);
		model <<[goalModelconfirm:userGoalResponse?.getUsergoal()];
	}
	
	 def suspendConfirmGoal(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		 UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		 setSessionAttribute("GOALREQUEST", userGoalRequest);
		 UserGoalResponse userGoalResponse = bmClient.goalService.addConfirmForWorkFlow(userGoalRequest);
		 model << [goalModelconfirm:userGoalResponse,userGoalRequest:userGoalRequest];
	 }
	 def supendGoal(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		 UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		 userGoalRequest.setGoalId(params.goalsuspendId?.toLong())
		 UserGoalResponse userGoalResponse = bmClient.goalService.suspendGoalSchedulePayment(userGoalRequest)
		// model <<[suspendGoalModel:userGoalResponse.getPaymentScheduleDetails()];
		// model <<[goalModel:userGoalResponse,userGoalRequest:userGoalRequest];
		 model <<[goalModel:userGoalResponse.getPaymentScheduleDetails()];		
	 }
	 
	 def resumeConfirmGoal(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		 UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		 setSessionAttribute("GOALREQUEST", userGoalRequest);
		 UserGoalResponse userGoalResponse = bmClient.goalService.addConfirmForWorkFlow(userGoalRequest);
		 model << [goalModelconfirm:userGoalResponse,userGoalRequest:userGoalRequest]
	 }
	 
	 def resumeGoal(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		 UserGoalRequest userGoalRequest = getBean(UserGoalRequest.class,requestHeader, params);
		 userGoalRequest.setGoalId(params.goalresumeId?.toLong())
		 UserGoalResponse userGoalResponse = bmClient.goalService.resumeGoalSchedulePayment(userGoalRequest);
		// model <<[suspendGoalModel:userGoalResponse.getPaymentScheduleDetails()];
		 model <<[goalModel:userGoalResponse,userGoalRequest:userGoalRequest];
		
		
	 }


}