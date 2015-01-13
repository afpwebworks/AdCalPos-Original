
<!---			NAVIGATION BUTTONS (view page)			--->
<cfparam name="LocalAppCostiDB" default="#Applic_AppRoot#">
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<!--- <CFQUERY name="GetRecord" dataSource="CostiDSN" maxRows=1> --->


<CFQUERY name="GetRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="Microsoft.Jet.OLEDB.4.0" dataSource="#LocalAppCostiDB#costi.mdb" PROVIDERDSN="#LocalAppCostiDB#costi.mdb" USERNAME="admin">
		SELECT tblPictureFile.PictureFileID AS ID_Field
		FROM tblPictureFile

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblPictureFile.PictureFileID < #Form.RecordID#
			ORDER BY tblPictureFile.PictureFileID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblPictureFile.PictureFileID > #Form.RecordID#
			ORDER BY tblPictureFile.PictureFileID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblPictureFile.PictureFileID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblPictureFile.PictureFileID > #Form.RecordID#
			ORDER BY tblPictureFile.PictureFileID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="TestSQLAccess_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="TestSQLAccess_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="TestSQLAccess_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="TestSQLAccess_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" dataSource="#LocalAppCostiDB#costi.mdb" maxRows=1>
		DELETE
		FROM tblPictureFile
		WHERE tblPictureFile.PictureFileID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="TestSQLAccess_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>

	<CFIF ParameterExists(Form.RecordID)>
		<!--- <CFUPDATE dataSource="#LocalAppCostiDB#costi.mdb" tableName="tblPictureFile" formFields="#Form.FieldList#"> --->
<CFUPDATE  DBTYPE="OLEDB" PROVIDER="Microsoft.Jet.OLEDB.4.0" dataSource="#LocalAppCostiDB#costi.mdb" PROVIDERDSN="#LocalAppCostiDB#costi.mdb" USERNAME="admin" tableName="tblPictureFile" formFields="#Form.FieldList#">
		<CFLOCATION url="TestSQLAccess_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<CFINSERT dataSource="#LocalAppCostiDB#costi.mdb" tableName="tblPictureFile" formFields="#Form.FieldList#">
		<CFQUERY name="GetNewRecord" dataSource="#LocalAppCostiDB#costi.mdb" maxRows=1>
			SELECT tblPictureFile.PictureFileID AS ID_Field
			FROM tblPictureFile
			ORDER BY tblPictureFile.PictureFileID DESC
		</CFQUERY>
		<CFLOCATION url="TestSQLAccess_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="TestSQLAccess_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="TestSQLAccess_RecordView.cfm">
	</CFIF>

</CFIF>
