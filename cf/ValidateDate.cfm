
<!--- If strValidDate = 'N' then abort --->
<!--- If lngWeekDay = 0 then this function only validates the date --->
<!--- If lngWeekDay is beween 1 and 7 then this function will make sure that the date is Sunday through Saturday --->
<cfset strMyDate = #Attributes.strDateValue#>
<cfset lngWeekDay = #Attributes.lngWeekDay#>
<cfset strValidDate = 'N'>

<!--- Make sure that the user has typed 8 digits --->
<cfif #len(strMyDate)# NEQ 8>
	<cfset ErrorMessage = 'Please type date in ddmmyyyy format (example: 22022003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
<cfelseif #IsNumeric(strMyDate)# EQ false>
	<!--- Make sure that the user has typed only numbers --->
		<cfset ErrorMessage = 'Please type date in ddmmyyyy format (example: 22022003)'>
		<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
		<cfabort>
<cfelseif #IsDate('#mid(strMyDate,3,2)#/#mid(strMyDate,1,2)#/#mid(strMyDate,5,4)#')# EQ False>
	<!--- IsDate() function looks like this IsDate('02/28/2003') --->
	<!--- Make sure that the number can be converted to a date --->
		<cfset ErrorMessage = 'Please type date in ddmmyyyy format (example: 22022003)'>
		<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
		<cfabort>
<cfelse>
	<cfif #lngWeekDay# EQ 0>
		<cfset strValidDate = 'Y'>
	<cfelse>
		<cfset dteMyDate = #CreateDate(mid(strMyDate,5,4), mid(strMyDate,3,2), mid(strMyDate,1,2))#>
		<cfset lngDateNumber = #DayOfWeek(dteMyDate)#>
		<cfif #lngDateNumber# NEQ #lngWeekDay#>
			<cfset ErrorMessage = 'date must be #DayOfWeekAsString(lngWeekDay)#.  The date that you have typed is a #DayOfWeekAsString(lngDateNumber)#'>
			<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
			<cfabort>
    	<cfelse>
			<cfset strValidDate = 'Y'>
		</cfif>
	</cfif>
</cfif>

<!--- <CFSET Caller.strValidDate = "#strValidDate#"> --->

