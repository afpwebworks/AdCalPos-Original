
<!--- Get the main menu items --->
<cfset strQuery = "SELECT * from tblEmployee">

<CFQUERY name="GetEmployee" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfoutput><BR>#GetEmployee.RecordCount#</cfoutput>

<cfoutput query ="GetEmployee">
	<hr>
	<BR>#GetEmployee.employeeID#
	<BR>#GetEmployee.ColumnList#
</cfoutput>
