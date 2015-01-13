
<!--- Calculates todays date ---> 
<cfset TodayDay = #day(now())# >
<cfset TodayMonth = #Month(now())# >
<cfset TodayYear = #Year(now())# >

<cfset strDateToday = "#numberformat(TodayDay,"00")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(TodayYear,"0000")#">

<CFSET Caller.strDateToday = #strDateToday#>



