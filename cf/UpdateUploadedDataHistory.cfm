
<CFIF ParameterExists(URL.SID)>
	<cfset lngSID = #URL.SID#>

	<!--- Get tomorrows date --->	
	<cfset strTomorrowDate = "">
	<cf_GetTomorrowDate>

	<!--- Get todays date --->	
	<cfset strDateToday = "">
	<cf_GetTodayDate>
	
    <!--- Mark the closing balance records  --->
	<cfset strQuery = "UPDATE (tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo) INNER JOIN tblStockHist ON tblStockLocation.PartNo = tblStockHist.PartNo SET tblStockHist.ClosingStock = [tblStockLocation].[QtyOnHand], tblStockHist.AverageCost = [tblStockLocation].[AverageCost], tblStockHist.RetailPrice = [tblStockLocation].[RetailPrice], tblStockHist.Cost = [tblStockMaster].[Cost], tblStockHist.Wholesale = [tblStockMaster].[Wholesale], tblStockHist.ClosingDate = '#strDateToday#' ">
	<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngSID#))">
	<CFQUERY name="UpdateClosingBal" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	
	
    <!--- Append the records to History archive table  --->
	<cfset strQuery = "UPDATE (tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo) INNER JOIN tblStockHist ON tblStockLocation.PartNo = tblStockHist.PartNo SET tblStockHist.ClosingStock = [tblStockLocation].[QtyOnHand], tblStockHist.AverageCost = [tblStockLocation].[AverageCost], tblStockHist.RetailPrice = [tblStockLocation].[RetailPrice], tblStockHist.Cost = [tblStockMaster].[Cost], tblStockHist.Wholesale = [tblStockMaster].[Wholesale], tblStockHist.ClosingDate = '#strDateToday#' ">
	<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngSID#))">
	<CFQUERY name="UpdateClosingBal" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	

	
    <!--- Add starting bal for tomorrow --->
	<cfset strQuery = "INSERT INTO tblStockHist ( PartNo, StoreID, DDate, StartingStock ) ">
	<cfset strQuery = strQuery & "SELECT tblStockLocation.PartNo, tblStockLocation.StoreID, '#strTomorrowDate#' AS MyDate, tblStockLocation.QtyOnHand AS StartingStock ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngSID#) AND ((tblStockMaster.PluType)='m' Or (tblStockMaster.PluType)='n'))">

	<CFQUERY name="AddStartingBalForTomorrow" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <cfoutput>Success</cfoutput>
</cfif>	
