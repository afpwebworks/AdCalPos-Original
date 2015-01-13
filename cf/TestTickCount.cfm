
<!--- This example calls the GetTickCount
      function to track execution time --->
<HTML>
<BODY>
<!--- Setup timing test --->
<CFSET iterationCount = 500000>

<!--- Time an empty loop with this many iterations --->
<CFSET tickBegin = GetTickCount()>
<CFLOOP Index=i From=1 To=#iterationCount#></CFLOOP>
<CFSET tickEnd = GetTickCount()>
<CFSET loopTime = tickEnd - tickBegin>

<!--- Report --->
<CFOUTPUT>Loop time (#iterationCount# iterations) was: #loopTime#
  milliseconds</CFOUTPUT>

<cfset strUUID = CreateUUID()>
<cfoutput><BR> length=:#len(strUUID)#, UUID = #strUUID#</cfoutput>  
<cfset strUUID = CreateUUID()>
<cfoutput><BR> length=:#len(strUUID)#, UUID = #strUUID#</cfoutput>  

<cfset strString = "O''Shea hagh">
<cfoutput><br>strString = #strString#</cfoutput>
<cfset strStringEncoded = URLEncodedFormat(strString)>
<cfoutput><br>strStringEncoded = #strStringEncoded#</cfoutput>
<cfset strStringDecoded = URLDecode(strStringEncoded)>
<cfoutput><br>strStringDecoded = #strStringDecoded#</cfoutput>
<cfset strPreserve = PreserveSingleQuotes(strString)>
<cfoutput><br>strPreserve = #strPreserve#</cfoutput>
<cfset strXMLFormat = XMLFormat(strString)>
<cfoutput><br>strXMLFormat = #strXMLFormat#</cfoutput>

</BODY>
</HTML>

