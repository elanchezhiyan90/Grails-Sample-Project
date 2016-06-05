package com.vayana.ib.retail.web.controller.common

import com.vayana.bm.common.security.SecurityUtils

class FileDownloadController extends GenericController {
	def downloadFromFile={
		String downloadFile = params.downloadFile;
		StringBuffer fullpath = getTenantFilePath(params);
		File file = new File(fullpath.append("/").append(downloadFile).toString())
		if (file.exists()) {
		   response.setContentType("application/octet-stream")
		   response.setHeader("Content-disposition", "filename=${file.name}")
		   response.outputStream << file.bytes
		   return
		}
	}
}
