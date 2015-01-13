
<!--- Get todays date --->
<CFSET strDateToday = ''>
<CF_GetTodayDate>

<CFSET lngStoreID = #session.storeid#>


<!--- check to see if a record for today exist in the tblEodSummary table with Eod_PLU_CSV_Updated, EodWasteUpdated, and EodTransferUpdated flaged as true --->
<cfset strQuery = "SELECT tblEodSummary.EodID ">
<cfset strQuery = strQuery & "FROM tblEodSummary ">
<cfset strQuery = strQuery & "WHERE (tblEodSummary.Date = '#strDateToday#') AND (tblEodSummary.StoreID = #lngStoreID#) AND (tblEodSummary.Eod_EndOfDayFinished = 1)">

<CFQUERY name="CheckItem" datasource="#application.dsn#" > 

<!--- <CFQUERY name="CheckItem" DBTYPE="OLEDB" PROVIDER="SQLOLEDB" dataSource="vs139312_1" PROVIDERDSN="vs139312_1" USERNAME="vs139312_1_dbo" PASSWORD="gmsne4848n" DBNAME ="vs139312_1" DBSERVER="wic003q.server-sql.com\SQL3">  --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>


<cfif #CheckItem.RecordCount# GT 0>
	<cfset strEODFinished = 'Y'>	
<cfelse>
	<cfset strEODFinished = 'N'>	
</cfif>
<CFSET Caller.strEODFinished = '#strEODFinished#'> 



