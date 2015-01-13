
<!---			NAVIGATION BUTTONS (view page)			--->

<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" dataSource="vs139312_1_x" maxRows=1 USERNAME="vs139312_1_dbo" PASSWORD="gmsne4848n">

		SELECT tblStores.StoreID AS ID_Field
		FROM tblStores

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblStores.StoreID < #Form.RecordID#
			ORDER BY tblStores.StoreID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblStores.StoreID > #Form.RecordID#
			ORDER BY tblStores.StoreID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblStores.StoreID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblStores.StoreID > #Form.RecordID#
			ORDER BY tblStores.StoreID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="TestSQLServer5_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="TestSQLServer5_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="TestSQLServer5_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="TestSQLServer5_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" dataSource="vs139312_1_x" maxRows=1 USERNAME="vs139312_1_dbo" PASSWORD="gmsne4848n">
		DELETE
		FROM tblStores
		WHERE tblStores.StoreID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="TestSQLServer5_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFUPDATE dataSource="vs139312_1_x" tableName="tblStores" formFields="#Form.FieldList#" USERNAME="vs139312_1_dbo" PASSWORD="gmsne4848n">
		<CFLOCATION url="TestSQLServer5_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<CFINSERT dataSource="vs139312_1_x" tableName="tblStores" formFields="#Form.FieldList#" USERNAME="vs139312_1_dbo" PASSWORD="gmsne4848n">
		<CFQUERY name="GetNewRecord" dataSource="vs139312_1_x" maxRows=1>
			SELECT tblStores.StoreID AS ID_Field
			FROM tblStores
			ORDER BY tblStores.StoreID DESC
		</CFQUERY>
		<CFLOCATION url="TestSQLServer5_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="TestSQLServer5_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="TestSQLServer5_RecordView.cfm">
	</CFIF>

</CFIF>
