
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblSecurityTask.TaskID AS ID_Field
		FROM tblSecurityTask

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblSecurityTask.TaskID < #Form.RecordID#
			ORDER BY tblSecurityTask.TaskID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblSecurityTask.TaskID > #Form.RecordID#
			ORDER BY tblSecurityTask.TaskID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblSecurityTask.TaskID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblSecurityTask.TaskID > #Form.RecordID#
			ORDER BY tblSecurityTask.TaskID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblSecurityTask_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblSecurityTask_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblSecurityTask_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblSecurityTask_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>
	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblSecurityTask
		WHERE tblSecurityTask.TaskID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblSecurityTask_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "update tblSecurityTask set TaskFormID = Convert(int,#Form.TaskFormID#) ,  UserTypeID = Convert(int,#Form.UserTypeID#) ">
		<cfset strQuery = strQuery & "WHERE TaskID =Convert(int,#Form.TaskID#) ">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblSecurityTask" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblSecurityTask_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<!--- Check for duplicates --->
		<cfset strQuery = "SELECT * from tblSecurityTask where TaskFormID = Convert(int,#Form.TaskFormID#) and UserTypeID = Convert(int,#Form.UserTypeID#)">
		<CFQUERY name="CheckDuplicates" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckDuplicates.RecordCount# GT 0>
			<Cfoutput><BR>This record creates a duplicate and can not be saved.</cfoutput>
			<cfabort>
		</cfif>
	
		<cfset strQuery = "insert into tblSecurityTask (TaskFormID                     ,  UserTypeID                     ) ">
		<cfset strQuery = strQuery & "values           (Convert(int,#Form.TaskFormID#) ,  Convert(int,#Form.UserTypeID#) )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblSecurityTask" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblSecurityTask.TaskID AS ID_Field
			FROM tblSecurityTask
			ORDER BY tblSecurityTask.TaskID DESC
		</CFQUERY>
		<CFLOCATION url="tblSecurityTask_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblSecurityTask_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblSecurityTask_RecordView.cfm">
	</CFIF>

</CFIF>
