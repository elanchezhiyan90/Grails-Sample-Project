package com.vayana.ib.retail.web.controller.common
import grails.converters.JSON
import org.springframework.http.HttpStatus
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.springframework.web.multipart.MultipartFile

import com.vayana.bm.common.security.SecurityUtils;
import com.vayana.ib.retail.web.service.common.FileUploadService;
import com.vayana.ib.retail.web.taglibs.exception.FileUploadException
import org.codehaus.groovy.grails.commons.GrailsApplication;
import javax.servlet.http.HttpServletRequest

class FileUploadController extends GenericController {
	FileUploadService fileUploadService
	GrailsApplication grailsApplication
	
	def upload = {
		try {
			println params;   
			StringBuffer tenantPath = getTenantFilePath(params);
			String fileName = params.qqfile;
			File uploaded = createTemporaryFile(tenantPath, fileName);
			InputStream inputStream = selectInputStream(request)
			fileUploadService.upload(inputStream, uploaded)    
			return render(text: [success:true] as JSON, contentType:'text/json')
		} catch (FileUploadException e) {
			return render(text: [success:false] as JSON, contentType:'text/json')
		}
	}

	private InputStream selectInputStream(HttpServletRequest request) {
		if (request instanceof MultipartHttpServletRequest) {
			MultipartFile uploadedFile = ((MultipartHttpServletRequest) request).getFile('qqfile')
			return uploadedFile.inputStream
		}
		return request.inputStream
	}
	
	private File createTemporaryFile(StringBuffer filePath, String fileName) {
		File fullPath=  new File(filePath.toString());
		if (!fullPath.exists()) {
			fullPath.mkdirs();
		}
		String fullPathFileName = filePath.append("/").append(fileName).toString();
		File uploadedFile = new File(fullPathFileName)
        return uploadedFile
	}
}