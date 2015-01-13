
<!--- Calculates the tomorrow date ---> 
<CFSET strDateValue = #Attributes.strDateValue#>

<CFSET strValidDate = "N">
<cfif IsNumeric(strDateValue)>
	<cfset TodayDay = #mid(strDateValue,1,2)# >
	<cfset TodayMonth = #mid(strDateValue,3,2)# >
	<cfset TodayYear = #mid(strDateValue,5,4)# >

	<cfif #len(TodayDay)# LT 2>
		<cfset TodayDay = "0" & #TodayDay# >
	</cfif>
	<cfif #len(TodayMonth)# LT 2>
		<cfset TodayMonth = "0" & #TodayMonth# >
	</cfif>
	
	<CFSET strDateToday = CreateDate(#TodayYear#, #TodayMonth#, #TodayDay#)>	
	
	<cfif isdate(#strDateToday#)>
			<cfif #DayOfWeek(strDateToday)# EQ 7>
				<CFSET strValidDate = "Y">
			</cfif>	
	</cfif>
</cfif>
<CFSET Caller.strValidDate = "#strValidDate#">
