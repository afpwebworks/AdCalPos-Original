<cfsilent>
<!----
==========================================================================================================
Filename:     
Description:  
Date:         
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfscript>

</cfscript>
<cfparam name="request.pagename" default="Test of dsn">
</cfsilent>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<cfoutput>
<title>#application.sitename#<cfif len(request.pagename)>-#request.pagename#</cfif></title>
</cfoutput>
</head>

<body>
<cfoutput>
<p>DSN = #application.dsn#</p>
<p>DSN = #application.siteversion#</p>
</cfoutput>
</body>
</html>