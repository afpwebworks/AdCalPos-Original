
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

    <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1>

		SELECT tblStockKit.KitID AS ID_Field
		FROM tblStockKit

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblStockKit.KitID < #Form.RecordID#
			ORDER BY tblStockKit.KitID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblStockKit.KitID > #Form.RecordID#
			ORDER BY tblStockKit.KitID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblStockKit.KitID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblStockKit.KitID > #Form.RecordID#
			ORDER BY tblStockKit.KitID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblStockKit_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblStockKit_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblStockKit_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblStockKit_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

    <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1>
		DELETE
		FROM tblStockKit
		WHERE tblStockKit.KitID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblStockKit_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>

		<CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockKit" formFields="#Form.FieldList#">
		<CFLOCATION url="tblStockKit_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockKit" formFields="#Form.FieldList#">
        <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1>
			SELECT tblStockKit.KitID AS ID_Field
			FROM tblStockKit
			ORDER BY tblStockKit.KitID DESC
		</CFQUERY>
		<CFLOCATION url="tblStockKit_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblStockKit_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblStockKit_RecordView.cfm">
	</CFIF>

</CFIF>
