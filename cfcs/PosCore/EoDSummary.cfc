<cfcomponent displayname="EoDSummary" output="false" hint="A bean which models the EoDSummary record.">

<cfsilent>
<!----
================================================================
Filename: EoDSummary.cfc
Description: A bean which models the EoDSummary record.
Author:  Michael Kear, AFP Webworks 
Date: 19/May/2010
================================================================
This bean was generated with the following template:
Bean Name: EoDSummary
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	EodID numeric 0
	Date string 
	StoreID numeric 0
	Eod_ECR_CSV_Updated boolean false
	Eod_PLU_CSV_Updated boolean false
	EodHoursWorkedUpdated boolean false
	EodWasteUpdated boolean false
	EodTransferUpdated boolean false
	EodMiscUpdated boolean false
	EodStocktakeEnteredNotUpdated boolean false
	EodStocktakeUpdated boolean false
	DateEntered date #request.austime#
	Eod_EndOfDayFinished boolean false
	StartingStockValEx numeric 0
	EndingStockValEx numeric 0
	StockVarianceValEx numeric 0
	PurchaseValEx numeric 0
	WastageValEx numeric 0
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
	<cffunction name="init" access="public" returntype="EoDSummary" output="false">
		<cfargument name="EodID" type="numeric" required="false" default="0" />
		<cfargument name="Date" type="string" required="false" default="" />
		<cfargument name="StoreID" type="numeric" required="false" default="0" />
		<cfargument name="Eod_ECR_CSV_Updated" type="boolean" required="false" default="false" />
		<cfargument name="Eod_PLU_CSV_Updated" type="boolean" required="false" default="false" />
		<cfargument name="EodHoursWorkedUpdated" type="boolean" required="false" default="false" />
		<cfargument name="EodWasteUpdated" type="boolean" required="false" default="false" />
		<cfargument name="EodTransferUpdated" type="boolean" required="false" default="false" />
		<cfargument name="EodMiscUpdated" type="boolean" required="false" default="false" />
		<cfargument name="EodStocktakeEnteredNotUpdated" type="boolean" required="false" default="false" />
		<cfargument name="EodStocktakeUpdated" type="boolean" required="false" default="false" />
		<cfargument name="DateEntered" type="string" required="false" default="#request.austime#" />
		<cfargument name="Eod_EndOfDayFinished" type="boolean" required="false" default="false" />
		<cfargument name="StartingStockValEx" type="numeric" required="false" default="0" />
		<cfargument name="EndingStockValEx" type="numeric" required="false" default="0" />
		<cfargument name="StockVarianceValEx" type="numeric" required="false" default="0" />
		<cfargument name="PurchaseValEx" type="numeric" required="false" default="0" />
		<cfargument name="WastageValEx" type="numeric" required="false" default="0" />
		<cfscript>
			// run setters
			setEodID(arguments.EodID);
			setDate(arguments.Date);
			setStoreID(arguments.StoreID);
			setEod_ECR_CSV_Updated(arguments.Eod_ECR_CSV_Updated);
			setEod_PLU_CSV_Updated(arguments.Eod_PLU_CSV_Updated);
			setEodHoursWorkedUpdated(arguments.EodHoursWorkedUpdated);
			setEodWasteUpdated(arguments.EodWasteUpdated);
			setEodTransferUpdated(arguments.EodTransferUpdated);
			setEodMiscUpdated(arguments.EodMiscUpdated);
			setEodStocktakeEnteredNotUpdated(arguments.EodStocktakeEnteredNotUpdated);
			setEodStocktakeUpdated(arguments.EodStocktakeUpdated);
			setDateEntered(arguments.DateEntered);
			setEod_EndOfDayFinished(arguments.Eod_EndOfDayFinished);
			setStartingStockValEx(arguments.StartingStockValEx);
			setEndingStockValEx(arguments.EndingStockValEx);
			setStockVarianceValEx(arguments.StockVarianceValEx);
			setPurchaseValEx(arguments.PurchaseValEx);
			setWastageValEx(arguments.WastageValEx);
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
			<!----[ EodID ]---->
			<cfif ( getEodID() eq whatever )>
				<cfset arguments.eH.setError("EodID", "EodID This is the error message") />
			</cfif>
			<!----[ Date ]---->
			<cfif ( getDate() eq whatever )>
				<cfset arguments.eH.setError("Date", "Date This is the error message") />
			</cfif>
			<!----[ StoreID ]---->
			<cfif ( getStoreID() eq whatever )>
				<cfset arguments.eH.setError("StoreID", "StoreID This is the error message") />
			</cfif>
			<!----[ Eod_ECR_CSV_Updated ]---->
			<cfif ( getEod_ECR_CSV_Updated() eq whatever )>
				<cfset arguments.eH.setError("Eod_ECR_CSV_Updated", "Eod_ECR_CSV_Updated This is the error message") />
			</cfif>
			<!----[ Eod_PLU_CSV_Updated ]---->
			<cfif ( getEod_PLU_CSV_Updated() eq whatever )>
				<cfset arguments.eH.setError("Eod_PLU_CSV_Updated", "Eod_PLU_CSV_Updated This is the error message") />
			</cfif>
			<!----[ EodHoursWorkedUpdated ]---->
			<cfif ( getEodHoursWorkedUpdated() eq whatever )>
				<cfset arguments.eH.setError("EodHoursWorkedUpdated", "EodHoursWorkedUpdated This is the error message") />
			</cfif>
			<!----[ EodWasteUpdated ]---->
			<cfif ( getEodWasteUpdated() eq whatever )>
				<cfset arguments.eH.setError("EodWasteUpdated", "EodWasteUpdated This is the error message") />
			</cfif>
			<!----[ EodTransferUpdated ]---->
			<cfif ( getEodTransferUpdated() eq whatever )>
				<cfset arguments.eH.setError("EodTransferUpdated", "EodTransferUpdated This is the error message") />
			</cfif>
			<!----[ EodMiscUpdated ]---->
			<cfif ( getEodMiscUpdated() eq whatever )>
				<cfset arguments.eH.setError("EodMiscUpdated", "EodMiscUpdated This is the error message") />
			</cfif>
			<!----[ EodStocktakeEnteredNotUpdated ]---->
			<cfif ( getEodStocktakeEnteredNotUpdated() eq whatever )>
				<cfset arguments.eH.setError("EodStocktakeEnteredNotUpdated", "EodStocktakeEnteredNotUpdated This is the error message") />
			</cfif>
			<!----[ EodStocktakeUpdated ]---->
			<cfif ( getEodStocktakeUpdated() eq whatever )>
				<cfset arguments.eH.setError("EodStocktakeUpdated", "EodStocktakeUpdated This is the error message") />
			</cfif>
			<!----[ DateEntered ]---->
			<cfif ( getDateEntered() eq whatever )>
				<cfset arguments.eH.setError("DateEntered", "DateEntered This is the error message") />
			</cfif>
			<!----[ Eod_EndOfDayFinished ]---->
			<cfif ( getEod_EndOfDayFinished() eq whatever )>
				<cfset arguments.eH.setError("Eod_EndOfDayFinished", "Eod_EndOfDayFinished This is the error message") />
			</cfif>
			<!----[ StartingStockValEx ]---->
			<cfif ( getStartingStockValEx() eq whatever )>
				<cfset arguments.eH.setError("StartingStockValEx", "StartingStockValEx This is the error message") />
			</cfif>
			<!----[ EndingStockValEx ]---->
			<cfif ( getEndingStockValEx() eq whatever )>
				<cfset arguments.eH.setError("EndingStockValEx", "EndingStockValEx This is the error message") />
			</cfif>
			<!----[ StockVarianceValEx ]---->
			<cfif ( getStockVarianceValEx() eq whatever )>
				<cfset arguments.eH.setError("StockVarianceValEx", "StockVarianceValEx This is the error message") />
			</cfif>
			<!----[ PurchaseValEx ]---->
			<cfif ( getPurchaseValEx() eq whatever )>
				<cfset arguments.eH.setError("PurchaseValEx", "PurchaseValEx This is the error message") />
			</cfif>
			<!----[ WastageValEx ]---->
			<cfif ( getWastageValEx() eq whatever )>
				<cfset arguments.eH.setError("WastageValEx", "WastageValEx This is the error message") />
			</cfif>
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setEodID" access="public" returntype="void" output="false">
		<cfargument name="EodID" type="numeric" required="true" />
		<cfset variables.instance.EodID = arguments.EodID />
	</cffunction>
	<cffunction name="getEodID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.EodID />
	</cffunction>

	<cffunction name="setDate" access="public" returntype="void" output="false">
		<cfargument name="Date" type="string" required="true" />
		<cfset variables.instance.Date = arguments.Date />
	</cffunction>
	<cffunction name="getDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Date />
	</cffunction>

	<cffunction name="setStoreID" access="public" returntype="void" output="false">
		<cfargument name="StoreID" type="numeric" required="true" />
		<cfset variables.instance.StoreID = arguments.StoreID />
	</cffunction>
	<cffunction name="getStoreID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.StoreID />
	</cffunction>

	<cffunction name="setEod_ECR_CSV_Updated" access="public" returntype="void" output="false">
		<cfargument name="Eod_ECR_CSV_Updated" type="boolean" required="true" />
		<cfset variables.instance.Eod_ECR_CSV_Updated = arguments.Eod_ECR_CSV_Updated />
	</cffunction>
	<cffunction name="getEod_ECR_CSV_Updated" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.Eod_ECR_CSV_Updated />
	</cffunction>

	<cffunction name="setEod_PLU_CSV_Updated" access="public" returntype="void" output="false">
		<cfargument name="Eod_PLU_CSV_Updated" type="boolean" required="true" />
		<cfset variables.instance.Eod_PLU_CSV_Updated = arguments.Eod_PLU_CSV_Updated />
	</cffunction>
	<cffunction name="getEod_PLU_CSV_Updated" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.Eod_PLU_CSV_Updated />
	</cffunction>

	<cffunction name="setEodHoursWorkedUpdated" access="public" returntype="void" output="false">
		<cfargument name="EodHoursWorkedUpdated" type="boolean" required="true" />
		<cfset variables.instance.EodHoursWorkedUpdated = arguments.EodHoursWorkedUpdated />
	</cffunction>
	<cffunction name="getEodHoursWorkedUpdated" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.EodHoursWorkedUpdated />
	</cffunction>

	<cffunction name="setEodWasteUpdated" access="public" returntype="void" output="false">
		<cfargument name="EodWasteUpdated" type="boolean" required="true" />
		<cfset variables.instance.EodWasteUpdated = arguments.EodWasteUpdated />
	</cffunction>
	<cffunction name="getEodWasteUpdated" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.EodWasteUpdated />
	</cffunction>

	<cffunction name="setEodTransferUpdated" access="public" returntype="void" output="false">
		<cfargument name="EodTransferUpdated" type="boolean" required="true" />
		<cfset variables.instance.EodTransferUpdated = arguments.EodTransferUpdated />
	</cffunction>
	<cffunction name="getEodTransferUpdated" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.EodTransferUpdated />
	</cffunction>

	<cffunction name="setEodMiscUpdated" access="public" returntype="void" output="false">
		<cfargument name="EodMiscUpdated" type="boolean" required="true" />
		<cfset variables.instance.EodMiscUpdated = arguments.EodMiscUpdated />
	</cffunction>
	<cffunction name="getEodMiscUpdated" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.EodMiscUpdated />
	</cffunction>

	<cffunction name="setEodStocktakeEnteredNotUpdated" access="public" returntype="void" output="false">
		<cfargument name="EodStocktakeEnteredNotUpdated" type="boolean" required="true" />
		<cfset variables.instance.EodStocktakeEnteredNotUpdated = arguments.EodStocktakeEnteredNotUpdated />
	</cffunction>
	<cffunction name="getEodStocktakeEnteredNotUpdated" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.EodStocktakeEnteredNotUpdated />
	</cffunction>

	<cffunction name="setEodStocktakeUpdated" access="public" returntype="void" output="false">
		<cfargument name="EodStocktakeUpdated" type="boolean" required="true" />
		<cfset variables.instance.EodStocktakeUpdated = arguments.EodStocktakeUpdated />
	</cffunction>
	<cffunction name="getEodStocktakeUpdated" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.EodStocktakeUpdated />
	</cffunction>

	<cffunction name="setDateEntered" access="public" returntype="void" output="false">
		<cfargument name="DateEntered" type="string" required="true" />
		<cfif isDate(arguments.DateEntered)>
			<cfset arguments.DateEntered = dateformat(arguments.DateEntered,"DD/MM/YYYY") />
		</cfif>
		<cfset variables.instance.DateEntered = arguments.DateEntered />
	</cffunction>
	<cffunction name="getDateEntered" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateEntered />
	</cffunction>

	<cffunction name="setEod_EndOfDayFinished" access="public" returntype="void" output="false">
		<cfargument name="Eod_EndOfDayFinished" type="boolean" required="true" />
		<cfset variables.instance.Eod_EndOfDayFinished = arguments.Eod_EndOfDayFinished />
	</cffunction>
	<cffunction name="getEod_EndOfDayFinished" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.Eod_EndOfDayFinished />
	</cffunction>

	<cffunction name="setStartingStockValEx" access="public" returntype="void" output="false">
		<cfargument name="StartingStockValEx" type="numeric" required="true" />
		<cfset variables.instance.StartingStockValEx = arguments.StartingStockValEx />
	</cffunction>
	<cffunction name="getStartingStockValEx" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.StartingStockValEx />
	</cffunction>

	<cffunction name="setEndingStockValEx" access="public" returntype="void" output="false">
		<cfargument name="EndingStockValEx" type="numeric" required="true" />
		<cfset variables.instance.EndingStockValEx = arguments.EndingStockValEx />
	</cffunction>
	<cffunction name="getEndingStockValEx" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.EndingStockValEx />
	</cffunction>

	<cffunction name="setStockVarianceValEx" access="public" returntype="void" output="false">
		<cfargument name="StockVarianceValEx" type="numeric" required="true" />
		<cfset variables.instance.StockVarianceValEx = arguments.StockVarianceValEx />
	</cffunction>
	<cffunction name="getStockVarianceValEx" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.StockVarianceValEx />
	</cffunction>

	<cffunction name="setPurchaseValEx" access="public" returntype="void" output="false">
		<cfargument name="PurchaseValEx" type="numeric" required="true" />
		<cfset variables.instance.PurchaseValEx = arguments.PurchaseValEx />
	</cffunction>
	<cffunction name="getPurchaseValEx" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PurchaseValEx />
	</cffunction>

	<cffunction name="setWastageValEx" access="public" returntype="void" output="false">
		<cfargument name="WastageValEx" type="numeric" required="true" />
		<cfset variables.instance.WastageValEx = arguments.WastageValEx />
	</cffunction>
	<cffunction name="getWastageValEx" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.WastageValEx />
	</cffunction>

</cfcomponent>