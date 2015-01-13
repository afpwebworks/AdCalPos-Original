<cfcomponent displayname="tblStore_PLUTotals DAO" output="false" hint="DAO Component Handles all Database access for the table tblStore_PLUTotals.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    StorePLUTotalsDAO.cfc
Description: DAO Component Handles all Database access for the table tblStore_PLUTotals.  Requires Coldspring v1.0
Date:        12/May/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( PLUTotal.getid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="StorePLUTotalsDAO" output="false" hint="Initialises the controller">
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


<cffunction name="save" access="public" returntype="PLUTotal" output="false" hint="DAO method">
<cfargument name="PLUTotal" type="PLUTotal" required="yes" />
<!-----[  If a ID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfset checkRecordExists( arguments.PLUTotal  ) />

<cfif (arguments.PLUTotal.getID() neq "0")>	
		<cfset PLUTotal = update(arguments.PLUTotal)/>
	<cfelse>
		<cfset PLUTotal = create(arguments.PLUTotal)/>
	</cfif>
	<cfreturn PLUTotal />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PLUTotal" type="PLUTotal" required="true" /> 
	<cfset var qPLUTotalDelete = 0 >
<cfquery name="PLUTotalDelete" datasource="#variables.dsn#" >
		DELETE FROM tblStore_PLUTotals
		WHERE 
		ID = <cfqueryparam value="#PLUTotal.getID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	
</cffunction>



<cffunction name="read" access="public" returntype="PLUTotal" output="false" hint="DAO Method. - Reads a PLUTotal into the bean">
<cfargument name="argsPLUTotal" type="PLUTotal" required="true" />
	<cfset var PLUTotal  =  arguments.argsPLUTotal />
	<cfset var QtblStore_PLUTotalsselect = "" />
	<cfquery name="QtblStore_PLUTotalsselect" datasource="#variables.dsn#">
		SELECT 
		ID, StoreID, FileName, DateEntered, TimeEntered, Date, Time, Location, ScaleIDCode, PLUNumber, TotalD, Quantity, TotalKg, PrePackTotalD, PrePackQuantity, PrePackTotalkg, Posted, COGS
		FROM tblStore_PLUTotals 
		WHERE 
		ID = <cfqueryparam value="#PLUTotal.getID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QtblStore_PLUTotalsselect.recordCount >
		<cfscript>
		PLUTotal.setID(QtblStore_PLUTotalsselect.ID);
         PLUTotal.setStoreID(QtblStore_PLUTotalsselect.StoreID);
         PLUTotal.setFileName(QtblStore_PLUTotalsselect.FileName);
         PLUTotal.setDateEntered(QtblStore_PLUTotalsselect.DateEntered);
         PLUTotal.setTimeEntered(QtblStore_PLUTotalsselect.TimeEntered);
         PLUTotal.setDate(QtblStore_PLUTotalsselect.Date);
         PLUTotal.setTime(QtblStore_PLUTotalsselect.Time);
         PLUTotal.setLocation(QtblStore_PLUTotalsselect.Location);
         PLUTotal.setScaleIDCode(QtblStore_PLUTotalsselect.ScaleIDCode);
         PLUTotal.setPLUNumber(QtblStore_PLUTotalsselect.PLUNumber);
         PLUTotal.setTotalD(QtblStore_PLUTotalsselect.TotalD);
         PLUTotal.setQuantity(QtblStore_PLUTotalsselect.Quantity);
         PLUTotal.setTotalKg(QtblStore_PLUTotalsselect.TotalKg);
         PLUTotal.setPrePackTotalD(QtblStore_PLUTotalsselect.PrePackTotalD);
         PLUTotal.setPrePackQuantity(QtblStore_PLUTotalsselect.PrePackQuantity);
         PLUTotal.setPrePackTotalkg(QtblStore_PLUTotalsselect.PrePackTotalkg);
         PLUTotal.setPosted(QtblStore_PLUTotalsselect.Posted);
         PLUTotal.setCOGS(QtblStore_PLUTotalsselect.COGS);
         
		</cfscript>
	</cfif>
	<cfreturn PLUTotal />
</cffunction>
		
        
<cffunction name="checkRecordExists" access="public" output="no" returntype="PLUTotal" hint="Determines if a record is already existing in the database for that store/day">
<cfargument name="argsPLUTotal" type="PLUTotal" required="yes"  />
	<cfset var PLUTotal = arguments.argsPLUTotal />
	<cfset var qPLUTotal = 0 />
    <cfset var result = false />
    <cfquery name="qPLUTotal" datasource="#variables.dsn#">
	    SELECT ID from tblStore_PLUTotals WHERE 
    	StoreID = <cfqueryparam value="#PLUTotal.getStoreID()#" cfsqltype="cf_sql_integer" /> AND
        PLUNumber = <cfqueryparam value="#PLUTotal.getPLUNumber()#" cfsqltype="cf_sql_integer" /> AND
        Date = <cfqueryparam value="#PLUTotal.getDate()#" cfsqltype="cf_sql_timestamp" />
    </cfquery>
       
    <cfif qPLUTotal.recordcount >
    	<cfset result = true />
        <cfset PLUTotal.setID(  qPLUTotal.ID ) />
   </cfif>	
    <cfreturn PLUTotal />
</cffunction>


<cffunction name="GetAllPLUTotals" access="public" output="false" returntype="query" hint="Returns a query of all PLUTotals in our Database">
<cfset var QgetallPLUTotals = 0 />
	<cfquery name="QgetallPLUTotals" datasource="#variables.dsn#">
		SELECT ID, StoreID, FileName, DateEntered, TimeEntered, Date, Time, Location, ScaleIDCode, PLUNumber, TotalD, Quantity, TotalKg, PrePackTotalD, PrePackQuantity, PrePackTotalkg, Posted, COGS
		FROM tblStore_PLUTotals 
		ORDER BY ID
	</cfquery>
	<cfreturn QgetallPLUTotals />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="PLUTotal" output="false" hint="DAO method">
<cfargument name="argsPLUTotal" type="PLUTotal" required="yes" displayname="create" />
	<cfset var qPLUTotalInsert = 0 />
	<cfset var PLUTotal = arguments.argsPLUTotal />

<!---[     Create the correct format date for insert into the database   ]---->
    <!---[   <cfset CreateTransDate( PLUTotal ) />   ]---->
    
    
	<cfquery name="qPLUTotalInsert" datasource="#variables.dsn#" result="Result">
        SET NOCOUNT ON
  		INSERT into tblStore_PLUTotals
		( StoreID, FileName, DateEntered, TimeEntered, Date, Time, Location, ScaleIDCode, PLUNumber, TotalD, Quantity, TotalKg, PrePackTotalD, PrePackQuantity, PrePackTotalkg, Posted, COGS ) VALUES
		(

		<cfqueryparam value="#PLUTotal.getstoreid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PLUTotal.getfilename()#" cfsqltype="CF_SQL_VARCHAR" />,
        <cfqueryparam value="#variables.config.getAusTime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
        <cfqueryparam value="#PLUTotal.gettimeentered()#" cfsqltype="CF_SQL_VARCHAR" />,
        <cfqueryparam value="#PLUTotal.getdate()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#PLUTotal.gettime()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PLUTotal.getlocation()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PLUTotal.getscaleidcode()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PLUTotal.getplunumber()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PLUTotal.gettotald()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PLUTotal.getquantity()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PLUTotal.gettotalkg()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PLUTotal.getprepacktotald()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PLUTotal.getprepackquantity()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PLUTotal.getprepacktotalkg()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PLUTotal.getposted()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PLUTotal.getcogs()#" cfsqltype="CF_SQL_FLOAT" />
		   ) 
		SELECT Ident_Current('tblStore_PLUTotals') as ID
		SET NOCOUNT OFF
	</cfquery>
	<cfset PLUTotal.setID(qPLUTotalInsert.ID)>
	<cfreturn PLUTotal />
</cffunction>

<cffunction name="update" access="private" returntype="PLUTotal" output="false" hint="DAO method">
<cfargument name="argsPLUTotal" type="PLUTotal" required="yes" />
	<cfset var PLUTotal = arguments.argsPLUTotal />
	<cfset var PLUTotalUpdate = 0 >
  <!---[     Create the correct format date for insert into the database   ]---->
    <!---[   <cfset CreateTransDate( PLUTotal ) />   ]---->
    
	<cfquery name="PLUTotalUpdate" datasource="#variables.dsn#" >
    	UPDATE tblStore_PLUTotals SET
storeid  = <cfqueryparam value="#PLUTotal.getStoreID()#" cfsqltype="CF_SQL_INTEGER"/>,
filename  = <cfqueryparam value="#PLUTotal.getFileName()#" cfsqltype="CF_SQL_VARCHAR"/>,
dateentered  = <cfqueryparam value="#variables.config.getAusTime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
timeentered  = <cfqueryparam value="#PLUTotal.getTimeEntered()#" cfsqltype="CF_SQL_VARCHAR"/>,
date  = <cfqueryparam value="#PLUTotal.getdate()#" cfsqltype="CF_SQL_TIMESTAMP" />,
time  = <cfqueryparam value="#PLUTotal.getTime()#" cfsqltype="CF_SQL_VARCHAR"/>,
location  = <cfqueryparam value="#PLUTotal.getLocation()#" cfsqltype="CF_SQL_INTEGER"/>,
scaleidcode  = <cfqueryparam value="#PLUTotal.getScaleIDCode()#" cfsqltype="CF_SQL_INTEGER"/>,
plunumber  = <cfqueryparam value="#PLUTotal.getPLUNumber()#" cfsqltype="CF_SQL_INTEGER"/>,
totald  = totald + <cfqueryparam value="#PLUTotal.getTotalD()#" cfsqltype="CF_SQL_FLOAT"/>,
quantity  = quantity + <cfqueryparam value="#PLUTotal.getQuantity()#" cfsqltype="CF_SQL_FLOAT"/>,
totalkg  = totalkg + <cfqueryparam value="#PLUTotal.getTotalKg()#" cfsqltype="CF_SQL_FLOAT"/>,
prepacktotald  = prepacktotald + <cfqueryparam value="#PLUTotal.getPrePackTotalD()#" cfsqltype="CF_SQL_FLOAT"/>,
prepackquantity  = prepackquantity +  <cfqueryparam value="#PLUTotal.getPrePackQuantity()#" cfsqltype="CF_SQL_FLOAT"/>,
prepacktotalkg  = prepacktotalkg +  <cfqueryparam value="#PLUTotal.getPrePackTotalkg()#" cfsqltype="CF_SQL_FLOAT"/>,
posted  = <cfqueryparam value="#PLUTotal.getPosted()#" cfsqltype="CF_SQL_BIT"/>,
cogs  = cogs + <cfqueryparam value="#PLUTotal.getCOGS()#" cfsqltype="CF_SQL_FLOAT"/>
						
		WHERE 
		ID = <cfqueryparam value="#PLUTotal.getID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	
	<cfreturn PLUTotal />
</cffunction>


<cffunction name="CreateTransDate" access="public" output="no" returntype="PLUTotal" hint="Calculates the value of TransDate, from the current value of TimeStamp">
<cfargument name="argsPLUTotal" type="PLUTotal" required="yes" />
	<cfset var PLUTotal = arguments.argsPLUTotal />
    <cfset var TransDate = 0 />
    
    <cfscript>
	TransDate =  PLUTotal.getDate();
	//TransYear = datepart("yyyy", TransDate );
	//TransMonth = datepart("m", TransDate);
	//TransDay = datepart("d", TransDate );
	TransDay = listfirst(TransDate, "/");
	TransMonth = ListGetAt(Transdate, "2", "/");
	TransYear = listlast(TransDate, "/");
	NewTransDate = createdatetime( TransYear, TransMonth, TransDay,  "0", "0", "0");
	PLUTotal.setDate( NewTransDate );	
	</cfscript>  
    
	<cfreturn PLUTotal />
</cffunction>

</cfcomponent>
