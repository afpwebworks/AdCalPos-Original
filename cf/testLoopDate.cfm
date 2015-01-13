
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<Cfset dteBaseDate = #now()#>

<cfloop index="LoopIndex" from="1" to ="30">
	<Cfset dteSpan = #CreateTimeSpan(LoopIndex, 0, 0, 0)#>
	<Cfset dteNewDate = #dteBaseDate# + #dteSpan#>

	<Cfset lngDay = #Day(dteNewDate)#>
	<Cfset lngDay = #numberformat(lngDay , "00")#>
	<Cfset lngMonth = #month(dteNewDate)#>
	<Cfset lngMonth = #numberformat(lngMonth , "00")#>
	<Cfset lngYear = #year(dteNewDate)#>
	<Cfset strDate = "#lngDay##lngMonth##lngYear#" >	
	<cfoutput><BR>LoopIndex: #LoopIndex#  Day: #strDate# #lngDay#/#lngMonth#/#lngYear#</cfoutput>
</cfloop>


</body>
</html>
