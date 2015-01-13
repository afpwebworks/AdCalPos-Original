
<cfset strDateToday ="">
<cf_GetTodayDate>

<!---			OK BUTTON (edit page)				--->
<CFIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>

	<cfset lngStoreID = #session.storeid#>	
	<cfset lngEmployeeID = #session.employeeID#>	
	<cfset strPartNo = ''>	
	<cfset dblB4_QtyOnHand = 0>	
	<cfset dblB4_Prev_QtyOnHand = 0>	
	<cfset dblB4_Freezer_QtyOnHand = 0>	
	<cfset dblB4_CoolRoom_QtyOnHand = 0>	
	<cfset dblB4_Display_QtyOnHand = 0>	
	<cfset dblAF_QtyOnHand = 0>	
	<cfset dblAF_Prev_QtyOnHand = 0>	
	<cfset dblAF_Freezer_QtyOnHand = 0>	
	<cfset dblAF_CoolRoom_QtyOnHand = 0>	
	<cfset dblAF_Display_QtyOnHand = 0>	
	<cfset dblWholesale = 0>	
	<cfset dblLastCost = 0 >	
	
    <!--- Check the existing values --->
	<cfset strQuery = "SELECT tblStockLocation.ID, tblStockMaster.Wholesale, tblStockLocation.StoreID, tblStockLocation.PartNo, tblStockLocation.LastCost, tblStockLocation.AverageCost, tblStockLocation.QtyOnHand, tblStockLocation.Prev_QtyOnHand, tblStockLocation.Freezer_QtyOnHand, tblStockLocation.CoolRoom_QtyOnHand, tblStockLocation.Display_QtyOnHand ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<cfset strQuery = strQuery & "WHERE (((tblStockLocation.ID)=#Form.RecordID#))">
	<CFQUERY name="CheckRecord" datasource="#application.dsn#" > 
	<!--- <CFQUERY  name="CheckRecord" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
    
	<cfif #CheckRecord.RecordCount# GT 0>
		<cfset strPartNo = #CheckRecord.PartNo#>	
		<cfset dblB4_QtyOnHand = #CheckRecord.QtyOnHand#>	
		<cfset dblB4_Prev_QtyOnHand = #CheckRecord.Prev_QtyOnHand#>	
		<cfset dblB4_Freezer_QtyOnHand = #CheckRecord.Freezer_QtyOnHand#>	
		<cfset dblB4_CoolRoom_QtyOnHand = #CheckRecord.CoolRoom_QtyOnHand#>	
		<cfset dblB4_Display_QtyOnHand = #CheckRecord.Display_QtyOnHand#>	
		<cfset dblWholesale = #CheckRecord.Wholesale#>	
		<cfset dblLastCost = #CheckRecord.LastCost#>	
	</cfif>

    <!--- Check the new values --->
    <cfset dblTotal = #Form.Freezer_QtyOnHand# + #Form.CoolRoom_QtyOnHand# + #Form.Display_QtyOnHand# >	
	<cfset dblAF_QtyOnHand = #dblTotal#>	
	<cfset dblAF_Prev_QtyOnHand = #dblB4_QtyOnHand#>	
	<cfset dblAF_Freezer_QtyOnHand = #Form.Freezer_QtyOnHand#>	
	<cfset dblAF_CoolRoom_QtyOnHand = #Form.CoolRoom_QtyOnHand#>	
	<cfset dblAF_Display_QtyOnHand = #Form.Display_QtyOnHand#>	
	<cfset strAdjustReason = #Form.AdjustReason#>	
	
	
	<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.Freezer_QtyOnHand = #Form.Freezer_QtyOnHand#, tblStockLocation.CoolRoom_QtyOnHand = #Form.CoolRoom_QtyOnHand#, tblStockLocation.Display_QtyOnHand = #Form.Display_QtyOnHand#, tblStockLocation.QtyOnHand = #dblTotal# ">
	<cfset strQuery = strQuery & "WHERE (((tblStockLocation.ID)= #Form.RecordID# ))">

	<CFQUERY name="UpdateRecord" datasource="#application.dsn#" > 
	<!--- <CFQUERY  name="UpdateRecord" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Write a record into the log table --->
	<cfset strQuery = "INSERT INTO tblStocktakeLog ( StoreID, PartNo, EmployeeID, B4_QtyOnHand, B4_Prev_QtyOnHand, B4_Freezer_QtyOnHand, B4_CoolRoom_QtyOnHand, B4_Display_QtyOnHand, AF_QtyOnHand, AF_Prev_QtyOnHand, AF_Freezer_QtyOnHand, AF_CoolRoom_QtyOnHand, AF_Display_QtyOnHand, ReasonCode ) ">
	<cfset strQuery = strQuery & "Values (#lngStoreID#, '#strPartNo#',#lngEmployeeID#, #dblB4_QtyOnHand#, #dblB4_Prev_QtyOnHand#, #dblB4_Freezer_QtyOnHand#, #dblB4_CoolRoom_QtyOnHand#, #dblB4_Display_QtyOnHand#, #dblAF_QtyOnHand#, #dblAF_Prev_QtyOnHand#, #dblAF_Freezer_QtyOnHand#, #dblAF_CoolRoom_QtyOnHand#, #dblAF_Display_QtyOnHand#, '#strAdjustReason#' )">
	<CFQUERY name="WriteLog" datasource="#application.dsn#" > 
	<!--- <CFQUERY  name="WriteLog" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Write a record into the log table --->
	<!--- 
	<cfset strQuery = "INSERT INTO tblStocktakeLogVariance ( StoreID, PartNo, EmployeeID, Wholesale,  B4_QtyOnHand, AF_QtyOnHand, ReasonCode, AdjustingScreen ,DDate ) ">
	<cfset strQuery = strQuery & "Values (#lngStoreID#, '#strPartNo#',#lngEmployeeID#, #dblWholesale#,#dblB4_QtyOnHand#,   #dblAF_QtyOnHand#, '#strAdjustReason#', True , '#strDateToday#'  )">
	 --->
	<cfset strQuery = "INSERT INTO tblStocktakeLogVariance ( StoreID, PartNo, EmployeeID, Wholesale,  B4_QtyOnHand, AF_QtyOnHand, ReasonCode, AdjustingScreen ,DDate ) ">
	<cfset strQuery = strQuery & "Values (#lngStoreID#, '#strPartNo#',#lngEmployeeID#, #dblLastCost#,#dblB4_QtyOnHand#,   #dblAF_QtyOnHand#, '#strAdjustReason#', 1 , '#strDateToday#'  )">

	<CFQUERY name="WriteLogVariane" datasource="#application.dsn#" > 
	<!--- <CFQUERY  name="WriteLogVariane" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	<!--- Agjust the EOD summary and tran files --->
	<!--- KF amendment 111203, CF_ can't pass in variables, use CFINCLUDE --->

<!--- 	<cf_GetAdjustEODAfterStocktake PartNo = '#strPartNo#' QtyB4 = #dblB4_QtyOnHand# QtyAfter = #dblAF_QtyOnHand# Cost = #dblLastCost# storeid = #lngStoreID# > --->
    <cfset PartNo = '#strPartNo#'>
	<cfset QtyB4 = #dblB4_QtyOnHand#>
	<cfset QtyAfter = #dblAF_QtyOnHand#>
	<cfset Cost = #dblLastCost#>
	<cfset storeid = #lngStoreID# >
	<cfINCLUDE TEMPLATE="GetAdjustEODAfterStocktake.CFM">
	
	<!--- Reset flag in the tblStocktakeLogVariance --->
	<cfset strQuery = "update tblStocktakeLogVariance set EOD_NeedsAdjusting = 0 ">
	<cfset strQuery = strQuery & "FROM tblStocktakeLogVariance ">
	<cfset strQuery = strQuery & "WHERE (tblStocktakeLogVariance.PartNo = '#strPartNo#' ) AND (tblStocktakeLogVariance.StoreID = #lngStoreID#) ">
	<CFQUERY name="ResetFlags" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	
		<CFLOCATION url="StockTake_Variance.cfm?cmbDeptNo=0&dd=#Form.RecordID#">
	</CFIF>
<!---			CANCEL BUTTON (edit page)			--->
<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>
	<CFLOCATION url="StockTake_Variance.cfm?cmbDeptNo=0&dd=#Form.RecordID#">
</CFIF>
