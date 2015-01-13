
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblEmpRoster.RosterID AS ID_Field
		FROM tblEmpRoster

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblEmpRoster.RosterID < #Form.RecordID#
			ORDER BY tblEmpRoster.RosterID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblEmpRoster.RosterID > #Form.RecordID#
			ORDER BY tblEmpRoster.RosterID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblEmpRoster.RosterID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblEmpRoster.RosterID > #Form.RecordID#
			ORDER BY tblEmpRoster.RosterID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblEmpRoster_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblEmpRoster_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblEmpRoster_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblEmpRoster_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblEmpRoster
		WHERE tblEmpRoster.RosterID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblEmpRoster_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>

		<CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpRoster" formFields="#Form.FieldList#">
		<CFLOCATION url="tblEmpRoster_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpRoster" formFields="#Form.FieldList#">
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblEmpRoster.RosterID AS ID_Field
			FROM tblEmpRoster
			ORDER BY tblEmpRoster.RosterID DESC
		</CFQUERY>
		<CFLOCATION url="tblEmpRoster_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblEmpRoster_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblEmpRoster_RecordView.cfm">
	</CFIF>

</CFIF>
