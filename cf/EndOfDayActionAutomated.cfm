
<cfset StartingTickCount = #gettickcount()#>
<cfset lngMainMenu = 0>
<cfif isdefined("URL.mn")>
	<cfset lngMainMenu = 1>
</cfif>	
<cfloop index="DayIndexNum" from="1" to = "2">
	<cfif #DayIndexNum# eq 1>
		<!--- Today is day before yesterday --->
		<!--- Tomorrow is yesterday --->
		<cfset strDateToday = "">
		<cf_GetTodayDate>
		<cfset strNextDate = "">	
		<cf_GetXDaysFromNow	baseDate = "#strDateToday#" numDays = -2>
		<cfset strDay1 = #strNextDate#>	
		<cfset strNextDate = "">	
		<cf_GetXDaysFromNow	baseDate = "#strDateToday#" numDays = -1>
		<cfset strDay2 = #strNextDate#>	
		<cfset strDateToday = #strDay1#>	
		<cfset strTomorrowDate = #strDay2#>	
	<cfelseif #DayIndexNum# eq 2>
		<cfset strDateToday = "">
		<cf_GetTodayDate>
		<cfset strNextDate = "">	
		<cf_GetXDaysFromNow	baseDate = "#strDateToday#" numDays = -1>
		<!--- Today is yesterday --->
		<!--- Tomorrow is today --->
		<cfset strTomorrowDate = #strDateToday#>
		<cfset strDateToday = #strNextDate#>	
	<cfelse>
		<cfabort>
	</cfif>
		
	<!--- convert dates to numeric format --->
	<cfset TodayDay = #mid(strDateToday,1,2)# >
	<cfset TodayMonth = #mid(strDateToday,3,2)# >
	<cfset TodayYear = #mid(strDateToday,5,4)# >
	<cfset strDateTodayLong =  "#numberformat(TodayYear,"0000")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(TodayDay,"00")#" >

	<cfset TodayDay = #mid(strTomorrowDate,1,2)# >
	<cfset TodayMonth = #mid(strTomorrowDate,3,2)# >
	<cfset TodayYear = #mid(strTomorrowDate,5,4)# >
	<cfset strTomorrowDateLong =  "#numberformat(TodayYear,"0000")#" & "#numberformat(TodayMonth,"00")#" & "#numberformat(TodayDay,"00")#" >
	
	<!--VP Get X days from now -->
	   	<cfset strQuery = "SELECT tblOptions.clearancedays  ">
		<cfset strQuery = strQuery & "FROM tblOptions ">
	<CFQUERY name="GetClearanceDays" datasource="#application.dsn#"  > <!--- <CFQUERY name="CheckEODSummaryFinishedAlready"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset lngNumDays = -#GetClearanceDays.clearancedays#>
	<cfset strNextDate = "">	
	<cf_GetXDaysFromNow	baseDate = "#strDateToday#" numDays = #lngNumDays#>
	<cfset earlierDate = #strNextDate#>	
	<cfset  strDF = "#mid(earlierDate,1,2)#">
	<cfset  strmF = "#mid(earlierDate,3,2)#">
	<cfset  strYF = "#mid(earlierDate,5,4)#">
	<cfset newDate=#strYF# & #strmF# & #strDF#>
	
	<!--- Do not do anything if there is a record in tblEODautomated table ---> 
   	<cfset strQuery = "select * from tblEODAutomated ">
	<cfset strQuery = strQuery & "where TheDate = #strDateTodayLong#">
	<CFQUERY name="CheckEODautomatedVal"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
    
	<cfif #CheckEODautomatedVal.RecordCount# LT 1>
		<!--- insert a record into tblEODautomated table ---> 
   		<cfset strQuery = "insert into tblEODAutomated (TheDate) ">
		<cfset strQuery = strQuery & "values (#strDateTodayLong#)">
		<CFQUERY name="InsertEODautomatedVal"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<cfoutput><BR>Automated end of day summary started #now()#</cfoutput>
	    <cfoutput><BR>strDateToday: #strDateToday#</cfoutput>	
    	<cfoutput><BR>strTomorrowDate: #strTomorrowDate#</cfoutput>	

		<cfoutput><BR><hr></cfoutput>
		<cfoutput><BR><h1>Automated end of day for #strDateToday#</h1></cfoutput>
	
	   	<cfset strQuery = "SELECT StoreID, StoreName ">
		<cfset strQuery = strQuery & "FROM dbo.tblStores ">
		<cfset strQuery = strQuery & "WHERE (NoLongerUsed = 0) AND (StoreID > 0)">
		<CFQUERY name="GetTheStores"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfloop query ="GetTheStores">
		    <cfset lngStoreID =#GetTheStores.StoreID#>
			<cfoutput><BR><HR></cfoutput>
			<cfoutput><BR>Store #lngStoreID#</cfoutput>
				<!--- log it --->
			   	<cfset strQuery = "insert into tblEODAutomatedLog (TheDate , Store, Message ) ">
				<cfset strQuery = strQuery & "values (#strDateTodayLong# , #lngStoreID# , 'Automatic EOD Started')">
				<CFQUERY name="LogEvents"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
				</CFQUERY>
			<!--- If the EOD has already finished then do not update it again --->
		   	<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID, tblEodSummary.Eod_EndOfDayFinished ">
			<cfset strQuery = strQuery & "FROM tblEodSummary ">
			<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#) AND ((tblEodSummary.Eod_EndOfDayFinished)=1))">
			<CFQUERY name="CheckEODSummaryFinishedAlready"      datasource="#application.dsn#"  > <!--- <CFQUERY name="CheckEODSummaryFinishedAlready"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #CheckEODSummaryFinishedAlready.RecordCount# GT 0>
				<!--- End of day has finished for this store already --->
				<cfoutput><BR>End of day has already finished normally</cfoutput>
					<!--- log it --->
				   	<cfset strQuery = "insert into tblEODAutomatedLog (TheDate , Store, Message ) ">
					<cfset strQuery = strQuery & "values (#strDateTodayLong# , #lngStoreID# , 'EOD has already finished normally')">
					<CFQUERY name="LogEvents"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
					</CFQUERY>
			<cfelse>
			    <!--- Check to see if a record exist n the EOD summary for today --->
			   	<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID ">
				<cfset strQuery = strQuery & "FROM tblEodSummary ">
				<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
				<CFQUERY name="CheckEODSummary"      datasource="#application.dsn#"  > <!--- <CFQUERY name="CheckEODSummary"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
			
				<cfif #CheckEODSummary.RecordCount# LT 1>
					<!--- Add a record to EOD summary --->
				   	<cfset strQuery = "insert into tblEodSummary (Date, StoreID ) ">
					<cfset strQuery = strQuery & "values ('#strDateToday#', #lngStoreID# )">
					<CFQUERY name="AddDateToEODSummary"      datasource="#application.dsn#"  > <!--- <CFQUERY name="AddDateToEODSummary"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
						#PreserveSingleQuotes(strQuery)#
					</CFQUERY>
				</cfif>
			
			    <!--- Check to see if a record exist n the EOD summary for today --->
   	<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID ">
	<cfset strQuery = strQuery & "FROM tblEodSummary ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="CheckEODSummary"      datasource="#application.dsn#"  > <!--- <CFQUERY name="CheckEODSummary"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfif #CheckEODSummary.RecordCount# LT 1>
		<!--- Add a record to EOD summary --->
	   	<cfset strQuery = "insert into tblEodSummary (Date, StoreID ) ">
		<cfset strQuery = strQuery & "values ('#strDateToday#', #lngStoreID# )">
		<CFQUERY name="AddDateToEODSummary"      datasource="#application.dsn#"  > <!--- <CFQUERY name="AddDateToEODSummary"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	</cfif>

    <!--- Check to see if a record exist n the EOD summary for tomorrow --->
   	<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID ">
	<cfset strQuery = strQuery & "FROM tblEodSummary ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strTomorrowDate#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="CheckEODSummary2"      datasource="#application.dsn#"  > <!--- <CFQUERY name="CheckEODSummary2"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfif #CheckEODSummary2.RecordCount# LT 1>
		<!--- Add a record to EOD summary --->
	   	<cfset strQuery = "insert into tblEodSummary (Date, StoreID ) ">
		<cfset strQuery = strQuery & "values ('#strTomorrowDate#', #lngStoreID# )">
		<CFQUERY name="AddDateToEODSummary2"      datasource="#application.dsn#"  > <!--- <CFQUERY name="AddDateToEODSummary2"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	</cfif>
	
	<!--- mh 20030902 reduce the qty on hand here instead of the syncroniser --->
	<cfset strQuery = "select ID, ID_PluTotals, QtyOnHand, FinalQty,PCode, LastCost ">
	<cfset strQuery = strQuery & "FROM qryStore_PLUTotalsB ">
	<cfset strQuery = strQuery & "WHERE (Posted = 0) AND (sortedDate = #strDateTodayLong#) AND (StoreID = #lngStoreID# )">
	
	<CFQUERY name="ItemsToReduceQty"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	<cfloop query = "ItemsToReduceQty" >
	
	<cfif #ItemsToReduceQty.PCode# is 90>
		<!--- <cfset strQuery = "UPDATE tblStore_PLUTotals set posted = 1 FROM tblStore_PLUTotals WHERE ID = #ItemsToReduceQty.ID_PluTotals# ">
   	    <CFQUERY name="QR1"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		 --->
		<cfset strQuery = " select  distinct tblIngredient.ingredientPLU, tblIngredient.qtyIngredient from tblIngredient, qryStore_PLUTotalsB where qryStore_PLUTotalsB.PartNo=tblIngredient.SalePLU and qryStore_PLUTotalsB.ID=#ItemsToReduceQty.ID# group by tblIngredient.ingredientPLU,tblIngredient.qtyIngredient order by tblIngredient.ingredientPLU,tblIngredient.qtyIngredient"> 
		<CFQUERY name="QR0"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<cfloop query = "QR0">
		<cfset strQuery = "UPDATE tblStockLocation set QtyOnHand = QtyOnHand - (#QR0.qtyIngredient#*#ItemsToReduceQty.FinalQty#) FROM tblStockLocation WHERE partno = '#QR0.ingredientPLU#'">
 	    <CFQUERY name="QR3"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		</cfloop>
		<!---Update COGS --->
		<cfset strQuery = "UPDATE tblStore_PLUTotals set COGS=(#QR0.qtyIngredient#*#ItemsToReduceQty.FinalQty#)*#ItemsToReduceQty.LastCost# WHERE ID = #ItemsToReduceQty.ID_PluTotals# ">
		<CFQUERY name="QR4"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	<cfelse>
		
		<cfset strQuery = "UPDATE tblStore_PLUTotals set posted = 1 FROM tblStore_PLUTotals WHERE ID = #ItemsToReduceQty.ID_PluTotals# ">
   	    <CFQUERY name="QR1"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfset strQuery = "UPDATE tblStockLocation set QtyOnHand = QtyOnHand - #ItemsToReduceQty.FinalQty# FROM tblStockLocation WHERE ID = #ItemsToReduceQty.ID# ">
 	    <CFQUERY name="QR2"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfset strQuery = "UPDATE tblStore_PLUTotals set COGS=(#ItemsToReduceQty.FinalQty#*#ItemsToReduceQty.LastCost#) WHERE ID = #ItemsToReduceQty.ID_PluTotals# ">
		<CFQUERY name="QR5"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	</cfif>
	</cfloop>
	
	<!--- Summarize the plu stock ending for today --->
	<!--- 
   	<cfset strQuery = "INSERT INTO tblStockHistEnding ( PartNo, Wholesale, RetailPrice, StoreID, ClosingStock, DDate ) ">
	<cfset strQuery = strQuery & "SELECT tblStockMaster.PartNo, tblStockMaster.Wholesale, tblStockMaster.MaxRetail, tblStockLocation.StoreID, tblStockLocation.QtyOnHand, #strDateTodayLong# AS DDate ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PluType)='m' Or (tblStockMaster.PluType)='n') AND ((tblStockLocation.StoreID)=#lngStoreID#))">
	 --->
   	<cfset strQuery = "INSERT INTO tblStockHistEnding ( PartNo, Wholesale, RetailPrice, StoreID, ClosingStock, DDate ) ">
	<cfset strQuery = strQuery & "SELECT tblStockMaster.PartNo, tblStockLocation.LastCost, tblStockMaster.Wholesale, tblStockLocation.StoreID, tblStockLocation.QtyOnHand, #strDateTodayLong# AS DDate ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PluType)='m' Or (tblStockMaster.PluType)='n') AND ((tblStockLocation.StoreID)=#lngStoreID#))">
	<CFQUERY name="StockEndingSummary"      datasource="#application.dsn#"  > <!--- <CFQUERY name="StockEndingSummary"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Summarize the plu stock starting for tomorrow --->
	<!--- 
   	<cfset strQuery = "INSERT INTO tblStockHistStart ( PartNo, Wholesale, RetailPrice, StoreID, StartingStock, DDate ) ">
	<cfset strQuery = strQuery & "SELECT tblStockMaster.PartNo, tblStockMaster.Wholesale, tblStockMaster.MaxRetail, tblStockLocation.StoreID, tblStockLocation.QtyOnHand, #strTomorrowDateLong# AS DDate ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PluType)='m' Or (tblStockMaster.PluType)='n') AND ((tblStockLocation.StoreID)=#lngStoreID#))">
	 --->
   	<cfset strQuery = "INSERT INTO tblStockHistStart ( PartNo, Wholesale, RetailPrice, StoreID, StartingStock, DDate ) ">
	<cfset strQuery = strQuery & "SELECT tblStockMaster.PartNo, tblStockLocation.LastCost, tblStockMaster.Wholesale, tblStockLocation.StoreID, tblStockLocation.QtyOnHand, #strTomorrowDateLong# AS DDate ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PluType)='m' Or (tblStockMaster.PluType)='n') AND ((tblStockLocation.StoreID)=#lngStoreID#))">

	<CFQUERY name="StockBeginningSummary"      datasource="#application.dsn#"  > <!--- <CFQUERY name="StockBeginningSummary"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Get Stock Value --->
	<!--- 
   	<cfset strQuery = "SELECT Sum([Wholesale]*[QtyOnHand]) AS StockValue, tblStockLocation.StoreID ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PluType)='m' Or (tblStockMaster.PluType)='n')) ">
	<cfset strQuery = strQuery & "GROUP BY tblStockLocation.StoreID ">
	<cfset strQuery = strQuery & "HAVING (((tblStockLocation.StoreID)=#lngStoreID#))">
	 --->
   	<cfset strQuery = "SELECT Sum(tblStockLocation.LastCost *[QtyOnHand]) AS StockValue, tblStockLocation.StoreID ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<cfset strQuery = strQuery & "WHERE (tblStockMaster.PCode = 0 ) AND (  (tblStockMaster.PluType = 'm') Or (tblStockMaster.PluType = 'n')    ) ">
	<cfset strQuery = strQuery & "GROUP BY tblStockLocation.StoreID ">
	<cfset strQuery = strQuery & "HAVING (((tblStockLocation.StoreID)=#lngStoreID#))">
	<CFQUERY name="GetStockValue"      datasource="#application.dsn#"  > <!--- <CFQUERY name="GetStockValue"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblStockValue = 0>
	<cfif #GetStockValue.RecordCount# GT 0>
		<cfif #isnumeric(GetStockValue.StockValue)# >
			<cfset dblStockValue = #GetStockValue.StockValue#>
		</cfif>
	</cfif>
	
	<!--- Summarize the plu stock Value ending for today --->
   	<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.EndingStockValEx = #dblStockValue# ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="UpdateStockValueToday"      datasource="#application.dsn#"  > <!--- <CFQUERY name="UpdateStockValueToday"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Summarize the plu stock Value beginning for tomorrow --->
   	<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.StartingStockValEx = #dblStockValue# ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strTomorrowDate#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="UpdateStockValueTomorrow"      datasource="#application.dsn#"  > <!--- <CFQUERY name="UpdateStockValueTomorrow"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Total of the stocktake variace value --->
   	<cfset strQuery = "SELECT tblStocktakeLogVariance.StoreID, Sum([Wholesale]*([AF_QtyOnHand] - [B4_QtyOnHand])) AS dblValue ">
	<cfset strQuery = strQuery & "FROM tblStocktakeLogVariance ">
	<cfset strQuery = strQuery & "WHERE (((tblStocktakeLogVariance.DDate)='#strDateToday#')) ">
	<cfset strQuery = strQuery & "GROUP BY tblStocktakeLogVariance.StoreID ">
	<cfset strQuery = strQuery & "HAVING (((tblStocktakeLogVariance.StoreID)=#lngStoreID#))">
	<CFQUERY name="UpdateStocktakeVariance"      datasource="#application.dsn#"  > <!--- <CFQUERY name="UpdateStocktakeVariance"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblStockVarianceVal = 0>
	<cfif #UpdateStocktakeVariance.RecordCount# GT 0>
		<cfif #isnumeric(UpdateStocktakeVariance.dblValue)# >
			<cfset dblStockVarianceVal = #UpdateStocktakeVariance.dblValue#>
		</cfif>
	</cfif>
   	<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.StockVarianceValEx = #dblStockVarianceVal# ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="UpdateStocktakeVariance2"      datasource="#application.dsn#"  > <!--- <CFQUERY name="UpdateStocktakeVariance2"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Total of the stocktake variace value --->

   	<cfset strQuery = "SELECT Sum([SCtoStoreUnitPriceExG]*[QtySupplied]) AS dblValue ">
	<cfset strQuery = strQuery & "FROM tblOrderInvoiceHeader INNER JOIN tblOrderInvoiceDetail ON tblOrderInvoiceHeader.InvoiceID = tblOrderInvoiceDetail.InvoiceID ">
	<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceHeader.StoreID)=#lngStoreID#) AND ((tblOrderInvoiceHeader.InvoiceDate)='#strDateToday#'))">
	<CFQUERY name="GetPurchaseVal"      datasource="#application.dsn#"  > <!--- <CFQUERY name="GetPurchaseVal"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblPurchaseVal = 0>
	<cfif #GetPurchaseVal.RecordCount# GT 0>
		<cfif #isnumeric(GetPurchaseVal.dblValue)# >
			<cfset dblPurchaseVal = #GetPurchaseVal.dblValue#>
		</cfif>
	</cfif>
   	<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.PurchaseValEx = #dblPurchaseVal# ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="GetPurchaseVal2"      datasource="#application.dsn#"  > <!--- <CFQUERY name="GetPurchaseVal2"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	<!--- LM 2004-05-26 --->
				<!--- delete all records prior to today that had zero onhand --->
					<cfset strQuery = " DELETE FROM tblStockHistEnding ">
				<cfset strQuery = strQuery & "WHERE ">
				<cfset strQuery = strQuery & "tblStockHistEnding.StoreID=#lngStoreID#">
				<cfset strQuery = strQuery & " AND tblStockHistEnding.ClosingStock = 0	">	
				<cfset strQuery = strQuery & " AND tblStockHistEnding.DDate < '#newDate#' " >
				<CFQUERY name="StockEndingDeleteZeros" datasource="#application.dsn#"  > 
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
				
				<cfset strQuery = " DELETE FROM tblStockHistStart ">
				<cfset strQuery = strQuery & "WHERE ">
				<cfset strQuery = strQuery & "tblStockHistStart.StoreID=#lngStoreID#">
				<cfset strQuery = strQuery & " AND tblStockHistStart.StartingStock = 0	">	
				<cfset strQuery = strQuery & " AND tblStockHistStart.DDate < '#newDate#' " >
				<CFQUERY name="StockStartDeleteZeros" datasource="#application.dsn#"  > 
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
				<!--- End of deletions function --->			

	<!--- Mark End of Day Finished --->
   	<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.EodHoursWorkedUpdated = 1, tblEodSummary.EodWasteUpdated = 1, tblEodSummary.EodTransferUpdated = 1, tblEodSummary.Eod_EndOfDayFinished = 1 ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="UpdateEndOfDayFinished"      datasource="#application.dsn#"  > <!--- <CFQUERY name="UpdateEndOfDayFinished"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
   				<cfoutput><BR>End of day calculations finished by the automated program</cfoutput>
					<!--- log it --->
				   	<cfset strQuery = "insert into tblEODAutomatedLog (TheDate , Store, Message ) ">
					<cfset strQuery = strQuery & "values (#strDateTodayLong# , #lngStoreID# , 'Calculations finished by the automated program')">
					<CFQUERY name="LogEvents"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
					</CFQUERY>
			</cfif>
		</cfloop> 
		<!--- 
		<!--- insert a record into tblEODautomated table ---> 
   		<cfset strQuery = "insert into tblEODAutomated (TheDate) ">
		<cfset strQuery = strQuery & "values (#strDateTodayLong#)">
		<CFQUERY name="InsertEODautomatedVal"      datasource="#application.dsn#"  > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		 --->
	</cfif>			
</cfloop> 	
<cfset EndingTickCount = #gettickcount()#>
<cfset TimeUsed = EndingTickCount - StartingTickCount >
<cfoutput><BR><hr></cfoutput>
<cfoutput><BR>Total time used: #TimeUsed#</cfoutput>
<!--- Open up main menu --->
<cfif lngMainMenu eq 1>
	<CFLOCATION url="MainMenu.cfm">
</cfif>
	
