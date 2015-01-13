
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblStockGroup.GroupNo AS ID_Field
		FROM tblStockGroup

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblStockGroup.GroupNo < #Form.RecordID#
			ORDER BY tblStockGroup.GroupNo DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblStockGroup.GroupNo > #Form.RecordID#
			ORDER BY tblStockGroup.GroupNo

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblStockGroup.GroupNo

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblStockGroup.GroupNo > #Form.RecordID#
			ORDER BY tblStockGroup.GroupNo DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblStockGroup_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblStockGroup_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblStockGroup_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblStockGroup_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblStockGroup
		WHERE tblStockGroup.GroupNo = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblStockGroup_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>

		<cfset strQuery = "update tblStockGroup set [Group] = '#Form.Group#', DeptNo = convert(int,'#Form.DeptNo#') ">
		<cfset strQuery = strQuery & "where GroupNo = convert(int,#Form.GroupNo#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE datasource="#application.dsn#"  tableName="tblStockGroup" formFields="#Form.FieldList#"> --->
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockGroup" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblStockGroup_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<cfset strQuery = "insert into tblStockGroup (GroupNo, [Group], DeptNo) ">
		<cfset strQuery = strQuery & "Values (convert(int,#Form.GroupNo#), '#Form.Group#', convert(int,'#Form.DeptNo#') )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockGroup" formFields="#Form.FieldList#"> --->

		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblStockGroup.GroupNo AS ID_Field
			FROM tblStockGroup
			ORDER BY tblStockGroup.GroupNo DESC
		</CFQUERY>
		<CFLOCATION url="tblStockGroup_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblStockGroup_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblStockGroup_RecordView.cfm">
	</CFIF>

</CFIF>
