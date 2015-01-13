<cfcomponent displayname="tblStockPrice DAO" output="false" hint="DAO Component Handles all Database access for the table tblStockPrice.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    StockPricesDAO.cfc
Description: DAO Component Handles all Database access for the table tblStockPrice.  Requires Coldspring v1.0
Date:        8/Dec/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( StockPrice.getpriceid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="StockPricesDAO" output="false" hint="Initialises the controller">
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

<cffunction name="setMaintenanceMonitor" access="public" output="false" returntype="void" hint="Dependency: Maintenance Monitor Service">
	<cfargument name="MaintenanceMonitor" type="any" required="true"/>
	<cfset variables.MonitorService = arguments.MaintenanceMonitor/>
</cffunction>

<cffunction name="save" access="public" returntype="StockPrice" output="false" hint="DAO method">
<cfargument name="StockPrice" type="StockPrice" required="yes" />
<!-----[  If a PriceID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.StockPrice.getPriceID() neq "0")>	
		<cfset StockPrice = update(arguments.StockPrice)/>
	<cfelse>
		<cfset StockPrice = create(arguments.StockPrice)/>
	</cfif>
    <cfreturn StockPrice />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="StockPrice" type="StockPrice" required="true" /> 
	<cfset var qStockPriceDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qStockPriceDelete" datasource="#variables.dsn#" >
		UPDATE tblStockPrice
		Set IsVisible = '0'
		WHERE 
		PriceID = <cfqueryparam value="#StockPrice.getPriceID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
     <!---[       Trigger the version number so there is a maintenance update   ]---->
	<cfset variables.MonitorService.SetVersion() />

</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="StockPrice" type="StockPrice" required="true" /> 
	<cfset var qStockPriceUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qStockPriceDelete" datasource="#variables.dsn#" >
		UPDATE tblStockPrice
		Set IsVisible = '1'
		WHERE 
		PriceID = <cfqueryparam value="#StockPrice.getPriceID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>	
     <!---[       Trigger the version number so there is a maintenance update   ]---->
	<cfset variables.MonitorService.SetVersion() />

</cffunction>


<cffunction name="read" access="public" returntype="StockPrice" output="false" hint="DAO Method. - Reads a StockPrice into the bean">
<cfargument name="argsStockPrice" type="StockPrice" required="true" />
	<cfset var StockPrice  =  arguments.argsStockPrice />
	<cfset var QtblStockPriceselect = "" />
	<cfquery name="QtblStockPriceselect" datasource="#variables.dsn#">
		SELECT 
		PriceID, Description, IsVisible, DateAdded, AddedBy, DateUpdated, UpdatedBy
		FROM tblStockPrice 
		WHERE 
		IsVisible = '1' AND
        PriceID = <cfqueryparam value="#StockPrice.getPriceID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QtblStockPriceselect.recordCount >
		<cfscript>
		StockPrice.setPriceID(QtblStockPriceselect.PriceID);
         StockPrice.setDescription(QtblStockPriceselect.Description);
         StockPrice.setIsVisible(QtblStockPriceselect.IsVisible);
         StockPrice.setDateAdded(QtblStockPriceselect.DateAdded);
         StockPrice.setAddedBy(QtblStockPriceselect.AddedBy);
         StockPrice.setDateUpdated(QtblStockPriceselect.DateUpdated);
         StockPrice.setUpdatedBy(QtblStockPriceselect.UpdatedBy);
         
		</cfscript>
	</cfif>
	<cfreturn StockPrice />
</cffunction>
		

<cffunction name="GetAllStockPrices" access="public" output="false" returntype="query" hint="Returns a query of all StockPrices in our Database">
<cfset var QgetallStockPrices = 0 />
	<cfquery name="QgetallStockPrices" datasource="#variables.dsn#">
		SELECT PriceID, Description, IsVisible, DateAdded, AddedBy, DateUpdated, UpdatedBy
		FROM tblStockPrice 
		WHERE IsVisible = '1'
		ORDER BY Description
	</cfquery>
	<cfreturn QgetallStockPrices />
</cffunction>



<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="StockPrice" output="false" hint="DAO method">
<cfargument name="argsStockPrice" type="StockPrice" required="yes" displayname="create" />
	<cfset var qStockPriceInsert = 0 />
	<cfset var StockPrice = arguments.argsStockPrice />
	
	<cfquery name="qStockPriceInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into tblStockPrice
		( Description, IsVisible, DateAdded, AddedBy, DateUpdated, UpdatedBy ) VALUES
		(

		<cfqueryparam value="#StockPrice.getdescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockPrice.getisvisible()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> ,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/> 
		   ) 
		SELECT Ident_Current('tblStockPrice') as PriceID
		SET NOCOUNT OFF
	</cfquery>
	<cfset StockPrice.setPriceID(qStockPriceInsert.PriceID)>
     <!---[       Trigger the version number so there is a maintenance update   ]---->
	<cfset variables.MonitorService.SetVersion() />


	<cfreturn StockPrice />
</cffunction>

<cffunction name="update" access="private" returntype="StockPrice" output="false" hint="DAO method">
<cfargument name="argsStockPrice" type="StockPrice" required="yes" />
	<cfset var StockPrice = arguments.argsStockPrice />
	<cfset var StockPriceUpdate = 0 >
	<cfquery name="StockPriceUpdate" datasource="#variables.dsn#" >
		UPDATE tblStockPrice SET
description  = <cfqueryparam value="#StockPrice.getDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
isvisible  = <cfqueryparam value="#StockPrice.getIsVisible()#" cfsqltype="CF_SQL_BIT"/>,
dateupdated  = <cfqueryparam value="#variables.config.getAustime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="CF_SQL_VARCHAR"/>
						
		WHERE 
		PriceID = <cfqueryparam value="#StockPrice.getPriceID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	 <!---[       Trigger the version number so there is a maintenance update   ]---->
	<cfset variables.MonitorService.SetVersion() />

    
	<cfreturn StockPrice />
</cffunction>

</cfcomponent>
