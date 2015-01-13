
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfset strEODFinished = ''>

<cf_GetEndOfDayFinished>

<CFSET strDateToday = ''>
<CF_GetTodayDate>

<cfoutput><br>strDateToday: #strDateToday#</cfoutput>
<cfoutput><br>Store ID: #Session.storeid#</cfoutput>
<cfoutput><br>strEODFinished: #strEODFinished#</cfoutput>

</body>
</html>
