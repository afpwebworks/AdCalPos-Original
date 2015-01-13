
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Invalid Date</title>
</head>

<body>
	<CFIF ParameterExists(URL.message)>
		<p><cfoutput><b><font size="4">#URL.message#</font></b></cfoutput></p>
		<p></p>
	<cfelse>
		<p>Please select a valid date.</p>
	</cfif>
</body>
</html>
