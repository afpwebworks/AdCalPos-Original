<cfcomponent displayname="PosMixMatch DAO" output="false" hint="DAO Component Handles all Database access for the table PosMixMatch.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    PosMixMatchDAO.cfc
Description: DAO Component Handles all Database access for the table PosMixMatch.  Requires Coldspring v1.0
Date:        5/May/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( PosMixMatch.getpostxid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="PosMixMatchDAO" output="false" hint="Initialises the controller">
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


<cffunction name="save" access="public" returntype="PosMixMatch" output="false" hint="DAO method">
<cfargument name="PosMixMatch" type="PosMixMatch" required="yes" />
<!-----[  If a MixMatchID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<!---[   <cfif (arguments.MixMatch.getMixMatchID() neq "0")>	   ]---->
<cfif recordexists( arguments.PosMixMatch ) >
		<cfset PosMixMatch = update(arguments.PosMixMatch)/>
	<cfelse>
		<cfset PosMixMatch = create(arguments.PosMixMatch)/>
	</cfif>
	<cfreturn PosMixMatch />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PosMixMatch" type="PosMixMatch" required="true" /> 
	<cfset var qPosMixMatchDelete = 0 >
<cfquery name="PosMixMatchDelete" datasource="#variables.dsn#" >
		DELETE FROM PosMixMatch
		WHERE 
		MixMatchID = <cfqueryparam value="#PosMixMatch.getMixMatchID()#"   cfsqltype="CF_SQL_INTEGER" />  AND
        postxid  = <cfqueryparam value="#PosMixMatch.getPosTXID()#" cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	
</cffunction>

<cffunction name="recordexists" access="public" returntype="boolean" output="no" hint="Checks if a record already exists in the database">
    <cfargument name="PosMixMatch" type="PosMixMatch" required="yes" />
    <cfset var MixMatch = arguments.PosMixMatch />
    <cfset var Result = false />
    
    <cfquery name="qRecordExists" datasource="#variables.dsn#">
        SELECT MixMatchID from PosMixMatch where 
        PosTXID = <cfqueryparam value="#MixMatch.getPosTXID()#" cfsqltype="cf_sql_integer" /> AND
        MixMatchID = <cfqueryparam value="#MixMatch.getMixMatchID()#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <cfif qRecordExists.recordcount> <Cfset result=True /></cfif>
    <cfreturn result />
</cffunction>




<cffunction name="read" access="public" returntype="PosMixMatch" output="false" hint="DAO Method. - Reads a PosMixMatch into the bean">
<cfargument name="argsPosMixMatch" type="PosMixMatch" required="true" />
	<cfset var PosMixMatch  =  arguments.argsPosMixMatch />
	<cfset var QPosMixMatchselect = "" />
	<cfquery name="QPosMixMatchselect" datasource="#variables.dsn#">
		SELECT 
		PosTXID, MixMatchID, MixMatchDescription, MixMatchTriggerType, MixMatchTriggerValue, MixMatchGiveAwayType, MixMatchGiveAwayValue, MixMatchResetTrigger, ProductQuantity, ProductValue, MixMatchTotal, MixMatchQuantity
		FROM PosMixMatch 
		WHERE 
		MixMatchID = <cfqueryparam value="#PosMixMatch.getMixMatchID()#"   cfsqltype="CF_SQL_INTEGER" />  AND
        postxid  = <cfqueryparam value="#PosMixMatch.getPosTXID()#" cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QPosMixMatchselect.recordCount >
		<cfscript>
		PosMixMatch.setPosTXID(QPosMixMatchselect.PosTXID);
         PosMixMatch.setMixMatchID(QPosMixMatchselect.MixMatchID);
         PosMixMatch.setMixMatchDescription(QPosMixMatchselect.MixMatchDescription);
         PosMixMatch.setMixMatchTriggerType(QPosMixMatchselect.MixMatchTriggerType);
         PosMixMatch.setMixMatchTriggerValue(QPosMixMatchselect.MixMatchTriggerValue);
         PosMixMatch.setMixMatchGiveAwayType(QPosMixMatchselect.MixMatchGiveAwayType);
         PosMixMatch.setMixMatchGiveAwayValue(QPosMixMatchselect.MixMatchGiveAwayValue);
         PosMixMatch.setMixMatchResetTrigger(QPosMixMatchselect.MixMatchResetTrigger);
         PosMixMatch.setProductQuantity(QPosMixMatchselect.ProductQuantity);
         PosMixMatch.setProductValue(QPosMixMatchselect.ProductValue);
         PosMixMatch.setMixMatchTotal(QPosMixMatchselect.MixMatchTotal);
         PosMixMatch.setMixMatchQuantity(QPosMixMatchselect.MixMatchQuantity);
         
		</cfscript>
	</cfif>
	<cfreturn PosMixMatch />
</cffunction>
		

<cffunction name="GetAllPosMixMatchs" access="public" output="false" returntype="query" hint="Returns a query of all PosMixMatchs in our Database">
<cfset var QgetallPosMixMatchs = 0 />
	<cfquery name="QgetallPosMixMatchs" datasource="#variables.dsn#">
		SELECT PosTXID, MixMatchID, MixMatchDescription, MixMatchTriggerType, MixMatchTriggerValue, MixMatchGiveAwayType, MixMatchGiveAwayValue, MixMatchResetTrigger, ProductQuantity, ProductValue, MixMatchTotal, MixMatchQuantity
		FROM PosMixMatch 
		ORDER BY MixMatchID
	</cfquery>
	<cfreturn QgetallPosMixMatchs />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="PosMixMatch" output="false" hint="DAO method">
<cfargument name="argsPosMixMatch" type="PosMixMatch" required="yes" displayname="create" />
	<cfset var qPosMixMatchInsert = 0 />
	<cfset var PosMixMatch = arguments.argsPosMixMatch />
	
	<cfquery name="qPosMixMatchInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into PosMixMatch
		( PosTXID, MixMatchID, MixMatchDescription, MixMatchTriggerType, MixMatchTriggerValue, MixMatchGiveAwayType, MixMatchGiveAwayValue, MixMatchResetTrigger, ProductQuantity, ProductValue, MixMatchTotal, MixMatchQuantity ) VALUES
		(

		<cfqueryparam value="#PosMixMatch.getpostxid()#" cfsqltype="CF_SQL_Integer" />,
        <cfqueryparam value="#PosMixMatch.getMixMatchID()#" cfsqltype="CF_SQL_Integer" />,
		<cfqueryparam value="#PosMixMatch.getmixmatchdescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosMixMatch.getmixmatchtriggertype()#" cfsqltype="CF_SQL_TINYINT" />,
		<cfqueryparam value="#PosMixMatch.getmixmatchtriggervalue()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosMixMatch.getmixmatchgiveawaytype()#" cfsqltype="CF_SQL_TINYINT" />,
		<cfqueryparam value="#PosMixMatch.getmixmatchgiveawayvalue()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosMixMatch.getmixmatchresettrigger()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PosMixMatch.getproductquantity()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosMixMatch.getproductvalue()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosMixMatch.getmixmatchtotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosMixMatch.getmixmatchquantity()#" cfsqltype="CF_SQL_FLOAT" />
		   ) 
		SET NOCOUNT OFF
	</cfquery>
	<!---[   <cfset PosMixMatch.setMixMatchID(qPosMixMatchInsert.MixMatchID)>   ]---->

	<cfreturn PosMixMatch />
</cffunction>

<cffunction name="update" access="private" returntype="PosMixMatch" output="false" hint="DAO method">
<cfargument name="argsPosMixMatch" type="PosMixMatch" required="yes" />
	<cfset var PosMixMatch = arguments.argsPosMixMatch />
	<cfset var PosMixMatchUpdate = 0 >
	<cfquery name="PosMixMatchUpdate" datasource="#variables.dsn#" >
		UPDATE PosMixMatch SET
mixmatchdescription  = <cfqueryparam value="#PosMixMatch.getMixMatchDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
mixmatchtriggertype  = <cfqueryparam value="#PosMixMatch.getMixMatchTriggerType()#" cfsqltype="CF_SQL_TINYINT"/>,
mixmatchtriggervalue  = <cfqueryparam value="#PosMixMatch.getMixMatchTriggerValue()#" cfsqltype="CF_SQL_FLOAT"/>,
mixmatchgiveawaytype  = <cfqueryparam value="#PosMixMatch.getMixMatchGiveAwayType()#" cfsqltype="CF_SQL_TINYINT"/>,
mixmatchgiveawayvalue  = <cfqueryparam value="#PosMixMatch.getMixMatchGiveAwayValue()#" cfsqltype="CF_SQL_FLOAT"/>,
mixmatchresettrigger  = <cfqueryparam value="#PosMixMatch.getMixMatchResetTrigger()#" cfsqltype="CF_SQL_BIT"/>,
productquantity  = <cfqueryparam value="#PosMixMatch.getProductQuantity()#" cfsqltype="CF_SQL_FLOAT"/>,
productvalue  = <cfqueryparam value="#PosMixMatch.getProductValue()#" cfsqltype="CF_SQL_FLOAT"/>,
mixmatchtotal  = <cfqueryparam value="#PosMixMatch.getMixMatchTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
mixmatchquantity  = <cfqueryparam value="#PosMixMatch.getMixMatchQuantity()#" cfsqltype="CF_SQL_FLOAT"/>
						
		WHERE 
		MixMatchID = <cfqueryparam value="#PosMixMatch.getMixMatchID()#"   cfsqltype="CF_SQL_INTEGER" />  AND
        postxid  = <cfqueryparam value="#PosMixMatch.getPosTXID()#" cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	
	<cfreturn PosMixMatch />
</cffunction>

</cfcomponent>