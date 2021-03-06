<cfcomponent displayname="timezone" hint="various timezone functions not included in mx: version 2.1 jul-2005 Paul Hastings (paul@sustainbleGIS.com)" output="No">
<!--- 
author:		paul hastings <paul@sustainableGIS.com>
date:		11-sep-2003
revisions:
			23-oct-2003 changed to use argument dates rather than setting calendar time, forgot that
			java MONTH start with zero. kept gregorian calendar object for timezone offset in order to
			use DST_OFFSET field in calendar object.
			8-nov-2003 added castToUTC, castFromUTC to support Ray Camden's blog i18n, added castToServer
			and castFromServer at user request.
			14-feb-2005 reworked castToUTC, castFromUTC to not use gregorian calendar class,
			added init().
			16-feb-2005 fixed java/cf date bug in cast to/from functions
			6-aug-2005 fixed bug in to/from UTC methods, was using decimals hours for tz 
			offsetsbut cf's dateAdd function only takes integers. thanks to Behrang Noroozinia 
			<behrang@khorshidchehr.com> for finding that bug.
			18/12/2005 - Michael Kear - added method  GetNISTTime which gets the current time from a NIST time server
			
notes:		this cfc contains methods to handle some timezone functionality not in cfmx as well as when
			you need to "cast" to a specific timezone (cf's timezone functions are tied to server). it 
			requires the use of createObject.
			
methods in this CFC:
			- isDST determines if a given date & timezone are in DST. if no date or timezone is passed
			the method defaults to current date/time and server timezone. PUBLIC.
			- getAvailableTZ returns an array of available timezones on this server (ie according to 
			server's JVM). PUBLIC.
			- isValidTZ determines if a given timezone is valid according to getAvailableTZ. PUBLIC.
			- usesDST determines if a given timezone uses DST. PUBLIC.
			- GetNISTTime gets the current time from a NIST time server to permit ignoring the server time.
			- getRawOffset returns the raw (as opposed to DST) offset in hours for a given timezone. 
			PUBLIC.
			- getTZOffset returns offset in hours for a given date/time & timezone, uses DST if timezone 
			uses and is currently in DST. returns -999 if bad date or bad timezone. PUBLIC.	
			- getDST returns DST savings for given timezone. returns -999 for bad timezone. PUBLIC.
			- castToUTC return UTC from given datetime in given timezone. required argument thisDate,
			optional argument thisTZ valid timezone ID, defaults to server timezone. PUBLIC.
			- castfromUTC return date in given timezone from UTC datetime. required argument thisDate,
			optional argument thisTZ valid timezone ID, defaults to server timezone. PUBLIC.
			- castToServer returns server datetime from given datetime in given timezone. required argument 
			thisDate valid datetime, optional argument thisTZ valid timezone ID, defaults to server 
			timezone. PUBLIC.
			- castfromServer return datetime in given timezone from server datetime. required argument 
			thisDate valdi datetime, optional argument thisTZ valid timezone ID, defaults to server 
			timezone. PUBLIC.
			- getServerTZ returns server timezone.
 --->
 
<!--- lets try a default INIT method --->
<cfset init()>

<cffunction name="init" output="No" access="public">
	<cfset variables.tzObj=createObject("java","java.util.TimeZone")>
	<cfset variables.tzList = arrayToList(tzObj.getAvailableIDs())>
</cffunction>

<!--- validates if a given timezone is in list of timezones available on this server --->
<cffunction name="isValidTZ" output="No" returntype="boolean" access="public">
	<cfargument name="tzToTest" required="yes">
	<cfscript>
		if (listFindNoCase(variables.tzList,arguments.tzTotest))
			return true;
		else
			return false;	 
	</cfscript>
</cffunction>

<!----[  Gets the time from a NIST Time server  ]---->
<cffunction name="GetNISTTime" returntype="struct" output="false">
	<cfargument name="timeServer" type="string" default="192.43.244.18" required="false">
	<cfset var result=StructNew()>

	<!--- Try/catch block --->
	<cftry>

      <!--- Try get time data --->
      <cfhttp url="http://#arguments.timeServer#:13/" />
      <!--- Save raw data --->
      <cfset result.raw = CFHTTP.FileContent>
      <!--- Extract Julian date --->
      <cfset result.julian=ListGetAt(result.raw, 1, " ")>
      <!--- Extract current date and time --->
      <cfset result.now=LSParseDateTime(ListGetAt(result.raw, 2, " ")
                              & " "
                              & ListGetAt(result.raw, 3, " "))>
      <!--- Extract daylight savings time flag --->
      <cfset result.dst=IIf(ListGetAt(result.raw, 4, " ") IS 0,
                        FALSE, TRUE)>
      <!--- Extract leap month flag --->
      <cfset result.leapmonth=IIf(ListGetAt(result.raw, 5, " ") IS 0,
                           FALSE, TRUE)>
      <!--- Extract health flag --->
      <cfset result.healthy=IIf(ListGetAt(result.raw, 6, " ") IS 0,
                           FALSE, TRUE)>
      <!--- Extract advance milliseconds --->
      <cfset result.msadv=ListGetAt(result.raw, 7, " ")>
      <!--- Success --->
      <cfset result.success=TRUE>

      <!--- Catch any errors --->
      <cfcatch type="any">
         <cfset result.success=FALSE>
      </cfcatch>

	</cftry>

	<cfreturn result>

</cffunction>


<!--- determines if a given date in a given timezone is in DST --->
<cffunction name="isDST" output="No" returntype="boolean" access="public">  
	<cfargument name="dateToTest" required="no" type="date" default="#now()#">
	<cfargument name="tzToTest" required="no" default="#tzObj.getDefault().ID#">
	<cfscript>
		// set up correct tz,date,etc.
		var thisTZ=tzObj.getTimeZone(arguments.tzToTest);
		return thisTZ.inDaylightTime(arguments.dateTotest);
	</cfscript>
</cffunction>

<!--- returns a list of timezones available on this server --->
<cffunction name="getAvailableTZ" output="No" returntype="array" access="public">  
	<cfscript>
		return listToArray(variables.tzList);
	</cfscript>
</cffunction>

<!--- returns a list of timezones available on this server for a given raw offset--->
<cffunction name="getTZByOffset" output="No" returntype="array" access="public">  
	<cfargument name="thisOffset" required="Yes" type="numeric">
	<cfscript>
		var rawOffset=javacast("long",arguments.thisOffset * 3600000);
		var tzList = tzObj.getAvailableIDs(rawOffset);
		return tzList;
	</cfscript>
</cffunction>

<!--- determines if a given timezone uses DST --->
<cffunction name="usesDST" output="No" returntype="boolean" access="public">
	<cfargument name="tz" required="no" default="#tzObj.getDefault().ID#">
	<cfscript>
		return tzObj.getTimeZone(arguments.tz).useDaylightTime();
	</cfscript>
</cffunction>

<!--- returns rawoffset in hours --->
<cffunction name="getRawOffset" output="No" access="public" returntype="numeric">  
	<cfargument name="tZ" required="no" default="#tzObj.getDefault().ID#">
	<cfscript>
		var thisTZ=tzObj.getTimeZone(arguments.tZ);
		return thisTZ.getRawOffset()/3600000;
	</cfscript>
</cffunction>

<!--- returns offset in hours --->
<cffunction name="getTZOffset" output="No" access="public" returntype="numeric">  
	<cfargument name="thisDate" required="no" type="date" default="#now()#">
	<cfargument name="thisTZ" required="no" default="#tzObj.getDefault().ID#">
	<cfscript>
		var timezone=tzObj.getTimeZone(arguments.thisTZ);
		var tYear=javacast("int",Year(arguments.thisDate));
		var tMonth=javacast("int",month(arguments.thisDate)-1); //java months are 0 based
		var tDay=javacast("int",Day(thisDate));
		var tDOW=javacast("int",DayOfWeek(thisDate));	//day of week
		return timezone.getOffset(1,tYear,tMonth,tDay,tDOW,0)/3600000;
</cfscript>
</cffunction>

<!--- returns DST savings in hours --->
<cffunction name="getDST" output="No" access="public" returntype="numeric">  
	<cfargument name="thisTZ" required="no" default="#tzObj.getDefault().ID#">
	<cfscript>
		var tZ=tzObj.getTimeZone(arguments.thisTZ);
		return tZ.getDSTSavings()/3600000;
	</cfscript>
</cffunction>

<!--- returns UTC from given date in given TZ, takes DST into account --->
<cffunction name="castToUTC" output="No" access="public" returntype="date">  
	<cfargument name="thisDate" required="yes" type="date">
	<cfargument name="thisTZ" required="no" default="#tzObj.getDefault().ID#">
	<cfscript>
		var timezone=tzObj.getTimeZone(arguments.thisTZ);
		var tYear=javacast("int",Year(arguments.thisDate));
		var tMonth=javacast("int",month(arguments.thisDate)-1); //java months are 0 based
		var tDay=javacast("int",Day(thisDate));
		var tDOW=javacast("int",DayOfWeek(thisDate));	//day of week
		var thisOffset=(timezone.getOffset(1,tYear,tMonth,tDay,tDOW,0)/60000)*-1.00;
		return dateAdd("n",thisOffset,arguments.thisDate);
	</cfscript>
</cffunction>

<!--- returns date in given TZ from given UTC date, takes DST into account --->
<cffunction name="castFromUTC" output="No" access="public" returntype="date">  
	<cfargument name="thisDate" required="yes" type="date">
	<cfargument name="thisTZ" required="no" default="#tzObj.getDefault().ID#">
	<cfscript>
		var timezone=tzObj.getTimeZone(arguments.thisTZ);
		var tYear=javacast("int",Year(arguments.thisDate));
		var tMonth=javacast("int",month(arguments.thisDate)-1); //java months are 0 based
		var tDay=javacast("int",Day(thisDate));
		var tDOW=javacast("int",DayOfWeek(thisDate));	//day of week
		var thisOffset=timezone.getOffset(1,tYear,tMonth,tDay,tDOW,0)/60000;
		return dateAdd("n",thisOffset,arguments.thisDate);
	</cfscript>
</cffunction>

<!--- returns server date in given TZ from given UTC date, takes DST into account --->
<cffunction name="castToServer" output="No" access="public" returntype="date">  
	<cfargument name="thisDate" required="yes" type="date">
	<cfargument name="thisTZ" required="no" default="#tzObj.getDefault().ID#">
	<cfscript>
		return dateConvert("utc2Local",castToUTC(arguments.thisDate,arguments.thisTZ));
	</cfscript>
</cffunction>

<!--- returns date in given TZ from given server date, takes DST into account --->
<cffunction name="castFromServer" output="No" access="public" returntype="date">  
	<cfargument name="thisDate" required="yes" type="date">
	<cfargument name="thisTZ" required="no" default="#tzObj.getDefault().ID#">
	<cfscript>
		return castFromUTC(dateConvert("local2UTC",arguments.thisDate),arguments.thisTZ);
	</cfscript>
</cffunction>

<!--- returns server TZ --->
<cffunction name="getServerTZ" output="No" access="public" returntype="string">  
	<cfreturn tzObj.getDefault().getDisplayName(true,tzObj.LONG)>
</cffunction>

</cfcomponent>
