
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

<!---
StoreGroupID
StoreGroup
--->

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblStoreGroup.StoreGroupID AS ID_Field
		FROM tblStoreGroup

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblStoreGroup.StoreGroupID < #Form.RecordID#
			ORDER BY tblStoreGroup.StoreGroupID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblStoreGroup.StoreGroupID > #Form.RecordID#
			ORDER BY tblStoreGroup.StoreGroupID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblStoreGroup.StoreGroupID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblStoreGroup.StoreGroupID > #Form.RecordID#
			ORDER BY tblStoreGroup.StoreGroupID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblStoreGroup_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblStoreGroup_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblStoreGroup_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblStoreGroup_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblStoreGroup
		WHERE tblStoreGroup.StoreGroupID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblStoreGroup_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "UPDATE tblStoreGroup SET tblStoreGroup.StoreGroup = '#Form.StoreGroup#' ">
		<cfset strQuery = strQuery & "WHERE (((tblStoreGroup.StoreGroupID)=#Form.StoreGroupID#))">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE datasource="#application.dsn#"  tableName="tblStoreGroup" formFields="#Form.FieldList#"> --->
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStoreGroup" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblStoreGroup_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<cfset strQuery = "Insert into tblStoreGroup (StoreGroupID, StoreGroup ) ">
		<cfset strQuery = strQuery & "Values (#Form.StoreGroupID#, '#Form.StoreGroup#')">
		<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT datasource="#application.dsn#"  tableName="tblStoreGroup" formFields="#Form.FieldList#"> --->
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStoreGroup" formFields="#Form.FieldList#"> --->
  	    <CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblStoreGroup.StoreGroupID AS ID_Field
			FROM tblStoreGroup
			ORDER BY tblStoreGroup.StoreGroupID DESC
		</CFQUERY>
		<CFLOCATION url="tblStoreGroup_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblStoreGroup_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblStoreGroup_RecordView.cfm">
	</CFIF>

</CFIF>
