
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblSecurityTaskForms.TaskFormID AS ID_Field
		FROM tblSecurityTaskForms

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblSecurityTaskForms.TaskFormID < #Form.RecordID#
			ORDER BY tblSecurityTaskForms.TaskFormID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblSecurityTaskForms.TaskFormID > #Form.RecordID#
			ORDER BY tblSecurityTaskForms.TaskFormID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblSecurityTaskForms.TaskFormID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblSecurityTaskForms.TaskFormID > #Form.RecordID#
			ORDER BY tblSecurityTaskForms.TaskFormID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblSecurityTaskForms_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblSecurityTaskForms_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblSecurityTaskForms_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblSecurityTaskForms_RecordEdit.cfm">
<!---			DELETE BUTTON (view page)			--->
<CFELSEIF ParameterExists(Form.btnView_Delete)>
	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblSecurityTaskForms
		WHERE tblSecurityTaskForms.TaskFormID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblSecurityTaskForms_RecordView.cfm">
<!---			OK BUTTON (edit page)				--->
<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "update tblSecurityTaskForms set TaskName = '#Form.TaskName#', FormName = '#Form.FormName#', MainHeading  = '#Form.MainHeading#', HeadingOrder = Convert(int,#Form.HeadingOrder#), FormOrder = Convert(int,#Form.FormOrder#) ">
		<cfset strQuery = strQuery & "WHERE TaskFormID = Convert(int,#Form.TaskFormID#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblSecurityTaskForms" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblSecurityTaskForms_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<cfset strQuery = "insert into tblSecurityTaskForms (TaskName         , FormName         , MainHeading         , HeadingOrder                    , FormOrder                     ) ">
		<cfset strQuery = strQuery & "values                ('#Form.TaskName#', '#Form.FormName#', '#Form.MainHeading#', Convert(int,#Form.HeadingOrder#), Convert(int,#Form.FormOrder#) )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblSecurityTaskForms" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblSecurityTaskForms.TaskFormID AS ID_Field
			FROM tblSecurityTaskForms
			ORDER BY tblSecurityTaskForms.TaskFormID DESC
		</CFQUERY>
		<CFLOCATION url="tblSecurityTaskForms_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">
	</CFIF>
<!---			CANCEL BUTTON (edit page)			--->
<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>
	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblSecurityTaskForms_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblSecurityTaskForms_RecordView.cfm">
	</CFIF>
</CFIF>
