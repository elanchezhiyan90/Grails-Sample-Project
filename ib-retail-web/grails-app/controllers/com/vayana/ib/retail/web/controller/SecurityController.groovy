package com.vayana.ib.retail.web.controller

import com.vayana.bm.core.api.constants.BusinessFunctionConstants;
import com.vayana.bm.core.api.model.enums.SecurityEnum;
import com.vayana.bm.core.api.model.enums.SecurityScopeEnum;
import com.vayana.ib.retail.web.controller.common.GenericController

class SecurityController extends GenericController {
	/**
	 * 
	 * @return
	 */
	def fetchPaymentSecurityAdvice()
	{  
		if(model)  
		{
			def secuirtySettingHolder=model?.securityHolder
	  		
			if(!secuirtySettingHolder?.securitySettings.isEmpty())
			{
				def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
					if(securitySetting.equals(SecurityEnum.TWOFA.toString()))
					{
						chain(action:"showTwoFa",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.TXN.toString()))
					{
						chain(action:"showTxnPwd",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.SQ.toString()))
					{
						chain(action:"showSecretQandA",controller:"security",params:params)
					}
				
			}else
			{  
			 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)	
			}
		}
	}
	
	def fetchSecurityAdviceForAService()
	{
		if(model)  
		{
			def secuirtySettingHolder=model?.securityHolder
			  
			if(!secuirtySettingHolder?.securitySettings.isEmpty())
			{
				def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
					if(securitySetting.equals(SecurityEnum.TWOFA.toString()))
					{
						chain(action:"showTwoFa",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.TXN.toString()))
					{
						chain(action:"showTxnPwd",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.SQ.toString()))
					{
						chain(action:"showSecretQandA",controller:"security",params:params)
					}
				
			}else
			{
			 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)
			}
		}
	}
	
	def fetchSecurityAdviceForAImpsService()
	{
		if(model)
		{
			def secuirtySettingHolder=model?.securityHolder
			  
			if(!secuirtySettingHolder?.securitySettings.isEmpty())
			{
				def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
					if(securitySetting.equals(SecurityEnum.TWOFA.toString()))
					{
						chain(action:"showTwoFaIMPS",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.TXN.toString()))
					{
						chain(action:"showTxnPwd",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.SQ.toString()))
					{
						chain(action:"showSecretQandA",controller:"security",params:params)
					}
				
			}else
			{
			 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)
			}
		}
	}
	
	
	def showTwoFa()
	{
		
			render template:"/common/security/twoFa",model:model;
		
	}
	
	def validateTwoFa()
	{
		if(model)
		{
			def secuirtySettingHolder=model?.securityHolder
			  
			if(!secuirtySettingHolder?.securitySettings.isEmpty())
			{
				def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
					if(securitySetting.equals(SecurityEnum.TXN.toString()))
					{
						chain(action:"showTxnPwd",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.SQ.toString()))
					{
						chain(action:"showSecretQandA",controller:"security",params:params)
					}
				
			}else
			{
			 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)
			}
		}	
	}
	
	def showTxnPwd()
	{
		render template:"/common/security/tranxPassword",model:model;
	}
	
	def validateTxnPwd()
	{
		log.info("--------------------------------------------------------");
		log.info("Controller 	:: 	Security");
		log.info("Action 		:: 	validateTxnPwd");
		if(model)
		{
			def secuirtySettingHolder=model?.securityHolder
			log.info("Security Holder Values :: "+secuirtySettingHolder?.dump());
			if(secuirtySettingHolder != null && BusinessFunctionConstants.PG_PAYMENT.equals(secuirtySettingHolder?.serviceCode) && 0 == secuirtySettingHolder?.MAX_TXN_PWD_ATTEMPTS ){
				log.info("PG Payment -> Transaction Password Maximum Retry Attempts Validations Exceeded !!!")
				model<<[messageType:'failure',errorCode:'transaction.password.max.retry.attempts.exceeded']
				render template:"/billPayment/templates/pg/txnpwdAttemptsFailure",model:model;                    
			}else{
				if(!secuirtySettingHolder?.securitySettings.isEmpty())
				{
					def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
						if(securitySetting.equals(SecurityEnum.TWOFA.toString()))
						{
							chain(action:"showTwoFa",controller:"security",params:params)
							
						}else if(securitySetting.equals(SecurityEnum.SQ.toString()))
						{
							chain(action:"showSecretQandA",controller:"security",params:params)
						}
					
				}else
				{
				 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)
				}
			}
		}
	}
	
	def showSecretQandA()
	{
		render template:"/common/security/secretQandA",model:model;
	}
	
	def validateSecretQandA()
	{
		if(model)
		{
			def secuirtySettingHolder=model?.securityHolder
			  
			if(!secuirtySettingHolder?.securitySettings.isEmpty())
			{
				def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
					if(securitySetting.equals(SecurityEnum.TWOFA.toString()))
					{
						chain(action:"showTwoFa",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.TXN.toString()))
					{
						chain(action:"showTxnPwd",controller:"security",params:params)
						
					}
				
			}else
			{
			 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)
			}
		}
	}
	
	def fetchBillPaymentSecurityAdvice()
	{
		if(model)
		{
			def secuirtySettingHolder=model?.securityHolder
			  
			if(!secuirtySettingHolder?.securitySettings.isEmpty())
			{
				def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
					if(securitySetting.equals(SecurityEnum.TWOFA.toString()))
					{
						chain(action:"showTwoFa",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.TXN.toString()))
					{
						chain(action:"showTxnPwd",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.SQ.toString()))
					{
						chain(action:"showSecretQandA",controller:"security",params:params)
					}
				
			}else
			{
			 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)
			}
		}
	}
	
	def resendOTP(){
		render "ok"
	}
	
	
	
	def fetchSecurityAdviceForAServiceRequest()
	{
		if(model)
		{
			def secuirtySettingHolder=model?.securityHolder
			  
			if(!secuirtySettingHolder?.securitySettings.isEmpty())
			{
				def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
					if(securitySetting.equals(SecurityEnum.TWOFA.toString()))
					{
						chain(action:"showTwoFa",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.TXN.toString()))
					{
						chain(action:"showTxnPwd",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.SQ.toString()))
					{
						chain(action:"showSecretQandA",controller:"security",params:params)
					}
				
			}else
			{
			 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)
			}
		}
	}
	
	def fetchLoanRequestSecurityAdvice()
	{
		if(model)
		{
			def secuirtySettingHolder=model?.securityHolder
			  
			if(!secuirtySettingHolder?.securitySettings.isEmpty())
			{
				def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
					if(securitySetting.equals(SecurityEnum.TWOFA.toString()))
					{
						chain(action:"showTwoFa",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.TXN.toString()))
					{
						chain(action:"showTxnPwd",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.SQ.toString()))
					{
						chain(action:"showSecretQandA",controller:"security",params:params)
					}
				
			}else
			{
			 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)
			}
		}
	}
	
	def fetchIMPSSecurityAdvice()
	{
		if(model)
		{
			def secuirtySettingHolder=model?.securityHolder
			  
			if(!secuirtySettingHolder?.securitySettings.isEmpty())
			{
				def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
					if(securitySetting.equals(SecurityEnum.TWOFA.toString()))
					{
						chain(action:"showTwoFaIMPS",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.TXN.toString()))
					{
						chain(action:"showTxnPwd",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.SQ.toString()))
					{
						chain(action:"showSecretQandA",controller:"security",params:params)
					}
				
			}else
			{
			 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)
			}
		}
	}
	
	def showTwoFaIMPS()
	{	
			render template:"/common/security/twoFaImps",model:model;
		
	}
	def validateTwoFaIMPS()
	{
		if(model)
		{
			def secuirtySettingHolder=model?.securityHolder
			  
			if(!secuirtySettingHolder?.securitySettings.isEmpty())
			{
				def securitySetting=secuirtySettingHolder?.securitySettings?.get(0).toString()
					if(securitySetting.equals(SecurityEnum.TXN.toString()))
					{
						chain(action:"showTxnPwd",controller:"security",params:params)
						
					}else if(securitySetting.equals(SecurityEnum.SQ.toString()))
					{
						chain(action:"showSecretQandA",controller:"security",params:params)
					}
				
			}else
			{
			 chain(action:secuirtySettingHolder?.successAction, controller:secuirtySettingHolder?.successController,params:params,model:model)
			}
		}
	}
}
