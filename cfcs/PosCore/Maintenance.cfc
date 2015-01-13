<cfcomponent displayname="Display name" output="no" hint="this is the function of this CFC">
<cfsilent>
<!----
==========================================================================================================
Filename:     Maintenance.cfc
Description:  Maintenance processor for automated product updates 
Date:         28/7/2010
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
	
	<cffunction name="getCurrentRevision" access="public" returntype="numeric" output="false" hint="Returns the current revision level from the tblOptions table." >
	 <cfset var Revision="0" />
		<cfquery name="qGetRevision" datasource="#application.dsn#" >
             SELECT Revision from tblOptions       
        </cfquery>
       	<cfset Revision = qGetRevision.revision  />
		<cfreturn Revision />
	</cffunction>
    
    <cffunction name="setCurrentRevision" access="public" returntype="void" output="false" hint="updates the table tblOptions with the revision level passed in." >
    <cfargument name="argsRevision" type="numeric" required="yes"  />
    <cfset var Revision = arguments.argsRevision />
    <cfset var qUpdateRevision = 0 />
    
    	<cfquery name="qUpdateRevision" datasource="#variables.dsn#" >
             UPDATE tblOptions  
             SET Revision = <cfqueryparam value="#revision#" cfsqltype="cf_sql_integer" />
        </cfquery>
        
    </cffunction>
	
</cfcomponent>