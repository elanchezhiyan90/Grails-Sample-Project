import org.apache.log4j.ConsoleAppender
import org.apache.log4j.Level
import org.apache.log4j.PatternLayout
import org.apache.log4j.rolling.RollingFileAppender
import org.apache.log4j.rolling.TimeBasedRollingPolicy
import org.codehaus.groovy.grails.validation.ConstrainedProperty
import com.vayana.ib.retail.web.constraint.IBANConstraint

// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

ConstrainedProperty.registerNewConstraint(IBANConstraint.CONSTRAINT_NAME, IBANConstraint.class)

grails.config.locations = [
		com.vayana.ib.retail.web.config.GlobalConfig,
		com.vayana.ib.retail.web.config.PageOverridesConfig,
		"classpath:com/vayana/ib/retail/web/config/usercredentials.properties"
		]
	
	
// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }
// the default value is true
grails.databinding.trimStrings = false
// the default value is true
grails.databinding.convertEmptyStringsToNull = false
grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
    all:           '*/*',
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*','/themes/*']

// The default codec used to encode data with ${}
grails.views.default.codec = "html" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.dbconsole.enabled = false

//log4j
def log4jConsoleLogLevel = Level.WARN
def log4jAppFileLogLevel =  Level.INFO
 
environments {
    development {
		log4jConsoleLogLevel =  Level.DEBUG
		log4jAppFileLogLevel =  Level.DEBUG
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
    }
}

// log4j configuration
log4j = {
	println "Log4j consoleLevel: ${log4jConsoleLogLevel} appFile Level: ${log4jAppFileLogLevel}"
	
	def logLayoutPattern = new PatternLayout("%d [%t] [%X{userName}] %-5p %c %x - %m%n")
	
	def console = new ConsoleAppender(name: "console", threshold: log4jConsoleLogLevel, layout: logLayoutPattern)
	
	def appRollingFile = new RollingFileAppender(name: 'appAppender', threshold: log4jAppFileLogLevel, layout: logLayoutPattern)
	def appRollingPolicy = new TimeBasedRollingPolicy(fileNamePattern: 'logs/customer/backup/app.log.%d{yyyy-MM-dd}.gz', activeFileName: 'logs/customer/app.log')
	appRollingPolicy.activateOptions()
	appRollingFile.setRollingPolicy(appRollingPolicy)
	appRollingFile.activateOptions();
	
	
	def errorRollingFile = new RollingFileAppender(name: 'errorAppender', threshold: Level.ERROR, layout: logLayoutPattern)
	def errorRollingPolicy = new TimeBasedRollingPolicy(fileNamePattern: 'logs/customer/backup/error.%d{yyyy-MM-dd}.gz', activeFileName: 'logs/customer/error.log')
	errorRollingPolicy.activateOptions()
	errorRollingFile.setRollingPolicy(errorRollingPolicy)
	errorRollingFile.activateOptions();
	
    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',             // plugins
		   'org.apache.camel',
		   'net.sf.ehcache',
		   'org.codehaus.btm',
		   //commented for high CPU utilisation in IB Prod server.
		  // 'org.hibernate.envers',
		   'org.apache.camel',
		   'org.springframework.security'
		   
	info   'org.atmosphere',
		   'com.google.common.eventbus',
		   'org.springframework.cache',
		   'org.springframework.transaction',
		   'org.springframework.scheduling.quartz',
		   'org.apache.commons.configuration',
		   'org.springframework.aop.interceptor',
		   'org.apache.cxf',
		   'org.milyn',
		   'org.springframework.security',
		   'org.eclipse.jetty'
		   
		   
    debug  'com.vayana.bm',
		   'com.vayana.ib',
		   'org.hdiv',
		   'org.apache.camel'
		   
	trace   'com.vayana.bm.statistics'
			//'org.hibernate.type.descriptor.sql'
	
	appenders {
		appender appRollingFile
		appender errorRollingFile
		appender console
	}
	
	root {
		 error 'appAppender', 'errorAppender', 'console'
		 debug 'appAppender', 'errorAppender', 'console'
		 info  'appAppender', 'errorAppender', 'console'
		 //error 'errorAppender', 'console'
		 additivity = true
	}
}


facebook {
	page.connectedHome = "http://localhost:9090/ib-retail-web/home/homepage"
}

fileUpload {
	/*String javaTempDir = System.getProperty("java.io.tmpdir")
	location = javaTempDir + '/UploadedFiles/'*/
	location="D:\\fileupload\\"
}

simpleCaptcha {
	// font size used in CAPTCHA images
	fontSize = 30
	height = 200
	width = 200
	// number of characters in CAPTCHA text
	length = 6

	// amount of space between the bottom of the CAPTCHA text and the bottom of the CAPTCHA image
	bottomPadding = 16

	// distance between the diagonal lines used to obfuscate the text
	lineSpacing = 5

	// the charcters shown in the CAPTCHA text must be one of the following
	chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
	
	storeInSession = true
}

showcaptcha{
	sbi{
		userRegistration{
			userRegistration="y"
		}
		user{
			prelogin="y"
		}
		user{
			forgotPassword="y"
		}
	}
}

validatecaptcha{
	sbi{
		home{
			homepage="y"
		}
		/*userRegistration{
			userRegistration="y"
		}
		user{
			forgotPassword="y"
		}*/
//		Commented to validate captcha in webflow service level
	}
}

//values are pojo, http, jms
bmclient.deployment.strategy=""

//Beneficiary limit configuration,values are true, false
beneficiary.limit.display=false
//Login Secure Color Validate config
secure.color.required = false
// Quick Pay module Disabled for PMCB
beneficiary.quickpay.required = false

// Time interval to enable the Resend OTP
otp.resend.interval=15000

grails {
	plugin {
		hdiv {
			config {
				debugMode='true'
				startPages = [GET: '/,/tenant/index,/user/index,user/logout,/home/homepage', POST: '/user/prelogin,/j_spring_security_filter']
				errorPage = '/errors/securityerror'
				sessionExpired =[
					[loginPage: '/tenant/index', homePage: '/']
				]
				reuseExistingPageInAjaxRequest='true'
			}

			validations = [
				[id: 'safeText', acceptedPattern: '^[a-zA-Z0-9@.\\-_]*$']
			]

			editableValidations = [
				[id: 'editableParametersValidations', registerDefaults: true,
					validationRules: [
						[url: '/home/.*', enableDefaults: true,  validationIds: 'safeText'],
						[url: '/account/.*', enableDefaults: true,  validationIds: 'safeText']
					]
				]
			]
		}
	}
}

grails.gorm.default.constraints = {
	reminderDescriptionSize(nullable: false, blank: false, size: 1..50)
	remarksConstraint(size: 0..50)
	shortNameConstraint(size : 1..25)
	nameOnCardConstraint(size : 1..50)
	ibUserLoginNameConstraint(size : 5..20)
	requiredNumericConstraint(nullable: false, blank: false, matches: "[0-9]+")
	numericConstraint(nullable: false, blank: false,matches: "(^(0{0,1}|([1-9][0-9]*))(\\.[0-9]{1,3})?)")
	
	}

// AES Encryption Decryption properties used for securing form submission values
security.aes.iv="F27D5C9927726BCEFE7510B1BDD3D137"
security.aes.salt="3FF2EC019C627B945225DEBAD71A01B6985FE84C95A70EB132882F88C0A59A55"
security.aes.keySize=128
security.aes.iterations=1024
security.aes.passPhrase="khcbformsubmission"
reports.url="http://irb-test.pmcb.com:9081/ib-retail-reports/reports"

//XFRAME OPTIONS CONFIG
//grails.plugin.xframeoptions.deny = true
grails.plugin.xframeoptions.sameOrigin = true
grails.plugin.xframeoptions.enabled = true

//Browser Detection browsers version 
browserdetection.ie.version="9"
browserdetection.chrome.version="15"
browserdetection.safari.version="5.1"
browserdetection.firefox.version="10"
browserdetection.opera.version="12"
