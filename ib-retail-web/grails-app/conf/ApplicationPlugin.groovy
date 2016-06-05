import grails.util.Environment

import org.springframework.orm.jpa.support.OpenEntityManagerInViewFilter
import org.springframework.web.filter.DelegatingFilterProxy

import com.vayana.bm.infra.security.listener.TenantHttpSessionEventPublisher
import com.vayana.bm.infra.security.listener.TenantHttpSessionListener
import com.vayana.ib.retail.web.context.WebApplicationEventListener
import com.vayana.ib.retail.web.service.common.ApplicationContextHolder
import com.vayana.ib.retail.web.service.common.BmClient

class ApplicationPlugin {
	// List of resources - "file:./grails-app/jobs/**"
	 def watchedResources = []
	 // List of plugins to load this "plugin" after
	 def loadAfter = ["controllers", "services","compress","gsp-resources"]
	 // Observe the following plugins - meaning the onChange event will be
	 //  called after their onChange event
	 def observe = []
	 // The artefact handlers to register
	 def artefacts = []
 
	 // See Grails plugin documentation for examples on how to use these
	 def doWithWebDescriptor = {xml ->
		
        def contextParam = xml.'context-param'
        contextParam[contextParam.size() - 1] + {
			
			'filter' {
				'filter-name'('springSecurityFilterChain')
					'filter-class'(DelegatingFilterProxy.name)
			}
			
			'filter' {
				'filter-name'('oemInViewFilter')
					'filter-class'(OpenEntityManagerInViewFilter.name)
					'init-param' {
						'param-name'('entityManagerFactoryBeanName')
						'param-value'('entityManagerFactory')
					}
			}
        }
        // Place the Spring Security filters after the Spring character encoding filter, otherwise the latter filter won't work.
        def filter = xml.'filter-mapping'.find { it.'filter-name'.text() == "charEncodingFilter" }
        if (!filter) {
            int i = 0
            int siteMeshIndex = -1
            xml.'filter-mapping'.each {
                if (it.'filter-name'.text().equalsIgnoreCase("sitemesh")) {
                    siteMeshIndex = i
                }
                i++
            }
            
            if (siteMeshIndex > 0) {
                filter = xml.'filter-mapping'[siteMeshIndex - 1]
            }
            else if (siteMeshIndex == 0 || xml.'filter-mapping'.size() == 0) {
                def filters = xml.'filter'
                filter = filters[filters.size() - 1]
            }
            else {
                // Simply add this filter mapping to the end.
                def filterMappings = xml.'filter-mapping'
                filter = filterMappings[filterMappings.size() - 1]
            }
        }

        // Finally add the springSecurityFilterChain filter mapping after the selected insertion point.
        filter + {
			
			'filter-mapping' {
				'filter-name'('springSecurityFilterChain')
				'url-pattern'('/*')
				'dispatcher'('ERROR')
				'dispatcher'('REQUEST')
			}
			
			'filter-mapping' {
				'filter-name'('oemInViewFilter')
				'url-pattern'("/*")
			}
		}
		
		def listenerloc = xml.'listener'
		listenerloc[listenerloc.size() - 1] + {
		  'listener' {
			'listener-class' (TenantHttpSessionListener.name)
		  }

		  'listener' {
			  'listener-class' (TenantHttpSessionEventPublisher.name)
		  }
		  
		  
		  'listener' {
			  'listener-class' (WebApplicationEventListener.name)
		  }
		  
		  'listener'{
			  'listener-class' ('org.springframework.security.web.session.HttpSessionEventPublisher')
		  }
		  
		  'listener'{
			  'listener-class' ('net.sf.ehcache.constructs.web.ShutdownListener')
		  }

		}
		
		def servletloc = xml.'servlet'
		servletloc[servletloc.size() - 1] + {
			'servlet'{
				'servlet-name'('remoting')
				'servlet-class'('org.springframework.web.servlet.DispatcherServlet')
				'load-on-startup'('2')
			}
			
		}
		
		def servletMappingloc = xml.'servlet-mapping'
		servletMappingloc[servletMappingloc.size() - 1] + {
			'servlet-mapping'{
				'servlet-name'('remoting')
				'url-pattern'('/remoting/*Service')
			}
			
			if (Environment.current == Environment.PRODUCTION) {
				'session-config'{
					'session-timeout'(5)
				}
			}else{
				'session-config'{
					'session-timeout'(10)
				}
			}
		}	 	
		
    }
	 
	 def doWithSpring = {
		 def deploymentStrategy =  "${application.config.bmclient.deployment.strategy}"
		 println "BM Deployment Strategy : " + deploymentStrategy;
		 
		 applicationContextHolder(ApplicationContextHolder) { bean ->
			bean.factoryMethod = 'getInstance'
		 }
	
		 bmClient(BmClient){
				userService= ref("userService${deploymentStrategy}Client")
				beneficiaryService= ref("beneficiaryService${deploymentStrategy}Client")
				iBCommonService= ref("iBCommonService${deploymentStrategy}Client")				
				accountService= ref("accountService${deploymentStrategy}Client")
				paymentService= ref("paymentService${deploymentStrategy}Client")
				creditCardService = ref("creditCardService${deploymentStrategy}Client")
				prepaidCardService = ref("prepaidCardService${deploymentStrategy}Client")
				loanService = ref("loanService${deploymentStrategy}Client")
				investmentService = ref("investmentService${deploymentStrategy}Client")
				workflowService = ref("workflowService${deploymentStrategy}Client")
				serviceRequestService = ref("serviceRequestService${deploymentStrategy}Client")
				billerService = ref("billerService${deploymentStrategy}Client")
				iBUserService = ref("iBUserService${deploymentStrategy}Client")
				billPaymentService = ref("billPaymentService${deploymentStrategy}Client")
				twoFactorService = ref("twoFactorService${deploymentStrategy}Client")
				portfolioService = ref("portfolioService${deploymentStrategy}Client")
				reminderService  = ref("reminderService${deploymentStrategy}Client")
				messageCenterService  = ref("messageCenterService${deploymentStrategy}Client")
				applyLoanService  	  = ref("applyLoanService${deploymentStrategy}Client")
				notificationService  = ref("notificationService${deploymentStrategy}Client")
				goalService  = ref("goalService${deploymentStrategy}Client")
				bulkPaymentService = ref("bulkPaymentService${deploymentStrategy}Client")
		 }
	 }
 
	 def doWithDynamicMethods = { ctx ->
	 }
 
	 def doWithApplicationContext = { applicationContext ->
	 }
 
	 def onChange = { event ->
	 }
 
	 def onConfigChange = { event ->
	 }
 
}
