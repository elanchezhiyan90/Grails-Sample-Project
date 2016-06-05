atmospherePlugin {
    servlet {
    	// Servlet initialization parameters
    	// Example: initParams = ['org.atmosphere.useNative': 'true', 'org.atmosphere.useStream': 'false']
    	initParams = ['org.atmosphere.useNative': 'true', 'org.atmosphere.useStream': 'false', 'org.atmosphere.useWebSocket':'true']
    	urlPattern = '/atmosphere/*'
    }
    handlers {
    	// This closure is used to generate the atmosphere.xml using a MarkupBuilder instance in META-INF folder
    	atmosphereDotXml = {
        	//'atmosphere-handler'('context-root': '/atmosphere/chat', 'class-name': 'com.odelia.grails.plugins.atmosphere.ChatAtmosphereHandler')
    	}
    }
}