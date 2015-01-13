
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblStocktakeErrors.ErrorID AS ID_Field
		FROM tblStocktakeErrors

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblStocktakeErrors.ErrorID < '#Form.RecordID#'
			ORDER BY tblStocktakeErrors.ErrorID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblStocktakeErrors.ErrorID > '#Form.RecordID#'
			ORDER BY tblStocktakeErrors.ErrorID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblStocktakeErrors.ErrorID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblStocktakeErrors.ErrorID > '#Form.RecordID#'
			ORDER BY tblStocktakeErrors.ErrorID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblStocktakeErrors_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblStocktakeErrors_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblStocktakeErrors_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblStocktakeErrors_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblStocktakeErrors
		WHERE tblStocktakeErrors.ErrorID = '#Form.RecordID#'
	</CFQUERY>
	<CFLOCATION url="tblStocktakeErrors_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>

		<cfset strQuery = "UPDATE tblStocktakeErrors SET tblStocktakeErrors.ErrorDesc = '#Form.ErrorDesc#' ">
		<cfset strQuery = strQuery & "WHERE (((tblStocktakeErrors.ErrorID)='#Form.ErrorID#'))">
		<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
		<!--- <cfabort> --->
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStocktakeErrors" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblStocktakeErrors_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<cfset strQuery = "Insert into tblStocktakeErrors ( ErrorID , ErrorDesc ) ">
		<cfset strQuery = strQuery & "Values ( '#Form.ErrorID#', '#Form.ErrorDesc#')">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStocktakeErrors" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblStocktakeErrors.ErrorID AS ID_Field
			FROM tblStocktakeErrors
			ORDER BY tblStocktakeErrors.ErrorID DESC
		</CFQUERY>
		<CFLOCATION url="tblStocktakeErrors_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblStocktakeErrors_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblStocktakeErrors_RecordView.cfm">
	</CFIF>

</CFIF>
