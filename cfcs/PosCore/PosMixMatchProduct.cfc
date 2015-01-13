<cfcomponent displayname="PosMixMatchProduct" output="false" hint="A bean which models the PosMixMatchProduct record.">

<cfsilent>
<!----
================================================================
Filename: PosMixMatchProduct.cfc
Description: A bean which models the PosMixMatchProduct record.
Author:  Michael Kear, AFP Webworks 
Date: 5/May/2010
================================================================
This bean was generated with the following template:
Bean Name: PosMixMatchProduct
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	PosTXID numeric 0
	MixMatchID numeric 0
	ProductID numeric 0
	ProductCode string 
	Description string 
	ProductQuantity numeric 0
	ProductValue numeric 0
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
	<cffunction name="init" access="public" returntype="PosMixMatchProduct" output="false">
		<cfargument name="PosTXID" type="numeric" required="false" default="0" />
		<cfargument name="MixMatchID" type="numeric" required="false" default="0" />
		<cfargument name="ProductID" type="numeric" required="false" default="0" />
		<cfargument name="ProductCode" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="ProductQuantity" type="numeric" required="false" default="0" />
		<cfargument name="ProductValue" type="numeric" required="false" default="0" />
		<cfscript>
			// run setters
			setPosTXID(arguments.PosTXID);
			setMixMatchID(arguments.MixMatchID);
			setProductID(arguments.ProductID);
			setProductCode(arguments.ProductCode);
			setDescription(arguments.Description);
			setProductQuantity(arguments.ProductQuantity);
			setProductValue(arguments.ProductValue);
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

	<cffunction name="setMixMatchID" access="public" returntype="void" output="false">
		<cfargument name="MixMatchID" type="numeric" required="true" />
		<cfset variables.instance.MixMatchID = arguments.MixMatchID />
	</cffunction>
	<cffunction name="getMixMatchID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MixMatchID />
	</cffunction>

	<cffunction name="setProductID" access="public" returntype="void" output="false">
		<cfargument name="ProductID" type="numeric" required="true" />
		<cfset variables.instance.ProductID = arguments.ProductID />
	</cffunction>
	<cffunction name="getProductID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ProductID />
	</cffunction>

	<cffunction name="setProductCode" access="public" returntype="void" output="false">
		<cfargument name="ProductCode" type="string" required="true" />
		<cfset variables.instance.ProductCode = arguments.ProductCode />
	</cffunction>
	<cffunction name="getProductCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ProductCode />
	</cffunction>

	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance.Description = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>

	<cffunction name="setProductQuantity" access="public" returntype="void" output="false">
		<cfargument name="ProductQuantity" type="numeric" required="true" />
		<cfset variables.instance.ProductQuantity = arguments.ProductQuantity />
	</cffunction>
	<cffunction name="getProductQuantity" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ProductQuantity />
	</cffunction>

	<cffunction name="setProductValue" access="public" returntype="void" output="false">
		<cfargument name="ProductValue" type="numeric" required="true" />
		<cfset variables.instance.ProductValue = arguments.ProductValue />
	</cffunction>
	<cffunction name="getProductValue" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ProductValue />
	</cffunction>

</cfcomponent>