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
7/6/2010  revised getECSTotals() query to remove createodbcdate() function to get correct record selection.

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


<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
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
    
    
    <cffunction name="SalesReportPaymentType" access="public" returntype="query" output="yes" hint="Returns the data for the sales report with subtotals for paymenttype" >
	<cfargument name="argsStartDate" type="date" required="no" />
    <cfargument name="argsEndDate" type="date" required="no" />
    <cfargument name="argsStoreID" type="any" required="no" default="All" />
		<cfset var StartDate = arguments.argsStartDate />
		<cfset var EndDate = arguments.argsEndDate />
        <cfset var StoreID = arguments.argsStoreID />
        <cfset var QueryResult = 0 />

      <cfquery name="QueryResult"  datasource="#variables.dsn#">
        SELECT  
        Pos.TransDate, 
        Pos.StoreID, 
        Pos.LocationID, 
        Pos.TerminalID, 
        m.mediaid, 
        Pos.PosType,  
        sum(m.MediaEXT) as SalesNet,
        sum(m.mediachange) as Change 

            FROM Pos, PosMedia m 
            
            WHERE 0=0 AND
            Pos.Postxid=m.postxid and
            (
            Pos.TransDate >= <cfqueryparam value="#StartDate#" cfsqltype="cf_sql_timestamp" /> And  
            Pos.TransDate <= <cfqueryparam value="#EndDate#" cfsqltype="cf_sql_timestamp" />)
            AND NOT Pos.PosType IN (255, 11, 12, 13, 14, 15)
            <cfif NOT ListfindNoCase(storeID,  "All" )>
            	AND POS.StoreID in ( #StoreID#  ) 
            </cfif>
            GROUP BY Pos.StoreID, POS.locationid, Pos.TerminalID, Pos.PosType , Pos.TransDate, m.mediaid   
            ORDER BY Pos.TransDate, storeid, locationid, terminalid, m.mediaid, PosType   
        </cfquery>

		<cfreturn QueryResult />
  </cffunction>
    
  <cffunction name="SalesProductsStores" access="public" output="no" returntype="query" hint="Returns the query for the ProductSales by Department and Stores report.">
       <cfargument name="argsStartDate" type="date" required="no" />
       <cfargument name="argsEndDate" type="date" required="no" />
       <cfargument name="argsStoreID" type="any" required="no" default="All" />
       <cfset var StoreID = arguments.argsStoreID />
       <cfset var QueryResult = 0 />
       <cfset var StartDate = arguments.argsStartDate />
	   <cfset var EndDate = arguments.argsEndDate />
        
        <cfquery name="QueryResult"  datasource="#variables.dsn#">
        SELECT 
            p.storeID,
            p.locationid,
            p.terminalid,
            mp.Description,
            mp.productid,
            p.postype,
            p.TransDate,
            sum(P.CostTotal) as SalesCost, 
            SUM(P.LineSaleTotal) AS SalesGross, 
            sum(P.DiscountTotal) as Salesdiscount, 	
            sum(p.SubTotalSurcharge + ItemSurchargeTotal) as SalesSurcharge,
            sum(P.TaxTotal) as TaxTot,
            SUM(P.SaleTotal) AS SalesNet 
            
            FROM dbo.Pos p, dbo.PosMixMatchProduct mp 
            
            WHERE  p.postxid=mp.postxid  
            and
            (
            P.TransDate >= <cfqueryparam value="#StartDate#" cfsqltype="cf_sql_timestamp" /> And  
            P.TransDate <= <cfqueryparam value="#EndDate#" cfsqltype="cf_sql_timestamp" />)
            AND NOT P.PosType IN (255, 11, 12, 13, 14, 15)
            <cfif NOT ListfindNoCase(storeID,  "All" )>
            	AND P.StoreID in ( #StoreID#  ) 
            </cfif>
            
            GROUP BY P.StoreID, P.locationid, P.TerminalID, P.PosType , P.TransDate,  
            		mp.productid,   mp.Description  
            ORDER BY  p.locationid, p.storeid,  mp.productid  

  		</cfquery>

       <cfreturn QueryResult />
</cffunction>
    
 <cffunction name="getMediaType" access="public" returntype="string" output="no" hint="Returns a string representing the media type associated with a mediaID code">
    <cfargument name="argsMediaID" required="yes" type="numeric" />
    <cfset var MediaID = arguments.argsMediaID />
    <cfset var MediaString = "" />
    <cfswitch expression="#mediaID#" >
    	<cfcase value="1"><cfset MediaString = "Cash" /></cfcase>
        <cfcase value="2"><cfset MediaString = "EFTPOS" /></cfcase>
        <cfcase value="3"><cfset MediaString = "Credit Card" /></cfcase>
        <cfcase value="4"><cfset MediaString = "Other" /></cfcase>
        <cfcase value="5"><cfset MediaString = "NotUsed Code 5" /></cfcase>
        <cfcase value="6"><cfset MediaString = "NotUsed Code 6" /></cfcase>
        <cfcase value="7"><cfset MediaString = "NotUsed Code 7" /></cfcase>
        <cfcase value="8"><cfset MediaString = "NotUsed Code 8" /></cfcase>
        <cfcase value="9"><cfset MediaString = "Charge" /></cfcase>
    </cfswitch>
    <cfreturn MediaString />
 </cffunction>
    
	
    <cffunction name="getStores" access="public" returntype="query" output="no" hint="Returns details of the stores.">
    	<cfargument name="argsStoreID" type="any" required="no" default="All" />
        <cfargument name="argsEmployeeID" type="any" required="no" default="0" />
         <cfargument name="argsUserTypeID" type="any" required="no" default="2" />
        <cfset var UserTypeID = arguments.argsUserTypeID />
        <cfset var EmployeeID = arguments.argsEmployeeID />
        <cfset var StoreID = arguments.argsStoreID />
    	<cfset var QueryResult = 0 />
      
  		<!---[   Level 3 employees (UserTypeID=3) can only see the stores in their own state   ]---->
       <cfif  UserTypeID GTE '3'>
            <cfquery name="QueryResult"  datasource="#variables.dsn#">
                Select s.* from dbo.tblStores s, tblemployee e
                WHERE 0=0 
                AND e.storeid=s.storeid
                <cfif NOT ListFindNoCase(StoreID, "all")>
                  and s.storeID in ( #StoreID# ) 
                </cfif>
                <cfif UserTypeID eq 3>
                    and s.state = e.state
                    AND e.employeeid = <cfqueryparam value="#EmployeeID#" cfsqltype="cf_sql_integer" />
                </cfif>
            </cfquery>
        <cfelse>
        
                <cfquery name="QueryResult"  datasource="#variables.dsn#">
                    Select s.* from dbo.tblStores s
                    WHERE 0=0 
                    <cfif NOT ListFindNoCase(StoreID, "all")>
                      and s.storeID in ( #StoreID# ) 
                    </cfif>
                </cfquery>

        </cfif>
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
    <cfset var storestosee = arguments.argslngStoreID />
    
    
     <!---[   If the stores to see is not "all",  remove references to "all" from the string   ]---->
	<cfif storestosee NEQ "ALL">
       <cfset storestosee = replacenocase(storestosee, "All,", "", "ALL") />
    
	<cfelseif (storestosee EQ "ALL") AND (variables.UserService.getuser().getUserTYpeID() GT variables.config.getmgmtreportcutoff() ) >
    	<cfset storestosee = variables.UserService.getuser().getSTORESTOSEE() />    
    </cfif>
    
    
    
    <cfquery name="qECSTotals" datasource="#variables.dsn#">
    SELECT *
    FROM tblStore_ECRTotals
    WHERE 0=0
    <cfif storestosee neq "All">
	    AND (tblStore_ECRTotals.StoreID IN(#storestosee#)) 
    </cfif>
    AND date = <cfqueryparam value="#startdate#" cfsqltype="cf_sql_date" />
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
    
    <cffunction name="makeTotalStruct" access="public" output="no" returntype="struct" hint="Creates a new struct for containing totals, populated with default values">
    <cfset var resultStruct = StructNew() />
   <cfscript> 
		resultStruct.SalesCost = 0;
		resultStruct.salesgross = 0;
		resultStruct.salesdiscount = 0;
		resultStruct.salessurcharge = 0;
		resultStruct.salesnet = 0;
		resultStruct.gp = 0;
	</cfscript>
    <cfreturn resultStruct />
    
    </cffunction>
    
    
<cffunction name="UpdateTotalStruct" access="public" returntype="struct" output="No" hint="Updates a given struct for containing totals, populated with default values"> 
    <cfargument name="argsTotalStruct" type="struct" required="yes" />
	<cfargument name="argsQuery" required="Yes" type="query"> 
	<cfargument name="rowindex" required="Yes" type="numeric"> 
    
    <cfset var TotalStruct = arguments.argsTotalStruct />
    <cfset var Query = arguments.argsQuery />
	<cfset var index = arguments.rowIndex />
    
    <cfif Query.postype[index] EQ 3>
 <!---[      If the sale is a refund (i.e. postype=3) set the values to negative   ]---->
        <cfscript>
            TotalStruct.SalesCost = TotalStruct.SalesCost - Query.SalesCost[index];
            TotalStruct.salesgross = TotalStruct.salesgross - Query.salesgross[index];
            TotalStruct.salesdiscount = TotalStruct.salesdiscount - Query.salesdiscount[index];
            TotalStruct.salessurcharge = TotalStruct.salessurcharge - Query.salessurcharge[index];
            TotalStruct.salesnet = TotalStruct.salesnet -  Query.salesnet[index];
            TotalStruct.gp = TotalStruct.gp -  Query.salesnet[index] + Query.SalesCost[index]  ;
        </cfscript>
        

 	<cfelse> 
	
		<cfscript>
            TotalStruct.SalesCost = TotalStruct.SalesCost + Query.SalesCost[index];
            TotalStruct.salesgross = TotalStruct.salesgross +Query.salesgross[index];
            TotalStruct.salesdiscount = TotalStruct.salesdiscount +Query.salesdiscount[index];
            TotalStruct.salessurcharge = TotalStruct.salessurcharge +Query.salessurcharge[index];
            TotalStruct.salesnet = TotalStruct.salesnet + Query.salesnet[index];
            TotalStruct.gp = TotalStruct.gp +  Query.salesnet[index] - Query.SalesCost[index]  ;
        </cfscript>
   
    </cfif> 
	<cfreturn TotalStruct> 
</cffunction> 

<cffunction name="StockLocationbyPartNO" access="public" returntype="query" output="no" hint="Returns a query showing the stores that have a specific partno">
<cfargument name="argsPartNO" required="yes" type="string" />
<cfset var partNO = arguments.argsPartNo />
<cfset var qStockLevels = 0 />

<cfquery name="qStockLevels" datasource="#variables.dsn#">
    SELECT
    m.partno, 
    m.description, 
    m.productid,
    l.storeid, 
    l.qtyonhand, 
    l.lastcost, 
    l.averagecost,
    s.storename, 
    s.manager1name, 
    s.storegroupid, 
    s.phone, 
    s.mobile, 
    s.email
    
    FROM dbo.tblStockMaster m, tblStockLocation l, dbo.tblStores S 
    WHERE
    m.partno=l.partno AND
    l.storeID = s.StoreID AND
    l.partno = <cfqueryparam value="#partNO#" cfsqltype="cf_sql_varchar" />
</cfquery>

<cfreturn qStockLevels />
</cffunction>

<cffunction name="getPartNos" access="public" returntype="query" output="no" hint="Returns a query of valid part numbers along with their descriptions">
	<cfset var qPartNOs = 0 />
    
    <cfquery name="qPartNOs" datasource="#variables.dsn#">
    	SELECT PartNo, ProductID, Description, SupplyUnit, OrderingUnit, Label, GroupNo, TCode, PCode, RCode, Tolerance, Cost, Wholesale, PluType, LockOrderUnitType, MinOrderQty, PictureFile, PartNoBuyingPlu, PartNoSalePlu
        FROM dbo.tblStockMaster
        ORDER BY Description, PartNO
    </cfquery>
    <cfreturn qPartNOs />    
</cffunction>
</cfcomponent>

