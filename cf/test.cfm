
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfset strMyDate = '30042003'>

<!--- Make sure that the user has typed 8 digits --->
<cfif #len(strMyDate)# NEQ 8>
	<br>Please type week commencing in ddmmyyyy format (example: 22022003)
	<cfabort>
</cfif>

<!--- Make sure that the user has typed only numbers --->
<cfif #IsNumeric(strMyDate)#>
<cfelse>
	<br>Please type week commencing in ddmmyyyy format (example: 22022003)
	<cfabort>
</cfif>

<!--- IsDate() function looks like this IsDate('02/28/2003') --->
<!--- Make sure that the number can be converted to a date --->
<cfif #IsDate('#mid(strMyDate,3,2)#/#mid(strMyDate,1,2)#/#mid(strMyDate,5,4)#')#>
<cfelse>
	<br>Please type week commencing in ddmmyyyy format (example: 22022003)
	<cfabort>
</cfif>

<cfset dteMyDate = #CreateDate(mid(strMyDate,5,4), mid(strMyDate,3,2), mid(strMyDate,1,2))#>
<cfset lngDateNumber = #DayOfWeek(dteMyDate)#>
<cfif lngDateNumber NEQ 2>
	<cfoutput>
		<br>Week commencing must be Monday.  The date that you have typed is a #DayOfWeekAsString(lngDateNumber)#
	</cfoutput>	
</cfif>




</body>
</html>
