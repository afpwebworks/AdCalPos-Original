<cfcomponent displayname="tblStore_ECRTotals DAO" output="false" hint="DAO Component Handles all Database access for the table tblStore_ECRTotals.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    StoreECRTTotalsDAO.cfc
Description: DAO Component Handles all Database access for the table tblStore_ECRTotals.  Requires Coldspring v1.0
Date:        12/May/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( ECRTTotal.getid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="StoreECRTTotalsDAO" output="false" hint="Initialises the controller">
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


<cffunction name="save" access="public" returntype="ECRTTotal" output="false" hint="DAO method">
<cfargument name="ECRTTotal" type="ECRTTotal" required="yes" />
<!-----[  If a ID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<!---[     ]---->
    <cfset checkRecordExists( arguments.ECRTTotal   )>	

    <cfif (arguments.ECRTTotal.getID() neq "0")> 
		<cfset ECRTTotal = update(arguments.ECRTTotal)/>
	<cfelse>
		<cfset ECRTTotal = create(arguments.ECRTTotal)/>
	</cfif>
	<cfreturn ECRTTotal />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="ECRTTotal" type="ECRTTotal" required="true" /> 
	<cfset var qECRTTotalDelete = 0 >
<cfquery name="ECRTTotalDelete" datasource="#variables.dsn#" >
		DELETE FROM tblStore_ECRTotals
		WHERE 
		ID = <cfqueryparam value="#ECRTTotal.getID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
</cffunction>


<cffunction name="read" access="public" returntype="ECRTTotal" output="false" hint="DAO Method. - Reads a ECRTTotal into the bean">
<cfargument name="argsECRTTotal" type="ECRTTotal" required="true" />
	<cfset var ECRTTotal  =  arguments.argsECRTTotal />
	<cfset var QtblStore_ECRTotalsselect = "" />
    
    <!---[   Verify the record already exists, and if so, set the ID   ]---->
    <cfset checkRecordExists( ECRTTotal   )>	
    
	<!---[   If there is a valid id for this record,  read all the values in, 
	otherwise return the object as is, with all the defaults.   ]---->
    <cfif (ECRTTotal.getID() neq "0")>
	<cfquery name="QtblStore_ECRTotalsselect" datasource="#variables.dsn#">
		SELECT 
		ID, StoreID, FileName, DateEntered, TimeEntered, Date, Time, Location, ScaleIDCode, RoundingsD, Discounts, DiscountD, CashSales, CashSalesD, CreditSales, CreditSalesD, EFTCashOut, EFTCashOutD, CashRefunds, CashRefundD, CreditRefunds, CreditRefundD, CashSalesGSTincD, CashSaleGSTfreeD, CreditSalesGSTincD, CreditSalesGSTfreeD, GSTCashSaleD, GSTCreditSaleD, CashIn, CashInD, CashOut, CashOutD, Cancellations, CancellationD, Sales, Posted
		FROM tblStore_ECRTotals 
		WHERE 
		ID = <cfqueryparam value="#ECRTTotal.getID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QtblStore_ECRTotalsselect.recordCount >
		<cfscript>
		 ECRTTotal.setID(QtblStore_ECRTotalsselect.ID);
         ECRTTotal.setStoreID(QtblStore_ECRTotalsselect.StoreID);
         ECRTTotal.setFileName(QtblStore_ECRTotalsselect.FileName);
         ECRTTotal.setDateEntered(QtblStore_ECRTotalsselect.DateEntered);
         ECRTTotal.setTimeEntered(QtblStore_ECRTotalsselect.TimeEntered);
         ECRTTotal.setDate(QtblStore_ECRTotalsselect.Date);
         ECRTTotal.setTime(QtblStore_ECRTotalsselect.Time);
         ECRTTotal.setLocation(QtblStore_ECRTotalsselect.Location);
         ECRTTotal.setScaleIDCode(QtblStore_ECRTotalsselect.ScaleIDCode);
         ECRTTotal.setRoundingsD(QtblStore_ECRTotalsselect.RoundingsD);
         ECRTTotal.setDiscounts(QtblStore_ECRTotalsselect.Discounts);
         ECRTTotal.setDiscountD(QtblStore_ECRTotalsselect.DiscountD);
         ECRTTotal.setCashSales(QtblStore_ECRTotalsselect.CashSales);
         ECRTTotal.setCashSalesD(QtblStore_ECRTotalsselect.CashSalesD);
         ECRTTotal.setCreditSales(QtblStore_ECRTotalsselect.CreditSales);
         ECRTTotal.setCreditSalesD(QtblStore_ECRTotalsselect.CreditSalesD);
         ECRTTotal.setEFTCashOut(QtblStore_ECRTotalsselect.EFTCashOut);
         ECRTTotal.setEFTCashOutD(QtblStore_ECRTotalsselect.EFTCashOutD);
         ECRTTotal.setCashRefunds(QtblStore_ECRTotalsselect.CashRefunds);
         ECRTTotal.setCashRefundD(QtblStore_ECRTotalsselect.CashRefundD);
         ECRTTotal.setCreditRefunds(QtblStore_ECRTotalsselect.CreditRefunds);
         ECRTTotal.setCreditRefundD(QtblStore_ECRTotalsselect.CreditRefundD);
         ECRTTotal.setCashSalesGSTincD(QtblStore_ECRTotalsselect.CashSalesGSTincD);
         ECRTTotal.setCashSaleGSTfreeD(QtblStore_ECRTotalsselect.CashSaleGSTfreeD);
         ECRTTotal.setCreditSalesGSTincD(QtblStore_ECRTotalsselect.CreditSalesGSTincD);
         ECRTTotal.setCreditSalesGSTfreeD(QtblStore_ECRTotalsselect.CreditSalesGSTfreeD);
         ECRTTotal.setGSTCashSaleD(QtblStore_ECRTotalsselect.GSTCashSaleD);
         ECRTTotal.setGSTCreditSaleD(QtblStore_ECRTotalsselect.GSTCreditSaleD);
         ECRTTotal.setCashIn(QtblStore_ECRTotalsselect.CashIn);
         ECRTTotal.setCashInD(QtblStore_ECRTotalsselect.CashInD);
         ECRTTotal.setCashOut(QtblStore_ECRTotalsselect.CashOut);
         ECRTTotal.setCashOutD(QtblStore_ECRTotalsselect.CashOutD);
         ECRTTotal.setCancellations(QtblStore_ECRTotalsselect.Cancellations);
         ECRTTotal.setCancellationD(QtblStore_ECRTotalsselect.CancellationD);
         ECRTTotal.setSales(QtblStore_ECRTotalsselect.Sales);
         ECRTTotal.setPosted(QtblStore_ECRTotalsselect.Posted);
         
		</cfscript>
	</cfif>
    </cfif>
	<cfreturn ECRTTotal />
</cffunction>
		

<cffunction name="GetAllECRTTotals" access="public" output="false" returntype="query" hint="Returns a query of all ECRTTotals in our Database">
<cfset var QgetallECRTTotals = 0 />
	<cfquery name="QgetallECRTTotals" datasource="#variables.dsn#">
		SELECT ID, StoreID, FileName, DateEntered, TimeEntered, Date, Time, Location, ScaleIDCode, RoundingsD, Discounts, DiscountD, CashSales, CashSalesD, CreditSales, CreditSalesD, EFTCashOut, EFTCashOutD, CashRefunds, CashRefundD, CreditRefunds, CreditRefundD, CashSalesGSTincD, CashSaleGSTfreeD, CreditSalesGSTincD, CreditSalesGSTfreeD, GSTCashSaleD, GSTCreditSaleD, CashIn, CashInD, CashOut, CashOutD, Cancellations, CancellationD, Sales, Posted
		FROM tblStore_ECRTotals 
		ORDER BY ID
	</cfquery>
	<cfreturn QgetallECRTTotals />
</cffunction>


<cffunction name="checkRecordExists" access="public" output="no" returntype="ECRTTotal" hint="Determines if a record is already existing in the database for that store/day">
<cfargument name="argsECRTTotal" type="ECRTTotal" required="yes"/>
	<cfset var ECRTTotal = arguments.argsECRTTotal />
	<cfset var qECRTTotal = 0 />
    <cfset var result = false />
    
    <cfquery name="qECRTTotal" datasource="#variables.dsn#">
	    SELECT ID from tblStore_ECRTotals WHERE 
    	StoreID = <cfqueryparam value="#ECRTTotal.getStoreID()#" cfsqltype="cf_sql_integer" /> AND
        Date = <cfqueryparam value="#ECRTTotal.getDate()#" cfsqltype="cf_sql_date" />
    </cfquery>
       
    <cfif qECRTTotal.recordcount >
    	<cfset result = true />
        <cfset ECRTTotal.setID(  qECRTTotal.ID ) />
   </cfif>	
    <cfreturn ECRTTotal />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="ECRTTotal" output="false" hint="DAO method">
<cfargument name="argsECRTTotal" type="ECRTTotal" required="yes" displayname="create" />
	<cfset var qECRTTotalInsert = 0 />
	<cfset var ECRTTotal = arguments.argsECRTTotal />
	
	<cfquery name="qECRTTotalInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
        set language british
		INSERT into tblStore_ECRTotals
		( StoreID, FileName, DateEntered, TimeEntered, Date, Time, Location, ScaleIDCode, RoundingsD, Discounts, DiscountD, CashSales, CashSalesD, CreditSales, CreditSalesD, EFTCashOut, EFTCashOutD, CashRefunds, CashRefundD, CreditRefunds, CreditRefundD, CashSalesGSTincD, CashSaleGSTfreeD, CreditSalesGSTincD, CreditSalesGSTfreeD, GSTCashSaleD, GSTCreditSaleD, CashIn, CashInD, CashOut, CashOutD, Cancellations, CancellationD, Sales, Posted ) VALUES
		(

		<cfqueryparam value="#ECRTTotal.getstoreid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getfilename()#" cfsqltype="CF_SQL_VARCHAR" />,
		#createodbcdate(ECRTTotal.getdateentered())#,
		<cfqueryparam value="#ECRTTotal.gettimeentered()#" cfsqltype="CF_SQL_VARCHAR" />,
		#createodbcdate(ECRTTotal.getdate() )#,
		<cfqueryparam value="#ECRTTotal.gettime()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#ECRTTotal.getlocation()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getscaleidcode()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getroundingsd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getdiscounts()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getdiscountd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getcashsales()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getcashsalesd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getcreditsales()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getcreditsalesd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.geteftcashout()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.geteftcashoutd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getcashrefunds()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getcashrefundd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getcreditrefunds()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getcreditrefundd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getcashsalesgstincd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getcashsalegstfreed()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getcreditsalesgstincd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getcreditsalesgstfreed()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getgstcashsaled()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getgstcreditsaled()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getcashin()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getcashind()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getcashout()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getcashoutd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getcancellations()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getcancellationd()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#ECRTTotal.getsales()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#ECRTTotal.getposted()#" cfsqltype="CF_SQL_BIT" />
		   ) 
		SELECT Ident_Current('tblStore_ECRTotals') as ID
		SET NOCOUNT OFF
	</cfquery>
	<cfset ECRTTotal.setID(qECRTTotalInsert.ID)>

	<cfreturn ECRTTotal />
</cffunction>

<cffunction name="update" access="private" returntype="ECRTTotal" output="false" hint="DAO method">
<cfargument name="argsECRTTotal" type="ECRTTotal" required="yes" />
	<cfset var ECRTTotal = arguments.argsECRTTotal />
	<cfset var ECRTTotalUpdate = 0 >
	<cfquery name="ECRTTotalUpdate" datasource="#variables.dsn#" >
    	UPDATE tblStore_ECRTotals SET
            storeid  =    <cfqueryparam value="#ECRTTotal.getStoreID()#" cfsqltype="CF_SQL_INTEGER"/>,
            filename  =    <cfqueryparam value="#ECRTTotal.getFileName()#" cfsqltype="CF_SQL_VARCHAR"/>,
            dateentered  = #createodbcdate(ECRTTotal.getdateentered())#,
            timeentered  =  <cfqueryparam value="#ECRTTotal.getTimeEntered()#" cfsqltype="CF_SQL_VARCHAR"/>,
            date  =  #createodbcdate(ECRTTotal.getDate())#,
            time  =  <cfqueryparam value="#ECRTTotal.getTime()#" cfsqltype="CF_SQL_VARCHAR"/>,
            location  =  <cfqueryparam value="#ECRTTotal.getLocation()#" cfsqltype="CF_SQL_INTEGER"/>,
            scaleidcode  =   <cfqueryparam value="#ECRTTotal.getScaleIDCode()#" cfsqltype="CF_SQL_INTEGER"/>,
            roundingsd  =  roundingsd + <cfqueryparam value="#ECRTTotal.getRoundingsD()#" cfsqltype="CF_SQL_FLOAT"/>,
            discounts  =    discounts + <cfqueryparam value="#ECRTTotal.getDiscounts()#" cfsqltype="CF_SQL_INTEGER"/>,
            discountd  =   discountd + <cfqueryparam value="#ECRTTotal.getDiscountD()#" cfsqltype="CF_SQL_FLOAT"/>,
            cashsales  =   cashsales + <cfqueryparam value="#ECRTTotal.getCashSales()#" cfsqltype="CF_SQL_INTEGER"/>,
            cashsalesd  =   cashsalesd + <cfqueryparam value="#ECRTTotal.getCashSalesD()#" cfsqltype="CF_SQL_FLOAT"/>,
            creditsales  = creditsales + <cfqueryparam value="#ECRTTotal.getCreditSales()#" cfsqltype="CF_SQL_INTEGER"/>,
            creditsalesd  =   creditsalesd + <cfqueryparam value="#ECRTTotal.getCreditSalesD()#" cfsqltype="CF_SQL_FLOAT"/>,
            eftcashout  =  eftcashout + <cfqueryparam value="#ECRTTotal.getEFTCashOut()#" cfsqltype="CF_SQL_INTEGER"/>,
            eftcashoutd  =  eftcashoutd + <cfqueryparam value="#ECRTTotal.getEFTCashOutD()#" cfsqltype="CF_SQL_FLOAT"/>,
            cashrefunds  =   cashrefunds + <cfqueryparam value="#ECRTTotal.getCashRefunds()#" cfsqltype="CF_SQL_INTEGER"/>,
            cashrefundd  =   cashrefundd + <cfqueryparam value="#ECRTTotal.getCashRefundD()#" cfsqltype="CF_SQL_FLOAT"/>,
            creditrefunds  =  creditrefunds + <cfqueryparam value="#ECRTTotal.getCreditRefunds()#" cfsqltype="CF_SQL_INTEGER"/>,
            creditrefundd  =  creditrefundd + <cfqueryparam value="#ECRTTotal.getCreditRefundD()#" cfsqltype="CF_SQL_FLOAT"/>,
            cashsalesgstincd  =  cashsalesgstincd + <cfqueryparam value="#ECRTTotal.getCashSalesGSTincD()#" cfsqltype="CF_SQL_FLOAT"/>,
            cashsalegstfreed  =  cashsalegstfreed + <cfqueryparam value="#ECRTTotal.getCashSaleGSTfreeD()#" cfsqltype="CF_SQL_FLOAT"/>,
            creditsalesgstincd  = creditsalesgstincd + <cfqueryparam value="#ECRTTotal.getCreditSalesGSTincD()#" cfsqltype="CF_SQL_FLOAT"/>,
            creditsalesgstfreed  = creditsalesgstfreed + <cfqueryparam value="#ECRTTotal.getCreditSalesGSTfreeD()#" cfsqltype="CF_SQL_FLOAT"/>,
            gstcashsaled  =  gstcashsaled + <cfqueryparam value="#ECRTTotal.getGSTCashSaleD()#" cfsqltype="CF_SQL_FLOAT"/>,
            gstcreditsaled  = gstcreditsaled + <cfqueryparam value="#ECRTTotal.getGSTCreditSaleD()#" cfsqltype="CF_SQL_FLOAT"/>,
            cashin  =  cashin + <cfqueryparam value="#ECRTTotal.getCashIn()#" cfsqltype="CF_SQL_INTEGER"/>,
            cashind  = cashind + <cfqueryparam value="#ECRTTotal.getCashInD()#" cfsqltype="CF_SQL_INTEGER"/>,
            cashout  =  cashout + <cfqueryparam value="#ECRTTotal.getCashOut()#" cfsqltype="CF_SQL_INTEGER"/>,
            cashoutd  =  cashoutd + <cfqueryparam value="#ECRTTotal.getCashOutD()#" cfsqltype="CF_SQL_FLOAT"/>,
            cancellations  = cancellations + <cfqueryparam value="#ECRTTotal.getCancellations()#" cfsqltype="CF_SQL_INTEGER"/>,
            cancellationd  = cancellationd + <cfqueryparam value="#ECRTTotal.getCancellationD()#" cfsqltype="CF_SQL_FLOAT"/>,
            sales  =  sales + <cfqueryparam value="#ECRTTotal.getSales()#" cfsqltype="CF_SQL_INTEGER"/>,
            posted  =  <cfqueryparam value="#ECRTTotal.getPosted()#" cfsqltype="CF_SQL_BIT"/>
						
		WHERE 
		ID = <cfqueryparam value="#ECRTTotal.getID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	
	<cfreturn ECRTTotal />
</cffunction>

</cfcomponent>