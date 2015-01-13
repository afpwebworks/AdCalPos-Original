
<cfset strQuery = "SELECT tblOptions.OptionID, tblOptions.CutOffTime ">
<cfset strQuery = strQuery & "FROM tblOptions ">
<cfset strQuery = strQuery & "ORDER BY tblOptions.OptionID">


<CFQUERY name="GetTimeFromOptions" datasource="#application.dsn#" >
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfif #GetTimeFromOptions.RecordCount# GT 0>
	<cfset lngCutOffTime = #GetTimeFromOptions.CutOffTime#>	
<cfelse>
	<cfset lngCutOffTime = 0>	
</cfif>
<CFSET Caller.lngCutOffTime = #lngCutOffTime#> 



