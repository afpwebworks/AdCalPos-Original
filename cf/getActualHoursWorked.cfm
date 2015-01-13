
<!--- <cfset strQuery = "SELECT * FROM  tblEmpHoursWorked a, tblEmployee b ">
<cfset strQuery = strQuery & "WHERE (a.EmployeeID = #employeeID#) AND (a.StoreID = #lngStoreID#) AND (WeekEnding = '#strDate#')">
<cfset strQuery = strQuery & "and (a.EmployeeID = b.employeeID) ">
<cfset strQuery = strQuery & "and (a.StoreID = b.storeID) ">
 --->


<cfset strQuery = "SELECT * FROM  tblEmpHoursWorked ">
<cfset strQuery = strQuery & "WHERE (EmployeeID = #employeeID#) AND (StoreID = #lngStoreID#) AND (WeekEnding = '#strDate#')">

<CFQUERY name="GetHours" datasource="#application.dsn#" > 
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>
<CFSET totalMins=0>
<CFOUTPUT>
  <CFLOOP query="GetHours">
    <CFSET startMinsElapsed = (MID(startTime,1,2) * 60) + MID(startTime,3,2)>
    <CFSET endMinsElapsed = (MID(endTime,1,2) * 60) + MID(endTime,3,2)>
    <CFSET totalMins = totalMins + (endMinsElapsed - startMinsElapsed) + ot1mins + ot2mins>  
<!---     #totalMins#<br> --->
  </cfloop>
</cfoutput>
<CFSET sumHours = INT(totalMins/60)>
<CFSET sumMins = totalMins mod 60>
