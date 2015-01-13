<cfif ParameterExists(form.txtUserName) AND ParameterExists(form.txtPassword) AND len(trim(form.txtUserName)) GT 1 AND len(trim(form.txtPassword)) GT 1>
    <cfset strQuery = "SELECT UserName, Password, * ">
    <cfset strQuery = strQuery & "FROM qryEmployee ">
    <cfset strQuery = strQuery & "WHERE ((Upper([UserName])=Upper('#Form.txtUserName#')) AND (Upper([Password])=Upper('#Form.txtPassword#')) AND (NoLongerUsed=0))">	
	<cfoutput><BR>strQuery: #strQuery#</cfoutput>
	<CFQUERY name="GetRecord" maxRows=1 dataSource="#application.dsn#" >
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
        #PreserveSingleQuotes(strQuery)#
	</CFQUERY>

		
	<CFIF GetRecord.RecordCount is 1>
		<cfset session.logged ="YES">
		<cfset session.employeeID =#GetRecord.EmployeeID#>
		<cfset session.empfullname = "#GetRecord.FullName#">
		<cfset session.usertype ="#GetRecord.UserTypeID#">
		<cfset session.storeid =#GetRecord.StoreID#>
		<cfset session.storename =#GetRecord.StoreName#>		
		<!--- <CFLOCATION url="MainMenu.cfm"> --->
		<CFLOCATION url="EndOfDayActionAutomated.cfm?mn=0">
	<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="/cf/frmLogin.htm">
	</CFIF>
<CFELSE>
    <cfset session.logged ="NO">
    <cfset session.employeeID =0>
    <cfset session.empfullname = "NA">		
	<cfset session.usertype ="NONE">
	<CFLOCATION url="/cf/frmLogin.htm">
</CFIF>

