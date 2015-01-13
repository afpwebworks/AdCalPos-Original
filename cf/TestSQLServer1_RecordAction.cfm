
<!---			NAVIGATION BUTTONS (view page)			--->

<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" dataSource="vs139312_1_x" maxRows=1>

		SELECT qryEmployee.TheStoreID AS ID_Field
		FROM qryEmployee

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE qryEmployee.TheStoreID < #Form.RecordID#
			ORDER BY qryEmployee.TheStoreID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE qryEmployee.TheStoreID > #Form.RecordID#
			ORDER BY qryEmployee.TheStoreID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY qryEmployee.TheStoreID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE qryEmployee.TheStoreID > #Form.RecordID#
			ORDER BY qryEmployee.TheStoreID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="TestSQLServer1_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="TestSQLServer1_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="TestSQLServer1_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="TestSQLServer1_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" dataSource="vs139312_1_x" maxRows=1>
		DELETE
		FROM qryEmployee
		WHERE qryEmployee.TheStoreID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="TestSQLServer1_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFUPDATE dataSource="vs139312_1_x" tableName="qryEmployee" formFields="#Form.FieldList#">
		<CFLOCATION url="TestSQLServer1_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<CFINSERT dataSource="vs139312_1_x" tableName="qryEmployee" formFields="#Form.FieldList#">
		<CFQUERY name="GetNewRecord" dataSource="vs139312_1_x" maxRows=1>
			SELECT qryEmployee.TheStoreID AS ID_Field
			FROM qryEmployee
			ORDER BY qryEmployee.TheStoreID DESC
		</CFQUERY>
		<CFLOCATION url="TestSQLServer1_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="TestSQLServer1_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="TestSQLServer1_RecordView.cfm">
	</CFIF>

</CFIF>
