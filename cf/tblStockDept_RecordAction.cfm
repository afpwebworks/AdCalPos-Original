
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblStockDept.DeptNo AS ID_Field
		FROM tblStockDept

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblStockDept.DeptNo < #Form.RecordID#
			ORDER BY tblStockDept.DeptNo DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblStockDept.DeptNo > #Form.RecordID#
			ORDER BY tblStockDept.DeptNo

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblStockDept.DeptNo

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblStockDept.DeptNo > #Form.RecordID#
			ORDER BY tblStockDept.DeptNo DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblStockDept_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblStockDept_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblStockDept_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblStockDept_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblStockDept
		WHERE tblStockDept.DeptNo = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblStockDept_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>

		<CFUPDATE datasource="#application.dsn#"  tableName="tblStockDept" formFields="#Form.FieldList#">
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockDept" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblStockDept_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<cfset strQuery = "Insert into tblStockDept (DeptNo, Dept, BackGroundColor, ImageFileName) ">
		<cfset strQuery = strQuery & "Values (#Form.DeptNo#, '#Form.Dept#', '#Form.BackGroundColor#', '#Form.ImageFileName#') ">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT datasource="#application.dsn#"  tableName="tblStockDept" formFields="#Form.FieldList#"> --->
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockDept" formFields="#Form.FieldList#"> --->

		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblStockDept.DeptNo AS ID_Field
			FROM tblStockDept
			ORDER BY tblStockDept.DeptNo DESC
		</CFQUERY>
		<CFLOCATION url="tblStockDept_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblStockDept_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblStockDept_RecordView.cfm">
	</CFIF>

</CFIF>
