
<!--- Adjust EOD tables after the stocktake ---> 
<!--- KF amendment, no need for attributes scope as CFINCLUDE brings thru
variables anyway --->
<!--- 
<CFSET strPartNo = Attributes.PartNo >
<CFSET dblQtyB4 = Attributes.QtyB4 >
<CFSET dblQtyAfter = Attributes.QtyAfter >
<CFSET dblCost = Attributes.Cost >
<CFSET lngStoreID = Attributes.storeid >
 --->

<CFSET strPartNo = PartNo >
<CFSET dblQtyB4 = QtyB4 >
<CFSET dblQtyAfter = QtyAfter >
<CFSET dblCost = Cost >
<CFSET lngStoreID = storeid >

<!--- Get todays date --->
<CFSET strDateToday = ''>
<CF_GetTodayDate>

	<cfset lngDateLong = ''>
	<CF_GetDateLong baseDate = '#strDateToday#' >
	<CFSET strDateTodayLong = #lngDateLong# >

<!--- Get tomorrow date --->
<cfset strTomorrowDate = ''>
<CF_GetTomorrowDate>

	<cfset lngDateLong = ''>
	<CF_GetDateLong baseDate = '#strTomorrowDate#' >
	<CFSET strTomorrowDateLong = #lngDateLong# >

<CFSET dblQtyVariance = #dblQtyAfter# - #dblQtyB4# >
<CFSET dblValueVariance = #dblQtyVariance# * #dblCost# >

<!--- Update the Closing stock in EOD Summary for totday --->
<cfset strQuery = "update  tblEodSummary set EndingStockValEx = EndingStockValEx + #dblValueVariance# , StockVarianceValEx = StockVarianceValEx + #dblValueVariance# ">
<cfset strQuery = strQuery & "FROM tblEodSummary ">
<cfset strQuery = strQuery & "WHERE (tblEodSummary.Date = '#strDateToday#' ) AND (tblEodSummary.StoreID = #lngStoreID# ) ">  
<CFQUERY name="Adjust_EOD_EndingStock"  datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
</CFQUERY>


<!--- Update the Starting stock in EOD Summary for tomorrow --->
<cfset strQuery = "update  tblEodSummary set StartingStockValEx = StartingStockValEx + #dblValueVariance# ">
<cfset strQuery = strQuery & "FROM tblEodSummary ">
<cfset strQuery = strQuery & "WHERE (tblEodSummary.Date = '#strTomorrowDate#' ) AND (tblEodSummary.StoreID = #lngStoreID# ) ">  
<CFQUERY name="Adjust_EOD_StartingStock"  datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Update the Closing stock transaction file for totday --->
<cfset strQuery = "update tblStockHistEnding set ClosingStock = ClosingStock + #dblQtyVariance# ">
<cfset strQuery = strQuery & "FROM tblStockHistEnding ">
<cfset strQuery = strQuery & "WHERE (PartNo = '#strPartNo#' ) AND (StoreID = #lngStoreID# )  AND (DDate = #strDateTodayLong# ) ">  
<CFQUERY name="Adjust_EOD_StockEnding"  datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
</CFQUERY>


<!--- Update the Starting stock transaction file for tomorrow --->
<cfset strQuery = "update tblStockHistStart set StartingStock = StartingStock + #dblQtyVariance# ">
<cfset strQuery = strQuery & "FROM tblStockHistStart ">
<cfset strQuery = strQuery & "WHERE (PartNo = '#strPartNo#' ) AND (StoreID = #lngStoreID# )  AND (DDate = #strTomorrowDateLong# ) ">  
<CFQUERY name="Adjust_EOD_StockEnding"  datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
</CFQUERY>


