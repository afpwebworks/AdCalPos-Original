
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblSecurityUserTypes.UserTypeID AS ID_Field
		FROM tblSecurityUserTypes

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblSecurityUserTypes.UserTypeID < #Form.RecordID#
			ORDER BY tblSecurityUserTypes.UserTypeID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblSecurityUserTypes.UserTypeID > #Form.RecordID#
			ORDER BY tblSecurityUserTypes.UserTypeID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblSecurityUserTypes.UserTypeID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblSecurityUserTypes.UserTypeID > #Form.RecordID#
			ORDER BY tblSecurityUserTypes.UserTypeID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblSecurityUserTypes_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblSecurityUserTypes_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblSecurityUserTypes_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblSecurityUserTypes_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblSecurityUserTypes
		WHERE tblSecurityUserTypes.UserTypeID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblSecurityUserTypes_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "update tblSecurityUserTypes set UserType = '#Form.UserType#' ">
		<cfset strQuery = strQuery & "WHERE UserTypeID = Convert(int,#Form.UserTypeID#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblSecurityUserTypes" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblSecurityUserTypes_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<cfset strQuery = "SELECT * from tblSecurityUserTypes ">
		<cfset strQuery = strQuery & "WHERE UserTypeID = Convert(int,#Form.UserTypeID#)">
		<CFQUERY name="CheckForDuplicates" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckForDuplicates.RecordCount# GT 0>
			<cfoutput><BR>This record will create a duplicate and it will not be saved</cfoutput>
			<cfabort>
		</cfif>
		
		<cfset strQuery = "insert into tblSecurityUserTypes ( UserTypeID                     , UserType          )  ">
		<cfset strQuery = strQuery & "values                ( Convert(int,#Form.UserTypeID#) , '#Form.UserType#' )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblSecurityUserTypes" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblSecurityUserTypes.UserTypeID AS ID_Field
			FROM tblSecurityUserTypes
			ORDER BY tblSecurityUserTypes.UserTypeID DESC
		</CFQUERY>
		<CFLOCATION url="tblSecurityUserTypes_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblSecurityUserTypes_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblSecurityUserTypes_RecordView.cfm">
	</CFIF>

</CFIF>
