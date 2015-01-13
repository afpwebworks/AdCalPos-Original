<cfcomponent displayname="tblStockMaster DAO" output="false" hint="DAO Component Handles all Database access for the table tblStockMaster.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    StockmasterDAO.cfc
Description: DAO Component Handles all Database access for the table tblStockMaster.  Requires Coldspring v1.0
Date:        3/May/2010
Author:      Michael Kear

Revision history: 
7/9/2010 added ProductID to the bean and database record. - MK

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( Stockmaster.getpartno() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="StockmasterDAO" output="false" hint="Initialises the controller">
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

<cffunction name="setPricesDAOService" access="public" output="false" returntype="void" hint="Dependency: PricesDAO Service">
	<cfargument name="PricesDAOService" type="any" required="true"/>
	<cfset variables.PricesDAOService = arguments.PricesDAOService/>
</cffunction>


<cffunction name="save" access="public" returntype="Stockmaster" output="false" hint="DAO method">
<cfargument name="Stockmaster" type="Stockmaster" required="yes" />
<!-----[  If an ID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
    <cfif (arguments.Stockmaster.getID() neq "0")> 
		<cfset Stockmaster = update(arguments.Stockmaster)/>
	<cfelse>
		<cfset Stockmaster = create(arguments.Stockmaster)/>
	</cfif>
	<cfreturn Stockmaster />
</cffunction>


<cffunction name="saveProductPrice" access="public" returntype="ProductPrice" output="false" hint="DAO method">
<cfargument name="argsProductPrice" type="ProductPrice" required="yes" />
<cfset var ProductPrice = arguments.argsProductPrice />
<!-----[  If an ID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
    <cfif PriceExists( ProductPrice )> 
		<cfset ProductPrice = updateProductPrice(ProductPrice)/>
	<cfelse>
		<cfset ProductPrice = createProductPrice(ProductPrice)/>
	</cfif>
	<cfreturn ProductPrice />
</cffunction>


<cffunction name="PriceExists" access="public" returntype="boolean" output="no" hint="Checks if a price already exists for this productid">
    <cfargument name="argsProductPrice" type="ProductPrice" required="yes" />
    <cfset var ProductPrice = arguments.argsProductPrice />
	<cfset var result = false />
    
    	<cfquery name="qCheckProductPrice" datasource="#variables.dsn#">
        SELECT * from tblStockProductPrice
        WHERE
        PriceID =  <cfqueryparam value="#ProductPrice.getPriceID()#" cfsqltype="cf_sql_integer" /> AND 
        ProductID =  <cfqueryparam value="#ProductPrice.getProductID()#" cfsqltype="cf_sql_integer" />
        </cfquery>	
       
       <cfif  qCheckProductPrice.recordcount>
       <cfset result = true />
       </cfif>
    <cfreturn result />
</cffunction>


<cffunction name="createProductPrice" access="public" returntype="ProductPrice" output="false" hint="DAO method">
    <cfargument name="argsProductPrice" type="ProductPrice" required="yes" />
    <cfset var ProductPrice = arguments.argsProductPrice />
	<cfset var qProductPriceInsert = 0 />
	
	<cfquery name="qProductPriceInsert" datasource="#variables.dsn#" >
		INSERT into tblStockProductPrice
		( Priceid, ProductId, SellIncludeTax, SellUnit ) VALUES
		(
		<cfqueryparam value="#ProductPrice.getpriceid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ProductPrice.getproductid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ProductPrice.getsellincludetax()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#ProductPrice.getsellunit()#" cfsqltype="CF_SQL_FLOAT" />
		   ) 
		</cfquery>
         <!---[       Trigger the version number so there is a maintenance update   ]---->
    	<cfset variables.MonitorService.SetVersion() />

	<cfreturn ProductPrice />
</cffunction>


<cffunction name="updateProductPrice" access="private" returntype="ProductPrice" output="false" hint="DAO method">
<cfargument name="argsProductPrice" type="ProductPrice" required="yes" />
	<cfset var ProductPrice = arguments.argsProductPrice />
	<cfset var ProductPriceUpdate = 0 >
    
	<cfquery name="ProductPriceUpdate" datasource="#variables.dsn#" >
		UPDATE tblStockProductPrice SET
        
sellincludetax  = <cfqueryparam value="#ProductPrice.getSellIncludeTax()#" cfsqltype="CF_SQL_BIT"/>,
sellunit  = <cfqueryparam value="#ProductPrice.getSellUnit()#" cfsqltype="CF_SQL_FLOAT"/>
						
		WHERE 
		PriceID = <cfqueryparam value="#ProductPrice.getPriceID()#"   cfsqltype="CF_SQL_INTEGER" /> AND
        productid  = <cfqueryparam value="#ProductPrice.getProductId()#" cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	 <!---[       Trigger the version number so there is a maintenance update   ]---->
	<cfset variables.MonitorService.SetVersion() />

    
	<cfreturn ProductPrice />
</cffunction>


<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="Stockmaster" type="Stockmaster" required="true" /> 
	<cfset var qStockmasterDelete = 0 >
<cfquery name="StockmasterDelete" datasource="#variables.dsn#" >
		DELETE FROM tblStockMaster
		WHERE 
		PartNo = <cfqueryparam value="#Stockmaster.getPartNo()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
</cffunction>


<cffunction name="read" access="public" returntype="StockMaster" output="false" hint="DAO Method. - Reads a StockMaster into the bean.  Requires a partNO to be set in the bean">
<cfargument name="argsStockMaster" type="StockMaster" required="true" />
	<cfset var StockMaster  =  arguments.argsStockMaster />
	<cfset var QtblStockMasterselect = 0 />
    <cfset var qGetPicture = 0 />
    <cfset var Picturefilename = "NoPic.jpg" />
        
	<cfquery name="QtblStockMasterselect" datasource="#variables.dsn#">
		SELECT 
		m.PartNo, m.Description, m.SupplyUnit, m.OrderingUnit, m.Label, m.GroupNo, m.TCode, m.PCode, m.RCode, m.Tolerance, m.Cost, m.Wholesale, m.MaxRetail, m.PluType, m.LockOrderUnitType, m.MinOrderQty, m.PictureFile, m.NoLongerUsed, m.SuppressOrder, m.SuppressStocktake, m.DateEntered, m.ID, m.PartNoBuyingPlu, m.PartNoSalePlu, m.Ratio, m.PrepCode, m.ThreeHRebate, m.SCRebate, m.ThreeHRebateVal, m.SCRebateVal, m.ParentCost, m.TypeID, m.ProductID, m.kitchentype, m.ModifierID, m.ModifierType,  m.IsWeighed, m.Tare, m.AllowZeroPrice, m.Discountable, m.IsCountDown, m.AllowOpenPrice, m.DiscountNo, m.KitchenPrint, m.PointsAwarded, m.PointsRequiredToBuy
		FROM tblStockMaster m
		WHERE 
    	ID = <cfqueryparam value="#StockMaster.getID()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
    
    <cfquery name="qGetPicture" datasource="#variables.dsn#">
		SELECT PictureFileName 
        FROM tblPictureFile 
        WHERE
        PictureFileID = <cfqueryparam value="#QtblStockMasterselect.PictureFile#" cfsqltype="cf_sql_integer" />        
    </cfquery>
    
    
       
    <cfif qGetPicture.recordcount>
    	<cfset Picturefilename = qGetPicture.PictureFileName />
    </cfif>
    
	  <cfif QtblStockMasterselect.recordCount >
		<cfscript>
	     StockMaster.setPartNo(QtblStockMasterselect.PartNo);
         StockMaster.setDescription(QtblStockMasterselect.Description);
         StockMaster.setSupplyUnit(QtblStockMasterselect.SupplyUnit);
         StockMaster.setOrderingUnit(QtblStockMasterselect.OrderingUnit);
         StockMaster.setLabel(QtblStockMasterselect.Label);
         StockMaster.setGroupNo(QtblStockMasterselect.GroupNo);
         StockMaster.setTCode(QtblStockMasterselect.TCode);
         StockMaster.setPCode(QtblStockMasterselect.PCode);
         StockMaster.setRCode(QtblStockMasterselect.RCode);
         StockMaster.setTolerance(QtblStockMasterselect.Tolerance);
         StockMaster.setCost(QtblStockMasterselect.Cost);
         StockMaster.setWholesale(QtblStockMasterselect.Wholesale);
         StockMaster.setMaxRetail(QtblStockMasterselect.MaxRetail);
         StockMaster.setPluType(QtblStockMasterselect.PluType);
         StockMaster.setLockOrderUnitType(QtblStockMasterselect.LockOrderUnitType);
         StockMaster.setMinOrderQty(QtblStockMasterselect.MinOrderQty);
         StockMaster.setPictureFile(QtblStockMasterselect.PictureFile);
		 StockMaster.setPicturefilename(Picturefilename);
		 StockMaster.setNoLongerUsed(QtblStockMasterselect.NoLongerUsed);
         StockMaster.setSuppressOrder(QtblStockMasterselect.SuppressOrder);
         StockMaster.setSuppressStocktake(QtblStockMasterselect.SuppressStocktake);
         StockMaster.setDateEntered(QtblStockMasterselect.DateEntered);
         StockMaster.setID(QtblStockMasterselect.ID);
         StockMaster.setPartNoBuyingPlu(QtblStockMasterselect.PartNoBuyingPlu);
         StockMaster.setPartNoSalePlu(QtblStockMasterselect.PartNoSalePlu);
         StockMaster.setRatio(QtblStockMasterselect.Ratio);
         StockMaster.setPrepCode(QtblStockMasterselect.PrepCode);
         StockMaster.setThreeHRebate(QtblStockMasterselect.ThreeHRebate);
         StockMaster.setSCRebate(QtblStockMasterselect.SCRebate);
         StockMaster.setThreeHRebateVal(QtblStockMasterselect.ThreeHRebateVal);
         StockMaster.setSCRebateVal(QtblStockMasterselect.SCRebateVal);
         StockMaster.setParentCost(QtblStockMasterselect.ParentCost);
         StockMaster.setTypeID(QtblStockMasterselect.TypeID);
         StockMaster.setProductID(QtblStockMasterselect.ProductID);
         StockMaster.setkitchentype(QtblStockMasterselect.kitchentype);
         StockMaster.setModifierID(QtblStockMasterselect.ModifierID);
		 StockMaster.setModifierType(QtblStockMasterselect.ModifierType);		 
         StockMaster.setCostUnit(QtblStockMasterselect.wholesale);
         StockMaster.setIsWeighed(QtblStockMasterselect.IsWeighed);
         StockMaster.setTare(QtblStockMasterselect.Tare);
         StockMaster.setAllowZeroPrice(QtblStockMasterselect.AllowZeroPrice);
         StockMaster.setDiscountable(QtblStockMasterselect.Discountable);
         StockMaster.setIsCountDown(QtblStockMasterselect.IsCountDown);
         StockMaster.setAllowOpenPrice(QtblStockMasterselect.AllowOpenPrice);
         StockMaster.setDiscountNo(QtblStockMasterselect.DiscountNo);
         StockMaster.setKitchenPrint(QtblStockMasterselect.KitchenPrint);
         StockMaster.setPointsAwarded(QtblStockMasterselect.PointsAwarded);
         StockMaster.setPointsRequiredToBuy(QtblStockMasterselect.PointsRequiredToBuy);
		</cfscript>
      </cfif>
      
      <cfset GetPricesForProductID( stockmaster ) />
      
  	<cfreturn StockMaster />
</cffunction>
		
<cffunction name="readbyProductID" access="public" returntype="StockMaster" output="false" hint="DAO Method. - Reads a StockMaster into the bean based on the ProductID"> 
<cfargument name="argsStockMaster" type="StockMaster" required="true" />
	<cfset var StockMaster  =  arguments.argsStockMaster />
  	<cfset var qProduct = 0 />
    <!---[ Get the ID for the associated ProductID  ]---->
  	<cfquery name="qProduct" datasource="#variables.dsn#">
    	SELECT ID from tblStockMaster 
        WHERE ProductID = <cfqueryparam value="#StockMaster.getProductID()#" cfsqltype="cf_sql_integer" />
    </cfquery>
    
    <cfif qProduct.recordcount eq "1">
		<cfset StockMaster.setID( qProduct.ID ) />
        <cfset read( StockMaster ) />
    </cfif> 
	<cfreturn StockMaster />
</cffunction>  

<cffunction name="readbyPartNo" access="public" returntype="StockMaster" output="false" hint="DAO Method. - Reads a StockMaster into the bean based on the PartNO"> 
<cfargument name="argsStockMaster" type="StockMaster" required="true" />
	<cfset var StockMaster  =  arguments.argsStockMaster />
  	<cfset var qProduct = 0 />
    <!---[ Get the ID for the associated PartNO  ]---->
  	<cfquery name="qProduct" datasource="#variables.dsn#">
    	SELECT ID from tblStockMaster 
        WHERE PartNo = <cfqueryparam value="#StockMaster.getPartNo()#" cfsqltype="cf_sql_varchar" />
    </cfquery>
    
    <cfif qProduct.recordcount eq "1">
		<cfset StockMaster.setID( qProduct.ID ) />
        <cfset read( StockMaster ) />
    </cfif> 
	<cfreturn StockMaster />
</cffunction> 


<cffunction name="readbyDescription" access="public" output="false" returntype="StockMaster" hint="Returns a query of the data relating to one  Stockmasters in our Database">
 <cfargument name="argsStockmaster" type="Stockmaster" required="true" />
 <cfset var Stockmaster = arguments.argsStockmaster />
 <cfset var qStockmaster = 0 />
 
 <cfquery name="qStockmaster" datasource="#variables.dsn#">
 	SELECT PartNo from tblStockMaster
    WHERE
    Description Like <cfqueryparam value="%#stockmaster.getDescription()#%" cfsqltype="cf_sql_varchar" />
 </cfquery>
 
 <cfif qStockmaster.recordcount>
 	<cfset stockmaster.setPartNo(  qStockmaster.PartNo  ) />
    <cfset read( stockmaster ) />
 </cfif>
 <cfreturn stockmaster />
</cffunction>
        
        
<cffunction name="recordexists" access="public" returntype="boolean" output="no" hint="Checks if a record already exists in the database">
   <cfargument name="argsStockmaster" type="Stockmaster" required="true" />
 	<cfset var ID = arguments.argsStockmaster.getID() />
    <cfset var PartNo = trim(arguments.argsStockmaster.getPartNO())  />
    <cfset var Result = false />
  <!---[     Check for ID first   ]---->
  
     <cfquery name="qPosLineExists" datasource="#variables.dsn#">
        SELECT PartNo from tblStockMaster where PartNo = <cfqueryparam value="#PartNo#" />
    </cfquery>
    <cfif qPosLineExists.recordcount GT 0> <Cfset result=True /></cfif>
    <cfreturn result />
</cffunction>        


<cffunction name="GetPricesForProductID" access="public" returntype="Stockmaster" output="no" hint="Returns struct showing the current prices for a productID">
   <cfargument name="argsStockmaster" type="Stockmaster" required="true" />
    <cfset var StockMaster = arguments.argsStockmaster />
	<cfset var PricesStruct = structNew() />
    <cfset var PriceLevels = variables.PricesDAOService.GetAllStockPrices() />
    
    <cfquery name="qProductPrices" datasource="#variables.dsn#">
    SELECT 
    	p.ProductId, p.PriceID, p.SellIncludeTax, p.SellUnit, d.Description
    FROM dbo.tblStockProductPrice p, dbo.tblStockPrice d
    WHERE p.PriceID = d.priceid AND
    p.ProductID = <cfqueryparam value="#StockMaster.getProductID()#" cfsqltype="cf_sql_integer" />
    order by p.priceid
    </cfquery>
    
    <!---[   Set the pricing struct to the default values of zero   ]---->
     <cfloop query="PriceLevels">
     <cfif qProductPrices.currentrow eq 1>
     	<cfset PricesStruct[PriceLevels.description]= {PriceID=PriceLevels.PriceID,SellIncludeTax = 1,SellUnit = StockMaster.getMaxRetail()  } />
     <cfelse>
	    <cfset PricesStruct[PriceLevels.description]= {PriceID=PriceLevels.PriceID,SellIncludeTax = 1,SellUnit = 0 } />
    </cfif>
    </cfloop>
    <!---[   As a default, if the first price is zero, set the default to be the value of stockmaster.getMaxRetail()    ]---->
    
    <!---[   Now over write those values with the values set for this product (if any) leaving zeros where there are no values set   ]---->
 
    <cfloop query="qProductPrices">
    <cfscript>
    PricesStruct[qProductPrices.description]= {PriceID=qProductPrices.PriceID,SellIncludeTax = qProductPrices.SellIncludeTax,SellUnit = qProductPrices.SellUnit };	  
	</cfscript>  
    </cfloop>

	<cfset Stockmaster.setPriceLevels( PricesStruct ) />
    <cfreturn StockMaster />
</cffunction>

<cffunction name="GetAllStockmasters" access="public" output="false" returntype="query" hint="Returns a query of all Stockmasters in our Database">
<cfset var QgetallStockmasters = 0 />
	<cfquery name="QgetallStockmasters" datasource="#variables.dsn#">
		SELECT PartNo, Description, SupplyUnit, OrderingUnit, Label, GroupNo, TCode, PCode, RCode, Tolerance, Cost, Wholesale, MaxRetail, PluType, LockOrderUnitType, MinOrderQty, PictureFile, NoLongerUsed, SuppressOrder, SuppressStocktake, DateEntered, ID, PartNoBuyingPlu, PartNoSalePlu, Ratio, PrepCode, ThreeHRebate, SCRebate, ThreeHRebateVal, SCRebateVal, ParentCost, TypeID, ProductID, kitchentype, ModifierID, ModifierType,  IsWeighed, Tare, AllowZeroPrice, Discountable, IsCountDown, AllowOpenPrice, DiscountNo, KitchenPrint, PointsAwarded, PointsRequiredToBuy
		FROM tblStockMaster 
		ORDER BY PartNo
	</cfquery>
	<cfreturn QgetallStockmasters />
</cffunction>










<cffunction name="IsUpdateRequired" returntype="boolean" output="no" access="public" hint="Determines if the options table specities that update of the stockmaster table is required.">
<cfset var required = false />

	<cfquery name="qRequired" datasource="#variables.dsn#">
    	Select updatestockmaster from tblOptions
    </cfquery>
    
    <cfif qRequired.recordcount >
    	<cfset required = qRequired.updatestockmaster /> 
    </cfif>
    
    <cfreturn required />
 </cffunction> 
 
 
 <cffunction name="CheckUnique" access="public" returntype="any" output="no" hint="Checks that partno and productID are unique in the database. ">
 <cfargument name="argsStockmaster" type="Stockmaster" required="yes"  />
 <cfargument name="argsErrorHandler" type="any" required="yes"  />
	<cfset var ErrorHandler = arguments.argsErrorHandler />
	<cfset var Stockmaster = arguments.argsStockmaster />
 
 	<cfif Stockmaster.getID() eq 0>
    	<!---[   If this is an add, the partno should not exist in the database.   ]---->
    	<cfquery name="qCheckUnique" datasource="#variables.dsn#">
            Select count(PartNO) as PartNOcount from tblStockMaster
            Where Partno = <cfqueryparam value="#stockmaster.getPartNO()#" cfsqltype="cf_sql_varchar" />
        </cfquery>
    	<cfif  qCheckUnique.PartNOcount GT 0>
        	 <cfset ErrorHandler.setError("PartNo", "PartNo is not unique. Please choose another or use Edit (204)") />      
         </cfif>
     <!---[    If this is an update,  there should only be one partno in the database, and it should be associated with this record ID   ]---->   
    <cfelseif Stockmaster.getID() neq 0 >
    	<cfquery name="qCheckUnique" datasource="#variables.dsn#">
            SELECT count(PartNO) as PartNOcount from tblStockMaster
            WHERE ID <> <cfqueryparam value="#stockmaster.getID()#" cfsqltype="cf_sql_integer" /> AND
            PartNO = <cfqueryparam value="#stockmaster.getPartNO()#" cfsqltype="cf_sql_varchar" />
        </cfquery>
        <cfif  qCheckUnique.PartNOcount GT 0>
        	 <cfset ErrorHandler.setError("PartNo", "PartNo is not unique. Please choose another or use Edit (213)") /> 
        </cfif>       
    </cfif>      
    <cfreturn ErrorHandler />    
 </cffunction>
 
 <cffunction name="setRebateCodes" access="public" returntype="Stockmaster" output="no" hint="sets the rebate codes based on the value of getRcode() in a valid stockmaster object.">
 	<cfargument name="argsStockmaster" type="Stockmaster" required="yes" />
    <cfset var Stockmaster = arguments.argsStockmaster />
    <cfset var rCode = arguments.argsStockmaster.getRcode() />
    <cfset var ThreeHRebate =  0 />
    <cfset var SCRebate = 0 />
    <cfset var qRebateCodes = 0 />
    
    <cfquery name="qRebateCodes" datasource="#variables.dsn#">
        SELECT * FROM tblStockRebate
        WHERE
        RebateCode = <cfqueryparam  value="#rCode#" cfsqltype="cf_sql_integer" />
    </cfquery>    
    
    <cfset Stockmaster.setThreeHRebate(  qRebateCodes.ThreeHRebate  ) />
    <cfset Stockmaster.setSCRebate(  qRebateCodes.SCRebate  ) />
    
    <cfreturn STockmaster />
  </cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="Stockmaster" output="false" hint="DAO method">
<cfargument name="argsStockmaster" type="Stockmaster" required="yes" displayname="create" />
	<cfset var qStockmasterInsert = 0 />
	<cfset var Stockmaster = arguments.argsStockmaster />
    <!---[   <cfset var NewIndex = IssueIndex( Stockmaster ) />   ]----> 
    
	
	<cfquery name="qStockmasterInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into tblStockMaster
		( PartNo, Description, SupplyUnit, OrderingUnit, Label, GroupNo, TCode, PCode, RCode, Tolerance, Cost, Wholesale, MaxRetail, PluType, LockOrderUnitType, MinOrderQty, PictureFile, NoLongerUsed, SuppressOrder, SuppressStocktake, DateEntered, PartNoBuyingPlu, PartNoSalePlu, Ratio, PrepCode, ThreeHRebate, SCRebate, ThreeHRebateVal, SCRebateVal, ParentCost, TypeID,  kitchentype, ModifierID, ModifierType, IsWeighed, Tare, AllowZeroPrice, Discountable, IsCountDown, AllowOpenPrice, DiscountNo, KitchenPrint, PointsAwarded, PointsRequiredToBuy ) VALUES
		(

		<cfqueryparam value="#StockMaster.getpartno()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockMaster.getdescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockMaster.getsupplyunit()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockMaster.getorderingunit()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockMaster.getlabel()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockMaster.getgroupno()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockMaster.gettcode()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockMaster.getpcode()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockMaster.getrcode()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockMaster.gettolerance()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getcost()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getwholesale()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getmaxretail()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getplutype()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockMaster.getlockorderunittype()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#StockMaster.getminorderqty()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getpicturefile()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockMaster.getnolongerused()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#StockMaster.getsuppressorder()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#StockMaster.getsuppressstocktake()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#variables.austime#" cfsqltype="CF_SQL_TIMESTAMP"/>,
		<cfqueryparam value="#StockMaster.getpartnobuyingplu()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockMaster.getpartnosaleplu()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockMaster.getratio()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getprepcode()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockMaster.getthreehrebate()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getscrebate()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getthreehrebateval()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getscrebateval()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getparentcost()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.gettypeid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockMaster.getkitchentype()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockMaster.getmodifierid()#" cfsqltype="CF_SQL_INTEGER" />,
        <cfqueryparam value="#StockMaster.getmodifiertype()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockMaster.getisweighed()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#StockMaster.gettare()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StockMaster.getallowzeroprice()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#StockMaster.getdiscountable()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#StockMaster.getiscountdown()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#StockMaster.getallowopenprice()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#StockMaster.getdiscountno()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockMaster.getkitchenprint()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StockMaster.getpointsawarded()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StockMaster.getpointsrequiredtobuy()#" cfsqltype="CF_SQL_INTEGER" />
		   ) 
        SELECT Ident_Current('tblStockMaster') as ID 
		SET NOCOUNT OFF
	</cfquery>
	<cfset Stockmaster.setID(qStockmasterInsert.ID)>
    <cfset Stockmaster.setProductID(qStockmasterInsert.ID)>
	<cfset PopulateStores(Stockmaster) />
    <!---[       Trigger the version number so there is a maintenance update   ]---->
	<cfset variables.MonitorService.SetVersion() />

    <cfreturn Stockmaster />
</cffunction>

<cffunction name="PopulateStores" access="private" returntype="void" output="no" hint="Ensures that this product exists for every store.">
<cfargument name="argsStockMaster" required="yes" type="StockMaster" />
<cfset var StockMaster = arguments.argsStockMaster />
<cfset var PartNo = StockMaster.getPartNo() />
<cfset var ProductID = StockMaster.getProductID() />
<!---[   First get all store IDs.   ]---->
<cfquery name="qGetStores" datasource="#variables.dsn#">
	SELECT StoreID from TBLStores
    Order by StoreID
</cfquery>
<!---[   Delete all current records in the StockLocation for this partNO   ]---->
<cfquery name="qDeleteCurrent" datasource="#variables.dsn#">
	Delete from tblStockLocation
    WHERE ProductID = <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer" />
</cfquery>
<!---[   Now loop through the StoreIDs and insert the PartNo for each store.   ]---->
<cfloop query="qGetStores">
	<cfquery name="qInsertRecord" datasource="#variables.dsn#">
    	INSERT INTO tblStockLocation (StoreID, productid, PartNo) VALUES
        (
        <cfqueryparam value="#qGetStores.StoreID#" cfsqltype="cf_sql_integer" />,
        <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer" />,
        <cfqueryparam value="#PartNo#" cfsqltype="cf_sql_varchar" />
        )
    </cfquery>
</cfloop>
</cffunction>       

<cffunction name="IssueIndexes" access="private" returntype="StockMaster" output="no" hint="Works out the new index value for the insert.">
<cfargument name="argsStockmaster" type="Stockmaster" required="yes" />
	<cfset var Stockmaster = arguments.argsStockmaster />
    
<!---[       First check if the PartNo or ProductID exist already in the database   ]---->
<cfquery name="qCheckPartProductIDS" datasource="#variables.dsn#">
	SELECT PartNo
    FROM tblStockMaster
    WHERE
    PartNO = <cfqueryparam value="#stockmaster.getPartNO()#" cfsqltype="cf_sql_varchar"/>    
</cfquery>
<cfif qCheckPartProductIDS.recordcount >
	
</cfif>

<!---[   First work out index value.   ]---->
    <cfquery name="qgetCurrentIndex" datasource="#variables.dsn#" >
    SELECT Max(ProductID) as currentindex from tblStockMaster
    </cfquery>
    
    <cfif qgetCurrentIndex.recordcount GT '0'>
    	<cfset NewIndex = qgetCurrentIndex.currentindex + 1 />
    <cfelse>
    	<cfset NewIndex = 1 />
    </cfif>
    
    <cfset Stockmaster.setProductID(NewIndex)>
    <cfset Stockmaster.setPartNo(NewIndex)>
    
 </cffunction>   

<cffunction name="update" access="private" returntype="Stockmaster" output="false" hint="DAO method">
<cfargument name="argsStockmaster" type="Stockmaster" required="yes" />
	<cfset var Stockmaster = arguments.argsStockmaster />
	<cfset var StockmasterUpdate = 0 >

	<cfquery name="StockmasterUpdate" datasource="#variables.dsn#" result="SQL" >
    	
		UPDATE tblStockMaster SET
            partno  = <cfqueryparam value="#StockMaster.getPartNo()#" cfsqltype="CF_SQL_VARCHAR"/>,
            description  = <cfqueryparam value="#StockMaster.getDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
            supplyunit  = <cfqueryparam value="#StockMaster.getSupplyUnit()#" cfsqltype="CF_SQL_VARCHAR"/>,
            orderingunit  = <cfqueryparam value="#StockMaster.getOrderingUnit()#" cfsqltype="CF_SQL_VARCHAR"/>,
            label  = <cfqueryparam value="#StockMaster.getLabel()#" cfsqltype="CF_SQL_VARCHAR"/>,
            groupno  = <cfqueryparam value="#StockMaster.getGroupNo()#" cfsqltype="CF_SQL_INTEGER"/>,
            tcode  = <cfqueryparam value="#StockMaster.getTCode()#" cfsqltype="CF_SQL_INTEGER"/>,
            pcode  = <cfqueryparam value="#StockMaster.getPCode()#" cfsqltype="CF_SQL_INTEGER"/>,
            rcode  = <cfqueryparam value="#StockMaster.getRCode()#" cfsqltype="CF_SQL_INTEGER"/>,
            tolerance  = <cfqueryparam value="#StockMaster.getTolerance()#" cfsqltype="CF_SQL_FLOAT"/>,
            cost  = <cfqueryparam value="#StockMaster.getCost()#" cfsqltype="CF_SQL_FLOAT"/>,
            wholesale  = <cfqueryparam value="#StockMaster.getWholesale()#" cfsqltype="CF_SQL_FLOAT"/>,
            maxretail  = <cfqueryparam value="#StockMaster.getMaxRetail()#" cfsqltype="CF_SQL_FLOAT"/>,
            plutype  = <cfqueryparam value="#StockMaster.getPluType()#" cfsqltype="CF_SQL_VARCHAR"/>,
            lockorderunittype  = <cfqueryparam value="#StockMaster.getLockOrderUnitType()#" cfsqltype="CF_SQL_BIT"/>,
            minorderqty  = <cfqueryparam value="#StockMaster.getMinOrderQty()#" cfsqltype="CF_SQL_FLOAT"/>,
            picturefile  = <cfqueryparam value="#StockMaster.getPictureFile()#" cfsqltype="CF_SQL_INTEGER"/>,
            nolongerused  = <cfqueryparam value="#StockMaster.getNoLongerUsed()#" cfsqltype="CF_SQL_BIT"/>,
            suppressorder  = <cfqueryparam value="#StockMaster.getSuppressOrder()#" cfsqltype="CF_SQL_BIT"/>,
            suppressstocktake  = <cfqueryparam value="#StockMaster.getSuppressStocktake()#" cfsqltype="CF_SQL_BIT"/>,
            dateentered  = <cfqueryparam value="#variables.austime#" cfsqltype="CF_SQL_TIMESTAMP"/>,
            partnobuyingplu  = <cfqueryparam value="#StockMaster.getPartNoBuyingPlu()#" cfsqltype="CF_SQL_VARCHAR"/>,
            partnosaleplu  = <cfqueryparam value="#StockMaster.getPartNoSalePlu()#" cfsqltype="CF_SQL_VARCHAR"/>,
            ratio  = <cfqueryparam value="#StockMaster.getRatio()#" cfsqltype="CF_SQL_FLOAT"/>,
            prepcode  = <cfqueryparam value="#StockMaster.getPrepCode()#" cfsqltype="CF_SQL_VARCHAR"/>,
            threehrebate  = <cfqueryparam value="#StockMaster.getThreeHRebate()#" cfsqltype="CF_SQL_FLOAT"/>,
            screbate  = <cfqueryparam value="#StockMaster.getSCRebate()#" cfsqltype="CF_SQL_FLOAT"/>,
            threehrebateval  = <cfqueryparam value="#StockMaster.getThreeHRebateVal()#" cfsqltype="CF_SQL_FLOAT"/>,
            screbateval  = <cfqueryparam value="#StockMaster.getSCRebateVal()#" cfsqltype="CF_SQL_FLOAT"/>,
            parentcost  = <cfqueryparam value="#StockMaster.getParentCost()#" cfsqltype="CF_SQL_FLOAT"/>,
            typeid  = <cfqueryparam value="#StockMaster.getTypeID()#" cfsqltype="CF_SQL_INTEGER"/>,
            kitchentype  = <cfqueryparam value="#StockMaster.getkitchentype()#" cfsqltype="CF_SQL_INTEGER"/>,
            modifierid  = <cfqueryparam value="#StockMaster.getModifierID()#" cfsqltype="CF_SQL_INTEGER"/>,
            modifiertype = <cfqueryparam value="#StockMaster.getModifierType()#" cfsqltype="CF_SQL_INTEGER" />,
            isweighed  = <cfqueryparam value="#StockMaster.getIsWeighed()#" cfsqltype="CF_SQL_BIT"/>,
            tare  = <cfqueryparam value="#StockMaster.getTare()#" cfsqltype="CF_SQL_FLOAT"/>,
            allowzeroprice  = <cfqueryparam value="#StockMaster.getAllowZeroPrice()#" cfsqltype="CF_SQL_BIT"/>,
            discountable  = <cfqueryparam value="#StockMaster.getDiscountable()#" cfsqltype="CF_SQL_BIT"/>,
            iscountdown  = <cfqueryparam value="#StockMaster.getIsCountDown()#" cfsqltype="CF_SQL_BIT"/>,
            allowopenprice  = <cfqueryparam value="#StockMaster.getAllowOpenPrice()#" cfsqltype="CF_SQL_BIT"/>,
            discountno  = <cfqueryparam value="#StockMaster.getDiscountNo()#" cfsqltype="CF_SQL_INTEGER"/>,
            kitchenprint  = <cfqueryparam value="#StockMaster.getKitchenPrint()#" cfsqltype="CF_SQL_VARCHAR"/>,
            pointsawarded  = <cfqueryparam value="#StockMaster.getPointsAwarded()#" cfsqltype="CF_SQL_INTEGER"/>,
            pointsrequiredtobuy  = <cfqueryparam value="#StockMaster.getPointsRequiredToBuy()#" cfsqltype="CF_SQL_INTEGER"/>
						
		WHERE 
		ID = <cfqueryparam value="#Stockmaster.getID()#" cfsqltype="CF_SQL_Integer" />
        
	</cfquery>
    
   <!---[       Trigger the version number so there is a maintenance update   ]---->
	<cfset variables.MonitorService.SetVersion() />
    <!---[   Ensure this product is available for all stores.   ]---->
    <cfset PopulateStores(Stockmaster) />
	<cfreturn Stockmaster />
</cffunction>

</cfcomponent>
