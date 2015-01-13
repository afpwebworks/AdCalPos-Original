<cfcomponent displayname="MaintenanceMonitor" output="no" hint="Triggers the maintenance update version numbers">
<cfsilent>
<!----
==========================================================================================================
Filename:     MaintenanceMonitor.cfc
Description:  Triggers the maintenance update version numbers
Date:         13/10/2010
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
     <cffunction name="init" access="public" returntype="component" output="false" hint="This is called by the framework and automatically maps variables in the current event to the instance variables of this bean.">
	<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>
	
	<cffunction name="SetVersion" access="public" returntype="boolean" output="false" hint="Updates the version number in the tblOptions record, to flag an update required." >
		<cfset var qUpdateQuery="0" />
        <cfset result = true />
        <!---[   Sets the revision number in the tblOptions record to the current app revision plus 1    ]---->
        <cftry>
        <cfquery name="qUpdateQuery" datasource="#variables.dsn#">
        	Update tblOptions set Revision = Revision + '1' 
        </cfquery>
		<cfcatch type="any">
        	<cfset result=false />
        </cfcatch>
        </cftry>    
        <cfreturn result />
	</cffunction>
	
</cfcomponent>