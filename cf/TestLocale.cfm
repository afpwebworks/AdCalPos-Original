
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfoutput>
<br>#SetLocale("English (Australian)")#
</cfoutput>
<P>The locale for this system is <CFOUTPUT>#GetLocale()#</CFOUTPUT>
<cfset MyDate = "1/2/2003">
<cfoutput><br>MyDate: #MyDate#</cfoutput>
<cfoutput><br>Day: #day(MyDate)#</cfoutput>
<cfoutput><br>Month: #month(MyDate)#</cfoutput>
<cfoutput><br>Year: #year(MyDate)#</cfoutput>
<cfoutput><br>LS Date Format: #LSDateFormat(MyDate)#</cfoutput>


</body>
</html>
