<cfcomponent displayname="StoreBean" output="false" hint="A bean which models the StoreBean record.">

<cfsilent>
<!----
================================================================
Filename: StoreBean.cfc
Description: A bean which models the StoreBean record.
Author:  Michael Kear, AFP Webworks 
Date: 5/Jan/2011
================================================================
This bean was generated with the following template:
Bean Name: StoreBean
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	StoreID numeric 0
	StoreName string 
	Manager1Name string 
	Manager2Name string 
	StoreGroupID numeric 0
	StoreGroup string 
	Phone string 
	Fax string 
	Mobile string 
	email string 
	AcctBalance numeric 0
	CreditLimit numeric 0
	NoLongerUsed boolean false
	FridayFactor numeric 1
	DateEntered string 
	ChainID numeric 1
	ABN string 
	Address string 
	Suburb string 
	State string 
	PostCode string 
	StartingStockEntered boolean false
	StoreMail string 
	SecurityCode string 
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
	<cffunction name="init" access="public" returntype="StoreBean" output="false">
		<cfargument name="StoreID" type="numeric" required="false" default="0" />
		<cfargument name="StoreName" type="string" required="false" default="" />
		<cfargument name="Manager1Name" type="string" required="false" default="" />
		<cfargument name="Manager2Name" type="string" required="false" default="" />
		<cfargument name="StoreGroupID" type="numeric" required="false" default="0" />
		<cfargument name="StoreGroup" type="string" required="false" default="" />
		<cfargument name="Phone" type="string" required="false" default="" />
		<cfargument name="Fax" type="string" required="false" default="" />
		<cfargument name="Mobile" type="string" required="false" default="" />
		<cfargument name="email" type="string" required="false" default="" />
		<cfargument name="AcctBalance" type="numeric" required="false" default="0" />
		<cfargument name="CreditLimit" type="numeric" required="false" default="0" />
		<cfargument name="NoLongerUsed" type="boolean" required="false" default="false" />
		<cfargument name="FridayFactor" type="numeric" required="false" default="1" />
		<cfargument name="DateEntered" type="string" required="false" default="" />
		<cfargument name="ChainID" type="numeric" required="false" default="1" />
		<cfargument name="ABN" type="string" required="false" default="" />
		<cfargument name="Address" type="string" required="false" default="" />
		<cfargument name="Suburb" type="string" required="false" default="" />
		<cfargument name="State" type="string" required="false" default="" />
		<cfargument name="PostCode" type="string" required="false" default="" />
		<cfargument name="StartingStockEntered" type="boolean" required="false" default="false" />
		<cfargument name="StoreMail" type="string" required="false" default="" />
		<cfargument name="SecurityCode" type="string" required="false" default="" />
		<cfscript>
			// run setters
			setStoreID(arguments.StoreID);
			setStoreName(arguments.StoreName);
			setManager1Name(arguments.Manager1Name);
			setManager2Name(arguments.Manager2Name);
			setStoreGroupID(arguments.StoreGroupID);
			setStoreGroup(arguments.StoreGroup);
			setPhone(arguments.Phone);
			setFax(arguments.Fax);
			setMobile(arguments.Mobile);
			setEmail(arguments.email);
			setAcctBalance(arguments.AcctBalance);
			setCreditLimit(arguments.CreditLimit);
			setNoLongerUsed(arguments.NoLongerUsed);
			setFridayFactor(arguments.FridayFactor);
			setDateEntered(arguments.DateEntered);
			setChainID(arguments.ChainID);
			setABN(arguments.ABN);
			setAddress(arguments.Address);
			setSuburb(arguments.Suburb);
			setState(arguments.State);
			setPostCode(arguments.PostCode);
			setStartingStockEntered(arguments.StartingStockEntered);
			setStoreMail(arguments.StoreMail);
			setSecurityCode(arguments.SecurityCode);
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
			<!----[ StoreID ]---->
			<cfif ( getStoreID() eq whatever )>
				<cfset arguments.eH.setError("StoreID", "StoreID This is the error message") />
			</cfif>
			<!----[ StoreName ]---->
			<cfif ( getStoreName() eq whatever )>
				<cfset arguments.eH.setError("StoreName", "StoreName This is the error message") />
			</cfif>
			<!----[ Manager1Name ]---->
			<cfif ( getManager1Name() eq whatever )>
				<cfset arguments.eH.setError("Manager1Name", "Manager1Name This is the error message") />
			</cfif>
			<!----[ Manager2Name ]---->
			<cfif ( getManager2Name() eq whatever )>
				<cfset arguments.eH.setError("Manager2Name", "Manager2Name This is the error message") />
			</cfif>
			<!----[ StoreGroupID ]---->
			<cfif ( getStoreGroupID() eq whatever )>
				<cfset arguments.eH.setError("StoreGroupID", "StoreGroupID This is the error message") />
			</cfif>
			<!----[ StoreGroup ]---->
			<cfif ( getStoreGroup() eq whatever )>
				<cfset arguments.eH.setError("StoreGroup", "StoreGroup This is the error message") />
			</cfif>
			<!----[ Phone ]---->
			<cfif ( getPhone() eq whatever )>
				<cfset arguments.eH.setError("Phone", "Phone This is the error message") />
			</cfif>
			<!----[ Fax ]---->
			<cfif ( getFax() eq whatever )>
				<cfset arguments.eH.setError("Fax", "Fax This is the error message") />
			</cfif>
			<!----[ Mobile ]---->
			<cfif ( getMobile() eq whatever )>
				<cfset arguments.eH.setError("Mobile", "Mobile This is the error message") />
			</cfif>
			<!----[ email ]---->
			<cfif ( getEmail() eq whatever )>
				<cfset arguments.eH.setError("email", "email This is the error message") />
			</cfif>
			<!----[ AcctBalance ]---->
			<cfif ( getAcctBalance() eq whatever )>
				<cfset arguments.eH.setError("AcctBalance", "AcctBalance This is the error message") />
			</cfif>
			<!----[ CreditLimit ]---->
			<cfif ( getCreditLimit() eq whatever )>
				<cfset arguments.eH.setError("CreditLimit", "CreditLimit This is the error message") />
			</cfif>
			<!----[ NoLongerUsed ]---->
			<cfif ( getNoLongerUsed() eq whatever )>
				<cfset arguments.eH.setError("NoLongerUsed", "NoLongerUsed This is the error message") />
			</cfif>
			<!----[ FridayFactor ]---->
			<cfif ( getFridayFactor() eq whatever )>
				<cfset arguments.eH.setError("FridayFactor", "FridayFactor This is the error message") />
			</cfif>
			<!----[ DateEntered ]---->
			<cfif ( getDateEntered() eq whatever )>
				<cfset arguments.eH.setError("DateEntered", "DateEntered This is the error message") />
			</cfif>
			<!----[ ChainID ]---->
			<cfif ( getChainID() eq whatever )>
				<cfset arguments.eH.setError("ChainID", "ChainID This is the error message") />
			</cfif>
			<!----[ ABN ]---->
			<cfif ( getABN() eq whatever )>
				<cfset arguments.eH.setError("ABN", "ABN This is the error message") />
			</cfif>
			<!----[ Address ]---->
			<cfif ( getAddress() eq whatever )>
				<cfset arguments.eH.setError("Address", "Address This is the error message") />
			</cfif>
			<!----[ Suburb ]---->
			<cfif ( getSuburb() eq whatever )>
				<cfset arguments.eH.setError("Suburb", "Suburb This is the error message") />
			</cfif>
			<!----[ State ]---->
			<cfif ( getState() eq whatever )>
				<cfset arguments.eH.setError("State", "State This is the error message") />
			</cfif>
			<!----[ PostCode ]---->
			<cfif ( getPostCode() eq whatever )>
				<cfset arguments.eH.setError("PostCode", "PostCode This is the error message") />
			</cfif>
			<!----[ StartingStockEntered ]---->
			<cfif ( getStartingStockEntered() eq whatever )>
				<cfset arguments.eH.setError("StartingStockEntered", "StartingStockEntered This is the error message") />
			</cfif>
			<!----[ StoreMail ]---->
			<cfif ( getStoreMail() eq whatever )>
				<cfset arguments.eH.setError("StoreMail", "StoreMail This is the error message") />
			</cfif>
			<!----[ SecurityCode ]---->
			<cfif ( getSecurityCode() eq whatever )>
				<cfset arguments.eH.setError("SecurityCode", "SecurityCode This is the error message") />
			</cfif>
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setStoreID" access="public" returntype="void" output="false">
		<cfargument name="StoreID" type="numeric" required="true" />
		<cfset variables.instance.StoreID = arguments.StoreID />
	</cffunction>
	<cffunction name="getStoreID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.StoreID />
	</cffunction>

	<cffunction name="setStoreName" access="public" returntype="void" output="false">
		<cfargument name="StoreName" type="string" required="true" />
		<cfset variables.instance.StoreName = arguments.StoreName />
	</cffunction>
	<cffunction name="getStoreName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.StoreName />
	</cffunction>

	<cffunction name="setManager1Name" access="public" returntype="void" output="false">
		<cfargument name="Manager1Name" type="string" required="true" />
		<cfset variables.instance.Manager1Name = arguments.Manager1Name />
	</cffunction>
	<cffunction name="getManager1Name" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Manager1Name />
	</cffunction>

	<cffunction name="setManager2Name" access="public" returntype="void" output="false">
		<cfargument name="Manager2Name" type="string" required="true" />
		<cfset variables.instance.Manager2Name = arguments.Manager2Name />
	</cffunction>
	<cffunction name="getManager2Name" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Manager2Name />
	</cffunction>

	<cffunction name="setStoreGroupID" access="public" returntype="void" output="false">
		<cfargument name="StoreGroupID" type="numeric" required="true" />
		<cfset variables.instance.StoreGroupID = arguments.StoreGroupID />
	</cffunction>
	<cffunction name="getStoreGroupID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.StoreGroupID />
	</cffunction>

	<cffunction name="setStoreGroup" access="public" returntype="void" output="false">
		<cfargument name="StoreGroup" type="string" required="true" />
		<cfset variables.instance.StoreGroup = arguments.StoreGroup />
	</cffunction>
	<cffunction name="getStoreGroup" access="public" returntype="string" output="false">
		<cfreturn variables.instance.StoreGroup />
	</cffunction>

	<cffunction name="setPhone" access="public" returntype="void" output="false">
		<cfargument name="Phone" type="string" required="true" />
		<cfset variables.instance.Phone = arguments.Phone />
	</cffunction>
	<cffunction name="getPhone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Phone />
	</cffunction>

	<cffunction name="setFax" access="public" returntype="void" output="false">
		<cfargument name="Fax" type="string" required="true" />
		<cfset variables.instance.Fax = arguments.Fax />
	</cffunction>
	<cffunction name="getFax" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Fax />
	</cffunction>

	<cffunction name="setMobile" access="public" returntype="void" output="false">
		<cfargument name="Mobile" type="string" required="true" />
		<cfset variables.instance.Mobile = arguments.Mobile />
	</cffunction>
	<cffunction name="getMobile" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Mobile />
	</cffunction>

	<cffunction name="setEmail" access="public" returntype="void" output="false">
		<cfargument name="email" type="string" required="true" />
		<cfset variables.instance.email = arguments.email />
	</cffunction>
	<cffunction name="getEmail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.email />
	</cffunction>

	<cffunction name="setAcctBalance" access="public" returntype="void" output="false">
		<cfargument name="AcctBalance" type="numeric" required="true" />
		<cfset variables.instance.AcctBalance = arguments.AcctBalance />
	</cffunction>
	<cffunction name="getAcctBalance" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.AcctBalance />
	</cffunction>

	<cffunction name="setCreditLimit" access="public" returntype="void" output="false">
		<cfargument name="CreditLimit" type="numeric" required="true" />
		<cfset variables.instance.CreditLimit = arguments.CreditLimit />
	</cffunction>
	<cffunction name="getCreditLimit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CreditLimit />
	</cffunction>

	<cffunction name="setNoLongerUsed" access="public" returntype="void" output="false">
		<cfargument name="NoLongerUsed" type="boolean" required="true" />
		<cfset variables.instance.NoLongerUsed = arguments.NoLongerUsed />
	</cffunction>
	<cffunction name="getNoLongerUsed" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.NoLongerUsed />
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
		<cfset variables.instance.DateEntered = arguments.DateEntered />
	</cffunction>
	<cffunction name="getDateEntered" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateEntered />
	</cffunction>

	<cffunction name="setChainID" access="public" returntype="void" output="false">
		<cfargument name="ChainID" type="numeric" required="true" />
		<cfset variables.instance.ChainID = arguments.ChainID />
	</cffunction>
	<cffunction name="getChainID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ChainID />
	</cffunction>

	<cffunction name="setABN" access="public" returntype="void" output="false">
		<cfargument name="ABN" type="string" required="true" />
		<cfset variables.instance.ABN = arguments.ABN />
	</cffunction>
	<cffunction name="getABN" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ABN />
	</cffunction>

	<cffunction name="setAddress" access="public" returntype="void" output="false">
		<cfargument name="Address" type="string" required="true" />
		<cfset variables.instance.Address = arguments.Address />
	</cffunction>
	<cffunction name="getAddress" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Address />
	</cffunction>

	<cffunction name="setSuburb" access="public" returntype="void" output="false">
		<cfargument name="Suburb" type="string" required="true" />
		<cfset variables.instance.Suburb = arguments.Suburb />
	</cffunction>
	<cffunction name="getSuburb" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Suburb />
	</cffunction>

	<cffunction name="setState" access="public" returntype="void" output="false">
		<cfargument name="State" type="string" required="true" />
		<cfset variables.instance.State = arguments.State />
	</cffunction>
	<cffunction name="getState" access="public" returntype="string" output="false">
		<cfreturn variables.instance.State />
	</cffunction>

	<cffunction name="setPostCode" access="public" returntype="void" output="false">
		<cfargument name="PostCode" type="string" required="true" />
		<cfset variables.instance.PostCode = arguments.PostCode />
	</cffunction>
	<cffunction name="getPostCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PostCode />
	</cffunction>

	<cffunction name="setStartingStockEntered" access="public" returntype="void" output="false">
		<cfargument name="StartingStockEntered" type="boolean" required="true" />
		<cfset variables.instance.StartingStockEntered = arguments.StartingStockEntered />
	</cffunction>
	<cffunction name="getStartingStockEntered" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.StartingStockEntered />
	</cffunction>

	<cffunction name="setStoreMail" access="public" returntype="void" output="false">
		<cfargument name="StoreMail" type="string" required="true" />
		<cfset variables.instance.StoreMail = arguments.StoreMail />
	</cffunction>
	<cffunction name="getStoreMail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.StoreMail />
	</cffunction>

	<cffunction name="setSecurityCode" access="public" returntype="void" output="false">
		<cfargument name="SecurityCode" type="string" required="true" />
		<cfset variables.instance.SecurityCode = arguments.SecurityCode />
	</cffunction>
	<cffunction name="getSecurityCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SecurityCode />
	</cffunction>

</cfcomponent>