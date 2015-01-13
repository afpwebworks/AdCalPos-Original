
<!--- Calculates the day of the week --->
<!--- Base date format is ddmmyyyy --->
<CFSET strBaseDate = Attributes.baseDate>
<Cfset dteBaseDate = #CreateDate(mid(strBaseDate,5,4), mid(strBaseDate,3,2), mid(strBaseDate,1,2))#>

<cfset lngToday = #DayOfWeek(dteBaseDate)#>
<cfif #lngToday# eq 1>
	<cfset lngD1 = 6>
	<CFSET Caller.strDateField = 'Sun'>
<cfelseif #lngToday# eq 2>
	<cfset lngD1 = 5>
	<CFSET Caller.strDateField = 'Mon'>
<cfelseif #lngToday# eq 3>
	<cfset lngD1 = 4>
	<CFSET Caller.strDateField = 'Tue'>	
<cfelseif #lngToday# eq 4>
	<cfset lngD1 = 3>
	<CFSET Caller.strDateField = 'Wed'>	
<cfelseif #lngToday# eq 5>
	<cfset lngD1 = 2>
	<CFSET Caller.strDateField = 'Thu'>	
<cfelseif #lngToday# eq 6>
	<cfset lngD1 = 1>
	<CFSET Caller.strDateField = 'Fri'>	
<cfelseif #lngToday# eq 7>
	<cfset lngD1 = 0>
	<CFSET Caller.strDateField = 'Sat'>	
</cfif>












