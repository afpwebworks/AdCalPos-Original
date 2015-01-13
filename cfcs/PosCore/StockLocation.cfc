<cfcomponent displayname="StockLocation" output="false" hint="A bean which models the StockLocation record.">

<cfsilent>
<!----
================================================================
Filename: StockLocation.cfc
Description: A bean which models the StockLocation record.
Author:  Michael Kear, AFP Webworks 
Date: 5/Apr/2011
================================================================
This bean was generated with the following template:
Bean Name: StockLocation
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	ID numeric 0
	StoreID numeric 0
	PartNo string 
	productid numeric 0
	LastCost numeric 0
	AverageCost numeric 0
	RetailPrice numeric 0
	MaxRetail numeric 0
	QtyOnHand numeric 0
	ReorderPoint numeric 0
	MaxShelfQty numeric 0
	FridayFactor numeric 0
	DateEntered date #request.austime#
	Prev_QtyOnHand numeric 0
	Freezer_QtyOnHand numeric 0
	CoolRoom_QtyOnHand numeric 0
	Display_QtyOnHand numeric 0
	Wastage numeric 0
	TeansferQty numeric 0
	TransferToPlu string 
	ProcessedStockTake boolean false
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
	<cffunction name="init" access="public" returntype="StockLocation" output="false">
		<cfargument name="ID" type="numeric" required="false" default="0" />
		<cfargument name="StoreID" type="numeric" required="false" default="0" />
		<cfargument name="PartNo" type="string" required="false" default="" />
		<cfargument name="productid" type="numeric" required="false" default="0" />
		<cfargument name="LastCost" type="numeric" required="false" default="0" />
		<cfargument name="AverageCost" type="numeric" required="false" default="0" />
		<cfargument name="RetailPrice" type="numeric" required="false" default="0" />
		<cfargument name="MaxRetail" type="numeric" required="false" default="0" />
		<cfargument name="QtyOnHand" type="numeric" required="false" default="0" />
		<cfargument name="ReorderPoint" type="numeric" required="false" default="0" />
		<cfargument name="MaxShelfQty" type="numeric" required="false" default="0" />
		<cfargument name="FridayFactor" type="numeric" required="false" default="0" />
		<cfargument name="DateEntered" type="string" required="false" default="#request.austime#" />
		<cfargument name="Prev_QtyOnHand" type="numeric" required="false" default="0" />
		<cfargument name="Freezer_QtyOnHand" type="numeric" required="false" default="0" />
		<cfargument name="CoolRoom_QtyOnHand" type="numeric" required="false" default="0" />
		<cfargument name="Display_QtyOnHand" type="numeric" required="false" default="0" />
		<cfargument name="Wastage" type="numeric" required="false" default="0" />
		<cfargument name="TeansferQty" type="numeric" required="false" default="0" />
		<cfargument name="TransferToPlu" type="string" required="false" default="" />
		<cfargument name="ProcessedStockTake" type="boolean" required="false" default="false" />
		<cfscript>
			// run setters
			setID(arguments.ID);
			setStoreID(arguments.StoreID);
			setPartNo(arguments.PartNo);
			setProductid(arguments.productid);
			setLastCost(arguments.LastCost);
			setAverageCost(arguments.AverageCost);
			setRetailPrice(arguments.RetailPrice);
			setMaxRetail(arguments.MaxRetail);
			setQtyOnHand(arguments.QtyOnHand);
			setReorderPoint(arguments.ReorderPoint);
			setMaxShelfQty(arguments.MaxShelfQty);
			setFridayFactor(arguments.FridayFactor);
			setDateEntered(arguments.DateEntered);
			setPrev_QtyOnHand(arguments.Prev_QtyOnHand);
			setFreezer_QtyOnHand(arguments.Freezer_QtyOnHand);
			setCoolRoom_QtyOnHand(arguments.CoolRoom_QtyOnHand);
			setDisplay_QtyOnHand(arguments.Display_QtyOnHand);
			setWastage(arguments.Wastage);
			setTeansferQty(arguments.TeansferQty);
			setTransferToPlu(arguments.TransferToPlu);
			setProcessedStockTake(arguments.ProcessedStockTake);
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

	<cffunction name="setPartNo" access="public" returntype="void" output="false">
		<cfargument name="PartNo" type="string" required="true" />
		<cfset variables.instance.PartNo = arguments.PartNo />
	</cffunction>
	<cffunction name="getPartNo" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PartNo />
	</cffunction>

	<cffunction name="setProductid" access="public" returntype="void" output="false">
		<cfargument name="productid" type="numeric" required="true" />
		<cfset variables.instance.productid = arguments.productid />
	</cffunction>
	<cffunction name="getProductid" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.productid />
	</cffunction>

	<cffunction name="setLastCost" access="public" returntype="void" output="false">
		<cfargument name="LastCost" type="numeric" required="true" />
		<cfset variables.instance.LastCost = arguments.LastCost />
	</cffunction>
	<cffunction name="getLastCost" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.LastCost />
	</cffunction>

	<cffunction name="setAverageCost" access="public" returntype="void" output="false">
		<cfargument name="AverageCost" type="numeric" required="true" />
		<cfset variables.instance.AverageCost = arguments.AverageCost />
	</cffunction>
	<cffunction name="getAverageCost" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.AverageCost />
	</cffunction>

	<cffunction name="setRetailPrice" access="public" returntype="void" output="false">
		<cfargument name="RetailPrice" type="numeric" required="true" />
		<cfset variables.instance.RetailPrice = arguments.RetailPrice />
	</cffunction>
	<cffunction name="getRetailPrice" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.RetailPrice />
	</cffunction>

	<cffunction name="setMaxRetail" access="public" returntype="void" output="false">
		<cfargument name="MaxRetail" type="numeric" required="true" />
		<cfset variables.instance.MaxRetail = arguments.MaxRetail />
	</cffunction>
	<cffunction name="getMaxRetail" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MaxRetail />
	</cffunction>

	<cffunction name="setQtyOnHand" access="public" returntype="void" output="false">
		<cfargument name="QtyOnHand" type="numeric" required="true" />
		<cfset variables.instance.QtyOnHand = arguments.QtyOnHand />
	</cffunction>
	<cffunction name="getQtyOnHand" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.QtyOnHand />
	</cffunction>

	<cffunction name="setReorderPoint" access="public" returntype="void" output="false">
		<cfargument name="ReorderPoint" type="numeric" required="true" />
		<cfset variables.instance.ReorderPoint = arguments.ReorderPoint />
	</cffunction>
	<cffunction name="getReorderPoint" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ReorderPoint />
	</cffunction>

	<cffunction name="setMaxShelfQty" access="public" returntype="void" output="false">
		<cfargument name="MaxShelfQty" type="numeric" required="true" />
		<cfset variables.instance.MaxShelfQty = arguments.MaxShelfQty />
	</cffunction>
	<cffunction name="getMaxShelfQty" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MaxShelfQty />
	</cffunction>

	<cffunction name="setFridayFactor" access="public" returntype="void" output="false">
		<cfargument name="FridayFactor" type="numeric" required="true" />
		<cfset variables.instance.FridayFactor = arguments.FridayFactor />
	</cffunction>
	<cffunction name="getFridayFactor" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.FridayFactor />
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

	<cffunction name="setPrev_QtyOnHand" access="public" returntype="void" output="false">
		<cfargument name="Prev_QtyOnHand" type="numeric" required="true" />
		<cfset variables.instance.Prev_QtyOnHand = arguments.Prev_QtyOnHand />
	</cffunction>
	<cffunction name="getPrev_QtyOnHand" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Prev_QtyOnHand />
	</cffunction>

	<cffunction name="setFreezer_QtyOnHand" access="public" returntype="void" output="false">
		<cfargument name="Freezer_QtyOnHand" type="numeric" required="true" />
		<cfset variables.instance.Freezer_QtyOnHand = arguments.Freezer_QtyOnHand />
	</cffunction>
	<cffunction name="getFreezer_QtyOnHand" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Freezer_QtyOnHand />
	</cffunction>

	<cffunction name="setCoolRoom_QtyOnHand" access="public" returntype="void" output="false">
		<cfargument name="CoolRoom_QtyOnHand" type="numeric" required="true" />
		<cfset variables.instance.CoolRoom_QtyOnHand = arguments.CoolRoom_QtyOnHand />
	</cffunction>
	<cffunction name="getCoolRoom_QtyOnHand" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CoolRoom_QtyOnHand />
	</cffunction>

	<cffunction name="setDisplay_QtyOnHand" access="public" returntype="void" output="false">
		<cfargument name="Display_QtyOnHand" type="numeric" required="true" />
		<cfset variables.instance.Display_QtyOnHand = arguments.Display_QtyOnHand />
	</cffunction>
	<cffunction name="getDisplay_QtyOnHand" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Display_QtyOnHand />
	</cffunction>

	<cffunction name="setWastage" access="public" returntype="void" output="false">
		<cfargument name="Wastage" type="numeric" required="true" />
		<cfset variables.instance.Wastage = arguments.Wastage />
	</cffunction>
	<cffunction name="getWastage" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Wastage />
	</cffunction>

	<cffunction name="setTeansferQty" access="public" returntype="void" output="false">
		<cfargument name="TeansferQty" type="numeric" required="true" />
		<cfset variables.instance.TeansferQty = arguments.TeansferQty />
	</cffunction>
	<cffunction name="getTeansferQty" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.TeansferQty />
	</cffunction>

	<cffunction name="setTransferToPlu" access="public" returntype="void" output="false">
		<cfargument name="TransferToPlu" type="string" required="true" />
		<cfset variables.instance.TransferToPlu = arguments.TransferToPlu />
	</cffunction>
	<cffunction name="getTransferToPlu" access="public" returntype="string" output="false">
		<cfreturn variables.instance.TransferToPlu />
	</cffunction>

	<cffunction name="setProcessedStockTake" access="public" returntype="void" output="false">
		<cfargument name="ProcessedStockTake" type="boolean" required="true" />
		<cfset variables.instance.ProcessedStockTake = arguments.ProcessedStockTake />
	</cffunction>
	<cffunction name="getProcessedStockTake" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.ProcessedStockTake />
	</cffunction>

</cfcomponent>