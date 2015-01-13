
<!--- Calculates the tomorrow date ---> 
<cfset TodayDay = #day(now())# >
<cfset TodayMonth = #Month(now())# >
<cfset TodayYear = #Year(now())# >

<cfset strDateToday = "#numberformat(TodayDay,"00")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(TodayYear,"0000")#">
<cfset strDateStringTomorrow ="#numberformat(TodayDay + 1,"00")#/#numberformat(TodayMonth,"00")#/#numberformat(TodayYear,"0000")#">
<cfif isdate(#strDateStringTomorrow#)>
		<cfset strDateStringTomorrow ="#numberformat(TodayDay + 1,"00")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(TodayYear,"0000")#">
<cfelse>
        <cfif #TodayMonth# eq 12>
			<cfset strDateStringTomorrow ="#numberformat(1,"00")#" & "#numberformat(1,"00")#" & "#numberformat(TodayYear + 1,"0000")#">
		<cfelse>
			<cfset strDateStringTomorrow ="#numberformat(1,"00")#" & "#numberformat(TodayMonth + 1,"00")#" & "#numberformat(TodayYear,"0000")#">
		</cfif>
</cfif>

<CFSET Caller.strTomorrowDate = #strDateStringTomorrow#>



