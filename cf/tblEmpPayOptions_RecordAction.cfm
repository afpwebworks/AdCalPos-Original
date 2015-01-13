
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblEmpPayOptions.ID AS ID_Field
		FROM tblEmpPayOptions

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblEmpPayOptions.ID < #Form.RecordID#
			ORDER BY tblEmpPayOptions.ID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblEmpPayOptions.ID > #Form.RecordID#
			ORDER BY tblEmpPayOptions.ID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblEmpPayOptions.ID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblEmpPayOptions.ID > #Form.RecordID#
			ORDER BY tblEmpPayOptions.ID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblEmpPayOptions_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblEmpPayOptions_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblEmpPayOptions_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblEmpPayOptions_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblEmpPayOptions
		WHERE tblEmpPayOptions.ID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblEmpPayOptions_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>

		<CFUPDATE datasource="#application.dsn#"  tableName="tblEmpPayOptions" formFields="#Form.FieldList#">
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpPayOptions" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblEmpPayOptions_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<CFINSERT datasource="#application.dsn#"  tableName="tblEmpPayOptions" formFields="#Form.FieldList#">
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpPayOptions" formFields="#Form.FieldList#"> --->

		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblEmpPayOptions.ID AS ID_Field
			FROM tblEmpPayOptions
			ORDER BY tblEmpPayOptions.ID DESC
		</CFQUERY>
		<CFLOCATION url="tblEmpPayOptions_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblEmpPayOptions_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblEmpPayOptions_RecordView.cfm">
	</CFIF>

</CFIF>
