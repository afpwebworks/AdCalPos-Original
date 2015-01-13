
<!---			NAVIGATION BUTTONS (view page)			--->

<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

    <CFQUERY  DBTYPE="OLEDB" DBNAME ="CostiSQL" DBSERVER="w2000s" PROVIDER="SQLOLEDB" dataSource="CostiSQL" PROVIDERDSN="CostiSQL" USERNAME="sa" PASSWORD="" name="GetRecord" maxRows=1>
		SELECT tblEmployee.EmployeeID AS ID_Field
		FROM tblEmployee

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblEmployee.EmployeeID < #Form.RecordID#
			ORDER BY tblEmployee.EmployeeID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblEmployee.EmployeeID > #Form.RecordID#
			ORDER BY tblEmployee.EmployeeID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblEmployee.EmployeeID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblEmployee.EmployeeID > #Form.RecordID#
			ORDER BY tblEmployee.EmployeeID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="TestSQL_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="TestSQL_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="TestSQL_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="TestSQL_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

    <CFQUERY  DBTYPE="OLEDB" DBNAME ="CostiSQL" DBSERVER="w2000s" PROVIDER="SQLOLEDB" dataSource="CostiSQL" PROVIDERDSN="CostiSQL" USERNAME="sa" PASSWORD="" name="DeleteRecord" maxRows=1>
		DELETE
		FROM tblEmployee
		WHERE tblEmployee.EmployeeID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="TestSQL_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>

	<CFIF ParameterExists(Form.RecordID)>
    
		<CFUPDATE DBTYPE="OLEDB" DBNAME ="CostiSQL" DBSERVER="w2000s" PROVIDER="SQLOLEDB" dataSource="CostiSQL" PROVIDERDSN="CostiSQL" USERNAME="sa" PASSWORD="" tableName="tblEmployee" formFields="#Form.FieldList#">
		<CFLOCATION url="TestSQL_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<CFINSERT DBTYPE="OLEDB" DBNAME ="CostiSQL" DBSERVER="w2000s" PROVIDER="SQLOLEDB" dataSource="CostiSQL" PROVIDERDSN="CostiSQL" USERNAME="sa" PASSWORD="" tableName="tblEmployee" formFields="#Form.FieldList#">
		<CFQUERY name="GetNewRecord" dataSource="CostiDSN" maxRows=1>
			SELECT tblEmployee.EmployeeID AS ID_Field
			FROM tblEmployee
			ORDER BY tblEmployee.EmployeeID DESC
		</CFQUERY>
		<CFLOCATION url="TestSQL_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="TestSQL_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="TestSQL_RecordView.cfm">
	</CFIF>

</CFIF>
