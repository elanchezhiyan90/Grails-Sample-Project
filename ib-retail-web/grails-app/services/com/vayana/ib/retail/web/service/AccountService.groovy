package com.vayana.ib.retail.web.service
import java.text.DateFormat
import java.text.SimpleDateFormat
import com.vayana.bm.core.api.exception.BusinessException;
import com.vayana.ib.bm.core.api.beans.servicerequest.ChequeImageRequest;
import com.vayana.ib.bm.core.api.beans.servicerequest.ChequeImageResponse;
import org.springframework.data.domain.PageRequest
import org.springframework.ui.ModelMap
import org.springframework.util.StringUtils
import org.apache.commons.io.IOUtils;
import com.vayana.bm.common.utils.DateUtils
import com.vayana.bm.core.api.beans.common.CommonRequest
import com.vayana.bm.core.api.beans.common.CommonResponse
import com.vayana.bm.core.api.beans.common.ContextCodeType
import com.vayana.bm.core.api.beans.common.GenericRequestHeader
import com.vayana.bm.core.api.exception.BusinessException
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailedStatementRequest
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailedStatementResponse
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailsRequest
import com.vayana.ib.bm.core.api.beans.account.CasaAccountDetailsResponse
import com.vayana.ib.bm.core.api.beans.account.CasaAccountMiniStatementRequest
import com.vayana.ib.bm.core.api.beans.account.CasaAccountMiniStatementResponse
import com.vayana.ib.bm.core.api.beans.constants.AttributeConstants
import com.vayana.ib.bm.core.impl.service.util.IBCommonUtil
import com.vayana.ib.retail.web.service.common.BmClient
import com.vayana.ib.retail.web.service.common.GenericService

class AccountService extends GenericService {
	BmClient bmClient;
	IBCommonUtil ibCommonUtil;
	CommonService commonService;
	def details(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		String accountNumber = params.accountNumber;
		CasaAccountDetailsRequest casaAccountDetailsRequest = getBean(CasaAccountDetailsRequest.class, requestHeader,params);
		casaAccountDetailsRequest.accountNumber = accountNumber;
		CasaAccountDetailsResponse casaAccountDetailsResponse = bmClient.accountService.getCasaAccountDetails(casaAccountDetailsRequest);
		model << [actDtlModel:casaAccountDetailsResponse];
	}
	
	def ministatement(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		CasaAccountMiniStatementRequest miniStatement = getBean(CasaAccountMiniStatementRequest.class,"casaAccountMiniStatementRequest",requestHeader, params)  
		miniStatement.cifNumber = requestHeader?.invoker?.primaryCIF
		miniStatement.branchId = "001"
		miniStatement.setTransactionCount("10")  
		CasaAccountMiniStatementResponse miniStatementResponse = null;
		try{
			miniStatementResponse =  bmClient.accountService.getCasaAccountMiniStatement(miniStatement);      
		}catch(Exception e){
			e.printStackTrace();
			model << [actstmtModel:null,pagerModel:null]     
			return;
		}      
		if(miniStatementResponse.hasErrors()){
			model << [errors:miniStatementResponse.errors()]  
			return;
		}else{
		print "Pager Model:"+miniStatementResponse?.getPage() 
		model << [actstmtModel:miniStatementResponse,pagerModel:miniStatementResponse?.getPage()]  
		return;              
	    }
	}
	def detailedstatement(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{       
		CasaAccountDetailedStatementCommand casaAccountDetailedStatementCommand =validateCommandObject(CasaAccountDetailedStatementCommand.class,params);
		if(!casaAccountDetailedStatementCommand.hasErrors()){
			CasaAccountDetailedStatementRequest detailedStatementRequest =  getBean(CasaAccountDetailedStatementRequest.class,"casaAccountDetailedStatementRequest", requestHeader,params);     
			detailedStatementRequest.cifNumber = requestHeader?.invoker?.primaryCIF   
			detailedStatementRequest.branchId ="001"
			log.info("Detailedstatement Params ::: "+params?.dump());
			if(params.lastNTransactionFilter != ""){  
				log.info("Detailedstatement Filtered By lastNTransactionFilter");
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");                                 
				String fromDate =  df.format(new Date());
				detailedStatementRequest.setFromDate(DateUtils.convertStringToDate(fromDate, DateUtils.YYYY_MM_DD));       
				detailedStatementRequest.uptoDate=null
				detailedStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;                   
				detailedStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
				detailedStatementRequest.lastNTransactionFilter=params.int("lastNTransactionFilter")
				
			}else if(params?.monthFilter != "" && params?.fromDate =="" && params?.uptoDate ==""){
				log.info("Detailedstatement Filtered By monthFilter");
				Calendar cal	=	Calendar.getInstance();    
				cal.setTime(new SimpleDateFormat("MMM-yyyy").parse(params.monthFilter));
				String endDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH)+"-"+params.monthFilter
				detailedStatementRequest.fromDate=new Date("01-"+params.monthFilter)
				detailedStatementRequest.uptoDate=new Date(endDate)
				detailedStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
				detailedStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
				if((params.lastNTransactionFilter != null) &&( params.lastNTransactionFilter != "")){
				   detailedStatementRequest.lastNTransactionFilter=params.int("lastNTransactionFilter")
			   }else{
			   	detailedStatementRequest.lastNTransactionFilter=0
			   }
			}else if(params.fromDate !="" && params.uptoDate!=""){	
				log.info("Detailedstatement Filtered By From and To Date");
			   detailedStatementRequest.setFromDate(DateUtils.convertStringToDate(params.fromDate, DateUtils.YYYY_MM_DD));
			   detailedStatementRequest.setUptoDate(DateUtils.convertStringToDate(params.uptoDate, DateUtils.YYYY_MM_DD)); 
			   detailedStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
			   detailedStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
			   if((params.lastNTransactionFilter != null) &&( params.lastNTransactionFilter != "")){
				   detailedStatementRequest.lastNTransactionFilter=params.int("lastNTransactionFilter")
			   }else{
			   detailedStatementRequest.lastNTransactionFilter=0
			   }
		     }else{
			 	throw new BusinessException(ContextCodeType.CORE, "casaAccountDetailedStatementCommand.datemonthlastn.blank", "Error Occcured Fetching your Account Details. Please contact the Bank", null);
			 	//detailedStatementRequest.lastNTransactionFilter=10
		     }
			/*else if(params.fromAmountFilter != "" && params.toAmountFilter != ""){
				 detailedStatementRequest.fromDate=null
				 detailedStatementRequest.uptoDate=null
				 detailedStatementRequest.fromAmountFilter=(params.fromAmountFilter != "")? new BigDecimal(params.fromAmountFilter) :null;
				 detailedStatementRequest.toAmountFilter=(params.toAmountFilter != "")? new BigDecimal(params.toAmountFilter) :null;
				 detailedStatementRequest.lastNTransactionFilter=null
		     }*/
			detailedStatementRequest.debitCreditFilter=params.debitCreditFilter
			detailedStatementRequest.referenceNumberFilter=params.referenceNumberFilter
			detailedStatementRequest.setSortBy("id");  			//setSortBy("transactionDate"); For PMCB Purpose This value has been modified
			detailedStatementRequest.setSortOrder("asc")
			CasaAccountDetailedStatementResponse detailedStatementResponse =  bmClient.accountService.getCasaAccountDetailedStatement(detailedStatementRequest);
			log.info("Account Service :: Page Size :"+detailedStatementResponse?.getPage().getSize());
			log.info("Account Service :: TotalPages :"+detailedStatementResponse?.getPage().getTotalPages());
			log.info("Account Service :: number :"+detailedStatementResponse?.getPage().getNumber());
			log.info("Account Service :: TotalElements :"+detailedStatementResponse?.getPage().getTotalElements());
			log.info("Account Service :: Pager Model:"+detailedStatementResponse?.getPage() );   
			if(detailedStatementResponse?.getPage()?.getTotalPages()==0 && detailedStatementResponse?.getPage()?.getTotalElements()==0){
				throw new BusinessException(ContextCodeType.CORE, "common.template.norecordsfound.label", "Error Occcured Fetching your Account Details. Please contact the Bank", null);
			}  
			model << [actstmtModel:detailedStatementResponse, pagerModel:detailedStatementResponse.getPage()]     
			}else{     
			model<<[errors:casaAccountDetailedStatementCommand]
			}
		
	}
		
	def detailedstatementgotopage(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		CasaAccountDetailedStatementRequest casaAccountDetailedStatementRequest  =  getBean(CasaAccountDetailedStatementRequest.class,'casaAccountDetailedStatementRequest', requestHeader, params);
		casaAccountDetailedStatementRequest.setUserSession(getInvoker().getSessionId());
		//PageRequest pageRequest = new PageRequest(Integer.parseInt(params.gotoPage), appConfig.getInt("rowsPerPage"));
		PageRequest pageRequest= new PageRequest(Integer.parseInt(params.gotoPage),10);
		casaAccountDetailedStatementRequest.setPageRequest(pageRequest);
		if(params?.sortBy){
			casaAccountDetailedStatementRequest.setSortBy(params.sortBy)                    
		}else{
			casaAccountDetailedStatementRequest.setSortBy("id");  			//setSortBy("transactionDate"); For PMCB Purpose This value has been modified
		}
		if(params?.sortOrder){
			casaAccountDetailedStatementRequest.setSortOrder(params.sortOrder);   
		}else{
			casaAccountDetailedStatementRequest.setSortOrder("asc");
		}
		CasaAccountDetailedStatementResponse detailedStatementResponse = bmClient.accountService.getCasaAccountDetailedStatementPage(casaAccountDetailedStatementRequest);
		if(detailedStatementResponse.hasErrors()){
			model << [errors:detailedStatementResponse.errors()]
			return;
		}
		else{
		    model << [actstmtModel:detailedStatementResponse, pagerModel:detailedStatementResponse.getPage()]
	     return;
		}
	  }          

	def updateaccountnickname(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		UpdateCasaAccountNickNameCommand updateNickCommand = validateCommandObject(UpdateCasaAccountNickNameCommand.class, params)
		//If Errors Not Found Prepare the Request and call BM.
		if (!updateNickCommand.hasErrors()){
			CommonRequest nickUpdateRequest = getBean(CommonRequest.class, requestHeader, params);
			nickUpdateRequest.setAttribute(AttributeConstants.ACCOUNT_NUMBER, params.accountNumber);
			nickUpdateRequest.setAttribute(AttributeConstants.ACCOUNT_SHORT_NAME, params.accountShortName);
			CommonResponse updateNickResponse = bmClient.accountService.updateAccountNickName(nickUpdateRequest);
			model << [accountNickModel:updateNickResponse]
		}else{   
			model << [errors:updateNickCommand.errors]    
		}
	}
	
	
	CasaAccountDetailsResponse getCasaAcctBalanceInfo(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		String accountNumber = params.accountNumber;
		CasaAccountDetailsRequest casaAccountDetailsRequest = getBean(CasaAccountDetailsRequest.class, requestHeader,params);
		casaAccountDetailsRequest.customerId = requestHeader?.invoker?.primaryCIF
		casaAccountDetailsRequest.accountNumber = accountNumber;
		CasaAccountDetailsResponse casaAccountDetailsResponse = bmClient.accountService.getCasaAccountBalanceInfo(casaAccountDetailsRequest);
		return casaAccountDetailsResponse;
	}
	
	def fetchChequeImage(Map params,  GenericRequestHeader requestHeader, ModelMap model) throws Exception{
		println "ChequeNo :: "+params?.chequeNo +" :: Clear Date :: "+params?.clearDate+" :: AccountNumber :: "+params?.accountNumber;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.s");
		String clearDate = params?.clearDate;
		System.out.println("dateNew......."+formatter.parse(clearDate));
		Date dateNew =  formatter.parse(clearDate);
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
		String reqDate = dateFormat.format(dateNew);
		
		System.out.println("Formateeddd Date......."+reqDate);
		ChequeImageRequest chequeImageRequest = getBean(ChequeImageRequest.class, requestHeader, params);
		chequeImageRequest.setAccountId(params?.accountNumber);
		chequeImageRequest.setClearingDate(reqDate);
		chequeImageRequest.setChequeNumber(params?.chequeNo?.toLong())
		ChequeImageResponse chequeImageResponse=null;
		chequeImageResponse=bmClient.serviceRequestService.validateChequeImage(chequeImageRequest);	
		//def image = "iVBORw0KGgoAAAANSUhEUgAABkgAAALhAQMAAAAuGrpIAAAABlBMVEX///8AAABVwtN+AAAgAElEQVR42u29fXQc13kf/MyHMMN4hR1KjrWyIeyQki03J7ZWstvADsS9lPha/MO12Lf5w8mb2qtY51hvz9sYctQWkkHiguQx4cS21iftW6VHiVZOT+O2502lvDk5lI8oXpCshRx/aJX6pFYqiRcQLK5rWRxAa2t2NbPTe+/M7M4C+wXsLrBAdkgCy/2Yvb/7fD/3uc+VPNgjl7zVD3q49tgVPwsAFwAsgNMAOYD58I0GQOS9JSR+EXDDJy3xk33oUu1DW7ikhjRZHgfVAdldM8JnzkxLaSLt0HTHf3KDVR4BQMS9m7CfJY0/Xo9kaRwW0uAqsDIWPuWou4+3Ts0ADR4m+Y9Za9eKiVJFstsvRbqSgAvpvYBEdvKQ3htUIXuFu2TYK5e6F0DMMiN7eM/QBKtxZuTn8LqnDWvXyboiuAutf8nM7yokC1oZXlNXpQb6K7/LWKvMvNi9o7vkPWNk5IZyQvYMTfDfp5hx0C66Z5Aoe113Nboygw3EbOlBfuSP3v9nV2Zf/JAyPw0I5wYaidsIiTIZamFX0aBCPgTz/+kHAx8lR5BYynvfwtLJjymEKeELvz72+pd+9rfO55cfyn6loO4CHRdBomsyZM5Pf+MaDx7OFQIRWgSekmMh8rbamFixq+jXOsV/JnZU4kcVrDwukXH28FDke/1BxoTdEA+1jTgiXGOJpGhhUAL+w/6vMYPnsoT4RqdUIi20MB0AHyXI13Ka4GbD4RlevZE9mejUHdgOJDb7twImf1hErbxBb+D9LvUMih0CdChO3oSPPKFRT44rlgpnFiYsVclMwhib0WkQKezUQCNxsJ4zEIUFzgOxDN7PKHFJh3ji4POMobIX4XNKYv4MvMZkfvV7U9RujAQNBJZrMdwPz64AuQvcon60UHnYRIBcyDN7cZQxmCpkCUs6yFhR65DYAxVeaW+Mwqtc++AYcX7XpS+z8VHHe9w4azoeXILf+Z+32PNMlMDFX8aqUYdkoLIPFX9iSxU3IuYF9jRiIl5ZYpJe4Wtgr3hAsk69bMhm9WFqAJB4h+Lg+A9Xka9wpxwKEBEIUxaSoECGgNRYTtYGgioiaRg1F9ituR2TzD4Spru4vr48Fi5RBkhqZuLJQQCSKgWuoESq3HKk+uolpqYNvqwqQcm4C2C2MU3cwQoAORBLmHQaJZIeugJHF8H7euPotxMXURtJwFTG1iBFL8ZSM6NxeOEFiSTjMB6PP6Ekv3cxreGLN8bGJi6+z35rK8nlGbgODoJnZj2DAbiLwxmpmogkwJxnjDKUBD6ptLLxSgc+izSqYzYxbGoMXQZjgmtv08AHDMzVjAo68/yyIHG1r29JDWNuwdnfONdhZ5n0Si8DvD4l0NyCxyUTH4XrPDZwvM812sSMbcKA/2zwD7E7viwZHtj6wVcQQZ5p4W/FyP/lesHcuIXlZ8TsOBtvsWS2/AZ8mE8KnpuYvcJ+Lb8t2Gnul/2Qw77wpdvgq4+C9FfXPgO0NnwcoYnJZnS2uZ+IAsetwi2o73YWpAp17gRzdRXWLFSGIuaOnYl/2+fyrQT+81euvf8cWjxnwROwaH7shUNrUzcWoFgwPccFOgtPTObPn4DzFW/iaoUej8wSqaOJB/hK0+/ImRGzQ3j0oM6elVnIQ2/isvkZ4SRgLowZ31E1t7QIUxYaiv1dDqYvx2elxGgMH4WT7Nk7WBx7gT3Dns3lGke/GJenV9uEnlxplPiDERYpYx1WDV+4RvCbZMRDX3nP3wZvrNoAd7tKRNQ69sH6SBv3mApFeC2zuYZJmdNWEhoedPxhF/bxqMK7xcG+ms8ZxW1W3BEPssCJK9EWcfyCmeOE5z4pyKsme+CbIYP5sEyHcRkyyH8A+Mvtzo4pG7WwYiVaxPEzZ+GuW0wF384Q5214jHHrrTge/4tRUNx/zNDFJZ4sUHAewdTLsEM0QdKYGQ2mm1wWhoplgXcUzuIDGcxpQCgQDM4Y5t4fRZeZqONtjxHqtLDHZWWsVcjuuVeLluXYJjzyo6tlhyQXAX4XqIUvs5Ah51jUs+/4fuEh6x43c3l0MWDLEY2mgZLnVz2YGYmlUhP9ABK1jIY3vowRAyS30pFcNHggGmYI7oR/w38tw+rqA0zg/SQTU4EFFAah2T/fLxwBruBP/aGHFvuuu0Bz+JeTFtm7LaZ+TK4MVqt8uwGLUlJhdK1xyqTRVYwBrPwmszkENZR4650G8OIWt+djE/FuwqeSWZKA+YQL8mlGxxV7w3TK9emutslWntG76Hle2mtIE1MkgZn+qjCjMnv4xIXpeW/u0Rig75777e5CWjZ0/KhQfhU+Yxtt//7wgV+t4U91RijylIjOE4VaulgrXXzuy7f/129NQTS/t9GDDJ+YkPi3c5Vw+g86JntD3tINxEdz4Z+K/55YgQ0rMd5bnUWsPjEdJpuwOOY+WJ/Ni2ZTFVILPDFDpOqAjcOCWizeCcMXkkzAa4AXzLjyCZieFpOsoBZZJqHaT34wNmdNqoBYBE4bJCK2mn1DjZAYgQaru52X918ZD5TC6NQoYAWW7j6YN2I4cfpM4iOKFIOnppYSuWZ6fqyWjeXe+gYx8Wcv1j4lonequwKft8Z9hsQpKvskjbia6k0LQO+cAHTdpVv52/4Yjk4Api2+QqPqVc84z2bmqYecDUZz/6r4VdK7kcao7hIyaaYSnGbuXUyR+CY/z+eiRkW7EDov3ON6mWNmz2BDQu25wOljflBenwxH0geC/52sirlaSzgZPk+LNBmn0wmeNZBY5OiH241IQpkaL6k09N5wAwdIKqmPSg92RZKoPTGFV4ttUtUJYtCSiEemgghQ+FOCP+iKLZkpDoQ6bIDzX+iEv0820UnT7Kue2goA0pgmPqA5nbGVwxmCsYTFXdtvVl0xT2gwl7ss8FaU57JNfRDtOriU4T+l1GjlyBxtaGNxc4d1S9wVuSvPk/BxSoZMoncTXEazCgazCF4uH6jZD6ry/qZWYOo1f6CLt8NEY7vE0SXRFhyslkiMehXPiIFLNTdiyqepxN5VEUxjIOEXTJ3GTZPWfCa4nffAmwWrkaQY1utgJmucEqeaBdk0TjIb5/FMI9W8ptF4UyQlgUZFpV8L3utUzVudrQs+r4pxSVkoN9FKxbK5ai4Wy2slXYKTa8WFBrlO10wwcTSrw0sZOnszQWZCVZhJIDx3hjfPXb4qwD6x47qY7OqM5EYveDBCrvkgwCGurSa/yL4iAQcfcTxz64qHT5Zdqo0V6YbKKGkilfESAnOTNp5suHn4bqfKcwBL7Psky7bZF60SmMASzVifgb+qNF+r7eharltZwKopM9IYmI+K/ZY3J/HmOs14IkBkQQXDvO93lctXoVwAOnmVfYn9SEF3i+detYpwr3Nnk4X86ir6xBQEt0xv4EN1Arx4ZCpc7B0GeRlKd8Fj8+aacOPxZhQB86Y5R8qhv+UbA3abzOPV93Cfle+14jlZwj8vBkCapxxrospc6zmfruvf8xbZ97WIsyM5BP0p/6Qt6eDIV42pDkIXubGZgROcAS/UiHWpr9kEe51NsQFbJykV04CB6p1YRpVEknI4GgSwv2IePHm5652C5U8QPKvcxug8XignzbmNEi9HCeVtcPc3nYOsTzZP0is3WuoJMS/LW8pX17KpEmOsvC/ZS0sbbKCLqn6/b18mQy/HW+JPl8FYbctdaCO3VapGPYElrrUQgdW+chdflq6bSuRP8ulJQ8y13QF1mq1pcUaTGSDDjmjgPl5uQ0fs4nTV+dqMxHP2qV+FsAOeJXXKvvcX1/RfrLNnMxeNYOEUdBKsPGzKxkumLjjL59hKCWNr2YF/gS+FQqjYIeWyGfYNvq/E3a5UsB6oaAqNJ1+jWyBIvs4I+XfQPcM47SvQTXoriVQ1pJhnmncOVs0CJ9ZiOaoheDr0g99goXfNkUAhT8xfMoz6MoyOcnHr9FDBB/Kx05WQ6Qtoc0g0IiajeYhq1JnufGmDLjxuwnuXuq3mEZzBpmWaRRTHxTMLm+Eu0jrw8WffHo9r7J2TbKqe19iH8RWJUIvrS3uB/QbdmEVvI9ql4Bi5YlYPomxny5FWm5TBnDF/UYlx65/ga9lK4js3G8zlVmKauZ8vajkjOkikS5qY2MXYYWqGJ3ecrSJpLVmPYUjfMs3lJccdLhX/sWngW3jBlQdIZPgY/8m4V1rNA8W3bZNbiX5bpk4zK8sVRra/huLv33hnhcpwv4ey4kZfR1eY4n93TwDcCTNsEGxiKnyHu2l3kp1s6NWXW3Aws7UuZVgUVWNSX87CqzwmUgV+CjripkfVu1wjwWOy4ZegogRQSWSXyWZp0qYOpww3BI+uev8/l6qEyAGtkcCOxbC1+Xy4tl4UlOWFJMD1loowJCvXcQs31YZj3XqaeH6sWGj1kQRXKHz7dllUS4BuJ1jEgkfl/Yrp6UR9B6Tzm12DV2Bd4k/ijSZivBMBzxhbHQRaG2liQ8vSYN6yQjpqiPeNKTyTZDq38MXrDOgJxmOXrAwZBfvslhNwQcaEVqRwHJxrwWpHZqXenph+pgw1j/1/F+KAj9MJRrorCpjKlAbwLPdsvgQ24VXgp8DavDVRzXV5eM9yvBwmOTvMe9ptfWF1vcSbrbncgcsf/ZxtJcBbkx6A2+EVpq1+vAJjbuGL8LN/zNjVnjxnPbLZMtF1wukt/HZxsYzPL2nG1O0SjLOgplzcBF35VHodyipRInm8rhPwGlAvzg2H4ifPSCTKyATCKQQmeHfNXZJwI+4SV6cRVQU3zjptXfGqeijXWwu2I3G8CR0vvm46/dzW0SoIU9RNqLbFngXIn71cr5DA4+q1K93dIRLHt5kTE/p4Yex14PR1qoVz7cjQTyTNXMDOkwiDsmvDASXTFU2i9sTYQSCWIkXyQFGl/lSnnnrnEi9ur5RO3Td285MTv/7dObx6+Afmys91pTS58rnsi8bRlbfsh+9739ZUiJKH0ukuJb5jlUqD9zMfRQr5wORZJZlXSu3Xjxw05u/eMl2JF9g9bgqiInlsw1ultjTJdPKNX5mf1w4ePAKydf1xmLtdPSicyvveQN89OfdHcAv+g60ZeQqSygtAvSgDPSF+PtoyJ/O1NhmJ5teM5/1CYLYEVe6xNBbe8R0ixuKKeSd+fmu62iafhLcyW9ikEMNbkBMzcHH1NSAfqzotRd8LQrfCs5XpmLfVpAqeOQszpzv3Mb7+Dbi62py7OrHYp+YqEFfK4HAP7oTYBxpTJwmQGznYvwWzsBUVLEHJKR7dxCe+uFFe5E6TKoFlnAYYp8StaYESvAkvMjVgS9VAbfM+E6P0cZf0THd1dL0IYqsCOl1kyE+u8G932D3co9vhCfQUyQTIBahUMP6ZP5mjTHd9bBYRqnN98ytgDSASkojUqOL/ErgAPGGRmg/NbMb/+CVuoI8AplLbjHr/rg2666v/8jtn773O1P7lxBWAax4hX0klrOyUX1rCIZ0u6ToOzbFR+vB3HYbu0KPmRfn/03+BvwKDQJPx5Ouel/49e4KHlva/tUWI+SJkiz8qyrrkZUNFY2nMlvhOUjyon8PSWafyvSsLFNNuB+Tvk4iLxawJf0dIZzY7QhOJMqb5OOOVuTmu4gQ3nQRmOv4B11B+7aiLFbdMf9WGP8CAU5Cbs0T/03T+nxjzl1enS7T7ubX4F/srWke+y3/uK2eFfZjmGSoyzdObmbNc2SeulhpnJH6RvjAA7r1fTTwmei/MaFzs4r4aIYJMRBTlZ8TPsWgPhuhu5l+qtm7YUSSfFr/+eqOPIUyVOcFpYvhmS4vSRCYwYBet6siQX3ybm/VrtsVPf31GHh3EmLGh5AaD8wu0iICYp7UIxGqWkRisi0uILVKsQSl2XIx0n3jsO3clZ7BpEvUsxUJOJcp1rws8qtDLjrlrkBxu5sv9VDxVObtrkFSMiJNubQzR6/4zeLqrLpb0TUUkIo4mVurjuoGliSCEH/t1FlEPHpKxmi72fAl5T5dI4lB1gLf18vcIarDJVEkLJFM7EzQlhRFX3uwkBdcYic1DdCUiRFjfGe6Keite7XHnvkHwwIAtJJB6ed0kllGW9JqsFxdTneQ61g+3Sghl9as7giS6HpSP/vYLN/wwqdTAZK6Tk0gZVf4Cj+NHYbdcoQcpydXyY2KlRQy6NP666M22S65o94UXDp9igew3PUBz6cP3EJCk3dQgNhyqnA/iF8SPKzngq8AcwO5DwgIzS6iKhxkp1mBZaI2pXYmE+AWifAeoddVX6kybW5Vdh0S1scTsato2vDohN3cfTRh7XQ4MPJWuqz7t7EIksMwtTZ6fTTMuCiiNmgnaTUh032AuoAx7ajm/QAekFeEWaBLsKmC666s8LiDOZjzqQTCMG3Y32UAIvCplwOR85ti7jibxjx587kAqUFUSHIRK4rldxVxOlSY/qDnDs+MwRj3NkQDA2nU0MZkZHOfD1nSmiy8HNhJ2j2GsepAVeLeoZgVc8gBL5+cgd9iyd9PxetFICx1mWM4Vg/2TYodbkw5YA3ltVLPjkcfKrtHCjU5DiLpaY7vQMtauOu3b2NLruwNJB5exO5BE3d+lxp8q7A4ki7ArrwZI0K4Eov59PMlliGSIZMte/ZAmQ901pMnfByRkjwDZS7or4mWN7Bk5qexmIHVa2NkzNBlq4SGSgdPCM+wP5YuSimj6la5IVpKcUCzF0uisNWg0SeMkHEp6eNZb4hvPZz02eltiw/YInIRTfG3Sw2OiOA6J8l7sf277yng69SBJxuS/MuEAaw0azLq3Sfw15jaYFdArOntXr8t4lK7lxIj8JOEjGaKpL5QRHeIxJDk8lfGbfrHc87mn3SFRQKfccOp4w0s6I8PxkgWlvIl1Duuc+Mltkwr4ysleIzFaI2lbO7UkuEQCV0qu6iYcl3T/s7yLnQSnbRPsj0KpLG5X8pOtqjisaKHHQFy9pe5S1I5oGnRjqbkCUpSqjGSeXtuaF/SJ7vkKjNmaJgfb3gBHfm689Cpl8xCuiCOQmcD0fEtLsVuJP83eKlXpEPCcXxO36OMTLwviYuwaNizDUqXX5ypAi55JPpLPbJqmdqjERLNZ/+KNls7iwBdlkmk9W9G6D+QUL+Gv4sTEJqBm+2lVMYluu7YsTrDOhc94FyBG4dSppYteSZ8msx+xg13AcedCMmSzS5OCeDaTku5PCFHhiqf4AYe3j4ndqnHiJMSfRo1pkm13u8hRrvE6B+R7NQ0g7o2r32CJ9qe9sYx1MiDxZdBDzf2udCsPyfX7+3v+PxQNaPI6NjfEOHien6zmWJDtgV9308MV+PcrLpRNJCpO5XXiGkUrOdBmxQ3H1tkdsVWPiw+qoQ2fYu+T/N6B0IPTm0rW2RW48urpBzX3QgktqVk16AXVCIkM0KbQOWA/y5WQy6jCLGPQ2dUMje76NkCSsDDu4d5orEzdmM0UFIAkGyDhnXBcs9WdVmsqrDhXtSwOuBYGx8dyN8PkmIK7XoMRQFZrN2kz/okhBD4uIgjet1NZBEdLZc48aM82lKXkGa357e6qMScJKcjpYVe5i3oh23GUFAOSoQdK2J8M3ok79RpTmlVC6DpGJ9XGXr2Jmt4s3swblR3TXGfpa2h7685jDydqcu54R4qgfnODfnN8Laq3dFbCJJKFa2pXbA/2P2YRkOw7HxZ6weJnUpjQm4LQol/NDB9/gukuvyv+Iq9DeROMKbIOicK7+2VWx3Bnt0YBdpd5xJXqEXk28O6j8zoLAaxQzTlGD6BwE7XAvlQ0iKseWSLaRUbqNGv25LWZVuYRPRdyTCaov0cCjefpCE6H6sDhEBTHquUB4+e7R/IC5hNesdZZfnpo3dmyNU9Kap6DtFNgveY7Qd/gGyJPeT7LRRrw6I6BgM5wVcAEiccl/OiHXuU1ecvORYq8WvCLx/6iPuzytfDvMktq3Ca6PDYReQfGnFD5GlEbqeLqbNDAm+edff3nvF7kNalP3yw/I21SrqrQglV34FOgu8TcIu/DTT1IPnQ7qqOscB5OOtVIy/IJ5XG4J/wGjqgHdSFLR4VQ6CFb2Scp/zW2zpr7SD7RLuaEQhn8TplX+QRhfk5ttWO5OAfE9mB1AR6A03MyrKIljxkbZmwXzN5wFyPDpYJpAz9o1Jnhp/3M0esAvzdqOLgcK6/ztrfTtHk4n6wvYNvei58IQckYxFK80RdWPA3HvbjtPX/Kma6+SZNrgZTWogvOUnBC6o5clHAusKDIrErKxa7n8JCKTfuJyIFWjk+TcU6TQ3RX7TfZkMgKkfBrVyPxtbAFLVMnu+EKtLCvlzVrFyOpj5DpbkYStS0O6vRTkWOaxYY75RXfbsT+8p6fvIgqa+/66acP/ImU45Fe4Zd/ProaRAWFBKBnwiDIbX8yOr9B6Z4jM+af/ZdZ4/MP3+yO/gWCujM/I4Nv2Fqe3Pt0GsojzESflwacEtXxBRnhVB5mfv/bC5+YJtUMj1idJ7uRu06dYg7kupEj//+le562xk49eO/tj9/PPf/UU7etgnW9GyuO/p85y8jkgrNGt+UiiCaksjXGGG8de/rcxYYyi/lLxZhE/dY/u+3SdhUDtUQyXI8fuGvPVXRO7hUkirxnaPLB3Q9kz1XZ0j2D5Mt7QAvvGRuv7DE5UfaOxO8dJM7uB7KH7ImfuRvGJwPn1bt7R+JjQ69+4Ghi7xkke0dO9L2CpPLmXkHiOXuBvfZKfDLMQQ6R9B0J2iseJJzdMzT58hDJwEW/gWUc2f00Ca59Pb11Bqq11woJ63SDg0v6roU7NviiLiRxqBYQHIpb62tFsuCFhwup6zaKNdi51iMkAXfZZrO3xWkwucFv5jwnvZUIfsnat7PMVb86V2q6xW6qYXM1v0BB6ZiI2yAnYX1BUwuJ5WZjs8MPN9gl521jO0m1PtJqVkmqVOtDaARddPAvHW+wj0le3cCuuG/Rtj+hH73k/6/Zxhd19d6NT87NRf5TcPI7KycBdz0bzj1pskNs/UnqTSZ1gtskG9IwNe2XIsYVaseFRtSIPcMPdpuxZkmc9AsJl9lZj10WaI3DR2rh8GR6xebd7MWOr0OKRSU78etkxn9Beh7sGzUNCN33Zal6BEEqnB1FUWSsADZTE/3irgrUaiAbuvk6se++5x/cIBRYbETChwGJzaPqPktWQfWlIeaO+DLHuG5EkpVQLpBakxEJyIP96Vzo+CemnGZfc+R72YK+OtlUfU2UdIHSkPixuCfEJmt9BGKR2nmdmxaDTYaBAwG0VQOwy3fmcaWC1OI1IK0BQof7JSeME06em75aZqOiE1MvSHaSOBtVjiHxGmlTDJK9PGsHRuUXPhZXhkVOHR0t8/ddCkWqdFdoP/P4BwB3XdWP075JvB01CHOpC6p5oM7eGWysJdXfyOSxQRqSzdFJhgouKrwQHEJ52Pi42BpPLvO63XOh+bTDppKMNuf5KWXY6YOZCezJTM0X5jKjHizJG/bVFLAr9jVV+CDl6lj4Wb+8ibcKNvUnwz2OqibKQdI6f8ztqxZW+AhPSGLntAl4GVYn6vWsFdG9nGuyMepTsbLOpodu2HoNuGBULbDapwJrnyb/HGDUt+IaMy2XGRrjYxsUcejLGLo/FknnQ48g9lWYla7bkbMxUZvud3yyEqH81UfdBoVSp2yOR9korvusOqM5VzN8FX27kh0RXziHDcsA94jvME2dbOTV8GssMv/BnNexS8nfxRlct43Q9a7Bgt5HmjABsTFQNt1CgNm/3Dc2auHjNQxeI+sWxi5mfRuMdW/tUw7a113uSW4jnYDn8QFGgbfWv1OEUxzQnbwbQdADQfIn4jvReGXUiXhmoku5WYsYxI9pta9y4sJxsf1YVr3r4N+/UB8I20ivxsaYD9LWG1DDFFAMjogpqNCMn18fm5kYp/qGxBHjtFxDuJMx5zNg1X+ZafD9/HHf1PNzE/luu0mw6mfX+o6lmhKm4qYfgMCli5+rqiyHOZ6VJFzsmy8sDrEaq83vIYe+UmfBnASfdZkBTVdOmUFTE48EPDRJ/ZFRe4IqxJoRBaJOoj64cmpGx6b94y7+1V/zmXt5yVjw9CVUN9uuxhEuUe7NEvLImKVf9B2Rcp0IO3xDhQ3PwTxTD+FU4JyI31yXQTrOYeG8tdh74+jUBvwUG0NZ7HJu9EY2LvyHwobTAhPjhG/jS2K/psO9GL4JmA02mXW82S9x98cRo528CgXmtTGiFY2EDbezyPLMHHysH0QhIU1qUtmAi2cthcxoNiheJa6xSMtKQhxiYyBRKw5WHDbsHx8Jk3fVqUL9XeLQVD/obacXeWMueMdW4HN/tyZxAlkjP4ei4KufM69M+/mkn8zQSrEiJAoT30ovvvRZ6ipPMARf+6e0/Im/jK2MFWMgv+81OO08vK/hxuaSnuxEggqJXMaw1Hfu+MNP/ovTUQKwuVJKUSRzmfGVDemtbOMdgpd6Wf3dIZIGKbcqTfh1Ipop2Zina7LVcSOQtdEQdCHBJ6C63+WBf/diir0aiJ3CCJRnmt6sjR09AyXprfe/vZp6s1CGuLGUKEAy8zXl/O3mU6lcJvvpRk2OMK6nibsx8eYqhU8/qb1ETsHpjzf1XuPWAvu45PZKABI+j8Y6btOiHMf1NJk5zcAt/sPr9z1wKmpHfCl+uPmNApd+MNqUCkW11VMYlc0cz9nBFWSPOi/SqsXoWne1RK7fUeZSj2fX2DpNBmUxa6KZwumYJgNWS7SJ1Ate53cNSi1RN66lj+QI7PoriOPJ7keyd6rRB7MCZytaWPX71eMBgWB2TZNv7gXuQrBHLp8mr+4VJLt41wautyeDeHhAYks08dSBAaB4HhZ+V4b3KOfRcAVmRdmM03q5YuB2N6lhyQlnG2QaoEkSximD78cgZJdZRlT12E2kA192Quy3KkmNzA0eWCQlfUnYeKaE1BW/OetdYrlZb2e+fSQDVDZYqnIZsw0Pn1C24vYAACAASURBVOax07LhYl74tma0RzJInW6MavRIfAdGpTBDwJi+y9pVHqRSiZbn2OKxFwzzcgcx4+AcSa4G7FFNv4nh21L7yMP3hQfq4FUUGmvEMzfR9nqt0g1+UY1ycHBwSA+HsZ/zAdqe+fE6X3gAziXNhKrLz73xXpMJwlWRTurZrcllD8xeh2z9LNdqEQ3nQGc0iU7ITl6xsY1qVUywiTvrqemvx5/YeSQnA5FQqlZDvSC8k3SH1Uf1FZ07Kel82BSUGVrNQXoGl44THZ7XMTAn6M0HQVLtEAIgourK6dB611Wq7eRVpn5upVR1WHzroQR6ta1D5WvhASCMdz+E6rfe6HOEuid8SrtNZAODkYPcYAnsgDLaMx3F54PWK6qmqOL4MOjokKEQZk/QONMCre2KTxOc26GBz+rTbPTv4tPvSedRnW+FxkCb+QRMXhpfehxfzNsnv+i2zxLtmAcZ0VRBcFurFXDGLBxucRHsH7Na0WSHs0SRs1MCq1E7IukcUGIzeBXxm1fz01beil+NvmMS/8xS1qBQksZWlKBSeiki8IRansQgoqQFJQ/wXHvdxU/x2pHmwosT1a8NLEH4/wkHri2CObrGy5gL5jiswRPtPUjF2GmVFZnGAFG+tq+nwMzlMjOXLXuaB6tzZYAd6vfsb5FK1uwJ379n1bil8zne4YxE0hLKif5erU6/Gs4Kxum4S/4gZFO5RsJ6aAgqxhZrJHa+smCJsdVqrezSC4tW3hY/i5tD4u5YZcGTnxUksai5Qf7L66Lgzmjy0A76wKG7RTbo1a1wV3ancJhlQ1oSgUlV5E93hWTHetlmPTDjTMSJGY09ti7xyv/asYwKgT9hvx7tQYi0w/mui7aQbyYjLuoJErxTSJji4qFR3uz+6C1fC7++U0hW8sC8YVhde1kIB93ghXV+BXuxdyzYRVP+OagFwF4vuGsHLyJswFpwbtJuRpIPWSoPXSUT9AHwICNLHma39mRPXD6S8d0PxN47NPF30tAeAuKbJ2I/TP/ZryS93zl2+yi4Kze74GglhRdAfP5//IV1c+mjF0dG0DOSdugbqZWxQgLMhf2jy+M3vXudC5/ZlArwd228sw7J1Lwmr+27WzjaC7MvwZXaS6ujfStDKOlp0koziEKppeSK8auXr3FhKksQubualtSqSKay6We0neWPNkgaU6KKRA3iHIg3MLHlEcinchnIZXQb8tfJf/TN3znllDR51lt6+RI8duW+J6c+5X4UJ689kkFg9SDV9P0X3n/8Bxech7LeQ/9J/mYqdvOLccil/E2i+VQH3AVjK/x0HT4tZx68t37/McSfns0/yF8UGWjFKeli582gXcGeoJVaR5u5xskPqJ7UrA6y7moToQZev8qZWF96YqAtY8vLiJ55beTI7kVSf2HBaxPKYCJpPSwm4YpGNJq4m8xAEiwtTuCIigdOTkgHohSfPro/kYBJX6vh6aVB7K3sc1fbRa2UYaq1UNvoOizqB5JOUxpIZoHdjMBcHGCJbyn3sscr31yzEGYqvz+QYU0HQ2I85VyGGa6K7eAfUGM3Iqk6aWGTFa4kvMFDInRXtQKnUQm0VfMEBvnIVn+vQ1URNcrO2uJVfvCsxN8v9O/qgCKpVBVYQ3WcWWfl+d/Bi/x9LfzDVm/x6VRiBJkf/NzKUy09rVr/YQpLfjLKfnZAkbRcCapV8AjtkNztvjBOCiiW37nHGVQkRhuDwrTwadNfL+ofSZJ8epLhFibCO0NPUuGox7dOE/+jljQB3uOBa68QnIa4Z4H02KyuUMnzvOk+wMkEhXWKWX3Kq0XgNsxaDOAEBxhvGP0avlMYK3oo6uVznfy5z3GDuKaJVolTvlLWwOAmFPdWl7l4A3v4TIwfjfRk1lvH8T80grK25lWq+GENqOosnJfOZ1Pum2/23qA4PGHzYDiuGqJsw6yDih9sn5HQVxsBnwMYd8Xc3M5E57K0hc2T7S7PeBDw1+M/vJZnqtLZiZlnlfjS9cU4mfoP1zp355++OwclRK8wCPYNtgf4lBuprVDDABfmMsGzY6X2AaFM+yP1CLJfx6qODp/RUQr/62d90nhgVGQwUuI4SYk3Q1JTiyiemdUT6yX+SOC9t3ETzc0klzYfiKdWAPH6G13FSEceIKkqF+6aVPObZFBkRCTDqAtcfV/4bzr6KuW56sN+tDpWFisYTpFLYJq8uu7ba0z6b/gZnzXkAs3CTVx3cY3E1NuTaw4BvRjtm+nTZA0ia/JGZ2zQ/Qr6BrtFEeTMKvU5b1SYUp3GQoe5YKgK1sQL6heygG9Cb6Laqep6x3F8/y17ifdhXRLL8uNs1H54Wl0+mHJeE2V4tvi75o/G3mAZa6KhtZATt7a2+Up/wARBhbpEA3MgM5GeE6Yxzxwl73s41Mkp31xa65F8qrPq5xo7rfSLMLy9ocd3Yfsq9SduyPS3w6rBhl4K/u/vMC/FGnkrm5OTfuguDy7wDt4gjQH2wo2JWKhJ3RypaRmmzkZxTVzrkDxXhfTOTrqzH5jzPT76BPo4IAOu1pS+UVJVkDilruPv+YYEWCMH4xvkRDBLmmjamR09dDLhCSm1nWCuK+AoNT9S8X2pGLwKzmdHTUTtOudKjghA2t7R0w3Z+CuALoPn2ARs6+xVZxJesRDvkOlMuxWgVnV4bgWL4y/sqDYNUSk4zRz1M94mNgFP7CT5ACtYiiRL4j6SMY4kFqNX4J5NIEnAAF1xf/3k5UAFOlziIzo6FuhuS6PsD4njJE73qyN4b6JfnwGnvsyUXpCcmMWe5tHroMLilkVN142EkUilMhlEah02zEECEq1bMY4xm3LLXb49wYe5gTE1SZUl5pwausn+MMVoMv+NDCZN+LBc/4QPUlEhIUWcRIk7v0+O2HCXd9oT2aJHWJy8Yg4wd+V8c8p+5f2zfaRlc8VRmXM9r0/pYNAKqRxx0IP4ivSzWjsmOlhIhA16Q7iRKQar9FxoiF51ORuJ/uGexZUB2klXplOavFtoMBbQQO5S9QVTuGKeOL3BBESjWYLBk3iI9JEQqwvfC6adc47qmnw/8RejMaZX10h38GgiAg/HOfF4aEzkME+hRSdfmUqS6y9fRwYYiRABV3/CrQuhOHH8rsdSWH4DZmxAjwMPqmwbJxPXryVSMNbWBQUDR5O6PndVb4WnGeuKvUpwdf/ygeWtSvpE/5G4zevqRfKCeoGumgd8uWF7oI6uS9tAk8apAXGoAV7n/fMzprb2VRpsHxJcG7AZev3Bhm1uUrpcxO4vc0U9SE1CEQckTNhIVceEhHmLLQIizrbRBJMo4xzkCRvAtg5YMmRTReqkjvdbByo3b+2b0jC9E3LiXU/HmMd10OZn+ukWlYgyo+Az9qg3vtUWWcTt617D6K4NHcVrB5XGvPAImlnOapZDgdpgYcpU15a8Fa/fq6yR5QNXzhK9em6flMZT8GrJcyo8bWPbVsGycvflpPPS+bmthNl9L9PzRz5WzY7qAQuQheeYZK/AycpDwJsyGuLsPLNuxWITtFEs6HMmzY74wgbcCAU3UMMLcEFoYuz1hLvHurSLE51KfCGwIahP1kujUEI9EoIOfGGeuOyTVE70v5g16gubXt+yJqTbPo20U5qIN5Z4OYRyd+e379gnTndNErnDt7jipFhErkDFnupD0oHU+sH028aLYg+RxHd6S/LAhXO3IXlRpxQKGJG53pdtStuyZ0WtTVy2T4FtErZlean/xdhx2gOSSIOAJLU9JOk/EoX0ovP6uwcASSxoATPQNOlItVq98VNwh0icvhEn3Zse34c61ML1nciMj5xTchko/8dMm892UNEGZNsaY/vSyFn5xGzkaQZiJNOD2ydhsSfDtO7dhI2v44KcD8Ok7s0UXOW9/+Pu2NOPfv6Oo7nQTV+EoJ6nnUODtpcmENScu/n3B6Ug91XhSX48yf7O1XpWiJlu35EqHm7voOY2IeFBcD+2vZNgG1HXrTO9DpG4fWptGU/5JBm/72S3tzI7pEmffFXDJ8noAQwn+85d/ez5nKRi4Qhu735tFXeApI+zZAZSguhS13FodieRKORCdUJt3N29OghP1f7p+zG/uZj20uB7kG1IQoMUrbHAHLv+G8j+RdgzYRpiFMV3N02wT5JJbnK7lJKOrHbftHDa80lylygB3k6/q+eOSpis42497rbtBGnvUst9EsV4NFln72Y5sXwpGfPTmngbRtknJMmSWXX8KiIh2B1ddsxbUWjA16jKwOru5K6ZcAXL8QljbsMRkP1Bgv1chca4gh8j1/VKmbpTSMbDhAqpSsdzu5MmNEwfEb/IxYXYbN93b/dDEONBMD36c2xBEdzuF8m8DrZT9YEmihVMj1GdKmp0l1PVd4a7xpaqft9FcUTZFMQzu9LGUxqQxgqC1nlIPdzdLTvJ/fTeF05WqyGE4nIFgxV2I01CxRXjU4n5sjKOHtjSPyS99oW96tL7Isxyb8Vks9Vtwt7YGZr4Glgw1S3Bc9vRcqbXSJRASgyw82WIpUAyprq85URnhUG9RjJTC+7eAcx37erz27PQ2GMk0w/X5M6BDDdpt/aAt8xtR6KdORpaAMsBnOVOl9lt7It2giZ2iUSsGQJTY15kt25XgzLjVL+RJAMLKI8DHAV0G0wQ3JOzhCc6IFMvkSg0iN6Pc03suYCP0IzX9XK81VlY30skTjhqb06YFVxLenV9rW2nnMSrN1s7GcZZvSjgow2+qb8e5NRqLZzAVgHMPO7FbaWNDJay+kqTODYid3WC370pqlw3JcRs70FW/5dQ6zQeDmZHa16IO1WKfDG2tV71iN3INXG3tZygYMSEKFQfTSTgENN96h1Q0MDRQGH3k8+Q5uZWw7U0BOY+PTH6Ve08tdIMyegkd11NwApFgJ6ecA21lCoyaJr1rp/5dav4hk/A+QqacJqSxA4majQI3ksmjh4b2UOhV2bNFjRhnEEUXsf/ntx/1eBouUQtpWwnYvYVUnbwjAuvl+XLs2WtaSFg8krAjvuJ2Awg9646dD2XjjXRyESLBSwj8w2l/533kRvj7SXY0zNM3f0/ioSn/ZcJiTc9C7xajjFLMjCpcUWZ6g0QTTDsaIOvqhceGf6h4i8OsKFPKdqHPmiU6E89NqEsSrq/qMDfuLzTlMzZJte8R7JX9dx5z7aXS0/ZvdwTIEV5WvOaWcZni4ifRkkN0KirQ1GHMd2W+DxkaIXiJfbATlU43fI5l+abOFzh7aU8ysJPmNcFE71OCgYR20TjozMNWSpUcngVENb5ee0ulFU46HJrYElXkGfoFvH1GkHwRh6yeuvc2tQIYQ9lOHKD36etl5cf5iikifaUPdPLojVi5sC8AaaL4Chktcz1gHnNeYA7HyqanNWoAllYKaDFJhO9EPk2g80HHe/X5tixJkrHknm3n0nPPMYU3Xu5mqgUUuDK3ikNPszmOf9xl5enHYMYgkmwciu04W2WfD0VnwrO7Ay9LuhB4lkP1ZcfsWWaZYhlBpHeDMYiGwvSFplcl3TbdSTG98/acZt3Dyf84IAP8fVo+7E2nIxx8I0rVZL0eDumNtvMNMuyZusFdBRoIW/fgOBBgu95ByryaV0+VjZGGKPw4w8IelaCJxW4tLbWRvO/7SvOTGhM4opwD3qWbEg0HYD8XOLLVilHqQlo6rfg1ApGixUyB2X3GgK/yfw/+iOAuQWpIKuMhf6mdUy+VG3ehJ2a16Z2l4D0Qg4VDnDzpuwy3PQNFbIqGIZJGSf88SJ3Y6+ZNHlzVLsUh2N5SDO1llN1uClRclvUJ02yryES70ruKdWlXnee9Ii/xBc3dzKYL/yXRRkWLYiZXPHOgjrpksOYvscZBTLlMKZjXu0IyPg2Jv63OFiira2xL5yTtcoypwfdTDzuhwtiTKy0YEGrchatgHaJZg9Tvhp1PZjnf2Xpx4xPUjn3aSgmUpLOxvL7RSjIbbP/o+q6BBWt9GjThqI3jUxCJKZXfmqNHyety4RPeJHgb+bhx4/ZYn6pXHwJSkhRmAgX/hsgA7W4FRELHTo4dYPv0TEQZxhRtBaJGlnCYB6VpM8y/sZzeWafXdPgLcbut4QHeDfITNJeg3dBJma4GF5qHaY+z71hkC71Nijl5FA5v04sto7I8IoNXwR4PzcdCW6jfxHwu2aZQXOVkQrg39Phs60yo9XK83o3nHRZWS8FS1qrzJc7j1qpakyN/+UwKw6vMLm2b30Gjn6L67scWAroCbD5bVzxxrfBwLh1XooDt3CEudbUTRyj3DiEC9WJCvFWuXL5sJIgLl/XFL15mU+CoJBjYcgK0H3voCN2uQhJXCk617yWLbbZIOj4/4qNXMuu87SicU0L8hoyxG4Z5ZMuI5h1ZTx3KMeMz7uesNgH76+s/HeHhWJ01iO6hh50Ef5Qi63BBu8J4GbqHa2ShbtPr7A7eJw1LrcKQ+XKtWsvwnOWZH8Evq1fg9ATj7MI5UGPoWOcVLBdRfSbzJkfZiPM5Vs2TeExCtbKbt1Mrqa6j1PGBJo1pRVz8SKAknMciiO/eGrq36hyCbJ/Lhfhfpm3pc+DXMKH04dkjX4aHDZOXGjdOZELUSIAMr7sm0pjApTeWJTSWKG1c+Y4LoK8brwyL8cYGQmXhQwUiDTH1wsQSHdAKZvn6XKSL1jJ5gS2xAovjqykiWhGha43q/NQegycjNk6L2Zyi0z+b4DfKItdTjbPVQHPumOmAU2ZOx7fgrylQ6pgwB1tvhR9OyLit/Gv7t0plg934DCbPIz4tgqJEYhJtsVZyEAyPMW08zlhptUMTYHO0LRc/sSSbxv5xSW03IsmCA4WdgpBrHV5gozOAsnOKnnepYS9NSY7ZTvBBvCrXH6pZWEP0vgdIOTjk++2C21K9Udq5mYFXhAmpkc5VWm61qO3mbdiVRgPnEaAKy5YvyL/Ned4RQGLuoBczKeDTDtlCg+gsgp/itq6FbXIl0wLiltdH0POJsSylHLrnRuyfPMXjhGmZZzf9FydpiTnBNO2Ogvw+YvZxTzXQFrFzUj0mCszRYtbyOWYFXlVWTWtEm8R3C052CSD5pmxNl4Pj+MLee6u/yuuZnCRa0z0f0hfXWMeWYVQJuQJyfDcrIzKzH6qSqv5VYJeJJJQMkjAQt1GJxVu3ZnkplC7EFldhMQfQ/zSWXqAhY0VjN6ckyy4OCdh3eeWz0IRQQ5LkurBSKy5Rq3fmaEJQ8rQnV3rWkZE3/dz0lSb1QmPFm+9r2gg51i6yPgMcmvYI3DpLpfnsIoJC9bANc0pNkxHBSfVQoJNIwgfxKlWQYvPyW6bOXDNw+ISZaXNplchDpCb+mfgFvLWPCZoJMfPB+P9ofWYyrwxbk/yzLOUSeU6MFquSdt6VR3b7J+5ccVgK5cpk8QixHITpI0W3jcCJbCYA1sswL9mYVfCV0Em8gqpZekYrwDkeVSifsmjLRsEqbWld0NWncBU+ZIz0oWZZ55GBjkGPtdOTuKr9iLQKcDvFOEx8IwSZn5nhX8eOz8RRilN3ypARq+wmOlHxzr0+e5i/0w2I8HC9o3dyL2Kj4P5UrzYDsl7eSiDaTxTtk0HIcy8laIKFP8jOFuAa8FwFZIoFmHFhRwz+6Qj23D0piXeWF6tKoHuFJiywjh3ymqHxHZ0SMNha7/nHGMqOJuVmQW4YDz6fshTx2GEVVc114bKG8LeSbnmussMViDY9UPmLqR71Gxwnmew7objbWZDlqHCa2XkpU8BPMCz2fh2G15GR+HHNhv6j5gboxs6OOMel91X959srkDcqm8fB6ssLHNl/WtbuYgWZxwWb7eKIUspiGmrCMwFgn8N5Vmo+9/486+LBoqHLJUwDnMUptMXdQ4i1l50EVAEIxWUAer53JWBl7twv1Q+IdwytEFSoV5Bz3KtnUNFc5nNvc3Z+scAv+RdNGmJ+4LuObwMWM2D6bWfXM8UkXx0De2x7tKoFRYzFpbbp8Ex0Dio72FGw6zki78MSl5iE+jyNP2d+cAa5JBHSJlFoWMdBeUMboZ5+CiQUW2kq/oVmYWd0kvtdIYhe7APPgMJxjlvZL034EMnVPJe7g0Sq4ImlxFVMiRJXnoOnlJd5MByB1v22dSoCpuMA+GB5gmpq+MGVs3GZ3k2SIHSh+BlO0nhUXhLyswk8AFVUeER3cthFj2OEUJTKwvmt5ivSbVy+1LACtMaRP078MbDfFGXPqTtLIKOOkDyLJv++FHLTFg6sR34dElx5uGXKHk3c1MsBf8zqqzF3lk4xkZ1zE7oHXhRbP5l9s0mCpMqTO5RNwEX6Sg7I/NAL5cimWcwlPxaAHWx6DpZ/A7Vn/VUeEjC8YNMqZd1xbRu6sSNYt+75AEygncmSWURdwPEsV+D2zpCYivcpVn8gzIcZREJJBKgpyrfwiXjLH9DXlZhtQinJdulmclOSjjWJCjw+wb1dhkTysjqImx0rYL3XCdIXmaTWJQ0wjTO3/L4Dt0EqRRz5/3W6DJSrgG7nOG1NBJ5QDnVlunZPZAX6afefQ7SLHUSeHKH1VOyTBm756HE1Kc1NcnPPyx/APAbFEZjvFKl7GaXeH90iY5lOlwmUKtZfWaRRqQuExOo0BkSXcWTaaZ0VhzuINIC5Jg9/WtCLKaMDXikCCzCtxwRlmW+16Ej/mvVx3wQJu1uP+OC2QkS1atocO46Bvy3XLH4hccsnC47+EecVcpKBtIEfqPoluAc4Ac7aOEiAZVKz4XfrVJBnE9Cny9LVt9woCKvQNJiImrOMmrQl0HOgbv4C1HzwRwtYqJvu3yXqApWZz1mTOZE21U3jHF5dat+pm9Q5Au2ZKSuMW0WFv0EsThq7iKxJfxBwh1IVQd7H6ClhCmC8rt1zWx/gMAHmMlBri4kI06FNahsx3ngMpMSx9HAfObIhJ3T+QzOWbFK6UkWVdmKZaIEnKK35F0wyR9CR/XYknt+P/b7yYIReCn0A30/G9yQ0Q3MonwYyOLfqHAMrk8bSM7dkYL85M8diUoE0ChG1lXG+rd8cnLUk2kHltH8+qqfOAQztM6JwHEh+f7RRDJtQCwAISWFKc8YjKoqZpzkXeC6dBGmLOMSGxUxvE/+GVNv17ZXhx4YZCrwtkRMQZbZ4yAa6GPPetUhsPLQ2WQenDw/9kBK/qk4Uz0/7vLwakInYyXmCZIM+v73H4HYqtk20vr4BZ0uBFHi6qcEA3uG+4R4bVZF/SMK6fUJX9PVQqhDYKVBoslxYGqdPxH3KlP9wpGUoW/bJkckyQoMTJD5NkDqm+Rb/dhVftb/tY/HXBDIPtfDlun18WSefuwqD0TBIBdgmUPgla48za2T2aW+tUw2+tfNB9X2tJ8U6EoaLPdPdfVhj2ng9SbPeiL+5k7LjC83ALk+Iuk9dwX+VkatsHvrCZFVoX5usq/duHtPkyCwwnxhPvHP/cQ/EmiWzL4iIf2684UCeGJnvFfiikvp95lo/ZJ4qcQdeeWBqyYeF9tQ+t7pXUZ9urEvLr+zBiOIM1d8st/H1PWHJidCTUwwLMz40tPv5vt9QTKN+UGIzBIuhNRRaN9PDuwLkjPgmw7MlTzlzspY/89D6JuNxx7Xxzr2dW//SdInJH7eojZ4ZRuOqFB7b08OXZg9KdDU8hDONpyv2QeaLJByGGnBF8SDauvn3WVPFC/c/jcD8SDC8rbhINc+0KTsJyKe5epXUEejy7ALkdjqYtXIj/uB9fS2nELbayRJZkHm1QmoSJYES6LjaBxvg5T0HompcN56XhzhGvd7Jljbc9xxr5EQcPAlBU5KvLrW8xWXBLsRCbcj1A+tMp5f0OltC5CeR7/efl7gkucrWV8XvJXu2Sb5baZJWeylIicWK2lfPEjXNbY7hKRgMKlYejCJRv1K5XSfz8btHxIMI+aFSGICldAuRZJzIZkDXraywG1JEuuwS5FAWNbp1xJQF3Ytkgz4pR0Cwuy2nNPWHyTKSW7jVSrqiLTt8VP6gyQm8f4FwSJcogd+StreMTnJMAeFCL9eoQs9uN9I10jiU7FYDJJjGp1JAjmlfSdWSXdwQz0rCjD5w8meNI/hXlsnC63VvPCEMhKDdCxujSapp2lUAyzzOvCbdTgF5ADqcDHybZGJEOKukV6QpGRsliaa2LCH/TnQwdD9R3xycemAeMtaB1Nc5n2BimINyO6Nn9KxnFS/7fScUJlWHHIF7o8Xs3w2ltZck4/LZLb6WGeaSHIqVExNj/yUuJW+9HmSViY6pMkaOA5i3qsprfCVD8S5PbpQ22kAK+UO2aLg2e6Zn6IjSJik3a5IuV7rBM5TWTi13CRQXYH3wfKxy7Y0NdlZcZc/AUmvV37KtcidLBkrpGPd5R6anhrlTC5Cb+RhGBdK0OZdLvz9PZ2kSOSMv3RNe9QtVZ12VhywpVfbnWBXQ8Km8O/4bzb+9wFMhW0WyiXzIYXwTcTmyk86C92Q8OZ7RBJlVuRnsNcxd43ipCWV/WGcMBHXZaJn1tvEeBOri6vgWbiDukrNtl4SGrhnfgqLpu1OBLWKhEfbE2+jt+FTGFY08UFersw/j7k67XiKKZ/DRM+yjiXV7/6YblcUWtNd1wU5EL6ttGRmSyazHwr/uCXjCdO+AvAnM50E8oIrL/fQCzL8+iXascRXDLi0T94n1gcm8OIEhi8olCbj9zIZ8fyt4R1kSRwh6OleHsl3k/g5h9oLaHAxmSYjC5TzNzbgRxMe5lqZUD4ZlZ+WCrijtvEu5610T/yU6uR0aMjCLWQpaj715J8UaIkqd3b73bPHexdgTSxOrPzG4oR0b5thJatfmYc8l+4be/DlSdzTrKOaKarg3bzSsZz07BrN9DZSfO0kM8l4DG0/kv24t7WOlkF40V5bcSG9BqJ423J81gaW7j1NHNB3AknvuUvbhgXrxkh6DcV2zR1C0uNDlbYzV9dX7lK2M1dXd5ky6un9ZrZnTbH/NNF2jCQ9RqLY7o6RhPYUTlL5/AAABXJJREFUiQP3w56gSby/pc1tfJpeVtlasAB7giZp2LY1xUYxcu+0cJx4OuwJmlh9Pfe8A8vYO8+x94uj/japzpaCcM+Q6B0cobjZ68uZ8FFiWyW+9z7wTzbxXtQ7LdyHlfeXlTOPJoFOTsS1eGp8u2hi96M+RUUIFLjrkoGz0oF2SHqlhfthSya9UsUE81geSr91MrV9ctL7y9vHO9ugv2Ia/m1q7GYkF4xRG9ycyP+03c4+0EgYLRyQsggMJF3d3UhsKZY5iScAbv3z9tphoJGIo+et/9cAOuW26z3b+xxk76+ZjrSDDHvl2g1IOloKIrsByfyeock2e/U7LydkKPEDx11oSJMhkqHuGnLXEMkQyRDJEMkAX3RIk4G7zCFNhkiGSIZIhkiGSIZIhkiGHuSQJkMPcohkiGSIZKiFh1p4SJMhkiGSoRYe0mSohYdIhkiGSIZIhki26RpW4AyRDLlryF1DJEMkQ4kf0mRIkyGSIZJ+XIqHFY80edFjf8nAIFFGoG6oM6KBIvursHFOUhWQCqbiUUg7QefCpAdxD2sejQPVIAVa+GmFQLyyzUjSmA0HZtnwLJU3pzdh1qltOiQSEL/F8t0Ge00HIwYGoPB7TCAp4A2kDd6MWRddy9afWbVtSBDK8F9GpAOpLE74DO6GIdIY1JD04H2SaEiI+IjN8NP+Dldp57gLR3emrusWs6TCqs5P+OZNDGT2A8WlI1AKZ7wkwcck4yZp3pVwXEJ1H101thfJd9hXqibMCQy62G5bMjW/ZUUFJArIcsRuytMQaXZqBQIxHTTW5keL8JeLoCV2SOIlnfinyNc4CGwrwuWV9V1JKz6eiBxE2vtWwhfcndVdjbE21boDaE+8kCalDj9gt++qu0tsfLZnKqq/SLLtlU7/e63JPRGFDVZN8WW6Un2hBW9VX9Ks7UYirMAsb9jFLnWWTfdzjd40Gz01pNJG6vilS9uMZKEOkQ4xQQF53R1TglShFyCttPj+2hjITsmJDTG/oUshNBTx8KXCurvTJjylTtYkqWjsiMSX8uBa8FZCyAxdL9ju2IbzPhp7iHo4ACXepXHcMhIbgWOu5wq5zvK3/Lw5GLqret20TqfRFrLdzMjfslNI6hTMCqrJ/g4b4K17K43d/Y4dLLrjSLxWA50zRdVF5KYKDxeFTCyFJNUBq5yKKBCWl3eKJnc0cqFK4eEknqESrrOq/Y48vCqYL+hUJgwMs+VYYS+IFECpsIPclbhAQaecQ9hY1tEobkPcIQpTXHHKpN9iKsybqTHdmQp93oPXPJu/sK67TXzbvRXQmDnTDP63qbCExsUGy47qYxEoUouTpf6FnaEJaqqsWPDIIncP+4cFUbDLkumwxxUUEIUHx0BsoEXIOYJiUQOEuoGyFVenmiVSPMsX64bZpH7HVvXfthv6d3WGZJgXHiIZIhkiGSIZIhkiGSIZ6Gu412HwruFehyGSIZIhkiGSIZJeXMM6yCFNhjQZIhkiGUr8kCZD7hp0mphD7hpy15AmbZHQIXcNuWuI5O+RFh5axiGSoT0ZctfQqx/SZIhkc0gcif1RHM3WKpodZ39esOL8D03SJEmSSZwmGk5DDNLggAcVqSJhibCP2EoC7IuOZsXZG/hHkjB2ZhamIcX+/B5kwMIeYMnXnvWn4GY2j0SiEUFJL0xe8k6eWEiXtJIGcOHQ2mhHNymP8LeH1+kZgFxmZSz8v/nKzRTcuqrP2v+i3zDPT1l3737m1pdufekeAqVbX7ztxXufvvfpR+974vD5w+fvSy6Pz83KFdlV3GtK2s/f5Y5c99Ngp4e2qkne0mefTIYDGkCmcRsXvoJh6W8fuHyAEdT0iSp5Q4kftOt/A4ghPSb9NVuBAAAAAElFTkSuQmCC";
		model<<[ChequeImage:chequeImageResponse.chqImage]; 
	}
	
	}
class UpdateCasaAccountNickNameCommand {
	String accountNumber, accountShortName;
	private static int SHORT_NAME_LENGTH = 25
	static constraints = {
	   accountNumber(blank: false)
	   accountShortName validator : { val,obj->
		   if(StringUtils.hasLength(val) && val?.matches("[a-zA-Z0-9 ]+")) {
			   if(val.length() > SHORT_NAME_LENGTH) {
				   obj.errors.rejectValue('accountShortName','accountShortName.invalid.error')
			   }
		   } else {
			   	obj.errors.rejectValue('accountShortName','accountShortName.invalid.error')
		   }
		   
	   } 
	}
}
class CasaAccountDetailedStatementCommand{
	String lastNTransactionFilter,monthFilter,fromDate,uptoDate,debitCreditFilter,fromAmountFilter,toAmountFilter,referenceNumberFilter;
	static constraints={
		debitCreditFilter validator:{val,obj ->
			
			if(StringUtils.hasLength(obj.fromAmountFilter)){
				if(!StringUtils.hasLength(obj.lastNTransactionFilter) && !StringUtils.hasLength(obj.monthFilter) && !StringUtils.hasLength(obj.fromDate) && !StringUtils.hasLength(obj.uptoDate)){
					obj.errors.rejectValue('debitCreditFilter','casaAccountDetailedStatementCommand.datemonthlastn.blank')
				}
				if(!StringUtils.hasLength(obj.toAmountFilter)){
					   obj.errors.rejectValue('debitCreditFilter','casaAccountDetailedStatementCommand.toAmountFilter.blank')
				}
			}else if(StringUtils.hasLength(obj.toAmountFilter)){
				if(!StringUtils.hasLength(obj.lastNTransactionFilter) && !StringUtils.hasLength(obj.monthFilter) && !StringUtils.hasLength(obj.fromDate) && !StringUtils.hasLength(obj.uptoDate)){
					obj.errors.rejectValue('debitCreditFilter','casaAccountDetailedStatementCommand.datemonthlastn.blank')
				}
				if(!StringUtils.hasLength(obj.fromAmountFilter)){
						   obj.errors.rejectValue('debitCreditFilter','casaAccountDetailedStatementCommand.fromAmountFilter.blank')
				}
			}
		};
		fromDate validator :{val,obj->               
			if(StringUtils.hasLength(obj.fromDate)){
				if(!StringUtils.hasLength(obj.uptoDate)){
					  obj.errors.rejectValue('fromDate','casaAccountDetailedStatementCommand.uptoDate.blank')
				}
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");   
				Date currentDate = formatter.parse(formatter.format(new Date()))
				Date date = obj.uptoDate ? (Date)formatter.parse(obj.uptoDate):null;   
				if(date.compareTo(currentDate)>0){
					obj.errors.rejectValue('fromDate','casaAccountDetailedStatementCommand.uptoDate.compare.error')
				}
			}else if(StringUtils.hasLength(obj.uptoDate)){    
					if(!StringUtils.hasLength(obj.fromDate)){
						 obj.errors.rejectValue('fromDate','casaAccountDetailedStatementCommand.fromDate.blank')
					}
					DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					Date currentDate = formatter.parse(formatter.format(new Date()))
					Date date = obj.uptoDate ? (Date)formatter.parse(obj.uptoDate):null;
					if(date.compareTo(currentDate)>0){
						obj.errors.rejectValue('fromDate','casaAccountDetailedStatementCommand.uptoDate.compare.error')
					}
			   }
		};
		
	}
}

