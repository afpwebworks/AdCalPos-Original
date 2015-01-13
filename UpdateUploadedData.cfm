<CFIF ParameterExists(URL.SID)>
	<cfset lngSID = #URL.SID#>
	
	<!--- <cfset LocalAppCostiDB = "#Applic_AppRoot#costi_SQL_EOD.mdb" > --->
	<cfset LocalWebCostiDB = "#Applic_WebRoot#" >
	<!--- <cfset LocalAppCostiDB = "testodbc" > --->	
	 <cfset LocalAppCostiDB = "#Applic_AppRoot#">
	
     Check the upload table A 
	<cfset strQuery = "Select * from A_tblCheckUploadA IN ">
	<cfset strQuery = strQuery &" '#LocalWebCostiDB#C#lngSID#_Costi2000.mdb' ">
	
   	<CFQUERY name="CheckUploadA"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<!--- <cfif #CheckUploadA.RecordCount# EQ 2>
	<cfelse>
		<br>Upload error (A).  Database has not been uploaded correctly. 
		<cfabort>
	</cfif> --->
	
	<!--- <cfset strQuery = "Select * from A_tblCheckUploadA IN">
	<cfset strQuery = strQuery &" '#LocalWebCostiDB#C#lngSID#_Costi2000.mdb' ">
	
   	<CFQUERY name="CheckUploadA" 
		dataSource="#LocalAppCostiDB#"  
        username="" 
        password=""> 
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfoutput>'#LocalWebCostiDB#C#lngSID#_Costi2000.mdb'</cfoutput> --->
	 <!--- <cfif #CheckUploadA.RecordCount# EQ 2>
	<cfelse>
		<br>Upload error (A).  Database has not been uploaded correctly. 
		<cfabort>
	</cfif> ---> 
	
	<cfset strQuery = "Select * from Z_tblCheckUploadB IN">
	<cfset strQuery = strQuery & " '#LocalWebCostiDB#C#lngSID#_Costi2000.mdb' "> 
   	<CFQUERY name="CheckUploadB"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	<!--- <cfif #CheckUploadB.RecordCount# EQ 3>
	<cfelse>
		<br>Upload error (B).  Database has not been uploaded correctly. 
		<cfabort>
	</cfif> --->
	 
    <!--- Add ECR Totals --->
	<cfset strQuery = "INSERT INTO tblStore_ECRTotals ( StoreID, FileName, DateEntered, TimeEntered, [Date], [Time], Location, ScaleIDCode, RoundingsD, Discounts, DiscountD, CashSales, CashSalesD, CreditSales, CreditSalesD, EFTCashOut, EFTCashOutD, CashRefunds, CashRefundD, CreditRefunds, CreditRefundD, CashSalesGSTincD, CashSaleGSTfreeD, CreditSalesGSTincD, CreditSalesGSTfreeD, GSTCashSaleD, GSTCreditSaleD, CashIn, CashInD, CashOut, CashOutD, Cancellations, CancellationD, Sales ) ">
	<cfset strQuery = strQuery & "SELECT #lngSID# AS SID, ECRTotals.FileName, ECRTotals.DateEntered, ECRTotals.TimeEntered, ECRTotals.Date, ECRTotals.Time, ECRTotals.Location, ECRTotals.ScaleIDCode, ECRTotals.RoundingsD, ECRTotals.Discounts, ECRTotals.DiscountD, ECRTotals.CashSales, ECRTotals.CashSalesD, ECRTotals.CreditSales, ECRTotals.CreditSalesD, ECRTotals.EFTCashOut, ECRTotals.EFTCashOutD, ECRTotals.CashRefunds, ECRTotals.CashRefundD, ECRTotals.CreditRefunds, ECRTotals.CreditRefundD, ECRTotals.CashSalesGSTincD, ECRTotals.CashSaleGSTfreeD, ECRTotals.CreditSalesGSTincD, ECRTotals.CreditSalesGSTfreeD, ECRTotals.GSTCashSaleD, ECRTotals.GSTCreditSaleD, ECRTotals.CashIn, ECRTotals.CashInD, ECRTotals.CashOut, ECRTotals.CashOutD, ECRTotals.Cancellations, ECRTotals.CancellationD, ECRTotals.Sales ">

	<!--- <cfset strQuery = strQuery & "FROM ECRTotals IN 'E:\InetPub\vs166129\C#lngSID#_Costi2000.mdb'"> --->
<cfset strQuery = strQuery & "FROM ECRTotals IN"> 
<cfset strQuery = strQuery &" '#LocalWebCostiDB#C#lngSID#_Costi2000.mdb' "> 
   	<CFQUERY name="AddECRTotals"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Add Operator Totals --->
	<cfset strQuery = "INSERT INTO tblStore_OperatorTotals ( StoreID, FileName, DateEntered, TimeEntered, [Date], [Time], Location, ScaleIDCode, OperatorNumber, Customers, TotalD ) ">
	<cfset strQuery = strQuery & "SELECT #lngSID# AS SID, OperatorTotals.FileName, OperatorTotals.DateEntered, OperatorTotals.TimeEntered, OperatorTotals.Date, OperatorTotals.Time, OperatorTotals.Location, OperatorTotals.ScaleIDCode, OperatorTotals.OperatorNumber, OperatorTotals.Customers, OperatorTotals.TotalD ">

	<!--- <cfset strQuery = strQuery & "FROM OperatorTotals IN 'E:\InetPub\vs166129\C#lngSID#_Costi2000.mdb'"> --->
<cfset strQuery = strQuery & "FROM OperatorTotals IN ">
<cfset strQuery = strQuery &" '#LocalWebCostiDB#C#lngSID#_Costi2000.mdb' "> 
 
	<CFQUERY name="AddOperatorTotals"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Add Cash In Draw --->
	<!--- <cfset strQuery = "INSERT INTO tblStore_CashInDraw ( StoreID, CashInDraw, [Date] ) ">
	<cfset strQuery = strQuery & "SELECT #lngSID# AS SID, tblCashInDraw.CashInDraw, tblCashInDraw.Date ">
	<cfset strQuery = strQuery & "FROM tblCashInDraw IN 'E:\InetPub\vs166129\C#lngSID#_Costi2000.mdb'">
	<CFQUERY name="AddCashInDraw"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY> --->
<!-- Added CreditINDraw column --->
<!--- vishal --->
	<cfset strQuery = "INSERT INTO tblStore_CashInDraw ( StoreID, CashInDraw, CreditInDraw, [Date], Posted  ) ">
	<cfset strQuery = strQuery & "SELECT #lngSID# AS SID, tblCashInDraw.CashInDraw, tblCashInDraw.CreditInDraw, tblCashInDraw.Date, tblCashInDraw.Posted  ">
 	<cfset strQuery = strQuery & "FROM tblCashInDraw IN '#LocalWebCostiDB#C#lngSID#_Costi2000.mdb'" >
	
	
	<CFQUERY name="AddCashInDraw"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	 <cfoutput>Success</cfoutput>
    <!--- Update EOD Summary table --->
	<cfset strDateToday = ''>
	<cf_GetTodayDate>
	<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.Eod_ECR_CSV_Updated = 1, tblEodSummary.Eod_PLU_CSV_Updated = 1 ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngSID#))">
	<CFQUERY name="UpdateEODSummary"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!---   MH20030902  qty on hand is now reduced at eod
    <!--- Reduce the stock on hand based PLU Totals --->
    <!--- Mark the existing PLU Totals --->
	<cfset strQuery = "UPDATE C#lngSID#_PLUTotals INNER JOIN tblStockMaster ON C#lngSID#_PLUTotals.PLUNumber = tblStockMaster.PartNo SET C#lngSID#_PLUTotals.Posted = 1">
	<CFQUERY name="MarkPosted"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Add PLU Totals --->
	<cfset strQuery = "INSERT INTO tblStore_PLUTotals ( StoreID, FileName, DateEntered, TimeEntered, [Date], [Time], Location, ScaleIDCode, PLUNumber, TotalD, Quantity, TotalKg, PrePackTotalD, PrePackQuantity, PrePackTotalkg, Posted ) ">
	<cfset strQuery = strQuery & "SELECT #lngSID# AS SID, PLUTotals.FileName, PLUTotals.DateEntered, PLUTotals.TimeEntered, PLUTotals.Date, PLUTotals.Time, PLUTotals.Location, PLUTotals.ScaleIDCode, PLUTotals.PLUNumber, PLUTotals.TotalD, PLUTotals.Quantity, PLUTotals.TotalKg, PLUTotals.PrePackTotalD, PLUTotals.PrePackQuantity, PLUTotals.PrePackTotalkg, PLUTotals.Posted ">
	<cfset strQuery = strQuery & "FROM PLUTotals IN 'E:\InetPub\vs166129\C#lngSID#_Costi2000.mdb'">
	<CFQUERY name="AddPLUTotals"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Reduce the stock on hand based PLU Totals --->
	
	<cfset strQuery = "UPDATE C#lngSID#_PLUTotals INNER JOIN tblStockLocation ON C#lngSID#_PLUTotals.PLUNumber = tblStockLocation.PartNo SET tblStockLocation.QtyOnHand = [QtyOnHand]-CDbl(IIf(abs([TotalKg])>0.0001,[TotalKg],[Quantity])) ">
	<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngSID#))">
	<CFQUERY name="ReduceQtyInLocationTable"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
    --->
	
    <!--- Reduce the stock on hand based PLU Totals --->

    <!--- Add PLU Totals --->
	<cfset strQuery = "INSERT INTO tblStore_PLUTotals ( StoreID, FileName, DateEntered, TimeEntered, [Date], [Time], Location, ScaleIDCode, PLUNumber, TotalD, Quantity, TotalKg, PrePackTotalD, PrePackQuantity, PrePackTotalkg, Posted ) ">
	<cfset strQuery = strQuery & "SELECT #lngSID# AS SID, PLUTotals.FileName, PLUTotals.DateEntered, PLUTotals.TimeEntered, PLUTotals.Date, PLUTotals.Time, PLUTotals.Location, PLUTotals.ScaleIDCode, PLUTotals.PLUNumber, PLUTotals.TotalD, PLUTotals.Quantity, PLUTotals.TotalKg, PLUTotals.PrePackTotalD, PLUTotals.PrePackQuantity, PLUTotals.PrePackTotalkg, PLUTotals.Posted ">
	<cfset strQuery = strQuery & "FROM PLUTotals IN ">
	<cfset strQuery = strQuery &" '#LocalWebCostiDB#C#lngSID#_Costi2000.mdb' "> 
	<CFQUERY name="AddPLUTotals"  dataSource="spidert_Spider2"   >
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
   
</cfif>	
