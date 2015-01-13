
<CFSET strDateToday = ''>
<CF_GetTodayDate>

<CFSET strDateField = ''>
<CFSET strDateWE = ''>
<CF_GetWeekEnding>

<cfoutput><br>strDateToday: #strDateToday#</cfoutput>
<cfoutput><br>strDateField: #strDateField#</cfoutput>
<cfoutput><br>strDateWE: #strDateWE#</cfoutput>

<cfset lngStoreID = #session.storeid#>

	<cfset strQuery = "SELECT tblEmpRoster.RosterID, tblEmpRoster.EmployeeID, tblEmpRoster.StoreID, tblEmpRoster.WeekEnding, tblEmpRoster.#strDateField#Start AS RosterStart, tblEmpRoster.#strDateField#End AS RosterEnd ">
	<cfset strQuery = strQuery & "FROM tblEmpRoster ">
	<cfset strQuery = strQuery & "WHERE (((tblEmpRoster.StoreID)= #lngStoreID# ) AND ((tblEmpRoster.WeekEnding)= '#strDateWE#' ))">
	<CFQUERY name="CheckRoster" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="CheckRoster" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfoutput Query = "CheckRoster">
		<CFSET lngEmpID = #CheckRoster.EmployeeID# >
		<CFSET strRosterStart = #CheckRoster.RosterStart# >
		<CFSET strRosterEnd = #CheckRoster.RosterEnd# >			
	    <!--- Check to see if this line exist in the employee hours worked or not ---> 
		<cfset strQuery = "SELECT tblEmpHoursWorked.HoursWorkedID, tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID, tblEmpHoursWorked.DateWorked, tblEmpHoursWorked.StartTime, tblEmpHoursWorked.EndTime, tblEmpHoursWorked.StartRoster, tblEmpHoursWorked.EndRoster ">
		<cfset strQuery = strQuery & "FROM tblEmpHoursWorked ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.EmployeeID)= #lngEmpID# ) AND ((tblEmpHoursWorked.StoreID)= #lngStoreID# ) AND ((tblEmpHoursWorked.DateWorked)= '#strDateToday#' ))">
		<CFQUERY name="CheckHoursWorked" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CheckHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckHoursWorked.RecordCount# LT 1>
			<!--- Add the information from the roster to hours worked --->
			<cfset strQuery = "INSERT INTO tblEmpHoursWorked ( WeekEnding, EmployeeID, StoreID, DateWorked, StartTime, EndTime, StartRoster, EndRoster ) ">
			<cfset strQuery = strQuery & "Values ('#strDateWE#', #lngEmpID# , #lngStoreID# , '#strDateToday#' , '#strRosterStart#' , '#strRosterEnd#'  , '#strRosterStart#' , '#strRosterEnd#' )">
			<CFQUERY name="InsertDataIntoHoursWorked" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="InsertDataIntoHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<br>Values ('#strDateWE#', #lngEmpID# , #lngStoreID# , '#strDateToday#' , '#strRosterStart#' , '#strRosterEnd#'  , '#strRosterStart#' , '#strRosterEnd#' )
		</cfif>
	</cfoutput>
	

<cfabort>


<cfset lngDay = #Form.DF#>
<cfset lngMonth = #Form.MF#>
<cfset lngYear = #Form.YF#>

<cfif #len(lngDay)# LT 2>
	<cfset lngDay = "0" & "#lngDay#">
</cfif>
<cfif #len(lngMonth)# LT 2>
	<cfset lngMonth = "0" & "#lngMonth#">
</cfif>
<cfset strDate = "#lngDay#" & "#lngMonth#" & "#lngYear#">

<cfset lngStoreID = #session.storeid#>

<CFSET strValidDate = ''>
<CF_ValidateSaturday strDateValue= "#strDate#">

<!--- Make sure that the date belongs to a Saturday --->
<cfif #strValidDate# EQ "Y">
    <!--- Make sure that this week information already exists --->
	<cfset strQuery = "SELECT tblEmpRoster.WeekEnding AS RosterWC, substring([WeekEnding],1,2) + '/' + substring([WeekEnding],3,2) + '/' + substring([WeekEnding],5,4) AS DateStringFormatted ">
	<cfset strQuery = strQuery & "FROM tblEmpRoster ">
	<cfset strQuery = strQuery & "GROUP BY tblEmpRoster.WeekEnding, substring([WeekEnding],1,2) + '/' + substring([WeekEnding],3,2) + '/' + substring([WeekEnding],5,4), tblEmpRoster.StoreID ">
	<cfset strQuery = strQuery & "HAVING (((tblEmpRoster.WeekEnding)='#strDate#') AND ((tblEmpRoster.StoreID)=#lngStoreID#))">
	<CFQUERY name="CheckRoster" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="CheckRoster" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfif #CheckRoster.RecordCount# GT 0>
		<cflocation URL = "tblEmpRoster_RecordList.cfm?D=#strDate#">
	<cfelse>	
		<!--- Copy the lines to the Roster table and try again --->	
		<cfset strQuery = "INSERT INTO tblEmpRoster ( EmployeeID, StoreID, WeekEnding ) ">
		<cfset strQuery = strQuery & "SELECT tblEmployee.EmployeeID, tblEmployee.StoreID, '#strDate#' AS WeekEnding ">
		<cfset strQuery = strQuery & "FROM tblEmployee ">
		<cfset strQuery = strQuery & "WHERE (((tblEmployee.StoreID)=#lngStoreID#) AND ((tblEmployee.NoLongerUsed)=False))">
<!--- 
    <cfoutput><p>Inser Query: #strQuery#</p></cfoutput>
	<cfabort>
 --->
		<CFQUERY name="AddRosterLines" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="AddRosterLines" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cflocation URL = "tblEmpRoster_RecordList.cfm?D=#strDate#">
	</cfif>
<cfelse>
	<cflocation URL = "ValidDateMessage.cfm?message=Please select a Saturday">
</cfif>	


