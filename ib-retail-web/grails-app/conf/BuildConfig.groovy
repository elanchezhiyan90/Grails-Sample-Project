import grails.util.BuildSettings;
import grails.util.BuildSettingsHolder;
import grails.util.GrailsUtil;

grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
	//if you would like to continue using Grails regular commands like run-app, test-app and so on 
	//then you can tell Grails' command line to load dependencies from the Maven pom.xml file instead.
	legacyResolve false
    // inherit Grails' default dependencies
    inherits("global") {
        grailsSettings.dependenciesExternallyConfigured = true
		// specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
	pom true
    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        //grailsCentral()
        mavenLocal()
        //mavenCentral()
		mavenRepo "http://192.168.12.48:9080/nexus/content/groups/public/"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
    }

    plugins {
        
    }
}
grails.server.port.http = 9090
//grails.project.fork.run= [maxMemory:1024, minMemory:64, debug:true, maxPerm:512]
grails.project.fork.run=false
grails.tomcat.jvmArgs = ["-server", "-XX:MaxPermSize=512m", "-XX:MaxNewSize=256m", "-XX:NewSize=256m",
	"-Xms256m", "-Xmx512m", "-XX:SurvivorRatio=128", "-XX:MaxTenuringThreshold=0",
   "-XX:+UseTLAB", "-XX:+UseConcMarkSweepGC", "-XX:+CMSClassUnloadingEnabled",
   "-XX:+CMSIncrementalMode", "-XX:-UseGCOverheadLimit", "-XX:+ExplicitGCInvokesConcurrent"]


// Remove the JDBC jar before the war is bundled
grails.war.resources = { stagingDir ->
  delete(file:"${stagingDir}/WEB-INF/lib/validation-api-1.0.0.GA.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/tomcat-juli-7.0.47.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/tomcat-jdbc-7.0.47.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/tomcat-embed-logging-log4j-7.0.47.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/ojdbc6-11.2.0.3-jdk16.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jta-1.1.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jboss-transaction-api_1.1_spec-1.0.1.Final.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/hamcrest-core-1.1.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/servlet-api-2.5.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/junit-4.11.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jsp-api-2.1.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-all-8.1.8.v20121106.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-all-7.6.0.v20120127.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/btm-jetty7-lifecycle-2.1.3.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/btm-2.1.3.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/btm-jetty-lifecycle-2.1.3.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/stax-api-1.0-2.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/javassist-3.7.ga.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/javassist-3.10.0.GA.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/bcprov-jdk15-1.45.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/asm-3.3.1.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/cglib-2.2.2.jar")
  
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-all-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-client-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-continuation-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-http-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-io-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-jmx-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-security-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-server-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-servlet-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-servlets-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-util-7.6.9.v20130131.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jetty-websocket-7.6.9.v20130131.jar")
  
  
  delete(file:"${stagingDir}/WEB-INF/lib/bm-infra-tx-btm-1.0-SNAPSHOT.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/jtds-1.2.8.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/javax.servlet-2.5.0.v201103041518.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/geronimo-javamail_1.4_spec-1.7.1.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/geronimo-servlet_2.5_spec-1.2.jar")
  
  delete(file:"${stagingDir}/WEB-INF/lib/c3p0-0.9.1.2.jar")
  delete(file:"${stagingDir}/WEB-INF/lib/xercesImpl-2.9.1.jar")
  
}