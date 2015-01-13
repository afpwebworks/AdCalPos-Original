
<cfset lngDay=right(form.sDate,2)>
<cfset lngMonth=mid(form.sDate,5,2)>
<cfset lngYear=left(form.sDate,4)>

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
	<cfset strQuery = "Select * FROM tblEmployee ">
	<cfset strQuery = strQuery & "WHERE (((tblEmployee.StoreID)=#lngStoreID#) AND ((tblEmployee.NoLongerUsed)=0) AND ((tblEmployee.UserTypeID) <> 1) )">
	<CFQUERY name="GetEmployees" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetEmployees" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfloop query="GetEmployees">
		<cfset lngEmployeeID = #GetEmployees.EmployeeID#>
		<!--- <cfoutput><BR>lngEmployeeID: #lngEmployeeID#</cfoutput> --->
	    <!--- Make sure that this week information already exists --->
		<cfset strQuery = "SELECT tblEmpRoster.WeekEnding AS RosterWC, substring([WeekEnding],1,2) + '/' + substring([WeekEnding],3,2) + '/' + substring([WeekEnding],5,4) AS DateStringFormatted ">
		<cfset strQuery = strQuery & "FROM tblEmpRoster ">
		<cfset strQuery = strQuery & "GROUP BY tblEmpRoster.EmployeeID, tblEmpRoster.WeekEnding, substring([WeekEnding],1,2) + '/' + substring([WeekEnding],3,2) + '/' + substring([WeekEnding],5,4), tblEmpRoster.StoreID ">
		<cfset strQuery = strQuery & "HAVING ( ((tblEmpRoster.EmployeeID)=#lngEmployeeID#) AND ((tblEmpRoster.WeekEnding)='#strDate#') AND ((tblEmpRoster.StoreID)=#lngStoreID#))">
		<CFQUERY name="CheckRoster" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CheckRoster" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<cfif #CheckRoster.RecordCount# GT 0>
			<!--- <cfoutput><BR>Existed</cfoutput> --->
		<cfelse>	
			<!--- <cfoutput><BR>Added</cfoutput> --->
			<!--- Copy the lines to the Roster table and try again --->	
			<cfset strQuery = "INSERT INTO tblEmpRoster ( EmployeeID, StoreID, WeekEnding ) ">
			<cfset strQuery = strQuery & "SELECT tblEmployee.EmployeeID, tblEmployee.StoreID, '#strDate#' AS WeekEnding ">
			<cfset strQuery = strQuery & "FROM tblEmployee ">
			<cfset strQuery = strQuery & "WHERE ( ((tblEmployee.EmployeeID)=#lngEmployeeID#) AND ((tblEmployee.StoreID)=#lngStoreID#) AND ((tblEmployee.NoLongerUsed)=0))">
			<CFQUERY name="AddRosterLines" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="AddRosterLines" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		</cfif>
		<!--- <cfoutput><BR><hr></cfoutput> --->
	</cfloop>
	<!--- <cfabort> --->
	<cflocation URL = "tblEmpRoster_RecordList.cfm?D=#strDate#">
<cfelse>
	<cflocation URL = "ValidDateMessage.cfm?message=Please select a Saturday">
</cfif>	


