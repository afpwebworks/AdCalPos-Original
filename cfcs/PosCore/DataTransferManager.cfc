<cfcomponent displayname="Display name" output="no" hint="this is the function of this CFC">
<cfsilent>
<!----
==========================================================================================================
Filename:     DataTransferManager.cfc
Description:  Manages the transfer of data from the SQLserver database to the Access database for broadcast to the terminals
Date:         13/9/2010
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
    <cfset variables.dsnout = variables.config.getFTPDSN() />
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
       <!---[    And set the application variable to the same    ]---->
        <cfset variables.config.setcurrentversion( Revision  )/>      
        
    </cffunction>
    
    
	<cffunction name="getAllProductMDB" access="public" returntype="query" output="false" hint="Returns a query of all records in the MDF Product table" >
		<cfset var qProducts="0" />
		
        <cfquery name="qProducts" datasource="#variables.dsnout#">
        	SELECT * from product
            Order by ProductID
        </cfquery>
        <cfreturn qProducts />
	</cffunction>
    
    <cffunction name="getAllProductSQL" access="public" returntype="query" output="false" hint="Returns a query of all records in the SqlServer Product table" >
		<cfset var qProducts="0" />
		
        <cfquery name="qProducts" datasource="#variables.dsn#">
        	SELECT * from tblStockMaster
            Order by ProductID
        </cfquery>
        <cfreturn qProducts />
	</cffunction>
    
  <cffunction name="getAllBarcodesSQL" access="public" returntype="query" output="false" hint="Returns a query of all records in the SqlServer Product table" >
		<cfset var qBarcodes="0" />

        <cfquery name="qBarcodes" datasource="#variables.dsn#">
        	SELECT b.partno, b.barcode, p.productid  
            FROM tblstockbarcode b, tblStockMaster p
            WHERE
            b.partno = p.partno
            Order By p.ProductID, b.Barcode
        </cfquery>
        <cfreturn qBarcodes />
   </cffunction> 
    
	
 <cffunction name="SQLPlutypetoMDB" access="public" returntype="numeric" output="no" hint="Converts alphabetic SQLPlutype to MDB Numeric Plutype.">
    <cfargument name="argsPLUType" required="yes" type="string" />
    <cfset var PluTYpe = arguments.argsPLUTYpe />
    <cfset var NumericType = 0 />
    <cfswitch expression="#plutype#">
    <cfcase value="N"><cfset NumericType = "1" /></cfcase>
    <cfcase value="P"><cfset NumericType = "2" /></cfcase>
    <cfcase value="M"><cfset NumericType = "3" /></cfcase>
    <cfcase value="4"><cfset NumericType = "4" /></cfcase>
    <cfcase value="C"><cfset NumericType = "9" /></cfcase>
    <cfcase value="5"><cfset NumericType = "6" /></cfcase>
    <cfcase value="Normal"><cfset NumericType = "1" /></cfcase>
    <cfcase value="Portion/processed"><cfset NumericType = "2" /></cfcase>
    <cfcase value="Manufactured"><cfset NumericType = "3" /></cfcase>
    <cfcase value="Miscellaneous"><cfset NumericType = "4" /></cfcase>
    <cfcase value="Condiment"><cfset NumericType = "9" /></cfcase>
    <cfcase value="Combo"><cfset NumericType = "6" /></cfcase>  
    <cfdefaultcase> <cfset NumericType = "0" /></cfdefaultcase> 
    </cfswitch>
    <!---[   1:Stock Item;2:Portion;3:Prepared;4:Miscellaneous;9:Condiment;255:Discontinued   ]---->
    <cfreturn NumericType />
</cffunction>


 <cffunction name="MDBPlutypetoSQL" access="public" returntype="string" output="no" hint="Converts numeric Plutype to SQLServer Alphanumeric Plutype.">
    <cfargument name="argsPLUType" required="yes" type="numeric" />
    <cfset var PluTYpe = arguments.argsPLUTYpe />
    <cfset var AlphaType = "" />
    <cfswitch expression="#plutype#">
    <cfcase value="1"><cfset AlphaType = "Normal" /></cfcase>
    <cfcase value="2"><cfset AlphaType = "Portion/processed" /></cfcase>
    <cfcase value="3"><cfset AlphaType = "Manufactured" /></cfcase>
    <cfcase value="4"><cfset AlphaType = "Miscellaneous" /></cfcase>
    <cfcase value="5"><cfset AlphaType = "Combo" /></cfcase>
    <cfdefaultcase> <cfset AlphaType = "0" /></cfdefaultcase> 
    </cfswitch>
    <!---[   1:Stock Item;2:Portion;3:Prepared;4:Miscellaneous;9:Condiment;255:Discontinued   ]---->
    <cfreturn AlphaType />
</cffunction>

<cffunction name="savetoMDB" access="public" returntype="void" output="no" hint="Inserts a record into the MDB database Product Table.">
<cfargument name="argsMDBRecordStruct" required="yes" type="struct" />
     <cfset  var MDBProduct = arguments.argsMDBRecordStruct   />
     
    <!---[    Check if the record already exists in the access database.   If so, update.  Otherwise, Create   ]---->
	<cfquery name="qCheckExists" datasource="#variables.dsnout#">
     Select ProductID from PRODUCT where ProductID = <cfqueryparam value="#MDBProduct.ProductID#" />
    </cfquery>	
    <cfif qCheckExists.recordcount >
    	<cfset updateInMDB(  MDBProduct   ) />
    <cfelse>
        <cfset createInMDB(  MDBProduct   ) />
    </cfif>

</cffunction>

<cffunction name="saveBarcodetoMDB" access="public" returntype="void" output="no" hint="Inserts a record into the MDB database Product Table.">
	<cfargument name="argsPartNo" required="yes" type="string" />
    <cfargument name="argsBarcode" required="yes" type="any" />
    <cfargument name="argsProductID" required="yes" type="numeric" />
    <cfset var PartNo = arguments.argsPartNo />
    <cfset var ProductID = arguments.argsProductID />
    <cfset var Barcode = arguments.argsBarcode />
    
    <cfset qInsert = 0 />
    
    <cfquery name="qInsert" datasource="#variables.dsnout#">
    	INSERT into ProductBarcode ( PartNo, Barcode, ProductID) values (
        <cfqueryparam value="#PartNo#" cfsqltype="cf_sql_varchar" />,
         <cfqueryparam value="#Barcode#" cfsqltype="cf_sql_varchar" />,
         <cfqueryparam value="#productID#" cfsqltype="cf_sql_integer" />
        )
    </cfquery>
</cffunction>

<cffunction name="ClearBarcodeTableMDB" access="public" returntype="void" output="no" hint="Clears all the existing barcode records from the MDB ProductBarcode table prior to inserting new records.">
	<cfset qDelete = 0 />
	<cfquery name="qDelete" datasource="#variables.dsnout#">
    	DELETE from ProductBarcode where 0=0
    </cfquery>
    
</cffunction>

<!---[   
====================================================================================
Manipulating data from the tblStockProductPrice Table.
====================================================================================
   ]---->


<cffunction name="ClearPriceTableMDB" access="public" returntype="void" output="no" hint="Clears all the existing price records from the MDB ProductPrice table prior to inserting new records.">
	<cfset qDelete = 0 />
	<cfquery name="qDelete" datasource="#variables.dsnout#">
    	DELETE from ProductPrice where 0=0
    </cfquery>    
</cffunction>

<cffunction name="SetStockPriceRecordMDB" access="public" returntype="boolean" output="no" hint="Adds a Stockprice record to the Access database ProductPrice table.">
	<cfargument name="argsProductID" required="yes" type="numeric" />
    <cfargument name="argsPriceID" required="yes" type="numeric" />
    <cfargument name="argsSellIncludeTax" required="yes" type="numeric" />
    <cfargument name="argsSellUnit" required="yes" type="numeric" />
    <cfscript> 
	 var ProductID        = arguments.argsProductID;
     var SellIncludeTax   = arguments.argsSellIncludeTax ;
     var SellUnit         = arguments.argsSellUnit ;
	 var PriceID          = arguments.argsPriceID ;
	 var qInsert          = 0 ;	
	 var result           = true ; 
    </cfscript>
    <cftry>
    <cfquery name="qInsert" datasource="#variables.dsnout#" result="qResult">
    	INSERT into ProductPrice (ProductID, PriceID, SellIncludeTax, SellUnit) Values (
        <cfqueryparam value="#ProductID#" cfsqltype="cf_sql_integer" />,
        <cfqueryparam value="#PriceID#" cfsqltype="cf_sql_integer" />,
        <cfqueryparam value="#SellIncludeTax#" cfsqltype="cf_sql_bit" />,
        <cfqueryparam value="#SellUnit#" cfsqltype="cf_sql_float" />
        )
    </cfquery>
    <cfcatch type="database">
    	<cfset result = false />
    </cfcatch>
    </cftry>
    <cfreturn result />   
</cffunction>

<cffunction name="getAllProductPriceData" access="public" returntype="query" output="no" hint="Returns a query of the tblStockProductPrice table">
<cfset var qProductPriceData = 0 />
	<cfquery name="qProductPriceData" datasource="#variables.dsn#">
    	Select * from tblStockProductPrice
        ORDER BY ProductID, PriceID
    </cfquery>

	<cfreturn qProductPriceData />
</cffunction>
<!---[   
====================================================================================
Manipulating data from the tblStockPRice Table.
====================================================================================
   ]---->
   
<cffunction name="getAllPricesData" access="public" returntype="query" output="no" hint="Returns a query of the tblStockPrice table">
	<cfset var qPricesData = 0 />
	<cfquery name="qPricesData" datasource="#variables.dsn#">
    	Select * from tblStockPrice
        WHERE IsVisible = '1'
        ORDER BY PriceID
    </cfquery>

	<cfreturn qPricesData />
</cffunction>


<cffunction name="ClearPricesMDB" access="public" returntype="void" output="no" hint="Clears all the existing price records from the MDB ProductPrice table prior to inserting new records.">
	<cfset qDelete = 0 />
	<cfquery name="qDelete" datasource="#variables.dsnout#">
    	DELETE from Price where 0=0
    </cfquery>    
</cffunction>

<cffunction name="SetPriceMDB" access="public" returntype="boolean" output="no" hint="Adds a price record to the Access database Price table.">
 <cfargument name="argsPriceID" required="yes" type="any" />
 <cfargument name="argsDescription" required="yes" type="any" />
 <cfargument name="argsTimestamp" required="yes" type="any" />
 <cfset var PriceID = arguments.argsPriceID />
 <cfset var Description = arguments.argsDescription />
 <cfset var Timestamp = arguments.argsTimestamp />
 <cfset var Result = true />
 
    <cftry>
        <cfquery name="qInsert" datasource="#variables.dsnout#" result="qResult">
            INSERT into Price (PriceID, Description<!---[   , Timestamp   ]---->) Values (
            <cfqueryparam value="#PriceID#" cfsqltype="cf_sql_integer" />,
            <cfqueryparam value="#Description#" cfsqltype="cf_sql_varchar" />
			<!---[   ,
            <cfqueryparam value="#timestamp#" cfsqltype="cf_sql_timestamp" />   
			]---->
            )
        </cfquery>
        <cfcatch type="database">
            <cfset result = false />
        </cfcatch>
    </cftry>
    <cfreturn result />   
</cffunction>


<cffunction name="createInMDB" access="public" returntype="void" output="no" hint="Inserts a record into the MDB database Product Table.">
<cfargument name="argsMDBRecordStruct" required="yes" type="struct" />
     <cfset  var MDBProduct = arguments.argsMDBRecordStruct   />
	 <cfset  var qInsert = 0 />

<cfquery name="qInsert" datasource="#variables.dsnout#">
INSERT into Product ( ProductID, Description, ProductCode, ProductType, DepartmentID, KitchenType, ModifierType, ModifierID, TaxID, CostIncludeTax, CostUnit, IsWeighed, Tare, AllowZeroPrice, AllowOpenPrice, Discountable, DiscountNumber, IsCountDown, OnHand,KitchenPrint, PointsAwarded, PointsRequiredToBuy,<!---[    Timestamp,   ]----> ExternalID, PictureFile, Status ) 
Values 

(
    <cfqueryparam value="#MDBProduct.ProductID#" cfsqltype="cf_sql_integer" />,
    <cfqueryparam value="#MDBProduct.Description#" cfsqltype="cf_sql_varchar" />,
    <cfqueryparam value="#MDBProduct.ProductCode#" cfsqltype="cf_sql_varchar" />,
    <cfqueryparam value="#MDBProduct.ProductType#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#MDBProduct.DepartmentID#" cfsqltype="cf_sql_integer" />,
    <cfqueryparam value="#MDBProduct.KitchenType#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#MDBProduct.ModifierType#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#MDBProduct.ModifierID#" cfsqltype="cf_sql_integer" />,
    <cfqueryparam value="#MDBProduct.TaxID#" cfsqltype="cf_sql_integer" />,
    <cfqueryparam value="#MDBProduct.CostIncludeTax#" cfsqltype="cf_sql_bit" />,
    <cfqueryparam value="#MDBProduct.CostUnit#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#MDBProduct.IsWeighed#" cfsqltype="cf_sql_bit"/>,
    <cfqueryparam value="#MDBProduct.Tare#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#MDBProduct.AllowZeroPrice#" cfsqltype="cf_sql_bit" />,
    <cfqueryparam value="#MDBProduct.AllowOpenPrice#" cfsqltype="cf_sql_bit" />,
    <cfqueryparam value="#MDBProduct.Discountable#" cfsqltype="cf_sql_bit" />,
    <cfqueryparam value="#MDBProduct.DiscountNumber#" cfsqltype="cf_sql_integer" />,
    <cfqueryparam value="#MDBProduct.IsCountDown#" cfsqltype="cf_sql_bit" />,
    <cfqueryparam value="#MDBProduct.OnHand#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#MDBProduct.KitchenPrint#" cfsqltype="cf_sql_varchar" />, 
    <cfqueryparam value="#MDBProduct.PointsAwarded#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#MDBProduct.PointsRequiredToBuy#" cfsqltype="cf_sql_float" />,
   <!---[    <cfqueryparam value="#variables.austime#" cfsqltype="cf_sql_timestamp"/>,   ]---->
    <cfqueryparam value="#MDBProduct.ExternalID#" cfsqltype="cf_sql_varchar" />,
    <cfqueryparam value="#MDBProduct.PictureFile#" cfsqltype="cf_sql_varchar" />,
    <cfqueryparam value="#MDBProduct.Status#" cfsqltype="cf_sql_integer" />
);
</cfquery>

</cffunction>


<cffunction name="updateInMDB" access="public" returntype="void" output="no" hint="Updates an existing record into the MDB database Product Table.">
<cfargument name="argsMDBRecordStruct" required="yes" type="struct" />
     <cfset  var MDBProduct = arguments.argsMDBRecordStruct   />
	 <cfset  var qUpdate = 0 />

<cfquery name="qUpdate" datasource="#variables.dsnout#">
Update Product  SET 

Description =<cfqueryparam value="#MDBProduct.Description#" cfsqltype="cf_sql_varchar" />,  
ProductCode =<cfqueryparam value="#MDBProduct.ProductCode#" cfsqltype="cf_sql_varchar" />, 
ProductType = <cfqueryparam value="#MDBProduct.ProductType#" cfsqltype="cf_sql_integer" />, 
DepartmentID =  <cfqueryparam value="#MDBProduct.DepartmentID#" cfsqltype="cf_sql_integer" />, 
KitchenType = <cfqueryparam value="#MDBProduct.KitchenType#" cfsqltype="cf_sql_integer" />, 
ModifierType= <cfqueryparam value="#MDBProduct.ModifierType#" cfsqltype="cf_sql_integer" />,
ModifierID = <cfqueryparam value="#MDBProduct.ModifierID#" cfsqltype="cf_sql_integer" />,
TaxID = <cfqueryparam value="#MDBProduct.TaxID#" cfsqltype="cf_sql_integer" />,
CostIncludeTax =<cfqueryparam value="#MDBProduct.CostIncludeTax#" cfsqltype="cf_sql_bit" />,
CostUnit = <cfqueryparam value="#MDBProduct.CostUnit#" cfsqltype="cf_sql_float" />, 
IsWeighed = <cfqueryparam value="#MDBProduct.IsWeighed#" cfsqltype="cf_sql_bit"/>,
Tare = <cfqueryparam value="#MDBProduct.Tare#" cfsqltype="cf_sql_float" />,
AllowZeroPrice = <cfqueryparam value="#MDBProduct.AllowZeroPrice#" cfsqltype="cf_sql_bit" />,
AllowOpenPrice =  <cfqueryparam value="#MDBProduct.AllowOpenPrice#" cfsqltype="cf_sql_bit" />,
Discountable =  <cfqueryparam value="#MDBProduct.Discountable#" cfsqltype="cf_sql_bit" />,
DiscountNumber = <cfqueryparam value="#MDBProduct.DiscountNumber#" cfsqltype="cf_sql_float" />,
IsCountDown = <cfqueryparam value="#MDBProduct.IsCountDown#" cfsqltype="cf_sql_bit" />,
OnHand = <cfqueryparam value="#MDBProduct.OnHand#" cfsqltype="cf_sql_float" />,
KitchenPrint = <cfqueryparam value="#MDBProduct.KitchenPrint#" cfsqltype="cf_sql_varchar" />, 
PointsAwarded = <cfqueryparam value="#MDBProduct.PointsAwarded#" cfsqltype="cf_sql_float" />,
PointsRequiredToBuy = <cfqueryparam value="#MDBProduct.PointsRequiredToBuy#" cfsqltype="cf_sql_float" />, 
<!---[   Timestamp = <cfqueryparam value="#variables.austime#" cfsqltype="cf_sql_timestamp"/>,   ]---->
ExternalID = <cfqueryparam value="#MDBProduct.ExternalID#" cfsqltype="cf_sql_varchar" />,
PictureFile = <cfqueryparam value="#MDBProduct.PictureFile#" cfsqltype="cf_sql_varchar" />,
Status  = <cfqueryparam value="#MDBProduct.Status#" cfsqltype="cf_sql_integer" />
WHERE
ProductID =  <cfqueryparam value="#MDBProduct.ProductID#" cfsqltype="cf_sql_integer" />
</cfquery>

</cffunction>


</cfcomponent>