<cfcomponent displayname="Pos DAO" output="false" hint="DAO Component Handles all Database access for the table Pos.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    PosDAO.cfc
Description: DAO Component Handles all Database access for the table Pos.  Requires Coldspring v1.0
Date:        4/Apr/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( PosBean.getpostxid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="PosDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="save" access="public" returntype="PosBean" output="false" hint="DAO method">
<cfargument name="PosBean" type="PosBean" required="yes" />
<!-----[  If a PosTXID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.PosBean.getPosTXID() neq "0")>	
		<cfset PosBean = update(arguments.PosBean)/>
	<cfelse>
		<cfset PosBean = create(arguments.PosBean)/>
	</cfif>
	<cfreturn PosBean />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PosBean" type="PosBean" required="true" /> 
	<cfset var qPosBeanDelete = 0 >
<cfquery name="PosBeanDelete" datasource="#variables.dsn#" >
		DELETE FROM Pos
		WHERE 
		PosTXID = <cfqueryparam value="#PosBean.getPosTXID()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
	
</cffunction>



<cffunction name="read" access="public" returntype="PosBean" output="false" hint="DAO Method. - Reads a PosBean into the bean">
<cfargument name="argsPosBean" type="PosBean" required="true" />
	<cfset var PosBean  =  arguments.argsPosBean />
	<cfset var QPosselect = "" />
	<cfquery name="QPosselect" datasource="#variables.dsn#">
		SELECT 
		PosTXID, PosID, PosType, PosStatus, PosCode, StoreID, TerminalID, LocationID, TableID, PriceID, ClerkID, DrawerID, MemberID, MemberName, DebtorID, DebtorName, CoverQuantity, SeatCount, WalletCount, CostTotal, DiscountTotal, LineTaxTotal, LineSaleTotal, MediaTaxTotal, MediaRoundTotal, MediaChangeTotal, MediaTotal, DueTotal, TaxTotal, SaleTotal, VoidTotal, Timestamp, TransDate, ItemDiscountTotal, ItemSurchargeTotal, SubTotalDiscount, SubTotalDiscountID, SubTotalDiscountDescription, SubTotalDiscountRate, SubTotalDiscountEntryType, SubTotalSurcharge, SubTotalSurchargeID, SubTotalSurchargeDescription, SubTotalSurchargeRate, SubTotalSurchargeEntryType, Tips
		FROM Pos 
		WHERE 
		PosTXID = <cfqueryparam value="#PosBean.getPosTXID()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
	<cfif QPosselect.recordCount >
		<cfscript>
		PosBean.setPosTXID(QPosselect.PosTXID);
         PosBean.setPosID(QPosselect.PosID);
         PosBean.setPosType(QPosselect.PosType);
         PosBean.setPosStatus(QPosselect.PosStatus);
         PosBean.setPosCode(QPosselect.PosCode);
         PosBean.setStoreID(QPosselect.StoreID);
         PosBean.setTerminalID(QPosselect.TerminalID);
         PosBean.setLocationID(QPosselect.LocationID);
         PosBean.setTableID(QPosselect.TableID);
         PosBean.setPriceID(QPosselect.PriceID);
         PosBean.setClerkID(QPosselect.ClerkID);
         PosBean.setDrawerID(QPosselect.DrawerID);
         PosBean.setMemberID(QPosselect.MemberID);
         PosBean.setMemberName(QPosselect.MemberName);
         PosBean.setDebtorID(QPosselect.DebtorID);
         PosBean.setDebtorName(QPosselect.DebtorName);
         PosBean.setCoverQuantity(QPosselect.CoverQuantity);
         PosBean.setSeatCount(QPosselect.SeatCount);
         PosBean.setWalletCount(QPosselect.WalletCount);
         PosBean.setCostTotal(QPosselect.CostTotal);
         PosBean.setDiscountTotal(QPosselect.DiscountTotal);
         PosBean.setLineTaxTotal(QPosselect.LineTaxTotal);
         PosBean.setLineSaleTotal(QPosselect.LineSaleTotal);
         PosBean.setMediaTaxTotal(QPosselect.MediaTaxTotal);
         PosBean.setMediaRoundTotal(QPosselect.MediaRoundTotal);
         PosBean.setMediaChangeTotal(QPosselect.MediaChangeTotal);
         PosBean.setMediaTotal(QPosselect.MediaTotal);
         PosBean.setDueTotal(QPosselect.DueTotal);
         PosBean.setTaxTotal(QPosselect.TaxTotal);
         PosBean.setSaleTotal(QPosselect.SaleTotal);
         PosBean.setVoidTotal(QPosselect.VoidTotal);
         PosBean.setTimestamp(QPosselect.Timestamp);
		 PosBean.setTransDate(QPosselect.TransDate);
         PosBean.setItemDiscountTotal(QPosselect.ItemDiscountTotal);
         PosBean.setItemSurchargeTotal(QPosselect.ItemSurchargeTotal);
         PosBean.setSubTotalDiscount(QPosselect.SubTotalDiscount);
         PosBean.setSubTotalDiscountID(QPosselect.SubTotalDiscountID);
         PosBean.setSubTotalDiscountDescription(QPosselect.SubTotalDiscountDescription);
         PosBean.setSubTotalDiscountRate(QPosselect.SubTotalDiscountRate);
         PosBean.setSubTotalDiscountEntryType(QPosselect.SubTotalDiscountEntryType);
         PosBean.setSubTotalSurcharge(QPosselect.SubTotalSurcharge);
         PosBean.setSubTotalSurchargeID(QPosselect.SubTotalSurchargeID);
         PosBean.setSubTotalSurchargeDescription(QPosselect.SubTotalSurchargeDescription);
         PosBean.setSubTotalSurchargeRate(QPosselect.SubTotalSurchargeRate);
         PosBean.setSubTotalSurchargeEntryType(QPosselect.SubTotalSurchargeEntryType);
         PosBean.setTips(QPosselect.Tips);
         
		</cfscript>
	</cfif>
	<cfreturn PosBean />
</cffunction>
		
        
<cffunction name="setPosStatus" access="public" output="no" returntype="void" hint="Sets the status field for a given PosTXID">
<cfargument name="argsPosTXID" required="yes" type="numeric" />
<cfargument name="argsStatusValue" required="yes" type="numeric" />
	<cfset var PosTXID = arguments.argsPosTxID />
	<cfset var StatusValue = arguments.argsStatusValue />
    
    <cfquery name="qUpdateStatus" datasource="#variables.dsn#">
    	UPDATE Pos set PosStatus = <cfqueryparam value="#StatusValue#" cfsqltype="cf_sql_integer" />
        WHERE
        PosTXID = <cfqueryparam value="#PosTXID#" cfsqltype="cf_sql_integer" />
    </cfquery>
</cffunction>


<cffunction name="GetAllPosBeans" access="public" output="false" returntype="query" hint="Returns a query of all PosBeans in our Database">
<cfset var QgetallPosBeans = 0 />
	<cfquery name="QgetallPosBeans" datasource="#variables.dsn#">
		SELECT PosTXID, PosID, PosType, PosStatus, PosCode, StoreID, TerminalID, LocationID, TableID, PriceID, ClerkID, DrawerID, MemberID, MemberName, DebtorID, DebtorName, CoverQuantity, SeatCount, WalletCount, CostTotal, DiscountTotal, LineTaxTotal, LineSaleTotal, MediaTaxTotal, MediaRoundTotal, MediaChangeTotal, MediaTotal, DueTotal, TaxTotal, SaleTotal, VoidTotal, Timestamp, TransDate, ItemDiscountTotal, ItemSurchargeTotal, SubTotalDiscount, SubTotalDiscountID, SubTotalDiscountDescription, SubTotalDiscountRate, SubTotalDiscountEntryType, SubTotalSurcharge, SubTotalSurchargeID, SubTotalSurchargeDescription, SubTotalSurchargeRate, SubTotalSurchargeEntryType, Tips
		FROM Pos 
		ORDER BY PosTXID
	</cfquery>
	<cfreturn QgetallPosBeans />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="public" returntype="PosBean" output="false" hint="DAO method">
<cfargument name="argsPosBean" type="PosBean" required="yes" displayname="create" />
	<cfset var qPosBeanInsert = 0 />
	<cfset var PosBean = arguments.argsPosBean />
    
      <!---[    Set the Transdate to just the year, month and day   ]---->
       <cfset CreateTransDate( PosBean ) /> 
     
	<cfquery name="qPosBeanInsert" datasource="#variables.dsn#" result="result" >
		SET NOCOUNT ON
		INSERT into Pos
		( PosID, PosType, PosStatus, PosCode, StoreID, TerminalID, LocationID, TableID, PriceID, ClerkID, DrawerID, MemberID, MemberName, DebtorID, DebtorName, CoverQuantity, SeatCount, WalletCount, CostTotal, DiscountTotal, LineTaxTotal, LineSaleTotal, MediaTaxTotal, MediaRoundTotal, MediaChangeTotal, MediaTotal, DueTotal, TaxTotal, SaleTotal, VoidTotal, Timestamp, TransDate, ItemDiscountTotal, ItemSurchargeTotal, SubTotalDiscount, SubTotalDiscountID, SubTotalDiscountDescription, SubTotalDiscountRate, SubTotalDiscountEntryType, SubTotalSurcharge, SubTotalSurchargeID, SubTotalSurchargeDescription, SubTotalSurchargeRate, SubTotalSurchargeEntryType, Tips ) VALUES
		(

		<cfqueryparam value="#PosBean.getposid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getpostype()#" cfsqltype="CF_SQL_TINYINT" />,
		<cfqueryparam value="#PosBean.getposstatus()#" cfsqltype="CF_SQL_TINYINT" />,
		<cfqueryparam value="#PosBean.getposcode()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosBean.getstoreid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getterminalid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getlocationid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.gettableid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getpriceid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getclerkid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getdrawerid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getmemberid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getmembername()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosBean.getdebtorid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getdebtorname()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosBean.getcoverquantity()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getseatcount()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getwalletcount()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getcosttotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getdiscounttotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getlinetaxtotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getlinesaletotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getmediataxtotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getmediaroundtotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getmediachangetotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getmediatotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getduetotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.gettaxtotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getsaletotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getvoidtotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#variables.config.getAusTime()#" cfsqltype="CF_SQL_TIMESTAMP" />,
        #createodbcdate(PosBean.getTransDate())#,
		<cfqueryparam value="#PosBean.getitemdiscounttotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getitemsurchargetotal()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getsubtotaldiscount()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getsubtotaldiscountid()#" cfsqltype="CF_SQL_SMALLINT" />,
		<cfqueryparam value="#PosBean.getsubtotaldiscountdescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosBean.getsubtotaldiscountrate()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getsubtotaldiscountentrytype()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.getsubtotalsurcharge()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getsubtotalsurchargeid()#" cfsqltype="CF_SQL_SMALLINT" />,
		<cfqueryparam value="#PosBean.getsubtotalsurchargedescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosBean.getsubtotalsurchargerate()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosBean.getsubtotalsurchargeentrytype()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosBean.gettips()#" cfsqltype="CF_SQL_FLOAT" />
		   ) 
		SELECT Ident_Current('Pos') as PosTXID
		SET NOCOUNT OFF
	</cfquery>
	<cfset PosBean.setPosTXID(qPosBeanInsert.PosTXID)>
    <cfreturn PosBean />
</cffunction>

<cffunction name="update" access="private" returntype="PosBean" output="false" hint="DAO method">
<cfargument name="argsPosBean" type="PosBean" required="yes" />
	<cfset var PosBean = arguments.argsPosBean />
	<cfset var PosBeanUpdate = 0 >
   <!---[    Set the Transdate to just the year, month and day   ]---->
   <!---[    <cfset CreateTransDate( PosBean ) />   ]---->
    
	<cfquery name="PosBeanUpdate" datasource="#variables.dsn#" >
		UPDATE Pos SET
posid  = <cfqueryparam value="#PosBean.getPosID()#" cfsqltype="CF_SQL_INTEGER"/>,
postype  = <cfqueryparam value="#PosBean.getPosType()#" cfsqltype="CF_SQL_TINYINT"/>,
posstatus  = <cfqueryparam value="#PosBean.getPosStatus()#" cfsqltype="CF_SQL_TINYINT"/>,
poscode  = <cfqueryparam value="#PosBean.getPosCode()#" cfsqltype="CF_SQL_VARCHAR"/>,
storeid  = <cfqueryparam value="#PosBean.getStoreID()#" cfsqltype="CF_SQL_INTEGER"/>,
terminalid  = <cfqueryparam value="#PosBean.getTerminalID()#" cfsqltype="CF_SQL_INTEGER"/>,
locationid  = <cfqueryparam value="#PosBean.getLocationID()#" cfsqltype="CF_SQL_INTEGER"/>,
tableid  = <cfqueryparam value="#PosBean.getTableID()#" cfsqltype="CF_SQL_INTEGER"/>,
priceid  = <cfqueryparam value="#PosBean.getPriceID()#" cfsqltype="CF_SQL_INTEGER"/>,
clerkid  = <cfqueryparam value="#PosBean.getClerkID()#" cfsqltype="CF_SQL_INTEGER"/>,
drawerid  = <cfqueryparam value="#PosBean.getDrawerID()#" cfsqltype="CF_SQL_INTEGER"/>,
memberid  = <cfqueryparam value="#PosBean.getMemberID()#" cfsqltype="CF_SQL_INTEGER"/>,
membername  = <cfqueryparam value="#PosBean.getMemberName()#" cfsqltype="CF_SQL_VARCHAR"/>,
debtorid  = <cfqueryparam value="#PosBean.getDebtorID()#" cfsqltype="CF_SQL_INTEGER"/>,
debtorname  = <cfqueryparam value="#PosBean.getDebtorName()#" cfsqltype="CF_SQL_VARCHAR"/>,
coverquantity  = <cfqueryparam value="#PosBean.getCoverQuantity()#" cfsqltype="CF_SQL_INTEGER"/>,
seatcount  = <cfqueryparam value="#PosBean.getSeatCount()#" cfsqltype="CF_SQL_INTEGER"/>,
walletcount  = <cfqueryparam value="#PosBean.getWalletCount()#" cfsqltype="CF_SQL_INTEGER"/>,
costtotal  = <cfqueryparam value="#PosBean.getCostTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
discounttotal  = <cfqueryparam value="#PosBean.getDiscountTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
linetaxtotal  = <cfqueryparam value="#PosBean.getLineTaxTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
linesaletotal  = <cfqueryparam value="#PosBean.getLineSaleTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
mediataxtotal  = <cfqueryparam value="#PosBean.getMediaTaxTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
mediaroundtotal  = <cfqueryparam value="#PosBean.getMediaRoundTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
mediachangetotal  = <cfqueryparam value="#PosBean.getMediaChangeTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
mediatotal  = <cfqueryparam value="#PosBean.getMediaTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
duetotal  = <cfqueryparam value="#PosBean.getDueTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
taxtotal  = <cfqueryparam value="#PosBean.getTaxTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
saletotal  = <cfqueryparam value="#PosBean.getSaleTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
voidtotal  = <cfqueryparam value="#PosBean.getVoidTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
timestamp  = <cfqueryparam value="#PosBean.getTimestamp()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
transDate = <cfqueryparam value="#PosBean.getTransDate()#" cfsqltype="CF_SQL_TIMESTAMP" />,
itemdiscounttotal  = <cfqueryparam value="#PosBean.getItemDiscountTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
itemsurchargetotal  = <cfqueryparam value="#PosBean.getItemSurchargeTotal()#" cfsqltype="CF_SQL_FLOAT"/>,
subtotaldiscount  = <cfqueryparam value="#PosBean.getSubTotalDiscount()#" cfsqltype="CF_SQL_FLOAT"/>,
subtotaldiscountid  = <cfqueryparam value="#PosBean.getSubTotalDiscountID()#" cfsqltype="CF_SQL_SMALLINT"/>,
subtotaldiscountdescription  = <cfqueryparam value="#PosBean.getSubTotalDiscountDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
subtotaldiscountrate  = <cfqueryparam value="#PosBean.getSubTotalDiscountRate()#" cfsqltype="CF_SQL_FLOAT"/>,
subtotaldiscountentrytype  = <cfqueryparam value="#PosBean.getSubTotalDiscountEntryType()#" cfsqltype="CF_SQL_INTEGER"/>,
subtotalsurcharge  = <cfqueryparam value="#PosBean.getSubTotalSurcharge()#" cfsqltype="CF_SQL_FLOAT"/>,
subtotalsurchargeid  = <cfqueryparam value="#PosBean.getSubTotalSurchargeID()#" cfsqltype="CF_SQL_SMALLINT"/>,
subtotalsurchargedescription  = <cfqueryparam value="#PosBean.getSubTotalSurchargeDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
subtotalsurchargerate  = <cfqueryparam value="#PosBean.getSubTotalSurchargeRate()#" cfsqltype="CF_SQL_FLOAT"/>,
subtotalsurchargeentrytype  = <cfqueryparam value="#PosBean.getSubTotalSurchargeEntryType()#" cfsqltype="CF_SQL_INTEGER"/>,
tips  = <cfqueryparam value="#PosBean.getTips()#" cfsqltype="CF_SQL_FLOAT"/>
						
		WHERE 
		PosTXID = <cfqueryparam value="#PosBean.getPosTXID()#"   cfsqltype="CF_SQL_VARCHAR" />
	</cfquery>
	
	<cfreturn PosBean />
</cffunction>

<cffunction name="CreateTransDate" access="public" output="no" returntype="PosBean" hint="Calculates the value of TransDate, from the current value of TimeStamp">
<cfargument name="argsPosBean" type="PosBean" required="yes" />
	<cfset var PosBean = arguments.argsPosBean />
    <cfset var TransDate = 0 />
  
    <cfscript>
	TransDate =  PosBean.getTransDate();
	TransYear = year(TransDate );
	TransMonth = month(TransDate);
	TransDay = day(TransDate );
	//TransDay = listfirst(TransDate, "/");
	//TransYear = listlast(TransDate, "/");
	//TransMonth = ListGetAt(Transdate, "2", "/");
	NewTransDate = createdatetime( TransYear, TransMonth, TransDay,  "0", "0", "0");
	PosBean.setTransDate( NewTransDate );
	</cfscript>  
<cfreturn PosBean />
</cffunction>
<!---[   
=========================================================================================================
Update status methods - recording progress of the transaction through the system.
=========================================================================================================
]---->
   
<cffunction name="setPosMixMatchFlag" access="public" output="no" returntype="void" hint="Sets a flag to indicate successful process of the PosMixMatch subroutines.">
    <cfargument name="argsPosTXID" required="yes" type="numeric" />
    <cfset var PosTXID = arguments.argsPosTXID />
    <cfquery name="qUpdateFlag" datasource="#variables.dsn#">
        UPDATE Pos SET PosMixMatchPosted = <cfqueryparam value="true" cfsqltype="cf_sql_bit" />
        WHERE
        PosTXID = <cfqueryparam value="#PosTXID#" cfsqltype="cf_sql_integer" />
    </cfquery>
</cffunction> 

<cffunction name="setPosMixMatchProductFlag" access="public" output="no" returntype="void" hint="Sets a flag to indicate successful process of the PosMixMatch subroutines.">
    <cfargument name="argsPosTXID" required="yes" type="numeric" />
    <cfset var PosTXID = arguments.argsPosTXID />
    <cfquery name="qUpdateFlag" datasource="#variables.dsn#">
        UPDATE Pos SET PosMixMatchProductPosted = <cfqueryparam value="true" cfsqltype="cf_sql_bit" />
        WHERE
        PosTXID = <cfqueryparam value="#PosTXID#" cfsqltype="cf_sql_integer" />
    </cfquery>
</cffunction> 

<cffunction name="setEODSummaryPostedFlag" access="public" output="no" returntype="void" hint="Sets a flag to indicate successful process of the PosMixMatch subroutines.">
    <cfargument name="argsPosTXID" required="yes" type="numeric" />
    <cfset var PosTXID = arguments.argsPosTXID />
    <cfquery name="qUpdateFlag" datasource="#variables.dsn#">
        UPDATE Pos SET EODSummaryPosted = <cfqueryparam value="true" cfsqltype="cf_sql_bit" />
        WHERE
        PosTXID = <cfqueryparam value="#PosTXID#" cfsqltype="cf_sql_integer" />
    </cfquery>
</cffunction> 

<cffunction name="setECRTTotalPostedFlag" access="public" output="no" returntype="void" hint="Sets a flag to indicate successful process of the PosMixMatch subroutines.">
    <cfargument name="argsPosTXID" required="yes" type="numeric" />
    <cfset var PosTXID = arguments.argsPosTXID />
    <cfquery name="qUpdateFlag" datasource="#variables.dsn#">
        UPDATE Pos SET ECRTTotalPosted = <cfqueryparam value="true" cfsqltype="cf_sql_bit" />
        WHERE
        PosTXID = <cfqueryparam value="#PosTXID#" cfsqltype="cf_sql_integer" />
    </cfquery>
</cffunction> 

</cfcomponent>