
	<cfset strUserName = #URL.UN#>
	<cfset strPassword = #URL.PA#>

	<cfset strQuery = "SELECT tblEmployee.EmployeeID, tblEmployee.UserName, tblEmployee.Password, tblEmployee.NoLongerUsed ">
	<cfset strQuery = strQuery & "FROM tblEmployee ">
	<cfset strQuery = strQuery & "WHERE (((tblEmployee.UserName)='#strUserName#') AND ((tblEmployee.Password)='#strPassword#') AND ((tblEmployee.NoLongerUsed)=0))">

	<CFQUERY name="CheckUserName" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="CheckUserName" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfif #CheckUserName.RecordCount# GT 0>
		<BR>success
	<cfelse>
		<BR>Not Found
	</cfif>
