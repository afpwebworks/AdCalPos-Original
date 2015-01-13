

<cfset lngStoreID = #Form.txtStoreID#>

<!--- Write a query to select the store --->
<cfset strQuery = "SELECT tblStores.StoreID, tblStores.StoreName, tblStores.NoLongerUsed ">
<cfset strQuery = strQuery & "FROM tblStores ">
<cfset strQuery = strQuery & "WHERE tblStores.StoreID = #lngStoreID#">

<CFQUERY name="GetStores" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetStores" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset session.storeid =#GetStores.StoreID#>
<cfset session.storename =#GetStores.StoreName#>		

<CFLOCATION url="MainMenu.cfm">


