
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblEmpStatus.EmpStatusID AS ID_Field
		FROM tblEmpStatus

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblEmpStatus.EmpStatusID < #Form.RecordID#
			ORDER BY tblEmpStatus.EmpStatusID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblEmpStatus.EmpStatusID > #Form.RecordID#
			ORDER BY tblEmpStatus.EmpStatusID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblEmpStatus.EmpStatusID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblEmpStatus.EmpStatusID > #Form.RecordID#
			ORDER BY tblEmpStatus.EmpStatusID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblEmpStatus_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblEmpStatus_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblEmpStatus_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblEmpStatus_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblEmpStatus
		WHERE tblEmpStatus.EmpStatusID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblEmpStatus_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "update tblEmpStatus set Status = '#Form.Status#' , TaxScaleID = Convert(int,#Form.TaxScaleID#) ">
		<cfset strQuery = strQuery & "Where EmpStatusID = convert(int,#Form.EmpStatusID#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE datasource="#application.dsn#"  tableName="tblEmpStatus" formFields="#Form.FieldList#"> --->
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpStatus" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblEmpStatus_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<!--- Check for duplicates --->
		<cfset strQuery = "select * from tblEmpStatus ">
		<cfset strQuery = strQuery & "where EmpStatusID = convert(int,#Form.EmpStatusID#)">
		<CFQUERY name="CheckDuplicates" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckDuplicates.RecordCount# GT 0>
			<Cfoutput><BR>This record will create a duplicate and can not be saved.</cfoutput>
			<cfabort>
		</cfif>
		
		<cfset strQuery = "insert into tblEmpStatus (EmpStatusID                     , Status          ,TaxScaleID                     ) ">
		<cfset strQuery = strQuery & "values        (convert(int,#Form.EmpStatusID#) , '#Form.Status#' ,Convert(int,#Form.TaxScaleID#) )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT datasource="#application.dsn#"  tableName="tblEmpStatus" formFields="#Form.FieldList#"> --->
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpStatus" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblEmpStatus.EmpStatusID AS ID_Field
			FROM tblEmpStatus
			ORDER BY tblEmpStatus.EmpStatusID DESC
		</CFQUERY>
		<CFLOCATION url="tblEmpStatus_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">
	</CFIF>

<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblEmpStatus_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblEmpStatus_RecordView.cfm">
	</CFIF>

</CFIF>
