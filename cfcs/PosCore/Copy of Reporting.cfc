<cfcomponent displayname="Reporting" output="no" hint="Reporting engine for AdCalPos">
<cfsilent>
<!----
==========================================================================================================
Filename:     Reporting.cfc
Description:  Reporting engine for AdCalPos
Date:         8/4/2010
Author:       Michael Kear

Revision history: 
13/4/2010  Modified SalesReport query orderby and groupby lines as requested by client.- MK

==========================================================================================================
--->
</cfsilent>
   
<cffunction name="init" access="Public" returntype="Reporting" output="false" hint="Initialises the controller">
	<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

    
	
<cffunction name="SalesReport" access="public" returntype="query" output="yes" hint="Returns the data for the sales report" >
	<cfargument name="argsStartDate" type="date" required="no" />
    <cfargument name="argsEndDate" type="date" required="no" />
    <cfargument name="argsStoreID" type="any" required="no" default="All" />
		<cfset var StartDate = arguments.argsStartDate />
		<cfset var EndDate = arguments.argsEndDate />
        <cfset var StoreID = arguments.argsStoreID />
        <cfset var QueryResult = 0 />

      <cfquery name="QueryResult"  datasource="#variables.dsn#">
        SELECT 
       	 Pos.StoreID, 
		 Pos.LocationID,
         Pos.TerminalID, 
		 Pos.PosType,
         Pos.TransDate,
            sum(Pos.CostTotal) as SalesCost, 
            SUM(Pos.LineSaleTotal) AS SalesGross, 
		    sum(Pos.DiscountTotal) as Salesdiscount, 
		sum(pos.SubTotalSurcharge + ItemSurchargeTotal) as SalesSurcharge,
		    sum(Pos.TaxTotal) as TaxTot,
            SUM(Pos.SaleTotal) AS SalesNet 

            FROM Pos 
            
            WHERE 0=0 AND
          
            (
            Pos.TransDate >= <cfqueryparam value="#StartDate#" cfsqltype="cf_sql_timestamp" /> And  
            Pos.TransDate <= <cfqueryparam value="#EndDate#" cfsqltype="cf_sql_timestamp" />)
            AND NOT Pos.PosType IN (255, 11, 12, 13, 14, 15)
            <cfif NOT ListfindNoCase(storeID,  "All" )>
            	AND POS.StoreID in ( #StoreID#  ) 
            </cfif>
  
            
            GROUP BY Pos.StoreID, POS.locationid, Pos.TerminalID, Pos.PosType , Pos.TransDate   
            ORDER BY Pos.TransDate, storeid, locationid, terminalid, PosType   
        </cfquery>

		<cfreturn QueryResult />
	</cffunction>
	
    <cffunction name="getStores" access="public" returntype="query" output="no" hint="Returns details of the stores.">
    	<cfargument name="argsStoreID" type="any" required="no" default="All" />
        <cfset var StoreID = arguments.argsStoreID />
    	<cfset var QueryResult = 0 />
                
        <cfquery name="QueryResult"  datasource="#variables.dsn#">
        	Select * from dbo.tblStores
            WHERE 0=0 
            <cfif NOT ListFindNoCase(StoreID, "all")>
			  and storeID in ( #StoreID# ) 
		</cfif>
        </cfquery>
        <cfreturn QueryResult />
    </cffunction>
    
    <cffunction name="getStoreName" access="public" returntype="string" output="no" hint="Gets the store name, given a storeID">
    	<cfargument name="argsSToreID" required="yes" type="numeric"  />
        <cfset var StoreID = arguments.argsStoreID />
        <cfset var qstorename = "" />
        <cfquery name="qstorename"  datasource="#variables.dsn#">
        	select Storename from dbo.tblStores 
            WHERE storeid = <cfqueryparam value="#StoreID#" cfsqltype="cf_sql_numeric" />
        </cfquery>
        
        <cfreturn qstorename.storename />
        
    </cffunction> 
    
    
    <cffunction name="getECSTotals" access="public" output="no" returntype="query" hint="returns a query for the production of the daily takings report.">
    <cfargument name="argsStartDate" required="yes" type="date" />
    <cfargument name="argslngStoreID" required="no" default="All" />
    <cfset var qECSTotals = 0 />
    <cfset var StartDate = arguments.argsStartDate />
    <cfset var lngStoreID = arguments.argslngStoreID />
    
    <cfquery name="qECSTotals" datasource="#variables.dsn#">
    SELECT *
    FROM tblStore_ECRTotals
    WHERE 0=0
    <cfif lngStoreID neq "All">
	    AND (tblStore_ECRTotals.StoreID IN(#lngStoreID#)) 
    </cfif>
    AND date = <cfqueryparam value="#createodbcdate(startdate)#" cfsqltype="cf_sql_date" />
    </cfquery>
    
    <cfreturn qECSTotals />    
    </cffunction>
    
    <cffunction name="SalesItemReport" access="public" returntype="query" output="yes" hint="Returns the data for the sales report" >
	<cfargument name="argsStartDate" type="date" required="no" />
    <cfargument name="argsEndDate" type="date" required="no" />
    <cfargument name="argsStoreID" type="any" required="no" default="All" />
		<cfset var StartDate = arguments.argsStartDate />
		<cfset var EndDate = arguments.argsEndDate />
        <cfset var StoreID = arguments.argsStoreID />
        <cfset var QueryResult = 0 />
       <!---[   <cfquery name="QueryResult"  datasource="#variables.dsn#" debug="yes" result="TheSQL">
        Select * from POSline
        </cfquery>     ]---->
      <cfquery name="QueryResult"  datasource="#variables.dsn#">
        SELECT 
       	 Pos.StoreID, 
		 Pos.LocationID,
         Pos.TerminalID, 
		 Pos.PosType,
         Pos.TransDate,
            SUM(PosLine.Quantity) AS SalesQty, 
            SUM(PosLine.SellExt) AS SalesGross, 
            SUM(CASE WHEN PosLine.DiscountType = 0 THEN PosLine.DiscountExt ELSE 0 END) 
            		+ SUM(PosLine.MixMatchExt) 
                    + SUM(PosLine.SubTotalDiscountExt)  AS SalesDiscount, 
            SUM(CASE WHEN PosLine.DiscountType = 1 THEN PosLine.DiscountExt ELSE 0 END) 
            		+ SUM(PosLine.SubTotalSurchargeExt)  AS SalesSurcharge, 
            SUM(PosLine.SaleExt) AS SalesNet 
            
            FROM Pos RIGHT JOIN PosLine ON Pos.PosTxID = PosLine.PosTxID 
            
            WHERE 0=0 AND
          
            (
            Pos.TransDate >= <cfqueryparam value="#StartDate#" cfsqltype="cf_sql_timestamp" /> And  
            Pos.TransDate <= <cfqueryparam value="#EndDate#" cfsqltype="cf_sql_timestamp" />)
            AND NOT Pos.PosType IN (255, 11, 12, 13, 14, 15)
            <cfif NOT ListfindNoCase(storeID,  "All" )>
            	AND POS.StoreID in ( #StoreID#  ) 
            </cfif>
  
            
            GROUP BY Pos.StoreID, POS.locationid, Pos.TerminalID, Pos.PosType , Pos.TransDate   
            ORDER BY Pos.TransDate, storeid, locationid, terminalid, PosType   
        </cfquery>

		<cfreturn QueryResult />
	</cffunction>
    
</cfcomponent>

