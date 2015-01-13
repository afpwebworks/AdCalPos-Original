
<!--- Calculates the tomorrow date ---> 
<CFSET strDateValue = Attributes.strDateValue>

<cfif IsNumeric(strDateValue)>
	<cfset TodayDay = #mid(strDateValue,1,2)# >
	<cfset TodayMonth = #mid(strDateValue,3,2)# >
	<cfset TodayYear = #mid(strDateValue,5,4)# >
	
	<cfset lngTodayMonth = #numberformat(mid(strDateValue,3,2),"00")# >
    <cfif lngTodayMonth GT 12>
			<CFSET Caller.strValidDate = "N">
    <cfelseif TodayDay GT 31> 	
			<CFSET Caller.strValidDate = "N">
    <cfelse> 	
		<cfset strDateToday ="#TodayDay#/#TodayMonth#/#TodayYear#">
		<cfif isdate(#strDateToday#)>
			<CFSET Caller.strValidDate = "Y">
		<cfelse>
			<CFSET Caller.strValidDate = "N">
		</cfif>
	</cfif>
<cfelse>
	<CFSET Caller.strValidDate = "N">
</cfif>

