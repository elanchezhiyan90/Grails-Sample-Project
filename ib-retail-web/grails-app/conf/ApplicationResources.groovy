modules = {
    application {
        resource url:'js/application.js'
    }
	
	commonBody{
		resource url: 'js/libs/jquery-1.8.2.min.js'		
		resource url: 'js/libs/jquery.carousel.js'		
		resource url: 'js/libs/jquery-ui-1.9.1.custom.min.js'
		resource url: 'js/shim/polyfiller.js'
		resource url: 'js/shim/cssfx.min.js'
		//resource url: 'js/shim/extras/custom-validity.js'
		resource url: 'js/app/pluginsconf.js.gsp'
		resource url: 'js/application.js'
		resource url: 'js/app/encypform.js'		
		resource url: 'js/app/pager.js'
		resource url: 'js/app/moment.js'
		resource url: 'js/security/crypto-js/sha512.js'
		resource url: 'js/security/crypto-js/aes.js'
		resource url: 'js/security/aes-js/aes.js'
		resource url: 'js/security/aes-js/AesUtil.js'
		resource url: 'js/security/aes-js/pbkdf2.js'
		resource url: 'js/libs/jquery.idletimeout.js'
		resource url: 'js/libs/jquery.idletimer.js'
	}
	
	mainLayoutHead{
		
	}
	
	appLayoutHead{
		resource url:'js/app/fileuploader.js'
		resource url:'/css/uploader.css'
	}
	
	mainLayoutBody{
		resource url: 'js/layout/layout-script.js'
	}
	fullcalendar{
		dependsOn 'commonBody'
		resource url:'js/app/fullcalendar.min.js'
	}
	
	chart{
		dependsOn 'commonBody'
		resource url: 'js/app/jquery.jqplot.min.js'
		resource url: 'js/app/jqplot.pieRenderer.min.js'
	}
	
	payment{
		dependsOn 'commonBody'
		resource url: 'js/app/payment.js'
	}
	
	fileuploader {
		resource url:'/js/fileuploader.js'
		resource url:'/css/uploader.css'
	}
}