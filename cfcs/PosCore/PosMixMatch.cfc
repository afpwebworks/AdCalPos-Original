<cfcomponent displayname="PosMixMatch" output="false" hint="A bean which models the PosMixMatch record.">

<cfsilent>
<!----
================================================================
Filename: PosMixMatch.cfc
Description: A bean which models the PosMixMatch record.
Author:  Michael Kear, AFP Webworks 
Date: 5/May/2010
================================================================
This bean was generated with the following template:
Bean Name: PosMixMatch
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	PosTXID numeric 0
	MixMatchID numeric 0
	MixMatchDescription string 
	MixMatchTriggerType numeric 0
	MixMatchTriggerValue numeric 0
	MixMatchGiveAwayType numeric 0
	MixMatchGiveAwayValue numeric 0
	MixMatchResetTrigger boolean true
	ProductQuantity numeric 0
	ProductValue numeric 0
	MixMatchTotal numeric 0
	MixMatchQuantity numeric 0
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
	<cffunction name="init" access="public" returntype="PosMixMatch" output="false">
		<cfargument name="PosTXID" type="numeric" required="false" default="0" />
		<cfargument name="MixMatchID" type="numeric" required="false" default="0" />
		<cfargument name="MixMatchDescription" type="string" required="false" default="" />
		<cfargument name="MixMatchTriggerType" type="numeric" required="false" default="0" />
		<cfargument name="MixMatchTriggerValue" type="numeric" required="false" default="0" />
		<cfargument name="MixMatchGiveAwayType" type="numeric" required="false" default="0" />
		<cfargument name="MixMatchGiveAwayValue" type="numeric" required="false" default="0" />
		<cfargument name="MixMatchResetTrigger" type="boolean" required="false" default="true" />
		<cfargument name="ProductQuantity" type="numeric" required="false" default="0" />
		<cfargument name="ProductValue" type="numeric" required="false" default="0" />
		<cfargument name="MixMatchTotal" type="numeric" required="false" default="0" />
		<cfargument name="MixMatchQuantity" type="numeric" required="false" default="0" />
		<cfscript>
			// run setters
			setPosTXID(arguments.PosTXID);
			setMixMatchID(arguments.MixMatchID);
			setMixMatchDescription(arguments.MixMatchDescription);
			setMixMatchTriggerType(arguments.MixMatchTriggerType);
			setMixMatchTriggerValue(arguments.MixMatchTriggerValue);
			setMixMatchGiveAwayType(arguments.MixMatchGiveAwayType);
			setMixMatchGiveAwayValue(arguments.MixMatchGiveAwayValue);
			setMixMatchResetTrigger(arguments.MixMatchResetTrigger);
			setProductQuantity(arguments.ProductQuantity);
			setProductValue(arguments.ProductValue);
			setMixMatchTotal(arguments.MixMatchTotal);
			setMixMatchQuantity(arguments.MixMatchQuantity);
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

	<cffunction name="setMixMatchDescription" access="public" returntype="void" output="false">
		<cfargument name="MixMatchDescription" type="string" required="true" />
		<cfset variables.instance.MixMatchDescription = arguments.MixMatchDescription />
	</cffunction>
	<cffunction name="getMixMatchDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.MixMatchDescription />
	</cffunction>

	<cffunction name="setMixMatchTriggerType" access="public" returntype="void" output="false">
		<cfargument name="MixMatchTriggerType" type="numeric" required="true" />
		<cfset variables.instance.MixMatchTriggerType = arguments.MixMatchTriggerType />
	</cffunction>
	<cffunction name="getMixMatchTriggerType" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MixMatchTriggerType />
	</cffunction>

	<cffunction name="setMixMatchTriggerValue" access="public" returntype="void" output="false">
		<cfargument name="MixMatchTriggerValue" type="numeric" required="true" />
		<cfset variables.instance.MixMatchTriggerValue = arguments.MixMatchTriggerValue />
	</cffunction>
	<cffunction name="getMixMatchTriggerValue" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MixMatchTriggerValue />
	</cffunction>

	<cffunction name="setMixMatchGiveAwayType" access="public" returntype="void" output="false">
		<cfargument name="MixMatchGiveAwayType" type="numeric" required="true" />
		<cfset variables.instance.MixMatchGiveAwayType = arguments.MixMatchGiveAwayType />
	</cffunction>
	<cffunction name="getMixMatchGiveAwayType" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MixMatchGiveAwayType />
	</cffunction>

	<cffunction name="setMixMatchGiveAwayValue" access="public" returntype="void" output="false">
		<cfargument name="MixMatchGiveAwayValue" type="numeric" required="true" />
		<cfset variables.instance.MixMatchGiveAwayValue = arguments.MixMatchGiveAwayValue />
	</cffunction>
	<cffunction name="getMixMatchGiveAwayValue" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MixMatchGiveAwayValue />
	</cffunction>

	<cffunction name="setMixMatchResetTrigger" access="public" returntype="void" output="false">
		<cfargument name="MixMatchResetTrigger" type="boolean" required="true" />
		<cfset variables.instance.MixMatchResetTrigger = arguments.MixMatchResetTrigger />
	</cffunction>
	<cffunction name="getMixMatchResetTrigger" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.MixMatchResetTrigger />
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

	<cffunction name="setMixMatchTotal" access="public" returntype="void" output="false">
		<cfargument name="MixMatchTotal" type="numeric" required="true" />
		<cfset variables.instance.MixMatchTotal = arguments.MixMatchTotal />
	</cffunction>
	<cffunction name="getMixMatchTotal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MixMatchTotal />
	</cffunction>

	<cffunction name="setMixMatchQuantity" access="public" returntype="void" output="false">
		<cfargument name="MixMatchQuantity" type="numeric" required="true" />
		<cfset variables.instance.MixMatchQuantity = arguments.MixMatchQuantity />
	</cffunction>
	<cffunction name="getMixMatchQuantity" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MixMatchQuantity />
	</cffunction>

</cfcomponent>