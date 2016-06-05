package com.vayana.ib.retail.web.controller

import grails.converters.JSON

import com.vayana.bm.core.api.model.common.DocumentDetail
import com.vayana.ib.retail.web.controller.common.GenericController
import com.vayana.ib.retail.web.service.CommonService

class CommonController extends GenericController{
	CommonService commonService
	
	def image(){
		Long docDetailId = params.id?.toLong();
		DocumentDetail documentDetail = commonService.getDocumentDetail(docDetailId)
		response.outputStream << documentDetail?.documentBlob;
	}
	
	def getCharges()
	{
		render template:"/payment/templates/ownaccount/chargesAmount", model:model;
	}
	
	def fetchAccountBalance(){
		render template:"/common/accountBalance", model:model
	}
	
	
	def userIdAutoCompleter(){
		if(model?.commonResponse)
		{
			Map<String,Object> userIds=model?.commonResponse?.getAdditionalInfoMap();
			def userIdList=[]
			userIds.each {
				def userIdMap=[:]
				userIdMap.put("idVersion", it?.getKey())
				userIdMap.put("label", it?.getValue())
				userIdMap.put("value", it?.getValue())
				userIdList.add(userIdMap)
			}
			userIdList=userIdList as JSON
			render userIdList;
		}
}
	
}
