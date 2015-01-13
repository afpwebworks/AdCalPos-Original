
<!--- Calculates the tomorrow date ---> 
<CFSET strValue = Attributes.value>
<cfset TodayDay = #mid(strValue,1,2)# >
<cfset TodayMonth = #mid(strValue,3,2)# >
<cfset TodayYear = #mid(strValue,5,4)# >

<cfset strFormattedDate = "#TodayDay#" & "/#TodayMonth#" & "/#TodayYear#">

<CFSET Caller.strFormattedDate = #strFormattedDate#>



