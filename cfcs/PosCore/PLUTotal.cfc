<cfcomponent displayname="PLUTotal" output="false" hint="A bean which models the PLUTotal record.">

<cfsilent>
<!----
================================================================
Filename: PLUTotal.cfc
Description: A bean which models the PLUTotal record.
Author:  Michael Kear, AFP Webworks 
Date: 12/May/2010
================================================================
This bean was generated with the following template:
Bean Name: PLUTotal
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
	PLUNumber numeric 0
	TotalD numeric 0
	Quantity numeric 0
	TotalKg numeric 0
	PrePackTotalD numeric 0
	PrePackQuantity numeric 0
	PrePackTotalkg numeric 0
	Posted boolean false
	COGS numeric 0
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
	<cffunction name="init" access="public" returntype="PLUTotal" output="false">
		<cfargument name="ID" type="numeric" required="false" default="0" />
		<cfargument name="StoreID" type="numeric" required="false" default="0" />
		<cfargument name="FileName" type="string" required="false" default="" />
		<cfargument name="DateEntered" type="date" required="false" default="#request.austime#" />
		<cfargument name="TimeEntered" type="string" required="false" default="#request.austime#" />
		<cfargument name="Date" type="date" required="false" default="#request.austime#" />
		<cfargument name="Time" type="string" required="false" default="#request.austime#" />
		<cfargument name="Location" type="numeric" required="false" default="0" />
		<cfargument name="ScaleIDCode" type="numeric" required="false" default="0" />
		<cfargument name="PLUNumber" type="numeric" required="false" default="0" />
		<cfargument name="TotalD" type="numeric" required="false" default="0" />
		<cfargument name="Quantity" type="numeric" required="false" default="0" />
		<cfargument name="TotalKg" type="numeric" required="false" default="0" />
		<cfargument name="PrePackTotalD" type="numeric" required="false" default="0" />
		<cfargument name="PrePackQuantity" type="numeric" required="false" default="0" />
		<cfargument name="PrePackTotalkg" type="numeric" required="false" default="0" />
		<cfargument name="Posted" type="boolean" required="false" default="false" />
		<cfargument name="COGS" type="numeric" required="false" default="0" />
        
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
			setPLUNumber(arguments.PLUNumber);
			setTotalD(arguments.TotalD);
			setQuantity(arguments.Quantity);
			setTotalKg(arguments.TotalKg);
			setPrePackTotalD(arguments.PrePackTotalD);
			setPrePackQuantity(arguments.PrePackQuantity);
			setPrePackTotalkg(arguments.PrePackTotalkg);
			setPosted(arguments.Posted);
			setCOGS(arguments.COGS);
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

	<cffunction name="setPLUNumber" access="public" returntype="void" output="false">
		<cfargument name="PLUNumber" type="numeric" required="true" />
		<cfset variables.instance.PLUNumber = arguments.PLUNumber />
	</cffunction>
	<cffunction name="getPLUNumber" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PLUNumber />
	</cffunction>

	<cffunction name="setTotalD" access="public" returntype="void" output="false">
		<cfargument name="TotalD" type="numeric" required="true" />
		<cfset variables.instance.TotalD = arguments.TotalD />
	</cffunction>
	<cffunction name="getTotalD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.TotalD />
	</cffunction>

	<cffunction name="setQuantity" access="public" returntype="void" output="false">
		<cfargument name="Quantity" type="numeric" required="true" />
		<cfset variables.instance.Quantity = arguments.Quantity />
	</cffunction>
	<cffunction name="getQuantity" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Quantity />
	</cffunction>

	<cffunction name="setTotalKg" access="public" returntype="void" output="false">
		<cfargument name="TotalKg" type="numeric" required="true" />
		<cfset variables.instance.TotalKg = arguments.TotalKg />
	</cffunction>
	<cffunction name="getTotalKg" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.TotalKg />
	</cffunction>

	<cffunction name="setPrePackTotalD" access="public" returntype="void" output="false">
		<cfargument name="PrePackTotalD" type="numeric" required="true" />
		<cfset variables.instance.PrePackTotalD = arguments.PrePackTotalD />
	</cffunction>
	<cffunction name="getPrePackTotalD" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PrePackTotalD />
	</cffunction>

	<cffunction name="setPrePackQuantity" access="public" returntype="void" output="false">
		<cfargument name="PrePackQuantity" type="numeric" required="true" />
		<cfset variables.instance.PrePackQuantity = arguments.PrePackQuantity />
	</cffunction>
	<cffunction name="getPrePackQuantity" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PrePackQuantity />
	</cffunction>

	<cffunction name="setPrePackTotalkg" access="public" returntype="void" output="false">
		<cfargument name="PrePackTotalkg" type="numeric" required="true" />
		<cfset variables.instance.PrePackTotalkg = arguments.PrePackTotalkg />
	</cffunction>
	<cffunction name="getPrePackTotalkg" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PrePackTotalkg />
	</cffunction>

	<cffunction name="setPosted" access="public" returntype="void" output="false">
		<cfargument name="Posted" type="boolean" required="true" />
		<cfset variables.instance.Posted = arguments.Posted />
	</cffunction>
	<cffunction name="getPosted" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.Posted />
	</cffunction>

	<cffunction name="setCOGS" access="public" returntype="void" output="false">
		<cfargument name="COGS" type="numeric" required="true" />
		<cfset variables.instance.COGS = arguments.COGS />
	</cffunction>
	<cffunction name="getCOGS" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.COGS />
	</cffunction>

</cfcomponent>