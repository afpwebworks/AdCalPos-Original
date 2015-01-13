<cfcomponent displayname="tblStockBarcode DAO" output="false" hint="DAO Component Handles all Database access for the table tblStockBarcode.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    StockBarcodesDAO.cfc
Description: DAO Component Handles all Database access for the table tblStockBarcode.  Requires Coldspring v1.0
Date:        13/Jul/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( StockBarcode.getstockbarcodeid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="StockBarcodesDAO" output="false" hint="Initialises the controller">
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


<cffunction name="save" access="public" returntype="StockBarcode" output="false" hint="DAO method">
<cfargument name="StockBarcode" type="StockBarcode" required="yes" />
<!-----[  If a StockBarcodeID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.StockBarcode.getStockBarcodeID() neq "0")>	
		<cfset StockBarcode = update(arguments.StockBarcode)/>
	<cfelse>
		<cfset StockBarcode = create(arguments.StockBarcode)/>
	</cfif>
	<cfreturn StockBarcode />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="StockBarcode" type="StockBarcode" required="true" /> 
	<cfset var qStockBarcodeDelete = 0 >
<cfquery name="StockBarcodeDelete" datasource="#variables.dsn#" >
		DELETE FROM tblStockBarcode
		WHERE 
		StockBarcodeID = <cfqueryparam value="#StockBarcode.getStockBarcodeID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
     <!---[       Trigger the version number so there is a maintenance update   ]---->
   	<cfset variables.MonitorService.SetVersion() />
	
</cffunction>



<cffunction name="read" access="public" returntype="StockBarcode" output="false" hint="DAO Method. - Reads a StockBarcode into the bean">
<cfargument name="argsStockBarcode" type="StockBarcode" required="true" />
	<cfset var StockBarcode  =  arguments.argsStockBarcode />
	<cfset var QtblStockBarcodeselect = "" />
	<cfquery name="QtblStockBarcodeselect" datasource="#variables.dsn#">
		SELECT 
		StockBarcodeID, Partno, Barcode, DateEntered, ProductID
		FROM tblStockBarcode 
		WHERE 
		StockBarcodeID = <cfqueryparam value="#StockBarcode.getStockBarcodeID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QtblStockBarcodeselect.recordCount >
		<cfscript>
		StockBarcode.setStockBarcodeID(QtblStockBarcodeselect.StockBarcodeID);
         StockBarcode.setPartno(QtblStockBarcodeselect.Partno);
         StockBarcode.setBarcode( QtblStockBarcodeselect.Barcode  );
         StockBarcode.setDateEntered(QtblStockBarcodeselect.DateEntered);
         StockBarcode.setProductID(QtblStockBarcodeselect.ProductID);
		</cfscript>
	</cfif>
	<cfreturn StockBarcode />
</cffunction>
		

<cffunction name="GetAllStockBarcodes" access="public" output="false" returntype="query" hint="Returns a query of all StockBarcodes in our Database">
<cfset var QgetallStockBarcodes = 0 />
	<cfquery name="QgetallStockBarcodes" datasource="#variables.dsn#">
		SELECT StockBarcodeID, Partno, Barcode, DateEntered, ProductID
		FROM tblStockBarcode 
		ORDER BY StockBarcodeID
	</cfquery>
	<cfreturn QgetallStockBarcodes />
</cffunction>


<cffunction name="GetBarcodesforProduct" access="public" output="false" returntype="query" hint="Returns a query of all StockBarcodes in our Database for a specific part no">
<cfargument name="argsPartNo" type="string" />
<cfset var PartNo = arguments.ArgsPartNo />
<cfset var allStockBarcodes = querynew("StockBarcodeID,Partno,Barcode", "integer,varchar,varchar") />
<cfset var QgetallStockBarcodes = 0 />

	<cfquery name="QgetallStockBarcodes" datasource="#variables.dsn#">
		SELECT StockBarcodeID, Partno, Barcode, ProductID
		FROM tblStockBarcode 
        Where PartNo = <cfqueryparam value="#PartNo#" cfsqltype="cf_sql_varchar" />
		ORDER BY StockBarcodeID
	</cfquery>
    <cfif  QgetallStockBarcodes.recordcount >
    	<cfreturn QgetallStockBarcodes />
    <cfelse>    
    	<cfreturn allStockBarcodes />
    </cfif>
	
</cffunction>

<cffunction name="UpdateBarcodesforPartNo" access="public" returntype="any" output="no" hint="Updates the collection of barcodes for a partno">
<cfargument name="argsbarcodelist" type="string" required="yes" />
<cfargument name="argspartno" type="string" required="yes" />
<cfargument name="argsProductID" type="string" required="yes" />
<!---[ <cfargument name="argsErrorHandler" type="any" required="yes" />      ]---->
<cfset var barcodelist = arguments.argsbarcodelist />
<cfset var partno = arguments.argspartno />
<cfset var ProductID = arguments.argsProductID />
<cfset var qcheckAllGone.barcodecount = 0 />
<!---[ <cfset var errorhandler = arguments.argsErrorHandler />  ]---->

<!---[   Check there arent any barcodes in the database with that value for another partno  ]---->
<!---[<cfquery name="qcheckAllGone" datasource="#variables.dsn#">                             
select count(*) as barcodecount from tblstockbarcode
where barcode in (  #barcodelist# )  AND
PartNo <> <cfqueryparam value="#partno#" cfsqltype="cf_sql_varchar" />
</cfquery>

<cfif qcheckAllGone.barcodecount GT 0 >
     <cfset errorhandler.setError("Barcode", "Barcode: one or more of the barcodes is used in another productID.  Please check.  Barcodes must be unique.") />    
<cfelse>     ]---->

<!---[   First,  delete the existing barcode collection for this partno   ]---->
<cfquery name="deleteCodes" datasource="#variables.dsn#">
Delete from tblstockbarcode 
WHERE partno = <cfqueryparam value="#partno#" cfsqltype="cf_sql_varchar" />
</cfquery>

                         

	<!---[   Then add the new one by looping over the list and insert each.   ]---->
    <cfloop list="#barcodelist#" index="barcode">
        <cfquery name="qStockBarcodeInsert" datasource="#variables.dsn#" >
            INSERT into tblStockBarcode
            ( Partno, Barcode, DateEntered, ProductID ) VALUES
            (
            <cfqueryparam value="#partno#" cfsqltype="CF_SQL_VARCHAR" />,
            <cfqueryparam value="#barcode#" cfsqltype="CF_SQL_VARCHAR" />,
            <cfqueryparam value="#variables.austime#" cfsqltype="CF_SQL_TIMESTAMP" />,
            <cfqueryparam value="#ProductID#" cfsqltype="CF_SQL_INTEGER" />
            ) 
        </cfquery>
    </cfloop>
<!---[     </cfif>      ]---->
 <!---[    <cfreturn errorhandler />    ]---->
  <!---[       Trigger the version number so there is a maintenance update   ]---->
    	<cfset variables.MonitorService.SetVersion() />
</cffunction>

<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="StockBarcode" output="false" hint="DAO method">
<cfargument name="argsStockBarcode" type="StockBarcode" required="yes" displayname="create" />
	<cfset var qStockBarcodeInsert = 0 />
	<cfset var StockBarcode = arguments.argsStockBarcode />
	
	<cfquery name="qStockBarcodeInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
        INSERT into tblStockBarcode
		( Partno, Barcode, DateEntered, ProductID ) VALUES
		(

		<cfqueryparam value="#StockBarcode.getpartno()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockBarcode.getbarcode()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#variables.austime#" cfsqltype="CF_SQL_TIMESTAMP" />,
        <cfqueryparam value="#StockBarcode.getProductID()#" cfsqltype="CF_SQL_INTEGER" />
		   ) 
		SELECT Ident_Current('tblStockBarcode') as StockBarcodeID
		SET NOCOUNT OFF
	</cfquery>
	<cfset StockBarcode.setStockBarcodeID(qStockBarcodeInsert.StockBarcodeID)>
    <!---[       Trigger the version number so there is a maintenance update   ]---->
    <cfset variables.MonitorService.SetVersion() />
	<cfreturn StockBarcode />
</cffunction>

<cffunction name="update" access="private" returntype="StockBarcode" output="false" hint="DAO method">
<cfargument name="argsStockBarcode" type="StockBarcode" required="yes" />
	<cfset var StockBarcode = arguments.argsStockBarcode />
	<cfset var StockBarcodeUpdate = 0 >
	<cfquery name="StockBarcodeUpdate" datasource="#variables.dsn#" >
		UPDATE tblStockBarcode SET
        partno  = <cfqueryparam value="#StockBarcode.getPartno()#" cfsqltype="CF_SQL_VARCHAR"/>,
        barcode  = <cfqueryparam value="#StockBarcode.getBarcode()#" cfsqltype="CF_SQL_VARCHAR"/>,
        dateentered  = <cfqueryparam value="#variables.austime#" cfsqltype="CF_SQL_TIMESTAMP"/>,
        ProductID  = <cfqueryparam value="#StockBarcode.getProductID()#" cfsqltype="CF_SQL_INTEGER" />
					
		WHERE 
		StockBarcodeID = <cfqueryparam value="#StockBarcode.getStockBarcodeID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	 <!---[       Trigger the version number so there is a maintenance update   ]---->
    <cfset variables.MonitorService.SetVersion() />
	<cfreturn StockBarcode />
</cffunction>

</cfcomponent>