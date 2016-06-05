package com.vayana.ib.retail.web.controller

import java.security.cert.CertificateException
import java.security.cert.X509Certificate

import javax.net.ssl.SSLContext
import javax.net.ssl.TrustManager
import javax.net.ssl.X509TrustManager

import org.apache.http.HttpEntity
import org.apache.http.HttpHost
import org.apache.http.HttpResponse
import org.apache.http.NameValuePair
import org.apache.http.client.HttpClient
import org.apache.http.client.entity.UrlEncodedFormEntity
import org.apache.http.client.methods.HttpPost
import org.apache.http.client.protocol.HttpClientContext
import org.apache.http.impl.client.CloseableHttpClient
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.impl.client.HttpClients
import org.apache.http.message.BasicNameValuePair
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value

import com.vayana.bm.common.security.SecurityUtils
import com.vayana.bm.core.api.beans.common.Invoker
import com.vayana.ib.retail.web.controller.common.GenericController

class ReportsController extends GenericController {
	
	@Value('${ib.web.reports.url}')
	private String reportsUrl;
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	/**
	 * 
	 * @return
	 */
	def download(){
		logger.info("***********Welcome to Report Controller Download Action***********")
		String reportFormat 				= 		params.ReportFormat;
		logger.info("Requested Report Format :::::"+reportFormat)               
		Invoker invoker						= 		SecurityUtils.getInvoker();           
		Map<String,String> requestParams 	= 		request.getParameterMap();
		List<NameValuePair> nameValuePairs 	= 		new ArrayList<NameValuePair>(requestParams.size());
		String tenantName 					= 		invoker.tenantShortDescription.toLowerCase();
		logger.info("Requested Report Tenant Name :::"+tenantName)
		String reportName 					= 		tenantName +"/" + params.ReportName
		logger.info("Requested Report Name :::"+reportName)
		nameValuePairs.add(new BasicNameValuePair("ulpID", invoker.getUserLoginProfileId().toString()));
		logger.info("User Login Profile Id :::"+invoker.getUserLoginProfileId())
		nameValuePairs.add(new BasicNameValuePair("userSessionID", invoker.getSessionId().toString()));
		logger.info("User Session Id :::"+invoker.getSessionId())
		for (Map.Entry<String, String> entry : requestParams.entrySet()) {
			if ("ReportName".equals(entry.getKey().toString())){
				nameValuePairs.add(new BasicNameValuePair(entry.getKey().toString(), reportName));
			}else{
				String val 		= 		entry.getValue().toString();
				val 			= 		val.replace("[", "").replace("]", "");
				nameValuePairs.add(new BasicNameValuePair(entry.getKey().toString(), val));
			}
		}
		HttpResponse httpResponse 		= 		getHttpResponse(nameValuePairs);
		HttpEntity entity 				= 		httpResponse.getEntity();
		if (entity != null) {
			long len 					= 		entity.getContentLength();
			InputStream inputStream 	= 		entity.getContent();
			reportName 					= 		reportName.substring(reportName.indexOf("/") + 1, reportName.indexOf("."));
			String fileName				=		reportName+ "." + reportFormat ;
			response.setContentType("application/"+reportFormat );
			response.setHeader('Content-Disposition',"attachment; filename="+tenantName+"_"+fileName);
			response.outputStream << inputStream;
		}
		
		
	}
	/**
	 * 
	 * @param nameValuePairs
	 * @return
	 */
	private HttpResponse getHttpResponse(List<NameValuePair> nameValuePairs){
		HttpResponse httpResponse = null;
		logger.info("REPORTS URL -----> "+reportsUrl);
		if(!reportsUrl.startsWith("https")){
			HttpClient httpclient	 = 	new DefaultHttpClient();
			HttpPost post			 = 	new HttpPost (reportsUrl);
			post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
			httpResponse			 = 	httpclient.execute(post);
		} else {
			CloseableHttpClient httpclient 	= 	null;
			URL url 						= 	new URL(reportsUrl);
			HttpHost target 				= 	new HttpHost(url?.host, url?.port, url?.protocol);
			//CredentialsProvider credsProvider = getCredentialsProvider(target,userName, password);
			httpclient						= 	prepareHttpClient("https");
			HttpClientContext context 		= 	getClientContext(target);
			HttpPost post 					= 	new HttpPost (url?.path);
			post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
			httpResponse 					= 	httpclient.execute(target,post,context);
		}
		return httpResponse;
	}
	/**
	 * 
	 * @param protocol
	 * @return
	 * @throws Exception
	 */
	private CloseableHttpClient prepareHttpClient(String protocol)throws Exception {
		CloseableHttpClient httpclient = null;
		if ("https".equalsIgnoreCase(protocol)) {
			httpclient = HttpClients.custom().setSslcontext(sslContext()).build();      
		} else	{
			httpclient = new DefaultHttpClient();
		}
		return httpclient;
	}
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	private SSLContext sslContext() throws Exception {
		SSLContext sc = SSLContext.getInstance("SSL");
		sc.init(null,  [new AllPassTrustManager()] as TrustManager[] , null);    
		return sc;
	}
			
	/**
	 * 	
	 * @param target
	 * @return
	 * @throws Exception
	 */
	private HttpClientContext getClientContext(HttpHost target)	throws Exception {
		HttpClientContext localContext = HttpClientContext.create();
		return localContext;
	}

}
/**
 * 
 * @author elanchezhiyan
 *
 */
public class AllPassTrustManager implements TrustManager, X509TrustManager {
	public X509Certificate[] getAcceptedIssuers() {
		return null;
	}
		
	public void checkServerTrusted(X509Certificate[] certs, String authType)throws CertificateException {
		return;
	}
		
	public void checkClientTrusted(X509Certificate[] certs, String authType)throws CertificateException {
		return;
	}
}
