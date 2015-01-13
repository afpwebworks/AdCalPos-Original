
<cfset lngSID = #Form.SID#>
<Cfset strWE = #Form.WE#>
<cfif #len(strWE)# LT 8>
	<cfset strWE = "0" & "#strWE#">
</cfif>
<cfset lngWID = #Form.WID#>
<cfset lngEmployeeID = #Form.EmployeeID#>
<cfset strPaymentMethod = #Form.cmbPaymentMethod#>
<cfset strRefrenceNum = #Form.RefNumber#>

<CFSET strDateToday = ''>
<CF_GetTodayDate>
<!--- Mark Roster --->
<cfset strQuery = "UPDATE tblEmpRoster SET tblEmpRoster.DatePaid = '#strDateToday#' ">
<cfset strQuery = strQuery & "WHERE (((tblEmpRoster.EmployeeID)=#lngEmployeeID#) AND ((tblEmpRoster.StoreID)=#lngSID#) AND ((tblEmpRoster.WeekEnding)='#strWE#'))">
<CFQUERY name="MarkRoster" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="MarkRoster" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Mark hours worked --->
<cfset strQuery = "UPDATE tblEmpHoursWorked SET tblEmpHoursWorked.DatePaid = '#strDateToday#' ">
<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.EmployeeID)=#lngEmployeeID#) AND ((tblEmpHoursWorked.StoreID)=#lngSID#) AND ((tblEmpHoursWorked.WeekEnding)='#strWE#'))">
<CFQUERY name="MarkHoursWorked" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="MarkHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Copy the line into paid table --->
<cfset strQuery = "INSERT INTO tblEmpPayRollPaid ( WageID, EmployeeID, GivenName, Surname, EmpStatusID, WeekEnding, StoreID, TaxScaleID, Age, NormalHours, OT1, OT2, NormalHoursPay, OT1Pay, OT2Pay, HolidayHrs, SickHrs, HolidayHrsCanBePaid, SickHrsCanBePaid, HolidayLoading, HolidayLoadingValue, HolidayHrsCanBePaidValue, SickHrsCanBePaidValue, Bonus, Expenses, ShiftAllowance, CarAllowance, OtherAllowance, SickMinsAccumultedBy100, LeaveMinsAccumultedBy100, SuperAccumulated, WorkCompAccumulated, TaxableIncome, NonTaxableIncome, PayChequeNo, PayPaidDate, Tax, TaxPaid, TaxChequeNo, TaxPaidDate, SuperPaid, SuperChequeNo, SuperPaidDate, PaymentMethod, ReferenceNumber ) ">
<cfset strQuery = strQuery & "SELECT tblEmpPayRoll.WageID, tblEmpPayRoll.EmployeeID, tblEmpPayRoll.GivenName, tblEmpPayRoll.Surname, tblEmpPayRoll.EmpStatusID, tblEmpPayRoll.WeekEnding, tblEmpPayRoll.StoreID, tblEmpPayRoll.TaxScaleID, tblEmpPayRoll.Age, tblEmpPayRoll.NormalHours, tblEmpPayRoll.OT1, tblEmpPayRoll.OT2, tblEmpPayRoll.NormalHoursPay, tblEmpPayRoll.OT1Pay, tblEmpPayRoll.OT2Pay, tblEmpPayRoll.HolidayHrs, tblEmpPayRoll.SickHrs, tblEmpPayRoll.HolidayHrsCanBePaid, tblEmpPayRoll.SickHrsCanBePaid, tblEmpPayRoll.HolidayLoading, tblEmpPayRoll.HolidayLoadingValue, tblEmpPayRoll.HolidayHrsCanBePaidValue, tblEmpPayRoll.SickHrsCanBePaidValue, tblEmpPayRoll.Bonus, tblEmpPayRoll.Expenses, tblEmpPayRoll.ShiftAllowance, tblEmpPayRoll.CarAllowance, tblEmpPayRoll.OtherAllowance, tblEmpPayRoll.SickMinsAccumultedBy100, tblEmpPayRoll.LeaveMinsAccumultedBy100, tblEmpPayRoll.SuperAccumulated, tblEmpPayRoll.WorkCompAccumulated, tblEmpPayRoll.TaxableIncome, tblEmpPayRoll.NonTaxableIncome, tblEmpPayRoll.PayChequeNo, tblEmpPayRoll.PayPaidDate, tblEmpPayRoll.Tax, tblEmpPayRoll.TaxPaid, tblEmpPayRoll.TaxChequeNo, tblEmpPayRoll.TaxPaidDate, tblEmpPayRoll.SuperPaid, tblEmpPayRoll.SuperChequeNo, tblEmpPayRoll.SuperPaidDate, '#strPaymentMethod#' AS Expr1, '#strRefrenceNum#' AS Expr2 ">
<cfset strQuery = strQuery & "FROM tblEmpPayRoll ">
<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WageID)=#lngWID#))">
<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
<CFQUERY name="CopyDataToPaidTable" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="CopyDataToPaidTable" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Delete info from the paid table --->
<cfset strQuery = "DELETE ">
<cfset strQuery = strQuery & "FROM tblEmpPayRoll ">
<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WageID)=#lngWID#))">
<CFQUERY name="DeleteDataFromPaurollTable" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="DeleteDataFromPaurollTable" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Add the leave hours and sick hours to the employee --->
<cfset strQuery = "UPDATE tblEmployee SET tblEmployee.SickMinsAccumultedBy100 = [tblEmployee].[SickMinsAccumultedBy100]+[tblEmpPayRollPaid].[SickMinsAccumultedBy100], tblEmployee.LeaveMinsAccumultedBy100 = [tblEmployee].[LeaveMinsAccumultedBy100]+[tblEmpPayRollPaid].[LeaveMinsAccumultedBy100] ">
<cfset strQuery = strQuery & "From tblEmployee, tblEmpPayRollPaid ">
<cfset strQuery = strQuery & "WHERE (tblEmpPayRollPaid.EmployeeID = tblEmployee.EmployeeID) AND (tblEmpPayRollPaid.WageID=#lngWID#)">
<!--- 
<cfset strQuery = "UPDATE tblEmpPayRollPaid INNER JOIN tblEmployee ON tblEmpPayRollPaid.EmployeeID = tblEmployee.EmployeeID SET tblEmployee.SickMinsAccumultedBy100 = [tblEmployee].[SickMinsAccumultedBy100]+[tblEmpPayRollPaid].[SickMinsAccumultedBy100], tblEmployee.LeaveMinsAccumultedBy100 = [tblEmployee].[LeaveMinsAccumultedBy100]+[tblEmpPayRollPaid].[LeaveMinsAccumultedBy100] ">
<cfset strQuery = strQuery & "WHERE (((tblEmpPayRollPaid.WageID)=#lngWID#))">
 --->
<CFQUERY name="IncreaseHolidayAndSick" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="IncreaseHolidayAndSick" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Decrease holiday claimed from employee --->
<cfset strQuery = "UPDATE tblEmployee SET tblEmployee.LeaveMinsAccumultedBy100 = [tblEmployee].[LeaveMinsAccumultedBy100]-(100*60*[tblEmpPayRollPaid].[HolidayHrsCanBePaid]) ">
<cfset strQuery = strQuery & "From tblEmployee, tblEmpPayRollPaid ">
<cfset strQuery = strQuery & "WHERE (tblEmpPayRollPaid.EmployeeID = tblEmployee.EmployeeID) AND (tblEmpPayRollPaid.WageID=#lngWID#) AND (tblEmpPayRollPaid.HolidayHrsCanBePaid > 0.0001)">
<!--- 
<cfset strQuery = "UPDATE tblEmpPayRollPaid INNER JOIN tblEmployee ON tblEmpPayRollPaid.EmployeeID = tblEmployee.EmployeeID SET tblEmployee.LeaveMinsAccumultedBy100 = [tblEmployee].[LeaveMinsAccumultedBy100]-(100*60*[tblEmpPayRollPaid].[HolidayHrsCanBePaid]) ">
<cfset strQuery = strQuery & "WHERE (((tblEmpPayRollPaid.WageID)=#lngWID#) AND ((tblEmpPayRollPaid.HolidayHrsCanBePaid)>0.0001))">
 --->
<CFQUERY name="DecreaseHolidayAndSick" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="DecreaseHolidayAndSick" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Decrease sick days claimed from employee --->
<cfset strQuery = "UPDATE tblEmployee SET tblEmployee.SickMinsAccumultedBy100 = [tblEmployee].[SickMinsAccumultedBy100]-(100*60*[tblEmpPayRollPaid].[SickHrsCanBePaid]) ">
<cfset strQuery = strQuery & "From tblEmployee, tblEmpPayRollPaid ">
<cfset strQuery = strQuery & "WHERE (tblEmpPayRollPaid.EmployeeID = tblEmployee.EmployeeID) AND (tblEmpPayRollPaid.WageID=#lngWID#) AND (tblEmpPayRollPaid.SickHrsCanBePaid > 0.0001)">
<!--- 
<cfset strQuery = "UPDATE tblEmpPayRollPaid INNER JOIN tblEmployee ON tblEmpPayRollPaid.EmployeeID = tblEmployee.EmployeeID SET tblEmployee.SickMinsAccumultedBy100 = [tblEmployee].[SickMinsAccumultedBy100]-(100*60*[tblEmpPayRollPaid].[SickHrsCanBePaid]) ">
<cfset strQuery = strQuery & "WHERE (((tblEmpPayRollPaid.WageID)=#lngWID#) AND ((tblEmpPayRollPaid.SickHrsCanBePaid)>0.0001))">
 --->
<CFQUERY name="DecreaseHolidayAndSickB" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="DecreaseHolidayAndSick" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfoutput>
	<cflocation URL = "PayrollSelectReportPage.cfm?WE=#strWE#&SID=#lngSID#">		
</cfoutput>
