
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblSupExpenseCat.ExpenseCatID AS ID_Field
		FROM tblSupExpenseCat

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblSupExpenseCat.ExpenseCatID < #Form.RecordID#
			ORDER BY tblSupExpenseCat.ExpenseCatID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblSupExpenseCat.ExpenseCatID > #Form.RecordID#
			ORDER BY tblSupExpenseCat.ExpenseCatID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblSupExpenseCat.ExpenseCatID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblSupExpenseCat.ExpenseCatID > #Form.RecordID#
			ORDER BY tblSupExpenseCat.ExpenseCatID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblSupExpenseCat_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblSupExpenseCat_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblSupExpenseCat_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblSupExpenseCat_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblSupExpenseCat
		WHERE tblSupExpenseCat.ExpenseCatID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblSupExpenseCat_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "update tblSupExpenseCat set ExpenseCat = '#Form.ExpenseCat#' ">
		<cfset strQuery = strQuery & "WHERE ExpenseCatID = Convert(int,#Form.ExpenseCatID#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblSupExpenseCat" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblSupExpenseCat_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<cfset strQuery = "insert into tblSupExpenseCat ( ExpenseCat ) ">
		<cfset strQuery = strQuery & "values            ('#Form.ExpenseCat#' )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblSupExpenseCat" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblSupExpenseCat.ExpenseCatID AS ID_Field
			FROM tblSupExpenseCat
			ORDER BY tblSupExpenseCat.ExpenseCatID DESC
		</CFQUERY>
		<CFLOCATION url="tblSupExpenseCat_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblSupExpenseCat_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblSupExpenseCat_RecordView.cfm">
	</CFIF>

</CFIF>
