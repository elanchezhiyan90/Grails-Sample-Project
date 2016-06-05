import grails.util.Environment;

class UrlMappings {

	static mappings = {
		
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}
		
		"403"(controller: "errors", action: "error403")
		"404"(controller: "errors", action: "error404")
		"405"(controller: "errors", action: "error405")
		"500"(controller: "errors", action: "error500")
        
	}
}
