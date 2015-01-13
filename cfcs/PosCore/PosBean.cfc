<cfcomponent displayname="PosBean" output="false" hint="A bean which models the PosBean record.">

<cfsilent>
<!----
================================================================
Filename: PosBean.cfc
Description: A bean which models the PosBean record.
Author:  Michael Kear, AFP Webworks 
Date: 13/Apr/2010
================================================================
This bean was generated with the following template:
Bean Name: PosBean
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	PosTXID numeric 0
	PosID numeric 0
	PosType numeric 0
	PosStatus numeric 0
	PosCode string 
	StoreID numeric 1
	TerminalID numeric 1
	LocationID numeric 1
	TableID numeric 0
	PriceID numeric 0
	ClerkID numeric 0
	DrawerID numeric 0
	MemberID numeric 0
	MemberName string 
	DebtorID numeric 0
	DebtorName string 
	CoverQuantity numeric 0
	SeatCount numeric 0
	WalletCount numeric 0
	CostTotal numeric 0
	DiscountTotal numeric 0
	LineTaxTotal numeric 0
	LineSaleTotal numeric 0
	MediaTaxTotal numeric 0
	MediaRoundTotal numeric 0
	MediaChangeTotal numeric 0
	MediaTotal numeric 0
	DueTotal numeric 0
	TaxTotal numeric 0
	SaleTotal numeric 0
	VoidTotal numeric 0
	Timestamp date #request.austime#
	TransDate date #request.austime#
	ItemDiscountTotal numeric 0
	ItemSurchargeTotal numeric 0
	SubTotalDiscount numeric 0
	SubTotalDiscountID numeric 0
	SubTotalDiscountDescription string 
	SubTotalDiscountRate numeric 0
	SubTotalDiscountEntryType numeric 0
	SubTotalSurcharge numeric 0
	SubTotalSurchargeID numeric 0
	SubTotalSurchargeDescription string 
	SubTotalSurchargeRate numeric 0
	SubTotalSurchargeEntryType numeric 0
	Tips numeric 0
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
	<cffunction name="init" access="public" returntype="PosBean" output="false">
		<cfargument name="PosTXID" type="numeric" required="false" default="0" />
		<cfargument name="PosID" type="numeric" required="false" default="0" />
		<cfargument name="PosType" type="numeric" required="false" default="0" />
		<cfargument name="PosStatus" type="numeric" required="false" default="0" />
		<cfargument name="PosCode" type="string" required="false" default="" />
		<cfargument name="StoreID" type="numeric" required="false" default="1" />
		<cfargument name="TerminalID" type="numeric" required="false" default="1" />
		<cfargument name="LocationID" type="numeric" required="false" default="1" />
		<cfargument name="TableID" type="numeric" required="false" default="0" />
		<cfargument name="PriceID" type="numeric" required="false" default="0" />
		<cfargument name="ClerkID" type="numeric" required="false" default="0" />
		<cfargument name="DrawerID" type="numeric" required="false" default="0" />
		<cfargument name="MemberID" type="numeric" required="false" default="0" />
		<cfargument name="MemberName" type="string" required="false" default="" />
		<cfargument name="DebtorID" type="numeric" required="false" default="0" />
		<cfargument name="DebtorName" type="string" required="false" default="" />
		<cfargument name="CoverQuantity" type="numeric" required="false" default="0" />
		<cfargument name="SeatCount" type="numeric" required="false" default="0" />
		<cfargument name="WalletCount" type="numeric" required="false" default="0" />
		<cfargument name="CostTotal" type="numeric" required="false" default="0" />
		<cfargument name="DiscountTotal" type="numeric" required="false" default="0" />
		<cfargument name="LineTaxTotal" type="numeric" required="false" default="0" />
		<cfargument name="LineSaleTotal" type="numeric" required="false" default="0" />
		<cfargument name="MediaTaxTotal" type="numeric" required="false" default="0" />
		<cfargument name="MediaRoundTotal" type="numeric" required="false" default="0" />
		<cfargument name="MediaChangeTotal" type="numeric" required="false" default="0" />
		<cfargument name="MediaTotal" type="numeric" required="false" default="0" />
		<cfargument name="DueTotal" type="numeric" required="false" default="0" />
		<cfargument name="TaxTotal" type="numeric" required="false" default="0" />
		<cfargument name="SaleTotal" type="numeric" required="false" default="0" />
		<cfargument name="VoidTotal" type="numeric" required="false" default="0" />
		<cfargument name="Timestamp" type="string" required="false" default="#request.austime#" />
		<cfargument name="TransDate" type="string" required="false" default="#request.austime#" />
		<cfargument name="ItemDiscountTotal" type="numeric" required="false" default="0" />
		<cfargument name="ItemSurchargeTotal" type="numeric" required="false" default="0" />
		<cfargument name="SubTotalDiscount" type="numeric" required="false" default="0" />
		<cfargument name="SubTotalDiscountID" type="numeric" required="false" default="0" />
		<cfargument name="SubTotalDiscountDescription" type="string" required="false" default="" />
		<cfargument name="SubTotalDiscountRate" type="numeric" required="false" default="0" />
		<cfargument name="SubTotalDiscountEntryType" type="numeric" required="false" default="0" />
		<cfargument name="SubTotalSurcharge" type="numeric" required="false" default="0" />
		<cfargument name="SubTotalSurchargeID" type="numeric" required="false" default="0" />
		<cfargument name="SubTotalSurchargeDescription" type="string" required="false" default="" />
		<cfargument name="SubTotalSurchargeRate" type="numeric" required="false" default="0" />
		<cfargument name="SubTotalSurchargeEntryType" type="numeric" required="false" default="0" />
		<cfargument name="Tips" type="numeric" required="false" default="0" />
		<cfscript>
			// run setters
			setPosTXID(arguments.PosTXID);
			setPosID(arguments.PosID);
			setPosType(arguments.PosType);
			setPosStatus(arguments.PosStatus);
			setPosCode(arguments.PosCode);
			setStoreID(arguments.StoreID);
			setTerminalID(arguments.TerminalID);
			setLocationID(arguments.LocationID);
			setTableID(arguments.TableID);
			setPriceID(arguments.PriceID);
			setClerkID(arguments.ClerkID);
			setDrawerID(arguments.DrawerID);
			setMemberID(arguments.MemberID);
			setMemberName(arguments.MemberName);
			setDebtorID(arguments.DebtorID);
			setDebtorName(arguments.DebtorName);
			setCoverQuantity(arguments.CoverQuantity);
			setSeatCount(arguments.SeatCount);
			setWalletCount(arguments.WalletCount);
			setCostTotal(arguments.CostTotal);
			setDiscountTotal(arguments.DiscountTotal);
			setLineTaxTotal(arguments.LineTaxTotal);
			setLineSaleTotal(arguments.LineSaleTotal);
			setMediaTaxTotal(arguments.MediaTaxTotal);
			setMediaRoundTotal(arguments.MediaRoundTotal);
			setMediaChangeTotal(arguments.MediaChangeTotal);
			setMediaTotal(arguments.MediaTotal);
			setDueTotal(arguments.DueTotal);
			setTaxTotal(arguments.TaxTotal);
			setSaleTotal(arguments.SaleTotal);
			setVoidTotal(arguments.VoidTotal);
			setTimestamp(arguments.Timestamp);
			setTransDate(arguments.TransDate);
			setItemDiscountTotal(arguments.ItemDiscountTotal);
			setItemSurchargeTotal(arguments.ItemSurchargeTotal);
			setSubTotalDiscount(arguments.SubTotalDiscount);
			setSubTotalDiscountID(arguments.SubTotalDiscountID);
			setSubTotalDiscountDescription(arguments.SubTotalDiscountDescription);
			setSubTotalDiscountRate(arguments.SubTotalDiscountRate);
			setSubTotalDiscountEntryType(arguments.SubTotalDiscountEntryType);
			setSubTotalSurcharge(arguments.SubTotalSurcharge);
			setSubTotalSurchargeID(arguments.SubTotalSurchargeID);
			setSubTotalSurchargeDescription(arguments.SubTotalSurchargeDescription);
			setSubTotalSurchargeRate(arguments.SubTotalSurchargeRate);
			setSubTotalSurchargeEntryType(arguments.SubTotalSurchargeEntryType);
			setTips(arguments.Tips);
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
			<!----[ PosTXID ]---->
			<cfif ( getPosTXID() eq whatever )>
				<cfset arguments.eH.setError("PosTXID", "PosTXID This is the error message") />
			</cfif>
			<!----[ PosID ]---->
			<cfif ( getPosID() eq whatever )>
				<cfset arguments.eH.setError("PosID", "PosID This is the error message") />
			</cfif>
			<!----[ PosType ]---->
			<cfif ( getPosType() eq whatever )>
				<cfset arguments.eH.setError("PosType", "PosType This is the error message") />
			</cfif>
			<!----[ PosStatus ]---->
			<cfif ( getPosStatus() eq whatever )>
				<cfset arguments.eH.setError("PosStatus", "PosStatus This is the error message") />
			</cfif>
			<!----[ PosCode ]---->
			<cfif ( getPosCode() eq whatever )>
				<cfset arguments.eH.setError("PosCode", "PosCode This is the error message") />
			</cfif>
			<!----[ StoreID ]---->
			<cfif ( getStoreID() eq whatever )>
				<cfset arguments.eH.setError("StoreID", "StoreID This is the error message") />
			</cfif>
			<!----[ TerminalID ]---->
			<cfif ( getTerminalID() eq whatever )>
				<cfset arguments.eH.setError("TerminalID", "TerminalID This is the error message") />
			</cfif>
			<!----[ LocationID ]---->
			<cfif ( getLocationID() eq whatever )>
				<cfset arguments.eH.setError("LocationID", "LocationID This is the error message") />
			</cfif>
			<!----[ TableID ]---->
			<cfif ( getTableID() eq whatever )>
				<cfset arguments.eH.setError("TableID", "TableID This is the error message") />
			</cfif>
			<!----[ PriceID ]---->
			<cfif ( getPriceID() eq whatever )>
				<cfset arguments.eH.setError("PriceID", "PriceID This is the error message") />
			</cfif>
			<!----[ ClerkID ]---->
			<cfif ( getClerkID() eq whatever )>
				<cfset arguments.eH.setError("ClerkID", "ClerkID This is the error message") />
			</cfif>
			<!----[ DrawerID ]---->
			<cfif ( getDrawerID() eq whatever )>
				<cfset arguments.eH.setError("DrawerID", "DrawerID This is the error message") />
			</cfif>
			<!----[ MemberID ]---->
			<cfif ( getMemberID() eq whatever )>
				<cfset arguments.eH.setError("MemberID", "MemberID This is the error message") />
			</cfif>
			<!----[ MemberName ]---->
			<cfif ( getMemberName() eq whatever )>
				<cfset arguments.eH.setError("MemberName", "MemberName This is the error message") />
			</cfif>
			<!----[ DebtorID ]---->
			<cfif ( getDebtorID() eq whatever )>
				<cfset arguments.eH.setError("DebtorID", "DebtorID This is the error message") />
			</cfif>
			<!----[ DebtorName ]---->
			<cfif ( getDebtorName() eq whatever )>
				<cfset arguments.eH.setError("DebtorName", "DebtorName This is the error message") />
			</cfif>
			<!----[ CoverQuantity ]---->
			<cfif ( getCoverQuantity() eq whatever )>
				<cfset arguments.eH.setError("CoverQuantity", "CoverQuantity This is the error message") />
			</cfif>
			<!----[ SeatCount ]---->
			<cfif ( getSeatCount() eq whatever )>
				<cfset arguments.eH.setError("SeatCount", "SeatCount This is the error message") />
			</cfif>
			<!----[ WalletCount ]---->
			<cfif ( getWalletCount() eq whatever )>
				<cfset arguments.eH.setError("WalletCount", "WalletCount This is the error message") />
			</cfif>
			<!----[ CostTotal ]---->
			<cfif ( getCostTotal() eq whatever )>
				<cfset arguments.eH.setError("CostTotal", "CostTotal This is the error message") />
			</cfif>
			<!----[ DiscountTotal ]---->
			<cfif ( getDiscountTotal() eq whatever )>
				<cfset arguments.eH.setError("DiscountTotal", "DiscountTotal This is the error message") />
			</cfif>
			<!----[ LineTaxTotal ]---->
			<cfif ( getLineTaxTotal() eq whatever )>
				<cfset arguments.eH.setError("LineTaxTotal", "LineTaxTotal This is the error message") />
			</cfif>
			<!----[ LineSaleTotal ]---->
			<cfif ( getLineSaleTotal() eq whatever )>
				<cfset arguments.eH.setError("LineSaleTotal", "LineSaleTotal This is the error message") />
			</cfif>
			<!----[ MediaTaxTotal ]---->
			<cfif ( getMediaTaxTotal() eq whatever )>
				<cfset arguments.eH.setError("MediaTaxTotal", "MediaTaxTotal This is the error message") />
			</cfif>
			<!----[ MediaRoundTotal ]---->
			<cfif ( getMediaRoundTotal() eq whatever )>
				<cfset arguments.eH.setError("MediaRoundTotal", "MediaRoundTotal This is the error message") />
			</cfif>
			<!----[ MediaChangeTotal ]---->
			<cfif ( getMediaChangeTotal() eq whatever )>
				<cfset arguments.eH.setError("MediaChangeTotal", "MediaChangeTotal This is the error message") />
			</cfif>
			<!----[ MediaTotal ]---->
			<cfif ( getMediaTotal() eq whatever )>
				<cfset arguments.eH.setError("MediaTotal", "MediaTotal This is the error message") />
			</cfif>
			<!----[ DueTotal ]---->
			<cfif ( getDueTotal() eq whatever )>
				<cfset arguments.eH.setError("DueTotal", "DueTotal This is the error message") />
			</cfif>
			<!----[ TaxTotal ]---->
			<cfif ( getTaxTotal() eq whatever )>
				<cfset arguments.eH.setError("TaxTotal", "TaxTotal This is the error message") />
			</cfif>
			<!----[ SaleTotal ]---->
			<cfif ( getSaleTotal() eq whatever )>
				<cfset arguments.eH.setError("SaleTotal", "SaleTotal This is the error message") />
			</cfif>
			<!----[ VoidTotal ]---->
			<cfif ( getVoidTotal() eq whatever )>
				<cfset arguments.eH.setError("VoidTotal", "VoidTotal This is the error message") />
			</cfif>
			<!----[ Timestamp ]---->
			<cfif ( getTimestamp() eq whatever )>
				<cfset arguments.eH.setError("Timestamp", "Timestamp This is the error message") />
			</cfif>
			<!----[ TransDate ]---->
			<cfif ( getTransDate() eq whatever )>
				<cfset arguments.eH.setError("TransDate", "TransDate This is the error message") />
			</cfif>
			<!----[ ItemDiscountTotal ]---->
			<cfif ( getItemDiscountTotal() eq whatever )>
				<cfset arguments.eH.setError("ItemDiscountTotal", "ItemDiscountTotal This is the error message") />
			</cfif>
			<!----[ ItemSurchargeTotal ]---->
			<cfif ( getItemSurchargeTotal() eq whatever )>
				<cfset arguments.eH.setError("ItemSurchargeTotal", "ItemSurchargeTotal This is the error message") />
			</cfif>
			<!----[ SubTotalDiscount ]---->
			<cfif ( getSubTotalDiscount() eq whatever )>
				<cfset arguments.eH.setError("SubTotalDiscount", "SubTotalDiscount This is the error message") />
			</cfif>
			<!----[ SubTotalDiscountID ]---->
			<cfif ( getSubTotalDiscountID() eq whatever )>
				<cfset arguments.eH.setError("SubTotalDiscountID", "SubTotalDiscountID This is the error message") />
			</cfif>
			<!----[ SubTotalDiscountDescription ]---->
			<cfif ( getSubTotalDiscountDescription() eq whatever )>
				<cfset arguments.eH.setError("SubTotalDiscountDescription", "SubTotalDiscountDescription This is the error message") />
			</cfif>
			<!----[ SubTotalDiscountRate ]---->
			<cfif ( getSubTotalDiscountRate() eq whatever )>
				<cfset arguments.eH.setError("SubTotalDiscountRate", "SubTotalDiscountRate This is the error message") />
			</cfif>
			<!----[ SubTotalDiscountEntryType ]---->
			<cfif ( getSubTotalDiscountEntryType() eq whatever )>
				<cfset arguments.eH.setError("SubTotalDiscountEntryType", "SubTotalDiscountEntryType This is the error message") />
			</cfif>
			<!----[ SubTotalSurcharge ]---->
			<cfif ( getSubTotalSurcharge() eq whatever )>
				<cfset arguments.eH.setError("SubTotalSurcharge", "SubTotalSurcharge This is the error message") />
			</cfif>
			<!----[ SubTotalSurchargeID ]---->
			<cfif ( getSubTotalSurchargeID() eq whatever )>
				<cfset arguments.eH.setError("SubTotalSurchargeID", "SubTotalSurchargeID This is the error message") />
			</cfif>
			<!----[ SubTotalSurchargeDescription ]---->
			<cfif ( getSubTotalSurchargeDescription() eq whatever )>
				<cfset arguments.eH.setError("SubTotalSurchargeDescription", "SubTotalSurchargeDescription This is the error message") />
			</cfif>
			<!----[ SubTotalSurchargeRate ]---->
			<cfif ( getSubTotalSurchargeRate() eq whatever )>
				<cfset arguments.eH.setError("SubTotalSurchargeRate", "SubTotalSurchargeRate This is the error message") />
			</cfif>
			<!----[ SubTotalSurchargeEntryType ]---->
			<cfif ( getSubTotalSurchargeEntryType() eq whatever )>
				<cfset arguments.eH.setError("SubTotalSurchargeEntryType", "SubTotalSurchargeEntryType This is the error message") />
			</cfif>
			<!----[ Tips ]---->
			<cfif ( getTips() eq whatever )>
				<cfset arguments.eH.setError("Tips", "Tips This is the error message") />
			</cfif>
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setPosTXID" access="public" returntype="void" output="false">
		<cfargument name="PosTXID" type="numeric" required="true" />
		<cfset variables.instance.PosTXID = arguments.PosTXID />
	</cffunction>
	<cffunction name="getPosTXID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PosTXID />
	</cffunction>

	<cffunction name="setPosID" access="public" returntype="void" output="false">
		<cfargument name="PosID" type="numeric" required="true" />
		<cfset variables.instance.PosID = arguments.PosID />
	</cffunction>
	<cffunction name="getPosID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PosID />
	</cffunction>

	<cffunction name="setPosType" access="public" returntype="void" output="false">
		<cfargument name="PosType" type="numeric" required="true" />
		<cfset variables.instance.PosType = arguments.PosType />
	</cffunction>
	<cffunction name="getPosType" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PosType />
	</cffunction>

	<cffunction name="setPosStatus" access="public" returntype="void" output="false">
		<cfargument name="PosStatus" type="numeric" required="true" />
		<cfset variables.instance.PosStatus = arguments.PosStatus />
	</cffunction>
	<cffunction name="getPosStatus" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PosStatus />
	</cffunction>

	<cffunction name="setPosCode" access="public" returntype="void" output="false">
		<cfargument name="PosCode" type="string" required="true" />
		<cfset variables.instance.PosCode = arguments.PosCode />
	</cffunction>
	<cffunction name="getPosCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PosCode />
	</cffunction>

	<cffunction name="setStoreID" access="public" returntype="void" output="false">
		<cfargument name="StoreID" type="numeric" required="true" />
		<cfset variables.instance.StoreID = arguments.StoreID />
	</cffunction>
	<cffunction name="getStoreID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.StoreID />
	</cffunction>

	<cffunction name="setTerminalID" access="public" returntype="void" output="false">
		<cfargument name="TerminalID" type="numeric" required="true" />
		<cfset variables.instance.TerminalID = arguments.TerminalID />
	</cffunction>
	<cffunction name="getTerminalID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.TerminalID />
	</cffunction>

	<cffunction name="setLocationID" access="public" returntype="void" output="false">
		<cfargument name="LocationID" type="numeric" required="true" />
		<cfset variables.instance.LocationID = arguments.LocationID />
	</cffunction>
	<cffunction name="getLocationID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.LocationID />
	</cffunction>

	<cffunction name="setTableID" access="public" returntype="void" output="false">
		<cfargument name="TableID" type="numeric" required="true" />
		<cfset variables.instance.TableID = arguments.TableID />
	</cffunction>
	<cffunction name="getTableID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.TableID />
	</cffunction>

	<cffunction name="setPriceID" access="public" returntype="void" output="false">
		<cfargument name="PriceID" type="numeric" required="true" />
		<cfset variables.instance.PriceID = arguments.PriceID />
	</cffunction>
	<cffunction name="getPriceID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PriceID />
	</cffunction>

	<cffunction name="setClerkID" access="public" returntype="void" output="false">
		<cfargument name="ClerkID" type="numeric" required="true" />
		<cfset variables.instance.ClerkID = arguments.ClerkID />
	</cffunction>
	<cffunction name="getClerkID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ClerkID />
	</cffunction>

	<cffunction name="setDrawerID" access="public" returntype="void" output="false">
		<cfargument name="DrawerID" type="numeric" required="true" />
		<cfset variables.instance.DrawerID = arguments.DrawerID />
	</cffunction>
	<cffunction name="getDrawerID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.DrawerID />
	</cffunction>

	<cffunction name="setMemberID" access="public" returntype="void" output="false">
		<cfargument name="MemberID" type="numeric" required="true" />
		<cfset variables.instance.MemberID = arguments.MemberID />
	</cffunction>
	<cffunction name="getMemberID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MemberID />
	</cffunction>

	<cffunction name="setMemberName" access="public" returntype="void" output="false">
		<cfargument name="MemberName" type="string" required="true" />
		<cfset variables.instance.MemberName = arguments.MemberName />
	</cffunction>
	<cffunction name="getMemberName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.MemberName />
	</cffunction>

	<cffunction name="setDebtorID" access="public" returntype="void" output="false">
		<cfargument name="DebtorID" type="numeric" required="true" />
		<cfset variables.instance.DebtorID = arguments.DebtorID />
	</cffunction>
	<cffunction name="getDebtorID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.DebtorID />
	</cffunction>

	<cffunction name="setDebtorName" access="public" returntype="void" output="false">
		<cfargument name="DebtorName" type="string" required="true" />
		<cfset variables.instance.DebtorName = arguments.DebtorName />
	</cffunction>
	<cffunction name="getDebtorName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DebtorName />
	</cffunction>

	<cffunction name="setCoverQuantity" access="public" returntype="void" output="false">
		<cfargument name="CoverQuantity" type="numeric" required="true" />
		<cfset variables.instance.CoverQuantity = arguments.CoverQuantity />
	</cffunction>
	<cffunction name="getCoverQuantity" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CoverQuantity />
	</cffunction>

	<cffunction name="setSeatCount" access="public" returntype="void" output="false">
		<cfargument name="SeatCount" type="numeric" required="true" />
		<cfset variables.instance.SeatCount = arguments.SeatCount />
	</cffunction>
	<cffunction name="getSeatCount" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SeatCount />
	</cffunction>

	<cffunction name="setWalletCount" access="public" returntype="void" output="false">
		<cfargument name="WalletCount" type="numeric" required="true" />
		<cfset variables.instance.WalletCount = arguments.WalletCount />
	</cffunction>
	<cffunction name="getWalletCount" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.WalletCount />
	</cffunction>

	<cffunction name="setCostTotal" access="public" returntype="void" output="false">
		<cfargument name="CostTotal" type="numeric" required="true" />
		<cfset variables.instance.CostTotal = arguments.CostTotal />
	</cffunction>
	<cffunction name="getCostTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CostTotal />
	</cffunction>

	<cffunction name="setDiscountTotal" access="public" returntype="void" output="false">
		<cfargument name="DiscountTotal" type="numeric" required="true" />
		<cfset variables.instance.DiscountTotal = arguments.DiscountTotal />
	</cffunction>
	<cffunction name="getDiscountTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.DiscountTotal />
	</cffunction>

	<cffunction name="setLineTaxTotal" access="public" returntype="void" output="false">
		<cfargument name="LineTaxTotal" type="numeric" required="true" />
		<cfset variables.instance.LineTaxTotal = arguments.LineTaxTotal />
	</cffunction>
	<cffunction name="getLineTaxTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.LineTaxTotal />
	</cffunction>

	<cffunction name="setLineSaleTotal" access="public" returntype="void" output="false">
		<cfargument name="LineSaleTotal" type="numeric" required="true" />
		<cfset variables.instance.LineSaleTotal = arguments.LineSaleTotal />
	</cffunction>
	<cffunction name="getLineSaleTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.LineSaleTotal />
	</cffunction>

	<cffunction name="setMediaTaxTotal" access="public" returntype="void" output="false">
		<cfargument name="MediaTaxTotal" type="numeric" required="true" />
		<cfset variables.instance.MediaTaxTotal = arguments.MediaTaxTotal />
	</cffunction>
	<cffunction name="getMediaTaxTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MediaTaxTotal />
	</cffunction>

	<cffunction name="setMediaRoundTotal" access="public" returntype="void" output="false">
		<cfargument name="MediaRoundTotal" type="numeric" required="true" />
		<cfset variables.instance.MediaRoundTotal = arguments.MediaRoundTotal />
	</cffunction>
	<cffunction name="getMediaRoundTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MediaRoundTotal />
	</cffunction>

	<cffunction name="setMediaChangeTotal" access="public" returntype="void" output="false">
		<cfargument name="MediaChangeTotal" type="numeric" required="true" />
		<cfset variables.instance.MediaChangeTotal = arguments.MediaChangeTotal />
	</cffunction>
	<cffunction name="getMediaChangeTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MediaChangeTotal />
	</cffunction>

	<cffunction name="setMediaTotal" access="public" returntype="void" output="false">
		<cfargument name="MediaTotal" type="numeric" required="true" />
		<cfset variables.instance.MediaTotal = arguments.MediaTotal />
	</cffunction>
	<cffunction name="getMediaTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MediaTotal />
	</cffunction>

	<cffunction name="setDueTotal" access="public" returntype="void" output="false">
		<cfargument name="DueTotal" type="numeric" required="true" />
		<cfset variables.instance.DueTotal = arguments.DueTotal />
	</cffunction>
	<cffunction name="getDueTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.DueTotal />
	</cffunction>

	<cffunction name="setTaxTotal" access="public" returntype="void" output="false">
		<cfargument name="TaxTotal" type="numeric" required="true" />
		<cfset variables.instance.TaxTotal = arguments.TaxTotal />
	</cffunction>
	<cffunction name="getTaxTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.TaxTotal />
	</cffunction>

	<cffunction name="setSaleTotal" access="public" returntype="void" output="false">
		<cfargument name="SaleTotal" type="numeric" required="true" />
		<cfset variables.instance.SaleTotal = arguments.SaleTotal />
	</cffunction>
	<cffunction name="getSaleTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SaleTotal />
	</cffunction>

	<cffunction name="setVoidTotal" access="public" returntype="void" output="false">
		<cfargument name="VoidTotal" type="numeric" required="true" />
		<cfset variables.instance.VoidTotal = arguments.VoidTotal />
	</cffunction>
	<cffunction name="getVoidTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.VoidTotal />
	</cffunction>

	<cffunction name="setTimestamp" access="public" returntype="void" output="false">
		<cfargument name="Timestamp" type="date" required="true" />
		<!---[   <cfif isDate(arguments.Timestamp)>
			<cfset arguments.Timestamp = dateformat(arguments.Timestamp,"DD/MM/YYYY") />
		</cfif>   ]---->
		<cfset variables.instance.Timestamp = arguments.Timestamp />
	</cffunction>
	<cffunction name="getTimestamp" access="public" returntype="date" output="false">
		<cfreturn variables.instance.Timestamp />
	</cffunction>

	<cffunction name="setTransDate" access="public" returntype="void" output="false">
		<cfargument name="TransDate" type="date" required="true" />
		<!---[   <cfif isDate(arguments.TransDate)>
			<cfset arguments.TransDate = dateformat(arguments.TransDate,"DD/MM/YYYY") />
		</cfif>   ]---->
		<cfset variables.instance.TransDate = arguments.TransDate />
	</cffunction>
	<cffunction name="getTransDate" access="public" returntype="date" output="false">
		<cfreturn variables.instance.TransDate />
	</cffunction>

	<cffunction name="setItemDiscountTotal" access="public" returntype="void" output="false">
		<cfargument name="ItemDiscountTotal" type="numeric" required="true" />
		<cfset variables.instance.ItemDiscountTotal = arguments.ItemDiscountTotal />
	</cffunction>
	<cffunction name="getItemDiscountTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ItemDiscountTotal />
	</cffunction>

	<cffunction name="setItemSurchargeTotal" access="public" returntype="void" output="false">
		<cfargument name="ItemSurchargeTotal" type="numeric" required="true" />
		<cfset variables.instance.ItemSurchargeTotal = arguments.ItemSurchargeTotal />
	</cffunction>
	<cffunction name="getItemSurchargeTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ItemSurchargeTotal />
	</cffunction>

	<cffunction name="setSubTotalDiscount" access="public" returntype="void" output="false">
		<cfargument name="SubTotalDiscount" type="numeric" required="true" />
		<cfset variables.instance.SubTotalDiscount = arguments.SubTotalDiscount />
	</cffunction>
	<cffunction name="getSubTotalDiscount" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SubTotalDiscount />
	</cffunction>

	<cffunction name="setSubTotalDiscountID" access="public" returntype="void" output="false">
		<cfargument name="SubTotalDiscountID" type="numeric" required="true" />
		<cfset variables.instance.SubTotalDiscountID = arguments.SubTotalDiscountID />
	</cffunction>
	<cffunction name="getSubTotalDiscountID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SubTotalDiscountID />
	</cffunction>

	<cffunction name="setSubTotalDiscountDescription" access="public" returntype="void" output="false">
		<cfargument name="SubTotalDiscountDescription" type="string" required="true" />
		<cfset variables.instance.SubTotalDiscountDescription = arguments.SubTotalDiscountDescription />
	</cffunction>
	<cffunction name="getSubTotalDiscountDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SubTotalDiscountDescription />
	</cffunction>

	<cffunction name="setSubTotalDiscountRate" access="public" returntype="void" output="false">
		<cfargument name="SubTotalDiscountRate" type="numeric" required="true" />
		<cfset variables.instance.SubTotalDiscountRate = arguments.SubTotalDiscountRate />
	</cffunction>
	<cffunction name="getSubTotalDiscountRate" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SubTotalDiscountRate />
	</cffunction>

	<cffunction name="setSubTotalDiscountEntryType" access="public" returntype="void" output="false">
		<cfargument name="SubTotalDiscountEntryType" type="numeric" required="true" />
		<cfset variables.instance.SubTotalDiscountEntryType = arguments.SubTotalDiscountEntryType />
	</cffunction>
	<cffunction name="getSubTotalDiscountEntryType" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SubTotalDiscountEntryType />
	</cffunction>

	<cffunction name="setSubTotalSurcharge" access="public" returntype="void" output="false">
		<cfargument name="SubTotalSurcharge" type="numeric" required="true" />
		<cfset variables.instance.SubTotalSurcharge = arguments.SubTotalSurcharge />
	</cffunction>
	<cffunction name="getSubTotalSurcharge" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SubTotalSurcharge />
	</cffunction>

	<cffunction name="setSubTotalSurchargeID" access="public" returntype="void" output="false">
		<cfargument name="SubTotalSurchargeID" type="numeric" required="true" />
		<cfset variables.instance.SubTotalSurchargeID = arguments.SubTotalSurchargeID />
	</cffunction>
	<cffunction name="getSubTotalSurchargeID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SubTotalSurchargeID />
	</cffunction>

	<cffunction name="setSubTotalSurchargeDescription" access="public" returntype="void" output="false">
		<cfargument name="SubTotalSurchargeDescription" type="string" required="true" />
		<cfset variables.instance.SubTotalSurchargeDescription = arguments.SubTotalSurchargeDescription />
	</cffunction>
	<cffunction name="getSubTotalSurchargeDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SubTotalSurchargeDescription />
	</cffunction>

	<cffunction name="setSubTotalSurchargeRate" access="public" returntype="void" output="false">
		<cfargument name="SubTotalSurchargeRate" type="numeric" required="true" />
		<cfset variables.instance.SubTotalSurchargeRate = arguments.SubTotalSurchargeRate />
	</cffunction>
	<cffunction name="getSubTotalSurchargeRate" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SubTotalSurchargeRate />
	</cffunction>

	<cffunction name="setSubTotalSurchargeEntryType" access="public" returntype="void" output="false">
		<cfargument name="SubTotalSurchargeEntryType" type="numeric" required="true" />
		<cfset variables.instance.SubTotalSurchargeEntryType = arguments.SubTotalSurchargeEntryType />
	</cffunction>
	<cffunction name="getSubTotalSurchargeEntryType" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SubTotalSurchargeEntryType />
	</cffunction>

	<cffunction name="setTips" access="public" returntype="void" output="false">
		<cfargument name="Tips" type="numeric" required="true" />
		<cfset variables.instance.Tips = arguments.Tips />
	</cffunction>
	<cffunction name="getTips" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Tips />
	</cffunction>

</cfcomponent>