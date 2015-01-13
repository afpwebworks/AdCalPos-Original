<cfsilent>
<!----
==========================================================================================================
Filename:     test.cfm
Description:  Test page for submission side
Date:         29/3/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfset Filetoread = application.approotabs & "\test4.xml" />
<cffile action="read" file="#Filetoread#" variable="xmldoc">
<cfset mydoc = XmlParse(xmldoc)>

<cfscript>

</cfscript>
<cfparam name="request.pagename" default="">
</cfsilent>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>#application.sitename#<cfif len(request.pagename)>-#request.pagename#</cfif></title>
</head>
<body>
<!---[   <Cfdump var="#application#">   ]---->
<cfif application.siteversion is "development">
	 <cfset actionpage ="http://dev.adcalposnet/process.cfm" /> 
<cfelse>
	<cfset actionpage ="http://adcalpos.net/process.cfm" />    
</cfif>
<cfoutput>
<h1>This is test2.cfm</h1>
<form action="/process.cfm" method="post" name="inputformXML">  
<textarea name="data" cols="75" rows="16">#mydoc#</textarea>
<input type="submit" name="submit" value="Submit" />
</form>
</cfoutput>
</body>
</html>
 <cfdump var="#session#" label="line 42 test2.cfm"> 
<!----[    <cfdump var="#application#" label="application.vars line 45 test2.cfm">   ]----MK ---->
 <cfdump var="#mydoc#" label="line 43 test2.cfm"> 
 