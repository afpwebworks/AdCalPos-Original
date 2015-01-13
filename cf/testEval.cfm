
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfset strText = "AAAA">
<cfset strText2 = "BBBB">

<cfset strString = "strText">
<cfoutput><BR>evaluate(strString): #evaluate(strString)#</cfoutput>

<cfset strString2 = "#strText#  My Name  #strText2#">
<cfoutput><BR>evaluate(strString2): #de(strString2)#</cfoutput>

</body>
</html>
