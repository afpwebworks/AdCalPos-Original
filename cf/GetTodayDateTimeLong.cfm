
<!--- Calculates the long date ---> 
<cfset TodayDay = #day(now())# >
<cfset TodayMonth = #Month(now())# >
<cfset TodayYear = #Year(now())# >

<cfset lngDateToday =  "#numberformat(TodayYear,"0000")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(TodayDay,"00")#" & "#numberformat(hour(now()),"00")#" & "#numberformat(minute(now()),"00")#" & "#numberformat(second(now()),"00")#" >
<CFSET Caller.lngDateTimeToday = #lngDateToday#>


