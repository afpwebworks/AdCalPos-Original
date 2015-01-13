
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

    <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1>

		SELECT tblEmpEntitlement.EntitleID AS ID_Field
		FROM tblEmpEntitlement

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblEmpEntitlement.EntitleID < #Form.RecordID#
			ORDER BY tblEmpEntitlement.EntitleID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblEmpEntitlement.EntitleID > #Form.RecordID#
			ORDER BY tblEmpEntitlement.EntitleID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblEmpEntitlement.EntitleID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblEmpEntitlement.EntitleID > #Form.RecordID#
			ORDER BY tblEmpEntitlement.EntitleID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblEmpEntitlement_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblEmpEntitlement_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblEmpEntitlement_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblEmpEntitlement_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

    <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1>
		DELETE
		FROM tblEmpEntitlement
		WHERE tblEmpEntitlement.EntitleID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblEmpEntitlement_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>

		<CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpEntitlement" formFields="#Form.FieldList#">
		<CFLOCATION url="tblEmpEntitlement_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpEntitlement" formFields="#Form.FieldList#">
        <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1>
			SELECT tblEmpEntitlement.EntitleID AS ID_Field
			FROM tblEmpEntitlement
			ORDER BY tblEmpEntitlement.EntitleID DESC
		</CFQUERY>
		<CFLOCATION url="tblEmpEntitlement_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblEmpEntitlement_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblEmpEntitlement_RecordView.cfm">
	</CFIF>

</CFIF>
