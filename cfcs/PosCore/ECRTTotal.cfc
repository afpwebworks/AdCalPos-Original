<cfcomponent displayname="ECRTTotal" output="false" hint="A bean which models the ECRTTotal record.">

<cfsilent>
<!----
================================================================
Filename: ECRTTotal.cfc
Description: A bean which models the ECRTTotal record.
Author:  Michael Kear, AFP Webworks 
Date: 12/May/2010
================================================================
This bean was generated with the following template:
Bean Name: ECRTTotal
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	ID numeric 0
	StoreID numeric 0
	FileName string 
	DateEntered date #request.austime#
	TimeEntered string #request.austime#
	Date date #request.austime#
	Time string #request.austime#
	Location numeric 0
	ScaleIDCode numeric 0
	RoundingsD numeric 0
	Discounts numeric 0
	DiscountD numeric 0
	CashSales numeric 1
	CashSalesD numeric 0
	CreditSales numeric 0
	CreditSalesD numeric 0
	EFTCashOut numeric 0
	EFTCashOutD numeric 0
	CashRefunds numeric 0
	CashRefundD numeric 0
	CreditRefunds numeric 0
	CreditRefundD numeric 0
	CashSalesGSTincD numeric 0
	CashSaleGSTfreeD numeric 0
	CreditSalesGSTincD numeric 0
	CreditSalesGSTfreeD numeric 0
	GSTCashSaleD numeric 0
	GSTCreditSaleD numeric 0
	CashIn numeric 0
	CashInD numeric 0
	CashOut numeric 0
	CashOutD numeric 0
	Cancellations numeric 0
	CancellationD numeric 0
	Sales numeric 0
	Posted boolean false
Create getSnapshot method: true
Create setSnapshot method: false
Create setStepInstance method: false
Create validate method: true
Create validate interior: true
Create LTO methods: false
Path to LTO: 
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---[	PROPERTIES	]--->
	<cfset variables.instance = StructNew() />

	<!---[ 	INITIALIZATION / CONFIGURATION	]--->
	<cffunction name="init" access="public" returntype="ECRTTotal" output="false">
		<cfargument name="ID" type="numeric" required="false" default="0" />
		<cfargument name="StoreID" type="numeric" required="false" default="0" />
		<cfargument name="FileName" type="string" required="false" default="" />
		<cfargument name="DateEntered" type="date" required="false" default="#request.austime#" />
		<cfargument name="TimeEntered" type="string" required="false" default="#request.austime#" />
		<cfargument name="Date" type="date" required="false" default="#request.austime#" />
		<cfargument name="Time" type="string" required="false" default="#request.austime#" />
		<cfargument name="Location" type="numeric" required="false" default="0" />
		<cfargument name="ScaleIDCode" type="numeric" required="false" default="0" />
		<cfargument name="RoundingsD" type="numeric" required="false" default="0" />
		<cfargument name="Discounts" type="numeric" required="false" default="0" />
		<cfargument name="DiscountD" type="numeric" required="false" default="0" />
		<cfargument name="CashSales" type="numeric" required="false" default="1" />
		<cfargument name="CashSalesD" type="numeric" required="false" default="0" />
		<cfargument name="CreditSales" type="numeric" required="false" default="0" />
		<cfargument name="CreditSalesD" type="numeric" required="false" default="0" />
		<cfargument name="EFTCashOut" type="numeric" required="false" default="0" />
		<cfargument name="EFTCashOutD" type="numeric" required="false" default="0" />
		<cfargument name="CashRefunds" type="numeric" required="false" default="0" />
		<cfargument name="CashRefundD" type="numeric" required="false" default="0" />
		<cfargument name="CreditRefunds" type="numeric" required="false" default="0" />
		<cfargument name="CreditRefundD" type="numeric" required="false" default="0" />
		<cfargument name="CashSalesGSTincD" type="numeric" required="false" default="0" />
		<cfargument name="CashSaleGSTfreeD" type="numeric" required="false" default="0" />
		<cfargument name="CreditSalesGSTincD" type="numeric" required="false" default="0" />
		<cfargument name="CreditSalesGSTfreeD" type="numeric" required="false" default="0" />
		<cfargument name="GSTCashSaleD" type="numeric" required="false" default="0" />
		<cfargument name="GSTCreditSaleD" type="numeric" required="false" default="0" />
		<cfargument name="CashIn" type="numeric" required="false" default="0" />
		<cfargument name="CashInD" type="numeric" required="false" default="0" />
		<cfargument name="CashOut" type="numeric" required="false" default="0" />
		<cfargument name="CashOutD" type="numeric" required="false" default="0" />
		<cfargument name="Cancellations" type="numeric" required="false" default="0" />
		<cfargument name="CancellationD" type="numeric" required="false" default="0" />
		<cfargument name="Sales" type="numeric" required="false" default="0" />
		<cfargument name="Posted" type="boolean" required="false" default="false" />
        
       <!---[    Now change the dates and times from the argument values to the current request.austime date and time portions.   ]---->
      <cfscript>
	  		//Componentise the date.
			thisyear   = datepart("yyyy",request.austime) ;
			thismonth  = datepart("m",request.austime) ;
			thisday    = datepart("d",request.austime) ;
			thishour   = datepart("h",request.austime) ;
			thisminute = datepart("n",request.austime) ;
			thissecond = datepart("s",request.austime) ;
			//create temporary objects for date and time
			thisdate   = createdate( thisyear, thismonth, thisday  ) ;
			thistime   = "#thishour#:#thisminute#:#thissecond#" ;
			// run setters
			setID(arguments.ID);
			setStoreID(arguments.StoreID);
			setFileName(arguments.FileName);
			setDateEntered(thisdate);
			setTimeEntered(thistime);
			setDate(thisdate);
			setTime(thistime);
			setLocation(arguments.Location);
			setScaleIDCode(arguments.ScaleIDCode);
			setRoundingsD(arguments.RoundingsD);
			setDiscounts(arguments.Discounts);
			setDiscountD(arguments.DiscountD);
			setCashSales(arguments.CashSales);
			setCashSalesD(arguments.CashSalesD);
			setCreditSales(arguments.CreditSales);
			setCreditSalesD(arguments.CreditSalesD);
			setEFTCashOut(arguments.EFTCashOut);
			setEFTCashOutD(arguments.EFTCashOutD);
			setCashRefunds(arguments.CashRefunds);
			setCashRefundD(arguments.CashRefundD);
			setCreditRefunds(arguments.CreditRefunds);
			setCreditRefundD(arguments.CreditRefundD);
			setCashSalesGSTincD(arguments.CashSalesGSTincD);
			setCashSaleGSTfreeD(arguments.CashSaleGSTfreeD);
			setCreditSalesGSTincD(arguments.CreditSalesGSTincD);
			setCreditSalesGSTfreeD(arguments.CreditSalesGSTfreeD);
			setGSTCashSaleD(arguments.GSTCashSaleD);
			setGSTCreditSaleD(arguments.GSTCreditSaleD);
			setCashIn(arguments.CashIn);
			setCashInD(arguments.CashInD);
			setCashOut(arguments.CashOut);
			setCashOutD(arguments.CashOutD);
			setCancellations(arguments.Cancellations);
			setCancellationD(arguments.CancellationD);
			setSales(arguments.Sales);
			setPosted(arguments.Posted);
			return this;
		</cfscript>
 	</cffunction>

	<!---[ 	PUBLIC FUNCTIONS 	]--->
	<cffunction name="getSnapshot" access="public"returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="eH" required="true" type="any" />
<!-----[ validation parameters  (customise to suit) then remove comments 
			<!----[ ID ]---->
			<cfif ( getID() eq whatever )>
				<cfset arguments.eH.setError("ID", "ID This is the error message") />
			</cfif>
			
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setID" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true" />
		<cfset variables.instance.ID = arguments.ID />
	</cffunction>
	<cffunction name="getID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ID />
	</cffunction>

	<cffunction name="setStoreID" access="public" returntype="void" output="false">
		<cfargument name="StoreID" type="numeric" required="true" />
		<cfset variables.instance.StoreID = arguments.StoreID />
	</cffunction>
	<cffunction name="getStoreID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.StoreID />
	</cffunction>

	<cffunction name="setFileName" access="public" returntype="void" output="false">
		<cfargument name="FileName" type="string" required="true" />
		<cfset variables.instance.FileName = arguments.FileName />
	</cffunction>
	<cffunction name="getFileName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.FileName />
	</cffunction>

	<cffunction name="setDateEntered" access="public" returntype="void" output="false">
		<cfargument name="DateEntered" type="date" required="true" />
		<!---[   <cfif isDate(arguments.DateEntered)>
			<cfset arguments.DateEntered = dateformat(arguments.DateEntered,"DD/MM/YYYY") />
		</cfif>   ]---->
		<cfset variables.instance.DateEntered = arguments.DateEntered />
	</cffunction>
	<cffunction name="getDateEntered" access="public" returntype="date" output="false">
		<cfreturn variables.instance.DateEntered />
	</cffunction>

	<cffunction name="setTimeEntered" access="public" returntype="void" output="false">
		<cfargument name="TimeEntered" type="string" required="true" />
		<cfset variables.instance.TimeEntered = arguments.TimeEntered />
	</cffunction>
	<cffunction name="getTimeEntered" access="public" returntype="string" output="false">
		<cfreturn variables.instance.TimeEntered />
	</cffunction>

	<cffunction name="setDate" access="public" returntype="void" output="false">
		<cfargument name="Date" type="date" required="true" />
		<!---[   <cfif isDate(arguments.Date)>
			<cfset arguments.Date = dateformat(arguments.Date,"DD/MM/YYYY") />
		</cfif>   ]---->
		<cfset variables.instance.Date = arguments.Date />
	</cffunction>
	<cffunction name="getDate" access="public" returntype="date" output="false">
		<cfreturn variables.instance.Date />
	</cffunction>

	<cffunction name="setTime" access="public" returntype="void" output="false">
		<cfargument name="Time" type="string" required="true" />
		<cfset variables.instance.Time = arguments.Time />
	</cffunction>
	<cffunction name="getTime" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Time />
	</cffunction>

	<cffunction name="setLocation" access="public" returntype="void" output="false">
		<cfargument name="Location" type="numeric" required="true" />
		<cfset variables.instance.Location = arguments.Location />
	</cffunction>
	<cffunction name="getLocation" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Location />
	</cffunction>

	<cffunction name="setScaleIDCode" access="public" returntype="void" output="false">
		<cfargument name="ScaleIDCode" type="numeric" required="true" />
		<cfset variables.instance.ScaleIDCode = arguments.ScaleIDCode />
	</cffunction>
	<cffunction name="getScaleIDCode" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ScaleIDCode />
	</cffunction>

	<cffunction name="setRoundingsD" access="public" returntype="void" output="false">
		<cfargument name="RoundingsD" type="numeric" required="true" />
		<cfset variables.instance.RoundingsD = arguments.RoundingsD />
	</cffunction>
	<cffunction name="getRoundingsD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.RoundingsD />
	</cffunction>

	<cffunction name="setDiscounts" access="public" returntype="void" output="false">
		<cfargument name="Discounts" type="numeric" required="true" />
		<cfset variables.instance.Discounts = arguments.Discounts />
	</cffunction>
	<cffunction name="getDiscounts" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Discounts />
	</cffunction>

	<cffunction name="setDiscountD" access="public" returntype="void" output="false">
		<cfargument name="DiscountD" type="numeric" required="true" />
		<cfset variables.instance.DiscountD = arguments.DiscountD />
	</cffunction>
	<cffunction name="getDiscountD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.DiscountD />
	</cffunction>

	<cffunction name="setCashSales" access="public" returntype="void" output="false">
		<cfargument name="CashSales" type="numeric" required="true" />
		<cfset variables.instance.CashSales = arguments.CashSales />
	</cffunction>
	<cffunction name="getCashSales" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CashSales />
	</cffunction>

	<cffunction name="setCashSalesD" access="public" returntype="void" output="false">
		<cfargument name="CashSalesD" type="numeric" required="true" />
		<cfset variables.instance.CashSalesD = arguments.CashSalesD />
	</cffunction>
	<cffunction name="getCashSalesD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CashSalesD />
	</cffunction>

	<cffunction name="setCreditSales" access="public" returntype="void" output="false">
		<cfargument name="CreditSales" type="numeric" required="true" />
		<cfset variables.instance.CreditSales = arguments.CreditSales />
	</cffunction>
	<cffunction name="getCreditSales" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CreditSales />
	</cffunction>

	<cffunction name="setCreditSalesD" access="public" returntype="void" output="false">
		<cfargument name="CreditSalesD" type="numeric" required="true" />
		<cfset variables.instance.CreditSalesD = arguments.CreditSalesD />
	</cffunction>
	<cffunction name="getCreditSalesD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CreditSalesD />
	</cffunction>

	<cffunction name="setEFTCashOut" access="public" returntype="void" output="false">
		<cfargument name="EFTCashOut" type="numeric" required="true" />
		<cfset variables.instance.EFTCashOut = arguments.EFTCashOut />
	</cffunction>
	<cffunction name="getEFTCashOut" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.EFTCashOut />
	</cffunction>

	<cffunction name="setEFTCashOutD" access="public" returntype="void" output="false">
		<cfargument name="EFTCashOutD" type="numeric" required="true" />
		<cfset variables.instance.EFTCashOutD = arguments.EFTCashOutD />
	</cffunction>
	<cffunction name="getEFTCashOutD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.EFTCashOutD />
	</cffunction>

	<cffunction name="setCashRefunds" access="public" returntype="void" output="false">
		<cfargument name="CashRefunds" type="numeric" required="true" />
		<cfset variables.instance.CashRefunds = arguments.CashRefunds />
	</cffunction>
	<cffunction name="getCashRefunds" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CashRefunds />
	</cffunction>

	<cffunction name="setCashRefundD" access="public" returntype="void" output="false">
		<cfargument name="CashRefundD" type="numeric" required="true" />
		<cfset variables.instance.CashRefundD = arguments.CashRefundD />
	</cffunction>
	<cffunction name="getCashRefundD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CashRefundD />
	</cffunction>

	<cffunction name="setCreditRefunds" access="public" returntype="void" output="false">
		<cfargument name="CreditRefunds" type="numeric" required="true" />
		<cfset variables.instance.CreditRefunds = arguments.CreditRefunds />
	</cffunction>
	<cffunction name="getCreditRefunds" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CreditRefunds />
	</cffunction>

	<cffunction name="setCreditRefundD" access="public" returntype="void" output="false">
		<cfargument name="CreditRefundD" type="numeric" required="true" />
		<cfset variables.instance.CreditRefundD = arguments.CreditRefundD />
	</cffunction>
	<cffunction name="getCreditRefundD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CreditRefundD />
	</cffunction>

	<cffunction name="setCashSalesGSTincD" access="public" returntype="void" output="false">
		<cfargument name="CashSalesGSTincD" type="numeric" required="true" />
		<cfset variables.instance.CashSalesGSTincD = arguments.CashSalesGSTincD />
	</cffunction>
	<cffunction name="getCashSalesGSTincD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CashSalesGSTincD />
	</cffunction>

	<cffunction name="setCashSaleGSTfreeD" access="public" returntype="void" output="false">
		<cfargument name="CashSaleGSTfreeD" type="numeric" required="true" />
		<cfset variables.instance.CashSaleGSTfreeD = arguments.CashSaleGSTfreeD />
	</cffunction>
	<cffunction name="getCashSaleGSTfreeD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CashSaleGSTfreeD />
	</cffunction>

	<cffunction name="setCreditSalesGSTincD" access="public" returntype="void" output="false">
		<cfargument name="CreditSalesGSTincD" type="numeric" required="true" />
		<cfset variables.instance.CreditSalesGSTincD = arguments.CreditSalesGSTincD />
	</cffunction>
	<cffunction name="getCreditSalesGSTincD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CreditSalesGSTincD />
	</cffunction>

	<cffunction name="setCreditSalesGSTfreeD" access="public" returntype="void" output="false">
		<cfargument name="CreditSalesGSTfreeD" type="numeric" required="true" />
		<cfset variables.instance.CreditSalesGSTfreeD = arguments.CreditSalesGSTfreeD />
	</cffunction>
	<cffunction name="getCreditSalesGSTfreeD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CreditSalesGSTfreeD />
	</cffunction>

	<cffunction name="setGSTCashSaleD" access="public" returntype="void" output="false">
		<cfargument name="GSTCashSaleD" type="numeric" required="true" />
		<cfset variables.instance.GSTCashSaleD = arguments.GSTCashSaleD />
	</cffunction>
	<cffunction name="getGSTCashSaleD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.GSTCashSaleD />
	</cffunction>

	<cffunction name="setGSTCreditSaleD" access="public" returntype="void" output="false">
		<cfargument name="GSTCreditSaleD" type="numeric" required="true" />
		<cfset variables.instance.GSTCreditSaleD = arguments.GSTCreditSaleD />
	</cffunction>
	<cffunction name="getGSTCreditSaleD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.GSTCreditSaleD />
	</cffunction>

	<cffunction name="setCashIn" access="public" returntype="void" output="false">
		<cfargument name="CashIn" type="numeric" required="true" />
		<cfset variables.instance.CashIn = arguments.CashIn />
	</cffunction>
	<cffunction name="getCashIn" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CashIn />
	</cffunction>

	<cffunction name="setCashInD" access="public" returntype="void" output="false">
		<cfargument name="CashInD" type="numeric" required="true" />
		<cfset variables.instance.CashInD = arguments.CashInD />
	</cffunction>
	<cffunction name="getCashInD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CashInD />
	</cffunction>

	<cffunction name="setCashOut" access="public" returntype="void" output="false">
		<cfargument name="CashOut" type="numeric" required="true" />
		<cfset variables.instance.CashOut = arguments.CashOut />
	</cffunction>
	<cffunction name="getCashOut" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CashOut />
	</cffunction>

	<cffunction name="setCashOutD" access="public" returntype="void" output="false">
		<cfargument name="CashOutD" type="numeric" required="true" />
		<cfset variables.instance.CashOutD = arguments.CashOutD />
	</cffunction>
	<cffunction name="getCashOutD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CashOutD />
	</cffunction>

	<cffunction name="setCancellations" access="public" returntype="void" output="false">
		<cfargument name="Cancellations" type="numeric" required="true" />
		<cfset variables.instance.Cancellations = arguments.Cancellations />
	</cffunction>
	<cffunction name="getCancellations" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Cancellations />
	</cffunction>

	<cffunction name="setCancellationD" access="public" returntype="void" output="false">
		<cfargument name="CancellationD" type="numeric" required="true" />
		<cfset variables.instance.CancellationD = arguments.CancellationD />
	</cffunction>
	<cffunction name="getCancellationD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CancellationD />
	</cffunction>

	<cffunction name="setSales" access="public" returntype="void" output="false">
		<cfargument name="Sales" type="numeric" required="true" />
		<cfset variables.instance.Sales = arguments.Sales />
	</cffunction>
	<cffunction name="getSales" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Sales />
	</cffunction>

	<cffunction name="setPosted" access="public" returntype="void" output="false">
		<cfargument name="Posted" type="boolean" required="true" />
		<cfset variables.instance.Posted = arguments.Posted />
	</cffunction>
	<cffunction name="getPosted" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.Posted />
	</cffunction>

</cfcomponent>