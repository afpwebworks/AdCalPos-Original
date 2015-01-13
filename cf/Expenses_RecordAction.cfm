
<!---			NAVIGATION BUTTONS (view page)			--->

<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 	  	
	<!--- <CFQUERY name="GetRecord" dataSource="costi" maxRows=1> --->

		SELECT tblSupplierTranDet.SupplierTranDetID AS ID_Field
		FROM tblSupplierTranDet

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblSupplierTranDet.SupplierTranDetID < #Form.RecordID#
			ORDER BY tblSupplierTranDet.SupplierTranDetID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblSupplierTranDet.SupplierTranDetID > #Form.RecordID#
			ORDER BY tblSupplierTranDet.SupplierTranDetID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblSupplierTranDet.SupplierTranDetID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblSupplierTranDet.SupplierTranDetID > #Form.RecordID#
			ORDER BY tblSupplierTranDet.SupplierTranDetID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="Expenses_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="Expenses_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="Expenses_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="Expenses_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" >
	<!--- <CFQUERY name="DeleteRecord" dataSource="costi" maxRows=1> --->
		DELETE
		FROM tblSupplierTranDet
		WHERE tblSupplierTranDet.SupplierTranDetID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="Expenses_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<!--- Validate user input --->
	<cfset lngSupplierID = #Form.SupplierID#>
	<cfset strDescription = #Form.Description#>
	<cfset lngExpenseCatID = #Form.ExpenseCatID#>
	<cfset lngStoreID = #Form.StoreID#>
	<cfset strDate = #Form.PurchaseDate#>
	<cfset strInvoiceNumber = #Form.InvoiceNumber#>
	<cfset dblTotalAmountIncGST = #Form.TotalAmountIncGST#>
	<cfset dblGST = #Form.GST#>

	<cf_ValidateDate strDateValue ="#strDate#" lngWeekDay=0>
    <cfif #dblGST# GT (#dblTotalAmountIncGST# + 0.0001)>
		<cfset ErrorMessage = 'GST can not be larger than total amount'>
		<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
		<cfabort>
	</cfif>
    <cfif #dblGST# GT (0.2 * (#dblTotalAmountIncGST# + 0.0001))>
		<cfset ErrorMessage = 'GST is too large'>
		<CFLOCATION url="ValidDateMessage.cfm?message=#ErrorMessage#">
		<cfabort>
	</cfif>
	
	<CFIF ParameterExists(Form.RecordID)>
		<cfset lngSupplierTranDetID = #Form.SupplierTranDetID#>
		<cfset strQuery = "UPDATE tblSupplierTranDet SET tblSupplierTranDet.Description = '#strDescription#' ,tblSupplierTranDet.SupplierID = #lngSupplierID#, tblSupplierTranDet.PurchaseDate = '#strDate#', tblSupplierTranDet.InvoiceNumber = '#strInvoiceNumber#', tblSupplierTranDet.GST = #dblGST#, tblSupplierTranDet.TotalAmountIncGST = #dblTotalAmountIncGST#, tblSupplierTranDet.ExpenseCatID = #lngExpenseCatID#, tblSupplierTranDet.PaymentMethod = '#Form.PaymentMethod#' ">
		<cfset strQuery = strQuery & "WHERE (((tblSupplierTranDet.SupplierTranDetID)=#lngSupplierTranDetID#))">

		<CFQUERY name="UpdateData" datasource="#application.dsn#" >
		<!--- <CFQUERY  name="UpdateData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE dataSource="costi" tableName="tblSupplierTranDet" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="Expenses_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
<!--- 		<cfset strQuery = "insert into tblSupplierTranDet (StoreID, PurchaseDate, InvoiceNumber, GST, TotalAmountIncGST, ExpenseCatID) ">
		<cfset strQuery = strQuery & "values (#lngStoreID#, '#strDate#', '#strInvoiceNumber#', #dblGST#, #dblTotalAmountIncGST#, #lngExpenseCatID#)">
		<CFQUERY  name="InsertData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
 --->		<!--- <CFINSERT dataSource="costi" tableName="tblSupplierTranDet" formFields="#Form.FieldList#"> --->
       
	    <cfset lngStoreID = #Form.StoreID# >
		<cfset strQuery = "insert into tblSupplierTranDet (SupplierID, Description, PurchaseDate, InvoiceNumber, GST, TotalAmountIncGST , ExpenseCatID, StoreID, PaymentMethod ) ">
		<cfset strQuery = strQuery & "Values (#lngSupplierID#, '#strDescription#', '#strDate#', '#strInvoiceNumber#', #dblGST#, #dblTotalAmountIncGST#, convert(int,#lngExpenseCatID#), convert(int,#lngStoreID#) ,'#Form.PaymentMethod#')">
		<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
		<CFQUERY name="InsertTheData" datasource="#application.dsn#" >
		<!--- <CFQUERY  name="UpdateData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<!--- <CFINSERT datasource="#application.dsn#"  tableName="tblSupplierTranDet" formFields="StoreID,PurchaseDate,InvoiceNumber,GST,TotalAmountIncGST, ExpenseCatID"> --->
		<!--- <CFINSERT dataSource="costi" tableName="tblSupplierTranDet" formFields="StoreID,PurchaseDate,InvoiceNumber,GST,TotalAmountIncGST, ExpenseCatID"> --->

		
		<CFQUERY name="GetMyNewRecord" maxRows=1 datasource="#application.dsn#" >
		<!--- <CFQUERY name="GetMyNewRecord" dataSource="costi" maxRows=1> --->
			SELECT tblSupplierTranDet.SupplierTranDetID AS ID_Field
			FROM tblSupplierTranDet
			ORDER BY tblSupplierTranDet.SupplierTranDetID DESC
		</CFQUERY>
<!--- 		
		<cfoutput><BR>SupplierTranDetID: #GetMyNewRecord.ID_Field#</cfoutput>
		<!--- Give some time to the server to save the last record properly --->
		<cfoutput><BR>Time: #GetTickCount()#</cfoutput>
		<cf_GetWait MiliSeonds=500>
		<cfoutput><BR>Time: #GetTickCount()#</cfoutput>

		<CFQUERY name="GetMyNewRecord2" dataSource="costi" maxRows=1>
			SELECT tblSupplierTranDet.SupplierTranDetID AS ID_Field
			FROM tblSupplierTranDet
			ORDER BY tblSupplierTranDet.SupplierTranDetID DESC
		</CFQUERY>
		<cfoutput><BR>SupplierTranDetID: #GetMyNewRecord2.ID_Field#</cfoutput>
		<cfabort>
 --->		
		<CFLOCATION url="Expenses_RecordView.cfm?RecordID=#GetMyNewRecord.ID_Field#">
	</CFIF>

<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="Expenses_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="Expenses_RecordView.cfm">
	</CFIF>

</CFIF>
