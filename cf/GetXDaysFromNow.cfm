
<!--- Calculates the tomorrow date ---> 
<CFSET strBaseDate = Attributes.baseDate>
<CFSET lngNumDays = Attributes.numDays>

<Cfset dteBaseDate = #CreateDate(mid(strBaseDate,5,4), mid(strBaseDate,3,2), mid(strBaseDate,1,2))#>
<Cfset dteSpan = #CreateTimeSpan(lngNumDays, 0, 0, 0)#>

<Cfset dteNewDate = #DateFormat(dteBaseDate + dteSpan)#>

<cfset TodayDay = #day(dteNewDate)# >
<cfset TodayMonth = #Month(dteNewDate)# >
<cfset TodayYear = #Year(dteNewDate)# >

<cfset strDateToday = "#numberformat(TodayDay,"00")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(TodayYear,"0000")#">

<CFSET Caller.strNextDate = #strDateToday#>

