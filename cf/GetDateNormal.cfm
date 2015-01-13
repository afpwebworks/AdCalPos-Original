
<!--- Converts date from yyyymmdd to ddmmyyyy format ---> 
<CFSET strBaseDate = Attributes.baseDate>

<cfset TodayDay = #mid(strBaseDate,7,2)# >
<cfset TodayMonth = #mid(strBaseDate,5,2)# >
<cfset TodayYear = #mid(strBaseDate,1,4)# >

<cfset lngDateToday =  "#numberformat(TodayDay,"00")#" & "#numberformat(TodayMonth,"00")#"  & #numberformat(TodayYear,"0000")#">

<CFSET Caller.lngDateLong = #lngDateToday#>



