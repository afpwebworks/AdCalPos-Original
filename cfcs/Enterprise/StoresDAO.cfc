<cfcomponent displayname="Display name" output="no" hint="this is the function of this CFC">
<cfsilent>
<!----
==========================================================================================================
Filename:     StoresDAO.cfc
Description:  Manages stores details for AdCalPos Enterprise
Date:         27/9/2010
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->

</cfsilent>
     <cffunction name="init" access="public" returntype="StoresDAO" output="false" hint="This is called by the framework and automatically maps variables in the current event to the instance variables of this bean.">
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

<cffunction name="getStoreDetails" access="public" returntype="query" output="no" hint="Returns a query of the store details. Requires a store ID or comma delimted list of storeids.">
<cfargument name="argsStoreID" required="yes" type="any">
	<cfset var storestosee = arguments.argsStoreID />
    <cfset var qStoreDetails = 0 />

    <!---[   If the stores to see is not "all",  remove references to "all" from the string   ]---->
	<cfif storestosee NEQ "ALL">
       <cfset storestosee = replacenocase(storestosee, "All,", "", "ALL") />
    
	<cfelseif (storestosee EQ "ALL") AND (variables.UserService.getuser().getUserTYpeID() GT variables.config.getmgmtreportcutoff() ) >
    	<cfset storestosee = variables.UserService.getuser().getSTORESTOSEE() />    
    </cfif>
    
    
    <cfquery name="qStoreDetails" datasource="#variables.dsn#">
    	SELECT s.*, g.storegroup, g.StoreGroupId 
        FROM tblstores s, tblstoregroup g
        WHERE s.storegroupid = g.storegroupid
        <cfif storestosee NEQ "ALL">
        AND s.storeid in (#storestosee#)
        </cfif>
        
    </cfquery>
    
    
	<cfreturn qStoreDetails />
</cffunction>

<cffunction name="getStoreName" access="public" returntype="string" output="no" hint="Returns a string of the store Name. Requires a store ID">
<cfargument name="argsStoreID" required="yes" type="numeric">
	<cfset var StoreID = arguments.argsStoreID />
    <cfset var qStoreName = 0 />
        <cfquery name="qStoreName" datasource="#variables.dsn#">
            SELECT StoreName from tblStores
            WHERE
            StoreID = <cfqueryparam value="#storeID#" cfsqltype="cf_sql_integer" />
        </cfquery>
    
    <cfreturn qStoreName.StoreName />
</cffunction>

<cffunction name="getAllStores" access="public" returntype="query" output="no" hint="Returns a query of all stores, with names, addresses etc.  If the user's UserTypeID is 5 or greater, stores are filtered by assignment to user" >
    <cfset var qGetStores = 0 />
    
    <cfif variables.UserService.getuser().getUserTYpeID() GT variables.config.getmgmtreportcutoff() >
        <cfset storestosee = variables.UserService.getuser().getSTORESTOSEE() />        
    </cfif>
  
    <cfquery name="qGetStores" datasource="#variables.dsn#">
    	SELECT s.*, g.storegroup, g.StoreGroupId 
        FROM tblstores s, tblstoregroup g
        WHERE
        s.storegroupid = g.storegroupid
		<cfif variables.UserService.getuser().getUserTYpeID() GT variables.config.getmgmtreportcutoff() >
            AND s.storeid in (#storestosee#)
        </cfif>
        Order by g.storegroup, s.state, s.storename, s.storeid
    </cfquery>
	<cfreturn qGetStores />
</cffunction>
	
   

<cffunction name="save" access="public" returntype="StoreBean" output="false" hint="DAO method">
<cfargument name="StoreBean" type="StoreBean" required="yes" />
<!-----[  If a StoreID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.StoreBean.getStoreID() neq "0")>	
		<cfset StoreBean = update(arguments.StoreBean)/>
	<cfelse>
		<cfset StoreBean = create(arguments.StoreBean)/>
	</cfif>
	<cfreturn StoreBean />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="StoreBean" type="StoreBean" required="true" /> 
	<cfset var qStoreBeanDelete = 0 >
<cfquery name="StoreBeanDelete" datasource="#variables.dsn#" >
		DELETE FROM tblStores
		WHERE 
		StoreID = <cfqueryparam value="#StoreBean.getStoreID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	
</cffunction>
   
    


<cffunction name="read" access="public" returntype="StoreBean" output="false" hint="DAO Method. - Reads a StoreBean into the bean">
<cfargument name="argsStoreBean" type="StoreBean" required="true" />
	<cfset var StoreBean  =  arguments.argsStoreBean />
	<cfset var QtblStoresselect = "" />
	<cfquery name="QtblStoresselect" datasource="#variables.dsn#">
		SELECT 
		s.StoreID, s.StoreName, s.Manager1Name, s.Manager2Name, s.StoreGroupID, s.Phone, s.Fax, s.Mobile, s.email, s.AcctBalance, s.CreditLimit, s.NoLongerUsed, s.FridayFactor, s.DateEntered, s.ChainID, s.ABN, s.Address, s.Suburb, s.State, s.PostCode, s.StartingStockEntered, s.StoreMail, s.SecurityCode, g.StoreGroup
		FROM tblStores s, tblStoreGroup g
		WHERE 
        s.StoreGroupID = g.StoreGroupID AND
		s.StoreID = <cfqueryparam value="#StoreBean.getStoreID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QtblStoresselect.recordCount >
		<cfscript>
		StoreBean.setStoreID(QtblStoresselect.StoreID);
         StoreBean.setStoreName(QtblStoresselect.StoreName);
         StoreBean.setManager1Name(QtblStoresselect.Manager1Name);
         StoreBean.setManager2Name(QtblStoresselect.Manager2Name);
         StoreBean.setStoreGroupID(QtblStoresselect.StoreGroupID);
		 StoreBean.setStoreGroup(QtblStoresselect.StoreGroup);
         StoreBean.setPhone(QtblStoresselect.Phone);
         StoreBean.setFax(QtblStoresselect.Fax);
         StoreBean.setMobile(QtblStoresselect.Mobile);
         StoreBean.setemail(QtblStoresselect.email);
         StoreBean.setAcctBalance(QtblStoresselect.AcctBalance);
         StoreBean.setCreditLimit(QtblStoresselect.CreditLimit);
         StoreBean.setNoLongerUsed(QtblStoresselect.NoLongerUsed);
         StoreBean.setFridayFactor(QtblStoresselect.FridayFactor);
         StoreBean.setDateEntered(QtblStoresselect.DateEntered);
         StoreBean.setChainID(QtblStoresselect.ChainID);
         StoreBean.setABN(QtblStoresselect.ABN);
         StoreBean.setAddress(QtblStoresselect.Address);
         StoreBean.setSuburb(QtblStoresselect.Suburb);
         StoreBean.setState(QtblStoresselect.State);
         StoreBean.setPostCode(QtblStoresselect.PostCode);
         StoreBean.setStartingStockEntered(QtblStoresselect.StartingStockEntered);
         StoreBean.setStoreMail(QtblStoresselect.StoreMail);
         StoreBean.setSecurityCode(QtblStoresselect.SecurityCode);
         
		</cfscript>
	</cfif>
	<cfreturn StoreBean />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="StoreBean" output="false" hint="DAO method">
<cfargument name="argsStoreBean" type="StoreBean" required="yes" displayname="create" />
	<cfset var qStoreBeanInsert = 0 />
	<cfset var StoreBean = arguments.argsStoreBean />
	
	<cfquery name="qStoreBeanInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into tblStores
		( StoreName, Manager1Name, Manager2Name, StoreGroupID, Phone, Fax, Mobile, email, AcctBalance, CreditLimit, NoLongerUsed, FridayFactor, DateEntered, ChainID, ABN, Address, Suburb, State, PostCode, StartingStockEntered, StoreMail, SecurityCode ) VALUES
		(

		<cfqueryparam value="#StoreBean.getstorename()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getmanager1name()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getmanager2name()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getstoregroupid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StoreBean.getphone()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getfax()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getmobile()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getemail()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getacctbalance()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StoreBean.getcreditlimit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StoreBean.getnolongerused()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#StoreBean.getfridayfactor()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#StoreBean.getdateentered()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#StoreBean.getchainid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#StoreBean.getabn()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getaddress()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getsuburb()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getstate()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getpostcode()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getstartingstockentered()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#StoreBean.getstoremail()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#StoreBean.getsecuritycode()#" cfsqltype="CF_SQL_VARCHAR" />
		   ) 
		SELECT Ident_Current('tblStores') as StoreID
		SET NOCOUNT OFF
	</cfquery>
	<cfset StoreBean.setStoreID(qStoreBeanInsert.StoreID)>

	<cfreturn StoreBean />
</cffunction>

<cffunction name="update" access="private" returntype="StoreBean" output="false" hint="DAO method">
<cfargument name="argsStoreBean" type="StoreBean" required="yes" />
	<cfset var StoreBean = arguments.argsStoreBean />
	<cfset var StoreBeanUpdate = 0 >
	<cfquery name="StoreBeanUpdate" datasource="#variables.dsn#" >
		UPDATE tblStores SET
storename  = <cfqueryparam value="#StoreBean.getStoreName()#" cfsqltype="CF_SQL_VARCHAR"/>,
manager1name  = <cfqueryparam value="#StoreBean.getManager1Name()#" cfsqltype="CF_SQL_VARCHAR"/>,
manager2name  = <cfqueryparam value="#StoreBean.getManager2Name()#" cfsqltype="CF_SQL_VARCHAR"/>,
storegroupid  = <cfqueryparam value="#StoreBean.getStoreGroupID()#" cfsqltype="CF_SQL_INTEGER"/>,
phone  = <cfqueryparam value="#StoreBean.getPhone()#" cfsqltype="CF_SQL_VARCHAR"/>,
fax  = <cfqueryparam value="#StoreBean.getFax()#" cfsqltype="CF_SQL_VARCHAR"/>,
mobile  = <cfqueryparam value="#StoreBean.getMobile()#" cfsqltype="CF_SQL_VARCHAR"/>,
email  = <cfqueryparam value="#StoreBean.getemail()#" cfsqltype="CF_SQL_VARCHAR"/>,
acctbalance  = <cfqueryparam value="#StoreBean.getAcctBalance()#" cfsqltype="CF_SQL_FLOAT"/>,
creditlimit  = <cfqueryparam value="#StoreBean.getCreditLimit()#" cfsqltype="CF_SQL_FLOAT"/>,
nolongerused  = <cfqueryparam value="#StoreBean.getNoLongerUsed()#" cfsqltype="CF_SQL_BIT"/>,
fridayfactor  = <cfqueryparam value="#StoreBean.getFridayFactor()#" cfsqltype="CF_SQL_FLOAT"/>,
dateentered  = <cfqueryparam value="#StoreBean.getDateEntered()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
chainid  = <cfqueryparam value="#StoreBean.getChainID()#" cfsqltype="CF_SQL_INTEGER"/>,
abn  = <cfqueryparam value="#StoreBean.getABN()#" cfsqltype="CF_SQL_VARCHAR"/>,
address  = <cfqueryparam value="#StoreBean.getAddress()#" cfsqltype="CF_SQL_VARCHAR"/>,
suburb  = <cfqueryparam value="#StoreBean.getSuburb()#" cfsqltype="CF_SQL_VARCHAR"/>,
state  = <cfqueryparam value="#StoreBean.getState()#" cfsqltype="CF_SQL_VARCHAR"/>,
postcode  = <cfqueryparam value="#StoreBean.getPostCode()#" cfsqltype="CF_SQL_VARCHAR"/>,
startingstockentered  = <cfqueryparam value="#StoreBean.getStartingStockEntered()#" cfsqltype="CF_SQL_BIT"/>,
storemail  = <cfqueryparam value="#StoreBean.getStoreMail()#" cfsqltype="CF_SQL_VARCHAR"/>,
securitycode  = <cfqueryparam value="#StoreBean.getSecurityCode()#" cfsqltype="CF_SQL_VARCHAR"/>
						
		WHERE 
		StoreID = <cfqueryparam value="#StoreBean.getStoreID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	
	<cfreturn StoreBean />
</cffunction>    
    
</cfcomponent>