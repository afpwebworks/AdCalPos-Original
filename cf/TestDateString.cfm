
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfset lngDay = "">
<cfset lngMonth = "">
<cfset lngYear = "">
<cfset strMyDate = "5/122003">
<cfoutput><br>strMyDate: #strMyDate#</cfoutput>

<Br>Before test
<CF_ValidateDateString strDateValue = "#strMyDate#" lngWeekDay = 0> 
<Br>After test

<cfoutput><br>lngDay: #lngDay#</cfoutput>
<cfoutput><br>lngMonth: #lngMonth#</cfoutput>
<cfoutput><br>lngYear: #lngYear#</cfoutput>

</body>
</html>
