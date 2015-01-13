<cfcomponent displayname="PosMixMatchProduct DAO" output="false" hint="DAO Component Handles all Database access for the table PosMixMatchProduct.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    PosMixMatchProductDAO.cfc
Description: DAO Component Handles all Database access for the table PosMixMatchProduct.  Requires Coldspring v1.0
Date:        5/May/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( PosMixMatchProduct.getpostxid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="PosMixMatchProductDAO" output="false" hint="Initialises the controller">
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


<cffunction name="save" access="public" returntype="PosMixMatchProduct" output="false" hint="DAO method">
<cfargument name="PosMixMatchProduct" type="PosMixMatchProduct" required="yes" />
<!-----[  If a MixMatchID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->

<cfif recordexists( arguments.PosMixMatchProduct ) >	
		<cfset PosMixMatchProduct = update(arguments.PosMixMatchProduct)/>
	<cfelse>
		<cfset PosMixMatchProduct = create(arguments.PosMixMatchProduct)/>
	</cfif>
	<cfreturn PosMixMatchProduct />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PosMixMatchProduct" type="PosMixMatchProduct" required="true" /> 
	<cfset var qPosMixMatchProductDelete = 0 >
<cfquery name="PosMixMatchProductDelete" datasource="#variables.dsn#" >
		DELETE FROM PosMixMatchProduct
		WHERE 
		PosTXID = <cfqueryparam value="#PosMixMatchProduct.getPosTXID()#" cfsqltype="cf_sql_integer" /> AND
        MixMatchID = <cfqueryparam value="#PosMixMatchProduct.getMixMatchID()#" cfsqltype="cf_sql_integer" /> AND
        ProductID = <cfqueryparam value="#PosMixMatchProduct.getProductID()#" cfsqltype="cf_sql_integer" />
	</cfquery>
	
</cffunction>


<cffunction name="recordexists" access="public" returntype="boolean" output="no" hint="Checks if a record already exists in the database">
    <cfargument name="argsPosMixMatchProduct" type="PosMixMatchProduct" required="yes" />
    <cfset var PosMixMatchProduct = arguments.argsPosMixMatchProduct />
    <cfset var Result = false />
    
    <cfquery name="qRecordExists" datasource="#variables.dsn#">
        SELECT ProductID from PosMixMatchProduct where 
        PosTXID = <cfqueryparam value="#PosMixMatchProduct.getPosTXID()#" cfsqltype="cf_sql_integer" /> AND
        MixMatchID = <cfqueryparam value="#PosMixMatchProduct.getMixMatchID()#" cfsqltype="cf_sql_integer" /> AND
        ProductID = <cfqueryparam value="#PosMixMatchProduct.getProductID()#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <cfif qRecordExists.recordcount> <Cfset result=True /></cfif>
    <cfreturn result />
</cffunction>



<cffunction name="read" access="public" returntype="PosMixMatchProduct" output="false" hint="DAO Method. - Reads a PosMixMatchProduct into the bean">
<cfargument name="argsPosMixMatchProduct" type="PosMixMatchProduct" required="true" />
	<cfset var PosMixMatchProduct  =  arguments.argsPosMixMatchProduct />
	<cfset var QPosMixMatchProductselect = "" />
	<cfquery name="QPosMixMatchProductselect" datasource="#variables.dsn#">
		SELECT 
		PosTXID, MixMatchID, ProductID, ProductCode, Description, ProductQuantity, ProductValue
		FROM PosMixMatchProduct 
		WHERE 
		PosTXID = <cfqueryparam value="#PosMixMatchProduct.getPosTXID()#" cfsqltype="cf_sql_integer" /> AND
        MixMatchID = <cfqueryparam value="#PosMixMatchProduct.getMixMatchID()#" cfsqltype="cf_sql_integer" /> AND
        ProductID = <cfqueryparam value="#PosMixMatchProduct.getProductID()#" cfsqltype="cf_sql_integer" />
	</cfquery>
	<cfif QPosMixMatchProductselect.recordCount >
		<cfscript>
		 PosMixMatchProduct.setPosTXID(QPosMixMatchProductselect.PosTXID);
         PosMixMatchProduct.setMixMatchID(QPosMixMatchProductselect.MixMatchID);
         PosMixMatchProduct.setProductID(QPosMixMatchProductselect.ProductID);
         PosMixMatchProduct.setProductCode(QPosMixMatchProductselect.ProductCode);
         PosMixMatchProduct.setDescription(QPosMixMatchProductselect.Description);
         PosMixMatchProduct.setProductQuantity(QPosMixMatchProductselect.ProductQuantity);
         PosMixMatchProduct.setProductValue(QPosMixMatchProductselect.ProductValue);
         
		</cfscript>
	</cfif>
	<cfreturn PosMixMatchProduct />
</cffunction>
		

<cffunction name="GetAllPosMixMatchProducts" access="public" output="false" returntype="query" hint="Returns a query of all PosMixMatchProducts in our Database">
<cfset var QgetallPosMixMatchProducts = 0 />
	<cfquery name="QgetallPosMixMatchProducts" datasource="#variables.dsn#">
		SELECT PosTXID, MixMatchID, ProductID, ProductCode, Description, ProductQuantity, ProductValue
		FROM PosMixMatchProduct 
		ORDER BY MixMatchID
	</cfquery>
	<cfreturn QgetallPosMixMatchProducts />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="PosMixMatchProduct" output="false" hint="DAO method">
<cfargument name="argsPosMixMatchProduct" type="PosMixMatchProduct" required="yes" displayname="create" />
	<cfset var qPosMixMatchProductInsert = 0 />
	<cfset var PosMixMatchProduct = arguments.argsPosMixMatchProduct />
	
	<cfquery name="qPosMixMatchProductInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into PosMixMatchProduct
		( PosTXID, MixMatchID, ProductID, ProductCode, Description, ProductQuantity, ProductValue ) VALUES
		(

		<cfqueryparam value="#PosMixMatchProduct.getpostxid()#" cfsqltype="CF_SQL_INTEGER" />,
        <cfqueryparam value="#PosMixMatchProduct.getMixMatchID()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosMixMatchProduct.getproductid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosMixMatchProduct.getproductcode()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosMixMatchProduct.getdescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosMixMatchProduct.getproductquantity()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosMixMatchProduct.getproductvalue()#" cfsqltype="CF_SQL_FLOAT" />
		   ) 
		SET NOCOUNT OFF
	</cfquery>
	
	<cfreturn PosMixMatchProduct />
</cffunction>

<cffunction name="update" access="private" returntype="PosMixMatchProduct" output="false" hint="DAO method">
<cfargument name="argsPosMixMatchProduct" type="PosMixMatchProduct" required="yes" />
	<cfset var PosMixMatchProduct = arguments.argsPosMixMatchProduct />
	<cfset var PosMixMatchProductUpdate = 0 >
	<cfquery name="PosMixMatchProductUpdate" datasource="#variables.dsn#" >
		UPDATE PosMixMatchProduct SET
productcode  = <cfqueryparam value="#PosMixMatchProduct.getProductCode()#" cfsqltype="CF_SQL_VARCHAR"/>,
description  = <cfqueryparam value="#PosMixMatchProduct.getDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
productquantity  = <cfqueryparam value="#PosMixMatchProduct.getProductQuantity()#" cfsqltype="CF_SQL_FLOAT"/>,
productvalue  = <cfqueryparam value="#PosMixMatchProduct.getProductValue()#" cfsqltype="CF_SQL_FLOAT"/>
						
		WHERE 
		MixMatchID = <cfqueryparam value="#PosMixMatchProduct.getMixMatchID()#"   cfsqltype="CF_SQL_INTEGER" /> AND
        postxid  = <cfqueryparam value="#PosMixMatchProduct.getPosTXID()#" cfsqltype="CF_SQL_INTEGER"/> AND
		productid  = <cfqueryparam value="#PosMixMatchProduct.getProductID()#" cfsqltype="CF_SQL_INTEGER"/>        
	</cfquery>
	
	<cfreturn PosMixMatchProduct />
</cffunction>

</cfcomponent>