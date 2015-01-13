<cfcomponent displayname="StockBarcode" output="false" hint="A bean which models the StockBarcode record.">

<cfsilent>
<!----
================================================================
Filename: StockBarcode.cfc
Description: A bean which models the StockBarcode record.
Author:  Michael Kear, AFP Webworks 
Date: 28/Oct/2010
================================================================
This bean was generated with the following template:
Bean Name: StockBarcode
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	StockBarcodeID numeric 0
	Partno string 
	Barcode string 
	DateEntered date #request.austime#
	ProductID numeric 0
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
	<cffunction name="init" access="public" returntype="StockBarcode" output="false">
		<cfargument name="StockBarcodeID" type="numeric" required="false" default="0" />
		<cfargument name="Partno" type="string" required="false" default="" />
		<cfargument name="Barcode" type="string" required="false" default="" />
		<cfargument name="DateEntered" type="string" required="false" default="#request.austime#" />
		<cfargument name="ProductID" type="numeric" required="false" default="0" />
		<cfscript>
			// run setters
			setStockBarcodeID(arguments.StockBarcodeID);
			setPartno(arguments.Partno);
			setBarcode(arguments.Barcode);
			setDateEntered(arguments.DateEntered);
			setProductID(arguments.ProductID);
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
			<!----[ StockBarcodeID ]---->
			<cfif ( getStockBarcodeID() eq whatever )>
				<cfset arguments.eH.setError("StockBarcodeID", "StockBarcodeID This is the error message") />
			</cfif>
			<!----[ Partno ]---->
			<cfif ( getPartno() eq whatever )>
				<cfset arguments.eH.setError("Partno", "Partno This is the error message") />
			</cfif>
			<!----[ Barcode ]---->
			<cfif ( getBarcode() eq whatever )>
				<cfset arguments.eH.setError("Barcode", "Barcode This is the error message") />
			</cfif>
			<!----[ DateEntered ]---->
			<cfif ( getDateEntered() eq whatever )>
				<cfset arguments.eH.setError("DateEntered", "DateEntered This is the error message") />
			</cfif>
			<!----[ ProductID ]---->
			<cfif ( getProductID() eq whatever )>
				<cfset arguments.eH.setError("ProductID", "ProductID This is the error message") />
			</cfif>
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setStockBarcodeID" access="public" returntype="void" output="false">
		<cfargument name="StockBarcodeID" type="numeric" required="true" />
		<cfset variables.instance.StockBarcodeID = arguments.StockBarcodeID />
	</cffunction>
	<cffunction name="getStockBarcodeID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.StockBarcodeID />
	</cffunction>

	<cffunction name="setPartno" access="public" returntype="void" output="false">
		<cfargument name="Partno" type="string" required="true" />
		<cfset variables.instance.Partno = arguments.Partno />
	</cffunction>
	<cffunction name="getPartno" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Partno />
	</cffunction>

	<cffunction name="setBarcode" access="public" returntype="void" output="false">
		<cfargument name="Barcode" type="string" required="true" />
		<cfset variables.instance.Barcode = arguments.Barcode />
	</cffunction>
	<cffunction name="getBarcode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Barcode />
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

	<cffunction name="setProductID" access="public" returntype="void" output="false">
		<cfargument name="ProductID" type="numeric" required="true" />
		<cfset variables.instance.ProductID = arguments.ProductID />
	</cffunction>
	<cffunction name="getProductID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ProductID />
	</cffunction>

</cfcomponent>