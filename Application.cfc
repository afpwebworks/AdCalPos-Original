<cfcomponent displayname="Application" output="no">
<cfsilent>
<!----
==========================================================================================================
Filename:     Application.cfc
Description:  Application file for AdCalPos
Date:         29/3/2010
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
<cfscript>
 This.name = "AdcalPos_00000021";
 This.clientmanagement="False";
 This.loginstorage="Session";
 This.sessionmanagement="True";
 This.sessiontimeout="#createtimespan(0,0,30,0)#";
 This.applicationtimeout="#createtimespan(5,0,0,0)#";
</cfscript>

<cfif cgi.HTTP_HOST contains "dev.shades">
	<cfset this.Siteversion = "development">
<cfelseif cgi.HTTP_HOST contains "adcalv1demo" >    
    <cfset this.Siteversion = "development">
<cfelseif cgi.HTTP_HOST contains "venture61.com" >
	<cfset this.Siteversion = "production">
<cfelse>
	<cfset this.Siteversion = "production">
</cfif>	 

<!----[  
============================================================================================================
Application start and end
============================================================================================================
 ]---->	

    <cffunction name="onApplicationStart"> 
    	<!--- Set up Application variables. Locking the Application scope is not necessary in this method. --->
		<cfset Application.datetimeConfigured = TimeFormat(Now(), "hh:mm tt") & "  " & DateFormat(Now(), "dd/mmm/yyyy")>
        <cfscript>
			Application = structNew();
			Application.siteversion = this.siteversion;
			Application.sessions = 0;
		</cfscript>
        	
<!----[  Start up the coldspring main component and feed it the bean definitions xml file.  Init the configbean.cfc will initialise all the application vars from the config.XML file or database]----> 
		<cfset application.BeanFactory = createObject("component","coldspring.beans.DefaultXmlBeanFactory").init()/>
		<cfset application.BeanFactory.loadBeansFromXmlFile(expandPath("/cfcs/config/Coldspring.xml"),true)/>
		<cfset application.beanfactory.getbean("configbean") />  

  <!---[    Check maintenance revision level   ]---->
        <cfquery name="qGetRevision" datasource="#application.dsn#" >
             SELECT Revision from tblOptions       
        </cfquery>
                  
       	<cfset application.Revision = qGetRevision.revision  />
       	
 		<cfreturn this>
	</cffunction>
	
    <cffunction name="onApplicationEnd" >
		
        
		<cfreturn true />
 	</cffunction>
    
 <!----[  
============================================================================================================
Session start and end
============================================================================================================
 ]---->	
 
    
    <cffunction name="onSessionStart" >
    	<cfset session.PosTXID = 99999 />
        <cfset session.errorhandler = application.beanfactory.getBean("ErrorHandler") />
        <cfif not isdefined("session.rollcount")>
			<cfset session.rollcount=1>
		</cfif>

 <!----[  Set up the default login bean for the guest user  ]---->
        <cfscript>
			session.User = application.beanfactory.getBean("User");
		</cfscript>  


		
		<cfreturn this />
 	</cffunction>
    
    <cffunction name="onSessionEnd" >
		
		<cfreturn this />
 	</cffunction>
    
 <!----[  
============================================================================================================
Request start and end
============================================================================================================
 ]---->	 
 	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<cfargument type="string" name="targetPage" required=true>
        <!---[   <cfif this.siteversion is "development"  >]---->
	        <cfsetting showdebugoutput="no" />
            <cfsetting requesttimeout="1500" />
         <!---[ </cfif>   ]---->
			<!--- RENEW APPLICATION VARIABLES --->
        <cfif structKeyExists(URL, "reset") AND URL.reset IS "Yes">
        	   <cfset applicationstop() />
               <cfset this.onApplicationStart()>
			   <cfset this.onSessionStart()> 
        </cfif>
       <!---[    Temporary variable assignments to allow backwards compatibility.   ]---->
        <cfset Applic_DBTYPE = "OLEDB">
		<cfset Applic_PROVIDER = "SQLOLEDB">
		<!--- user database --->
		<cfset Applic_dataSource =  application.dsn > 
		<!--- data source name --->
		<cfset Applic_PROVIDERDSN = application.dsn > 
		<!--- database related --->
		<cfset Applic_USERNAME = "">  
		<!--- database related --->
		<cfset Applic_PASSWORD = ""> 
		<!--- user database --->
		<cfset Applic_DBNAME = "adcalpos458975"> 
		<!--- database server name --->
		<cfset Applic_DBSERVER = ""> 
		<!--- application web root for this user ---> 
		<cfset Applic_WebRoot=application.approotURL> 
		<cfset Applic_AppRoot=application.approotABS & "\database\costi_SQL_EOD.mdb">
		<cfset Applic_DBRoot=application.approotABS & "\database\">
		<cfset AppProvider = "Microsoft.Jet.OLEDB.4.0">

        <cfset request.austime = application.beanfactory.getbean("configbean").getAustime() />
        <cfsetting showdebugoutput="no" /> 
        
           <!---[        Ensure there is a userobject in the session scope.  - if one doesnt already exist, create one that is not logged in.   ]---->
        <cfif NOT structKeyExists(session, "user")>
        	<cfset session.User = application.beanfactory.getBean("User") />
        </cfif>   
         
          <!----[  Check for login status and force login if required  ]---->
		 <cfif (session.user.getIsloggedIn() is false) >
         	 <cfif (cgi.SCRIPT_NAME DOES NOT Contain "Process.cfm") AND (cgi.SCRIPT_NAME DOES NOT Contain "process/maintenanceout")>
                <cfinclude template="/includes/ForceLogin.cfm" />
                <cfabort>
             </cfif>
		</cfif>         
		
		<cfreturn true>
	</cffunction>
    
  
	<cffunction name="onRequestEnd" returntype="void" output="true">
		<cfargument name="targetPage" required="true">
        
       <!--------[   <cfif session.user.getIsLoggedIn() and session.user.getSurname() is "Kear">
			<cfdump var="#session#" label="session vars. app.cfc line 159">
        	<cfdump var="#application#" label="application vars. app.cfc line 160">
        </cfif>  - MK ]------>
        
        
	</cffunction>
    
    	<!--- Begin OnRequest Method - Executes during the page request --->
<cffunction name="onRequest" returnType="void">
	<cfargument name="thePage" type="string" required="true">
	<cfinclude template="#arguments.thePage#">

</cffunction>
    
<!----[  
============================================================================================================
Error handling
============================================================================================================
 ]---->	    
    
<!---[   <cffunction name="onMissingTemplate" >
 <cflocation url="/cf/MainMenu.cfm" addtoken="no" /> 
</cffunction>
   ]---->
 

<!---[   <cffunction name="onError" returnType="void" output="true">
		<cfargument name="exception" required=true>
		<cfargument name="eventName" type="string" required=true>

		<cfmail to="#application.webmasteremail#" from="#application.webmasteremail#" subject="Error in #application.applicationName#" type="html" server="#application.mailserver#" username="#application.mailuser#" password="#application.mailpassword#">
		<cfoutput>
		<h2>An error occured in Shades 'n' Style</h2>
		<p>
		Page: #cgi.script_name#?#cgi.query_string#<br>
		Time: #dateFormat(request.austime, "d/m/yyyy")# at #lcase(timeFormat(request.austime, "h:mmtt"))#<br>
		</p>
		
		<cfdump var="#arguments.exception#" label="Exception">
		<cfdump var="#url#" label="URL">
		<cfdump var="#form#" label="Form">
		<cfdump var="#cgi#" label="CGI">
		</cfoutput>
		</cfmail>  

         <cfmail to="les.mustafa@gmail.com" from="#application.webmasteremail#" subject="Error in #application.applicationName#" type="html" server="#application.mailserver#" username="#application.mailuser#" password="#application.mailpassword#">
         <h2>An error occured in Shades 'n' Style</h2>
		<p>
		Page: #cgi.script_name#?#cgi.query_string#<br>
		Time: #dateFormat(request.austime, "d/m/yyyy")# at #lcase(timeFormat(request.austime, "h:mmtt"))#<br>
		</p>
        <p>The error message is: <br>
		[quote]<br>
        #arguments.exception.cause.message#<br>
        [/quote]
        </p>
         
         
         </cfmail>
		<!---[   <cflocation addtoken="no" url="/errorpages/errorpage.html" />
        <cfabort>   ]---->
				
	</cffunction>     ]----> 
    
</cfcomponent>