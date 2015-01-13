
<cfset strQuery = "SELECT * FROM tblEmpPayOptions WHERE tblEmpPayOptions.ID = 1">

<CFQUERY name="GetEmpPayOptions" datasource="#application.dsn#" > 
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<CFSET variables.standardHoursInWeek = GetEmpPayOptions.standardMinutesWorkedInWeek[1] / 60>
