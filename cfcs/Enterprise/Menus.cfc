<cfcomponent displayname="Display name" output="no" hint="this is the function of this CFC">
<cfsilent>
<!----
==========================================================================================================
Filename:     Menus.cfc
Description:  Menu manager for AdCalPos Enterprise
Date:         28/9/2010
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
<cffunction name="init" access="Public" returntype="Menus" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>

<cffunction name="getMainMenuHeadings" access="public" returntype="query" output="no" hint="Returns a query of the menus to allow access for this user.  Requires a valid logged in user object">
	<cfset var user = variables.UserService.getUser() />
	<cfset var qMenus = 0 />

    <cfquery name="qMenus" datasource="#variables.dsn#">
        SELECT qryMainMenuGroup.UserTypeID, qryMainMenuGroup.MainHeading
        FROM qryMainMenuGroup
        WHERE qryMainMenuGroup.UserTypeID = <cfqueryparam value="#user.getusertypeID()#" cfsqltype="cf_sql_integer" />
        ORDER BY qryMainMenuGroup.HeadingOrder
    </cfquery>
	<cfreturn qMenus />
 </cffunction>
 
 <cffunction name="getMenuItems" access="public" returntype="query" output="no" hint="Returns a query of the detail menu items in the main menu page. Requires a valid logged in user, and a main menu heading">
  <cfargument name="argsMenuHeading" required="yes" type="string" />
	<cfset var user = variables.UserService.getUser() />
    <cfset var MenuHeading = arguments.argsMenuHeading />
	<cfset var qMenuItems = 0 />
 
 
     <cfquery name="qMenuItems" datasource="#application.dsn#" > 
        SELECT 
        	qryMainMenu.UserTypeID, 
        	qryMainMenu.MainHeading, 
            qryMainMenu.TaskName, 
            qryMainMenu.FormName, * 
		FROM qryMainMenu 
        WHERE 
        qryMainMenu.UserTypeID = <cfqueryparam value="#user.getusertypeID()#" cfsqltype="cf_sql_integer" /> AND 
        qryMainMenu.MainHeading = <cfqueryparam value="#MenuHeading#" cfsqltype="cf_sql_varchar" />
         
        ORDER BY qryMainMenu.UserTypeID, qryMainMenu.HeadingOrder, qryMainMenu.FormOrder        
		</cfquery>
        <cfreturn qMenuItems />        
</cffunction>
	

	
</cfcomponent>