
<cfset strPageTitle = "Payment Application (4 / 3)">

<cfset lngAdjustID = #URL.adj#>

<cfif lngAdjustID EQ 0 >
	<!--- Apply the payment to an invoice --->

	<cfset lngStoreID = #URL.sid#>
	<cfset lngPymentID = #URL.pid#>
	<cfset lngInvoiceID = #URL.iid#>
<!--- 
	<cfoutput><br>lngStoreID: #lngStoreID#</cfoutput>
	<cfoutput><br>lngPymentID: #lngPymentID#</cfoutput>
	<cfoutput><br>lngInvoiceID: #lngInvoiceID#</cfoutput>
	<cfabort>
 --->	
	<CFSET strDateToday = ''>
	<CF_GetTodayDate>
   <!--- <cfoutput><BR>Marker 1</cfoutput> --->
	<!--- Write a query to select the payemnt --->
	<cfset strQuery = "SELECT * from qryPayment ">
	<cfset strQuery = strQuery & "WHERE PymentID=#lngPymentID#">

	<CFQUERY name="GetPayment" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetPayment" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset dblAmountAvailable = #NumberFormat(GetPayment.Value,"999999999.00")#>
	<cfif #dblAmountAvailable# LT 0.001>
		<cfoutput>
		<p>Amount of $#dblAmountAvailable# is too small to be applied</p>
		</cfoutput>
		<cfabort>
	</cfif>

	<!--- <cfoutput><br>#dblAmountAvailable#</cfoutput> --->

	<!--- select the invoices --->
	<cfset strQuery = "Select * from qryInvoiceDetailTotalPayApplication where InvoiceID = #lngInvoiceID#">
	<CFQUERY name="GetItems" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetItems" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
    <!--- <cfoutput><BR>Marker 2</cfoutput> --->

	<cfset dblInvoice = #NumberFormat(GetItems.AmountRemaining,"999999999.00")#>
	<!--- <cfoutput><br>#dblInvoice#</cfoutput> --->

	<cfif #dblAmountAvailable# GE #dblInvoice#>
		<cfset dblAmountToBeApplied = #dblInvoice#>
		<cfset bolFullyPaid = 1>	

		<cfset strQuery = "UPDATE tblOrderInvoiceHeader SET tblOrderInvoiceHeader.AmountApplied = [AmountApplied] + #dblAmountToBeApplied#, tblOrderInvoiceHeader.FullyApplied = 1 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceHeader.InvoiceID)=#lngInvoiceID#))">
	<cfelse>	
		<cfset dblAmountToBeApplied = #dblAmountAvailable#>
		<cfset bolFullyPaid = 0>	
	
		<cfset strQuery = "UPDATE tblOrderInvoiceHeader SET tblOrderInvoiceHeader.AmountApplied = [AmountApplied] + #dblAmountToBeApplied# ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceHeader.InvoiceID)=#lngInvoiceID#))">
	</cfif>

	<!--- <cfoutput><br>dblAmountToBeApplied: #dblAmountToBeApplied#</cfoutput> --->
    <!--- <cfoutput><BR>Marker 3</cfoutput> --->
	<!--- Save the Payment --->
	<CFQUERY name="UpdateInvoice" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdateInvoice" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
    <!--- <cfoutput><BR>Marker 4</cfoutput> --->

	<!--- Save into the Payment Application table --->
	<cfset strQuery = "INSERT INTO tblPaymentApplication ( StoreID, PymentID, InvoiceID, ApplicationDate, AmountApplied ) ">
	<cfset strQuery = strQuery & "Values (#lngStoreID#, #lngPymentID#, #lngInvoiceID#, '#strDateToday#', #dblAmountToBeApplied# ) ">

	<CFQUERY name="UpdatePaymentAppTable" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdatePaymentAppTable" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Save the payment --->
	<cfset dblPaymentRemaining = #dblAmountAvailable# - #dblAmountToBeApplied#>
	<cfif #dblPaymentRemaining# GT 0>
		<cfset strQuery = "UPDATE tblPayment SET tblPayment.AmountApplied = [AmountApplied] + #dblAmountToBeApplied# ">
		<cfset strQuery = strQuery & "WHERE (((tblPayment.PymentID)=#lngPymentID#))">
	<cfelse>
		<cfset strQuery = "UPDATE tblPayment SET tblPayment.AmountApplied = [AmountApplied] + #dblAmountToBeApplied#, tblPayment.FullyApplied = 1 ">
		<cfset strQuery = strQuery & "WHERE (((tblPayment.PymentID)=#lngPymentID#))">
	</cfif>
	<CFQUERY name="UpdatePayment" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdatePayment" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cflocation URL = "Payment_AppC.cfm?lngStoreID=#lngStoreID#&lngPymentID=#lngPymentID#">

<cfelseif lngAdjustID EQ 1>
	<!--- Reverse the application --->
	<!--- Apply the payment to an invoice --->

	<cfset lngPayApplicationID = #URL.aid#>
	<!--- 
	<cfoutput><br>lngStoreID: #lngStoreID#</cfoutput>
	<cfoutput><br>lngPymentID: #lngPymentID#</cfoutput>
	<cfoutput><br>lngInvoiceID: #lngInvoiceID#</cfoutput>
	 --->

	<!--- Read the Payment Application table --->
	<cfset strQuery = "Select * from tblPaymentApplication where ApplicationID = #lngPayApplicationID#">

	<CFQUERY name="GetPaymentAppTable" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetPaymentAppTable" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfif #GetPaymentAppTable.RecordCount# LT 1 >
		<cfoutput>
		<p>Can not find the application record ID #lngPayApplicationID#.  The process can not continue.</p>
		</cfoutput>
		<cfabort>
	</cfif>
	
	<CFSET dblAmountApplied = #GetPaymentAppTable.AmountApplied#>

	<cfif #dblAmountApplied# LT 0.001 >
		<cfoutput>
		<p>The applied amount $#dblAmountApplied# is too small to be removed from the invoices.  The process will not continue.</p>
		</cfoutput>
		<cfabort>
	</cfif>

	<cfset lngInvoiceID = #GetPaymentAppTable.InvoiceID#>		
	<cfset lngStoreID = #GetPaymentAppTable.StoreID#>
	<cfset lngPymentID = #GetPaymentAppTable.PymentID#>
	
	<!--- Remove the payment from the invoice --->
	<cfset strQuery = "UPDATE tblOrderInvoiceHeader SET tblOrderInvoiceHeader.AmountApplied = [AmountApplied] - #dblAmountApplied#, tblOrderInvoiceHeader.FullyApplied = 0 ">
	<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceHeader.InvoiceID)=#lngInvoiceID#))">
	<CFQUERY name="UpdateInvoice" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdateInvoice" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Remove changes from the payment --->
	<cfset strQuery = "UPDATE tblPayment SET tblPayment.AmountApplied = [AmountApplied] - #dblAmountApplied# , tblPayment.FullyApplied = 0  ">
	<cfset strQuery = strQuery & "WHERE (((tblPayment.PymentID)=#lngPymentID#))">
	<CFQUERY name="UpdatePayment" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdatePayment" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Remove the line from Payment App table --->
	<cfset strQuery = "Delete from tblPaymentApplication where ApplicationID = #lngPayApplicationID#">
	<CFQUERY name="UpdatePaymentAppTable" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdatePaymentAppTable" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cflocation URL = "Payment_AppC.cfm?lngStoreID=#lngStoreID#&lngPymentID=#lngPymentID#">
</cfif>
