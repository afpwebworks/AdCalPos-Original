<cfcomponent displayname="tblEodSummary DAO" output="false" hint="DAO Component Handles all Database access for the table tblEodSummary.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    EoDSummaryDAO.cfc
Description: DAO Component Handles all Database access for the table tblEodSummary.  Requires Coldspring v1.0
Date:        19/May/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( EoDSummary.geteodid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="EoDSummaryDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="save" access="public" returntype="EoDSummary" output="false" hint="DAO method">
<cfargument name="EoDSummary" type="EoDSummary" required="yes" />

<!---[   Check the EoD summary already exists in the database.   ]---->
<cfset recordExists( arguments.EoDSummary   ) />

<!-----[  If a EoDID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.EoDSummary.getEoDID() neq "0")>	
		<cfset EoDSummary = update(arguments.EoDSummary)/>
	<cfelse>
		<cfset EoDSummary = create(arguments.EoDSummary)/>
	</cfif>
	<cfreturn EoDSummary />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="EoDSummary" type="EoDSummary" required="true" /> 
	<cfset var qEoDSummaryDelete = 0 >
<cfquery name="EoDSummaryDelete" datasource="#variables.dsn#" >
		DELETE FROM tblEodSummary
		WHERE 
		EoDID = <cfqueryparam value="#EoDSummary.getEoDID()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
	
</cffunction>



<cffunction name="read" access="public" returntype="EoDSummary" output="false" hint="DAO Method. - Reads a EoDSummary into the bean">
<cfargument name="argsEoDSummary" type="EoDSummary" required="true" />
	<cfset var EoDSummary  =  arguments.argsEoDSummary />
	<cfset var QtblEodSummaryselect = "" />
	<cfquery name="QtblEodSummaryselect" datasource="#variables.dsn#">
		SELECT 
		EodID, Date, StoreID, Eod_ECR_CSV_Updated, Eod_PLU_CSV_Updated, EodHoursWorkedUpdated, EodWasteUpdated, EodTransferUpdated, EodMiscUpdated, EodStocktakeEnteredNotUpdated, EodStocktakeUpdated, DateEntered, Eod_EndOfDayFinished, StartingStockValEx, EndingStockValEx, StockVarianceValEx, PurchaseValEx, WastageValEx
		FROM tblEodSummary 
		WHERE 
		EoDID = <cfqueryparam value="#EoDSummary.getEoDID()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
	<cfif QtblEodSummaryselect.recordCount >
		<cfscript>
		EoDSummary.setEodID(QtblEodSummaryselect.EodID);
         EoDSummary.setDate(QtblEodSummaryselect.Date);
         EoDSummary.setStoreID(QtblEodSummaryselect.StoreID);
         EoDSummary.setEod_ECR_CSV_Updated(QtblEodSummaryselect.Eod_ECR_CSV_Updated);
         EoDSummary.setEod_PLU_CSV_Updated(QtblEodSummaryselect.Eod_PLU_CSV_Updated);
         EoDSummary.setEodHoursWorkedUpdated(QtblEodSummaryselect.EodHoursWorkedUpdated);
         EoDSummary.setEodWasteUpdated(QtblEodSummaryselect.EodWasteUpdated);
         EoDSummary.setEodTransferUpdated(QtblEodSummaryselect.EodTransferUpdated);
         EoDSummary.setEodMiscUpdated(QtblEodSummaryselect.EodMiscUpdated);
         EoDSummary.setEodStocktakeEnteredNotUpdated(QtblEodSummaryselect.EodStocktakeEnteredNotUpdated);
         EoDSummary.setEodStocktakeUpdated(QtblEodSummaryselect.EodStocktakeUpdated);
         EoDSummary.setDateEntered(QtblEodSummaryselect.DateEntered);
         EoDSummary.setEod_EndOfDayFinished(QtblEodSummaryselect.Eod_EndOfDayFinished);
         EoDSummary.setStartingStockValEx(QtblEodSummaryselect.StartingStockValEx);
         EoDSummary.setEndingStockValEx(QtblEodSummaryselect.EndingStockValEx);
         EoDSummary.setStockVarianceValEx(QtblEodSummaryselect.StockVarianceValEx);
         EoDSummary.setPurchaseValEx(QtblEodSummaryselect.PurchaseValEx);
         EoDSummary.setWastageValEx(QtblEodSummaryselect.WastageValEx);
         
		</cfscript>
	</cfif>
	<cfreturn EoDSummary />
</cffunction>
		
<cffunction name="recordexists" access="public" returntype="EoDSummary" output="no" hint="Checks if a record already exists in the database">
	<cfargument name="argsEoDSummary" type="EoDSummary" required="true" />
	<cfset var EoDSummary  =  arguments.argsEoDSummary />
  	<cfset var EoDSummary  =  arguments.argsEoDSummary />
    <cfset var StoreID = trim(EoDSummary.getStoreID())  />
    <cfset var Datestring =  EoDSummary.getDate()  />
	<cfset var qrecordexists = 0 /> 
    
    <cfquery name="qrecordexists" datasource="#variables.dsn#">
        SELECT EoDID FROM tblEodSummary 
        WHERE 
        date = <cfqueryparam value="#Datestring#" cfsqltype="cf_sql_varchar" />  AND
        StoreID = <cfqueryparam value="#StoreID#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <cfif qrecordexists.recordcount>
    	<cfset EoDSummary.setEodID(  qrecordexists.EoDID  ) />
	<cfelse>        
    	<cfset EoDSummary.setEodID(  "0"  ) />
    </cfif>
    <cfreturn EoDSummary />
</cffunction> 
       

<cffunction name="GetAllEoDSummarys" access="public" output="false" returntype="query" hint="Returns a query of all EoDSummarys in our Database">
<cfset var QgetallEoDSummarys = 0 />
	<cfquery name="QgetallEoDSummarys" datasource="#variables.dsn#">
		SELECT EodID, Date, StoreID, Eod_ECR_CSV_Updated, Eod_PLU_CSV_Updated, EodHoursWorkedUpdated, EodWasteUpdated, EodTransferUpdated, EodMiscUpdated, EodStocktakeEnteredNotUpdated, EodStocktakeUpdated, DateEntered, Eod_EndOfDayFinished, StartingStockValEx, EndingStockValEx, StockVarianceValEx, PurchaseValEx, WastageValEx
		FROM tblEodSummary 
		ORDER BY EoDID
	</cfquery>
	<cfreturn QgetallEoDSummarys />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="EoDSummary" output="false" hint="DAO method">
<cfargument name="argsEoDSummary" type="EoDSummary" required="yes" displayname="create" />
	<cfset var qEoDSummaryInsert = 0 />
	<cfset var EoDSummary = arguments.argsEoDSummary />
	
	<cfquery name="qEoDSummaryInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into tblEodSummary
		( Date, StoreID, Eod_ECR_CSV_Updated, Eod_PLU_CSV_Updated, EodHoursWorkedUpdated, EodWasteUpdated, EodTransferUpdated, EodMiscUpdated, EodStocktakeEnteredNotUpdated, EodStocktakeUpdated, DateEntered, Eod_EndOfDayFinished, StartingStockValEx, EndingStockValEx, StockVarianceValEx, PurchaseValEx, WastageValEx ) VALUES
		(

		<cfqueryparam value="#EoDSummary.getdate()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#EoDSummary.getstoreid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#EoDSummary.geteod_ecr_csv_updated()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#EoDSummary.geteod_plu_csv_updated()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#EoDSummary.geteodhoursworkedupdated()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#EoDSummary.geteodwasteupdated()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#EoDSummary.geteodtransferupdated()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#EoDSummary.geteodmiscupdated()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#EoDSummary.geteodstocktakeenterednotupdated()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#EoDSummary.geteodstocktakeupdated()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#variables.config.getAusTime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#EoDSummary.geteod_endofdayfinished()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#EoDSummary.getstartingstockvalex()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#EoDSummary.getendingstockvalex()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#EoDSummary.getstockvariancevalex()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#EoDSummary.getpurchasevalex()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#EoDSummary.getwastagevalex()#" cfsqltype="CF_SQL_FLOAT" />
		   ) 
		SELECT Ident_Current('tblEodSummary') as EoDID
		SET NOCOUNT OFF
	</cfquery>
	<cfset EoDSummary.setEoDID(qEoDSummaryInsert.EoDID)>

	<cfreturn EoDSummary />
</cffunction>

<cffunction name="update" access="private" returntype="EoDSummary" output="false" hint="DAO method">
<cfargument name="argsEoDSummary" type="EoDSummary" required="yes" />
	<cfset var EoDSummary = arguments.argsEoDSummary />
	<cfset var EoDSummaryUpdate = 0 >
	<cfquery name="EoDSummaryUpdate" datasource="#variables.dsn#" >
		UPDATE tblEodSummary SET
date  = <cfqueryparam value="#EoDSummary.getDate()#" cfsqltype="CF_SQL_VARCHAR"/>,
storeid  = <cfqueryparam value="#EoDSummary.getStoreID()#" cfsqltype="CF_SQL_INTEGER"/>,
eod_ecr_csv_updated  = <cfqueryparam value="#EoDSummary.getEod_ECR_CSV_Updated()#" cfsqltype="CF_SQL_BIT"/>,
eod_plu_csv_updated  = <cfqueryparam value="#EoDSummary.getEod_PLU_CSV_Updated()#" cfsqltype="CF_SQL_BIT"/>,
eodhoursworkedupdated  = <cfqueryparam value="#EoDSummary.getEodHoursWorkedUpdated()#" cfsqltype="CF_SQL_BIT"/>,
eodwasteupdated  = <cfqueryparam value="#EoDSummary.getEodWasteUpdated()#" cfsqltype="CF_SQL_BIT"/>,
eodtransferupdated  = <cfqueryparam value="#EoDSummary.getEodTransferUpdated()#" cfsqltype="CF_SQL_BIT"/>,
eodmiscupdated  = <cfqueryparam value="#EoDSummary.getEodMiscUpdated()#" cfsqltype="CF_SQL_BIT"/>,
eodstocktakeenterednotupdated  = <cfqueryparam value="#EoDSummary.getEodStocktakeEnteredNotUpdated()#" cfsqltype="CF_SQL_BIT"/>,
eodstocktakeupdated  = <cfqueryparam value="#EoDSummary.getEodStocktakeUpdated()#" cfsqltype="CF_SQL_BIT"/>,
dateentered  = <cfqueryparam value="#variables.config.getAusTime()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
eod_endofdayfinished  = <cfqueryparam value="#EoDSummary.getEod_EndOfDayFinished()#" cfsqltype="CF_SQL_BIT"/>,
startingstockvalex  = <cfqueryparam value="#EoDSummary.getStartingStockValEx()#" cfsqltype="CF_SQL_FLOAT"/>,
endingstockvalex  = <cfqueryparam value="#EoDSummary.getEndingStockValEx()#" cfsqltype="CF_SQL_FLOAT"/>,
stockvariancevalex  = <cfqueryparam value="#EoDSummary.getStockVarianceValEx()#" cfsqltype="CF_SQL_FLOAT"/>,
purchasevalex  = <cfqueryparam value="#EoDSummary.getPurchaseValEx()#" cfsqltype="CF_SQL_FLOAT"/>,
wastagevalex  = <cfqueryparam value="#EoDSummary.getWastageValEx()#" cfsqltype="CF_SQL_FLOAT"/>
						
		WHERE 
		EoDID = <cfqueryparam value="#EoDSummary.getEoDID()#"   cfsqltype="CF_SQL_VARCHAR" />
	</cfquery>
	
	<cfreturn EoDSummary />
</cffunction>

</cfcomponent>