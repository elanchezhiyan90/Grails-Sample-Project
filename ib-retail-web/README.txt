-server -Xms256m -Xmx784m -XX:MaxPermSize=256m


-server -Xms256m -Xmx784M -XX:MaxPermSize=256m -javaagent:${env_var:GRAILS_HOME}/lib/org.springsource.springloaded\springloaded-core\jars\springloaded-core-1.1.1.jar -noverify -Dspringloaded=profile=grails

MSSQL DB CONNECTION PROPERTIES

<!-- For MSSQL DB Connection -->
	
	<New id="khcbCustomerDs" class="org.eclipse.jetty.plus.jndi.Resource" >
        <Arg>jdbc/khcbCustomerDs</Arg>
        <Arg>
           <New class="com.mchange.v2.c3p0.ComboPooledDataSource">
                <Set name="driverClass">net.sourceforge.jtds.jdbc.Driver</Set>
     <!--          <Set name="jdbcUrl">jdbc:jtds:sqlserver://192.168.12.46:1433/KHCBP1</Set>
                <Set name="user">app_khcb_user_web</Set>
                <Set name="password">app_khcb_user_web</Set>  -->
     <Set name="jdbcUrl">jdbc:jtds:sqlserver://192.168.12.46:1433/IRBP1</Set>
	<Set name="user">IRB_APP_USER</Set>
	<Set name="password">IRB_APP_USER</Set>  
            </New>
        </Arg>
    </New>
    <New id="demoCustomerDs" class="org.eclipse.jetty.plus.jndi.Resource" >
        <Arg>jdbc/demoCustomerDs</Arg>
        <Arg>
            <New class="com.mchange.v2.c3p0.ComboPooledDataSource">
                <Set name="driverClass">net.sourceforge.jtds.jdbc.Driver</Set>
              <!--  <Set name="jdbcUrl">jdbc:jtds:sqlserver://192.168.12.46:1433/KHCBP1</Set>
                <Set name="user">app_khcb_user_web</Set>
                <Set name="password">app_khcb_user_web</Set>  -->
    <Set name="jdbcUrl">jdbc:jtds:sqlserver://192.168.12.46:1433/IRBP1</Set>
	<Set name="user">IRB_APP_USER</Set>
	<Set name="password">IRB_APP_USER</Set> 
            </New>
        </Arg>
    </New>
    
	<New id="sbiCustomerDs" class="org.eclipse.jetty.plus.jndi.Resource" >
        <Arg>jdbc/sbiCustomerDs</Arg>
        <Arg>
           <New class="com.mchange.v2.c3p0.ComboPooledDataSource">
                <Set name="driverClass">net.sourceforge.jtds.jdbc.Driver</Set>
              <!--   <Set name="jdbcUrl">jdbc:jtds:sqlserver://192.168.12.46:1433/KHCBP1</Set>
                <Set name="user">app_khcb_user_web</Set>
                <Set name="password">app_khcb_user_web</Set>  --> 
	<Set name="jdbcUrl">jdbc:jtds:sqlserver://192.168.12.46:1433/IRBP1</Set>
	<Set name="user">IRB_APP_USER</Set>
	<Set name="password">IRB_APP_USER</Set> 
            </New>
        </Arg>
    </New>
    
    ^\d*(\.\d{2}$)?
    http://jsfiddle.net/NfMQ7/178/