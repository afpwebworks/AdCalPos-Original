
<!---			NAVIGATION BUTTONS (view page)			--->

<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" dataSource="CostiSQLSQLSec" USERNAME="sa" PASSWORD="" maxRows=1>

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
		<CFLOCATION url="TestSQLSQLSec_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="TestSQLSQLSec_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="TestSQLSQLSec_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="TestSQLSQLSec_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" dataSource="CostiSQLSQLSec" USERNAME="sa" PASSWORD="" maxRows=1>
		DELETE
		FROM tblEmployee
		WHERE tblEmployee.EmployeeID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="TestSQLSQLSec_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFUPDATE dataSource="CostiSQLSQLSec" USERNAME="sa" PASSWORD="" tableName="tblEmployee" formFields="#Form.FieldList#">
		<CFLOCATION url="TestSQLSQLSec_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<CFINSERT dataSource="CostiSQLSQLSec" USERNAME="sa" PASSWORD="" tableName="tblEmployee" formFields="#Form.FieldList#">
		<CFQUERY name="GetNewRecord" USERNAME="sa" PASSWORD="" dataSource="CostiSQLSQLSec" maxRows=1>
			SELECT tblEmployee.EmployeeID AS ID_Field
			FROM tblEmployee
			ORDER BY tblEmployee.EmployeeID DESC
		</CFQUERY>
		<CFLOCATION url="TestSQLSQLSec_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="TestSQLSQLSec_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="TestSQLSQLSec_RecordView.cfm">
	</CFIF>

</CFIF>
