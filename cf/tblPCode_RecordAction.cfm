
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT PCodeID AS ID_Field
		FROM tblPCodes

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE PCodeID < #Form.RecordID#
			ORDER BY PCodeID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE PCodeID > #Form.RecordID#
			ORDER BY PCodeID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY PCodeID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE PCodeID > #Form.RecordID#
			ORDER BY PCodeID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblPCode_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblPCode_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblPCode_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblPCode_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblPCodes
		WHERE PCodeID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblPCode_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>

		<CFUPDATE datasource="#application.dsn#"  tableName="tblPCodes" formFields="#Form.FieldList#">
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockUnitType" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblPCode_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<cfset strQuery = "Insert into tblPCodes ( PCodeDescription ) ">
		<cfset strQuery = strQuery & "Values ('#Form.PCodeDescription#' )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	
		<!--- <CFINSERT datasource="#application.dsn#"  tableName="tblStockUnitType" formFields="#Form.FieldList#"> --->
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockUnitType" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT PCodeID AS ID_Field
			FROM tblPCodes
			ORDER BY PCodeID DESC
		</CFQUERY>
		<CFLOCATION url="tblPCode_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblPCode_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblPCode_RecordView.cfm">
	</CFIF>

</CFIF>
