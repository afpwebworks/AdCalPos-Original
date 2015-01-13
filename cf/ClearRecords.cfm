
<cfset strDateToday = "">
<cf_GetTodayDate>

<cfset strTomorrowDate = "">
<cf_GetTomorrowDate>

<cfset strYestDate = "">	
<cf_GetXDaysFromNow	baseDate = "#strDateToday#" numDays = -1>
<cfset strYestDate = #strNextDate#>

<!--- convert dates to numeric format --->
	<cfset TodayDay = #mid(strDateToday,1,2)# >
	<cfset TodayMonth = #mid(strDateToday,3,2)# >
	<cfset TodayYear = #mid(strDateToday,5,4)# >
	<cfset strDateTodayLong =  "#numberformat(TodayYear,"0000")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(TodayDay,"00")#" >

	<cfset TodayDay = #mid(strTomorrowDate,1,2)# >
	<cfset TodayMonth = #mid(strTomorrowDate,3,2)# >
	<cfset TodayYear = #mid(strTomorrowDate,5,4)# >
	<cfset strTomorrowDateLong =  "#numberformat(TodayYear,"0000")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(TodayDay,"00")#" >

<cfset YestDay = #mid(strYestDate,1,2)# >
	<cfset YestMonth = #mid(strYestDate,3,2)# >
	<cfset YestYear = #mid(strYestDate,5,4)# >
	<cfset strYestDateLong =  "#numberformat(YestYear,"0000")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(YestDay,"00")#" >

<!--- <cfscript>
	function buildQuery(argumentsCollection){
		 
</cfscript> ---> 

<cfset cleartblEODSummary = " DELETE FROM  tblEODSummary WHERE DATE='#strDateToday#'">
                 
<cfset cleartblStore_PLUTotals = " DELETE FROM  tblStore_PLUTotals WHERE DATE='#strDateTodayLong#'">

<cfset cleartblStore_ECRTotals = " DELETE FROM  tblStore_ECRTotals WHERE DATE='#strDateTodayLong#'">

<cfset cleartblStore_CashInDraw = "DELETE FROM  tblStore_CashInDraw WHERE  DATE='#strDateTodayLong#'">
<!--- <cfset cleartblStockLocation = " DELETE FROM  tblStockLocation WHERE DateEntered='#strDateTodayLong#'"> --->

<cfset cleartblStockHistStart = " DELETE FROM tblStockHistStart WHERE 								tblStockHistStart.DDate = '#strTomorrowDateLong#' " >

<cfset cleartblStore_OperatorTotals = " DELETE FROM tblStore_OperatorTotals WHERE 								Date = '#strDateTodayLong#' " >

<cfset cleartblStockHistEnding = " DELETE FROM tblStockHistEnding WHERE 								DDate = '#strDateTodayLong#' " >

<cfset cleartblEODAutomatedlog = " DELETE FROM tblEODAutomatedlog WHERE 								TheDate ='#strYestDateLong#' " >

<cfset cleartblEODAutomated = " DELETE FROM tblEODAutomated WHERE 								TheDate = '#strDateTodayLong#' or TheDate ='#strYestDateLong#'" >

<cftransaction>
<!--- <CFQUERY name="StockLocation" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(cleartblStockLocation)#
				</CFQUERY> --->
<CFQUERY name="tblStore_CashInDraw" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(cleartblStore_CashInDraw)#
				</CFQUERY>
<CFQUERY name="tblStore_ECRTotals" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(cleartblStore_ECRTotals)#
				</CFQUERY>
				
<CFQUERY name="tblStore_PLUTotals" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(cleartblStore_PLUTotals)#
				</CFQUERY>
<CFQUERY name="tblEODSummary" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(cleartblEODSummary)#
				</CFQUERY>
		
<CFQUERY name="tblStockHistStart " datasource="#application.dsn#" > 
					#PreserveSingleQuotes(cleartblStockHistStart)#
				</CFQUERY>

<CFQUERY name="tblStore_OperatorTotals" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(cleartblStore_OperatorTotals)#
				</CFQUERY>

<CFQUERY name="tblStockHistEnding" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(cleartblStockHistEnding)#
				</CFQUERY>
				
<CFQUERY name="tblEODAutomatedlog" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(cleartblEODAutomatedlog)#
				</CFQUERY>


<CFQUERY name="tblEODAutomated" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(cleartblEODAutomated)#
				</CFQUERY>
</cftransaction>

<cfoutput>Records deleted for #strDateToday# and #strTomorrowDate#</cfoutput>	OR
<br>
<cfoutput>Records deleted for #strDateTodayLong# and #strTomorrowDateLong#</cfoutput>	AND
<br>
<cfoutput>Records deleted for #strYestDate# and #strYestDateLong#</cfoutput>	
