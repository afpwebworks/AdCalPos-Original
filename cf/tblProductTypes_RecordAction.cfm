
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1      datasource="#application.dsn#" > 
		SELECT tblProductTypes.TypeID AS ID_Field
		FROM tblProductTypes

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblProductTypes.TypeID < #Form.RecordID#
			ORDER BY tblProductTypes.TypeID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblProductTypes.TypeID > #Form.RecordID#
			ORDER BY tblProductTypes.TypeID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblProductTypes.TypeID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblProductTypes.TypeID > #Form.RecordID#
			ORDER BY tblProductTypes.TypeID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblProductTypes_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblProductTypes_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblProductTypes_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblProductTypes_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1      datasource="#application.dsn#" > 
		DELETE
		FROM tblProductTypes
		WHERE tblProductTypes.TypeID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblProductTypes_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "UPDATE tblProductTypes SET tblProductTypes.TypeDescription = '#Form.TypeDescription#' ">
		<cfset strQuery = strQuery & "WHERE (((tblProductTypes.TypeID)=#Form.TypeID#))">
		<CFQUERY name="UpdateTheRecord"      datasource="#application.dsn#"       > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<CFLOCATION url="tblProductTypes_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<cfset strQuery = "Insert into tblProductTypes (TypeID, TypeDescription ) ">
		<cfset strQuery = strQuery & "Values (#Form.TypeID#, '#Form.TypeDescription#')">
		<CFQUERY name="InsertTheRecord"      datasource="#application.dsn#"       > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
  	    <CFQUERY name="GetNewRecord" maxRows=1      datasource="#application.dsn#"       > 
			SELECT tblProductTypes.TypeID AS ID_Field
			FROM tblProductTypes
			ORDER BY tblProductTypes.TypeID DESC
		</CFQUERY>
		<CFLOCATION url="tblProductTypes_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>
<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblProductTypes_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblProductTypes_RecordView.cfm">
	</CFIF>

</CFIF>
