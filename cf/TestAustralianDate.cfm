
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfset MyDate = "1/2/2003">
<CFSET DateArray = ArrayNew(1)>

	<cfoutput><Br>MyDate: #MyDate#</cfoutput>
	<Br>
	<cfoutput><Br>ListLen: #ListLen(MyDate,"/")#</cfoutput>
	<Br>
	<cfoutput><Br>Element 1: #ListGetAt(MyDate,1,"/")#</cfoutput>
	<cfoutput><Br>Element 2: #ListGetAt(MyDate,2,"/")#</cfoutput>
	<cfoutput><Br>Element 3: #ListGetAt(MyDate,3,"/")#</cfoutput>

	<Br>




	
<CFLOOP LIST="#MyDate#" INDEX="DateItem" DELIMITERS="/">
	<cfoutput><Br>DateItem: #DateItem#</cfoutput>

</cfloop>


</body>
</html>
