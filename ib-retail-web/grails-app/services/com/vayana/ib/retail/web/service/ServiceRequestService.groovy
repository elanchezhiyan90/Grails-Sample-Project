package com.vayana.ib.retail.web.service

import java.util.Map;

import org.springframework.ui.ModelMap

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.ContextCodeType
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.bm.core.api.exception.code.ErrorCodeConstants
import com.vayana.ib.bm.core.api.beans.exchangerate.ExchangeRateRequest
import com.vayana.ib.bm.core.api.beans.exchangerate.ExchangeRateResponse
import com.vayana.ib.bm.core.api.beans.security.SecurityHolder
import com.vayana.ib.bm.core.api.beans.servicerequest.GenericSRRequest
import com.vayana.ib.bm.core.api.beans.servicerequest.GenericSRResponse
import com.vayana.ib.bm.core.api.model.enums.SRServiceRequestTypeEnum
import com.vayana.ib.bm.core.api.model.servicerequest.ServiceRequestInstruction;
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService
//import com.vayana.ib.bm.core.api.beans.common.BankTariffResponse
//import com.vayana.ib.bm.core.api.beans.common.BankTariffRequest

class ServiceRequestService extends GenericService{
	
	BmClient bmClient;
	CommonService commonService;
	
	def serviceRequestMetaData(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		
			GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);
			genericSRRequest.requestHeader=requestHeader
          	GenericSRResponse genericSRResponse=bmClient.serviceRequestService.fetchSRMetaDataForAService(genericSRRequest)
			if(genericSRResponse.hasErrors()){
				model<<[errors:genericSRResponse.errors()]                                    
			}else{  
				model<<[genericSRModel:genericSRResponse]    
			}
		
	}
	def showSRDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		CommonRequest commonRequest 			= new CommonRequest();
		commonRequest.setRequestHeader(requestHeader);
		List<Object> filterParams 				= new ArrayList<Object>();
		filterParams.add(params.transactionIdentifier);
		commonRequest.setCommonEntityId(params.taskInstanceId?.toLong());
		commonRequest.setFilterParams(filterParams);
		CommonResponse commonResponse     				= 	bmClient.iBCommonService.getDateLineEventDetails(commonRequest);
		if(commonResponse.hasErrors())
		{
			model<<[errors:commonResponse.errors()]
		}
		if ("SR".equals(params.transactionIdentifier)) {
			ServiceRequestInstruction serviceRequestInstruction	=	(ServiceRequestInstruction)commonResponse.getCommonEntity();
			model<<[resp:["serviceRequestDatas":serviceRequestInstruction.getServiceRequestDatas(),"serviceRequestInstruction":serviceRequestInstruction]]
		}
		
	}
	def cancelServiceRequest(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		
			GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);        
			GenericSRResponse genericSRResponse=bmClient.serviceRequestService.fetchSRMetaDataForAService(genericSRRequest)
			if(genericSRResponse.hasErrors()){  
				model<<[errors:genericSRResponse.errors()]
			}else{
				model<<[genericSRModel:genericSRResponse]
			}
		
		}
		
		def serviceRequestConfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{		     	
				GenericSRRequest serviceRequest = getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);                   
				TreeMap<String, String> metaDataRequestMap=[:]      
				params.each {
						if(it?.key=~/-/)  
						{
						 metaDataRequestMap.put(it?.key, it?.value)   
						}     
				}  
			    serviceRequest.setMetaDataRequest(metaDataRequestMap);            
				serviceRequest.setPersistEntity(false);
				GenericSRResponse serviceResponse = bmClient.serviceRequestService.insertServiceRequest(serviceRequest);
				
				// Added newly for SME Check
				GenericSRRequest serviceRequest1 = getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);
				serviceRequest1.setMetaDataRequest(new TreeMap<String, String>(metaDataRequestMap));            
				serviceRequest1.setPersistEntity(false);
				serviceRequest1.setServiceRequestDatas(serviceResponse.getServiceRequestDatas());
				serviceRequest1.setServiceRequestInstructionId(serviceRequest.getServiceRequestInstructionId());
				serviceRequest1.setTenantServiceId(serviceRequest.getTenantServiceId());
				serviceRequest1.setTenantServiceDescription(serviceRequest.getTenantServiceDescription());
				GenericSRResponse serviceResponse1  = bmClient.serviceRequestService.checkForJointAuthServiceRequestValidation(serviceRequest1);
				serviceRequest.setIsAuthMatrixConfigured(serviceResponse1.getIsAuthMatrixConfigured());
				
				if(serviceResponse.hasErrors()){
					model<<[errors:serviceResponse.errors()]  
				}else{      
				setSessionAttribute("GSRR", serviceRequest);          
					model<<[ResponseModel:serviceResponse]      
				}   		
		  }
		
		
	def insertServicerequest(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{	
		
		SecurityHolder securityHolder=(SecurityHolder)getSessionAttribute("SECHOLD") 
		if(securityHolder.isValidated){
			GenericSRResponse serviceResponse =null;
			GenericSRRequest genericSRRequest=(GenericSRRequest)getSessionAttribute("GSRR")
			genericSRRequest.setInitiatedDate(new Date());
			if(genericSRRequest?.referenceNo == null || genericSRRequest?.referenceNo == ""){ 
				genericSRRequest.setReferenceNo(new Long(java.nio.ByteBuffer.wrap(UUID.randomUUID().toString().getBytes()).getLong()).toString());
			}
			log.info("insertServicerequest :: Reference Tag :: "+genericSRRequest?.referenceNo);
			genericSRRequest.setPersistEntity(true);    
			genericSRRequest.setCifNumber(genericSRRequest.getRequestHeader().getInvoker().getPrimaryCIF());        
			String tenantServiceCode = genericSRRequest.tenantServiceCode;
			String methodName = SRServiceRequestTypeEnum.valueOf(tenantServiceCode).getKey()   
			GenericSRRequest[] gsrr = new GenericSRRequest[1];
			gsrr[0] = genericSRRequest; 
			serviceResponse = bmClient.serviceRequestService.invokeMethod(methodName, gsrr[0])    
			if(serviceResponse.hasErrors()){
				model<<[errors:serviceResponse.errors()]             
			}
			else{	  		
				model<<[ResponseModel1:genericSRRequest,ResponseModel:serviceResponse]                                    
			}
			}
		else{
			throw new BusinessException(ContextCodeType.CORE, ErrorCodeConstants.UNSUPPORTED_OPERATION, "Security Breach", null)
		}
		}
		
	def transactiontoEmi(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);
		GenericSRResponse genericSRResponse=bmClient.serviceRequestService.fetchSRMetaDataForAService(genericSRRequest)
		if(genericSRResponse.hasErrors()){
			model<<[errors:genericSRResponse.errors()]
		}else{
			model<<[genericSRModel:genericSRResponse]
		}
	}
	
	def transferToEmiConfirm(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		GenericSRRequest serviceRequest = getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);
		def metaDataRequestMap=[:]
		params.each {
				if(it?.key=~/-/)
				{
					metaDataRequestMap.put(it?.key, it?.value)
				}
		}
		serviceRequest.metaDataRequest=metaDataRequestMap
			serviceRequest.setPersistEntity(false);
			GenericSRResponse serviceResponse = bmClient.serviceRequestService.insertServiceRequest(serviceRequest);
			if(serviceResponse.hasErrors()){
				model<<[errors:serviceResponse.errors()]
			}else{
			setSessionAttribute("GSRR", serviceRequest);
				model<<[ResponseModel:serviceResponse]
			}
		}
	
	
	def cancelTransactionToEmi(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		
			GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);
			GenericSRResponse genericSRResponse=bmClient.serviceRequestService.fetchSRMetaDataForAService(genericSRRequest)
			if(genericSRResponse.hasErrors()){
				model<<[errors:genericSRResponse.errors()]
			}else{
				model<<[genericSRModel:genericSRResponse]
			}
		
		}

	
	def getBranchPickUp(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException{
		GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);
		def invoker=SecurityUtils.getInvoker();
		if(params?.collectionType.equals("YES")){
			genericSRRequest.setServiceMetaDataId(params?.branchMetaDataId?.toLong())
			GenericSRResponse genericSRResponse=bmClient.serviceRequestService.fetchSRMetaDataForAMetaData(genericSRRequest)
			if(genericSRResponse.hasErrors()){
				model<<[errors:genericSRResponse.errors()]
			}else{
				model<<[genericSRModel:genericSRResponse]
			}
		}else{
			model<<[genericSRModel:null]
		}
		
		
	}
	def serviceRequestStatus(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		
			GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);
			GenericSRResponse genericSRResponse=bmClient.serviceRequestService.fetchSRStatusByServiceIdAndULP(genericSRRequest)
			model<<[genericSRModel:genericSRResponse]   
			}
	def serviceRequestFilter(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		GenericSRRequest genericSRRequest = getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);
		genericSRRequest.setTenantServiceCode(params.filter);    
		GenericSRResponse genericSRResponse=bmClient.serviceRequestService.fetchSRStatusFilter(genericSRRequest)
		model<<[genericSRModel:genericSRResponse]     
		}     
	   def serviceRequestDetails(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		   
			   GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",requestHeader,params);
			   GenericSRResponse genericSRResponse=bmClient.serviceRequestService.fetchServiceRequestDetails(genericSRRequest)
			   model<<[genericSRModel:genericSRResponse]
			   }
	   
	  def getBranchDisplay(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		 GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",null,null);
		 genericSRRequest.requestHeader.invocationSource.channelId="RIB"
		 genericSRRequest.requestHeader.invocationSource.mainModule="servicerequest"
		// GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,requestHeader,params);
		 GenericSRResponse genericSRResponse=bmClient.serviceRequestService.getBranchList(genericSRRequest);	
		 model<<[genericSRModel:genericSRResponse.getBranchList()]
		 
		  
			   }
	  
	  def getExchangerate(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws Exception{
		  ExchangeRateRequest request = getBean(ExchangeRateRequest.class,requestHeader,null);
		  ExchangeRateResponse response = bmClient.serviceRequestService.fetchExchangeRate(request);
		  model<<[exchangeRateModel:response]
		   }
	  
	  def getBankTariff(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException
	  {
		  
//		  BankTariffRequest bankTariffRequest = getBean(BankTariffRequest.class,requestHeader,params);
//		  BankTariffResponse response= bmClient.serviceRequestService.getBankTariff(bankTariffRequest);
//		  model<<[bankTariffModel:response.getBankTariff()]
		  
		   }
	  
	  def showDatelineSRDetailsforEdit(Map params,  GenericRequestHeader requestHeader, ModelMap model)throws BusinessException
	  {
		  GenericSRRequest genericSRRequest=getBean(GenericSRRequest.class,"genericSRRequest",null,null);
		  genericSRRequest.setServiceRequestInstructionId(params.taskInstanceId.toLong());
		  
		  GenericSRResponse genericSRResponse=bmClient.serviceRequestService.fetchServiceRequestDataByServiceInstructionId(genericSRRequest);
		  genericSRRequest.setIsJointAuthRequired(true);
		  genericSRRequest.setTenantServiceCode(genericSRResponse.getTenantServiceCode());
		  genericSRRequest.setBusinessFunction(genericSRResponse.getTenantServiceCode()+"."+"ADD");
		  genericSRRequest.requestHeader.invocationSource.channelId="RIB"
		  genericSRRequest.requestHeader.invocationSource.mainModule="servicerequest"
		  genericSRRequest.requestHeader.invocationSource.mediaType="WEB"
		  genericSRRequest.setPojoConsumingUrl("serviceRequestSlip.workFlowSMEBankingServiceRequestCallBack");
		  setSessionAttribute("GSRR", genericSRRequest);
		  model<<[ResponseModel:genericSRResponse,datelineRef:params?.id,SICancelFlag:params?.dtype,datelineEventRef:params?.dtype];
		  
		  
	  }
	  
	  def approvePreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		  model<<[successAction:'approveServiceRequest',serviceCode:params.srvCode];
	  }
	  def rejectPreConfirm(Map params,GenericRequestHeader requestHeader,ModelMap model) throws BusinessException{
		  model<<[successAction:'rejectServiceRequest',serviceCode:params.srvCode];
	  }
}