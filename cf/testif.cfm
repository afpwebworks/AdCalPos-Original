
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
 <CFQUERY NAME="ClientRecords" 
    DATASOURCE="mpsJobs"> 
    SELECT * FROM tblClient 
</CFQUERY> 

<!--- <CFLOOP QUERY="ClientRecords"> 
    <CFOUTPUT>#ClientID#</CFOUTPUT><BR> 
</CFLOOP>
 --->
<CFSET Start=2> 
<CFSET End=5> 

<CFLOOP QUERY="ClientRecords" 
    STARTROW="#Start#" 
    ENDROW="#End#"> 

    <CFOUTPUT>#ClientRecords.ClientName#</CFOUTPUT><BR>

</CFLOOP>



</body>
</html>
