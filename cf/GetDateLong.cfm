
<!--- Converts DDMMYYYY to YYYYMMDD ---> 
<CFSET strBaseDate = Attributes.baseDate>

<cfset TodayDay = #mid(strBaseDate,1,2)# >
<cfset TodayMonth = #mid(strBaseDate,3,2)# >
<cfset TodayYear = #mid(strBaseDate,5,4)# >

<cfset lngDateToday =  "#numberformat(TodayYear,"0000")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(TodayDay,"00")#" >

<CFSET Caller.lngDateLong = #lngDateToday#>



