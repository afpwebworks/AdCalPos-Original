<cfcomponent displayname="tblStockLocation DAO" output="false" hint="DAO Component Handles all Database access for the table tblStockLocation.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    StockLocationDAO.cfc
Description: DAO Component Handles all Database access for the table tblStockLocation.  Requires Coldspring v1.0
Date:        3/May/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( StockLocation.getid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="StockLocationDAO" output="false" hint="Initialises the controller">
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


<cffunction name="save" access="public" returntype="StockLocation" output="false" hint="DAO method">
<cfargument name="StockLocation" type="StockLocation" required="yes" />
<!-----[  If a ID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<!---[   <cfif (arguments.StockLocation.getID() neq "0")>   ]---->

<cfif  recordexists(arguments.StockLocation )>	
		<cfset StockLocation = update(arguments.StockLocation)/>
	<cfelse>
		<cfset StockLocation = create(arguments.StockLocation)/>
	</cfif>
	<cfreturn StockLocation />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="argsStockLocation" type="StockLocation" required="true" /> 
	<cfset var StockLocation = arguments.argsStockLocation />
	<cfset var qStockLocationDelete = 0 >
<cfquery name="StockLocationDelete" datasource="#variables.dsn#" >
		DELETE FROM tblStockLocation
		WHERE 
		ID = <cfqueryparam value="#StockLocation.getID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	
</cffunction>



<cffunction name="read" access="public" returntype="StockLocation" output="false" hint="DAO Method. - Reads a StockLocation into the bean">
<cfargument name="argsStockLocation" type="StockLocation" required="true" />
	<cfset var StockLocation  =  arguments.argsStockLocation />
	<cfset var QtblStockLocationselect = "" />
	<cfquery name="QtblStockLocationselect" datasource="#variables.dsn#">
		SELECT 
		ID, StoreID, PartNo, ProductID, LastCost, AverageCost, RetailPrice, MaxRetail, QtyOnHand, ReorderPoint, MaxShelfQty, FridayFactor, DateEntered, Prev_QtyOnHand, Freezer_QtyOnHand, CoolRoom_QtyOnHand, Display_QtyOnHand, Wastage, TeansferQty, TransferToPlu, ProcessedStockTake
		FROM tblStockLocation 
		WHERE 
		ID = <cfqueryparam value="#StockLocation.getID()#"  cfsqltype="CF_SQL_INTEGER"/> OR
        (ProductID = <cfqueryparam value="#StockLocation.getProductID()#" cfsqltype="cf_sql_varchar" />  AND
        StoreID = <cfqueryparam value="#StockLocation.getStoreID()#" cfsqltype="cf_sql_integer" /> )
	</cfquery>
	<cfif QtblStockLocationselect.recordCount >
		<cfscript>
		 StockLocation.setID(QtblStockLocationselect.ID);
         StockLocation.setStoreID(QtblStockLocationselect.StoreID);
         StockLocation.setPartNo(QtblStockLocationselect.PartNo);
		 StockLocation.setProductID(QtblStockLocationselect.ProductID);
         StockLocation.setLastCost(QtblStockLocationselect.LastCost);
         StockLocation.setAverageCost(QtblStockLocationselect.AverageCost);
         StockLocation.setRetailPrice(QtblStockLocationselect.RetailPrice);
         StockLocation.setMaxRetail(QtblStockLocationselect.MaxRetail);
         StockLocation.setQtyOnHand(QtblStockLocationselect.QtyOnHand);
         StockLocation.setReorderPoint(QtblStockLocationselect.ReorderPoint);
         StockLocation.setMaxShelfQty(QtblStockLocationselect.MaxShelfQty);
         StockLocation.setFridayFactor(QtblStockLocationselect.FridayFactor);
         StockLocation.setDateEntered(QtblStockLocationselect.DateEntered);
         StockLocation.setPrev_QtyOnHand(QtblStockLocationselect.Prev_QtyOnHand);
         StockLocation.setFreezer_QtyOnHand(QtblStockLocationselect.Freezer_QtyOnHand);
         StockLocation.setCoolRoom_QtyOnHand(QtblStockLocationselect.CoolRoom_QtyOnHand);
         StockLocation.setDisplay_QtyOnHand(QtblStockLocationselect.Display_QtyOnHand);
         StockLocation.setWastage(QtblStockLocationselect.Wastage);
         StockLocation.setTeansferQty(QtblStockLocationselect.TeansferQty);
         StockLocation.setTransferToPlu(QtblStockLocationselect.TransferToPlu);
         StockLocation.setProcessedStockTake(QtblStockLocationselect.ProcessedStockTake);
         
		</cfscript>
	</cfif>
	<cfreturn StockLocation />
</cffunction>


<cffunction name="readbyPartNO" access="public" returntype="StockLocation" output="no" hint="Reads a record and sets values in the Stocklocation bean based on a partno and storeid">
<cfargument name="argsStockLocation" type="StockLocation" required="true" />
	<cfset var StockLocation  =  arguments.argsStockLocation />
    <cfset var StoreID = trim(StockLocation.getStoreID())  />
    <cfset var ProductID = trim(StockLocation.getProductID())  />
    <cfset var PartNO = trim(StockLocation.getPartNO())  />
	<cfset var QtblStockLocationselect = "" />
    
    <cfquery name="QtblStockLocationselect" datasource="#variables.dsn#">
		SELECT ProductID from tblStockLocation 
        WHERE
        PartNO = <cfqueryparam value="#PartNO#" cfsqltype="cf_sql_integer" /> AND 
    	StoreID = <cfqueryparam value="#StoreID#" cfsqltype="cf_sql_integer" />
     </cfquery>
     <cfset StockLocation.setProductID( QtblStockLocationselect.ProductID   ) />
	<cfset read( Stocklocation ) />
	<cfreturn StockLocation />
</cffunction>

<cffunction name="recordexists" access="public" returntype="boolean" output="no" hint="Checks if a record already exists in the database">
    <cfargument name="argsStockLocation" type="StockLocation" required="true" />
	<cfset var StockLocation  =  arguments.argsStockLocation />
    <cfset var StoreID = trim(StockLocation.getStoreID())  />
    <cfset var ProductID = trim(StockLocation.getProductID())  />
    <cfset var Result = false />
    
    <cfquery name="qPosLineExists" datasource="#variables.dsn#">
        SELECT ID FROM tblStockLocation 
        WHERE 
        ProductID = <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer" />  AND
        StoreID = <cfqueryparam value="#StoreID#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <cfif qPosLineExists.recordcount> <Cfset result=True /></cfif>
    <cfreturn result />
</cffunction> 


<cffunction name="UpdateStockQuantity" access="public" returntype="void" output="no" hint="Updates the stock at the specified location.">
<cfargument name="argsStoreID" required="yes" type="numeric" />
<cfargument name="argsProductID" required="yes" type="numeric" />
<cfargument name="argsQty" required="yes" type="numeric"  hint="quantity can be negative for a return or refund"/>
   <cfset var StoreID = arguments.argsStoreID  />
   <cfset var ProductID = arguments.argsProductID />
   <cfset var Quantity = arguments.argsQty  />
   <Cfset var qStockUpdate = 0 />
   
	<cfquery name="qStockUpdate" datasource="#variables.dsn#" result="thesql" >
    Update tblStockLocation set 
    QtyOnHand = QtyOnHand + <cfqueryparam value="#Quantity#" cfsqltype="cf_sql_numeric" />
    WHERE 
        ProductID = <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer" />  AND
        StoreID = <cfqueryparam value="#StoreID#" cfsqltype="cf_sql_integer" />
	</cfquery>

</cffunction>

<cffunction name="SetStockQuantity" access="public" returntype="void" output="no" hint="Sets the amonnt of stock on hand to be equal to the supplied value">
<cfargument name="argsStoreID" required="yes" type="numeric" />
<cfargument name="argsProductID" required="yes" type="numeric" />
<cfargument name="argsQty" required="yes" type="numeric"  hint="quantity can be negative for a return or refund"/>
   <cfset var StoreID = arguments.argsStoreID  />
   <cfset var ProductID = arguments.argsProductID />
   <cfset var Quantity = arguments.argsQty  />
   <Cfset var qStockUpdate = 0 />

	<cfquery name="qStockUpdate" datasource="#variables.dsn#">
    Update tblStockLocation set 
    QtyOnHand = <cfqueryparam value="#Quantity#" cfsqltype="cf_sql_numeric" />
    WHERE 
        ProductID = <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer" />  AND
        StoreID = <cfqueryparam value="#StoreID#" cfsqltype="cf_sql_integer" />
	</cfquery>

</cffunction>
		

<cffunction name="GetAllStockLocations" access="public" output="false" returntype="query" hint="Returns a query of all StockLocations in our Database">
<cfset var QgetallStockLocations = 0 />
	<cfquery name="QgetallStockLocations" datasource="#variables.dsn#">
		SELECT ID, StoreID, PartNo, productid, LastCost, AverageCost, RetailPrice, MaxRetail, QtyOnHand, ReorderPoint, MaxShelfQty, FridayFactor, DateEntered, Prev_QtyOnHand, Freezer_QtyOnHand, CoolRoom_QtyOnHand, Display_QtyOnHand, Wastage, TeansferQty, TransferToPlu, ProcessedStockTake
		FROM tblStockLocation 
		ORDER BY ID
	</cfquery>
	<cfreturn QgetallStockLocations />
</cffunction>


<cffunction name="IsUpdateRequired" returntype="boolean" output="no" access="public" hint="Determines if the options table specities that update of the stocklocation table is required.">
<cfset var required = false />

	<cfquery name="qRequired" datasource="#variables.dsn#">
    	Select updatestocklocation from tblOptions
    </cfquery>
    
    <cfif qRequired.recordcount >
    	<cfset required = qRequired.updatestocklocation /> 
    </cfif>
    
    <cfreturn required />
 </cffunction> 


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="StockLocation" output="false" hint="DAO method">
<cfargument name="argsStockLocation" type="StockLocation" required="yes" displayname="create" />
	<cfset var qStockLocationInsert = 0 />
	<cfset var StockLocation = arguments.argsStockLocation />
	
	<cfquery name="qStockLocationInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into tblStockLocation
		( StoreID, PartNo, productid, LastCost, AverageCost, RetailPrice, MaxRetail, QtyOnHand, ReorderPoint, MaxShelfQty, FridayFactor, DateEntered, Prev_QtyOnHand, Freezer_QtyOnHand, CoolRoom_QtyOnHand, Display_QtyOnHand, Wastage, TeansferQty, TransferToPlu, ProcessedStockTake ) VALUES
		(

		<cfqueryparam value="#StockLocation.getstoreid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockLocation.getpartno()#" cfsqltype="CF_SQL_VARCHAR" />,
        <cfqueryparam value="#StockLocation.getproductid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockLocation.getlastcost()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getaveragecost()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getretailprice()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getmaxretail()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getqtyonhand()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getreorderpoint()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getmaxshelfqty()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getfridayfactor()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getdateentered()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#StockLocation.getprev_qtyonhand()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getfreezer_qtyonhand()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getcoolroom_qtyonhand()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getdisplay_qtyonhand()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getwastage()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.getteansferqty()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockLocation.gettransfertoplu()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockLocation.getprocessedstocktake()#" cfsqltype="CF_SQL_BIT" />
		   ) 
		SELECT Ident_Current('tblStockLocation') as ID
		SET NOCOUNT OFF
	</cfquery>
	<cfset StockLocation.setID(qStockLocationInsert.ID)>

	<cfreturn StockLocation />
</cffunction>

<cffunction name="update" access="private" returntype="StockLocation" output="false" hint="DAO method">
<cfargument name="argsStockLocation" type="StockLocation" required="yes" />
	<cfset var StockLocation = arguments.argsStockLocation />
	<cfset var StockLocationUpdate = 0 >
	<cfquery name="StockLocationUpdate" datasource="#variables.dsn#" >
		UPDATE tblStockLocation SET
        storeid  = <cfqueryparam value="#StockLocation.getStoreID()#" cfsqltype="CF_SQL_INTEGER"/>,
        partno  = <cfqueryparam value="#StockLocation.getPartNo()#" cfsqltype="CF_SQL_VARCHAR"/>,
        productid = <cfqueryparam value="#StockLocation.getproductid()#" cfsqltype="CF_SQL_INTEGER" />,
        lastcost  = <cfqueryparam value="#StockLocation.getLastCost()#" cfsqltype="CF_SQL_FLOAT"/>,
        averagecost  = <cfqueryparam value="#StockLocation.getAverageCost()#" cfsqltype="CF_SQL_FLOAT"/>,
        retailprice  = <cfqueryparam value="#StockLocation.getRetailPrice()#" cfsqltype="CF_SQL_FLOAT"/>,
        maxretail  = <cfqueryparam value="#StockLocation.getMaxRetail()#" cfsqltype="CF_SQL_FLOAT"/>,
        qtyonhand  =  <cfqueryparam value="#StockLocation.getQtyOnHand()#" cfsqltype="CF_SQL_FLOAT"/>,
        reorderpoint  = <cfqueryparam value="#StockLocation.getReorderPoint()#" cfsqltype="CF_SQL_FLOAT"/>,
        maxshelfqty  = <cfqueryparam value="#StockLocation.getMaxShelfQty()#" cfsqltype="CF_SQL_FLOAT"/>,
        fridayfactor  = <cfqueryparam value="#StockLocation.getFridayFactor()#" cfsqltype="CF_SQL_FLOAT"/>,
        dateentered  = <cfqueryparam value="#StockLocation.getDateEntered()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
        prev_qtyonhand  = <cfqueryparam value="#StockLocation.getPrev_QtyOnHand()#" cfsqltype="CF_SQL_FLOAT"/>,
        freezer_qtyonhand  = <cfqueryparam value="#StockLocation.getFreezer_QtyOnHand()#" cfsqltype="CF_SQL_FLOAT"/>,
        coolroom_qtyonhand  = <cfqueryparam value="#StockLocation.getCoolRoom_QtyOnHand()#" cfsqltype="CF_SQL_FLOAT"/>,
        display_qtyonhand  = <cfqueryparam value="#StockLocation.getDisplay_QtyOnHand()#" cfsqltype="CF_SQL_FLOAT"/>,
        wastage  = <cfqueryparam value="#StockLocation.getWastage()#" cfsqltype="CF_SQL_FLOAT"/>,
        teansferqty  = <cfqueryparam value="#StockLocation.getTeansferQty()#" cfsqltype="CF_SQL_FLOAT"/>,
        transfertoplu  = <cfqueryparam value="#StockLocation.getTransferToPlu()#" cfsqltype="CF_SQL_VARCHAR"/>,
        processedstocktake  = <cfqueryparam value="#StockLocation.getProcessedStockTake()#" cfsqltype="CF_SQL_BIT"/>
						
		WHERE 
		ID = <cfqueryparam value="#StockLocation.getID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	
	<cfreturn StockLocation />
</cffunction>

</cfcomponent>
