
<!---			NAVIGATION BUTTONS (view page)			--->

<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" dataSource="CostiDSN" maxRows=1>

		SELECT tblStockMaster.PartNo AS ID_Field
		FROM tblStockMaster

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblStockMaster.PartNo < '#Form.RecordID#'
			ORDER BY tblStockMaster.PartNo DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblStockMaster.PartNo > '#Form.RecordID#'
			ORDER BY tblStockMaster.PartNo

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblStockMaster.PartNo

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblStockMaster.PartNo > '#Form.RecordID#'
			ORDER BY tblStockMaster.PartNo DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="TestSQL2_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="TestSQL2_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="TestSQL2_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="TestSQL2_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" dataSource="CostiDSN" maxRows=1>
		DELETE
		FROM tblStockMaster
		WHERE tblStockMaster.PartNo = '#Form.RecordID#'
	</CFQUERY>
	<CFLOCATION url="TestSQL2_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFUPDATE dataSource="CostiDSN" tableName="tblStockMaster" formFields="#Form.FieldList#">
		<CFLOCATION url="TestSQL2_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<CFINSERT dataSource="CostiDSN" tableName="tblStockMaster" formFields="#Form.FieldList#">
		<CFQUERY name="GetNewRecord" dataSource="CostiDSN" maxRows=1>
			SELECT tblStockMaster.PartNo AS ID_Field
			FROM tblStockMaster
			ORDER BY tblStockMaster.PartNo DESC
		</CFQUERY>
		<CFLOCATION url="TestSQL2_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="TestSQL2_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="TestSQL2_RecordView.cfm">
	</CFIF>

</CFIF>
