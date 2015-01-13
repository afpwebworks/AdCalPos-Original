
<!--- It is expected that the date is formatted as  d/m/yy --->

<!--- If strValidDate = 'N' then abort --->
<!--- If lngWeekDay = 0 then this function only validates the date --->
<!--- If lngWeekDay is beween 1 and 7 then this function will make sure that the date is Sunday through Saturday --->
<cfset strMyDateTyped = #Attributes.strDateValue#>
<cfset lngWeekDay = #Attributes.lngWeekDay#>
<cfset strValidDate = 'N'>

<cfif #ListLen(strMyDateTyped,"/")# NEQ 3>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
</cfif>

<cfset strElement1 = #ListGetAt(strMyDateTyped,1,"/")#>
<cfset strElement2 = #ListGetAt(strMyDateTyped,2,"/")#>
<cfset strElement3 = #ListGetAt(strMyDateTyped,3,"/")#>

<!--- Check the length of each element --->
<cfif (#len(strElement1)# LT 1) or (#len(strElement1)# GT 2) >
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
</cfif>
<cfif (#len(strElement2)# LT 1) or (#len(strElement2)# GT 2) >
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
</cfif>
<cfif (#len(strElement3)# LT 1) or (#len(strElement3)# GT 4) >
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
</cfif>
<cfif #len(strElement3)# EQ 3>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
</cfif>
<cfif #len(strElement3)# EQ 2>
	<cfset strElement3 = "20" & #strElement3#>
</cfif>

<!--- Check each element to be a number --->
<cfif #isnumeric(strElement1)#>
<cfelse>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
</cfif>

<cfif #isnumeric(strElement2)#>
<cfelse>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
</cfif>

<cfif #isnumeric(strElement3)#>
<cfelse>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
</cfif>

<!--- Check range of each element --->
<cfif strElement1 GT 31>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
<cfelseif strElement1 LT 1>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
<cfelseif strElement2 GT 12>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
<cfelseif strElement2 LT 1>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
<cfelseif strElement3 LT 1990>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
<cfelseif strElement3 GT 2050>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
</cfif>

<!--- Convert the date into 8 digit text --->
<cfset strMyDate = #NumberFormat(strelement1,"00")# & #NumberFormat(strelement2,"00")# & #strelement3#>

<!--- Make sure that the user has typed 8 digits --->
<cfif #len(strMyDate)# NEQ 8>
	<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
	<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
	<cfabort>
<cfelseif #IsNumeric(strMyDate)# EQ false>
	<!--- Make sure that the user has typed only numbers --->
		<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
		<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
		<cfabort>
<cfelseif #IsDate('#mid(strMyDate,3,2)#/#mid(strMyDate,1,2)#/#mid(strMyDate,5,4)#')# EQ False>
	<!--- IsDate() function looks like this IsDate('02/28/2003') --->
	<!--- Make sure that the number can be converted to a date --->
		<cfset ErrorMessage = 'You have typed #strMyDateTyped#.  Please type date in dd/mm/yyyy format (example: 22/02/2003)'>
		<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
		<cfabort>
<cfelse>
	<cfif #lngWeekDay# EQ 0>
		<cfset strValidDate = 'Y'>
	<cfelse>
		<cfset dteMyDate = #CreateDate(mid(strMyDate,5,4), mid(strMyDate,3,2), mid(strMyDate,1,2))#>
		<cfset lngDateNumber = #DayOfWeek(dteMyDate)#>
		<cfif #lngDateNumber# NEQ #lngWeekDay#>
			<cfset ErrorMessage = 'Date must be #DayOfWeekAsString(lngWeekDay)#.  The date that you have typed is a #DayOfWeekAsString(lngDateNumber)#'>
			<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
			<cfabort>
    	<cfelse>
			<cfset strValidDate = 'Y'>
		</cfif>
	</cfif>
</cfif>

<CFSET Caller.lngDay = "#strElement1#"> 
<CFSET Caller.lngMonth = "#strElement2#"> 
<CFSET Caller.lngYear = "#strElement3#"> 


