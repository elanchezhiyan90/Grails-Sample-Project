package com.vayana.ib.retail.web.service.common

import com.vayana.ib.retail.web.taglibs.exception.FileUploadException
class FileUploadService extends GenericService{
	
	void upload(InputStream inputStream, File file) {
		try {
			file << inputStream
		} catch (Exception e) {
			e.printStackTrace();
		 	throw new FileUploadException(e)
		}
	}
}
