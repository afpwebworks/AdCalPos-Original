
   <cfset strPageTitle = "End of day">
<cfif isdefined("URL.YCC")>
    <!--- 
     YCC Structure
     XX Password UserName 
	 
     XX is the length of username
     Last letter of the password is written in the front of it
     Last letter of the user name is written in the front of it
    --->
    <cfset lngLenUserName = #left(URL.YCC,2)#>
    <cfset lngLength = #len(URL.YCC)#>
    <cfset lngLenPassword = lngLength - lngLenUserName - 2>

    <cfset lngPositionUserName = 2 + lngLenPassword + 1>

    <cfset MyPassword = #mid(URL.YCC,3,lngLenPassword)# >	
    <cfset MyUserName = #mid(URL.YCC,lngPositionUserName,lngLenUserName)# >

<!--- 
    <cfset MyPassword = #right(MyPassword,1)# & #left(MyPassword,lngLenPassword - 1)# >	
    <cfset MyUserName = #right(MyUserName,1)# & #left(MyUserName,lngLenUserName - 1)# >
 --->	
    <cfset MyPassword =  #right(MyPassword,lngLenPassword - 1)# & #left(MyPassword,1)# >	
 	<cfset MyUserName =  #right(MyUserName,lngLenUserName - 1)#  & #left(MyUserName,1)# >

<!--- 
	<cfoutput><br>lngLenUserName: #lngLenUserName#</cfoutput>
	<cfoutput><br>lngLenPassword: #lngLenPassword#</cfoutput>
	<cfoutput><br>lngLength: #lngLength#</cfoutput>
	<cfoutput><br>lngPositionUserName: #lngPositionUserName#</cfoutput>		
	<cfoutput><br>MyPassword: #MyPassword#</cfoutput>
	<cfoutput><br>MyUserName: #MyUserName#</cfoutput>		
 --->	
	<!--- Perform the login here --->
    <cfset strQuery = "SELECT UserName, Password, * ">
    <cfset strQuery = strQuery & "FROM qryEmployee ">
    <cfset strQuery = strQuery & "WHERE ((upper([UserName])=upper('#MyUserName#')) AND (upper([Password])=upper('#MyPassword#')) AND (NoLongerUsed=0))">	
	<CFQUERY name="GetRecord" maxRows=1 dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
        #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
		
	<CFIF GetRecord.RecordCount is 1>
		<cfset session.logged ="YES">
		<cfset session.employeeID =#GetRecord.EmployeeID#>
		<cfset session.empfullname = "#GetRecord.FullName#">
		<cfset session.usertype ="#GetRecord.UserTypeID#">
		<cfset session.storeid =#GetRecord.StoreID#>
		<cfset session.storename =#GetRecord.StoreName#>	
		<cfset lngStoreID =#GetRecord.StoreID#>			
	<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="frmlogin.htm">
	</CFIF>
<cfelse>
	<cfif isdefined("Form.lngStoreID") >
		<cfset lngStoreID =#Form.lngStoreID#>
	<cfelse>
		<CFIF 
			ParameterExists(session.logged) and 
			ParameterExists(session.employeeID)
			>
			<CFIF (session.logged is "YES") and (session.employeeID GT 0) and (session.usertype  NEQ "NONE")>
				<cfset lngStoreID = #session.storeid#>
			<CFELSE>
				<cfset session.logged ="NO">
				<cfset session.employeeID =0>
				<cfset session.empfullname = "NA">		
				<cfset session.usertype ="NONE">
				<CFLOCATION url="frmlogin.htm">
			</CFIF>
		<CFELSE>
				<cfset session.logged ="NO">
				<cfset session.employeeID =0>
				<cfset session.empfullname = "NA">		
				<cfset session.usertype ="NONE">
				<CFLOCATION url="frmlogin.htm">
		</CFIF>
	</cfif>
</cfif>


<CFSET strDateToday = ''>
<CF_GetTodayDate>

<CFSET strDateField = ''>
<CFSET strDateWE = ''>
<CF_GetWeekEnding>

<!--- Check to see if the end of day has finished --->
	<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID, tblEodSummary.Eod_EndOfDayFinished ">
	<cfset strQuery = strQuery & "FROM tblEodSummary ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#) AND ((tblEodSummary.Eod_EndOfDayFinished)=1))">
	<CFQUERY name="CheckEODFinished" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
	<!--- <CFQUERY name="CheckEODFinished" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset lngEODFinished = 0>
	<cfif #CheckEODFinished.RecordCount# GT 0>
		<cfset lngEODFinished = 1>
	</cfif>

<!--- Check the non saved wastage records --->
	<cfset strQuery = "SELECT tblStockLocation.StoreID, tblStockLocation.Wastage ">
	<cfset strQuery = strQuery & "FROM tblStockLocation ">
	<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngStoreID#) AND ((tblStockLocation.Wastage)>0.00001))">
	<CFQUERY name="CheckNotSavedWastage" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
	<!--- <CFQUERY name="CheckNotSavedWastage" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset lngNotSavesWastage = 0>
	<cfif #CheckNotSavedWastage.RecordCount# GT 0>
		<cfset lngNotSavesWastage = 1>
	</cfif>

<!--- Check the non saved transfer records --->
	<cfset strQuery = "SELECT tblStockLocation.StoreID, tblStockLocation.TeansferQty ">
	<cfset strQuery = strQuery & "FROM tblStockLocation ">
	<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=2) AND ((tblStockLocation.TeansferQty)>0.00001))">
	<CFQUERY name="CheckNotSavedTransfer" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
	<!--- <CFQUERY name="CheckNotSavedTransfer" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset lngNotSavesTransfer = 0>
	<cfif #CheckNotSavedTransfer.RecordCount# GT 0>
		<cfset lngNotSavesTransfer = 1>
	</cfif>

	<!--- Get Cash In Draw --->
	<cfset strQuery = "SELECT tblStore_CashInDraw.ID, tblStore_CashInDraw.StoreID, 
	tblStore_CashInDraw.CashInDraw, 
	tblStore_CashInDraw.CreditInDraw, replace(str(datepart(dd, [date] ),2),' ','0') AS MyDay, 
	replace(str(datepart(mm, [date] ),2),' ','0') AS MyMonth, datepart(yyyy, [date] ) AS MyYear, 
	tblStore_CashInDraw.Date ">
	<cfset strQuery = strQuery & "FROM tblStore_CashInDraw ">
	<cfset strQuery = strQuery & "WHERE (tblStore_CashInDraw.StoreID=#lngStoreID#)  ">
	<cfset strQuery = strQuery & "and CONVERT(int, (substring('#strDateToday#', 5, 4))) = convert(int,year([Date])) "> 
	<cfset strQuery = strQuery & "and CONVERT(int, (substring('#strDateToday#', 3, 2))) = convert(int,month([Date])) ">
	<cfset strQuery = strQuery & "and CONVERT(int, (substring('#strDateToday#', 1, 2))) = convert(int,day([Date])) ">
	<cfset strQuery = strQuery & "ORDER BY tblStore_CashInDraw.ID">
	<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
	<CFQUERY name="CheckCashInDraw" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
	<!--- <CFQUERY name="CheckCashInDraw" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblCashInDrawCounted = 0>
	<cfset dblCreditInDrawCounted = 0>
	<cfif #CheckCashInDraw.RecordCount# GT 0>
		<cfset dblCashInDrawCounted = #CheckCashInDraw.CashInDraw#>		
		<cfset dblCreditInDrawCounted = #CheckCashInDraw.CreditInDraw#>
	</cfif>
	
	<!--- Get ECR Total --->
	<cfset strQuery = "SELECT tblStore_ECRTotals.ID, tblStore_ECRTotals.StoreID, tblStore_ECRTotals.CancellationD , tblStore_ECRTotals.RoundingsD , replace(str(datepart(dd, [date] ),2),' ','0') AS MyDay, replace(str(datepart(mm, [date] ),2),' ','0') AS MyMonth, datepart(yyyy, [date] ) AS MyYear, tblStore_ECRTotals.Date, tblStore_ECRTotals.FileName, tblStore_ECRTotals.DateEntered, tblStore_ECRTotals.TimeEntered, tblStore_ECRTotals.Time, tblStore_ECRTotals.Location, tblStore_ECRTotals.ScaleIDCode, tblStore_ECRTotals.RoundingsD, tblStore_ECRTotals.Discounts, tblStore_ECRTotals.DiscountD, tblStore_ECRTotals.CashSales, tblStore_ECRTotals.CashSalesD, tblStore_ECRTotals.CreditSales, tblStore_ECRTotals.CreditSalesD, tblStore_ECRTotals.EFTCashOut, tblStore_ECRTotals.EFTCashOutD, tblStore_ECRTotals.CashRefunds, tblStore_ECRTotals.CashRefundD, tblStore_ECRTotals.CreditRefunds, tblStore_ECRTotals.CreditRefundD, tblStore_ECRTotals.CashSalesGSTincD, tblStore_ECRTotals.CashSaleGSTfreeD, tblStore_ECRTotals.CreditSalesGSTincD, tblStore_ECRTotals.CreditSalesGSTfreeD, tblStore_ECRTotals.GSTCashSaleD, tblStore_ECRTotals.GSTCreditSaleD, tblStore_ECRTotals.CashIn, tblStore_ECRTotals.CashInD, tblStore_ECRTotals.CashOut, tblStore_ECRTotals.CashOutD, tblStore_ECRTotals.Cancellations, tblStore_ECRTotals.CancellationD, tblStore_ECRTotals.Sales ">
	<cfset strQuery = strQuery & "FROM tblStore_ECRTotals ">
	<cfset strQuery = strQuery & "WHERE (((tblStore_ECRTotals.StoreID)=#lngStoreID#) AND ((replace(str(datepart(dd, [date] ),2),' ','0'))='#mid(strDateToday,1,2)#') AND ((replace(str(datepart(mm, [date] ),2),' ','0'))='#mid(strDateToday,3,2)#') AND ((datepart(yyyy, [date] ))='#mid(strDateToday,5,4)#')) ">
	<cfset strQuery = strQuery & "ORDER BY tblStore_ECRTotals.ID">
	<CFQUERY name="CheckECRTotals" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
	<!--- <CFQUERY name="CheckECRTotals" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	<!--- Get the cash expenses --->
	<cfset strQuery = "SELECT SUM(TotalAmountIncGST) AS STotalAmountIncGST1, SUM(GST) AS SGST, SUM(TotalAmountIncGST - GST) AS ExGST ">
	<cfset strQuery = strQuery & "FROM dbo.tblSupplierTranDet ">
	<cfset strQuery = strQuery & "WHERE (StoreID = #lngStoreID#) AND (PurchaseDate = '#strDateToday#') AND (PaymentMethod = 'CSH')">	
	<CFQUERY name="GetCashExpenses" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblCashExpense = 0>
	<cfif #GetCashExpenses.RecordCount# gt 0>
		<cfif #IsNumeric(GetCashExpenses.STotalAmountIncGST1)#>
			<cfset dblCashExpense = #GetCashExpenses.STotalAmountIncGST1#>
		</cfif>
	</cfif>
	
	<cfset dblCashSalesD = 0>
	<cfset dblCreditSalesD = 0>
	<cfset dblRoundingsD = 0>
	<cfset dblCancellationD = 0>
    <cfset dblEFTCashout = 0 />
    <cfset dblCCInDraw = 0 />
	<cfset dblDiscountD = 0>
	<cfset dblCashWages = 0>
	<cfset dblMoneyInDraw = 0>
    <cfset dblNetCashInDraw = 0 />
    <cfset dblNetCreditInDraw = 0 />
	<cfset dblxTotal = 0>
	<cfset dblDifference = 0 >
	<cfset dblTotalCustomers = 0>
	<cfset dblCashSales = 0>
	<cfset dblCreditSales = 0>
	
	<cfif #CheckECRTotals.RecordCount# GT 0>
		<cfset dblCashSalesD = #CheckECRTotals.CashSalesD#>
		<cfset dblCreditSalesD = #CheckECRTotals.CreditSalesD#>
		<cfset dblRoundingsD = (#CheckECRTotals.RoundingsD#) / 100 >
        <cfset dblEFTCashout  = #CheckECRTotals.EFTCashOutD#>
		<cfset dblCancellationD = #CheckECRTotals.CancellationD#>
		<cfset dblDiscountD = #CheckECRTotals.DiscountD#>
		<cfset dblCashSales = #CheckECRTotals.CashSales#>
		<cfset dblCreditSales = #CheckECRTotals.CreditSales#>
	</cfif>
	
    <!---[   This definition of net cash in draw is now obsolete.  Changed at request of LM on 12/8/2010 - mk  ]---->
	<!---[   <cfset dblMoneyInDraw = #dblCashSalesD# + #dblCreditSalesD# - #dblCashExpense# -#dblCashWages# >   ]---->
    <cfset dblMoneyInDraw = dblCashSalesD + dblCreditSalesD>
    <cfset dblNetCashInDraw = dblCashSalesD - dblEFTCashout />
    <cfset dblNetCreditInDraw = dblCreditSalesD + dblEFTCashout />    
	<cfset dblxTotal = dblCashSalesD + dblCreditSalesD + dblDiscountD >    
	<!---[   <cfset dblDifference = dblCashInDrawCounted + dblCreditInDrawCounted - dblMoneyInDraw + dblCreditSalesD >   ]---->  
    <cfset dblDifference = dblCashInDrawCounted + dblCreditInDrawCounted - dblMoneyInDraw >   
	<cfset dblTotalCustomers = dblCashSales + dblCreditSales >    
	
	<cfset strQuery = "SELECT tblEmpRoster.RosterID, tblEmpRoster.EmployeeID, tblEmpRoster.StoreID, tblEmpRoster.WeekEnding, tblEmpRoster.#strDateField#Start AS RosterStart, tblEmpRoster.#strDateField#End AS RosterEnd ">
	<cfset strQuery = strQuery & "FROM tblEmpRoster ">
	<cfset strQuery = strQuery & "WHERE (((tblEmpRoster.StoreID)= #lngStoreID# ) AND ((tblEmpRoster.WeekEnding)= '#strDateWE#' )  AND ((tblEmpRoster.DatePaid)='' Or (tblEmpRoster.DatePaid) Is Null)  )">
	<CFQUERY name="CheckRoster" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
	<!--- <CFQUERY name="CheckRoster" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfoutput Query = "CheckRoster">
		<CFSET lngEmpID = #CheckRoster.EmployeeID# >
		<CFSET strRosterStart = #CheckRoster.RosterStart# >
		<CFSET strRosterEnd = #CheckRoster.RosterEnd# >			
	    <!--- Check to see if this line exist in the employee hours worked or not ---> 
		<cfset strQuery = "SELECT tblEmpHoursWorked.HoursWorkedID, tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID, tblEmpHoursWorked.DateWorked, tblEmpHoursWorked.StartTime, tblEmpHoursWorked.EndTime, tblEmpHoursWorked.StartRoster, tblEmpHoursWorked.EndRoster ">
		<cfset strQuery = strQuery & "FROM tblEmpHoursWorked ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.EmployeeID)= #lngEmpID# ) AND ((tblEmpHoursWorked.StoreID)= #lngStoreID# ) AND ((tblEmpHoursWorked.DateWorked)= '#strDateToday#' ))">
		<CFQUERY name="CheckHoursWorked" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
		<!--- <CFQUERY name="CheckHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckHoursWorked.RecordCount# LT 1>
			<!--- Add the information from the roster to hours worked --->
			<cfset strQuery = "INSERT INTO tblEmpHoursWorked ( WeekEnding, EmployeeID, StoreID, DateWorked, StartTime, EndTime, StartRoster, EndRoster ) ">
			<cfset strQuery = strQuery & "Values ('#strDateWE#', #lngEmpID# , #lngStoreID# , '#strDateToday#' , '#strRosterStart#' , '#strRosterEnd#'  , '#strRosterStart#' , '#strRosterEnd#' )">
			<CFQUERY name="InsertDataIntoHoursWorked" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
			<!--- <CFQUERY name="InsertDataIntoHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		</cfif>
	</cfoutput>
	
<cfset strQuery = "SELECT [GivenName] + ' ' + [Surname] AS FullName, tblEmpHoursWorked.HoursWorkedID, tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID, tblEmpHoursWorked.DateWorked, tblEmpHoursWorked.StartTime, tblEmpHoursWorked.EndTime, tblEmpHoursWorked.StartRoster, tblEmpHoursWorked.EndRoster, tblEmpHoursWorked.DatePaid, tblEmpHoursWorked.OtherStartTime, tblEmpHoursWorked.OtherEndTime, tblEmpHoursWorked.OtherTimeType, tblEmpHoursWorked.Bonus, tblEmpHoursWorked.Expenses ">
<cfset strQuery = strQuery & "FROM tblEmpHoursWorked INNER JOIN tblEmployee ON tblEmpHoursWorked.EmployeeID = tblEmployee.EmployeeID ">
<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.StoreID)= #lngStoreID# ) AND ((tblEmpHoursWorked.DateWorked)= '#strDateToday#' ) AND ((tblEmpHoursWorked.DatePaid) Is Null)) ">
<cfset strQuery = strQuery & "ORDER BY [GivenName] + ' ' + [Surname]">

<CFQUERY name="GetRecord" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
<!--- <CFQUERY name="GetRecord" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset strQuery = "SELECT tblTransferLog.StoreID, tblTransferLog.DateEntered, tblTransferLog.PartNo, tblStockMaster.Description, tblTransferLog.EmployeeID, tblTransferLog.TeansferQty, tblTransferLog.TransferToPlu, tblTransferLog.B4_QtyOnHand, tblTransferLog.ReasonCode, tblStockMaster.SupplyUnit ">
<cfset strQuery = strQuery & "FROM tblTransferLog INNER JOIN tblStockMaster ON tblTransferLog.PartNo = tblStockMaster.PartNo ">
<cfset strQuery = strQuery & "WHERE (tblTransferLog.StoreID =#lngStoreID# ) AND (day(tblTransferLog.DateEntered) = day(getDate()) ) AND (month(tblTransferLog.DateEntered) = month(getDate()) ) AND (year(tblTransferLog.DateEntered) = year(getDate()) ) ">

<CFQUERY name="GetTransfer" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
<!--- <CFQUERY name="GetTransfer" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset strQuery = "SELECT tblWastageLog.StoreID, tblWastageLog.DateEntered, tblWastageLog.LogID, tblWastageLog.PartNo, tblStockMaster.Description, tblWastageLog.EmployeeID, tblWastageLog.Wastage, tblWastageLog.B4_QtyOnHand, tblWastageLog.ReasonCode, tblStockMaster.SupplyUnit ">
<cfset strQuery = strQuery & "FROM tblWastageLog INNER JOIN tblStockMaster ON tblWastageLog.PartNo = tblStockMaster.PartNo ">
<cfset strQuery = strQuery & "WHERE (tblWastageLog.StoreID =#lngStoreID# ) AND (day(tblWastageLog.DateEntered) = day(getDate()) ) AND (month(tblWastageLog.DateEntered) = month(getDate()) ) AND (year(tblWastageLog.DateEntered) = year(getDate()) ) ">

<CFQUERY name="GetWastage" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
<!--- <CFQUERY name="GetWastage" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset lngDeptNo = 0>

<cfset lngStoreID = #session.storeid#>

<cfset strPageTitle = "Wastage Report">

<!--- Get the store name --->
<cfset strQuery = "Select * from tblStores ">
<cfset strQuery = strQuery & "Where StoreID = #lngStoreID#">
<CFQUERY name="GetStoreName" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
<!--- <CFQUERY name="GetStoreName" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strStoreName = "#GetStoreName.StoreName#">

<!--- get the Departments --->
<cfset strQuery = "SELECT tblStockDept.Dept, tblStockDept.DeptNo, Count(tblStockMaster.PartNo) AS CountOfPartNo ">
<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
<cfif lngDeptNo LT 1>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressStocktake)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType ='M') or (tblStockMaster.PluType ='N'))) ">
<cfelse>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressStocktake)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType ='M') or (tblStockMaster.PluType ='N'))  AND ((tblStockDept.DeptNo)= #lngDeptNo# ) ) ">
</cfif>
<cfset strQuery = strQuery & "GROUP BY tblStockDept.Dept, tblStockDept.DeptNo ">
<cfset strQuery = strQuery & "ORDER BY tblStockDept.DeptNo">

<CFQUERY name="GetDepartments" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetDepartments"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>



<!--- <CFIF ParameterExists(URL.cmbDeptNo)>
	<cfset lngDeptNo = #URL.cmbDeptNo#>
<cfelse>
	<cfset lngDeptNo = #Form.cmbDeptNo#>
</cfif> --->

<cfset lngDeptNo = 0>
<cfset lngStoreID = #session.storeid#>

<cfset strPageTitle = "Transfer Report">

<!--- Get the store name --->
<cfset strQuery = "Select * from tblStores ">
<cfset strQuery = strQuery & "Where StoreID = #lngStoreID#">
<CFQUERY name="GetStoreName" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
<!--- <CFQUERY name="GetStoreName" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strStoreName = "#GetStoreName.StoreName#">

<!--- get the Departments --->
<cfset strQuery = "SELECT tblStockDept.Dept, tblStockDept.DeptNo, Count(tblStockMaster.PartNo) AS CountOfPartNo ">
<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
<cfif lngDeptNo LT 1>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressStocktake)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType ='M') or (tblStockMaster.PluType ='N'))) ">
<cfelse>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressStocktake)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType ='M') or (tblStockMaster.PluType ='N'))  AND ((tblStockDept.DeptNo)= #lngDeptNo# ) ) ">
</cfif>
<cfset strQuery = strQuery & "GROUP BY tblStockDept.Dept, tblStockDept.DeptNo ">
<cfset strQuery = strQuery & "ORDER BY tblStockDept.DeptNo">

<CFQUERY name="GetDepartments" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetDepartments"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle#</cfoutput></TITLE>
<script language="JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%" border="0">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td colspan="2"> 
      <h2><cfoutput>#session.storename# #strPageTitle# #mid(strDateToday,1,2)#/#mid(strDateToday,3,2)#/#mid(strDateToday,5,4)# </cfoutput></h2>
    </td>
  </tr>
  <cfif #lngEODFinished# GT 0>
	  <tr valign="middle"> 
	 	<td colspan="3"> 
	      <h2>End of day has finished</h2>
	    </td>
	  </tr>
  </cfif>
</table>
<br>
<br>
<FORM action="EndOfDayAction.cfm" method="post">
<!--- Write down the date --->
<cfoutput>
<input type="hidden" name="strDateToday" value="#strDateToday#">	
<input type="hidden" name="strDateField" value="#strDateField#">	
<input type="hidden" name="strDateWE" value="#strDateWE#">	
<input type="hidden" name="lngStoreID" value="#lngStoreID#">		
<input type="hidden" name="strStoreName" value="#session.storename#">		
<input type="hidden" name="lngNumRecords" value="#GetRecord.RecordCount#">	
</cfoutput>
<table width="100%" border="0">
<tr>
 <td>
 <table width="50%" border="0">
  <tr>
    <td width="38%"><b>Hours Worked</b></td>
    <td align="left"><a href="HoursWorked.cfm"><font color="white">Adjust</font></a></td>
  </tr>
 </table> 
  </td>
 </tr>
  <tr>
    <td>
      <div align="left">
<table width="95%" border="1" cellspacing="0">
  <tr> 
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Name</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Start</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Finish</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Roster Start</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Roster Finish</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Bonus</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Expense</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Entitlement</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Entitle Start</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Entitle Finish</font></b></div>
    </td>
  </tr>
  <cfoutput Query ="GetRecord">
  <cfset lngLineNumber = #GetRecord.CurrentRow#>	
  <tr> 
    <td>
		<font face="Tahoma" size="2"><b>#GetRecord.FullName#</b></font>
	</td>
    <td> 
      <INPUT type="hidden" name="RosterID_Line#lngLineNumber#" value = "#GetRecord.HoursWorkedID#">
      <font face="Tahoma" size="2">#GetRecord.StartTime#</font>
    </td>
    <td> 
      <font face="Tahoma" size="2">#GetRecord.EndTime#</font>
    </td>	  
    <td>
		<font face="Tahoma" size="2">#GetRecord.StartRoster#</font>
	</td>
    <td>
		<font face="Tahoma" size="2">#GetRecord.EndRoster#</font>
	</td>
    <td> 
      <font face="Tahoma" size="2">#GetRecord.Bonus#</font>
    </td>
    <td> 
      <font face="Tahoma" size="2">#GetRecord.Expenses#</font>
    </td>	  
	<td align="center" valign="top">
	   <font face="Tahoma" size="2">#GetRecord.OtherTimeType#</font>
	</td>	
    <td> 
      <font face="Tahoma" size="2">#GetRecord.OtherStartTime#</font>
    </td>
    <td> 
      <font face="Tahoma" size="2">#GetRecord.OtherEndTime#</font>
    </td>	  
  </tr>
  </cfoutput>
</table>
</div>
 </td>
</tr>
  <tr>
    <td>&nbsp;</td>
</tr>	
<tr>
 <td>
 <table width="50%" border="0">
  <tr>
    <td width="38%"><b>Wastage</b></td>
    <td align="left"><a href="WastageSelection.cfm"><font color="white">Add</font></a></td>
  </tr>
  <cfif lngNotSavesWastage EQ 1>
  <tr>
    <td colspan="2"><font color="CC0000"><b>There are un-saved wastage records.  Please save them.</b></font></td>
  </tr>
  </cfif>
 </table> 
  </td>
 </tr>
  <tr>
    <td>
	<div align="left">
        <table width="65%" border="1" cellspacing="0">	   
          <tr> 
            <td><h4>Plu</h4></td>
            <td><h4>Description</h4></td>
            <td><div align="center"><h4>Unit</h4></div></td>
             <td><div align="right"><h4>Wastage</h4></div></td>
          </tr>
		  
  <cfoutput query = "GetWastage">
          <tr> 
            <td>
				<h4>#GetWastage.PartNo#&nbsp;</h4>
			</td>
            <td><h4>#GetWastage.Description#&nbsp;</h4></td>
            <td><div align="center"><h4>#GetWastage.SupplyUnit#&nbsp;</h4></div></td>
			<td>
				<div align="right"><h4>#NumberFormat(GetWastage.Wastage,"_____.000")#&nbsp;</h4></div>
			</td>
          </tr>
  </cfoutput>
        </table>
      </div>
 </td>
</tr>
<tr>
 <td>&nbsp;
 </td>
</tr> 
<tr>
 <td>
 <table width="50%" border="0">
  <tr>
    <td width="38%"><b>Transfer</b></td>
    <td align="left"><a href="TransferSelection.cfm"><font color="white">Add</font></a></td>
  </tr>
  <cfif lngNotSavesTransfer EQ 1>
  <tr>
    <td colspan="2"><font color="CC0000"><b>There are un-saved transfer records.  Please save them.</b></font></td>
  </tr>
  </cfif>

 </table> 
  </td>
 </tr>
 <tr>
  <td>
      <div align="Left">
        <table width="80%" border="1" cellspacing="0">
          <tr> 
            <td><h4>Plu</h4></td>
            <td><h4>Description</h4></td>
            <td><div align="right"><h4>Unit</h4></div></td>
            <td><div align="right"><h4>Transfer Qty</h4></div></td>
            <td><div align="right"><h4>To Plu</h4></div></td>
			<td><div align="right"><h4>To Plu Desc</h4></div></td>
          </tr>
  		<cfoutput query = "GetTransfer">
			<cfstoredproc procedure = "TransferToPLU" 
				dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  >

				<cfprocresult name = "rs1"  > 
				<cfprocparam type = "IN" CFSQLType = CF_SQL_VARCHAR
			 	value="#GetTransfer.TransferToPlu#" dbVarName = @TransferPLU>
			</cfstoredproc>
          <tr> 
            <td>
				<h4>#GetTransfer.PartNo#&nbsp;</h4>
			</td>
            <td><h4>#GetTransfer.Description#&nbsp;</h4></td>
            <td><div align="right"><h4>#GetTransfer.SupplyUnit#&nbsp;</h4></div></td>
			<td>
				<div align="right"><h4>#NumberFormat(GetTransfer.TeansferQty,"_____.000")#&nbsp;</h4></div>
			</td>
			<td>
				<div align="right"><h4>#GetTransfer.TransferToPlu#&nbsp;</h4></div>
			</td>
			<td>
				<div align="right"><h4>#rs1.Description#&nbsp;</h4></div>
			</td>
          </tr>
	  </cfoutput>
        </table>
      </div>
  </td>
 </tr>
 <tr>
  <td>&nbsp;</td>
 </tr> 
 <tr>
 <td>
 <table width="100%" border="0" cellspacing="0">
	 <tr><td><b>Till Summary</b></td></tr>
</table>
 <table width="100%" border="1" cellspacing="0">
  <tr> 
    <td> 
      <div align="left"><h4><b>Item:</b></h4></div>
    </td>
    <td> 
      <div align="center"><h4>Cash Sales</h4></div>
    </td>
    <td> 
      <div align="center"><h4>CC Sales</h4></div>
    </td>
    <td> 
      <div align="center"><h4>Rounding</h4></div>
    </td>
    <td> 
      <div align="center"><h4>Voids</h4></div>
    </td>
    <td> 
      <div align="center"><h4>Discount</h4></div>
    </td>
    <td> 
      <div align="center"><h4>Cash Expenses</h4></div>
    </td>
    <td> 
      <div align="center"><h4>X-Total</h4></div>
    </td>
    
     <td> 
      <div align="center"><h4>Cash Out</h4></div>
    </td>
     <td> 
      <div align="center"><h4>Cash In Draw</h4></div>
    </td>
     <td> 
      <div align="center"><h4>CC In Draw</h4></div>
    </td>
    
    
    
     <td> 
      <div align="center"><h4>Money In Draw</h4></div>
    </td>
    
    <td> 
      <div align="center"><h4>Cash Counted</h4></div>
    </td>
    <td> 
      <div align="center"><h4>CC Counted</h4></div>
    </td>
    <td> 
      <div align="center"><h4>+/-</h4></div>
    </td>
    <td> 
      <div align="center"><h4>Customers</h4></div>
    </td>
  </tr>
  <cfoutput>
  <tr> 
    <td><h4><b>Value:</b></h4></td>
    <td> 
      <div align="right"><h4>#numberFormat(dblCashSalesD,'________.00')#</h4></div>
    </td>
    <td> 
      <div align="right"><h4>#numberFormat(dblCreditSalesD,'________.00')#</h4></div>
    </td>
    <td> 
      <div align="right"><h4>#numberFormat(dblRoundingsD,'________.00')#</h4></div>
    </td>
    <td> 
      <div align="right"><h4>#numberFormat(dblCancellationD,'________.00')#</h4></div>
    </td>
    <td> 
      <div align="right"><h4>#numberFormat(dblDiscountD,'________.00')#</h4></div>
    </td>
    <td> 
      <div align="right"><h4>#numberFormat(dblCashExpense,'________.00')#</h4></div>
    </td>
    <td> 
      <div align="right"><h4>#numberFormat(dblxTotal,'________.00')#</h4></div>
    </td>
    <td> 
      <div align="right"><h4>#numberFormat(dblEFTCashout,'________.00')#</h4></div>
    </td>
    
    <td> 
      <div align="right"><h4>#numberFormat(dblNetCashInDraw,'________.00')#</h4></div>
    </td>
    <td> 
      <div align="right"><h4>#numberFormat(dblNetCreditInDraw,'________.00')#</h4></div>
    </td> 
    <td> 
      <div align="right"><h4>#numberFormat(dblMoneyInDraw,'________.00')#</h4></div>
    </td> 
    <td> 
      <div align="right"><h4>#numberFormat(dblCashInDrawCounted,'________.00')#</h4></div>
    </td> 
    <td> 
      <div align="right"><h4>#numberFormat(dblCreditInDrawCounted,'________.00')#</h4></div>
    </td>
    <td> 
      <div align="right"><h4>#numberFormat(dblDifference,'________.00')#</h4></div>
    </td>
    <td> 
      <div align="right"><h4>#numberFormat(dblTotalCustomers,'________')#</h4></div>
    </td>
  </tr>
  </cfoutput>
</table>

    
 </td>
 </tr>
 <tr>
 	<td align="center">&nbsp;		
		
	</td>
 </tr>
 <tr>
 	<td align="center">
		<cfif #lngEODFinished# EQ 0>
			<cfif (lngNotSavesWastage EQ 0) and (lngNotSavesTransfer EQ 0)>
				<input type="submit" name="submit" value="  Finish End Of Day  ">
			<cfelse>
				<font color="CC0000"><b>You can not finish now</b></font>
			</cfif>
		<cfelse>
			<font color="CC0000"><b>EOD Has Finished For Today</b></font>
		</cfif>	 
	</td>
 </tr>
</table>

</form>
</body>
</HTML>

