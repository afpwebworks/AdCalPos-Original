
<!--- Get todays date --->
<CFSET strDateToday = ''>
<CF_GetTodayDate>

<CFSET lngStoreID = #session.storeid#>

<!--- check to see if a record for today exist in the tblEodSummary table with Eod_PLU_CSV_Updated, EodWasteUpdated, and EodTransferUpdated flaged as true --->
<cfset strQuery = "SELECT tblEodSummary.EodID ">
<cfset strQuery = strQuery & "FROM tblEodSummary ">
<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#) AND ((tblEodSummary.Eod_PLU_CSV_Updated)=1) AND ((tblEodSummary.EodTransferUpdated)=1) AND ((tblEodSummary.EodWasteUpdated)=1) AND ((tblEodSummary.EodStocktakeEnteredNotUpdated)=1))">  

<CFQUERY name="CheckItem" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfif #CheckItem.RecordCount# GT 0>
	<cfset strStocktakeHasData = 'Y'>	
<cfelse>
	<cfset strStocktakeHasData = 'N'>	
</cfif>
<CFSET Caller.strStocktakeHasData = '#strStocktakeHasData#'> 



