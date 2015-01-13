
<cfset lngStoreID = #Form.StoreID#>
<cfset lngEmployeeID = #Form.lngEmployeeID#>	

<CFIF ParameterExists(Form.CancelTask)>
	<cflocation URL = "StockTakeSelectionBL.cfm?sid=#lngStoreID#&eid=#lngEmployeeID#">
	<cfabort>
</cfif>

<!--- Process the results of the stocktake --->
<CFIF ParameterExists(Form.ProceedWithTask)>
	<cfset strDateToday ="">
	<cf_GetTodayDate>

	<cfset strTomorrowDate = "">
	<cf_GetTomorrowDate>
	
<cfset lngError = 0>
<cfset strError = ''>

<!--- <cfset FirstTime = #GetTickCount()#> --->

		<!--- Put all of the onhand figures in the previous on hand column --->
		<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.Prev_QtyOnHand = tblStockLocation.QtyOnHand ">
		<cfset strQuery = strQuery & "From tblStockLocation, tblStockMaster "> 
		<cfset strQuery = strQuery & "WHERE ((tblStockMaster.PCode) = 0 ) AND ((tblStockMaster.NoLongerUsed) = 0 ) AND  ((tblStockMaster.SuppressStocktake) = 0 ) AND  ( (tblStockMaster.PluType = 'M') or (tblStockMaster.PluType = 'N') ) AND (tblStockLocation.PartNo = tblStockMaster.PartNo) AND (tblStockLocation.StoreID=#lngStoreID#) ">

		<CFQUERY name="SaveQtyOnHand" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
<!--- 
<cfset SecondTime = #GetTickCount()#  - #FirstTime# >		
<cfoutput><BR>#SecondTime# : Put all of the onhand figures in the previous on hand column</cfoutput>
<cfset FirstTime = #GetTickCount()#>
 --->		
		<!--- Make sure that EOD Summary has some records --->
		<!--- KF amendment 111203, CF_ can't pass in variables, use CFINCLUDE --->		
		<!--- <cf_GetMakeSureOfEODSummaryRecords storeid = #lngStoreID# > --->
	    <cfinclude TEMPLATE="GetMakeSureOfEODSummaryRecords.cfm">
	
		<!--- Reset all flags in the tblStocktakeLogVariance --->
		<cfset strQuery = "update tblStocktakeLogVariance set EOD_NeedsAdjusting = 0 ">
		<cfset strQuery = strQuery & "FROM tblStocktakeLogVariance ">
		<cfset strQuery = strQuery & "WHERE (tblStocktakeLogVariance.StoreID = #lngStoreID#) and ((tblStocktakeLogVariance.EOD_NeedsAdjusting = 1 ) or (tblStocktakeLogVariance.EOD_NeedsAdjusting = -1 )) ">
		<CFQUERY name="ResetFlags" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="SaveLog" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
<!--- 
<cfset SecondTime = #GetTickCount()#  - #FirstTime# >		
<cfoutput><BR>#SecondTime# : Reset all flags in the tblStocktakeLogVariance</cfoutput>
<cfset FirstTime = #GetTickCount()#>
 --->		
		<cfset strQuery = "INSERT INTO tblStocktakeLogVariance ( StoreID, PartNo, Wholesale, B4_QtyOnHand, AF_QtyOnHand, EmployeeID, DDate , EOD_NeedsAdjusting ) ">
		<cfset strQuery = strQuery & "SELECT tblStockLocation.StoreID, tblStockLocation.PartNo, tblStockLocation.LastCost, tblStockLocation.QtyOnHand, [Freezer_QtyOnHand]+[Display_QtyOnHand]+[CoolRoom_QtyOnHand] AS NewQty, #lngemployeeID# AS EmployeeID , '#strDateToday#' as DDate , 1 ">
		<cfset strQuery = strQuery & "FROM tblStockLocation INNER JOIN tblStockMaster ON tblStockLocation.PartNo = tblStockMaster.PartNo ">
		<cfset strQuery = strQuery & "WHERE (  ((tblStockMaster.PCode) = 0 ) AND ((tblStockMaster.NoLongerUsed) = 0 ) AND  ((tblStockMaster.SuppressStocktake) = 0 ) AND  ( (tblStockMaster.PluType = 'M') or (tblStockMaster.PluType = 'N') ) AND   ((tblStockLocation.StoreID)=#lngStoreID#) AND ((Abs([Freezer_QtyOnHand]+[Display_QtyOnHand]+[CoolRoom_QtyOnHand]-[QtyOnHand]))>0.0001))">
		<CFQUERY name="SaveLog" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="SaveLog" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
<!--- 
<cfset SecondTime = #GetTickCount()#  - #FirstTime# >		
<cfoutput><BR>#SecondTime# : INSERT INTO tblStocktakeLogVariance</cfoutput>
<cfset FirstTime = #GetTickCount()#>
 --->		
		<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.QtyOnHand = [Freezer_QtyOnHand]+[Display_QtyOnHand]+[CoolRoom_QtyOnHand], tblStockLocation.ProcessedStockTake = 1 ">
		<cfset strQuery = strQuery & "From tblStockLocation, tblStockMaster "> 
		<cfset strQuery = strQuery & "WHERE (tblStockMaster.PCode = 0 ) AND (tblStockMaster.NoLongerUsed = 0 ) AND  (tblStockMaster.SuppressStocktake = 0 ) AND  ( (tblStockMaster.PluType = 'M') or (tblStockMaster.PluType = 'N') ) AND (tblStockLocation.PartNo = tblStockMaster.PartNo) AND (tblStockLocation.StoreID=#lngStoreID#) AND (Abs([Freezer_QtyOnHand]+[Display_QtyOnHand]+[CoolRoom_QtyOnHand]-[QtyOnHand]) > 0.0001) and (tblStockLocation.ProcessedStockTake = 0) ">
		<CFQUERY name="SaveQtyOnHand" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="SaveQtyOnHand" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
<!--- 
<cfset SecondTime = #GetTickCount()#  - #FirstTime# >		
<cfoutput><BR>#SecondTime# : UPDATE tblStockLocation SET tblStockLocation.QtyOnHand</cfoutput>
<cfset FirstTime = #GetTickCount()#>
 --->		
		
		<!--- If the store has not applied the initial stock take then do not check for any condition --->
		<cfset strQuery = "SELECT tblStores.StoreID, tblStores.StartingStockEntered ">
		<cfset strQuery = strQuery & "FROM tblStores ">
		<cfset strQuery = strQuery & "WHERE (tblStores.StoreID=#lngStoreID#) AND (tblStores.StartingStockEntered=0 )">
		<CFQUERY name="CheckInititalStocktake" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckInititalStocktake.RecordCount# GT 0>
			<!--- Change the flag to yes --->
			<cfset strQuery = "UPDATE tblStores SET tblStores.StartingStockEntered = 1 ">
			<cfset strQuery = strQuery & "WHERE (((tblStores.StoreID)=#lngStoreID#) AND ((tblStores.StartingStockEntered)=0))">
			<CFQUERY name="UpdateInititalStocktake" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		</cfif>
<!--- 
<cfset SecondTime = #GetTickCount()#  - #FirstTime# >		
<cfoutput><BR>#SecondTime# : If the store has not applied the initial stock take then</cfoutput>
<cfset FirstTime = #GetTickCount()#>
 --->	
	<!--- Update the EOD summary table --->
	<CFSET strDateToday = ''>
	<CF_GetTodayDate>
	
		<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.EodStocktakeEnteredNotUpdated = 0, tblEodSummary.EodStocktakeUpdated = 1 ">
		<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)= '#strDateToday#' ) AND ((tblEodSummary.StoreID)= #lngStoreID# ))">
		<CFQUERY name="UpdateSummaryApply" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="UpdateSummaryApply" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
<!--- 
<cfset SecondTime = #GetTickCount()#  - #FirstTime# >		
<cfoutput><BR>#SecondTime# : Mark end of stocktake</cfoutput>
<cfset FirstTime = #GetTickCount()#>
 --->		
		<!--- Make sure that there are 30 more lines in the EodSummary table --->
		<Cfset dteBaseDate = #now()#>        
		<cfloop INDEX="LoopCount" FROM="0" TO="30" STEP="1">
			<Cfset dteSpan = #CreateTimeSpan(LoopCount, 0, 0, 0)#>
			<Cfset dteNewDate = #dteBaseDate# + #dteSpan#>
			<Cfset lngDay = #Day(dteNewDate)#>
			<Cfset lngDay = #numberformat(lngDay , "00")#>
			<Cfset lngMonth = #month(dteNewDate)#>
			<Cfset lngMonth = #numberformat(lngMonth , "00")#>
			<Cfset lngYear = #year(dteNewDate)#>
			<Cfset strDate = "#lngDay##lngMonth##lngYear#" >	
		
			<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID ">
			<cfset strQuery = strQuery & "FROM tblEodSummary ">
			<cfset strQuery = strQuery & "WHERE (tblEodSummary.Date='#strDate#') AND (tblEodSummary.StoreID= #lngStoreID#)">
			<CFQUERY name="CheckDateIntoSummary" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #CheckDateIntoSummary.RecordCount# LT 1>
				<cfset strQuery = "INSERT INTO tblEodSummary ( [Date], StoreID ) ">
				<cfset strQuery = strQuery & "Values ( '#strDate#' , #lngStoreID# )">
				<CFQUERY name="InsertDateIntoSummary" datasource="#application.dsn#" > 
				<!--- <CFQUERY name="InsertDateIntoSummary" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
			</cfif>
		</cfloop>
<!--- 
<cfset SecondTime = #GetTickCount()#  - #FirstTime# >		
<cfoutput><BR>#SecondTime# : Add 30 lines to EOD Summary</cfoutput>
<cfset FirstTime = #GetTickCount()#>
 --->

<!--- pppppppppppppppppppppppppppp --->

   	<cfset strQuery = "SELECT Sum(tblStockLocation.LastCost *[QtyOnHand]) AS StockValue, tblStockLocation.StoreID ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<cfset strQuery = strQuery & "WHERE (tblStockMaster.PCode = 0 ) AND (  (tblStockMaster.PluType = 'm') Or (tblStockMaster.PluType = 'n')    ) ">
	<cfset strQuery = strQuery & "GROUP BY tblStockLocation.StoreID ">
	<cfset strQuery = strQuery & "HAVING (((tblStockLocation.StoreID)=#lngStoreID#))">
	<CFQUERY name="GetStockValue" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetStockValue" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblStockValue = 0>
	<cfif #GetStockValue.RecordCount# GT 0>
		<cfif #isnumeric(GetStockValue.StockValue)# >
			<cfset dblStockValue = #GetStockValue.StockValue#>
		</cfif>
	</cfif>
	
<!--- lm 23/01/2004
	<!--- Summarize the plu stock Value ending for today --->
   	<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.EndingStockValEx = #dblStockValue# ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="UpdateStockValueToday" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdateStockValueToday" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Summarize the plu stock Value beginning for tomorrow --->
   	<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.StartingStockValEx = #dblStockValue# ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strTomorrowDate#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="UpdateStockValueTomorrow" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdateStockValueTomorrow" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
 --->

	<!--- Total of the stocktake variace value --->
   	<cfset strQuery = "SELECT tblStocktakeLogVariance.StoreID, Sum([Wholesale]*([AF_QtyOnHand] - [B4_QtyOnHand])) AS dblValue ">
	<cfset strQuery = strQuery & "FROM tblStocktakeLogVariance ">
	<cfset strQuery = strQuery & "WHERE (((tblStocktakeLogVariance.DDate)='#strDateToday#')) ">
	<cfset strQuery = strQuery & "GROUP BY tblStocktakeLogVariance.StoreID ">
	<cfset strQuery = strQuery & "HAVING (((tblStocktakeLogVariance.StoreID)=#lngStoreID#))">
	<CFQUERY name="UpdateStocktakeVariance" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdateStocktakeVariance" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblStockVarianceVal = 0>
	<cfif #UpdateStocktakeVariance.RecordCount# GT 0>
		<cfif #isnumeric(UpdateStocktakeVariance.dblValue)# >
			<cfset dblStockVarianceVal = #UpdateStocktakeVariance.dblValue#>
		</cfif>
	</cfif>
	
<!--- lm 23/01/2004	
   	<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.StockVarianceValEx = #dblStockVarianceVal# ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="UpdateStocktakeVariance2" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdateStocktakeVariance2" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
 --->
 
<!--- 
<cfset SecondTime = #GetTickCount()#  - #FirstTime# >		
<cfoutput><BR>#SecondTime# : Recalculating the summary values</cfoutput>
<cfset FirstTime = #GetTickCount()#>
 --->
<!--- pppppppppppppppppppppppppppp --->

 <!--- 	mh20030902  This piece of code was taken out as it was causing the time out	 --->
 <!--- from here --->
 
		<!--- Adjust EOD tables --->
		<cfset strQuery = "select * from  tblStocktakeLogVariance ">
		<cfset strQuery = strQuery & "WHERE (StoreID = #lngStoreID# ) AND (EOD_NeedsAdjusting = 1 )">
		<CFQUERY name="UpdatedStockItems" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfloop query = "UpdatedStockItems" >
<!--- lm 23/01/2004
			<cfset My_strPartNo = #UpdatedStockItems.PartNo# > 
			<cfset My_dblB4_QtyOnHand = #UpdatedStockItems.B4_QtyOnHand# > 
			<cfset My_dblAF_QtyOnHand = #UpdatedStockItems.AF_QtyOnHand# > 
			<cfset My_dblLastCost = #UpdatedStockItems.Wholesale# > 
			<cf_GetAdjustEODAfterStocktake PartNo = '#My_strPartNo#' QtyB4 = #My_dblB4_QtyOnHand# QtyAfter = #My_dblAF_QtyOnHand# Cost = #My_dblLastCost# storeid = #lngStoreID# >
 --->
<!--- lm 23/01/2004 from here --->
			<cfset PartNo = #UpdatedStockItems.PartNo# > 
			<cfset QtyB4 = #UpdatedStockItems.B4_QtyOnHand# > 
			<cfset QtyAfter = #UpdatedStockItems.AF_QtyOnHand# > 
			<cfset Cost = #UpdatedStockItems.Wholesale# > 
			<cfset storeid = lngStoreID >

			<cfINCLUDE TEMPLATE="GetAdjustEODAfterStocktake.CFM">
<!--- lm 23/01/2004 to here --->

 		</cfloop>

<!--- <cfset SecondTime = #GetTickCount()#  - #FirstTime# >		
<cfoutput><BR>#SecondTime# : Adjust summary values</cfoutput>
<cfset FirstTime = #GetTickCount()#>
 --->
<!--- to here  --->		 
		
		<!--- Reset all flags in the tblStocktakeLogVariance --->
		<cfset strQuery = "update tblStocktakeLogVariance set EOD_NeedsAdjusting = 0 ">
		<cfset strQuery = strQuery & "FROM tblStocktakeLogVariance ">
		<cfset strQuery = strQuery & "WHERE (tblStocktakeLogVariance.StoreID = #lngStoreID#) ">
		<CFQUERY name="ResetFlagsAgain" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
<!--- 
<cfset SecondTime = #GetTickCount()#  - #FirstTime# >		
<cfoutput><BR>#SecondTime# : Reset flags on tblStocktakeLogVariance</cfoutput>
<cfset FirstTime = #GetTickCount()#>
		
<cfabort>
 --->		
		<cflocation URL = "StockTakeBL_Variance.cfm?cmbDeptNo=0&sid=#lngStoreID#&eid=#lngEmployeeID#&RequestTimeout=900">

</cfif>	
	  
